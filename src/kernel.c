void main() {
    char* video_memory = (char*) 0xb800;
    *video_memory = 'X';
}
