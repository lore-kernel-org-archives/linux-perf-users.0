From: Milian Wolff <mail@milianw.de>
Subject: Access to backtraces from user-space tracepoint callback in perf-script?
Date: Tue, 29 Apr 2014 17:44:54 +0200
Message-ID: <1998748.ORBRrU6aol@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:52623 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462AbaD2Pxm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Apr 2014 11:53:42 -0400
Received: from milian-kdab2.localnet (unknown [188.111.54.34])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id A188E6280526
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2014 17:44:55 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

today I played around with perf-script(-python) and custom tracepoints. What I 
could not figure out so far is how to print a backtrace from the python 
callback. Can someone explain me how this is done, or point me to the 
documentation for this?

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
