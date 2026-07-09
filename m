Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97133E1216;
	Thu,  9 Jul 2026 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635478; cv=none; b=qEcJKILg9/oE8PWVBSkcII1hIbeT4HN2sduyL4iGy6kt+EZ6cMR0nipGck4t4Xa5sk9doSBNSwqaYGCDiyIJR4aVoc5KVqtC1DE+SwRbybnBeUrbOj2EmX5jcu3L6EQFwg5P1E69Sud90FInMGa7pfYwEeLvu55QlhhKq5r8SL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635478; c=relaxed/simple;
	bh=c+cvRzzMrEpG80iUfXIZjOZsDmHVKPU2COZuQp7Q5qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR9g5S6mzVJTGiyMB7DnVya5mxTw5Vbgzk8tBkgJMC5qxmybx8VL+yJZv1WQvV4BaCbiKN8cuMrA2qtkI6f55b76DIkGR5dTs/X6e2TwbePl+qp9iVlVu9TB20EljnhS8sapIgVwuZSmrvhe7ShuooqcfjuaWUgbz7MjtDJEjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bX7vJHdQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bX7vJHdQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635476; x=1815171476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+cvRzzMrEpG80iUfXIZjOZsDmHVKPU2COZuQp7Q5qc=;
  b=bX7vJHdQs+S+a5IAJMGUBLQdGFUQ5LTNKxrKcuhM4yGwLi4RvJhgj9s5
   rZ3er+Olfl4Qb5y2UDds/rcOaGNJ2N0n/KbkZAaD7kUAdChw6soO/E6pW
   myFaVp2zeCf/ewM5cG+BTWtgcx/1UMLkl1JHNlx14yNJXNG7flB3L3jKR
   5jHkvtuvm4Ceix1Oq354MJUunCu8BVFBjglJ5TtalNKE7AuoN9I/oRRn+
   hYfDYmUrsCLFpyNe0sG2uRoSSiVvyjOK1ssRwxTJGdtYz/5AAVpuABWEC
   WDcw4DljVP0NkAj546PfWgkWkBsXEGbwxJtwJSF4Vb4nRlCC7FLurv+xY
   g==;
X-CSE-ConnectionGUID: FGHCHrM+T7G+UiqWu9tkMA==
X-CSE-MsgGUID: IE1ymY/CRoWUyxf8D+rfVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88163389"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88163389"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:55 -0700
X-CSE-ConnectionGUID: kE4abhYHTeumL24p28TvkA==
X-CSE-MsgGUID: wUL/dlpeSoi24t+lEhvSfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259620901"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.97])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:53 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 4/6] perf tools: Show memory region in perf-script subcommand
Date: Thu,  9 Jul 2026 17:17:34 -0500
Message-ID: <20260709221736.33446-5-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709221736.33446-1-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Show the memory region in perf-script subcommand. Memory region is found
in the mem_region field of the memory information data source. This
field was included with the introduction of support for the Off-module
Response facility (OMR) [1] in Intel's Diamond Rapids and Nova Lake
Architectures.

An example of perf-script output with the new memory region field is shown
below:

random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK No|BLK  N/A|Region  Mem-1                          561de7f8910a
random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK No|BLK  N/A|Region  Mem-1                          561de7f8910a
random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0

