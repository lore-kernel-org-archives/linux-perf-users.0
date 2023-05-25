Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA9C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbjEYHOA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbjEYHNQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:13:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5EA1702
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5654c7f991bso6859077b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998755; x=1687590755;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUbHbSjVoUcJs86GoUKywFnnspnn0CwjY1A+xgeJcrE=;
        b=7LtR4l2JL/M4jrlSVU40EKtOPMO9N0dHxSoR2A3E+/SFXlYWvUTFqVwUxLJUSGlzDV
         F6u5E3ufJCkrh98qSFG5E9ePrbrARJkjqi9c1X5Xttcmj/6EVj4j2RBPb8B3ZL+Amrki
         yj3ZkWUqMrq7qgqbXOH+Q+Zx7PkrJQaD9q9U/zGCebFeL2Yo17ojkCnQ60ZOmbXfptTv
         ezVT76QHlFCtJvzF54v9e5KRtWbnKLSESLXIBy9oAHjzUYpyfy/+p/fmc3NOZgZCsB+D
         CPWb/PhGo7Drd9gjoehm7CMbM1mCV3R16jIFa7AUSXDPfXFXWql0HqQM9qAInpOaZ/xA
         20RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998755; x=1687590755;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUbHbSjVoUcJs86GoUKywFnnspnn0CwjY1A+xgeJcrE=;
        b=HCnwxzSTxA6nYcRZO98gN2JWjKu2MUp9+Rfi6FCtqpLTRoe1V1TIOj+MZdoc3xcmQF
         cyvmOoo32g1ywsM1qaF1mVr0KU0peelVqU7ftfJpq0Fno1+5YmAofXWY7XP2V464kDvr
         WlRQRT+u9lgl9d5+gVrpBDErgVOVGapQzaDjyIy1w+bgFk/ps2DsF3N1lQ/Ez/0I0J0e
         gvt6z4ER4tGAV+3iGoqH7hekoFALzSFv2yVlDPnW4MOdPOf6/Qa8wFc3oIn4jgIj9tfX
         L/9BVeShZRn5v6YI8tpAP7VWOSndZDN3hPECGzdInBcTN+r/+nR30rCQ36dmEk6F0Dv+
         9rHA==
X-Gm-Message-State: AC+VfDwmgXE3rOVdBNUW9+ohZKsB0mzaWvBVx2gl+K7XeulXk+ei9w/c
        0kvkq32QdpS1V7Xwie45fCVKB1pRxbto
X-Google-Smtp-Source: ACHHUZ6DYMEKjWI2+BEz4r2CwS0UkrArsaV42OVmb0uVNSR+netmY8Zy2pEdzoCY7oajTqfSioq+92W7Wt0s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ae68:0:b0:55e:14b:bab9 with SMTP id
 g40-20020a81ae68000000b0055e014bbab9mr12549654ywk.4.1684998754691; Thu, 25
 May 2023 00:12:34 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:33 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-17-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 16/16] libsubcmd: Avoid two path statics
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

Use a single stack allocated buffer and avoid 8,192 bytes in .bss.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/exec-cmd.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
index 5dbea456973e..7739b5217cf6 100644
--- a/tools/lib/subcmd/exec-cmd.c
+++ b/tools/lib/subcmd/exec-cmd.c
@@ -36,38 +36,40 @@ static int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 
-static const char *get_pwd_cwd(void)
+static const char *get_pwd_cwd(char *buf, size_t sz)
 {
-	static char cwd[PATH_MAX + 1];
 	char *pwd;
 	struct stat cwd_stat, pwd_stat;
-	if (getcwd(cwd, PATH_MAX) == NULL)
+	if (getcwd(buf, sz) == NULL)
 		return NULL;
 	pwd = getenv("PWD");
-	if (pwd && strcmp(pwd, cwd)) {
-		stat(cwd, &cwd_stat);
+	if (pwd && strcmp(pwd, buf)) {
+		stat(buf, &cwd_stat);
 		if (!stat(pwd, &pwd_stat) &&
 		    pwd_stat.st_dev == cwd_stat.st_dev &&
 		    pwd_stat.st_ino == cwd_stat.st_ino) {
-			strlcpy(cwd, pwd, PATH_MAX);
+			strlcpy(buf, pwd, sz);
 		}
 	}
-	return cwd;
+	return buf;
 }
 
-static const char *make_nonrelative_path(const char *path)
+static const char *make_nonrelative_path(char *buf, size_t sz, const char *path)
 {
-	static char buf[PATH_MAX + 1];
-
 	if (is_absolute_path(path)) {
-		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+		if (strlcpy(buf, path, sz) >= sz)
 			die("Too long path: %.*s", 60, path);
 	} else {
-		const char *cwd = get_pwd_cwd();
+		const char *cwd = get_pwd_cwd(buf, sz);
+
 		if (!cwd)
 			die("Cannot determine the current working directory");
-		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
+
+		if (strlen(cwd) + strlen(path) + 2 >= sz)
 			die("Too long path: %.*s", 60, path);
+
+		strcat(buf, "/");
+		strcat(buf, path);
 	}
 	return buf;
 }
@@ -133,8 +135,11 @@ static void add_path(char **out, const char *path)
 	if (path && *path) {
 		if (is_absolute_path(path))
 			astrcat(out, path);
-		else
-			astrcat(out, make_nonrelative_path(path));
+		else {
+			char buf[PATH_MAX];
+
+			astrcat(out, make_nonrelative_path(buf, sizeof(buf), path));
+		}
 
 		astrcat(out, ":");
 	}
-- 
2.40.1.698.g37aff9b760-goog

