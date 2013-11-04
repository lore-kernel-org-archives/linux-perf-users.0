From: Milian Wolff <mail@milianw.de>
Subject: Can perf compare two perf.data files?
Date: Mon, 04 Nov 2013 16:17:58 +0100
Message-ID: <10173985.aGnRNdx3u3@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd24202.kasserver.com ([85.13.143.162]:53818 "EHLO
	dd24202.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab3KDPYW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Nov 2013 10:24:22 -0500
Received: from milian-kdab2.localnet (unknown [188.111.54.34])
	by dd24202.kasserver.com (Postfix) with ESMTPSA id C8AC7CFC486
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2013 16:17:58 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello there!

Is there some command for perf which I haven't found so far, that enables me 
to compare two perf.data files?

When I try to improve the performance, I first get a baseline perf.data. Then 
I try to optimize and want to compare before/after. It would now be cool if 
perf record could only show the difference between before/after, similar to 
what VTune is able to do.

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
