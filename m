From: Manuel Selva <selva.manuel@gmail.com>
Subject: Intel PEBS  Load Latency Measurement
Date: Tue, 17 Sep 2013 09:44:35 +0200
Message-ID: <52380863.4090606@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38588 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3IQHoi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Sep 2013 03:44:38 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so4563071wid.2
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2013 00:44:37 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am trying to use PMU on a 2 sockets workstation (2x Intel Xeon X5650 
currently running Linux 3.6.11) processor to identify memory controller 
unbalance.

For this purpose I successfully used some uncore events to count the 
load on each memory controller through the perf_event_open system call. 
I am now planning to use Intel PEBS Load Latency Measurement to identify 
if these loads result in "unusual" long memory latencies.

Looking at Vince Weaver web page discussing about kernel support for PMU 
here: 
http://web.eece.maine.edu/~vweaver/projects/perf_events/features.html I 
saw that the kernel 3.10 supports Load Latency Measurement. 
Unfortunately I can't find a man page describing how this works. Before 
looking at kernel sources, I wanted to ask here for confirmation about 
Load Latency Measurement in recent Linux kernels.

Can anyone confirm that this functionality is available and usable ? Is 
the perf userland tool using it to provide the functionality to end users ?

Thanks in advance for your help,

-- 
Manu
