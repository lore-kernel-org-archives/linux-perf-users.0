Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F62E8B96;
	Thu, 25 Sep 2025 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780864; cv=none; b=kgTpK7IAQQwONj/Oec4rQsu703Z6RkRqALuYgsOpVbIuZWOLoDgJwvxy3YhKW0T8ZX5VPYW5KEfgp7+w5e1fzz30KpDjEQzo1hL4Tu2s1qFY/HhC2sScDhCuqE6J1tdtXbJ2JspZXl0OHW4kH4NYacAzMDwEXClAm8z1BNXw8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780864; c=relaxed/simple;
	bh=73rRDPOsJT3cODBZ1vTdZ/565gIVbG9t2DSJXUQYCmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkVli/gfYvzrRKoG6l4xZhze5S6WPbzFCkXxynotISq19c13PLMhNoEAVYQ/29Jfb0z4oWkJPLR/ZnuMZ7OlJRYlotpZoKIAHtm7imaXcN8TKxrRYF/FzZKy6fhsCSI02Rpu9utGGgFE5iRaG4qH2GsI4I05efSNX/TypxSWwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kI1IlVOn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kI1IlVOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780863; x=1790316863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73rRDPOsJT3cODBZ1vTdZ/565gIVbG9t2DSJXUQYCmo=;
  b=kI1IlVOnbAKrjvD4Dr8R9e4UZ87a1E7A4nyMa3oLZPqxBmWOWwimqkOh
   U9mkNb1oHm9HIM7mCmwyinWxWRaOP9QKC7WZgq1hwJc7hgk687jeleTtH
   zCHoeG4+t2Moa2W97cF8bbwPZ7MDXcgH8CNAS1KDIk5N8/lap7lRLE3NH
   +t6wutLQp6gonNE9pa6yvOE1sVfclbKK71/I4YAsO9Wj6MODJy6BM8rOg
   YHdrezeNMBu3XO/GanbNCoRlClRO3ONoevnUdpQiTAicLec4h7fhp+vhz
   jcer4TM7H/sgK2nbXY1cxUvp9H4BxsUqjDvSpgZ9WQ+0FF3iLVIdzn0B/
   g==;
X-CSE-ConnectionGUID: iIsFff5EQDadROxjW2E61A==
X-CSE-MsgGUID: 3vaasjN6QgW3lD05pqvo5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139500"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139500"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:22 -0700
X-CSE-ConnectionGUID: ciWD4v70SX+oYfBYM0vj1w==
X-CSE-MsgGUID: G3fFtTAzS56daeEMqmRAyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528291"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:17 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 02/17] perf/x86: Setup the regs data
Date: Thu, 25 Sep 2025 14:11:58 +0800
Message-Id: <20250925061213.178796-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current code relies on the generic code to setup the regs data.
It will not work well when there are more regs introduced.
Introduce a X86-specific x86_pmu_setup_regs_data().
Now, it's the same as the generic code. More X86-specific codes will be
added later when the new regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 32 ++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c   |  4 +++-
 arch/x86/events/perf_event.h |  4 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f4afef16cbab..92678f61f819 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1685,6 +1685,38 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs)
+{
+	u64 sample_type = event->attr.sample_type;
+
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (user_mode(regs)) {
+			data->regs_user.abi = perf_reg_abi(current);
+			data->regs_user.regs = regs;
+		} else if (!(current->flags & PF_KTHREAD)) {
+			perf_get_regs_user(&data->regs_user, regs);
+		} else {
+			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
+			data->regs_user.regs = NULL;
+		}
+		data->dyn_size += sizeof(u64);
+		if (data->regs_user.regs)
+			data->dyn_size += hweight64(event->attr.sample_regs_user) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_USER;
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		data->regs_intr.regs = regs;
+		data->regs_intr.abi = perf_reg_abi(current);
+		data->dyn_size += sizeof(u64);
+		if (data->regs_intr.regs)
+			data->dyn_size += hweight64(event->attr.sample_regs_intr) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
+	}
+}
+
 int x86_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..e67d8a03ddfe 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2126,8 +2126,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			regs->flags &= ~PERF_EFLAGS_EXACT;
 		}
 
-		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
+		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 			adaptive_pebs_save_regs(regs, gprs);
+			x86_pmu_setup_regs_data(event, data, regs);
+		}
 	}
 
 	if (format_group & PEBS_DATACFG_MEMINFO) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2b969386dcdd..12682a059608 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1278,6 +1278,10 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs);
+
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
 static inline int x86_pmu_num_counters(struct pmu *pmu)
-- 
2.34.1

