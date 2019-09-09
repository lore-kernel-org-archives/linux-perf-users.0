From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] Add input file_name support for perf sched
 {map|latency|replay|timehist}
Date: Mon, 9 Sep 2019 09:50:18 +0100
Message-ID: <37eecde1-52de-0d7a-608f-8b8125ee1155@gmail.com>
References: <20190903085535.23913-1-ufo19890607@gmail.com>
 <CAHCio2iLvOSDEJ8JSnBx6w_65yekWNWu0B8wTAWbLDjy65J9JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCio2iLvOSDEJ8JSnBx6w_65yekWNWu0B8wTAWbLDjy65J9JQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, windyu@tencent.com, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On 9/9/19 4:49 AM, 禹舟键 wrote:
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 025151dcb651..8e51fbb88549 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3374,6 +3374,7 @@ int cmd_sched(int argc, const char **argv)
>>         const struct option latency_options[] = {
>>         OPT_STRING('s', "sort", &sched.sort_order, "key[,key2...]",
>>                    "sort by key(s): runtime, switch, avg, max"),
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_INTEGER('C', "CPU", &sched.profile_cpu,
>>                     "CPU to profile on"),
>>         OPT_BOOLEAN('p', "pids", &sched.skip_merge,
>> @@ -3381,11 +3382,13 @@ int cmd_sched(int argc, const char **argv)
>>         OPT_PARENT(sched_options)
>>         };
>>         const struct option replay_options[] = {
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
>>                      "repeat the workload replay N times (-1: infinite)"),
>>         OPT_PARENT(sched_options)
>>         };
>>         const struct option map_options[] = {
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_BOOLEAN(0, "compact", &sched.map.comp,
>>                     "map output in compact mode"),
>>         OPT_STRING(0, "color-pids", &sched.map.color_pids_str, "pids",
>> @@ -3397,6 +3400,7 @@ int cmd_sched(int argc, const char **argv)
>>         OPT_PARENT(sched_options)
>>         };
>>         const struct option timehist_options[] = {
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>                    "file", "vmlinux pathname"),
>>         OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>> --
>> 2.23.0.37.g745f681
>>

This is not needed; -i already works with timehist (and others as I
recall). I believe OPT_PARENT passes the option to the subcommand.
