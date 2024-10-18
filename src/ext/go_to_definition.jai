Definition_Finder :: struct
{
    search_text: string;
    search_in_progress: bool;

    was_using_case_sensitive: bool;
    was_using_whole_word: bool;
}
definition_finder: Definition_Finder;

update_definition_finder :: ()
{
    if !definition_finder.search_in_progress then return;

    finder_process_definition_search();
}

go_to_definition :: (using editor: *Editor)
{
    using definition_finder;

    buffer := *open_buffers[buffer_id];
    select_word(buffer, *cursors[main_cursor]);

    search_text = get_selected_string(cursors[main_cursor], buffer);

    if !search_text {
        add_user_error("Invalid text for which to attempt to find a definition.", dismiss_in_seconds = 5);
        return;
    }

    finder_search_for_definition();
}