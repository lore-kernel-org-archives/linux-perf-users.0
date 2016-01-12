From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: linux 4.4, perf & BPF, and bpf_perf_event_output
Date: Mon, 11 Jan 2016 16:07:36 -0800
Message-ID: <CAE40pde1XCYDCRXgThopk_wiDN_yw26BWLGgL4iaFnkWCkpW-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38741 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbcALAIH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Jan 2016 19:08:07 -0500
Received: by mail-ig0-f182.google.com with SMTP id mw1so121161697igb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Jan 2016 16:08:06 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, Wang Nan <wangnan0@huawei.com>

G'Day,

Congrats Wang Nan on the new perf bpf features in 4.4! I just
revisited where I was at with them now that it's official, and have a
couple of questions.

So I can run something like this:

---syncsnoop.c---
/* perf.data: default event record only; trace_pipe:
bpf_trace_printk() output */
#include <uapi/linux/bpf.h>
#include "bpf_helpers.h"

SEC("func=sys_sync")
int bpf_func__sys_sync(void *ctx)
{
    char fmt[] = "sync()\n";
    bpf_trace_printk(fmt, sizeof (fmt));
    return 1;
};

char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
------

With: perf record -a --clang-opt "-DLINUX_VERSION_CODE=0x40400"
--event syncsnoop.c sleep 5

And it works. I get PERF_RECORD_SAMPLE entries in perf.data, and my
custom strings in /sys/kernel/debug/tracing/trace_pipe.

Q1. Given bpf_trace_printk() & trace_pipe is a hack, is there a way
yet to print my custom strings to perf.data? Eg, something like
bpf_perf_event_output() to change the format string of the event.
Currently I just get:

# perf script
            sync 30207 [002]  2509.576984: perf_bpf_probe:func:
(ffffffff81221b20)
            sync 30209 [003]  2509.766632: perf_bpf_probe:func:
(ffffffff81221b20)
            sync 30229 [003]  2509.936299: perf_bpf_probe:func:
(ffffffff81221b20)
            sync 30230 [004]  2510.099059: perf_bpf_probe:func:
(ffffffff81221b20)
            sync 30231 [004]  2510.289351: perf_bpf_probe:func:
(ffffffff81221b20)

Q2. Apart from per-event strings, is there a way to emit the maps?
bpf-script-example.c populates a map, but I don't think it ends up in
perf.data. I think a common case would be to emit it once for the run.
Another common case would be to emit it once per second. Any way we
can do this? I did try bpf_perf_event_output(), but I don't think it
ended up in perf.data (at least, I don't see it using "perf script
-D").

thanks,

Brendan
