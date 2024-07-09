Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70519CCF0;
	Tue,  9 Jul 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535638; cv=none; b=dKJDNdxVXdAf6LzFoZ90aEffVi/DncDTOZHiQW+mTCdRwUEAgOUY2NZhBBLvqQHpf5bCIB3UCGofT9LJdswPRDFyR6Szdzjmbw+qWnxwcpoA2DrH2uvbgPLD3XMMRwY3AQs9DCT05CFvp5KNfHEIKOtOWnPGzDzVVJutXQMiPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535638; c=relaxed/simple;
	bh=OblXt4pwVEhCx1xGm8ZrsCUVLZmRk65ahm6MgN/kkjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUTTJaqPa48Xi7jGiSxUxAWkO17WNG6eK+oS/n8bjkoaOh4COGpSfta4HjIKlLnRhbBLgMYbcGOmcJ/wK372r3Wt2L9fLRkbhvEBNB62ALj82eIhhP/8RopAa3km15T5wDDAFZe2/SL6aVD53WRI30bNL+IYczAyF6kyVIPglHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4R7oyIt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4R7oyIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535636; x=1752071636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OblXt4pwVEhCx1xGm8ZrsCUVLZmRk65ahm6MgN/kkjs=;
  b=m4R7oyItFrnz7j16jTU2mOtLjw40KpuAUA65Zql2GAlS1a/1+ldY1aHG
   8MSsfJnlA63B5AMCJxV5iuos/gKsheZk6SmiFhiWv1JOzhlILy0TAeiH4
   jncC5t083vHnaSZXKXFRqhZh6+ndXej9E0pC2OGAJ8wbKPi3j5EkIt2Fr
   TRH/cSerJzjyBennkOrzqbjT2uPiWR9arjarklmKXF6wZ0iwyLFruCPn+
   ZZU0qk4Zsrt0LRZKgGz4i+fzULEpgZMz7BMaOR+Yk/JNT81kjRlNMgTKy
   tGgPgwU+ttFw/T5BFC05qQtDOlhxiR/v3MAZVk1cjeXqQgYzu0dvif074
   g==;
X-CSE-ConnectionGUID: Vhd3cyjwRZCY5BkBO57FDg==
X-CSE-MsgGUID: EpcVevfcTy6nhf5df2JF6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331374"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331374"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:54 -0700
X-CSE-ConnectionGUID: 0roRgyCSSkmHdPryONEexg==
X-CSE-MsgGUID: gTjWW+k6TVaWRolY+ro0HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272095"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:54 -0700
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
	Nikolay Borisov <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 04/11] x86/irq: Factor out common NMI handling code
Date: Tue,  9 Jul 2024 07:38:59 -0700
Message-Id: <20240709143906.1040477-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for handling NMIs with explicit source reporting, factor
out common code for reuse. No functional change.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/nmi.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 5491b460f32b..b96667eed106 100644
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

