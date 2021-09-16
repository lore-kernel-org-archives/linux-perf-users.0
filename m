Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98BC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00E060F51
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 15:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbhIPPs3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:48:29 -0400
Received: from foss.arm.com ([217.140.110.172]:39376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239196AbhIPPs2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 11:48:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB797113E;
        Thu, 16 Sep 2021 08:47:07 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06B4D3F5A1;
        Thu, 16 Sep 2021 08:47:05 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH 3/5] perf arm-spe: Add snapshot mode support
Date:   Thu, 16 Sep 2021 16:46:33 +0100
Message-Id: <20210916154635.1525-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210916154635.1525-1-german.gomez@arm.com>
References: <20210916154635.1525-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch enabled support for snapshot mode of arm_spe events,
including the implementation of the necessary callbacks (excluding
find_snapshot, which is to be included in a followup commit).

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 130 +++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index a4420d4df503..f8b03d164b42 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -84,6 +84,55 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	return 0;
 }
 
+static void
+arm_spe_snapshot_resolve_auxtrace_defaults(struct record_opts *opts,
+					   bool privileged)
+{
+	/*
+	 * The default snapshot size is the auxtrace mmap size. If neither auxtrace mmap size nor
+	 * snapshot size is specified, then the default is 4MiB for privileged users, 128KiB for
+	 * unprivileged users.
+	 *
+	 * The default auxtrace mmap size is 4MiB/page_size for privileged users, 128KiB for
+	 * unprivileged users. If an unprivileged user does not specify mmap pages, the mmap pages
+	 * will be reduced from the default 512KiB/page_size to 256KiB/page_size, otherwise the
+	 * user is likely to get an error as they exceed their mlock limmit.
+	 */
+
+	/*
+	 * No size were given to '-S' or '-m,', so go with the default
+	 */
+	if (!opts->auxtrace_snapshot_size && !opts->auxtrace_mmap_pages) {
+		if (privileged) {
+			opts->auxtrace_mmap_pages = MiB(4) / page_size;
+		} else {
+			opts->auxtrace_mmap_pages = KiB(128) / page_size;
+			if (opts->mmap_pages == UINT_MAX)
+				opts->mmap_pages = KiB(256) / page_size;
+		}
+	} else if (!opts->auxtrace_mmap_pages && !privileged && opts->mmap_pages == UINT_MAX) {
+		opts->mmap_pages = KiB(256) / page_size;
+	}
+
+	/*
+	 * '-m,xyz' was specified but no snapshot size, so make the snapshot size as big as the
+	 * auxtrace mmap area.
+	 */
+	if (!opts->auxtrace_snapshot_size)
+		opts->auxtrace_snapshot_size = opts->auxtrace_mmap_pages * (size_t)page_size;
+
+	/*
+	 * '-Sxyz' was specified but no auxtrace mmap area, so make the auxtrace mmap area big
+	 * enough to fit the requested snapshot size.
+	 */
+	if (!opts->auxtrace_mmap_pages) {
+		size_t sz = opts->auxtrace_snapshot_size;
+
+		sz = round_up(sz, page_size) / page_size;
+		opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
+	}
+}
+
 static int arm_spe_recording_options(struct auxtrace_record *itr,
 				     struct evlist *evlist,
 				     struct record_opts *opts)
@@ -115,6 +164,36 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
+	/*
+	 * we are in snapshot mode.
+	 */
+	if (opts->auxtrace_snapshot_mode) {
+		/*
+		 * Command arguments '-Sxyz' and/or '-m,xyz' are missing, so fill those in with
+		 * default values.
+		 */
+		if (!opts->auxtrace_snapshot_size || !opts->auxtrace_mmap_pages)
+			arm_spe_snapshot_resolve_auxtrace_defaults(opts, privileged);
+
+		/*
+		 * Snapshot size can't be bigger than the auxtrace area.
+		 */
+		if (opts->auxtrace_snapshot_size > opts->auxtrace_mmap_pages * (size_t)page_size) {
+			pr_err("Snapshot size %zu must not be greater than AUX area tracing mmap size %zu\n",
+			       opts->auxtrace_snapshot_size,
+			       opts->auxtrace_mmap_pages * (size_t)page_size);
+			return -EINVAL;
+		}
+
+		/*
+		 * Something went wrong somewhere - this shouldn't happen.
+		 */
+		if (!opts->auxtrace_snapshot_size || !opts->auxtrace_mmap_pages) {
+			pr_err("Failed to calculate default snapshot size and/or AUX area tracing mmap pages\n");
+			return -EINVAL;
+		}
+	}
+
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
 	if (!opts->auxtrace_mmap_pages) {
 		if (privileged) {
@@ -138,6 +217,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
+	if (opts->auxtrace_snapshot_mode)
+		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
+			  opts->auxtrace_snapshot_size);
 
 	/*
 	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
@@ -172,6 +254,51 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int arm_spe_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
+					 struct record_opts *opts,
+					 const char *str)
+{
+	unsigned long long snapshot_size = 0;
+	char *endptr;
+
+	if (str) {
+		snapshot_size = strtoull(str, &endptr, 0);
+		if (*endptr || snapshot_size > SIZE_MAX)
+			return -1;
+	}
+
+	opts->auxtrace_snapshot_mode = true;
+	opts->auxtrace_snapshot_size = snapshot_size;
+
+	return 0;
+}
+
+static int arm_spe_snapshot_start(struct auxtrace_record *itr)
+{
+	struct arm_spe_recording *ptr =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel;
+
+	evlist__for_each_entry(ptr->evlist, evsel) {
+		if (evsel->core.attr.type == ptr->arm_spe_pmu->type)
+			return evsel__disable(evsel);
+	}
+	return -EINVAL;
+}
+
+static int arm_spe_snapshot_finish(struct auxtrace_record *itr)
+{
+	struct arm_spe_recording *ptr =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel;
+
+	evlist__for_each_entry(ptr->evlist, evsel) {
+		if (evsel->core.attr.type == ptr->arm_spe_pmu->type)
+			return evsel__enable(evsel);
+	}
+	return -EINVAL;
+}
+
 static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
 {
 	struct timespec ts;
@@ -207,6 +334,9 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 
 	sper->arm_spe_pmu = arm_spe_pmu;
 	sper->itr.pmu = arm_spe_pmu;
+	sper->itr.snapshot_start = arm_spe_snapshot_start;
+	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
+	sper->itr.parse_snapshot_options = arm_spe_parse_snapshot_options;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;
 	sper->itr.info_fill = arm_spe_info_fill;
-- 
2.17.1

