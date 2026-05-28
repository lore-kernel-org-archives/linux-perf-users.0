Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA723BB127
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964417; cv=none; b=LJtqQLLRaaSv7SUHF2uq9ZCRNvvNS/aW+5kdY3jCwKT3cS+NJU+qAjdie3kM4ziEXKNtdwsPSxGyDiFxV4YvbDAldpD3Cg0cv9bk8DC/0bqcqDT9+TQHIJAsYj5dSn4VCpUbY8NEJ5CYoh79q154vAfVy0AmYWwGGJI8aDp9zVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964417; c=relaxed/simple;
	bh=pP9zymcXj1EdhFLVo2c4W4swf8P6e2WPmGdTahTiMxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbYjONb2huL2OHCBrywD1T16okr8/JHCtloTKuOJId2reAzHA4RkDZNj7nielA4Zvzkt5TcglpbNAN2ICVPa52BhO7+wkQeFhPNhGLVrGS2hPmbC9aC5ooISsFagB8sZ+hmeecYNiYsFMJRADzqZdZjfCtn0uOrV6eCKOVBlT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHXDt8gV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHXDt8gV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779964413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6jNa+GQSgA+jzK73QK9g09OBoehVz9w9jxoOFMsCm4=;
	b=UHXDt8gVne0ONgAiDnaBcRRBfefVOBLgetGyZ2Y3WeddDbGeRh8X/zQFO/L5X+yYEYWcnK
	CBUD/2zpsieK9w1V5xQXWlqyj+jFzkSYt88/2lxy2ZApLELxtqLkobo8BnOoKJWWUK75ji
	aagvi0UxerhCsk1fbpaCuxDMNoH3YqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-y6yYdKN3OkmW7ji_k6zCmg-1; Thu,
 28 May 2026 06:33:29 -0400
X-MC-Unique: y6yYdKN3OkmW7ji_k6zCmg-1
X-Mimecast-MFC-AGG-ID: y6yYdKN3OkmW7ji_k6zCmg_1779964408
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A609180034C;
	Thu, 28 May 2026 10:33:28 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED07B1688;
	Thu, 28 May 2026 10:33:24 +0000 (UTC)
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH v3 3/6] tools subcmd: allow parsing distinct --opt and --no-opt
Date: Thu, 28 May 2026 12:32:51 +0200
Message-ID: <20260528103254.2990068-4-tglozar@redhat.com>
In-Reply-To: <20260528103254.2990068-1-tglozar@redhat.com>
References: <20260528103254.2990068-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

libsubcmd automatically generates for every option --opt an equivalent
negated option, --no-opt, to unset the option. Vice versa, for every
option declared as --no-opt, a shorthand --opt is declared for
convenience.

Add a flag, PARSE_OPT_NOAUTONEG, to disable this behavior. This new flag
behaves similarly to the already existing PARSE_OPT_NONEG, only it does
not reject the --no-opt variant, but leaves it undefined. That is useful
when there is a conflicting distinct --no-opt option in the syntax of
the tool.

PARSE_OPT_NOAUTONEG is enabled per-option, allowing to unset other
options that do not have this conflict.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 10 ++++++----
 tools/lib/subcmd/parse-options.h |  3 +++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 664b2053bb77..e83200e9f56a 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -427,7 +427,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			return 0;
 		}
 		if (!rest) {
-			if (strstarts(options->long_name, "no-")) {
+			if (strstarts(options->long_name, "no-") &&
+			    !(options->flags & PARSE_OPT_NOAUTONEG)) {
 				/*
 				 * The long name itself starts with "no-", so
 				 * accept the option without "no-" so that users
@@ -465,12 +466,12 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 				continue;
 			}
 			/* negated and abbreviated very much? */
-			if (strstarts("no-", arg)) {
+			if (strstarts("no-", arg) && !(options->flags & PARSE_OPT_NOAUTONEG)) {
 				flags |= OPT_UNSET;
 				goto is_abbreviated;
 			}
 			/* negated? */
-			if (strncmp(arg, "no-", 3))
+			if (strncmp(arg, "no-", 3) || (options->flags & PARSE_OPT_NOAUTONEG))
 				continue;
 			flags |= OPT_UNSET;
 			rest = skip_prefix(arg + 3, options->long_name);
@@ -1019,7 +1020,8 @@ int parse_options_usage(const char * const *usagestr,
 		if (strstarts(opts->long_name, optstr))
 			print_option_help(opts, 0);
 		if (strstarts("no-", optstr) &&
-		    strstarts(opts->long_name, optstr + 3))
+		    strstarts(opts->long_name, optstr + 3) &&
+			!(opts->flags & PARSE_OPT_NOAUTONEG))
 			print_option_help(opts, 0);
 	}
 
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index c573a0ca5ca6..38df5fd21963 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -47,6 +47,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NOEMPTY  = 128,
 	PARSE_OPT_NOBUILD  = 256,
 	PARSE_OPT_CANSKIP  = 512,
+	PARSE_OPT_NOAUTONEG = 1024,
 };
 
 struct option;
@@ -149,6 +150,8 @@ struct option {
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = "time", .help = (h), .callback = parse_opt_approxidate_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f) }
+#define OPT_CALLBACK_FLAG(s, l, v, a, h, f, fl) \
+	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f), .flags = (fl) }
 #define OPT_CALLBACK_SET(s, l, v, os, a, h, f) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f), .set = check_vtype(os, bool *)}
 #define OPT_CALLBACK_NOOPT(s, l, v, a, h, f) \
-- 
2.54.0

