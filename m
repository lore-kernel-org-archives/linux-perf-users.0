From: Srinath <srsuryan@cisco.com>
Subject: How to interpret perf reporting tool
Date: Wed, 2 Sep 2015 00:48:35 +0000 (UTC)
Message-ID: <loom.20150902T024605-849@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44354 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbbIBAuI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Sep 2015 20:50:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1ZWwFX-0000Je-QK
	for linux-perf-users@vger.kernel.org; Wed, 02 Sep 2015 02:50:04 +0200
Received: from sjc12-dmz-wsa-3.cisco.com ([173.36.240.168])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 02:50:03 +0200
Received: from srsuryan by sjc12-dmz-wsa-3.cisco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 02:50:03 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

 I would like to understand how to interpret perf tool output such as
reporting output etc.

Specifically, I would like to understand how to understand the following
output I got from running my program

M sched:sched_switch                                                       
                  ?
633K sched:sched_stat_wait                                                 
                   ?
620K sched:sched_stat_sleep                                                
                   ?
2K sched:sched_stat_iowait                                                 
                   ?
648K sched:sched_stat_runtime                                              
                   ?
72 sched:sched_process_fork                                                
                   ?
623K sched:sched_wakeup                                                    
                   ?
4K sched:sched_migrate_task                                                
                   ?
                                                                           
                   ?
My problem is, I see the ipc I am using takes long time but during this
capture the cpu idle time has been 98%. So I am wondering where have I gone
wrong?

Thank you,
Srinath
