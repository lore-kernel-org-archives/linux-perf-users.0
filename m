From: Adrien BAK <adrien.bak@metascale.org>
Subject: recording rapl/power events
Date: Mon, 21 Apr 2014 17:01:32 +0900
Message-ID: <5354D05C.8080201@metascale.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:43250 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaDUIBi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Apr 2014 04:01:38 -0400
Received: from mail615.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id BA2C5FFB7E6
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2014 10:01:36 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi everyone,

I am looking into the power (rapl) events introduced in the kernel in 
version 3.14.

Right now, I can access those events through perf stat :

perf stat -a -e power/energy-pkg/ sleep 1

  Performance counter stats for 'system wide':

              17.16 Joules power/energy-pkg/

        1.002808169 seconds time elapsed

However, it seems that I can't record a sequence of power events :

perf record -a -e power/energy-pkg/ sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) 
for event (power/energy-pkg/).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?

dmesg does not give any information, and, as far as I know, perf_events 
are fully supported by my kernel (

Is there some limitation of the power events (or kernel support) I am 
unaware of that could explain this behaviour, or is there something 
wrong with my setup/configuration ?
How would one procede to record a sequence of power events ?

Thanks in advance
A.
