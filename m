From: Patrick Agrain <patrick.agrain@al-enterprise.com>
Subject: Re: perf records no samples on an IBM x3250M5
Date: Fri, 4 Dec 2015 08:45:48 +0000 (UTC)
Message-ID: <loom.20151204T093848-79@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42814 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465AbbLDIp4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Dec 2015 03:45:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1a4m02-0002Ss-IP
	for linux-perf-users@vger.kernel.org; Fri, 04 Dec 2015 09:45:54 +0100
Received: from proxy.eu.alcatel-lucent.com ([proxy.eu.alcatel-lucent.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Dec 2015 09:45:54 +0100
Received: from patrick.agrain by proxy.eu.alcatel-lucent.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Dec 2015 09:45:54 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


On Thu, 2015-12-03 at 14:26 +0000, Patrick Agrain wrote:
>> Hello,
>> 
>> perf record no samples in perf.data on an IBM x3250M5.
>> perf stat is OK (in that way that it displays some stats).

> 1) Which stats are displayed? Do the basic events from "perf list hw"
> work?

> perf stat -e cycles -- sleep 1
> perf stat -e instructions -- sleep 1

Hello,

Sorry, but I'm not familiar at all with Gmane interface. I only find this
way to answer to the questions Michael Petlan asked me.

[root@x3250-m5 tmpd]# ./perf319 stat -e cycles -- sleep 1

 Performance counter stats for 'sleep 1':

           749,662      cycles

       1.000436036 seconds time elapsed

[root@x3250-m5 tmpd]# perf stat -e instructions -- sleep 1
-bash: perf: command not found
[root@x3250-m5 tmpd]# ./perf319 stat -e instructions -- sleep 1

 Performance counter stats for 'sleep 1':

           545,304      instructions

       1.000413356 seconds time elapsed

[root@x3250-m5 tmpd]#

> 2) What does "perf list hw" show?

lines 1-7/7 (END)
  instructions                                       [Hardware event]
  cache-references                                   [Hardware event]
  cache-misses                                       [Hardware event]
  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]


Hope it helps. Thanks.
Kind regards,
Patrick Agrain
