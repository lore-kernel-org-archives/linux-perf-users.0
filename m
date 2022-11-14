Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F70C4321E
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbiKNSNn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbiKNSNZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0222286E1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so11188193ybf.17
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWjziziyWCL9ANTddckpRcCDgTKHv1YzBEeGesj8X4M=;
        b=Z1vW6YtBcmpz1uRXy9oUq83oCkscQDF4giyMlLAQnSqvcegJHwh6TZx1ptKlHFWfOL
         jKmvOd42xB4ddU6IaOmWcD5nh4uwLZAU7AEk9ev5yXDzw1FlAlmd+HEBIENpBYaavm3M
         Y+NBiKeW13mbxd6E3CWao4LE2D9+UOc1IHXBcrra20VTJBnFJj4CJHT8wn/ecpjx6T4l
         OiN6Rtd7JAzfe4FHhjFT2nLKh9173k/1W/OBC0o7GTL9GHJv+sTrmfAkKnrYm5xR6NKt
         eREIO3mxZPXOZJVsNEuZDLN64PxvLVENYHCdgMAtAdAr/zfoqGpglm0MXTg58fpcb3tH
         AfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWjziziyWCL9ANTddckpRcCDgTKHv1YzBEeGesj8X4M=;
        b=4dUw8BfIYO7+u6CclogOTR/JKc2Gq5DgwaR2y5iq3fkRcZsOjD9yDepD4fsU6TUYrC
         IV7PEyTkobmuzVuDU6rwd35476qDlX4EW9dnDChtxF+jW10hNTFd1TCYgbw8exUuoCER
         aec/tHQF8lAupzrEloxK7+DVRPBlbdSi7aO62uXdNL7GtZ+YtT5EzwWyPcx1ULuzCv1p
         lh/XDMlDOYHoOL78V3B0+IkjD7sBeoLKvHNwmMayqQjtBhSHR+fDfT7JeTsRUHoikPIm
         UzwfvtaojPKJO91B+JAzBDHTtSCSgky2Rjm3aqMPrfzoBAPuBvu0u4YmWunfykHJqpWL
         PD6A==
X-Gm-Message-State: ANoB5plh7RKZ7O/tDbU/3xuozZwOGVy4b9C7O8HT4OGHYjKHDOzIiu3x
        orAhyXAcCaFdT+qP/s1yXUmsVa0EFJeF
X-Google-Smtp-Source: AA0mqf5misNJZNIjUPm5eqEFWsObkGjNCGwnSTuq8/yXVPdCmj+KVWovjbjw+q9/z5IcWSeVQ59B/4h/uhgX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a0d:d442:0:b0:377:e4ac:6c3b with SMTP id
 w63-20020a0dd442000000b00377e4ac6c3bmr13752108ywd.285.1668449597176; Mon, 14
 Nov 2022 10:13:17 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:43 -0800
In-Reply-To: <20221114181251.2683871-1-irogers@google.com>
Message-Id: <20221114181251.2683871-2-irogers@google.com>
Mime-Version: 1.0
References: <20221114181251.2683871-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 1/9] perf pmu: Add documentation
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add documentation to struct perf_pmu and the associated structs of
perf_pmu_alias and perf_pmu_format.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c |  16 ++++++
 tools/perf/util/pmu.h | 123 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 133 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6a86e6af0903..8396504855cc 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -31,10 +31,26 @@
 
 struct perf_pmu perf_pmu__fake;
 
+/**
+ * struct perf_pmu_format - Values from a format file read from
+ * <sysfs>/devices/cpu/format/ held in struct perf_pmu.
+ *
+ * For example, the contents of <sysfs>/devices/cpu/format/event may be
+ * "config:0-7" and will be represented here as name="event",
+ * value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will be set.
+ */
 struct perf_pmu_format {
+	/** @name: The modifier/file name. */
 	char *name;
+	/**
+	 * @value : Which config value the format relates to. Supported values
+	 * are from PERF_PMU_FORMAT_VALUE_CONFIG to
+	 * PERF_PMU_FORMAT_VALUE_CONFIG_END.
+	 */
 	int value;
+	/** @bits: Which config bits are set by this format value. */
 	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
+	/** @list: Element on list within struct perf_pmu. */
 	struct list_head list;
 };
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 68e15c38ae71..ce718bab3018 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -33,31 +33,103 @@ struct perf_pmu_caps {
 	struct list_head list;
 };
 
