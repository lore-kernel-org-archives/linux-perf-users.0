Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C323E557A;
	Mon, 14 Sep 2026 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426026; cv=none; b=JUXGqi13WMKOVjojrWHj6+YvzbpZtYsXN8dfThltwZLFOJ9uQu3pSyBnEyZrjsMVakbrgNMrhMzRzQKlSDdiznm5Kg0vfRqTOgRI/LgR1M8tSAXDfW8YBrxwvYJpBJ8O4/QUhebSjAizMVPPJ2nPWw82xvCa4nL7GM3opgO7IQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426026; c=relaxed/simple;
	bh=HN9oaeewHji3EOcKW0dO64n2Hx4qzMpVscvlVZkLA/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irvoIPE6tIs9cRNYH9bFgc+lcFTGRd3Bn4+WCL+xUVmQHJUdn0mC/Oi6rKwxJj3tWXSxTrYJIg98Qn/BLjvtxo7/Xu8Pt0qb3kIfJGbPdPPIosqlUZ2VVLCzpj7vYl5dwwkFRPhnKx8zjqK41vvki58HJNuk07lFix7669SHqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIW6Ykmz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIW6Ykmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789426025; x=1820962025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HN9oaeewHji3EOcKW0dO64n2Hx4qzMpVscvlVZkLA/M=;
  b=QIW6YkmzxRTz6YX78YNKe6verqGeC/DVTOC831QASvb9yEuS7DA54q9d
   RUYX/61GOGPt0X6oRf3z9Azsc/XtmG1YAcRDWirhsDhUXQzjS9uzpq6yq
   F21VfEhm9P56UGHirLCq5/HORaww2rSpdg4GEa1Pptce2alVjqZJguaGz
   ZJXjqUMQmzjkM1rjD3Rr8BC8LWXugYpLum+GJJd1SfmiM6P+6FpkxKr+d
   goJEekRq/y5T1leMJsXtqC2+pmfqWuDWbggYwmpp+ZBzfuqhndeIeJLSx
   jwu73EOF0AC1sJJUt4ufCDc7NJ+zV7I7iFWlYEAL3uSowD6Hg83qBeAJt
   g==;
X-CSE-ConnectionGUID: WCiljDgAScmZW/glvL9HDQ==
X-CSE-MsgGUID: F3jOTzbORhuKI7ppUEQisw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93483241"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93483241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:47:05 -0700
X-CSE-ConnectionGUID: aG8tmsTuT6KybAubJ1yWpQ==
X-CSE-MsgGUID: ZXMIpklEQzGqJb7eCgCDww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268480110"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.56])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:47:04 -0700
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
Subject: [PATCH v9 5/6] perf tools: Show memory region in perf-script subcommand
Date: Mon, 14 Sep 2026 17:46:49 -0500
Message-ID: <20260914224650.52982-6-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914224650.52982-1-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
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
v8: Update developer tags and commit message with real example output
v4: Drop the global show-region flag; pass perf_session to
    perf_script__meminfo_scnprintf() and gate the Region field
    on the feature bit, with a pipe-mode fallback
v3: make memory region reporting conditional on feature bit
---
 tools/perf/builtin-script.c                   | 13 +--
 tools/perf/util/mem-events.c                  | 86 ++++++++++++++++++-
 tools/perf/util/mem-events.h                  |  4 +-
 .../scripting-engines/trace-event-python.c    |  5 +-
 4 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ad8ca08ceb5f..c7454155038d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2078,11 +2078,12 @@ static int evlist__max_name_len(struct evlist *evlist)
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
 
@@ -2090,10 +2091,10 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
 		return -ENOMEM;
 
 	mem_info__data_src(mi)->val = data_src;
-	perf_script__meminfo_scnprintf(decode, 100, mi);
+	perf_script__meminfo_scnprintf(decode, 200, mi, session);
 	mem_info__put(mi);
 
-	len = scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
+	len = scnprintf(out, 200, "%16" PRIx64 " %s", data_src, decode);
 	if (maxlen < len)
 		maxlen = len;
 
@@ -2487,7 +2488,7 @@ static void process_event(struct perf_script *script,
 		perf_sample__fprintf_addr(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(DATA_SRC))
-		data_src__fprintf(sample->data_src, fp);
+		data_src__fprintf(evsel__session(evsel), sample->data_src, fp);
 
 	if (PRINT_FIELD(WEIGHT))
 		fprintf(fp, "%16" PRIu64, sample->weight);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 4fd48fd20055..8ce4996cad8d 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -604,8 +604,77 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
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
@@ -620,6 +689,21 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
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
index daa22748f9fe..4ebb8109fc3c 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <linux/types.h>
+#include "session.h"
 
 struct perf_mem_event {
 	bool		supported;
@@ -47,7 +48,8 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
 int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
 
-int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct mem_info *mem_info);
+int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct mem_info *mem_info,
+				   struct perf_session *session);
 
 struct c2c_stats {
 	u32	nr_entries;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 7e8e3a7df1b1..01ba37ea5edd 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -694,8 +694,9 @@ static void set_sample_read_in_dict(PyObject *dict_sample, struct perf_sample *s
 static void set_sample_datasrc_in_dict(PyObject *dict,
 				      struct perf_sample *sample)
 {
+	struct perf_session *session = evsel__session(sample->evsel);
 	struct mem_info *mi = mem_info__new();
-	char decode[100];
+	char decode[200];
 
 	if (!mi)
 		Py_FatalError("couldn't create mem-info");
@@ -704,7 +705,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 			PyLong_FromUnsignedLongLong(sample->data_src));
 
 	mem_info__data_src(mi)->val = sample->data_src;
-	perf_script__meminfo_scnprintf(decode, 100, mi);
+	perf_script__meminfo_scnprintf(decode, 200, mi, session);
 	mem_info__put(mi);
 
 	pydict_set_item_string_decref(dict, "datasrc_decode",
-- 
2.55.0

