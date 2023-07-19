Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F18C001DC
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 20:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGSUte (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 16:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGSUtd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 16:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF21FED;
        Wed, 19 Jul 2023 13:49:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C448B6183B;
        Wed, 19 Jul 2023 20:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFC0C433C9;
        Wed, 19 Jul 2023 20:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799771;
        bh=UpIXw98xleRtWat9gzqiYLTx+YUEV/h5AHcduRz0D+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEXRxMJrFP/XDIveNjZ0NxFNqYfaNvIfalXAk5YT1ma0zjp9vX2pXPbD+VdYFBFgm
         cB8AZjF3cwGd/0alqe7e0/D2wU9Bc1syjBdbq5ZuZfOAaqZN2qRMUgA5yOfAAjSq6I
         AAjQwjOIKdrjs7hYAUeQrLOwDVkKPqNwu59FQiH7qeH32Ocy07bPfq63bbNHKzArFo
         y2j56WisF0Eh8oGHw6YR7MShJXoC6w37Vu0E4smV8Vk+hEc57txDVNVYeuokFP1NDK
         +LjwGf/20R2T19WZmOdN42bb50g5TLNizg2R+dW72u9FONA/Bmoax9ezf4imqQih9E
         nnzgj5KFoEN1A==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andre Fredette <anfredet@redhat.com>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/5] perf bench uprobe: Print diff to baseline
Date:   Wed, 19 Jul 2023 17:49:07 -0300
Message-ID: <20230719204910.539044-3-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719204910.539044-1-acme@kernel.org>
References: <20230719204910.539044-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is just prep work to show the diff to the unmodified workload.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andre Fredette <anfredet@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Dave Tucker <datucker@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/uprobe.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 707174220a76701f..60e7c43298d8cf56 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -34,6 +34,29 @@ static const char * const bench_uprobe_usage[] = {
 	NULL
 };
 
+static int bench_uprobe_format__default_fprintf(const char *name, const char *unit, u64 diff, FILE *fp)
+{
+	static u64 baseline;
+	s64 diff_to_baseline = diff - baseline;
+	int printed = fprintf(fp, "# Executed %'d %s calls\n", loops, name);
+
+	printed += fprintf(fp, " %14s: %'" PRIu64 " %ss", "Total time", diff, unit);
+
+	if (baseline)
+		printed += fprintf(fp, " %s%'" PRId64 " to baseline", diff_to_baseline > 0 ? "+" : "", diff_to_baseline);
+
+	printed += fprintf(fp, "\n\n %'.3f %ss/op", (double)diff / (double)loops, unit);
+
+	if (baseline)
+		printed += fprintf(fp, " %'.3f %ss/op to baseline", (double)diff_to_baseline / (double)loops, unit);
+	else
+		baseline = diff;
+
+	fputc('\n', fp);
+
+	return printed + 1;
+}
+
 static int bench_uprobe(int argc, const char **argv)
 {
 	const char *name = "usleep(1000)", *unit = "usec";
@@ -56,9 +79,7 @@ static int bench_uprobe(int argc, const char **argv)
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
-		printf("# Executed %'d %s calls\n", loops, name);
-		printf(" %14s: %'" PRIu64 " %ss\n\n", "Total time", diff, unit);
-		printf(" %'.3f %ss/op\n", (double)diff / (double)loops, unit);
+		bench_uprobe_format__default_fprintf(name, unit, diff, stdout);
 		break;
 
 	case BENCH_FORMAT_SIMPLE:
-- 
2.41.0

