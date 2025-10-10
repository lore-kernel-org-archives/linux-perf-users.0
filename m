Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEF276046;
	Fri, 10 Oct 2025 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082005; cv=none; b=b7TbzbGPkqnRiuUYqAatXBvGnyRy/BdFX0q1n5YVfOzxraSMJrsK78vyM1kjcsrGMdsnG4+ZYyh6ogM7U9kQlPfinv2zRzABXq5kNJPsj3gj2CQxiBA7phLH0lvC5hYtHcPBIQKOOJKxUVkaSRCcRIB51Lpyh46hkD2g9BruhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082005; c=relaxed/simple;
	bh=awfB6gUtABAJgO+86Dp+28VsRaf6irAuHPkgajoXnUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtCnbIglLQYqdObapwyHsjo2RSLyG3QKNyIinjM/9uvbvmJMY7hAsHCsBFoJAPyfAJbyxaHnimnE/Vp/u2b4OTntuUaALKAz+o9hMeoPVfzKTDx2kpnBa05/tUmCjO5RCRnWuTNrNJiyCZe/8thlsgtNANHqqWyOoR4xLTL0Dmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+CbFOMv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+CbFOMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760082004; x=1791618004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awfB6gUtABAJgO+86Dp+28VsRaf6irAuHPkgajoXnUU=;
  b=C+CbFOMvogL5IbrIETxizaVDINHQRngEatMOzgzR94GvsTlQSVII0EUy
   0YdpINpAPFXXWRGdFihTG4YS7s2ghZaVX0uHJpq9xUdkMgFV9818WJ5gg
   Edi9a0zrlbBmShxzYvRWIWpY1YJesZRM8bHPWn91Abj+pIkE3+ocMQnHo
   fb3G2IpL8zUPDhdY1jBb7+jxHrAjS5qKBBHpG52+kOhdRCCPb2m9t3zO0
   AtB+9Ohwa2tuzMfu+9UM+BzcV+RzWmP58nL68sKbfAAQwOoea3rjb75YU
   +mpdsjgW71f+Jp5FukfX5Uf5AOLFV3/N1C3wuYD0BryB6YQvvluLJrR8t
   w==;
X-CSE-ConnectionGUID: dcLmo4KxSTW+FVa1MX3qiw==
X-CSE-MsgGUID: 1KYNNWJgRbCQeFs6mQX8xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79942297"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="79942297"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:40:03 -0700
X-CSE-ConnectionGUID: da5/aN40SNe0DkUZZQ1tig==
X-CSE-MsgGUID: X3wvg7i4R/Woipaub4fv9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180502322"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2025 00:39:58 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] perf tools annotate: Fix a crash/hang when switch disassemble and source view
Date: Fri, 10 Oct 2025 16:33:12 +0800
Message-ID: <20251010083313.1839179-2-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aOTOEcNOiUiEJ9tz@google.com>
References: <aOTOEcNOiUiEJ9tz@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf report with annotation, press 'TAB' to navigate among hot lines,
press 's' to switch on the source view, then press 'TAB' again, the perf
report could crash or hang. The 'nd' and 'browser->curr_hot' need to be
updated when switch the disassemble and source view.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
---
 tools/perf/ui/browsers/annotate.c | 35 ++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8fe699f98542..32da310b3b62 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -852,6 +852,30 @@ static void annotate_browser__debuginfo_warning(struct annotate_browser *browser
 	}
 }
 
+static u32 rb_node__get_idx_asm(struct rb_node *nd)
+{
+	struct annotation_line *al = NULL;
+
+	if (nd == NULL)
+		return 0;
+
+	al = rb_entry(nd, struct annotation_line, rb_node);
+
+	return al->idx_asm;
+}
+
+static struct rb_node *annotate_browser__rb_node_by_idx_asm(struct annotate_browser *browser,
+									u32 idx_asm)
+{
+	struct annotation_line *al = NULL;
+
+	if (idx_asm == 0)
+		return NULL;
+
+	al = annotate_browser__find_new_asm_line(browser, idx_asm);
+	return al ? &al->rb_node : NULL;
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -969,8 +993,17 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			nd = browser->curr_hot;
 			break;
 		case 's':
-			if (annotate_browser__toggle_source(browser, evsel))
+			u32 idx_asm_nd = rb_node__get_idx_asm(nd);
+			u32 idx_asm_curr_hot = rb_node__get_idx_asm(browser->curr_hot);
+
+			if (annotate_browser__toggle_source(browser, evsel)) {
 				ui_helpline__puts(help);
+				/* Update the annotation browser's rb_tree, and reset the nd */
+				annotate_browser__calc_percent(browser, evsel);
+				nd = annotate_browser__rb_node_by_idx_asm(browser, idx_asm_nd);
+				browser->curr_hot = annotate_browser__rb_node_by_idx_asm(browser,
+							idx_asm_curr_hot);
+			}
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(browser, title, help);
 			continue;
-- 
2.47.1

