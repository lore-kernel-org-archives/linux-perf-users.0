Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE0C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40386113C
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbhHFNmE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:42:04 -0400
Received: from foss.arm.com ([217.140.110.172]:33134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344186AbhHFNmD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 09:42:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9C711FB;
        Fri,  6 Aug 2021 06:41:47 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C8773F40C;
        Fri,  6 Aug 2021 06:41:45 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org
Cc:     acme@kernel.org, suzuki.poulose@arm.com,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] perf cs-etm: Print the decoder name
Date:   Fri,  6 Aug 2021 14:41:08 +0100
Message-Id: <20210806134109.1182235-9-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210806134109.1182235-1-james.clark@arm.com>
References: <20210806134109.1182235-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the real name of the decoder instead of hard-coding "ETM" to avoid
confusion when the trace is ETE. This also now distinguishes between
ETMv3 and ETMv4.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 17 +++++++++++------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3071e5deddcc..29a23fa16aff 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -37,6 +37,7 @@ struct cs_etm_decoder {
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
+	const char *decoder_name;
 };
 
 static u32
@@ -614,7 +615,6 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 				   struct cs_etm_trace_params *t_params,
 				   struct cs_etm_decoder *decoder)
 {
-	const char *decoder_name;
 	ocsd_etmv3_cfg config_etmv3;
 	ocsd_etmv4_cfg trace_config_etmv4;
 	ocsd_ete_cfg trace_config_ete;
@@ -625,19 +625,19 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 	case CS_ETM_PROTO_ETMV3:
 	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+		decoder->decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
 							OCSD_BUILTIN_DCD_ETMV3 :
 							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
 		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
+		decoder->decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
 		trace_config = &trace_config_etmv4;
 		break;
 	case CS_ETM_PROTO_ETE:
 		cs_etm_decoder__gen_ete_config(t_params, &trace_config_ete);
-		decoder_name = OCSD_BUILTIN_DCD_ETE;
+		decoder->decoder_name = OCSD_BUILTIN_DCD_ETE;
 		trace_config = &trace_config_ete;
 		break;
 	default:
@@ -646,7 +646,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 
 	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
 		if (ocsd_dt_create_decoder(decoder->dcd_tree,
-					   decoder_name,
+					   decoder->decoder_name,
 					   OCSD_CREATE_FLG_FULL_DECODER,
 					   trace_config, &csid))
 			return -1;
@@ -658,7 +658,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 
 		return 0;
 	} else if (d_params->operation == CS_ETM_OPERATION_PRINT) {
-		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
+		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder->decoder_name,
 					   OCSD_CREATE_FLG_PACKET_PROC,
 					   trace_config, &csid))
 			return -1;
@@ -790,3 +790,8 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
 	decoder->dcd_tree = NULL;
 	free(decoder);
 }
+
+const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
+{
+	return decoder->decoder_name;
+}
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 0102ece5ca3e..92a855fbe5b8 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -104,5 +104,6 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
 			       struct cs_etm_packet *packet);
 
 int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
+const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder);
 
 #endif /* INCLUDE__CS_ETM_DECODER_H__ */
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e5649e9ea140..788ad5a099f6 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -537,8 +537,8 @@ static void cs_etm__dump_event(struct cs_etm_queue *etmq,
 
 	fprintf(stdout, "\n");
 	color_fprintf(stdout, color,
-		     ". ... CoreSight ETM Trace data: size %zu bytes\n",
-		     buffer->size);
+		     ". ... CoreSight %s Trace data: size %zu bytes\n",
+		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);
 
 	do {
 		size_t consumed;
-- 
2.28.0

