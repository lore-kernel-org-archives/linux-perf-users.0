Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E81514DC
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246817; cv=none; b=RmbOLUEYqPHsOJYswY8DmxWQvptsB6S/69o/ypKtY8DacZP8TCIxKvu4t+MwYjRHLpv19qoTFNduppJFL/3u06+RENMJ8eQCl3hEw8c0+RFJ4zJ9/is7EhCGgiM8i9dDvLdizHKd1Bj3Ld7Ieh0gD76q4xTaZcn0DbLJK5UoRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246817; c=relaxed/simple;
	bh=/TqMwuB1+zcy7mGpNuVeilWEYV9vQCViFdYalzT4ZX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fr9vgOCBQr0lKYPG4m6qCCLIU1N3yTPmi4LxE32px/MfQgarULpzxHxkNHke4XjNkjej7q+FzDEptLWPkOWuZnh6K5egOqSLl+x9NIj7o0n+AMBHo7uWsrxnSZIb5iRIfRFcxvqPG2nUywIrYFSzWMwVn3hdnZY+bDf94+FQy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0AB13D5;
	Sat,  1 Jun 2024 06:00:39 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 365B03F792;
	Sat,  1 Jun 2024 06:00:12 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 05/10] libsubcmd: Replace strstarts() usage with str_has_prefix()
Date: Sat,  1 Jun 2024 18:29:41 +0530
Message-Id: <20240601125946.1741414-6-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

Calls to strstarts() are replaced with str_has_prefix() to unify the
string comparison functions between tools/ and the kernel.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/lib/subcmd/help.c          |  2 +-
 tools/lib/subcmd/parse-options.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 8561b0f01a24..589ecdab9318 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -196,7 +196,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 	while ((de = readdir(dir)) != NULL) {
 		int entlen;
 
-		if (!strstarts(de->d_name, prefix))
+		if (!str_has_prefix(de->d_name, prefix))
 			continue;
 
 		astrcat(&buf, de->d_name);
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 4b60ec03b0bb..b3206d46e2b7 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -390,7 +390,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			return 0;
 		}
 		if (!rest) {
-			if (strstarts(options->long_name, "no-")) {
+			if (str_has_prefix(options->long_name, "no-")) {
 				/*
 				 * The long name itself starts with "no-", so
 				 * accept the option without "no-" so that users
@@ -403,7 +403,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 					goto match;
 				}
 				/* Abbreviated case */
-				if (strstarts(options->long_name + 3, arg)) {
+				if (str_has_prefix(options->long_name + 3, arg)) {
 					flags |= OPT_UNSET;
 					goto is_abbreviated;
 				}
@@ -428,7 +428,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 				continue;
 			}
 			/* negated and abbreviated very much? */
-			if (strstarts("no-", arg)) {
+			if (str_has_prefix("no-", arg)) {
 				flags |= OPT_UNSET;
 				goto is_abbreviated;
 			}
@@ -438,7 +438,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			flags |= OPT_UNSET;
 			rest = skip_prefix(arg + 3, options->long_name);
 			/* abbreviated and negated? */
-			if (!rest && strstarts(options->long_name, arg + 3))
+			if (!rest && str_has_prefix(options->long_name, arg + 3))
 				goto is_abbreviated;
 			if (!rest)
 				continue;
@@ -478,7 +478,7 @@ static void check_typos(const char *arg, const struct option *options)
 	if (strlen(arg) < 3)
 		return;
 
-	if (strstarts(arg, "no-")) {
+	if (str_has_prefix(arg, "no-")) {
 		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 		exit(129);
 	}
@@ -486,7 +486,7 @@ static void check_typos(const char *arg, const struct option *options)
 	for (; options->type != OPTION_END; options++) {
 		if (!options->long_name)
 			continue;
-		if (strstarts(options->long_name, arg)) {
+		if (str_has_prefix(options->long_name, arg)) {
 			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 			exit(129);
 		}
@@ -981,10 +981,10 @@ int parse_options_usage(const char * const *usagestr,
 		if (opts->long_name == NULL)
 			continue;
 
-		if (strstarts(opts->long_name, optstr))
+		if (str_has_prefix(opts->long_name, optstr))
 			print_option_help(opts, 0);
-		if (strstarts("no-", optstr) &&
-		    strstarts(opts->long_name, optstr + 3))
+		if (str_has_prefix("no-", optstr) &&
+		    str_has_prefix(opts->long_name, optstr + 3))
 			print_option_help(opts, 0);
 	}
 
-- 
2.34.1

