From: Victor Jimenez <victor.javier@bsc.es>
Subject: Problem when profiling a process' running/sleeping/waiting time
Date: Wed, 09 Jan 2013 11:56:32 +0100
Message-ID: <50ED4CE0.7050201@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:46061 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab3AILGU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Jan 2013 06:06:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 03FF71F319
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jan 2013 11:56:49 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06629-05 for <linux-perf-users@vger.kernel.org>;
 Wed,  9 Jan 2013 11:56:48 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 09C446A9BB
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jan 2013 11:56:48 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id r09Aulff008681
	for linux-perf-users@vger.kernel.org; Wed, 9 Jan 2013 11:56:47 +0100
Received: from [IPv6:2001:40b0:7c00:96:159b:3be5:d2ee:b33d] (unknown [IPv6:2001:40b0:7c00:96:159b:3be5:d2ee:b33d])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id BF5CE6A9B2
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jan 2013 11:56:47 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am trying to profile a process in terms of running, sleeping and 
waiting time. I am using kernel 3.6.6 running on an IBM POWER7 machine. 
Initially, I decided to use a toy example where I would expect that the 
process remains in running state most of the time. This is the code for 
such a simple example:

int main() {
     for (int i = 0; i < 1000000; i++)
         for (int j = 0; j < 1000; j++);
}

I am using the following command line for reading kernel stats:

perf stat -e 
"sched:sched_stat_runtime,sched:sched_stat_sleep,sched:sched_stat_wait, \
     sched:sched_stat_iowait,sched:sched_stat_blocked" ./test

And these are the results that I obtain:

  Performance counter stats for './test':

     12,077,957,756 sched:sched_stat_runtime
    169,892,740,990 sched:sched_stat_sleep
          5,816,784 sched:sched_stat_wait
                  0 sched:sched_stat_iowait
                  0 sched:sched_stat_blocked

      12.084706279  seconds time elapsed

I cannot really understand why the counter for sched_stat_sleep is so 
high (even higher than sched_stat_runtime), especially for such a 
CPU-bound workload.

Am I missing anything, or there could be a problem with sched_stat_sleep 
counter?

Thank you,
Victor

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
