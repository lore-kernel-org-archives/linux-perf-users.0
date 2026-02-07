Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF230C619
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452691; cv=none; b=Ls1fmgeDH/qLema+79OftInY6JS18q5AiiCX/NkLTYM2VcMmxSNeGgmLtn80KYEtnFXFeJHh+Z+9CAo1v573b3hT7+L+vuluE9Gu4Qunfia3pnfsqcR2lrr9gXk836JMJAdtXr+76mwwep18zw/SNmncP7eK3ff2cWtPCuiSlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452691; c=relaxed/simple;
	bh=N96xkMpy5lP+7H0aWH6pC7j/S+oT22nm8lNiuaa5llA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OHedgzQRPIyfGyiEHJ06/d3ove6gx00yYBlG3pkiidc1qwNciUlijNx6GaHPiM5rq9eDuZYfIyQ7phXPFw6V2NtsJPYx17tuzbkbl8m+KecesS1AQxZ9Ed8/dgGgsMjPYbVosYwr+ZELu5MqStzCxYhi/o5Na4gOjjExrTvPaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4DZLGgf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4DZLGgf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so91311c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 00:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770452691; x=1771057491; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73S70KhFl7MAoO9qRsIjn211Skfv7Zjtw2IW8M3qYRk=;
        b=V4DZLGgfOnwdYAODUs8NQEZVtzb5x1RYT8WITEPDdYaBNRz5uBcVMTYidITua85lKK
         L/L6zxBhlTs7QAOL2Yqc++Sjzm9Hg+rz+xOOCbUUhsoMbRlc4o+m7A3u703vn4xQu1s/
         zeUH9ICiAQW2nvDj3U60ielvZaAOsm+iXt5OVFyOQAnkntitiRx6k+SOo9X8zdxRsBKi
         bGpTarDgM6DOXqoVnKnCxZYTJN5eZ4Z0Y9ixL8+RSnVGO41ukOsl3fdLeOlQpl4jwcSE
         VmyJD+XUtfLl6vupK1p0oCo8vsdYGXGigzpka3NRkq8P9u/2+c6eLuytDpA6QRlXNgx3
         Z/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452691; x=1771057491;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73S70KhFl7MAoO9qRsIjn211Skfv7Zjtw2IW8M3qYRk=;
        b=q8uAu/9pQ37xCqwuSXlXMbTQEWuN/2WIo8hWiC+CEr52oUKKf3WNzYdGsE/gfk1bu2
         lmr8bvUoBMaXle3bce55LSg3l8g9wSgoRv9uPrRVICGiojmBBjpg0Xvn6lVWBJDVfWzW
         HoiABwhMhKsiwBTTTiAnGtd3/gnilnKCbxo0ZZzKA0NPKB8mUgX7qzdtbZLKV52WKAqE
         RzyokBUnwcFAk/YLw4lpIUglMYwXyBlVMEtRgJKLwVQsOO6lY5J0vj+ilbGu2Ov9dVZo
         cQpEzEwMGaZK4AP9pJD6vj+P4Cdw5NtjYzNqel8ocKU7YU8wSn4itraiklAklzFQiHFd
         vY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZKRx84BhxknZC3Cqpl9N5CjHKukbdz9KY7zQreZl7nnJlQ/3Lfk0c6+nvGecXVpmj9PHjeZPZ2KkO30Hv6lea@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AI+MLV91/wLeaOek3dHoYfLyXt+Cv9t/EWMiQTx800MyE2TT
	AwVkoK+C+Kyw3isM9HMd31tSbZ2/cT0m//CAdq3DBSrFv65yOZV6bTLTSdzdTytG2dpOItJKlfQ
	+UU7y4CficA==
X-Received: from dlbcy24.prod.google.com ([2002:a05:7022:b98:b0:126:faf3:bc29])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4a2:b0:11b:d211:3a64
 with SMTP id a92af1059eb24-12703e8f4c7mr2884395c88.0.1770452690831; Sat, 07
 Feb 2026 00:24:50 -0800 (PST)
Date: Sat,  7 Feb 2026 00:24:26 -0800
In-Reply-To: <20260207082428.1742209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207082428.1742209-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207082428.1742209-4-irogers@google.com>
Subject: [PATCH v1 3/5] perf tool: Constify the command and option arrays
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reduce scope and capture immutability.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index f475a8664ffc..1f51e8de6b1b 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -48,7 +48,7 @@ struct cmd_struct {
 	int option;
 };
 
-static struct cmd_struct commands[] = {
+static const struct cmd_struct commands[] = {
 	{ "archive",	NULL,	0 },
 	{ "buildid-cache", cmd_buildid_cache, 0 },
 	{ "buildid-list", cmd_buildid_list, 0 },
@@ -178,7 +178,7 @@ static int set_debug_file(const char *path)
 	return 0;
 }
 
-struct option options[] = {
+static const struct option options[] = {
 	OPT_ARGUMENT("help", "help"),
 	OPT_ARGUMENT("version", "version"),
 	OPT_ARGUMENT("exec-path", "exec-path"),
@@ -280,7 +280,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			unsigned int i;
 
 			for (i = 0; i < ARRAY_SIZE(commands); i++) {
-				struct cmd_struct *p = commands+i;
+				const struct cmd_struct *p = commands + i;
 				printf("%s ", p->cmd);
 			}
 			putchar('\n');
@@ -289,7 +289,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			unsigned int i;
 
 			for (i = 0; i < ARRAY_SIZE(options)-1; i++) {
-				struct option *p = options+i;
+				const struct option *p = options + i;
 				printf("--%s ", p->long_name);
 			}
 			putchar('\n');
@@ -331,7 +331,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 #define RUN_SETUP	(1<<0)
 #define USE_PAGER	(1<<1)
 
-static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
+static int run_builtin(const struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
 	struct stat st;
@@ -390,7 +390,7 @@ static void handle_internal_command(int argc, const char **argv)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
+		const struct cmd_struct *p = commands+i;
 		if (p->fn == NULL)
 			continue;
 		if (strcmp(p->cmd, cmd))
-- 
2.53.0.239.g8d8fc8a987-goog

