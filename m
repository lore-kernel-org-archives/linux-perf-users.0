From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: attr inherit vs inherit_stat
Date: Tue, 7 Aug 2012 15:47:32 -0400
Message-ID: <alpine.DEB.2.00.1208071544240.16260@cl320.icl.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:30129
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755857Ab2HGTri (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Aug 2012 15:47:38 -0400
Received: from mail42-ch1 (localhost [127.0.0.1])	by mail42-ch1-R.bigfish.com
 (Postfix) with ESMTP id 28A41180327	for <linux-perf-users@vger.kernel.org>;
 Tue,  7 Aug 2012 19:47:37 +0000 (UTC)
Received: from CH1EHSMHS016.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.233])	by mail42-ch1.bigfish.com (Postfix) with ESMTP id 2594A8004C
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Aug 2012 19:47:35 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello

I'm trying to figure out the difference between the "inherit" and
"inherit_stat" bitfields in the perf_event_attr structure.

Both seem to have similar functionality, and the code in core.c
is hard to follow.

Does anyone have any idea?

Thanks,

Vince
vweaver1@eecs.utk.edu
