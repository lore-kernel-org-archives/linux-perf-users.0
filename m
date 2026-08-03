Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B108437451;
	Mon,  3 Aug 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789970; cv=none; b=aX3ul3Xbb5/cdZIhzdIrpCLaxnnBovYt5qcf7GQBSzCywjqBqmU8DbkFCLfdgA7W3YxQ1HjLJFYclpE0oeN+JgsO8HOPMlMK7lZIOjZ1bWe10oCuExU1pMswJEI0Q6wrH4njmXd88u2jcdoOkVNJ+EVhTQDa5tEp9C1WaFzTISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789970; c=relaxed/simple;
	bh=oCfOBagHesRimmkS05GsKh75YlmNFcbqLf2Tf/uvQOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIiCyr5/3jo+jSsym3pou8G6Pmpp63LYzrNVp2+ydw1mW3gNTqm+Ecu2Tg0dCYHmnp0nhXbAHmHW84AyWq185O7Pl2M/QT68w9ptjTe17LwF8bUlwcGyhQmVDNG1TWGtA1B7ZhjNzbbE3WSHqHHu+pIwHZiD60joJjA3G+fSZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIRAg19X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIRAg19X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785789970; x=1817325970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oCfOBagHesRimmkS05GsKh75YlmNFcbqLf2Tf/uvQOo=;
  b=FIRAg19XgMbPI5rT2kFICze8gJgE5z1BhHuEf469NCz5w9OcKnlBPqgO
   Wqyg8h7jXwbYEmzQuFXEcCh88vtnNzTqvFeNdgqBwdrUxEvV2XPF6ttZ1
   47AQrnyjeTpzyx3CIsTfOCNCHPgj7SOOFCeY4k1u8U5RoAubiqABusDrS
   T4F9DhpucsYEXS0MSlWpsyFB8D3K4zCjzLc1/uQldnOocBsvkW4yObbO/
   DZ8jnLHgxQbvuekVTxvu8v0PJk2OprApKz4sPDiCKLwYJ2Jq4akZRJyTW
   NCX+xhDib44GxX5SkKIGZMz58Ngg3Zkss09i1UIDXkH/tQVrolMZjZ+r9
   g==;
X-CSE-ConnectionGUID: j9UQzaybSN+wkeWa3sEPXQ==
X-CSE-MsgGUID: DGTNGtRUTf2AVk0XCyMC5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96927309"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="96927309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:46:08 -0700
X-CSE-ConnectionGUID: 4f/vDhE9RTKvrwg2f/O6cw==
X-CSE-MsgGUID: GHj8MxH5TxaQEOKIiVlEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="284702401"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:46:06 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v3 6/6] perf c2c: print memory region data with stdio output
Date: Mon,  3 Aug 2026 15:45:40 -0500
Message-ID: <20260803204540.100348-7-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803204540.100348-1-thomas.falcon@intel.com>
References: <20260803204540.100348-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print memory range data in perf-c2c subcommand. Only available in stdio
mode currently. If memory ranges are not supported or present, print
nothing.

Example output of perf c2c report --stdio:

=================================================
                  Memory Ranges
=================================================
Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id 0, remote region id 255
Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id 0, remote region id 255
Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id 1, remote region id 255
Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id 1, remote region id 255
Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id 1, remote region id 255

Assisted-by: Sashiko:gemini-3.1-pro-preview
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v3: Included examples of memory range output in commit message
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6954a48c60e4..ce825fe6dfc6 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2635,6 +2635,34 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
 
+
+static void print_memory_ranges_info(FILE *out, struct perf_session *session)
+{
+	struct perf_env *env = perf_session__env(session);
+	int nr_ranges = 0;
+
+	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
+		return;
+	nr_ranges = env->nr_memory_ranges;
+	if (nr_ranges == 0) {
+		pr_debug("No memory ranges found, skipping\n");
+		return;
+	}
+
+	fprintf(out, "\n");
+	fprintf(out, "=================================================\n");
+	fprintf(out, "                  Memory Ranges                  \n");
+	fprintf(out, "=================================================\n");
+
+	for (int i = 0; i < nr_ranges; i++) {
+		struct memory_range *r = &env->memory_ranges[i];
+
+		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, local region id %u, remote region id %u\n",
+			i, r->base, r->base + r->length - 1, r->node,
+			r->local_region_id, r->remote_region_id);
+	}
+}
+
 static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 {
 	setup_pager();
@@ -2648,6 +2676,8 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	if (c2c.stats_only)
 		return;
 
+	print_memory_ranges_info(out, session);
+
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
 	fprintf(out, "           Shared Data Cache Line Table          \n");
-- 
2.55.0

