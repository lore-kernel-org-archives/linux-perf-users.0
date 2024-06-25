Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B231DDC9;
	Tue, 25 Jun 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322397; cv=none; b=rw+7rbbFeIFbQod5pu8KKsA+HO5U4bHFE1rW2QfufEZh+e3KgH7fMzYyrXTr90hp0nYIHR4ZXo6GroLfaM2oVLEzqry8rePzFnxM12xI9HxMs2zN11nPwDvASn4uwtRTxOq0CVhDKdVrPnbH7XMBw7lUH0blNZJzztKwAPxkuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322397; c=relaxed/simple;
	bh=eujB/BmdvKJot5kDSOgIqZuBhQic3PS+amFCha2fFDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2ugfFmaxKy20ZfX7h1c6AjInLsfik71YyBBSuozh+we0Capdqk2fQ5lJDYFbhxsa6ib6WlsafmqRpDGXM33i9xRIhwup6/w4AXDt8mmlKMjgSdYH2BVgJZbCmHkNgb/edC2AXxrw9DX6mfZTnzCodcFnywIVDx0cYDC9+v5E9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB132DA7;
	Tue, 25 Jun 2024 06:33:39 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6E533F73B;
	Tue, 25 Jun 2024 06:33:11 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com,
	jszu@nvidia.com,
	bwicaksono@nvidia.com
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 07/17] perf: cs-etm: Print queue number in raw trace dump
Date: Tue, 25 Jun 2024 14:30:50 +0100
Message-Id: <20240625133105.671245-8-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625133105.671245-1-james.clark@arm.com>
References: <20240625133105.671245-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have overlapping trace IDs it's also useful to know what the
queue number is to be able to distinguish the source of the trace so
print it inline.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 2 +-
 tools/perf/util/cs-etm.c                        | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index d49c3e9c7c21..b78ef0262135 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -41,7 +41,7 @@ const u32 INSTR_PER_NS = 10;
 
 struct cs_etm_decoder {
 	void *data;
-	void (*packet_printer)(const char *msg);
+	void (*packet_printer)(const char *msg, void *data);
 	bool suppress_printing;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
@@ -202,7 +202,7 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
 	const struct cs_etm_decoder *decoder = p_context;
 
 	if (p_context && str_len && !decoder->suppress_printing)
-		decoder->packet_printer(msg);
+		decoder->packet_printer(msg, decoder->data);
 }
 
 static int
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 272c2efe78ee..12c782fa6db2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -60,7 +60,7 @@ struct cs_etm_trace_params {
 
 struct cs_etm_decoder_params {
 	int operation;
-	void (*packet_printer)(const char *msg);
+	void (*packet_printer)(const char *msg, void *data);
 	cs_etm_mem_cb_type mem_acc_cb;
 	bool formatted;
 	bool fsyncs;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 87e983da19be..49fadf46f42b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -762,15 +762,16 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 	}
 }
 
-static void cs_etm__packet_dump(const char *pkt_string)
+static void cs_etm__packet_dump(const char *pkt_string, void *data)
 {
 	const char *color = PERF_COLOR_BLUE;
 	int len = strlen(pkt_string);
+	struct cs_etm_queue *etmq = data;
 
 	if (len && (pkt_string[len-1] == '\n'))
-		color_fprintf(stdout, color, "	%s", pkt_string);
+		color_fprintf(stdout, color, "	Qnr:%d; %s", etmq->queue_nr, pkt_string);
 	else
-		color_fprintf(stdout, color, "	%s\n", pkt_string);
+		color_fprintf(stdout, color, "	Qnr:%d; %s\n", etmq->queue_nr, pkt_string);
 
 	fflush(stdout);
 }
-- 
2.34.1

