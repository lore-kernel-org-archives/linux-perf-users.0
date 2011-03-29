From: Nathan Lawrence <nlawren2@illinois.edu>
Subject: ARM Performance Counters
Date: Tue, 29 Mar 2011 15:33:24 -0500
Message-ID: <AANLkTikgfT9VBsdE8jMRymMH9YkBySuQs_yadaW_No=m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35007 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab1C2UdZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2011 16:33:25 -0400
Received: by iyb14 with SMTP id 14so495984iyb.19
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2011 13:33:25 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I'm not sure if this is the correct place to ask this.  I'm trying to
get the branch miss-predict rate of an application using oprofile on
an ARM cortex A8.

Due to the complexity of the ARM performance counters, I'm trying to
write some simple test code to get performance counter results from,
however I'm not entirely sure of how to do this.

Ideally, I think that I would like to simply read/write to the PMCNT
registers from usermode, which should be possible so long as it's
turned on in the kernel.  From reading some of the kernel code, it
appears that this functionality is turned on when the
PERF_EVENT_IOC_ENABLE ioctl is called, however I'm still getting an
illegal instruction error, suggesting that this is not the case.

The code that I currently have is located at https://gist.github.com/891812.

If anybody could give me any pointers, it would be greatly appreciated.

All the best,
-- Nathan
