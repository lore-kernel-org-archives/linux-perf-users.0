From: William Cohen <wcohen@redhat.com>
Subject: Some event modifiers missing from output and desire option to compute
 value based on measurements
Date: Thu, 13 Mar 2014 12:58:20 -0400
Message-ID: <5321E3AC.8050600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62022 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbaCMQ6W (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Mar 2014 12:58:22 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2DGwLn0027190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2014 12:58:22 -0400
Received: from [10.13.129.12] (dhcp129-12.rdu.redhat.com [10.13.129.12])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s2DGwKR1020581
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2014 12:58:21 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

When experimenting with perf I wanted to have separate counts for events in userspace and the kernel.  I used:

$ perf stat   -e instructions:u -e instructions:k -e cycles:u -e cycles:k -e cache-misses:u -e cache-misses:k make

The associated  output below includes the event modifiers for all the events, but the 3.06 and 0.37 insns per cycles look off.  Shouldn't that instructions:u/cycles:u and instructions:k/cycles:k be the values reported for "insns per cycle"?

Performance counter stats for 'make':

   340,034,597,510 instructions:u            #    3.06  insns per cycle         [83.70%]
    40,963,149,231 instructions:k            #    0.37  insns per cycle         [83.67%]
   185,451,244,302 cycles:u                  [83.54%]
    36,901,938,457 cycles:k                  [83.64%]
        34,811,408 cache-misses:u                                               [83.96%]
       102,781,614 cache-misses:k                                               [83.85%]

      66.290033775 seconds time elapsed

For the L1-icache-load-misses and iTLB-load-misses the event modifier appears to be dropped as shown in the output below

$ perf stat   -e instructions:u -e instructions:k -e cycles:u -e cycles:k -e L1-icache-load-misses:u -e L1-icache-load-misses:k make

 Performance counter stats for 'make':

   340,522,617,398 instructions:u            #    3.09  insns per cycle         [83.55%]
    41,045,130,555 instructions:k            #    0.37  insns per cycle         [83.82%]
   184,082,319,783 cycles:u                  [84.12%]
    36,447,301,873 cycles:k                  [84.21%]
       849,438,930 L1-icache-load-misses                                        [82.96%]
       445,141,089 L1-icache-load-misses                                        [83.67%]

      65.611650172 seconds time elapsed




$ perf stat   -e instructions:u -e instructions:k -e cycles:u -e cycles:k -e iTLB-load-misses:u -e iTLB-load-misses:k make


 2,074,873,836,988 instructions:u            #    2.09  insns per cycle         [83.47%]
   128,412,604,104 instructions:k            #    0.13  insns per cycle         [83.51%]
 1,786,252,236,017 cycles:u                  [83.52%]
   202,469,325,995 cycles:k                  [83.46%]
       786,419,505 iTLB-load-misses                                             [83.44%]
        40,548,044 iTLB-load-misses                                             [83.43%]

    3800.440742009 seconds time elapsed



It appears that the output is listing the measurements in the same order they are specified on the command line, but it would be nice if the output was clearer on the events being measured.  If I am reading the output correctly, the L1-icache-load-misses per instruction is pretty poor for kernel-space.  Much of the time I am looking at ratios of events and it would be nice if "perf stat" had a way to have it compute the ratios directly. Maybe a "-m, --math" option allowing algebraic expressions where you could do:

perf stat   -e instructions:u -e instructions:k -e cycles:u -e cycles:k -e L1-icache-load-misses:u -e L1-icache-load-misses:k \
--math instructions:u/icache-load-misses:u \
--math instructions:k/icache-load-misses:k \
make

 Performance counter stats for 'make':

$ perf stat   -e instructions:u -e instructions:k -e cycles:u -e cycles:k -e L1-icache-load-misses:u -e L1-icache-load-misses:k make

 Performance counter stats for 'make':

   340,522,617,398 instructions:u            #    3.09  insns per cycle         [83.55%]
    41,045,130,555 instructions:k            #    0.37  insns per cycle         [83.82%]
   184,082,319,783 cycles:u                  [84.12%]
    36,447,301,873 cycles:k                  [84.21%]
       849,438,930 L1-icache-load-misses                                        [82.96%]
       445,141,089 L1-icache-load-misses                                        [83.67%]
            401.09 instructions:u/icache-load-misses:u
             92.20 instructions:k/icache-load-misses:k

      65.611650172 seconds time elapsed

-Will
