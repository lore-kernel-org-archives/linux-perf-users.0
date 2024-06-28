Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA978281;
	Fri, 28 Jun 2024 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605614; cv=none; b=rrZ33OBNpuRBAxSYzww5zuTZxB1/mFkHahB9jsWr9btET9CbEIQpzIW8fvOdktKoAcWM6a5oSJRBCxfB3MrF7aIfDqQMPluy1FIzkHHD+EA5rECHIuAAhHvmNarErbXPbRxVFqPPAwU59PocUaOMcoiMQvueMpUgaPYDCygiGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605614; c=relaxed/simple;
	bh=VhgJ5DKTDpf8FzXZJ+ysk6qnF1LRNTXZ5JT/SO2WlhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uR16I9ZBEzOs4z5b0JojDIczK0sEKNMgLyL4U5Q0XbE3EOew0lMe9fzp9DjY8hq7BURPxaPNRGG+YWs1s6rIlZXS4a40wQ56BSr1n/xI8vvt6jOd9BETqfOokJba+VPSMZy0XZBOJ/M4GaPpYN2UhgBcZ6YXpJ3uYJUkfbt523I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlpjvjM3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlpjvjM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605613; x=1751141613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VhgJ5DKTDpf8FzXZJ+ysk6qnF1LRNTXZ5JT/SO2WlhM=;
  b=UlpjvjM3v+uId5QgfTvTPw6zF7H7axFuKBJlN7PC1GRScSuhA5Jduwyz
   ifV/pVfZ7E72hl8IfGamyYLt7ulCs7Gsh+H3lhW4sFsM8UkQ8yHgyHwvn
   KAVt/4oQhtMCFsshOxtCrnXRXAGwaaDhZiqP5sUt1v9GzI7S7Y9SdqZoO
   0D5vIRoteEa4vwA0roobCw6Eq0MlwATIiWzHSLfcPZIybLxY0g12cSpqo
   7483p3ZaUiU6RaK/zx5OVgtYB/jkWhI11qP+baLwzXDPLY7b+UZ9+u/aP
   iY5t+4ye/giYk5GSztD3pttMjZy2cQ/of+VcEQj/4eBiK2s+MklAFao8z
   w==;
X-CSE-ConnectionGUID: ZJrhWwTAQjGcnkYxQm02/w==
X-CSE-MsgGUID: uD8Zu7OhRjWB1WGnDUuG8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12306996"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12306996"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:31 -0700
X-CSE-ConnectionGUID: PTJFqZLRTyW7yWy2U7TViA==
X-CSE-MsgGUID: SR60AZVeSpa+clu/LzHgfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312580"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Xin Li" <xin3.li@intel.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	acme@kernel.org,
	kan.liang@linux.intel.com,
	Andi Kleen <andi.kleen@intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 04/11] x86/irq: Factor out common NMI handling code
Date: Fri, 28 Jun 2024 13:18:32 -0700
Message-Id: <20240628201839.673086-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
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

