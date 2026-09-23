Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4753B5ED;
	Wed, 23 Sep 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179038; cv=none; b=UcBRsbfnVIU52/tIXr/cvut49IvSSpVMgwJTTIukF15Tz345EYQSDiA6N+GOnyG8BSvLiOSHNJjFN6ptluU5E3jKivqpeXXmnQei5Yk83+d51qiRlN2aDZy2K0SLvvmdsswh32VQYFgk3D+2gclNbmad2tVwR6lTF165FOnPuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179038; c=relaxed/simple;
	bh=6k189w7XrbI/Va4FjAoq4zQSBBJLUUZF0QLiETfL+oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTCh6gwYmVbQG9P7hBmcm9yZXYAzRalzJ5ZiGMWB0ed7it6KP4yx1nWkk9kfS/lmI3BjoFvTRyDIVAq8T5Xpo6pDl3hcfFTGDcZA1a4MkehicvDTKJWYrdE1+V9PJguyyIRW3NDc7W554KvgkR8/D/Qo9nr/2HM7QLowS0hjMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjoRwurz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjoRwurz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790179035; x=1821715035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6k189w7XrbI/Va4FjAoq4zQSBBJLUUZF0QLiETfL+oo=;
  b=NjoRwurzAfWRh97OyplLwClqKliM+LcgSxNhjIlpI0GtwWjPphHLMZn6
   RISeeA84Lq59tpOx1LR0LFbOTjBqDvHv7X65cbeLbmVcVS7TwbU4sNfGw
   7N/3sHm+YG9A9pme393p4Yfx1yC3li6hQKPBFkbU4Iqs+f/HMArTqLbPF
   zAuSam6mXlRYB5aWav/hwrW6ADuI06aU9+ffpd+aWpvg5NSX6xjJvvEr5
   9/0M4ITMIksPy2eA0UaGCC55r/dxy/2YCWTSaakVS14eIUmB5II2rMV4/
   yO6//AeSqs44uW+pj25wxDfwgJ2sxtj3UClYSSga+a9/FoZ3bStRaeISR
   A==;
X-CSE-ConnectionGUID: HahctLdmSYeBHARpQo5EOw==
X-CSE-MsgGUID: dcDywuYkTCi4xnvffACSQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78445977"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78445977"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:13 -0700
X-CSE-ConnectionGUID: Todp312MRCyBx7Suw8y7WQ==
X-CSE-MsgGUID: jVyNGSDTQg6XZIV67xWjgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4935338"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:13 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v11 5/6] perf tools: Show memory region in perf-script subcommand
Date: Wed, 23 Sep 2026 10:57:02 -0500
Message-ID: <20260923155703.34814-6-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923155703.34814-1-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
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

      thread 5/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-shared-cache              ffffffff9f002aba
      thread 2/0 ...	|OP LOAD|LVL L3 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-shared-cache              ffffffff9dc54c95
      thread 8/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Other-non-shared-cache          ffffffff9dc54db3
      thread 0/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  Addr|Region N/A                       ffffffff9dc54db3
      thread 2/0 ...	|OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region N/A                            ffffffff9f002a8c
      thread 0/0 ...	|OP LOAD|LVL L3 hit|SNP HitM or Fwd|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-non-shared-cache   ffffffff9f002aba
      thread 0/0 ...	|OP LOAD|LVL L3 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-shared-cache          ffffffff9dc54ca7
     thread 30/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region N/A                       ffffffff9dcc1ff2
     thread 30/0 ...	|OP LOAD|LVL RAM hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Mem-0                          ffffffff9dc54c95
     thread 19/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region N/A                        ffffffff9f002cbb
     thread 19/0 ...	|OP LOAD|LVL L3 hit|SNP HitM or Fwd|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-non-shared-cache   ffffffff9f002aba

[1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/

Assisted-by: Sashiko:gemini-3.1-pro-preview
Assisted-by: GitHub-Copilot:claude-opus-4-8
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v10: use a forward declaration of struct perf_session in mem-events.h
     instead of including session.h; include session.h directly where
     needed (Sashiko)
v8: Update developer tags and commit message with real example output
v4: Drop the global show-region flag; pass perf_session to
    perf_script__meminfo_scnprintf() and gate the Region field
    on the feature bit, with a pipe-mode fallback
v3: make memory region reporting conditional on feature bit
---
 tools/perf/builtin-script.c                   | 13 +--
 tools/perf/util/mem-events.c                  | 87 ++++++++++++++++++-
 tools/perf/util/mem-events.h                  |  4 +-
 .../scripting-engines/trace-event-python.c    |  6 +-
 4 files changed, 100 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0174489d1c0f..565ee8d55f80 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2153,11 +2153,12 @@ static int evlist__max_name_len(struct evlist *evlist)
 	return max;
 }
 
