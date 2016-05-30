From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH-REBASED 0/2] report perf sampling failing due to PMU lacking overflow intr support
Date: Mon, 30 May 2016 17:01:44 +0530
Message-ID: <1464607906-16012-1-git-send-email-vgupta@synopsys.com>
References: <alpine.DEB.2.20.1605121903470.18777@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:40537 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060AbcE3LcM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 30 May 2016 07:32:12 -0400
In-Reply-To: <alpine.DEB.2.20.1605121903470.18777@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, vincent.weaver@maine.edu, linux-snps-arc@lists.infradead.org, Alexey.Brodkin@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi,

This is a repost of RFC [1], rebased on 4.7-rc1, to print pretty PMU lacking
overflow interrupt support if user tries perf sampling.

At the time of RFC review, both PeterZ and Vince seemed convinced to go ahead
with this patch despite the ABI change [2].

Thx,
-Vineet


[1] http://lists.infradead.org/pipermail/linux-snps-arc/2016-May/001014.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2016-May/001032.html

Vineet Gupta (2):
  tools/perf: Handle EOPNOTSUPP for sampling events
  perf/core: change errno for sampling event not supported in hardware

 kernel/events/core.c    | 2 +-
 tools/perf/util/evsel.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.5.0
