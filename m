From: Milian Wolff <mail@milianw.de>
Subject: Size of perf data files
Date: Wed, 26 Nov 2014 13:47:41 +0100
Message-ID: <1601237.BEhNSa8l6d@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:34846 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaKZMrq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 07:47:46 -0500
Received: from milian-kdab2.localnet (unknown [188.111.54.34])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id DCFBC628027E
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2014 13:47:43 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hello all,

I wonder whether there is a way to reduce the size of perf data files. Esp. 
when I collect call graph information via Dwarf on user space applications, I 
easily end up with multiple gigabytes of data in just a few seconds.

I assume currently, perf is built for lowest possible overhead in mind. But 
could maybe a post-processor be added, which can be run after perf is finished 
collecting data, that aggregates common backtraces etc.? Essentially what I'd 
like to see would be something similar to:

perf report --stdout | gzip > perf.report.gz
perf report -g graph --no-children -i perf.report.gz

Does anything like that exist yet? Or is it planned? 

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
