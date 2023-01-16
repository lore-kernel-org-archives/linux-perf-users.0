Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F6C3DA78
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 01:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjAPBBj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 Jan 2023 20:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAPBBh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Jan 2023 20:01:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C7A25C
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 17:01:35 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id cr14-20020a056a000f0e00b0058da951c487so180881pfb.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=oVMWfsW34/mGzPMwBFwgP503Mmst6dTXQwRmf7yhjQV3T611RrXu8SUNd69diz8msL
         k2m6ORMzKffSio7JKlJDYGbJNzNcYNM/zi4Lh+Neq+n+22h8KgrCElrqrFrNrnrW9Fwt
         4Q0aMoJtNkCMGnvh5OijMMjPPrdIaHndXZd6eLelQTfo1IFemkORMu4h77rN+LVcOu6N
         pgHQSYw04OOZlUZjQ0ilOFIuOJMHbrpCoEgdIhWSmdlrkjyOIUDGbWBQLdvu3u2qmQbX
         mHHPhWZK+IL4rEZKsQXiNAi2erx1zf9lypve5krMuoHLn300TU+ofqNc6LiwuoX1klx+
         5Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=EL1sz+Be8ZHHvygvdGj4dDCy8wRVYN5yVEi+1fB9djI3m48nLRT7RDNb87uUQowtV2
         Uhl34V4j3CAqSIIV9wcRmyprq/ea4TivKETxiCQq58hDm6ZJ0ng9W+Sp+QYeNkrRrT3F
         nHD3rPkFrrWD/QA0ma2BmphNNTc5nD/k7KH5HT3T4UH1C6yoTzyYUd8bNPnwS/AUjC7J
         qEipzIqgiSB+anasFTDtpyB6dAOhLSk9Y9TtGml4hJFhTwt9J70slkvFqU3Ki0xatIX2
         wP3emVdnGkxA80e2B8hL58eM5dA1VUojiby6uOrxFZfn1GQqAHDF6anEtLyhDpLEsM7t
         h3Lw==
X-Gm-Message-State: AFqh2kq2f5FhgmuZxv8IE3m0OROPzFWerf+6/Oz9kvN4JSJhpdlrMaZL
        nMQKJG0A33YUw0NqKIjACbsOpPvXTDfS
X-Google-Smtp-Source: AMrXdXvaEANIV4ydnJVEVN/4TOnTdYZRjSst6vBFoO6VrG5s9o9TicPq79sqg2G3TQ4ogM26FcqU7DZSUxLt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:79e:5e8e:382c:e7ce])
 (user=irogers job=sendgmr) by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id
 pa13-20020a17090b264d00b002261564643cmr5421842pjb.206.1673830895350; Sun, 15
 Jan 2023 17:01:35 -0800 (PST)
Date:   Sun, 15 Jan 2023 17:01:13 -0800
In-Reply-To: <20230116010115.490713-1-irogers@google.com>
Message-Id: <20230116010115.490713-2-irogers@google.com>
Mime-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/3] tools build: Pass libbpf feature only if libbpf 1.0+
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libbpf 1.0 represented a cleanup and stabilization of APIs. Simplify
development by only passing the feature test if libbpf 1.0 is
installed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/build/feature/test-libbpf.c b/tools/build/feature/test-libbpf.c
index a508756cf4cc..cd9989f52119 100644
--- a/tools/build/feature/test-libbpf.c
+++ b/tools/build/feature/test-libbpf.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <bpf/libbpf.h>
 
+#if !defined(LIBBPF_MAJOR_VERSION) || (LIBBPF_MAJOR_VERSION < 1)
+#error At least libbpf 1.0 is required for Linux tools.
+#endif
+
 int main(void)
 {
 	return bpf_object__open("test") ? 0 : -1;
-- 
2.39.0.314.g84b9a713c41-goog

