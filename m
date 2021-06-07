Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B74C4743D
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 02:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD1F611C2
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 02:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFGDAa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 6 Jun 2021 23:00:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4327 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhFGDAa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 6 Jun 2021 23:00:30 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FyycT5zh8z1BJhT;
        Mon,  7 Jun 2021 10:53:45 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:58:34 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:58:34 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v2] perf annotate: Add itrace options support
Date:   Mon, 7 Jun 2021 10:59:18 +0800
Message-ID: <20210607025918.118603-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
"annotate". As a result, perf annotate does not support parsing itrace data.

A simple example is as follows:

  # perf record -e arm_spe_0/branch_filter=1/ -a sleep 1
  [ perf record: Woken up 9 times to write data ]
  [ perf record: Captured and wrote 20.874 MB perf.data ]
  # perf annotate --stdio
  Error:
  The perf.data data has no samples!

Solution:
1.Add itrace options in help,
2.Set hook functions of "auxtrace_info" and "auxtrace" in perf_tool.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---

Changes since v1:
 - Adjust spaces to maintain alignment in "tool".

 tools/perf/builtin-annotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 49627a7bed7c..8f87658eff31 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -474,6 +474,8 @@ int cmd_annotate(int argc, const char **argv)
 			.attr	= perf_event__process_attr,
 			.build_id = perf_event__process_build_id,
 			.tracing_data   = perf_event__process_tracing_data,
+			.auxtrace_info	= perf_event__process_auxtrace_info,
+			.auxtrace	= perf_event__process_auxtrace,
 			.feature	= process_feature_event,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
@@ -483,6 +485,9 @@ int cmd_annotate(int argc, const char **argv)
 	struct perf_data data = {
 		.mode  = PERF_DATA_MODE_READ,
 	};
+	struct itrace_synth_opts itrace_synth_opts = {
+		.set = 0,
+	};
 	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -547,6 +552,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
+	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
+			    "Instruction Tracing options\n" ITRACE_HELP,
+			    itrace_parse_synth_opts),
 
 	OPT_END()
 	};
@@ -591,6 +599,8 @@ int cmd_annotate(int argc, const char **argv)
 	if (IS_ERR(annotate.session))
 		return PTR_ERR(annotate.session);
 
+	annotate.session->itrace_synth_opts = &itrace_synth_opts;
+
 	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
 						      HEADER_BRANCH_STACK);
 
-- 
2.30.GIT

