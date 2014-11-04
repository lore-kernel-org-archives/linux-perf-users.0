From: Milian Wolff <mail@milianw.de>
Subject: Adding cache misses and references to list of default events for perf stat?
Date: Tue, 04 Nov 2014 17:44:35 +0100
Message-ID: <2902317.tSPbunES6b@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:49597 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaKDQwb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Nov 2014 11:52:31 -0500
Received: from milian-kdab2.localnet (unknown [188.111.54.34])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 67FF66280246
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2014 17:44:36 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello all,

could we have the cache-references,cache-misses events added to the list of 
default events for perf stat? I think it is a very valuable metric for all 
user-space applications.

Currently, I run perf stat twice, once with the default events, and once with

perf stat -e cache-references,cache-misses ...

there is no easy way to append two events to the list of default events.

So, what do you think?

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
