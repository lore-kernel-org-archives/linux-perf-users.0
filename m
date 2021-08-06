Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46100C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C18860C41
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbhHFNmB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:42:01 -0400
Received: from foss.arm.com ([217.140.110.172]:33116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344300AbhHFNmA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 09:42:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 582C431B;
        Fri,  6 Aug 2021 06:41:44 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5A183F40C;
        Fri,  6 Aug 2021 06:41:41 -0700 (PDT)
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
Subject: [PATCH v2 7/9] perf cs-etm: Create ETE decoder
Date:   Fri,  6 Aug 2021 14:41:07 +0100
Message-Id: <20210806134109.1182235-8-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210806134109.1182235-1-james.clark@arm.com>
References: <20210806134109.1182235-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the magic number indicates ETE instantiate a OCSD_BUILTIN_DCD_ETE
decoder instead of OCSD_BUILTIN_DCD_ETMV4I. ETE is the new trace feature
for Armv9.

Testing performed
=================

* Old files with v0 and v1 headers for ETMv4 still open correctly
* New files with new magic number open on new versions of perf
* New files with new magic number fail to open on old versions of perf
* Decoding with the ETE decoder results in the same output as the ETMv4
  decoder as long as there are no new ETE packet types

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++++++
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h | 12 +++++++++++
 tools/perf/util/cs-etm.c                      | 18 +++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 12cee321fbf2..3071e5deddcc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -156,6 +156,20 @@ static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 	config->core_prof = profile_CortexA;
 }
 
+static void cs_etm_decoder__gen_ete_config(struct cs_etm_trace_params *params,
+					   ocsd_ete_cfg *config)
+{
+	config->reg_configr = params->ete.reg_configr;
+	config->reg_traceidr = params->ete.reg_traceidr;
+	config->reg_idr0 = params->ete.reg_idr0;
+	config->reg_idr1 = params->ete.reg_idr1;
+	config->reg_idr2 = params->ete.reg_idr2;
+	config->reg_idr8 = params->ete.reg_idr8;
+	config->reg_devarch = params->ete.reg_devarch;
+	config->arch_ver = ARCH_AA64;
+	config->core_prof = profile_CortexA;
+}
+
 static void cs_etm_decoder__print_str_cb(const void *p_context,
 					 const char *msg,
 					 const int str_len)
@@ -603,6 +617,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 	const char *decoder_name;
 	ocsd_etmv3_cfg config_etmv3;
 	ocsd_etmv4_cfg trace_config_etmv4;
+	ocsd_ete_cfg trace_config_ete;
 	void *trace_config;
 	u8 csid;
 
@@ -620,6 +635,11 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
 		trace_config = &trace_config_etmv4;
 		break;
+	case CS_ETM_PROTO_ETE:
+		cs_etm_decoder__gen_ete_config(t_params, &trace_config_ete);
+		decoder_name = OCSD_BUILTIN_DCD_ETE;
+		trace_config = &trace_config_ete;
+		break;
 	default:
 		return -1;
 	}
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 11f3391d06f2..0102ece5ca3e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -37,11 +37,22 @@ struct cs_etmv4_trace_params {
 	u32 reg_traceidr;
 };
 
+struct cs_ete_trace_params {
+	u32 reg_idr0;
+	u32 reg_idr1;
+	u32 reg_idr2;
+	u32 reg_idr8;
+	u32 reg_configr;
+	u32 reg_traceidr;
+	u32 reg_devarch;
+};
+
 struct cs_etm_trace_params {
 	int protocol;
 	union {
 		struct cs_etmv3_trace_params etmv3;
 		struct cs_etmv4_trace_params etmv4;
+		struct cs_ete_trace_params ete;
 	};
 };
 
@@ -65,6 +76,7 @@ enum {
 	CS_ETM_PROTO_ETMV4i,
 	CS_ETM_PROTO_ETMV4d,
 	CS_ETM_PROTO_PTM,
+	CS_ETM_PROTO_ETE
 };
 
 enum cs_etm_decoder_operation {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d540512a3c96..e5649e9ea140 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -460,6 +460,21 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
 	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
 }
 
+static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = CS_ETM_PROTO_ETE;
+	t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
+	t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
+	t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
+	t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
+	t_params[idx].ete.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
+	t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+	t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
+}
+
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
 				     struct cs_etm_auxtrace *etm,
 				     int decoders)
@@ -479,6 +494,9 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
 		case __perf_cs_etmv4_magic:
 			cs_etm__set_trace_param_etmv4(t_params, etm, i);
 			break;
+		case __perf_cs_ete_magic:
+			cs_etm__set_trace_param_ete(t_params, etm, i);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.28.0

