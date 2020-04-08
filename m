From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: perf probe + uprobes missing events
Date: Wed, 8 Apr 2020 12:14:52 +0900
Message-ID: <20200408121452.eef4eb8e66367677f295f9ea@kernel.org>
References: <20200406145356.GA32649@kernel.org>
        <20200407213943.3a92e040d4ce30dc55e9aa1f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200407213943.3a92e040d4ce30dc55e9aa1f@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

This seems like a perf (perf's ringbuffer?) issue.

Actually, we can not enable perf and ftrace on same uprobe event yet, but the hit counter (uprobe_profile) works.

1) Setup the event.

$ sudo ./perf probe -x ./perf expr__parse expr:string
Added new event:
  probe_perf:expr__parse (on expr__parse in /home/mhiramat/ksrc/linux/tools/perf/perf with expr:string)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:expr__parse -aR sleep 1

$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                                0

2) run the test command

$ sudo ./perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 perf/9789 probe_perf:expr__parse(__probe_ip: 94836726971904, expr_string: "1+1")

$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                               12

OK, this shows the perf trace command only shows 1 event, but uprobe_event itself hits 12 times.

3) run the test command again

$ sudo ./perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 perf/9847 probe_perf:expr__parse(__probe_ip: 94778335464960, expr_string: "1+1")
     0.014 perf/9847 probe_perf:expr__parse(__probe_ip: 94778335464960, expr_string: "FOO+BAR")
     0.018 perf/9847 probe_perf:expr__parse(__probe_ip: 94778335464960, expr_string: "(BAR/2)%2")
$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                               24

Again, the perf trace shows only 3 events, but uprobe event hits +12 times

4) run the test command with ftrace.

$ echo 1 | sudo tee /sys/kernel/debug/tracing/events/probe_perf/enable 
1
$ ./perf test -F expr
 7: Simple expression parser                              : Ok
$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                               36

Hit +12 times and the ftrace shows all events correctly.

$ sudo cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 24/24   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            perf-9883  [003] d...  9287.936678: expr__parse: (0x55ea35ce9e00) expr_string="1+1"
            perf-9883  [003] d...  9287.936694: expr__parse: (0x55ea35ce9e00) expr_string="FOO+BAR"
            perf-9883  [003] d...  9287.936699: expr__parse: (0x55ea35ce9e00) expr_string="(BAR/2)%2"
            perf-9883  [003] d...  9287.936704: expr__parse: (0x55ea35ce9e00) expr_string="1 - -4"
            perf-9883  [003] d...  9287.936707: expr__parse: (0x55ea35ce9e00) expr_string="(FOO-1)*2 + (BAR/2)%2 - -4"
            perf-9883  [003] d...  9287.936712: expr__parse: (0x55ea35ce9e00) expr_string="1-1 | 1"
            perf-9883  [003] d...  9287.936716: expr__parse: (0x55ea35ce9e00) expr_string="1-1 & 1"
            perf-9883  [003] d...  9287.936719: expr__parse: (0x55ea35ce9e00) expr_string="min(1,2) + 1"
            perf-9883  [003] d...  9287.936723: expr__parse: (0x55ea35ce9e00) expr_string="max(1,2) + 1"
            perf-9883  [003] d...  9287.936726: expr__parse: (0x55ea35ce9e00) expr_string="1+1 if 3*4 else 0"
            perf-9883  [003] d...  9287.936731: expr__parse: (0x55ea35ce9e00) expr_string="FOO/0"
            perf-9883  [003] d...  9287.936734: expr__parse: (0x55ea35ce9e00) expr_string="BAR/"

It seems that the perf ring buffer returns only early events
(since expr_string="1+1" is always shown), so I guess there is
a timing issue when the ring buffer is read.

Can we delay the read timing?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
