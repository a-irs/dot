-- always use "compact lists", for example:
--
-- - item1
-- - item2
-- <blank line>
-- - item3
-- - item4
--
-- normally generates <li><p>item1</p></li> ...
-- now, it generates compact lists: <li>item1</li> ...

-- Source: https://stackoverflow.com/a/57943159/7361270
-- Modified by makeworld

-- Iterate over all blocks in an item, converting 'top-level'
-- Para into Plain blocks.
function compactifyItem (blocks)
  -- step through the list of blocks step-by-step, keeping track of the
  -- element's index in the list in variable `i`, and assign the current
  -- block to `blk`.
  for i, blk in ipairs(blocks) do
    if blk.t == 'Para' then
      -- update in item's block list.
      blocks[i] = pandoc.Plain(blk.content)
    elseif blk.t == 'BlockQuote' then
      -- It's a Google Doc thing, where each bullet is in a blockquote
      -- https://github.com/jgm/pandoc/issues/6824
      blocks[i] = pandoc.Plain(blk.content[1].content)
    end
  end
  return blocks
end

function compactifyList (l)
  -- l.content is an instance of pandoc.List, so the following is equivalent
  -- to pandoc.List.map(l.content, compactifyItem)
  l.content = l.content:map(compactifyItem)
  return l
end

return {{
    BulletList = compactifyList,
    OrderedList = compactifyList
}}
