From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Does Perf support AMD cpu perfectly?
Date: Mon, 26 Nov 2012 20:24:42 +0900
Message-ID: <50B3517A.7090505@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:53028 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab2KZLZU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Nov 2012 06:25:20 -0500
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id qAQBSW3p022482
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 20:28:32 +0900
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all.

I'm on the way of monitoring AMD machine.

I wonder Perf is supporting AMD PMU Events perfectly or not.

It seems not working correctly despite the same command works in intel
machines perfectly.

command : (perf stat -e rc0 -e instructions ./blah)
result : the value for "rc0" almost equals to that of "instruction" in
Intel machine, while it does not in AMD machine


Other events such as cache events seem weird also.

Is there any material mentioning this issue?



Thanks!
