Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA58301704
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019239; cv=none; b=UCkTuWQyI5Y2K8aOs8lifNz9M7q+4mP/OZbSw9J5hCglg2JvMwc812dBpJzwcIx6AsrmGKMMYz6p8BGyu5LcWzQ4uGRqkN5RqnxNdp69qMqz2Mz1A8iolQ0+af1iaJqQH7FpooZpaPiaERdHTm7eTB8r8wAlJiil7yL5TwgFTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019239; c=relaxed/simple;
	bh=h/I8Re7m7WOPYbknGlRF+QVH2AtXrxWw5aW0Nb+s838=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAZIU49hoOqw6Paoiy3Fld1Xm4H4KEzOqI7saTuYvbB8ZBuZSTI0MVSSliyehkG65rRixaqHnxGe4oZbyMCGstQggynIZeQP4F0RFdIJpIWy4fSy7bbSTGTDOvdTFySsPf8rC6nAkjhGuuzdEqWujS1lE8f0xAzYcb2cSFyr/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C24ra9jp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C24ra9jp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774019237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1vYlO08d38SSC6asSeb1UkO8Gzpz4WOW8Bkx6t6EKE=;
	b=C24ra9jp4DYoRjyF8Msyq24nq+ML7HpC7XvLbuR2iibDltbvb44lP6w1NyZYPr29rUnK6N
	I0WdnCncjHvAFTw2PuvU4R4xRx0YKkNKOOC0ZUWM6KBNtE2OFSYNtZwSFaPG7D8VTEjiv4
	RriNLyMts5GZtmqXcVhEQTWp+plfjt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178--xW8WFpyO7OtsYOEU3Av-w-1; Fri,
 20 Mar 2026 11:07:13 -0400
X-MC-Unique: -xW8WFpyO7OtsYOEU3Av-w-1
X-Mimecast-MFC-AGG-ID: -xW8WFpyO7OtsYOEU3Av-w_1774019232
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90D651955E79;
	Fri, 20 Mar 2026 15:07:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BD6130001A1;
	Fri, 20 Mar 2026 15:07:07 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH 2/3] tools subcmd: support optarg as separate argument
Date: Fri, 20 Mar 2026 16:06:50 +0100
Message-ID: <20260320150651.51057-3-tglozar@redhat.com>
In-Reply-To: <20260320150651.51057-1-tglozar@redhat.com>
References: <20260320150651.51057-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In addition to "-ovalue" and "--opt=value" syntax, allow also "-o value"
and "--opt value" for options with optional argument when the newly
added PARSE_OPT_OPTARG_ALLOW_NEXT flag is set.

This behavior is turned off by default since it does not make sense for
tools using non-option command line arguments. Consider the ambiguity
of "cmd -d x", where "-d x" can mean either "-d with argument of x" or
"-d without argument, followed by non-option argument x". This is not an
issue in the case that the tool takes no non-option arguments.

To implement this, a new local variable, force_defval, is created in
get_value(), along with a comment explaining the logic.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 53 +++++++++++++++++++++++++++-----
 tools/lib/subcmd/parse-options.h |  1 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 555d617c1f50..664b2053bb77 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -72,6 +72,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 	const char *s, *arg = NULL;
 	const int unset = flags & OPT_UNSET;
 	int err;
+	bool force_defval = false;
 
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
@@ -123,6 +124,42 @@ static int get_value(struct parse_opt_ctx_t *p,
 		}
 	}
 
+	if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		if (!(p->flags & PARSE_OPT_OPTARG_ALLOW_NEXT)) {
+			/*
+			 * If the option has an optional argument, and the argument is not
+			 * provided in the option itself, do not attempt to get it from
+			 * the next argument, unless PARSE_OPT_OPTARG_ALLOW_NEXT is set.
+			 *
+			 * This prevents a non-option argument from being interpreted as an
+			 * optional argument of a preceding option, for example:
+			 *
+			 * $ cmd --opt val
+			 * -> is "val" argument of "--opt" or a separate non-option
+			 * argument?
+			 *
+			 * With PARSE_OPT_OPTARG_ALLOW_NEXT, "val" is interpreted as
+			 * the argument of "--opt", i.e. the same as "--opt=val".
+			 * Without PARSE_OPT_OPTARG_ALLOW_NEXT, --opt is interpreted
+			 * as having the default value, and "val" as a separate non-option
+			 * argument.
+			 *
+			 * PARSE_OPT_OPTARG_ALLOW_NEXT is useful for commands that take no
+			 * non-option arguments and want to allow more flexibility in
+			 * optional argument passing.
+			 */
+			force_defval = true;
+		}
+
+		if (p->argc <= 1 || p->argv[1][0] == '-') {
+			/*
+			 * If next argument is an option or does not exist,
+			 * use the default value.
+			 */
+			force_defval = true;
+		}
+	}
+
 	if (opt->flags & PARSE_OPT_NOBUILD) {
 		char reason[128];
 		bool noarg = false;
@@ -148,7 +185,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			noarg = true;
 		if (opt->flags & PARSE_OPT_NOARG)
 			noarg = true;
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+		if (force_defval)
 			noarg = true;
 
 		switch (opt->type) {
@@ -212,7 +249,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		err = 0;
 		if (unset)
 			*(const char **)opt->value = NULL;
-		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+		else if (force_defval)
 			*(const char **)opt->value = (const char *)opt->defval;
 		else
 			err = get_arg(p, opt, flags, (const char **)opt->value);
@@ -244,7 +281,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
 		if (opt->flags & PARSE_OPT_NOARG)
 			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+		if (force_defval)
 			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
@@ -255,7 +292,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		if (force_defval) {
 			*(int *)opt->value = opt->defval;
 			return 0;
 		}
@@ -271,7 +308,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(unsigned int *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		if (force_defval) {
 			*(unsigned int *)opt->value = opt->defval;
 			return 0;
 		}
@@ -289,7 +326,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(long *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		if (force_defval) {
 			*(long *)opt->value = opt->defval;
 			return 0;
 		}
@@ -305,7 +342,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(unsigned long *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		if (force_defval) {
 			*(unsigned long *)opt->value = opt->defval;
 			return 0;
 		}
@@ -321,7 +358,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(u64 *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		if (force_defval) {
 			*(u64 *)opt->value = opt->defval;
 			return 0;
 		}
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 8e9147358a28..c573a0ca5ca6 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -33,6 +33,7 @@ enum parse_opt_flags {
 	PARSE_OPT_KEEP_ARGV0 = 4,
 	PARSE_OPT_KEEP_UNKNOWN = 8,
 	PARSE_OPT_NO_INTERNAL_HELP = 16,
+	PARSE_OPT_OPTARG_ALLOW_NEXT = 32,
 };
 
 enum parse_opt_option_flags {
-- 
2.53.0

