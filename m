From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: PEBS event monitoring
Date: Thu, 29 Nov 2012 15:08:16 +0900
Message-ID: <50B6FBD0.1010406@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:39478 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab2K2GIV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Nov 2012 01:08:21 -0500
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id qAT6C5xM011492
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Nov 2012 15:12:06 +0900
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, all.

Sorry for consecutive basic questions.

I am about to use PEBS monitoring of Intel CPU. (westmere)

Let me elaborate pfmon example a bit.

 %  pfmon --smpl-module=pebs -einstructions_retired --inv=1
--counter-mask=1 --long-smpl-periods=2660000 -uk -- foo
 # counts   %self    %cum          code addr
     1976  70.67%  70.67% 0x00000000004005e9
      710  25.39%  96.07% 0x00000000004005f1
       61   2.18%  98.25% 0x00000000004005e0
       21   0.75%  99.00% 0x00000000004005ed
       10   0.36%  99.36% 0x00000000004005f4
        2   0.07%  99.43% 0xffffffff80583110
        2   0.07%  99.50% 0xffffffff8024b4f8

As shown in the above,
I want to get the count number attached with address information.

While the example is only for retired instruction event, I want the same
thing for memory event (mem_load_retired) using Perf.

Is there any guide for this issue?