[1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-script.c                   |  8 +--
 tools/perf/util/mem-events.c                  | 68 +++++++++++++++++++
 .../scripting-engines/trace-event-python.c    |  4 +-
 3 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f91d8b1fbd01..7ed13cf261f8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2081,8 +2081,8 @@ static int evlist__max_name_len(struct evlist *evlist)
 static int data_src__fprintf(u64 data_src, FILE *fp)
 {
 	struct mem_info *mi = mem_info__new();
-	char decode[100];
-	char out[100];
+	char decode[150];
+	char out[150];
 	static int maxlen;
 	int len;
 
@@ -2090,10 +2090,10 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
 		return -ENOMEM;
 
 	mem_info__data_src(mi)->val = data_src;
-	perf_script__meminfo_scnprintf(decode, 100, mi);
+	perf_script__meminfo_scnprintf(decode, 150, mi);
 	mem_info__put(mi);
 
-	len = scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
+	len = scnprintf(out, 150, "%16" PRIx64 " %s", data_src, decode);
 	if (maxlen < len)
 		maxlen = len;
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 4fd48fd20055..ff08f1fee0e3 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -604,6 +604,72 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	return l;
 }
 
+static int perf_mem__region_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
+{
+	size_t l = 0;
+	u64 mem = PERF_MEM_REGION_NA;
+
+	sz -= 1; /* -1 for null termination */
+	out[0] = '\0';
+
+	if (mem_info)
+		mem = mem_info__const_data_src(mem_info)->mem_region;
+
+	switch (mem) {
+	case PERF_MEM_REGION_NA:
+	case PERF_MEM_REGION_RSVD:
+		l += scnprintf(out + l, sz - l, " N/A");
+		break;
+	case PERF_MEM_REGION_L_SHARE:
+		l += scnprintf(out + l, sz - l, " Local-shared-cache");
+		break;
+	case PERF_MEM_REGION_L_NON_SHARE:
+		l += scnprintf(out + l, sz - l, " Local-non-shared-cache");
+		break;
+	case PERF_MEM_REGION_O_IO:
+		l += scnprintf(out + l, sz - l, " Other-IO");
+		break;
+	case PERF_MEM_REGION_O_SHARE:
+		l += scnprintf(out + l, sz - l, " Other-shared-cache");
+		break;
+	case PERF_MEM_REGION_O_NON_SHARE:
+		l += scnprintf(out + l, sz - l, " Other-non-shared-cache");
+		break;
+	case PERF_MEM_REGION_MMIO:
+		l += scnprintf(out + l, sz - l, " MMIO");
+		break;
+	case PERF_MEM_REGION_MEM0:
+		l += scnprintf(out + l, sz - l, " Mem-0");
+		break;
+	case PERF_MEM_REGION_MEM1:
+		l += scnprintf(out + l, sz - l, " Mem-1");
+		break;
+	case PERF_MEM_REGION_MEM2:
+		l += scnprintf(out + l, sz - l, " Mem-2");
+		break;
+	case PERF_MEM_REGION_MEM3:
+		l += scnprintf(out + l, sz - l, " Mem-3");
+		break;
+	case PERF_MEM_REGION_MEM4:
+		l += scnprintf(out + l, sz - l, " Mem-4");
+		break;
+	case PERF_MEM_REGION_MEM5:
+		l += scnprintf(out + l, sz - l, " Mem-5");
+		break;
+	case PERF_MEM_REGION_MEM6:
+		l += scnprintf(out + l, sz - l, " Mem-6");
+		break;
+	case PERF_MEM_REGION_MEM7:
+		l += scnprintf(out + l, sz - l, " Mem-7");
+		break;
+	default:
+		l += scnprintf(out + l, sz - l, " N/A");
+		break;
+	}
+
+	return l;
+}
+
 int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	int i = 0;
@@ -620,6 +686,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|BLK ");
 	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
+	i += scnprintf(out + i, sz - i, "|Region ");
+	i += perf_mem__region_scnprintf(out + i, sz - i, mem_info);
 
 	return i;
 }
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8f832ae316ca..4e93f9d2dc8e 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -695,7 +695,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 				      struct perf_sample *sample)
 {
 	struct mem_info *mi = mem_info__new();
-	char decode[100];
+	char decode[150];
 
 	if (!mi)
 		Py_FatalError("couldn't create mem-info");
@@ -704,7 +704,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 			PyLong_FromUnsignedLongLong(sample->data_src));
 
 	mem_info__data_src(mi)->val = sample->data_src;
-	perf_script__meminfo_scnprintf(decode, 100, mi);
+	perf_script__meminfo_scnprintf(decode, 150, mi);
 	mem_info__put(mi);
 
 	pydict_set_item_string_decref(dict, "datasrc_decode",
-- 
2.43.0