+/**
+ * struct perf_pmu - hi
+ */
 struct perf_pmu {
+	/** @name: The name of the PMU such as "cpu". */
 	char *name;
+	/**
+	 * @alias_name: Optional alternate name for the PMU determined in
+	 * architecture specific code.
+	 */
 	char *alias_name;
+	/**
+	 * @id: Optional PMU identifier read from
+	 * <sysfs>/bus/event_source/devices/<name>/identifier.
+	 */
 	char *id;
+	/**
+	 * @type: Perf event attributed type value, read from
+	 * <sysfs>/bus/event_source/devices/<name>/type.
+	 */
 	__u32 type;
+	/**
+	 * @selectable: Can the PMU name be selected as if it were an event?
+	 */
 	bool selectable;
+	/**
+	 * @is_uncore: Is the PMU not within the CPU core? Determined by the
+	 * presence of <sysfs>/bus/event_source/devices/<name>/cpumask.
+	 */
 	bool is_uncore;
+	/** @is_hybrid: Is the PMU name either cpu_core or cpu_atom. */
 	bool is_hybrid;
+	/**
+	 * @auxtrace: Are events auxiliary events? Determined in architecture
+	 * specific code.
+	 */
 	bool auxtrace;
+	/**
+	 * @max_precise: Number of levels of :ppp precision supported by the
+	 * PMU, read from
+	 * <sysfs>/bus/event_source/devices/<name>/caps/max_precise.
+	 */
 	int max_precise;
+	/**
+	 * @default_config: Optional default perf_event_attr determined in
+	 * architecture specific code.
+	 */
 	struct perf_event_attr *default_config;
+	/**
+	 * @cpus: Empty or the contents of either of:
+	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
+	 * <sysfs>/bus/event_source/devices/<cpu>/cpus.
+	 */
 	struct perf_cpu_map *cpus;
-	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
-	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	/**
+	 * @format: Holds the contents of files read from
+	 * <sysfs>/bus/event_source/devices/<name>/format/. The contents specify
+	 * which event parameter changes what config, config1 or config2 bits.
+	 */
+	struct list_head format;
+	/**
+	 * @aliases: List of struct perf_pmu_alias. Each alias corresponds to an
+	 * event read from <sysfs>/bus/event_source/devices/<name>/events/ or
+	 * from json events in pmu-events.c.
+	 */
+	struct list_head aliases;
+	/** @caps_initialized: Has the list caps been initialized? */
 	bool caps_initialized;
+	/** @nr_caps: The length of the list caps. */
 	u32 nr_caps;
-	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
-	struct list_head list;    /* ELEM */
+	/**
+	 * @caps: Holds the contents of files read from
+	 * <sysfs>/bus/event_source/devices/<name>/caps/.
+	 *
+	 * The contents are pairs of the filename with the value of its
+	 * contents, for example, max_precise (see above) may have a value of 3.
+	 */
+	struct list_head caps;
+	/** @list: Element on pmus list in pmu.c. */
+	struct list_head list;
+	/** @hybrid_list: Element on perf_pmu__hybrid_pmus. */
 	struct list_head hybrid_list;
 
+	/**
+	 * @missing_features: Features to inhibit when events on this PMU are
+	 * opened.
+	 */
 	struct {
+		/**
+		 * @exclude_guest: Disables perf_event_attr exclude_guest and
+		 * exclude_host.
+		 */
 		bool exclude_guest;
 	} missing_features;
 };
 
+/** @perf_pmu__fake: A special global PMU used for testing. */
 extern struct perf_pmu perf_pmu__fake;
 
 struct perf_pmu_info {
@@ -71,21 +143,60 @@ struct perf_pmu_info {
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
+/**
+ * struct perf_pmu_alias - An event either read from sysfs or builtin in
+ * pmu-events.c, created by parsing the pmu-events json files.
+ */
 struct perf_pmu_alias {
+	/** @name: Name of the event like "mem-loads". */
 	char *name;
+	/** @desc: Optional short description of the event. */
 	char *desc;
+	/** @long_desc: Optional long description. */
 	char *long_desc;
+	/**
+	 * @topic: Optional topic such as cache or pipeline, particularly for
+	 * json events.
+	 */
 	char *topic;
+	/**
+	 * @str: Comma separated parameter list like
+	 * "event=0xcd,umask=0x1,ldlat=0x3".
+	 */
 	char *str;
-	struct list_head terms; /* HEAD struct parse_events_term -> list */
-	struct list_head list;  /* ELEM */
+	/** @terms: Owned list of the original parsed parameters. */
+	struct list_head terms;
+	/** @list: List element of struct perf_pmu aliases. */
+	struct list_head list;
+	/** @unit: Units for the event, such as bytes or cache lines. */
 	char unit[UNIT_MAX_LEN+1];
+	/** @scale: Value to scale read counter values by. */
 	double scale;
+	/**
+	 * @per_pkg: Does the file
+	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
+	 * equivalent json value exist and have the value 1.
+	 */
 	bool per_pkg;
+	/**
+	 * @snapshot: Does the file
+	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
+	 * exist and have the value 1.
+	 */
 	bool snapshot;
+	/**
+	 * @deprecated: Is the event hidden and so not shown in perf list by
+	 * default.
+	 */
 	bool deprecated;
+	/**
+	 * @metric_expr: A metric expression associated with an event. Doing
+	 * this makes little sense due to scale and unit applying to both.
+	 */
 	char *metric_expr;
+	/** @metric_name: A name for the metric. unit applying to both. */
 	char *metric_name;
+	/** @pmu_name: The name copied from struct perf_pmu. */
 	char *pmu_name;
 };
 
-- 
2.38.1.431.g37b22c650d-goog

