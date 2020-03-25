From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Date: Wed, 25 Mar 2020 16:17:57 -0300
Message-ID: <20200325191757.GG14102@kernel.org>
References: <20200325164053.10177-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200325164053.10177-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 25, 2020 at 09:40:53AM -0700, Tony Jones escreveu:
> The method of unwinding for kernel space is defined by the kernel config, 
> not by the value of --call-graph.   Improve the documentation to reflect 
> this.

Fixed the callgraph -> call-graph bit, as you pointed out privately,
applied.

About your question, to get the answer in some public location as
documentation about perf usage:

> As an aside, for record path, do you know where PERF_SAMPLE_CALLCHAIN
> is actually set before being passed to kernel space?

So, I think is somewhere down from perf_evsel__config()... its in:

	perf_evsel__set_sample_bit(evsel, CALLCHAIN);

which is set at:

$ perf probe -x ~/bin/perf -L __perf_evsel__config_callchain
<__perf_evsel__config_callchain@/home/acme/git/perf/tools/perf/util/evsel.c:0>
      0  static void __perf_evsel__config_callchain(struct evsel *evsel,
                                                   struct record_opts *opts,
                                                   struct callchain_param *param)
      3  {
      4         bool function = perf_evsel__is_function_event(evsel);
      5         struct perf_event_attr *attr = &evsel->core.attr;

      7         perf_evsel__set_sample_bit(evsel, CALLCHAIN);

      9         attr->sample_max_stack = param->max_stack;

     11         if (opts->kernel_callchains)
     12                 attr->exclude_callchain_user = 1;
     13         if (opts->user_callchains)
     14                 attr->exclude_callchain_kernel = 1;
     15         if (param->record_mode == CALLCHAIN_LBR) {


Line 7 of __perf_evsel__config_callchain(), so lets use perf probe +
perf trace + perf callchains to see where perf callchains are asked from
the kernel:

[root@seventh ~]# perf probe -x ~/bin/perf __perf_evsel__config_callchain:7
Added new event:
  probe_perf:__perf_evsel__config_callchain_L7 (on __perf_evsel__config_callchain:7 in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:__perf_evsel__config_callchain_L7 -aR sleep 1

[root@seventh ~]#
[root@seventh ~]# perf trace -e probe_perf:*callchain*/max-stack=16/ perf record -g sleep 1
     0.000 perf/14860 probe_perf:__perf_evsel__config_callchain_L7(__probe_ip: 5263069)
                                       __perf_evsel__config_callchain (/home/acme/bin/perf)
                                       perf_evsel__config_callchain (/home/acme/bin/perf)
                                       perf_evsel__config (/home/acme/bin/perf)
                                       perf_evlist__config (/home/acme/bin/perf)
                                       record__open (/home/acme/bin/perf)
                                       __cmd_record (/home/acme/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
                                       handle_internal_command (/home/acme/bin/perf)
                                       run_argv (/home/acme/bin/perf)
                                       main (/home/acme/bin/perf)
                                       __libc_start_main (/usr/lib64/libc-2.29.so)
                                       [0] ([unknown])
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data (8 samples) ]
[root@seventh ~]#

That [0] is the ugly part here, have seen it before, need to nail it
down, unsee it and all the rest seems ok, right?

- Arnaldo
