From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 0/2] report perf sampling failing due to PMU lacking overflow intr support
Date: Mon, 9 May 2016 15:07:38 +0530
Message-ID: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:56391 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbcEIJiD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 May 2016 05:38:03 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, peterz@infradead.org, acme@redhat.com
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org, vincent.weaver@maine.edu, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi,

A couple of minor patches to print better PMU lacking overflow intr support
such as in ARC700 cores.

This is an ABI change so might be controversial hence RFC.

Despite triviality, I've seperated the change into 2 pacthes - for different maintainers
and also kept userspace change first to keep it bisectable.

Comments welcome !

Thx,
-Vineet

Vineet Gupta (2):
  tools/perf: Handle EOPNOTSUPP for sampling events
  perf/core: change errno for sampling event not supported in hardware

 kernel/events/core.c    | 2 +-
 tools/perf/util/evsel.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.5.0
