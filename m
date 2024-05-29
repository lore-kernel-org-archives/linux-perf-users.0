Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161211C8FA8;
	Wed, 29 May 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014518; cv=none; b=DQiZYm8itfVWJ0aJKsozveC2QRV0qjl8KjNLlQoPzM40hqBYMGyj48MW6rd9Dxhdhd+LgpZCI3O2rBhq0SUMyreBlCmuvBzoD74fFVnrNiv2Dk2GiyKFpQCa2iOnFT2KYDw+Ei90VbQxFfgA/1pS082USweMrjNDsoQWvIWKJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014518; c=relaxed/simple;
	bh=5Ss+qVKsW4nTXNmqKzHj51EVHt4aOtz+UFZAROKBrOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBxvI4NSQ0B9xXoot8rkBOXVZzhFzeJXN6SkbRE32oD0/n+sflsd71ViKuWDucRmYDF+X8lTZc+4JKEtqKchD2LoKBSp5A3xe27+87BQjCJJQNvC+0oUE03lkVGJBE4pCEJvmKKOIpzWUkOfBs+w2eJcH7O4OuR4RETqgl4v5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esE4oyEX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esE4oyEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717014517; x=1748550517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Ss+qVKsW4nTXNmqKzHj51EVHt4aOtz+UFZAROKBrOg=;
  b=esE4oyEX0f7gM0o9S7N2T4uiXapAXDYyddUS4IfaP/wRJSvyoRqvzTHp
   FeX3KTVfBs8f0mq4v7DfJwim8LnsBoBpC0jE3HwpnZs8D+Xz+5nBICN2b
   zLmCI3/MVqW4Vn99Wy7kz9IO60JEmvj5I/gO9Aans49Q9AaTfB1J1HWm5
   mtrfF+360cEvL0WnFJezd7fVFmyPcDz4+XAG1+87j4c96iSdyXqZwOExr
   62WEg0PbPlrjTXCKXWnG7Uva0nhW+iBsgvIGCUCIoHkpyM+GKHHd1LUpw
   +XxE6t1LEq3ECx0jHEvltHDxoi7GbgejBYNjuwgdhuWTVt3tXQHApXjyS
   w==;
X-CSE-ConnectionGUID: jDHljMDXTw+3r7zwGuO2KA==
X-CSE-MsgGUID: 5FrWnwNHQvSq/xklSbbSpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13574545"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13574545"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 13:28:34 -0700
X-CSE-ConnectionGUID: JeoMxu0zR6K9zS/MN1X+bQ==
X-CSE-MsgGUID: Ub56xL9GSC6+vcroKOFI/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35491278"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 13:28:34 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>,
	"Xin Li" <xin3.li@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/6] x86/irq: Factor out common NMI handling code
Date: Wed, 29 May 2024 13:33:22 -0700
Message-Id: <20240529203325.3039243-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for handling NMIs with explicit source reporting, factor
out common code for reuse.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/nmi.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 1ff4f7c9f182..e2122ec9313c 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -135,6 +135,20 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 		action->handler, duration, decimal_msecs);
 }
 
+static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs *regs, unsigned int type)
+{
+	int thishandled;
+	u64 delta;
+
+	delta = sched_clock();
+	thishandled = a->handler(type, regs);
+	delta = sched_clock() - delta;
+	trace_nmi_handler(a->handler, (int)delta, thishandled);
+	nmi_check_duration(a, delta);
+
+	return thishandled;
+}
+
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
@@ -149,18 +163,8 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
 	 * can be latched at any given time.  Walk the whole list
 	 * to handle those situations.
 	 */
-	list_for_each_entry_rcu(a, &desc->head, list) {
-		int thishandled;
-		u64 delta;
-
-		delta = sched_clock();
-		thishandled = a->handler(type, regs);
-		handled += thishandled;
-		delta = sched_clock() - delta;
-		trace_nmi_handler(a->handler, (int)delta, thishandled);
-
-		nmi_check_duration(a, delta);
-	}
+	list_for_each_entry_rcu(a, &desc->head, list)
+		handled += do_handle_nmi(a, regs, type);
 
 	rcu_read_unlock();
 
-- 
2.25.1

