From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: PEBS availability
Date: Tue, 24 May 2011 16:49:27 +0100
Message-ID: <4DDBD387.2070906@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:1612 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757059Ab1EXPva (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 May 2011 11:51:30 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I've just got a shiny new i3-2310M and am a
bit surprised that `perf` isn't listing
detailed stats like L1 cache misses etc.

$ perf stat true

 Performance counter stats for 'true':

             1,239 cache-misses             #      1.555 M/sec
             9,314 cache-references         #     11.693 M/sec
             3,940 branch-misses            #      4.871 %
            80,885 branches                 #    101.546 M/sec
           403,808 instructions             #      0.000 IPC
     <not counted> cycles
                81 page-faults              #      0.102 M/sec
                 0 CPU-migrations           #      0.000 M/sec
                 1 context-switches         #      0.001 M/sec
          0.796537 task-clock-msecs         #      0.032 CPUs

        0.024654938  seconds time elapsed

I searched for a while but found it _very_ difficult
to find info on what was available on particular intel CPUs.

I did see in the "Nehalem Core PMU programming guide":
http://software.intel.com/file/30320
that the above stats are core features and that the other
counters I mentioned are PEBS (Precise Event Based Sampling)
and are not available on all systems.

So am I out of look with my new i3 sandy bridge CPU?
Are PEBS restricted to i7 versions only?
Is this documented anywhere?

Maybe I need some kernel support as hinted at by:
http://lwn.net/Articles/430100/
My kernel is 2.6.38.6-27.fc15.x86_64

cheers.
P=C3=A1draig.
