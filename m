Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041DFC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB4A61058
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhHYRA1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhHYRA1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 13:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B70161056;
        Wed, 25 Aug 2021 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629910781;
        bh=8svIy2DRVAvuqk85qjTGG0b4XCqSnyOm8NGC7jWY43s=;
        h=Date:From:To:Cc:Subject:From;
        b=V52Fw0cLMHnWjAoVMx0L7zHx0026uWghVh43nB/nZnIuE8v4YLlvuN6Hs6TuwgNyu
         GVbjz9NbvOoIcK/EFeG9Guxj7WW3hk/EIuz6cn4lsIQ4tPxY34ImIx0E5SitxkUMwg
         P1YQefnq1Pg7YAyyoGFeLCn0vpbHt6RyP9qimPCNU0vszrfgR5pPtO2IEWc+u7+b1N
         P0Vf077jyqT+t/JN3ue+jTNSPQ5F5HB79vNjOQ2ByVY2vo+spzsQxdmBc9gvG2YZF4
         XkR8KoYRb9o9CQOD/BD6ObUZhosO+5taJEYhHF4tgXWizoBkseaO6O8uOKLq0MOIYp
         zwRDcC5KXKksw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0D834007E; Wed, 25 Aug 2021 13:59:37 -0300 (-03)
Date:   Wed, 25 Aug 2021 13:59:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf bench inject-buildid: Handle writen() errors
Message-ID: <YSZ2+Wvt2Kjq6twd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,

	Please check and ack,

- Arnaldo

From 4e5caa5fbe6955dd26336a0b106c52b98c793f3b Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 25 Aug 2021 11:50:37 -0300
Subject: [PATCH 1/2] perf bench inject-buildid: Handle writen() errors

The build on fedora:35 and fedora:rawhide with clang is failing with:

  49    41.00 fedora:35                     : FAIL clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
    bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
            u64 len = 0;
                ^
    1 error generated.
    make[3]: *** [/git/perf-5.14.0-rc7/tools/build/Makefile.build:139: bench] Error 2
  50    41.11 fedora:rawhide                : FAIL clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
    bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
            u64 len = 0;
                ^
    1 error generated.
    make[3]: *** [/git/perf-5.14.0-rc7/tools/build/Makefile.build:139: bench] Error 2

That 'len' variable is not used at all, so just make sure all the
synthesize_RECORD() routines return ssize_t to propagate the writen()
return, as it may fail, ditch the 'ret' var and bail out if those
routines fail.

Fixes: 0bf02a0d80427f26 ("perf bench: Add build-id injection benchmark")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/inject-buildid.c | 52 ++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 55d373b75791b0e4..17672790f1231acc 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -133,7 +133,7 @@ static u64 dso_map_addr(struct bench_dso *dso)
 	return 0x400000ULL + dso->ino * 8192ULL;
 }
 
-static u32 synthesize_attr(struct bench_data *data)
+static ssize_t synthesize_attr(struct bench_data *data)
 {
 	union perf_event event;
 
@@ -151,7 +151,7 @@ static u32 synthesize_attr(struct bench_data *data)
 	return writen(data->input_pipe[1], &event, event.header.size);
 }
 
-static u32 synthesize_fork(struct bench_data *data)
+static ssize_t synthesize_fork(struct bench_data *data)
 {
 	union perf_event event;
 
@@ -169,8 +169,7 @@ static u32 synthesize_fork(struct bench_data *data)
 	return writen(data->input_pipe[1], &event, event.header.size);
 }
 
-static u32 synthesize_mmap(struct bench_data *data, struct bench_dso *dso,
-			   u64 timestamp)
+static ssize_t synthesize_mmap(struct bench_data *data, struct bench_dso *dso, u64 timestamp)
 {
 	union perf_event event;
 	size_t len = offsetof(struct perf_record_mmap2, filename);
@@ -198,23 +197,25 @@ static u32 synthesize_mmap(struct bench_data *data, struct bench_dso *dso,
 
 	if (len > sizeof(event.mmap2)) {
 		/* write mmap2 event first */
-		writen(data->input_pipe[1], &event, len - bench_id_hdr_size);
+		if (writen(data->input_pipe[1], &event, len - bench_id_hdr_size) < 0)
+			return -1;
 		/* zero-fill sample id header */
 		memset(id_hdr_ptr, 0, bench_id_hdr_size);
 		/* put timestamp in the right position */
 		ts_idx = (bench_id_hdr_size / sizeof(u64)) - 2;
 		id_hdr_ptr[ts_idx] = timestamp;
-		writen(data->input_pipe[1], id_hdr_ptr, bench_id_hdr_size);
-	} else {
-		ts_idx = (len / sizeof(u64)) - 2;
-		id_hdr_ptr[ts_idx] = timestamp;
-		writen(data->input_pipe[1], &event, len);
+		if (writen(data->input_pipe[1], id_hdr_ptr, bench_id_hdr_size) < 0)
+			return -1;
+
+		return len;
 	}
-	return len;
+
+	ts_idx = (len / sizeof(u64)) - 2;
+	id_hdr_ptr[ts_idx] = timestamp;
+	return writen(data->input_pipe[1], &event, len);
 }
 
-static u32 synthesize_sample(struct bench_data *data, struct bench_dso *dso,
-			     u64 timestamp)
+static ssize_t synthesize_sample(struct bench_data *data, struct bench_dso *dso, u64 timestamp)
 {
 	union perf_event event;
 	struct perf_sample sample = {
@@ -233,7 +234,7 @@ static u32 synthesize_sample(struct bench_data *data, struct bench_dso *dso,
 	return writen(data->input_pipe[1], &event, event.header.size);
 }
 
-static u32 synthesize_flush(struct bench_data *data)
+static ssize_t synthesize_flush(struct bench_data *data)
 {
 	struct perf_event_header header = {
 		.size = sizeof(header),
@@ -348,14 +349,16 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 	int status;
 	unsigned int i, k;
 	struct rusage rusage;
-	u64 len = 0;
 
 	/* this makes the child to run */
 	if (perf_header__write_pipe(data->input_pipe[1]) < 0)
 		return -1;
 
-	len += synthesize_attr(data);
-	len += synthesize_fork(data);
+	if (synthesize_attr(data) < 0)
+		return -1;
+
+	if (synthesize_fork(data) < 0)
+		return -1;
 
 	for (i = 0; i < nr_mmaps; i++) {
 		int idx = rand() % (nr_dsos - 1);
@@ -363,13 +366,18 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 		u64 timestamp = rand() % 1000000;
 
 		pr_debug2("   [%d] injecting: %s\n", i+1, dso->name);
-		len += synthesize_mmap(data, dso, timestamp);
+		if (synthesize_mmap(data, dso, timestamp) < 0)
+			return -1;
 
-		for (k = 0; k < nr_samples; k++)
-			len += synthesize_sample(data, dso, timestamp + k * 1000);
+		for (k = 0; k < nr_samples; k++) {
+			if (synthesize_sample(data, dso, timestamp + k * 1000) < 0)
+				return -1;
+		}
 
-		if ((i + 1) % 10 == 0)
-			len += synthesize_flush(data);
+		if ((i + 1) % 10 == 0) {
+			if (synthesize_flush(data) < 0)
+				return -1;
+		}
 	}
 
 	/* this makes the child to finish */
-- 
2.31.1

