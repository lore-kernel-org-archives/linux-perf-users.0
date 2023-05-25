Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A950C77B7E
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbjEYHMa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbjEYHMQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B5E68
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5653c160973so5965057b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998727; x=1687590727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bvqtZMaMVahHc8ltlI3yqPqIhhKvYIIrry65zbvjgo=;
        b=EvcEKepfQlDZdXfQ2topr18fG5SgrGkMrDGb6bXKfsk/E6u1iQDlvCXGEGeZSSJTY6
         j45Ul6s9ALG3dcVd6GYYuVE1gfcG593zZg6kIDNpNGJcV0JsjCBqSe9v+QKUrlUtA4VW
         6Z3iggxFzx2IKvwZaQ0Fr7Vrf9UrGS1G7IkwdNz0DF+AOVHcFcltf4ntb965lpeavXUX
         Eb3ksymwuH5wsVSv8xCnWbzN1Zq+CqWsqaqU1q+ONLCrRh0pZcM3JaobX0M/j9uKcH+D
         5YzBfhYJ7kXUv66f5KL2IQjA0oRxEAyJ/+6bgN0MgEtSyGKJ+le0h0b0VD/pj9jodrJc
         vB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998727; x=1687590727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bvqtZMaMVahHc8ltlI3yqPqIhhKvYIIrry65zbvjgo=;
        b=f8o2YHJHjFz0CQpcvnmwSjKgJ1815cM6ygTk0bgRwClKSl4Il9sIiZEjoMuvVST098
         ij0CJH5o0caTujPKfooewnGzc0UFQP9gyKTBFj7jtX5G+QfJgt4bpK9GuPn3IdAVDpKg
         5IROrpeTZ7YNF8yKRS3ZfvnmofukaxPGDV2gC1Z0yzF9ylL+b8VFREQ69gOEf2FlUT4q
         9WtGeggu8h70vbNIv+YqLu+2dIlgXdwPuNC63je4bCghGGp5QxvFmP86f//7YYk1MQw4
         t/Un9oo4Me8URWrl8oBj0rXBgYcwFKvjTkA09STkc3kBLqqfugFBC8az4mHyLS5dNhPL
         YvJQ==
X-Gm-Message-State: AC+VfDycNAPNCit6t5INXWS6MyfikMnH/ZVIF4utZd0z5/Pb0pkfwNxf
        lpY0zJphqUXSkXNaEsFofcNAtc9ycmU1
X-Google-Smtp-Source: ACHHUZ56KoRTg/8ZXkf+D/nXzC02q/vPfTREgKGfzN/3AV1a3sK4SMMvyr8WnSGo/ZkUQ9R4J0CmfpfV9C6Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ad27:0:b0:561:8fc0:24af with SMTP id
 l39-20020a81ad27000000b005618fc024afmr12304352ywh.9.1684998727652; Thu, 25
 May 2023 00:12:07 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:21 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-5-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 04/16] perf trace: Make some large static arrays const
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Allows the movement of 33,128 bytes from .data to .data.rel.ro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b49d3abb1203..62c7c99a0fe4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -914,7 +914,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #include "trace/beauty/socket_type.c"
 #include "trace/beauty/waitid_options.c"
 
-static struct syscall_fmt syscall_fmts[] = {
+static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
 	{ .name	    = "arch_prctl",
@@ -1176,18 +1176,21 @@ static int syscall_fmt__cmp(const void *name, const void *fmtp)
 	return strcmp(name, fmt->name);
 }
 
-static struct syscall_fmt *__syscall_fmt__find(struct syscall_fmt *fmts, const int nmemb, const char *name)
+static const struct syscall_fmt *__syscall_fmt__find(const struct syscall_fmt *fmts,
+						     const int nmemb,
+						     const char *name)
 {
 	return bsearch(name, fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
 }
 
-static struct syscall_fmt *syscall_fmt__find(const char *name)
+static const struct syscall_fmt *syscall_fmt__find(const char *name)
 {
 	const int nmemb = ARRAY_SIZE(syscall_fmts);
 	return __syscall_fmt__find(syscall_fmts, nmemb, name);
 }
 
-static struct syscall_fmt *__syscall_fmt__find_by_alias(struct syscall_fmt *fmts, const int nmemb, const char *alias)
+static const struct syscall_fmt *__syscall_fmt__find_by_alias(const struct syscall_fmt *fmts,
+							      const int nmemb, const char *alias)
 {
 	int i;
 
@@ -1199,7 +1202,7 @@ static struct syscall_fmt *__syscall_fmt__find_by_alias(struct syscall_fmt *fmts
 	return NULL;
 }
 
-static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+static const struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
 {
 	const int nmemb = ARRAY_SIZE(syscall_fmts);
 	return __syscall_fmt__find_by_alias(syscall_fmts, nmemb, alias);
@@ -1224,7 +1227,7 @@ struct syscall {
 	bool		    nonexistent;
 	struct tep_format_field *args;
 	const char	    *name;
-	struct syscall_fmt  *fmt;
+	const struct syscall_fmt  *fmt;
 	struct syscall_arg_fmt *arg_fmt;
 };
 
@@ -1673,7 +1676,7 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 	return 0;
 }
 
-static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
 	{ .name = "msr",	.scnprintf = SCA_X86_MSR,	  .strtoul = STUL_X86_MSR,	   },
 	{ .name = "vector",	.scnprintf = SCA_X86_IRQ_VECTORS, .strtoul = STUL_X86_IRQ_VECTORS, },
 };
@@ -1684,13 +1687,14 @@ static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
        return strcmp(name, fmt->name);
 }
 
-static struct syscall_arg_fmt *
-__syscall_arg_fmt__find_by_name(struct syscall_arg_fmt *fmts, const int nmemb, const char *name)
+static const struct syscall_arg_fmt *
+__syscall_arg_fmt__find_by_name(const struct syscall_arg_fmt *fmts, const int nmemb,
+				const char *name)
 {
        return bsearch(name, fmts, nmemb, sizeof(struct syscall_arg_fmt), syscall_arg_fmt__cmp);
 }
 
-static struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *name)
+static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *name)
 {
        const int nmemb = ARRAY_SIZE(syscall_arg_fmts__by_name);
        return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_name, nmemb, name);
@@ -1735,8 +1739,9 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
-               } else {
-			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
+		} else {
+			const struct syscall_arg_fmt *fmt =
+				syscall_arg_fmt__find_by_name(field->name);
 
 			if (fmt) {
 				arg->scnprintf = fmt->scnprintf;
@@ -4458,7 +4463,7 @@ static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt) {
-		struct syscall_fmt *scfmt = syscall_fmt__find(name);
+		const struct syscall_fmt *scfmt = syscall_fmt__find(name);
 
 		if (scfmt) {
 			int skip = 0;
@@ -4525,7 +4530,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	int len = strlen(str) + 1, err = -1, list, idx;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
-	struct syscall_fmt *fmt;
+	const struct syscall_fmt *fmt;
 
 	if (strace_groups_dir == NULL)
 		return -1;
-- 
2.40.1.698.g37aff9b760-goog

