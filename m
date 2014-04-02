From: "\"Oleg A. Arkhangelsky\"" <sysoleg@yandex.ru>
Subject: Inconsistent perf top output
Date: Wed, 02 Apr 2014 18:31:35 +0400
Message-ID: <645781396449095@web21h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from forward3h.mail.yandex.net ([84.201.187.148]:38050 "EHLO
	forward3h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbaDBObj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Apr 2014 10:31:39 -0400
Received: from web21h.yandex.ru (web21h.yandex.ru [84.201.187.155])
	by forward3h.mail.yandex.net (Yandex) with ESMTP id 231431360704
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2014 18:31:36 +0400 (MSK)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I'm profiling Linux IP packet forwarding performance. In common case I see this
functions eating most of CPU cycles.

13735.00 22.5% build_skb  
5138.00   8.4% ipt_do_table 
4750.00   7.8% fib_table_lookup
3519.00   5.8% ixgbe_clean_rx_irq
2836.00   4.6% nf_iterate
1530.00   2.5% dev_queue_xmit

Looks good. But accidentally I run tcpdump program on one of the NICs related
to my test. After killing tcpdump I see that top is different:

6362.00 10.3% fib_table_lookup
6227.00 10.1% ipt_do_table
4300.00  7.0% ixgbe_clean_rx_irq
3771.00  6.1% nf_iterate
3284.00  5.3% build_skb
2179.00  3.5% ixgbe_xmit_frame_ring

Dramatic change in build_skb() cpu cycles. But tcpdump is not active anymore.
More than this, if I stop pktgen on traffic generator PC for a few seconds and
start it again without any other changes, I see that build_skb() is top offender
again. Running tcpdump again and killing it move fib_table_lookup() or
ipt_do_table() (they are pretty same in cpu cycles) to the top. So this behavior
is reproducible.

I just have no sane explanation to such strange behavior. Maybe someone have?

Thank you!
