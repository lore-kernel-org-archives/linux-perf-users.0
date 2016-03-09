From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Bogus PMCs on Linux 3.13
Date: Wed, 9 Mar 2016 12:48:06 -0800
Message-ID: <CAE40pdezFG8caviy4NMNjKkucoU2tp2cbjAPY-V66RJfUwe66g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34975 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933896AbcCIUsh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Mar 2016 15:48:37 -0500
Received: by mail-ig0-f173.google.com with SMTP id vf5so1677804igb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Mar 2016 12:48:36 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

I'm guessing/hoping this has been fixed and someone knows this
offhand... I just noticed the following crazyness involving measuring
the same PMC multiple times:

On Linux 4.2:

# perf stat -e cycles -e instructions -e instructions -e instructions
-e instructions -e instructions -e instructions -e instructions -e
instructions dd if=/dev/zero of=/dev/null bs=1024k count=10k
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 0.559049 s, 19.2 GB/s

 Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1024k
count=10k':

     1,846,674,979      cycles
     5,643,478,284      instructions              #    3.06  insns per
cycle
     5,643,478,284      instructions              #    3.06  insns per
cycle
     5,643,478,284      instructions              #    3.06  insns per
cycle
     5,643,478,284      instructions              #    3.06  insns per
cycle
     5,643,478,284      instructions              #    3.06  insns per
cycle
     5,643,478,284      instructions              #    3.06  insns per
cycle
     5,643,478,284      instructions              #    3.06  insns per
cycle
     5,643,478,284      instructions              #    3.06  insns per
cycle

       0.560372803 seconds time elapsed

Ok, what am I trying to do here? Look like I've lost my mind. Now on Linux 3.13:

# perf stat -e cycles -e instructions -e instructions -e instructions
-e instructions -e instructions -e instructions -e instructions -e
instructions dd if=/dev/zero of=/dev/null bs=1024k count=10k
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 0.592963 s, 18.1 GB/s

 Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1024k
count=10k':

     1,784,251,390 cycles                    [33.80%]
   388,784,218,053 instructions              #   217.90  insns per
cycle         [34.25%]
    29,210,705,287 instructions              #   16.37  insns per
cycle         [34.69%]
    29,130,543,782 instructions              #   16.33  insns per
cycle         [34.44%]
   386,106,445,334 instructions              #   216.40  insns per
cycle         [33.93%]
    24,142,195,608 instructions              #   13.53  insns per
cycle         [33.26%]
    24,634,254,460 instructions              #   13.81  insns per
cycle         [32.59%]
   313,401,323,744 instructions              #   175.65  insns per
cycle         [33.58%]
     5,326,841,700 instructions              #    2.99  insns per
cycle         [33.34%]

       0.593762053 seconds time elapsed

Now I've definitely lost my mind.

If I measure the instructions PMC once, it doesn't work. Need to
measure it at least twice. In the above output, it's the last
"instructions" line that is sane.

If you've seen this before and know offhand, please let me know. If
not, I wouldn't dig on it -- it works fine on Linux 4.2, so might have
been fixed already. I've also mucked with this 3.13 server, so it
could just be me...

Brendan
