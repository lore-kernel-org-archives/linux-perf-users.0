Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C643054E4;
	Fri, 24 Oct 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296203; cv=none; b=rwMYLjYzCITV5jGcpFteW+1dBdaki9MK73h1AElUTjcDZ2t5tCSPiWsydcPnp2+0z9TKp3l4wIjr0p6lWyyCpta3Bxm8kZqIsQbNygGmjw7zd5LjyIwK9XRTfuUyC0+Q4GrhvJGqg2q3FI2c+dAyomEIm4/AfaSWMmYP0qnqECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296203; c=relaxed/simple;
	bh=VYSh5fqGEIj/C1Iblq5SwRpKBRa+LPEXqlDAO+XLsEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVzuTJ2HOHYnuVW+kr8rqVxQCHjIspTYsXJGSFBWidrK1JPh2eahVuWWfL2qepBAuu8pl/om73xYKJe/LeRe8r8CSWI0rKTdaKc7BhRymRdLIVQoolgJFzI9WlfJo79SOiKjKcyIjND1BCI+VeSPv7DRd98bbiYzyBhMwePMWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5533045ab0b711f0a38c85956e01ac42-20251024
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:e88689e8-884b-4a02-8c6c-73facf1312d1,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:3487dba6b5cd38bbae0950f70bca160f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5533045ab0b711f0a38c85956e01ac42-20251024
X-User: tanze@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 498110973; Fri, 24 Oct 2025 16:56:30 +0800
From: tanze <tanze@kylinos.cn>
To: leo.yan@arm.com,
	adrian.hunter@intel.com,
	namhyung@kernel.org,
	mingo@redhat.com
Cc: graham.woodward@arm.com,
	irogers@google.com,
	james.clark@linaro.org,
	john.g.garry@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mike.leach@linaro.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH v3] perf auxtrace: Add auxtrace_synth_id_range_start() helper
Date: Fri, 24 Oct 2025 16:56:25 +0800
Message-Id: <20251024085625.175688-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid hardcoding the offset value for synthetic event IDs 
in multiple auxtrace modules (arm-spe, cs-etm, intel-pt, etc.), 
and to improve code reusability, this patch unifies 
the handling of the ID offset via a dedicated helper function.

Signed-off-by: tanze <tanze@kylinos.cn>
---

Hi Leo Yan, Adrian Hunter,

Thank you for your valuable comments. I have modified my code according to your suggestions.

Best regards,
Ze Tan 
---
Changes in v3: 
 - Removed PERF_SYNTH_EVENT_ID_OFFSET from synthetic-events.h
 - Added AUXTRACE_SYNTH_EVENT_ID_OFFSET macro in auxtrace.c
 - Introduced auxtrace_synth_id_range_start() helper function in auxtrace.c 
   to unify ID calculation
 - Updated all auxtrace modules to use the new helper function

Changes in v2: 
 - Migrated the macro definitions to the synthetic-events.h file
 - Added modifications to other source files that use the offset value

v2:
 -patch: https://lore.kernel.org/all/20251017021540.45930-1-tanze@kylinos.cn/

---
 tools/perf/util/arm-spe.c        |  5 +----
 tools/perf/util/auxtrace.c       | 16 ++++++++++++++++
 tools/perf/util/auxtrace.h       |  1 +
 tools/perf/util/cs-etm.c         |  5 +----
 tools/perf/util/intel-bts.c      |  4 +---
 tools/perf/util/intel-pt.c       |  4 +---
 tools/perf/util/powerpc-vpadtl.c |  4 +---
 7 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 71be979f5077..4fd47600d9e4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1732,10 +1732,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.sample_period = spe->synth_opts.period;
 
 	/* create new id val to be a fixed offset from evsel id */
-	id = evsel->core.id[0] + 1000000000;
-
-	if (!id)
-		id = 1;
+	id = auxtrace_synth_id_range_start(evsel);
 
 	if (spe->synth_opts.flc) {
 		spe->sample_flc = true;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 1539c1dc823c..35f4745f6b2b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -62,6 +62,22 @@
 #include <internal/lib.h>
 #include "util/sample.h"
 
+#define AUXTRACE_SYNTH_EVENT_ID_OFFSET	1000000000ULL
+
+/*
+ * Event IDs are allocated sequentially, so a big offset from any
+ * existing ID will reach a unused range.
+ */
+u64 auxtrace_synth_id_range_start(struct evsel *evsel)
+{
+	u64 id = evsel->core.id[0] + AUXTRACE_SYNTH_EVENT_ID_OFFSET;
+
+	if (!id)
+		id = 1;
+
+	return id;
+}
+
 /*
  * Make a group from 'leader' to 'last', requiring that the events were not
  * already grouped to a different leader.
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e0a5b39fed12..ed3a1aaaf5d9 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -648,6 +648,7 @@ void auxtrace__free_events(struct perf_session *session);
 void auxtrace__free(struct perf_session *session);
 bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 				 struct evsel *evsel);
+u64 auxtrace_synth_id_range_start(struct evsel *evsel);
 
 #define ITRACE_HELP \
 "				i[period]:    		synthesize instructions events\n" \
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 30f4bb3e7fa3..62812bef1edf 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1726,10 +1726,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 	attr.read_format = evsel->core.attr.read_format;
 
 	/* create new id val to be a fixed offset from evsel id */
-	id = evsel->core.id[0] + 1000000000;
-
-	if (!id)
-		id = 1;
+	id = auxtrace_synth_id_range_start(evsel);
 
 	if (etm->synth_opts.branches) {
 		attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 3625c6224750..382255393fb3 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -777,9 +777,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
 
-	id = evsel->core.id[0] + 1000000000;
-	if (!id)
-		id = 1;
+	id = auxtrace_synth_id_range_start(evsel);
 
 	if (bts->synth_opts.branches) {
 		attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9b1011fe4826..fc9eec8b54b8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3987,9 +3987,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
 
-	id = evsel->core.id[0] + 1000000000;
-	if (!id)
-		id = 1;
+	id = auxtrace_synth_id_range_start(evsel);
 
 	if (pt->synth_opts.branches) {
 		attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index 39a3fb3f1330..bfa4156d7a97 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -656,9 +656,7 @@ powerpc_vpadtl_synth_events(struct powerpc_vpadtl *vpa, struct perf_session *ses
 	attr.config = PERF_SYNTH_POWERPC_VPA_DTL;
 
 	/* create new id val to be a fixed offset from evsel id */
-	id = evsel->core.id[0] + 1000000000;
-	if (!id)
-		id = 1;
+	id = auxtrace_synth_id_range_start(evsel);
 
 	err = perf_session__deliver_synth_attr_event(session, &attr, id);
 	if (err)
-- 
2.25.1

