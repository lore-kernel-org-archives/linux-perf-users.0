Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455A0C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbjEYHN5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbjEYHNP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:13:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B810FA
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56511755145so5937257b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998752; x=1687590752;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFIhQDFEKIUaqXH8KPF9Rc0UUB3N+wzcHQvTErnCb94=;
        b=aLvL4WUNiYGn7YqSRcIajOnoOp7Ns/caZgB3ExYe4cZKgG/JIeWjs77b4qdlx+2aOw
         O5+ULy5sQfwWCK7MTeyHd6GQNbrdbOB3bwe2wcONhK2EXX/cF/T1UplU0oDKpl2hULKV
         ToTt74ZMxzHkhY2Ah8nFyyxZ4We6xdS9uI6QD5FNOcJLSLwb/AtwZc2zkS3uMxyLvsVY
         2x5hKeZCVzAvzuBJIJlDxrGEFFeTthalhAvrs+cmSVyjyGCuFlytjzD6OGjBJRyzP/dF
         wVIEjApzHSFJdo8BjkiKXfLo4RvN1UcLW7zbSAirg1IniXJhiJ0tTiYQ2zmNGmURMeex
         tzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998752; x=1687590752;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tFIhQDFEKIUaqXH8KPF9Rc0UUB3N+wzcHQvTErnCb94=;
        b=gMOoXIb/bGcWb388PH+lYQFjlY8b9AQQ5lPKpX3fqrcFq4VpRr5DGWAdTwfftqtNP+
         /lbEBizv9lFDY9cnE1/0u1ATPzm8WIkcF4oMEumsRZWR6K5wUPsa0fnxDlNQ5F9YU01/
         FCnn8jL94i4Ze6MEI0+WEUBBg0VzWa9DjxS0iuuruC3mmbrZNyvtpdC3+eI2L5MkYU03
         svSWFl0dydS0Um1FYPeA8uN9IMTgpdhGqZf9u6mQ8LumOq/HkmigIOEJLgT+dOGRGGbu
         JOQETV9WJakqBuT2hbiHsCRKKhmVBOniEJRFAN7AguKGBH7jvSa5B95MUHaKl84k6gmN
         WDyg==
X-Gm-Message-State: AC+VfDz5d8fSd42VQnPIYx1ePe7k/BkTERBZDW5xI9y82wwsT0W4YLRe
        WVsfZrF9xbAT2ATEEnOwv4H/kJXLEsqS
X-Google-Smtp-Source: ACHHUZ4e3CApx3zDOiO4M4HximKdQvZpEhzdGnACtjgtnrPAYXZPGQWU/IsbgfrTndN+yHn8r8sr+WfvpL75
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:2511:0:b0:b9a:6508:1b5f with SMTP id
 l17-20020a252511000000b00b9a65081b5fmr1188695ybl.11.1684998752418; Thu, 25
 May 2023 00:12:32 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:32 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-16-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 15/16] perf test pmu: Avoid 2 static path arrays
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Avoid two static paths that contributed 8,192 bytes to .bss are only
used duing the perf parse pmu test. This change helps FORTIFY
triggering 2 warnings like:

```
tests/pmu.c: In function =E2=80=98test__pmu=E2=80=99:
tests/pmu.c:121:43: error: =E2=80=98%s=E2=80=99 directive output may be tru=
ncated writing up to 4095 bytes into a region of size 4090 [-Werror=3Dforma=
t-truncation=3D]
  121 |         snprintf(buf, sizeof(buf), "rm -f %s/*\n", dir);
```

So make buf a little larger.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 3cf25f883df7..a4452639a3d4 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -86,17 +86,16 @@ static struct parse_events_term test_terms[] =3D {
  * Prepare format directory data, exported by kernel
  * at /sys/bus/event_source/devices/<dev>/format.
  */
-static char *test_format_dir_get(void)
+static char *test_format_dir_get(char *dir, size_t sz)
 {
-	static char dir[PATH_MAX];
 	unsigned int i;
=20
-	snprintf(dir, PATH_MAX, "/tmp/perf-pmu-test-format-XXXXXX");
+	snprintf(dir, sz, "/tmp/perf-pmu-test-format-XXXXXX");
 	if (!mkdtemp(dir))
 		return NULL;
=20
 	for (i =3D 0; i < ARRAY_SIZE(test_formats); i++) {
-		static char name[PATH_MAX];
+		char name[PATH_MAX];
 		struct test_format *format =3D &test_formats[i];
 		FILE *file;
=20
@@ -118,12 +117,13 @@ static char *test_format_dir_get(void)
 /* Cleanup format directory. */
 static int test_format_dir_put(char *dir)
 {
-	char buf[PATH_MAX];
-	snprintf(buf, PATH_MAX, "rm -f %s/*\n", dir);
+	char buf[PATH_MAX + 20];
+
+	snprintf(buf, sizeof(buf), "rm -f %s/*\n", dir);
 	if (system(buf))
 		return -1;
=20
-	snprintf(buf, PATH_MAX, "rmdir %s\n", dir);
+	snprintf(buf, sizeof(buf), "rmdir %s\n", dir);
 	return system(buf);
 }
=20
@@ -140,7 +140,8 @@ static struct list_head *test_terms_list(void)
=20
 static int test__pmu(struct test_suite *test __maybe_unused, int subtest _=
_maybe_unused)
 {
-	char *format =3D test_format_dir_get();
+	char dir[PATH_MAX];
+	char *format =3D test_format_dir_get(dir, sizeof(dir));
 	LIST_HEAD(formats);
 	struct list_head *terms =3D test_terms_list();
 	int ret;
--=20
2.40.1.698.g37aff9b760-goog

