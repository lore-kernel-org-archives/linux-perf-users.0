Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F49C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Jun 2022 15:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350635AbiFUP1h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350330AbiFUP1g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Jun 2022 11:27:36 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2D2A97A
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jun 2022 08:27:35 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id i8-20020a056e020d8800b002d931252904so906783ilj.23
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jun 2022 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pJAAMlUR9Ydzb8Wli4Gr9USgcKMSCgzvdDTXVExWOBs=;
        b=qvMB8LoBpaFQ3GQUCSoTnXYGKUdpDLi2qS9fSWosgFZW6a9vh5vMNU1YdL3ai8VSFt
         BX8jS4oYUYceNUIdKCV4t5VtNX7ciKWxzBUVh7uoogjUG7nvpus5g7xx4STaT7Y1dVT+
         xYYpueD6bCQPD3QgzWleZSHzHBVbVJpavqmsQiQdHu9PXOH9h0262IVju7GemWKC02N5
         O+FHafG00jsVpcDQhEdjF4ehUJaXGe9DVYR44q1LKMY088VRjUAABKLdu8NIABYQLb0C
         Ae0SBv82idmUhns6AGaP+MIdZlQQ2nQQUAlFlh+O+klmpFaCCgAq2CYiZ1ffmeNAXpIA
         CI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pJAAMlUR9Ydzb8Wli4Gr9USgcKMSCgzvdDTXVExWOBs=;
        b=Ehqb/UEwfrnEVSdhDanAttmWGzz5uqmKVgm+OA0USaWZhptbcGQPJX0aMfn9rILXJs
         xipQVG0cSWCzx5704X4VqFbtRcWYsHKhUOt4pDMGBnI1oRp6nZ5gCKGbjmMhHrwyMNCv
         zZwDhTnNYt3xy8FR0AalZElVLk9TKYORW6mDPejiow1ZzqQDJg8w1A2p3d2mVsyWe9Zg
         pc9MM7KSl6cL2oSeekjD+USWcCS8gD/LPnHoth/MFOpkVcEjbcrlNGNg/sqz3BfhdloF
         VBNRtWZxg4jpxBkx2+DdvOcKPQnIDGAJbnv4x+UOyFFq/vHz9aUVUvlMFPkOrd3r8Cng
         lTeg==
X-Gm-Message-State: AJIora/RzOVL+5/NC5V4KryjazwmAqDJ6yBVsGLmJ8pDM8NbtrZ9kNvm
        WOUQUb7Csg5Mnp7f/5JLXjcHJk423rJS1w==
X-Google-Smtp-Source: AGRyM1sxUjFEpBuJrnP39Ob4bVY8ckbZiuOog9KsddFGcK4Q2gPiLHpmQTwxlL016bzslu2xQYcvjIQqcGtHzQ==
X-Received: from riochico.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b3e])
 (user=rsilvera job=sendgmr) by 2002:a02:ac02:0:b0:339:c83a:f6f3 with SMTP id
 a2-20020a02ac02000000b00339c83af6f3mr2553704jao.174.1655825254515; Tue, 21
 Jun 2022 08:27:34 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:27:25 +0000
Message-Id: <20220621152725.2668041-1-rsilvera@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v2] perf: Adjust perf-inject output data offset for backward compatibility
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
Changes since v1:
 - Use the adjusted header->data_offset in do_write_header instead of
   recomputing it.
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/util/header.c    | 14 ++++++++++++++
 tools/perf/util/header.h    |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index 53332da100e8..6ad629db63b7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
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

