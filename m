Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8CAC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Jun 2022 16:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiFTQuT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiFTQuS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Jun 2022 12:50:18 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66FC1570C
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jun 2022 09:50:17 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id n12-20020a92260c000000b002d3c9fc68d6so7725044ile.19
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jun 2022 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ExmBzSKpLkiCHa59QsqYQ/MSjLYvSFah4s+gXGLxJqg=;
        b=YPF0ZpgHCqKySH8864zZhz8jjEywgWvK0N2eUVokfhTYL9opzubKr6lpU+aEV2Mt33
         6F7mvs7DFJpAtBqyOQK5B1ZGhjpyNSN7GGDq14uIcQrfP6RtdeZMDDJTXnPOJ+eVU8sc
         dMZDwRSkv5JYW8U17L7SqX1kJB0LcJB70pbUGK3rO1T2rD9qp/AZLuLDMC7XlpZBPwsJ
         v0aBxLFLCGUdmNQZJw1a2Uv5Zf/FT/+YyXYWlORlUWuRSRzcnKX+BYEDtWUxMOvRl9t3
         5qLBIzUR9OOEN3+/b39OiDXyxrXQmIcv69lth7biygb2Cl633/n7srzCZMCrxWbrf4qi
         7Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ExmBzSKpLkiCHa59QsqYQ/MSjLYvSFah4s+gXGLxJqg=;
        b=0hejsrhg3hMMm8aBE2MJ1LhJ0LKPAyIRYjG1r+AElro0v1QYEyGpMQpNYTtuWHPqtV
         fWHShMm5EnXUJ93bTTs3NYQlgO6T4DkwxSl6kgmPp81A18EBfXl064lz5tTlXN03FsWy
         9rcbklvUwFqvUuTtggBHuomoCFcUD7i+lO8cUPHja5Wy+bFkslRo7oD2R4Y6buTl9X99
         FZswDosikPLMEpwp98CQ2//dlDhabzvLVKDk03jHBQG94ZAFK3M717JBoLDFA4O8oPD0
         p3Twoy6Sbie2oIgWLpQGUuij5Jb5K7+qSQQxRA5TCBDRQ8rw8XCjZGfaVBGe1TAnBvJO
         ojww==
X-Gm-Message-State: AJIora/wjEJlyOl8nFrN08nI+bxoBUkBNwGBTjHreLwb7dIAURtoTtA5
        xbdzO5d4/vTv3KiMRryM0z+KignAQyVwig==
X-Google-Smtp-Source: AGRyM1vGM7WoTsCDjAm/pRnXDblKRzisQgoA2GpoRfzaTLDl0iP0ZMsyTomuWIie58fRybYOHkVAbMJibswRjQ==
X-Received: from riochico.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b3e])
 (user=rsilvera job=sendgmr) by 2002:a92:902:0:b0:2d8:ea84:e37c with SMTP id
 y2-20020a920902000000b002d8ea84e37cmr8562357ilg.214.1655743817146; Mon, 20
 Jun 2022 09:50:17 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:49:53 +0000
Message-Id: <20220620164953.1503934-1-rsilvera@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] perf: Adjust perf-inject output data offset for backward compatibility
From:   Raul Silvera <rsilvera@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Colin Ian King <colin.king@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Raul Silvera <rsilvera@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When perf inject creates a new file, it reuses the data offset from the
input file. If there has been a change on the size of the header, as
happened in v5.12 -> v5.13, the new offsets will be wrong, resulting in
a corrupted output file.

This change adds the function perf_session__data_offset to compute the
data offset based on the current header size, and uses that instead of
the offset from the original input file.

Signed-off-by: Raul Silvera <rsilvera@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/util/header.c    | 16 +++++++++++++++-
 tools/perf/util/header.h    |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a75bf11585b5..1dfdcef36607 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -916,7 +916,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.tracing_data = perf_event__repipe_tracing_data;
 	}
 
-	output_data_offset = session->header.data_offset;
+	output_data_offset = perf_session__data_offset(session->evlist);
 
 	if (inject->build_id_all) {
 		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 53332da100e8..93706ae827f1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3660,7 +3660,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 			.size   = evlist->core.nr_entries * sizeof(f_attr),
 		},
 		.data = {
-			.offset = header->data_offset,
+			.offset = attr_offset + evlist->core.nr_entries * sizeof(f_attr),
 			.size	= header->data_size,
 		},
 		/* event_types is ignored, store zeros */
@@ -3686,6 +3686,20 @@ int perf_session__write_header(struct perf_session *session,
 	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
 }
 
+size_t perf_session__data_offset(const struct evlist *evlist)
+{
+	struct evsel *evsel;
+	size_t data_offset;
+
+	data_offset = sizeof(struct perf_file_header);
+	evlist__for_each_entry(evlist, evsel) {
+		data_offset += evsel->core.ids * sizeof(u64);
+	}
+	data_offset += evlist->core.nr_entries * sizeof(struct perf_file_attr);
+
+	return data_offset;
+}
+
 int perf_session__inject_header(struct perf_session *session,
 				struct evlist *evlist,
 				int fd,
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 08563c1f1bff..56916dabce7b 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -136,6 +136,8 @@ int perf_session__inject_header(struct perf_session *session,
 				int fd,
 				struct feat_copier *fc);
 
+size_t perf_session__data_offset(const struct evlist *evlist);
+
 void perf_header__set_feat(struct perf_header *header, int feat);
 void perf_header__clear_feat(struct perf_header *header, int feat);
 bool perf_header__has_feat(const struct perf_header *header, int feat);
-- 
2.37.0.rc0.104.g0611611a94-goog

