From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/43] perf tools: Add processing of coresight metadata
Date: Tue, 23 Jan 2018 10:12:38 -0300
Message-ID: <20180123131251.28197-31-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tor Jeremiassen <tor@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tor Jeremiassen <tor@ti.com>

The auxtrace_info section contains metadata that describes the number of
trace capable CPUs, their ETM version and trace configuration, including
trace id values. This information is required by the trace decoder in
order to properly decode the compressed trace packets. This patch adds
code to read and parse this metadata, and store it for use in
configuring instances of the cs-etm trace decoder.

Co-authored-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Tor Jeremiassen <tor@ti.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1516211539-5166-4-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/cs-etm.h |   3 +
 2 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f47797101857..18894ee7aa0b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -102,12 +102,24 @@ static void cs_etm__free_events(struct perf_session *session)
 
 static void cs_etm__free(struct perf_session *session)
 {
+	int i;
+	struct int_node *inode, *tmp;
 	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 	cs_etm__free_events(session);
 	session->auxtrace = NULL;
 
+	/* First remove all traceID/CPU# nodes for the RB tree */
+	intlist__for_each_entry_safe(inode, tmp, traceid_list)
+		intlist__remove(traceid_list, inode);
+	/* Then the RB tree itself */
+	intlist__delete(traceid_list);
+
+	for (i = 0; i < aux->num_cpu; i++)
+		zfree(&aux->metadata[i]);
+
+	zfree(&aux->metadata);
 	zfree(&aux);
 }
 
@@ -151,15 +163,69 @@ static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
 	return timeless_decoding;
 }
 
+static const char * const cs_etm_global_header_fmts[] = {
+	[CS_HEADER_VERSION_0]	= "	Header version		       %llx\n",
+	[CS_PMU_TYPE_CPUS]	= "	PMU type/num cpus	       %llx\n",
+	[CS_ETM_SNAPSHOT]	= "	Snapshot		       %llx\n",
+};
+
+static const char * const cs_etm_priv_fmts[] = {
+	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
+	[CS_ETM_CPU]		= "	CPU			       %lld\n",
+	[CS_ETM_ETMCR]		= "	ETMCR			       %llx\n",
+	[CS_ETM_ETMTRACEIDR]	= "	ETMTRACEIDR		       %llx\n",
+	[CS_ETM_ETMCCER]	= "	ETMCCER			       %llx\n",
+	[CS_ETM_ETMIDR]		= "	ETMIDR			       %llx\n",
+};
+
+static const char * const cs_etmv4_priv_fmts[] = {
+	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
+	[CS_ETM_CPU]		= "	CPU			       %lld\n",
+	[CS_ETMV4_TRCCONFIGR]	= "	TRCCONFIGR		       %llx\n",
+	[CS_ETMV4_TRCTRACEIDR]	= "	TRCTRACEIDR		       %llx\n",
+	[CS_ETMV4_TRCIDR0]	= "	TRCIDR0			       %llx\n",
+	[CS_ETMV4_TRCIDR1]	= "	TRCIDR1			       %llx\n",
+	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
+	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
+	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
+};
+
+static void cs_etm__print_auxtrace_info(u64 *val, int num)
+{
+	int i, j, cpu = 0;
+
+	for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
+		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
+
+	for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {
+		if (val[i] == __perf_cs_etmv3_magic)
+			for (j = 0; j < CS_ETM_PRIV_MAX; j++, i++)
+				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
+		else if (val[i] == __perf_cs_etmv4_magic)
+			for (j = 0; j < CS_ETMV4_PRIV_MAX; j++, i++)
+				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
+		else
+			/* failure.. return */
+			return;
+	}
+}
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
+	struct int_node *inode;
+	unsigned int pmu_type;
 	int event_header_size = sizeof(struct perf_event_header);
 	int info_header_size;
 	int total_size = auxtrace_info->header.size;
