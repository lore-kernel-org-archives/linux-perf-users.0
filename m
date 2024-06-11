Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DA4CE13;
	Tue, 11 Jun 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124600; cv=none; b=qGGjVce40IMSzUFDp+KLtpmqi/rAWPlT3RYENDM/Atq3LPmmENojEtJsB2zef/FrwYVlcDQn/myABy/5THhOX8ezCfhYaK717XSaQ5mL93mDZLKXbfiXf+eUm57AZ6ipdt39boX+itomiOxt5LjGXjhEEI19PS0ps47eDhIDHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124600; c=relaxed/simple;
	bh=VhgJ5DKTDpf8FzXZJ+ysk6qnF1LRNTXZ5JT/SO2WlhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=saAA9939bEwd/qDQCOyH8YFKsAIp1jXgzvtrjQowJryCnd1FINRaa+9wjldYs2X6ZgVEdpqgFUVeGnmVMTy2sZoGnwbSm9ghCX0a/8GxTonpkSDHgFvqC8W2CH+XtZi4uRYekI8x3eyKEHLE3iTy2X/Ow0v8C0XyinQdt1QSYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBncIaQd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBncIaQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718124599; x=1749660599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VhgJ5DKTDpf8FzXZJ+ysk6qnF1LRNTXZ5JT/SO2WlhM=;
  b=MBncIaQd2zK0BF4LT/qhdtXcIuuDwvB70eaOyBhg/B+1Hf5NuuJnibmp
   zGr+dyF1oSSLnp0eFlm//sz215v/yaDi5tvlqE5kzYTMCXTNZ22r9n534
   qF+rXtE2wMhqr3nCM4pSowE6Afou7maCuf+Vlp3vALva2DvvO1pRdYflr
   qnweGL0MluhMI7abH6Aw8eTI9WIqxFxceQ3vOYorOeQxi/KDwfX3d54x+
   Aa/RVFCevaZR0nkFqyymDFYVJSykWT1RNMIlm0r505SQ7p+5sW+0DX8dB
   6HrNv73y1GzHERNuBQsdRs7XD27EvIcvPfbmwPa8e9n0hOLCbvDTZYAzX
   g==;
X-CSE-ConnectionGUID: fJK4x0BLS2m/GbvfArpXvQ==
X-CSE-MsgGUID: XBjuSXwUSLi99rVSruTxsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40249642"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40249642"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:49:58 -0700
X-CSE-ConnectionGUID: TBUKbUKRQBSgYUz7/pGCHQ==
X-CSE-MsgGUID: y4MRJ4dbRUeLniGI4pMmUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40103306"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa008.jf.intel.com with ESMTP; 11 Jun 2024 09:49:58 -0700
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
Subject: [PATCH v2 3/6] x86/irq: Factor out common NMI handling code
Date: Tue, 11 Jun 2024 09:54:54 -0700
Message-Id: <20240611165457.156364-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
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
index 1ebe93edba7a..639a34e78bc9 100644
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

