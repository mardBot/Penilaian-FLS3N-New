import { createClient } from '@supabase/supabase-js';

const supabaseUrl = (import.meta as any).env?.VITE_SUPABASE_URL || 'https://gkypbfakuacrgehuatnw.supabase.co';
const supabaseAnonKey = (import.meta as any).env?.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdreXBiZmFrdWFjcmdlaHVhdG53Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIzNjI4NTQsImV4cCI6MjA4NzkzODg1NH0.TIpsuXBcXLZCFc09aDzuld3h5-YSSTc4NubOwGXW14Q';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
