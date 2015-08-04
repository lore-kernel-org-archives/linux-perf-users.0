From: Milian Wolff <mail@milianw.de>
Subject: RE: perf script: how to print user-space backtrace?
Date: Tue, 04 Aug 2015 19:18:30 +0200
Message-ID: <31999299.t6DjXiAAb9@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:54789 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbHDRSc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 13:18:32 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id D89466280966
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2015 19:18:30 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hey again,

could someone please look at this email:

http://thread.gmane.org/gmane.linux.kernel.perf.user/2174

This completely breaks the FlameGraph creation, which is a pity :(

Thanks
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
