Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B07C1B08C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4526B613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhGOQKp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhGOQKl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA5C061764;
        Thu, 15 Jul 2021 09:07:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a13so8447665wrf.10;
        Thu, 15 Jul 2021 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZshargtdxqaqsfQ8d4ivGY1bLIAzrAXHZBo9tMNpdQ=;
        b=AnTbKmorwji+sbPMx/bxg/fOO2Nz+yKeEhOuo1yEANxiwlN4sQj4/+Wdu9kgmQExLh
         U/h+hmKc/rJ9q3mazMWm39fktKKeDL/6XzINg5uSRNXCP+nI84qH/rm3NXS1zglB3nNm
         +e3Y7s4Pq3bZlp3KRpygJMQ/XUpRlG4OeDUn1F+FGDLOkMA0wbg+e4gqNxZ8gUjeBZCv
         7LwzFkXLaB56ziGluUKGXo3gVk7MYCMEMx9KpAIvHEjkL4tGwCyAO7PvzwQ5YdcvQ7G7
         r9ZpTU7nEKxRs2SMd2pez7oEzegjIDTJufNmzk+/fXW8/hN95vs3/LcUZU9eeeIVAfOS
         NisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZshargtdxqaqsfQ8d4ivGY1bLIAzrAXHZBo9tMNpdQ=;
        b=UND63w6zQH4TPkqe586EyjPJi5OPVlM12DbotNJ5r+9aLGH8zmNdarB2RQS2jEvLQu
         5tXqBpz2ZnUTsraGd8R/MZfdrilx/eYybWky17Bmb9QZX1bS+vo7XKFkSB6fNQirHFOF
         XSgs/T4w2GxZ9clvv68wOy5MI5BUjO7kMI/ocyaf53jw8SsuQK3ERs+uYFv3//cYdt03
         QE3wn5fWEPGdroPoQKSEPH6ZJEzljekzP1YZjzWEKH0RjCjAKwjSHHyxxfoqW0tbwFkb
         CM2CPCASC9WCusnijZIzw9+RpXKrBVcyNMR5kFSW4dRI+JX5Cqe0fqIlJYlYHDoMgDpb
         Deng==
X-Gm-Message-State: AOAM533M3Ips5a3OknywAOMgH7ReTnewDMRYhjkffRc8H/cFosOkIXBq
        qMXZT5qQY8kyTWgx1LISqsg=
X-Google-Smtp-Source: ABdhPJzCK62T/R1ZYwqkOnTvLlDFHZ46elA2lVubJYN03CQTYKlt7iG4AhEmraX4XjYt/OmGQtid1Q==
X-Received: by 2002:adf:fcd0:: with SMTP id f16mr6701606wrs.368.1626365264970;
        Thu, 15 Jul 2021 09:07:44 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:44 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH 15/20] perf trace: free malloc'd trace fields on exit
Date:   Thu, 15 Jul 2021 18:07:20 +0200
Message-Id: <de5945ed5c0cb882cbfa3268567d0bff460ff016.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports several memory leaks running the perf test
"88: Check open filename arg using perf trace + vfs_getname".
The first of these leaks is related to struct trace fields never being
deallocated.

This patch adds the function trace__exit, which is called at the end of
cmd_trace, replacing the existing deallocation, which is now moved
inside the new function.
This function deallocates:
 - ev_qualifier
 - ev_qualifier_ids.entries
 - syscalls.table
 - sctbl
 - perfconfig_events

In order to prevent errors in case any of this field is never
initialized, this patch also adds initialization to NULL to these
fields.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-trace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7ec18ff57fc4ae35..fe26d87ca8ccc14d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4701,6 +4701,15 @@ static int trace__config(const char *var, const char *value, void *arg)
 	return err;
 }
 
+static void trace__exit(struct trace *trace)
+{
+	strlist__delete(trace->ev_qualifier);
+	free(trace->ev_qualifier_ids.entries);
+	free(trace->syscalls.table);
+	syscalltbl__delete(trace->sctbl);
+	zfree(&trace->perfconfig_events);
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -4731,6 +4740,12 @@ int cmd_trace(int argc, const char **argv)
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
+		.ev_qualifier = NULL,
+		.sctbl = NULL,
+		.ev_qualifier_ids = {
+			.entries = NULL,
+			.nr = 0,
+		},
 	};
 	const char *map_dump_str = NULL;
 	const char *output_name = NULL;
@@ -5135,6 +5150,6 @@ int cmd_trace(int argc, const char **argv)
 	if (output_name != NULL)
 		fclose(trace.output);
 out:
-	zfree(&trace.perfconfig_events);
+	trace__exit(&trace);
 	return err;
 }
-- 
2.31.1

