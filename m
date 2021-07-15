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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F9BC47E4D
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5D6613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhGOQKq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbhGOQKm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B956C061768;
        Thu, 15 Jul 2021 09:07:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k4so8453306wrc.8;
        Thu, 15 Jul 2021 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=riEbMkvLA7aRiLgBpIs6UlI0MS+Z3HsL/W5MKJdNIMY=;
        b=k5+JAsd32MWe2dZpwzJO4FKgJAZV83Z/yxjSKfQ/XLshtCjwq6A2e5ztwzgAZsXpQ5
         SmaisksLGvD5mGVcemq4c2hKq2WX1JqTLBlyE+80T1PzIoAIKP+GfA4vWfgCwUa+NbMf
         rLpookaBNL0oh70n+d9wGKu9iKmodhsJgZFisRo0b+WBdesq0SUCFLZdmNp27ycKPf3o
         KK6zVlRGUuwLE1PkstgDBg8u4YulOW6zUxFuS7KcdZWvH+s41APVmxglbleih0Ktnl1F
         HBokglF2JvspLxpIkxzysc1IdJblw47ZQFlmuFv8YbuHu/soUolrDRXlwJvlVJ2Qh7X0
         gE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=riEbMkvLA7aRiLgBpIs6UlI0MS+Z3HsL/W5MKJdNIMY=;
        b=XY79uvbxtnXdWIDC6IwnpALUuKOaG232AaA1FQQck4QtAMDDq84CI5rAKQiidgDKMT
         Ik0N+DKqf3ST6yrckOaFdoUH1zS0zgrGTorKWbyu92zuIpXMMi5HACxba5Uz68/yMnWV
         JpG34f4jr2ijqH+sloUS90gR+vN4ZXQUzDCkknozbAplBbclOZ0kLVoyS3NEgKnYcUiO
         H8Q7g0boMf9LIP00IsvQ9NLQkWfdgSDZKbv4SQw2N8K4hTJukb+GDkgl0A5j3kRaQ+a8
         6h86YJ4Dp1SZHbrl44KjN/hSCmaTjmjaS13/4Qsqkry0F6otx6JyQo/pAlZDdOUez5c4
         mLAA==
X-Gm-Message-State: AOAM532zX9V8GwvjDKGmmT+jwto68u98FN7g4zlnE5XeY8kN1Cg5NHkW
        HY28gQ5BJ5c9mdALyg7rpNI=
X-Google-Smtp-Source: ABdhPJwq6d+CiLmxUmfWqcCSuwWYHJQstvf3d+50FXn+KFvoyv6OdV4ZwfHD/PZuAn5AF9CGI5eNTA==
X-Received: by 2002:adf:e7c6:: with SMTP id e6mr6581717wrn.221.1626365266970;
        Thu, 15 Jul 2021 09:07:46 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:46 -0700 (PDT)
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
Subject: [PATCH 17/20] perf trace: free syscall tp fields in evsel->priv
Date:   Thu, 15 Jul 2021 18:07:22 +0200
Message-Id: <46526611904ec5ff2768b59014e3afce8e0197d1.1626343282.git.rickyman7@gmail.com>
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
The third of these leaks is related to evsel->priv fields of sycalls never
being deallocated.

This patch adds the function evlist__free_syscall_tp_fields which
iterates over all evsels in evlist, matching syscalls, and calling the
missing frees.
This new function is called at the end of trace__run, right before
calling evlist__delete.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-trace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d67f02d237eb0c7e..d9c65d55a9ae7526 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3103,6 +3103,21 @@ static struct evsel *evsel__new_pgfault(u64 config)
 	return evsel;
 }
 
+static void evlist__free_syscall_tp_fields(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct evsel_trace *et = evsel->priv;
+
+		if (!et || !evsel->tp_format || strcmp(evsel->tp_format->system, "syscalls"))
+			continue;
+
+		free(et->fmt);
+		free(et);
+	}
+}
+
 static void trace__handle_event(struct trace *trace, union perf_event *event, struct perf_sample *sample)
 {
 	const u32 type = event->header.type;
@@ -4138,7 +4153,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 out_delete_evlist:
 	trace__symbols__exit(trace);
-
+	evlist__free_syscall_tp_fields(evlist);
 	evlist__delete(evlist);
 	cgroup__put(trace->cgroup);
 	trace->evlist = NULL;
-- 
2.31.1