-static int data_src__fprintf(u64 data_src, FILE *fp)
+static int data_src__fprintf(struct perf_session *session,
+			     u64 data_src, FILE *fp)
 {
 	struct mem_info *mi = mem_info__new();
-	char decode[100];
-	char out[100];
+	char decode[200];
+	char out[200];
 	static int maxlen;
 	int len;
 
@@ -2165,10 +2166,10 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
 		return -ENOMEM;
 
 	mem_info__data_src(mi)->val = data_src;
-	perf_script__meminfo_scnprintf(decode, 100, mi);
+	perf_script__meminfo_scnprintf(decode, 200, mi, session);
 	mem_info__put(mi);
 
-	len = scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
+	len = scnprintf(out, 200, "%16" PRIx64 " %s", data_src, decode);
 	if (maxlen < len)
 		maxlen = len;
 
@@ -2562,7 +2563,7 @@ static void process_event(struct perf_script *script,
 		perf_sample__fprintf_addr(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(DATA_SRC))
-		data_src__fprintf(sample->data_src, fp);
+		data_src__fprintf(evsel__session(evsel), sample->data_src, fp);
 
 	if (PRINT_FIELD(WEIGHT))
 		fprintf(fp, "%16" PRIu64, sample->weight);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 4fd48fd20055..0cdcb47647bd 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -17,6 +17,7 @@
 #include "symbol.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "session.h"
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
@@ -604,8 +605,77 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	return l;
 }
 
-int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
+static int perf_mem__region_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
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
+		l += scnprintf(out + l, sz - l, "N/A");
+		break;
+	case PERF_MEM_REGION_L_SHARE:
+		l += scnprintf(out + l, sz - l, "Local-shared-cache");
+		break;
+	case PERF_MEM_REGION_L_NON_SHARE:
+		l += scnprintf(out + l, sz - l, "Local-non-shared-cache");
+		break;
+	case PERF_MEM_REGION_O_IO:
+		l += scnprintf(out + l, sz - l, "Other-IO");
+		break;
+	case PERF_MEM_REGION_O_SHARE:
+		l += scnprintf(out + l, sz - l, "Other-shared-cache");
+		break;
+	case PERF_MEM_REGION_O_NON_SHARE:
+		l += scnprintf(out + l, sz - l, "Other-non-shared-cache");
+		break;
+	case PERF_MEM_REGION_MMIO:
+		l += scnprintf(out + l, sz - l, "MMIO");
+		break;
+	case PERF_MEM_REGION_MEM0:
+		l += scnprintf(out + l, sz - l, "Mem-0");
+		break;
+	case PERF_MEM_REGION_MEM1:
+		l += scnprintf(out + l, sz - l, "Mem-1");
+		break;
+	case PERF_MEM_REGION_MEM2:
+		l += scnprintf(out + l, sz - l, "Mem-2");
+		break;
+	case PERF_MEM_REGION_MEM3:
+		l += scnprintf(out + l, sz - l, "Mem-3");
+		break;
+	case PERF_MEM_REGION_MEM4:
+		l += scnprintf(out + l, sz - l, "Mem-4");
+		break;
+	case PERF_MEM_REGION_MEM5:
+		l += scnprintf(out + l, sz - l, "Mem-5");
+		break;
+	case PERF_MEM_REGION_MEM6:
+		l += scnprintf(out + l, sz - l, "Mem-6");
+		break;
+	case PERF_MEM_REGION_MEM7:
+		l += scnprintf(out + l, sz - l, "Mem-7");
+		break;
+	default:
+		l += scnprintf(out + l, sz - l, "N/A");
+		break;
+	}
+
+	return l;
+}
+
+int perf_script__meminfo_scnprintf(char *out, size_t sz,
+				   const struct mem_info *mem_info,
+				   struct perf_session *session)
+{
+	struct perf_env *env;
 	int i = 0;
 
 	i += scnprintf(out, sz, "|OP ");
@@ -620,6 +690,21 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|BLK ");
 	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
+	if (session) {
+		/*
+		 * In case the feature bits are not available, as in
+		 * pipe mode, fallback to checking for the existence of
+		 * memory ranges
+		 */
+		env = perf_session__env(session);
+		if ((env && session->data->is_pipe && env->nr_memory_ranges) ||
+		    perf_header__has_feat(&session->header,
+					  HEADER_MEMORY_RANGES)) {
+			i += scnprintf(out + i, sz - i, "|Region ");
+			i += perf_mem__region_scnprintf(out + i, sz - i,
+							mem_info);
+		}
+	}
 
 	return i;
 }
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index daa22748f9fe..38b14c03392c 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -24,6 +24,7 @@ enum {
 struct evsel;
 struct mem_info;
 struct perf_pmu;
+struct perf_session;
 
 extern unsigned int perf_mem_events__loads_ldlat;
 extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
@@ -47,7 +48,8 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
 int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
 
-int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct mem_info *mem_info);
+int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct mem_info *mem_info,
+				   struct perf_session *session);
 
 struct c2c_stats {
 	u32	nr_entries;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 239104b0337d..038c4268a429 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -58,6 +58,7 @@
 #include "stat.h"
 #include "mem-events.h"
 #include "util/perf_regs.h"
+#include "util/session.h"
 
 #define _PyUnicode_FromString(arg) \
   PyUnicode_FromString(arg)
@@ -694,8 +695,9 @@ static void set_sample_read_in_dict(PyObject *dict_sample, struct perf_sample *s
 static void set_sample_datasrc_in_dict(PyObject *dict,
 				      struct perf_sample *sample)
 {
+	struct perf_session *session = evsel__session(sample->evsel);
 	struct mem_info *mi = mem_info__new();
-	char decode[100];
+	char decode[200];
 
 	if (!mi)
 		Py_FatalError("couldn't create mem-info");
@@ -704,7 +706,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 			PyLong_FromUnsignedLongLong(sample->data_src));
 
 	mem_info__data_src(mi)->val = sample->data_src;
-	perf_script__meminfo_scnprintf(decode, 100, mi);
+	perf_script__meminfo_scnprintf(decode, 200, mi, session);
 	mem_info__put(mi);
 
 	pydict_set_item_string_decref(dict, "datasrc_decode",
-- 
2.43.0

