From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Workarounds for LLC miss profiling without PEBS
Date: Mon, 16 May 2016 18:01:47 -0700
Message-ID: <CAE40pdfxcd_aZ0Bkjk28Fa8TDHbLZUSS1QdpQJ3AudTMXAMB0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:32854 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbcEQBCR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 May 2016 21:02:17 -0400
Received: by mail-io0-f175.google.com with SMTP id f89so4861525ioi.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2016 18:02:17 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

I have a system that lacks PEBS, and would like to do LLC miss
profiling to identify the responsible functions. Some skid is okay, so
long as it usually stays within the function. I've come up with one
hack, and wonder if people know of others...

To test this out, I wrote a test program[1], and profiled LLC misses:

# perf top -e r412e:u -c 10000
Overhead  Shared Object     Symbol
  99.30%  memprofiletest    [.] spinner
   0.64%  memprofiletest    [.] memreader
   0.06%  perf              [.] 0x000000000006728e

It's identifying the wrong function: it should identify memreader, not
spinner. The :p modifier is also "not permitted" on this system (this
is Sandy Bridge, but also a Xen guest).

Now with a hack:

# perf top -e r412e:u -c 10000
Overhead  Shared Object     Symbol
  97.39%  memprofiletest    [.] memreader
   0.64%  perf              [.] 0x000000000007a667
   0.42%  memprofiletest    [.] spinner
   0.19%  perf              [.] 0x0000000000084d56
   0.11%  [kernel]          [k] xen_hvm_callback_vector
   0.11%  libc-2.19.so      [.] pthread_cond_destroy@@GLIBC_2.3.2
   0.11%  libjvm.so         [.] _ZNK24CompactibleFreeListSpace4freeEv

Works. This hack is adding three "mfence" instructions at the end of
each function, which also causes it to run 30% slower (for this
workload). Awful, yes. I suppose I could modifier compilers to do this
too, or do something similar dynamically with uretprobes...

Anyone know of other hacks?

I was also thinking of reducing the clockspeed, to see if that
improved (reduced) skid.

Maybe there's a way to cause mem loads/stores to be MUCH slower, also
reducing skid enough to fall within a function?

Brendan

[1] https://gist.github.com/brendangregg/84de23c57b2ef477d82bc30af15ca1cf
