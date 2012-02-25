From: Joy James Prabhu <prabhu.link@gmail.com>
Subject: Doubt about cache coherence related perf event
Date: Sat, 25 Feb 2012 04:05:44 +0000 (UTC)
Message-ID: <loom.20120225T050202-879@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42031 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009Ab2BYEKF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 24 Feb 2012 23:10:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1S18xP-0001x4-4q
	for linux-perf-users@vger.kernel.org; Sat, 25 Feb 2012 05:10:03 +0100
Received: from 24-240-35-126.dhcp.mdsn.wi.charter.com ([24.240.35.126])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2012 05:10:03 +0100
Received: from prabhu.link by 24-240-35-126.dhcp.mdsn.wi.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2012 05:10:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

 I am working on monitoring cache coherence events using perf. The more I use
the tool, the more I appreciate its design :)

 So, I am using perf on Intel i7 Nehalem machine which supports this event
related to L1 data cache stores :

#-----------------------------
IDX     : 31457325
PMU name : nhm (Intel Nehalem)
Name     : L1D_CACHE_ST
Equiv     : None
Flags    : None
Desc     : L1 data cache stores
Code     : 0x41
Umask-00 : 0x04 : PMU : [E_STATE] : None : L1 data cache stores in E state
Umask-01 : 0x01 : PMU : [I_STATE] : None : L1 data cache store in the I state
Umask-02 : 0x08 : PMU : [M_STATE] : None : L1 data cache stores in M state
Umask-03 : 0x02 : PMU : [S_STATE] : None : L1 data cache stores in S state
Umask-04 : 0x0f : PMU : [MESI] : [default] : L1 data cache store in all states

To obtain these events, I used the command :
          "perf -R -e r141:u,r241:u,r441:u,r841:u  -c 3 <some binary>"


(a) Now, just to be sure, are my raw event identifiers correct ?

(b) I then used "perf script" on the perf.data file, but here comes the strange
part :

     I got this log tuple for 'pbzip2_good' binary using r841:u [ L1 data cache
stores in modified state at user level ] :

     pbzip2_good  5857 [004] 15198.792535: raw 0x841:   402c1c
_Z19consumer_decompressPv 
(/home/joy/Desktop/Perf/pbzip2/pbzip2-0.9.4/pbzip2_good)

     Basically, it points to an instruction 402c1c in consumer_decompress
function which is basically a call to pthread_mutex_lock :

/home/joy/Desktop/Perf/pbzip2/pbzip2-0.9.4/pbzip2.cpp:555
  402c18:    48 8b 7b 30              mov    0x30(%rbx),%rdi
  402c1c:    e8 87 ed ff ff           callq  4019a8 <pthread_mutex_lock@plt>

    Corresponding code :

     pthread_mutex_lock(fifo->mut);
    
   So, I was expecting "402c18" to be the interesting instruction, but I always
see the "402c1c" instruction in the perf log. I see several more
pthread_function calls in the log.

   How can a "call" instruction, which from my understanding, has nothing to do
with cache coherence events in data cache, always come up in the output ?  While
the "mov" instruction, which is more related to modified stores in data cache,
never comes up in the log.

  All suggestions are welcome :)
