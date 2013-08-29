From: Mikhail Kulemin <mihkulemin@gmail.com>
Subject: Re: What should I do if I want to get Perf samples and Read
 Performance Counter at the same time?
Date: Thu, 29 Aug 2013 08:59:41 +0400
Message-ID: <CAKnzfP9VxYry9v+tSyTrs_9m6GFoCGzAuKXY0_yv99LqumeZEg@mail.gmail.com>
References: <CAEuYUerYx9w=LdJsGG0PV0BKteMcoTL4ro=3+nfm8hBdXtuZ2w@mail.gmail.com>
	<521E57D4.7090105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48905 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab3H2E7m (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Aug 2013 00:59:42 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so7237555pdj.17
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2013 21:59:41 -0700 (PDT)
In-Reply-To: <521E57D4.7090105@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Peipei Wang <wangpeipei.90@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

There is a possibility to use perf script with python or perl.

1) Record needed events with perf record

[mih@home perf]$ perf record -e cache-misses ls
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.013 MB perf.data (~556 samples) ]

2) You can see actual info about events using 'perf script'

[mih@home perf]$ perf script
# ========
# captured on: Thu Aug 29 08:33:20 2013

<...some info ommited...>

# cmdline : /usr/bin/perf record -e cache-misses ls
# event : name = cache-misses, type = 0, config = 0x3, config1 = 0x0, config2 =
# HEADER_CPU_TOPOLOGY info available, use -I to display
# HEADER_NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: cpu = 4, software = 1, tracepoint = 2, uncore_cbox_0 = 6, uncore
# ========
#
           :2717  2717  1148.761687: cache-misses:  ffffffff8107cc0d task_tgid_n
           :2717  2717  1148.761690: cache-misses:  ffffffff8107cc0d task_tgid_n
              ls  2717  1148.761693: cache-misses:  ffffffff8111e2f6 __perf_even
              ls  2717  1148.761696: cache-misses:  ffffffff8106e410 flush_signa
              ls  2717  1148.761702: cache-misses:  ffffffff812f1867 clear_page_
              ls  2717  1148.761834: cache-misses:        3a5bc17f70 open64 (/us
              ls  2717  1148.762713: cache-misses:  ffffffff8139c103 do_output_c
(END)

3) You can see time of each sample but can not see number of events in
each sample. By default there can be different number of events in
each sample. To get such info you can use custom script. First of all
generate basic template

[mih@home perf]$ perf script -g py
generated Python script: perf-script.py

This script handled only tracepoint events. (For more information
about scripting for perf read "man perf-script"). To handle hw events
you can use function process_event(). This function is not well
documented but rather simple.  There is one difficulty - you need
parse C structure of perf_sample to  get info about time and number of
events. I use scruct python module and use perf_struct defenition (for
example from http://lxr.linux.no/#linux+v3.10.9/tools/perf/util/event.h#L83
)

My perf-script.py :

import os
import sys
import struct

sys.path.append(os.environ['PERF_EXEC_PATH'] + \
    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')

from perf_trace_context import *
from Core import *


def trace_begin():
    print "in trace_begin"

def trace_end():
    print "in trace_end"

def process_event(param_dict):
        event_attr = param_dict["attr"]
        sample     = param_dict["sample"]
        raw_buf    = param_dict["raw_buf"]
        comm       = param_dict["comm"]
        name       = param_dict["ev_name"]

        if (param_dict.has_key("symbol")):
                symbol = param_dict["symbol"]
        else:
                symbol = "Unknown_symbol"

        # Extract counts value from perf_sample struct (Dirty.
Addition to API neeeded.)
        (counts,) = struct.unpack("=Q",sample[48:56])
        (time,) = struct.unpack("=Q",sample[16:24])

        print name, counts, time, symbol, comm


4) Run your custom script perf script -s perf-script.py
[mih@home perf]$ perf script -s perf-script.py
in trace_begin
cache-misses 1 1148761687085 task_tgid_nr_ns :2717
cache-misses 1 1148761690924 task_tgid_nr_ns :2717
cache-misses 9 1148761693240 __perf_event__output_id_sample ls
cache-misses 121 1148761696003 flush_signal_handlers ls
cache-misses 1467 1148761702371 clear_page_c_e ls
cache-misses 8503 1148761834505 open64 ls
cache-misses 8469 1148762713882 do_output_char ls
in trace_end

Time in nanosec - third field
number of events in sample second field

5) If you use -c option when running perf record script will report
only 1 event perf sample (but actial number of events per sample is
determine by -c parameter)

Mikhail

2013/8/29 David Ahern <dsahern@gmail.com>:
> On 8/28/13 11:21 AM, Peipei Wang wrote:
>>
>> Hi all,
>>
>> Here is my issue, looking forward to the suggestions from you guys. I
>> have a java process and I can get the process id. I want to get the
>> information about the event cache-misses for this process at the
>> sampling rate 100(For this, I use perf record -e cache-misses -c 100 -p
>> pid) . And I also want to know how many cache-misses events occurs for
>> each second(For this I use watch perf stat -e cache-misses -p pid sleep 1)
>>
>> Any one has ideas about how to get both of them?
>
>
> I believe you will need to write your own perf command to do that
>
> David
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
