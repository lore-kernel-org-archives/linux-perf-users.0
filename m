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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B5C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B470F613F0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhGOQKp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhGOQKm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF6C061766;
        Thu, 15 Jul 2021 09:07:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f17so8496066wrt.6;
        Thu, 15 Jul 2021 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jnAP5IbnC2zCgq+4HdFt5yTacLKkXCnHyA/6fpXXTI=;
        b=Q52V+1zOzDLhRN44K5XN2+/wa35l5jVQzTrduwWrIrnEHxnj68uzfOAl69kVAvb1ff
         6Gge3PklpPXk9GvTATufcb5ee/18MQRstZJlARAeLDmgygHQAjacHxMJWeTt3sfxdpSO
         LLQJknzO1lZDz+XJUolgnQ84PO/dalKNUUuA2HmpYtr9hEJUm7y/B6IIKpDtuqIZFNO3
         dHcGKQHvfFnt4xTtRKJawApgwE78wfNLWembIp1xMCVh/bAVYXX28WBNerR+sjO1Kn7z
         JThO0r+zfoP+Gf8oXHmdT/6ZDtqiQ2wM58j8T7fB0IoshkOhDeBNz9fsYI1+Gntn81JV
         gojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jnAP5IbnC2zCgq+4HdFt5yTacLKkXCnHyA/6fpXXTI=;
        b=lgLS6XA/UVhed8xEdiYhIg7qEE1KdUpYDYt3aZ5VJRtBG5UppErzrytVEv03lIjERU
         j/mW+5bg0yFOIEf3a31ao/1l8GkhAoOKN/Yl4qfn1A2WwGIhWQaYweKgRmPR4gJfyt+A
         CpkuKu6Z9Rnsn0WHksVTZbjJwsjfqjx2WRorlGL9T7IbvM5uagwFAQc6aql7VMY+dzjf
         HIFf+3PK5Oq6JE7ivjy5247jq5px2+xU9uca5Hmtuc6/8TuC0gbjkzinF3x4XO6mNFRq
         KjFrKbzINIoFDyrZz2+AdB8Zn13wlr9KALi7LvMXg7tjulW/2lZUbojV+7+okmW2KnlH
         Ii1Q==
X-Gm-Message-State: AOAM5321oe3eUXs0ql31pAim6tk+OKbgiw5iVK4xbFCoFivI7/1KCqdF
        PwaG+fSVko65aV5bpts3iNs=
X-Google-Smtp-Source: ABdhPJzWl5ja1qFbl7BjZYNKXufJ2f8aEYDBj/372uNz9mGh2BGCUAkjt1hUY7KD5y95V/CS7XCsyw==
X-Received: by 2002:a5d:6dd1:: with SMTP id d17mr6643630wrz.344.1626365266010;
        Thu, 15 Jul 2021 09:07:46 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:45 -0700 (PDT)
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
Subject: [PATCH 16/20] perf trace: free syscall->arg_fmt
Date:   Thu, 15 Jul 2021 18:07:21 +0200
Message-Id: <d68f25c043d30464ac9fa79c3399e18f429bca82.1626343282.git.rickyman7@gmail.com>
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
The second of these leaks is caused by the arg_fmt field of syscall not
being deallocated.

This patch adds a new function syscall__exit which is called on all
syscalls.table entries in trace__exit, which will free the arg_fmt
field.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-trace.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fe26d87ca8ccc14d..d67f02d237eb0c7e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2266,6 +2266,14 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	return augmented_args;
 }
 
+static void syscall__exit(struct syscall *sc)
+{
+	if (!sc)
+		return;
+
+	free(sc->arg_fmt);
+}
+
 static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
@@ -4703,9 +4711,15 @@ static int trace__config(const char *var, const char *value, void *arg)
 
 static void trace__exit(struct trace *trace)
 {
+	int i;
+
 	strlist__delete(trace->ev_qualifier);
 	free(trace->ev_qualifier_ids.entries);
-	free(trace->syscalls.table);
+	if (trace->syscalls.table) {
+		for (i = 0; i <= trace->sctbl->syscalls.max_id; i++)
+			syscall__exit(&trace->syscalls.table[i]);
+		free(trace->syscalls.table);
+	}
 	syscalltbl__delete(trace->sctbl);
 	zfree(&trace->perfconfig_events);
 }
-- 
2.31.1

