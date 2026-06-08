Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747D2DC76C;
	Mon,  8 Jun 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923704; cv=none; b=HEDnfLsDm6pGD2PxU4hz+JlCQIXrFPB+/9DqK8v04FtCVYLf1QW3Q4NCXsh7+f5kdpW7/br+bbFgmPqRadddoPaJazByVo6tGdH3CCqPLs83TF9Jv4Xdfn6cLAU1OgJPwOL2qtX/OZ3skiKuH7sKWZaX5SDHP7x003cMuoE9DeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923704; c=relaxed/simple;
	bh=5uFsXsLLqeNLq4ZoehU/wlhC1HppZJke7w81ld7cfhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4CxP9ffkuR8SrpAil2+MKy/Q4GtT+nmancHzL5zdpR73uw6IxJvnIehCs0AmnT3S0Xxx4fx4GieuvvCoEe4BIaOT+/xZoBME7anaOyQ9WmfvH1SgG9XrSoM8JAeoMP7ytm5dX2oAE1rWHBfzmvRd44u6v6QY41UiPe90XCxieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SDxo2VC8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SDxo2VC8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Mj2At4111481;
	Mon, 8 Jun 2026 13:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xe9qJdTzab1T3flao
	izxpF4+0/A1MZ+cmknVaZxDQIk=; b=SDxo2VC8hxzK6jmLxM8vtkslKx/Av/6/n
	qxL9DFJm7skHu1TRMMistJxggy4cBy0QxuSZb9+JtDN0tzcyUcgbD2VvK7bnfShs
	bm7+XH9hKsdrv1CWny5m/ekNc/R7JMIes4tlNqgje8qaPXYjeaBktmnE1TDpFjPv
	H9228TkczRofUIs66613ewFgTuCYh7P8X3FklJml+uqayRFmevs4gLJhh9DGi1zA
	GnrPYNwK0w1EtvGgGuvJBoXOChiQfh25BMiwEXtSKzmwcUWqy4KEYY9JyTZNbrX/
	NEF//EjS5bl/0LecFwnZdKiquL56j4755vyIh7cLqJHNa/hKaQVHA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23qckb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:01:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658CndJm022017;
	Mon, 8 Jun 2026 13:01:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjncb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:01:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658D1UCA49086962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 13:01:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20C832004D;
	Mon,  8 Jun 2026 13:01:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D68120049;
	Mon,  8 Jun 2026 13:01:24 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.212.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 13:01:24 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH 3/4] perf data-convert: Add perf.data to trace.dat conversion backend
Date: Mon,  8 Jun 2026 18:29:51 +0530
Message-ID: <20260608125951.90425-5-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608125951.90425-2-tshah@linux.ibm.com>
References: <20260608125951.90425-2-tshah@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a26bd2f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2DYhmZMCe2clY4UwxswA:9
X-Proofpoint-ORIG-GUID: Af9wSSXs7gDlqbskP9GtBoljeMNZDFtH
X-Proofpoint-GUID: PaRgCurP5YCkkSbeYASkWZYtuVEQPQJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExOSBTYWx0ZWRfXxovZhaoNn+jF
 AgRTesTCIoZ584NpdAxnMLfnoHe8bYqtj1qsitL5Lb1YPNTcTqz9OXYoUSYSuv4zz4m4tgCNdCG
 5hyzfYeMr23TJZD+67YJgR17Zu8kjwXddxuGMdNEMlMF296dRIgWcIyCFe2xAD2k0vqB4ooVJTm
 HBWkSXFF6HLonVwP5+xFEfvicCk+n1Bqbo4S68ljxRiRPhCT6ktH8cLu5uW5k6/8wJ8szIpX8pk
 83sFW2xVKDSXlzb9EE2gFoXwgbNPg4gT5qwfficimcRX2433aT1A/DJLa1sbYvqynTB304iuCgD
 GC1owlBd1WWtEG2sdVx6BB5J5AiiIDruRmTmjdS4ixkJoL7wG4alhK6SwnZGwc71qdeqnWkQPli
 LoAF8ggH02uStTS6gvFDiCgEEaAlCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606080119

Add data-convert-trace.c implementing trace_convert__perf2dat() to
convert perf.data tracepoint events to trace.dat format.

process_sample_event() is invoked for each PERF_TYPE_TRACEPOINT sample
during perf_session__process_events(), storing raw event bytes per-cpu
via trace_dat__collect_cpu_event().

Once all samples are collected:
- trace_dat__write_options_section1() writes the OPTIONS section with
  CPUCOUNT, TRACECLOCK, HEADER_INFO, FTRACE_EVENTS, EVENT_FORMATS,
  KALLSYMS, CMDLINES and DONE options.
- trace_dat__write__options_section2() writes the OPTIONS section with
  BUFFER option holding per-cpu data offset placeholders and the DONE
  option.
- trace_dat__write_flyrecord_section() builds ring buffer pages
  per-cpu and patches BUFFER option with final offsets and sizes

Per-cpu buffers are sized to tep_get_page_size() from the session
tep handle and released on all exit paths.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/Build                |   1 +
 tools/perf/util/data-convert-trace.c | 152 +++++++++++++++++++++++++++
 tools/perf/util/data-convert.h       |   4 +
 3 files changed, 157 insertions(+)
 create mode 100644 tools/perf/util/data-convert-trace.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c000d8032d25..88022b24e170 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -236,6 +236,7 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
 endif
 
 perf-util-y += data-convert-json.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += data-convert-trace.o
 
 perf-util-y += scripting-engines/
 
diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-convert-trace.c
new file mode 100644
index 000000000000..e4f8b817be36
--- /dev/null
+++ b/tools/perf/util/data-convert-trace.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026, IBM Corporation
+ * Author: Tanushree Shah <tshah@linux.ibm.com>
+ *
+ * data-convert-trace.c
+ *
+ * Implements perf.data to trace.dat format conversion for tracepoint events.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+
+#include "data-convert.h"
+#include "session.h"
+#include "evsel.h"
+#include "tool.h"
+#include "debug.h"
+#include "trace-dat.h"
+#include "trace-event.h"
+#include "event.h"
+#include "sample.h"
+#include "evlist.h"
+
+struct trace_convert {
+	struct perf_tool tool;
+	u64 events_count;
+};
+
+/* Store raw tracepoint event data in per-cpu buffer for trace.dat flyrecord */
+static int process_sample_event(const struct perf_tool *tool,
+				union perf_event *event __maybe_unused,
+				struct perf_sample *sample,
+				struct evsel *evsel,
+				struct machine *machine __maybe_unused)
+{
+	struct trace_convert *tc = container_of(tool, struct trace_convert, tool);
+
+	/* Collect raw tracepoint data per-cpu */
+	if (trace_dat_fp && sample->raw_size > 0 &&
+	    evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+		if (trace_dat__collect_cpu_event(sample->cpu, sample->time,
+					sample->raw_data, sample->raw_size) < 0) {
+			pr_err("Failed to collect CPU event\n");
+			return -ENOMEM;
+		}
+		tc->events_count++;
+	}
+
+	return 0;
+}
+
+/* Convert perf.data tracepoint events to trace.dat format */
+int trace_convert__perf2dat(const char *input, const char *to_trace,
+			   struct perf_data_convert_opts *opts)
+{
+	struct perf_session *session;
+	struct trace_convert tc = {
+		.events_count = 0,
+	};
+	struct perf_data data = {
+		.path = input,
+		.mode = PERF_DATA_MODE_READ,
+		.force = opts->force,
+	};
+	int ret = -EINVAL;
+	bool cpu_buffers_initialized = false;
+
+	/* Initialize tool with all required callbacks */
+	perf_tool__init(&tc.tool, /*ordered_events=*/true);
+	tc.tool.sample = process_sample_event;
+
+	/* Open output trace.dat file */
+	trace_dat_fp = fopen(to_trace, "wb");
+	if (!trace_dat_fp) {
+		pr_err("Failed to open output file: %s\n", to_trace);
+		return -EINVAL;
+	}
+
+	/* Open perf.data session - this writes trace.dat metadata sections */
+	session = perf_session__new(&data, &tc.tool);
+	if (IS_ERR(session)) {
+		pr_err("Failed to open perf.data file\n");
+		ret = PTR_ERR(session);
+		goto out_close;
+	}
+
+	/* Initialize per-CPU buffers for flyrecord data */
+	if (session->tevent.pevent) {
+		trace_dat_page_size = tep_get_page_size(session->tevent.pevent);
+		if (trace_dat__init_cpu_buffers(session->header.env.nr_cpus_online) < 0) {
+			pr_err("Failed to initialize CPU buffers\n");
+			ret = -ENOMEM;
+			goto out_delete;
+		}
+		cpu_buffers_initialized = true;
+	}
+
+	/* Process all events - collects raw data per-cpu */
+	ret = perf_session__process_events(session);
+	if (ret < 0) {
+		pr_err("Failed to process events\n");
+		goto out_delete;
+	}
+
+	/* Skip file creation if no tracepoint events found */
+	if (tc.events_count == 0) {
+		pr_warning("No tracepoint events found in '%s', skipping trace.dat creation\n",
+			input);
+		ret = -EINVAL;
+		goto out_delete;
+	}
+
+	/* Write trace.dat options and flyrecord sections */
+	if (trace_dat__write_options_section1() < 0) {
+		pr_err("Failed to write options section1\n");
+		ret = -EIO;
+		goto out_delete;
+	}
+	if (trace_dat__write_options_section2() < 0) {
+		pr_err("Failed to write options section2\n");
+		ret = -EIO;
+		goto out_delete;
+	}
+	if (trace_dat__write_flyrecord_section() < 0) {
+		pr_err("Failed to write flyrecord section\n");
+		ret = -EIO;
+		goto out_delete;
+	}
+
+	pr_info("[ perf data convert: Converted '%s' into trace.dat format '%s' ]\n",
+		input, to_trace);
+	pr_info("[ perf data convert: Converted %llu events ]\n",
+		(unsigned long long)tc.events_count);
+
+	ret = 0;
+
+out_delete:
+	if (cpu_buffers_initialized)
+		trace_dat__free_cpu_buffers();
+	perf_session__delete(session);
+out_close:
+	if (trace_dat_fp) {
+		fclose(trace_dat_fp);
+		trace_dat_fp = NULL;
+	}
+	if (ret != 0)
+		unlink(to_trace);
+	return ret;
+}
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index ee651fa680a1..d958e68367fe 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -19,4 +19,8 @@ int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
 int bt_convert__perf2json(const char *input_name, const char *to_ctf,
 			 struct perf_data_convert_opts *opts);
 
+#ifdef HAVE_LIBTRACEEVENT
+int trace_convert__perf2dat(const char *input, const char *to_trace,
+			   struct perf_data_convert_opts *opts);
+#endif /* HAVE_LIBTRACEEVENT */
 #endif /* __DATA_CONVERT_H */
-- 
2.53.0

