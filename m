Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC1C12002
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9486109F
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhGUIlo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:41:44 -0400
Received: from foss.arm.com ([217.140.110.172]:49216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236184AbhGUI0p (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A84D6E;
        Wed, 21 Jul 2021 02:07:22 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.38.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A8723F694;
        Wed, 21 Jul 2021 02:07:19 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/6] perf cs-etm: Refactor initialisation of decoder params.
Date:   Wed, 21 Jul 2021 10:07:00 +0100
Message-Id: <20210721090706.21523-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721090706.21523-1-james.clark@arm.com>
References: <20210721090706.21523-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The initialisation of the decoder params is duplicated between
creation of the packet printer and packet decoder. Put them both
into one function so that future changes only need to be made in one
place.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 99 +++++--------------
 1 file changed, 25 insertions(+), 74 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index ed1f0326f859..30889a9d0165 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -227,55 +227,6 @@ cs_etm_decoder__init_raw_frame_logging(
 }
 #endif
 
-static int cs_etm_decoder__create_packet_printer(struct cs_etm_decoder *decoder,
-						 const char *decoder_name,
-						 void *trace_config)
-{
-	u8 csid;
-
-	if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
-				   OCSD_CREATE_FLG_PACKET_PROC,
-				   trace_config, &csid))
-		return -1;
-
-	if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, 0))
-		return -1;
-
-	return 0;
-}
-
-static int
-cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_decoder *decoder)
-{
-	const char *decoder_name;
-	ocsd_etmv3_cfg config_etmv3;
-	ocsd_etmv4_cfg trace_config_etmv4;
-	void *trace_config;
-
-	switch (t_params->protocol) {
-	case CS_ETM_PROTO_ETMV3:
-	case CS_ETM_PROTO_PTM:
-		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
-							OCSD_BUILTIN_DCD_ETMV3 :
-							OCSD_BUILTIN_DCD_PTM;
-		trace_config = &config_etmv3;
-		break;
-	case CS_ETM_PROTO_ETMV4i:
-		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
-		trace_config = &trace_config_etmv4;
-		break;
-	default:
-		return -1;
-	}
-
-	return cs_etm_decoder__create_packet_printer(decoder,
-						     decoder_name,
-						     trace_config);
-}
-
 static ocsd_datapath_resp_t
 cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
 				  struct cs_etm_packet_queue *packet_queue,
@@ -629,9 +580,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	return resp;
 }
 
-static int cs_etm_decoder__create_etm_packet_decoder(
-					struct cs_etm_trace_params *t_params,
-					struct cs_etm_decoder *decoder)
+static int
+cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
+				   struct cs_etm_trace_params *t_params,
+				   struct cs_etm_decoder *decoder)
 {
 	const char *decoder_name;
 	ocsd_etmv3_cfg config_etmv3;
@@ -657,31 +609,30 @@ static int cs_etm_decoder__create_etm_packet_decoder(
 		return -1;
 	}
 
-	if (ocsd_dt_create_decoder(decoder->dcd_tree,
-				     decoder_name,
-				     OCSD_CREATE_FLG_FULL_DECODER,
-				     trace_config, &csid))
-		return -1;
+	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
+		if (ocsd_dt_create_decoder(decoder->dcd_tree,
+					   decoder_name,
+					   OCSD_CREATE_FLG_FULL_DECODER,
+					   trace_config, &csid))
+			return -1;
 
-	if (ocsd_dt_set_gen_elem_outfn(decoder->dcd_tree,
-				       cs_etm_decoder__gen_trace_elem_printer,
-				       decoder))
-		return -1;
+		if (ocsd_dt_set_gen_elem_outfn(decoder->dcd_tree,
+					       cs_etm_decoder__gen_trace_elem_printer,
+					       decoder))
+			return -1;
 
-	return 0;
-}
+		return 0;
+	} else if (d_params->operation == CS_ETM_OPERATION_PRINT) {
+		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
+					   OCSD_CREATE_FLG_PACKET_PROC,
+					   trace_config, &csid))
+			return -1;
 
-static int
-cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
-				   struct cs_etm_trace_params *t_params,
-				   struct cs_etm_decoder *decoder)
-{
-	if (d_params->operation == CS_ETM_OPERATION_PRINT)
-		return cs_etm_decoder__create_etm_packet_printer(t_params,
-								 decoder);
-	else if (d_params->operation == CS_ETM_OPERATION_DECODE)
-		return cs_etm_decoder__create_etm_packet_decoder(t_params,
-								 decoder);
+		if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, 0))
+			return -1;
+
+		return 0;
+	}
 
 	return -1;
 }
-- 
2.28.0

