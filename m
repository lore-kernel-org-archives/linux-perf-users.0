From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH] perf script: add flamegraph.py script
Date: Thu, 26 Mar 2020 14:04:30 -0500
Message-ID: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com>
 <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
 <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>, linux-perf-users@vger.kernel.org
Cc: Martin Spier <mspier@netflix.com>, Brendan Gregg <bgregg@netflix.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 3/24/20 2:05 PM, Andreas Gerstmayr wrote:
> On 24.03.20 17:16, Kim Phillips wrote:
>> On Ubuntu 19.10, where python 2.7 is still the default, I get:
>>
>> $ perf script report flamegraph
>>    File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 46
>>      print(f"Flame Graph template {self.args.template} does not " +
>>                                                                 ^
>> SyntaxError: invalid syntax
>> Error running python script /usr/libexec/perf-core/scripts/python/flamegraph.py
>>
>> Installing libpython3-dev doesn't help.
> 
> Hmm, I was hoping that I can drop support for Python 2 in 2020 ;) (it's officially EOL since Jan 1, 2020)
> 
> The Ubuntu 18.04 release notes mention that "Python 2 is no longer installed by default. Python 3 has been updated to 3.6. This is the last LTS release to include Python 2 in main." (https://wiki.ubuntu.com/BionicBeaver/ReleaseNotes) - so imho it should be fine to drop Python 2 support.
> 
> I tested it with a Ubuntu VM, and by default the Python bindings aren't enabled in perf (see https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1707875).
> 
> But you can compile perf and select Python 3:
> 
> $ make -j2 PYTHON=python3
> 
> in the perf source directory (libpython3-dev must be installed).
> 
> 
> Does this work for you?

Not on Ubuntu 18.04.4 LTS, but it does on 19.10.

On 19.10 however, when specifying dwarf on the record, e.g.:

sudo perf record -a -g -C2,4 --call-graph=dwarf -- sleep 10

I now get a SIGSEGV when executing perf script report flamegraph.

Here's a trace:

#0  0x000055555590a9b2 in regs_map (regs=0x7fffffffbfc8, mask=16715775, 
    bf=0x7fffffffba60 "", size=512) at util/scripting-engines/trace-event-python.c:696
#1  0x000055555590ab03 in set_regs_in_dict (dict=0x7ffff61dd500, sample=0x7fffffffbf20, 
    evsel=0x555555d7a700) at util/scripting-engines/trace-event-python.c:718
#2  0x000055555590af1f in get_perf_sample_dict (sample=0x7fffffffbf20, 
    evsel=0x555555d7a700, al=0x7fffffffbdd0, callchain=0x7ffff625b780)
    at util/scripting-engines/trace-event-python.c:787
#3  0x000055555590ce3e in python_process_general_event (sample=0x7fffffffbf20, 
    evsel=0x555555d7a700, al=0x7fffffffbdd0)
    at util/scripting-engines/trace-event-python.c:1301
#4  0x000055555590cf94 in python_process_event (event=0x7ffff60b0a48, 
    sample=0x7fffffffbf20, evsel=0x555555d7a700, al=0x7fffffffbdd0)
    at util/scripting-engines/trace-event-python.c:1328
#5  0x000055555577375c in process_sample_event (tool=0x7fffffffcf30, 
    event=0x7ffff60b0a48, sample=0x7fffffffbf20, evsel=0x555555d7a700, 
    machine=0x555555d73168) at builtin-script.c:2072
#6  0x000055555585f3d9 in perf_evlist__deliver_sample (evlist=0x555555d79c60, 
    tool=0x7fffffffcf30, event=0x7ffff60b0a48, sample=0x7fffffffbf20, 
    evsel=0x555555d7a700, machine=0x555555d73168) at util/session.c:1389
#7  0x000055555585f588 in machines__deliver_event (machines=0x555555d73168, 
    evlist=0x555555d79c60, event=0x7ffff60b0a48, sample=0x7fffffffbf20, 
    tool=0x7fffffffcf30, file_offset=3037768) at util/session.c:1426
#8  0x000055555585fa32 in perf_session__deliver_event (session=0x555555d72fe0, 
    event=0x7ffff60b0a48, tool=0x7fffffffcf30, file_offset=3037768)
    at util/session.c:1499
#9  0x000055555585bf5e in ordered_events__deliver_event (oe=0x555555d79b20, 
    event=0x555556446588) at util/session.c:183
#10 0x0000555555864010 in do_flush (oe=0x555555d79b20, show_progress=false)
    at util/ordered-events.c:244
#11 0x000055555586435f in __ordered_events__flush (oe=0x555555d79b20, 
    how=OE_FLUSH__ROUND, timestamp=0) at util/ordered-events.c:323
#12 0x0000555555864447 in ordered_events__flush (oe=0x555555d79b20, how=OE_FLUSH__ROUND)
    at util/ordered-events.c:341
#13 0x000055555585e2b1 in process_finished_round (tool=0x7fffffffcf30, 
    event=0x7ffff60ec040, oe=0x555555d79b20) at util/session.c:997
#14 0x000055555585fcea in perf_session__process_user_event (session=0x555555d72fe0, 
    event=0x7ffff60ec040, file_offset=3280960) at util/session.c:1546
#15 0x000055555586055d in perf_session__process_event (session=0x555555d72fe0, 
    event=0x7ffff60ec040, file_offset=3280960) at util/session.c:1706
#16 0x0000555555861973 in process_simple (session=0x555555d72fe0, event=0x7ffff60ec040, 
    file_offset=3280960) at util/session.c:2202
#17 0x0000555555861792 in reader__process_events (rd=0x7fffffffcd70, 
    session=0x555555d72fe0, prog=0x7fffffffcd90) at util/session.c:2168
#18 0x0000555555861a68 in __perf_session__process_events (session=0x555555d72fe0)
    at util/session.c:2225
#19 0x0000555555861b9d in perf_session__process_events (session=0x555555d72fe0)
    at util/session.c:2258
#20 0x0000555555774d02 in __cmd_script (script=0x7fffffffcf30) at builtin-script.c:2557
#21 0x0000555555779988 in cmd_script (argc=0, argv=0x7fffffffebd0)
    at builtin-script.c:3926
#22 0x00005555557f2a93 in run_builtin (p=0x555555bb44d8 <commands+408>, argc=4, 
    argv=0x7fffffffebd0) at perf.c:312
#23 0x00005555557f2d18 in handle_internal_command (argc=4, argv=0x7fffffffebd0)
    at perf.c:364
#24 0x00005555557f2e6b in run_argv (argcp=0x7fffffffea2c, argv=0x7fffffffea20)
    at perf.c:408
#25 0x00005555557f326e in main (argc=4, argv=0x7fffffffebd0) at perf.c:538

This is on today's acme's perf/urgent branch.

Thanks,

Kim