-	int err = 0;
+	int priv_size = 0;
+	int num_cpu;
+	int err = 0, idx = -1;
+	int i, j, k;
+	u64 *ptr, *hdr = NULL;
+	u64 **metadata = NULL;
 
 	/*
 	 * sizeof(auxtrace_info_event::type) +
@@ -170,10 +236,117 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (total_size < (event_header_size + info_header_size))
 		return -EINVAL;
 
+	priv_size = total_size - event_header_size - info_header_size;
+
+	/* First the global part */
+	ptr = (u64 *) auxtrace_info->priv;
+
+	/* Look for version '0' of the header */
+	if (ptr[0] != 0)
+		return -EINVAL;
+
+	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
+	if (!hdr)
+		return -ENOMEM;
+
+	/* Extract header information - see cs-etm.h for format */
+	for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
+		hdr[i] = ptr[i];
+	num_cpu = hdr[CS_PMU_TYPE_CPUS] & 0xffffffff;
+	pmu_type = (unsigned int) ((hdr[CS_PMU_TYPE_CPUS] >> 32) &
+				    0xffffffff);
+
+	/*
+	 * Create an RB tree for traceID-CPU# tuple. Since the conversion has
+	 * to be made for each packet that gets decoded, optimizing access in
+	 * anything other than a sequential array is worth doing.
+	 */
+	traceid_list = intlist__new(NULL);
+	if (!traceid_list) {
+		err = -ENOMEM;
+		goto err_free_hdr;
+	}
+
+	metadata = zalloc(sizeof(*metadata) * num_cpu);
+	if (!metadata) {
+		err = -ENOMEM;
+		goto err_free_traceid_list;
+	}
+
+	/*
+	 * The metadata is stored in the auxtrace_info section and encodes
+	 * the configuration of the ARM embedded trace macrocell which is
+	 * required by the trace decoder to properly decode the trace due
+	 * to its highly compressed nature.
+	 */
+	for (j = 0; j < num_cpu; j++) {
+		if (ptr[i] == __perf_cs_etmv3_magic) {
+			metadata[j] = zalloc(sizeof(*metadata[j]) *
+					     CS_ETM_PRIV_MAX);
+			if (!metadata[j]) {
+				err = -ENOMEM;
+				goto err_free_metadata;
+			}
+			for (k = 0; k < CS_ETM_PRIV_MAX; k++)
+				metadata[j][k] = ptr[i + k];
+
+			/* The traceID is our handle */
+			idx = metadata[j][CS_ETM_ETMTRACEIDR];
+			i += CS_ETM_PRIV_MAX;
+		} else if (ptr[i] == __perf_cs_etmv4_magic) {
+			metadata[j] = zalloc(sizeof(*metadata[j]) *
+					     CS_ETMV4_PRIV_MAX);
+			if (!metadata[j]) {
+				err = -ENOMEM;
+				goto err_free_metadata;
+			}
+			for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
+				metadata[j][k] = ptr[i + k];
+
+			/* The traceID is our handle */
+			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
+			i += CS_ETMV4_PRIV_MAX;
+		}
+
+		/* Get an RB node for this CPU */
+		inode = intlist__findnew(traceid_list, idx);
+
+		/* Something went wrong, no need to continue */
+		if (!inode) {
+			err = PTR_ERR(inode);
+			goto err_free_metadata;
+		}
+
+		/*
+		 * The node for that CPU should not be taken.
+		 * Back out if that's the case.
+		 */
+		if (inode->priv) {
+			err = -EINVAL;
+			goto err_free_metadata;
+		}
+		/* All good, associate the traceID with the CPU# */
+		inode->priv = &metadata[j][CS_ETM_CPU];
+	}
+
+	/*
+	 * Each of CS_HEADER_VERSION_0_MAX, CS_ETM_PRIV_MAX and
+	 * CS_ETMV4_PRIV_MAX mark how many double words are in the
+	 * global metadata, and each cpu's metadata respectively.
+	 * The following tests if the correct number of double words was
+	 * present in the auxtrace info section.
+	 */
+	if (i * 8 != priv_size) {
+		err = -EINVAL;
+		goto err_free_metadata;
+	}
+
 	etm = zalloc(sizeof(*etm));
 
-	if (!etm)
+	if (!etm) {
 		err = -ENOMEM;
+		goto err_free_metadata;
+	}
 
 	err = auxtrace_queues__init(&etm->queues);
 	if (err)
@@ -182,6 +355,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->session = session;
 	etm->machine = &session->machines.host;
 
+	etm->num_cpu = num_cpu;
+	etm->pmu_type = pmu_type;
+	etm->snapshot_mode = (hdr[CS_ETM_SNAPSHOT] != 0);
+	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
 	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
@@ -192,8 +369,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->auxtrace.free = cs_etm__free;
 	session->auxtrace = &etm->auxtrace;
 
-	if (dump_trace)
+	if (dump_trace) {
+		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
 		return 0;
+	}
 
 	err = auxtrace_queues__process_index(&etm->queues, session);
 	if (err)
@@ -208,6 +387,15 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	session->auxtrace = NULL;
 err_free_etm:
 	zfree(&etm);
+err_free_metadata:
+	/* No need to check @metadata[j], free(NULL) is supported */
+	for (j = 0; j < num_cpu; j++)
+		free(metadata[j]);
+	zfree(&metadata);
+err_free_traceid_list:
+	intlist__delete(traceid_list);
+err_free_hdr:
+	zfree(&hdr);
 
 	return -EINVAL;
 }
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 5ab6a8ef1b32..5864d5dca616 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -64,6 +64,9 @@ enum {
 	CS_ETMV4_PRIV_MAX,
 };
 
+/* RB tree for quick conversion between traceID and CPUs */
+struct intlist *traceid_list;
+
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
 
-- 
2.14.3
