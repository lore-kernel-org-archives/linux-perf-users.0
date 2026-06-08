Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3B2F5A06;
	Mon,  8 Jun 2026 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882322; cv=none; b=sfDUSXtzhipUn1kP1IqOudv6bkBjg99v72Bd0Xg1BcWDFEDIkYPWnlFyOFOTXTnE42mhKjp1a1nSMYkZpPtydHUM6bgmwr//OWs40diXh5E6d+1Al4rl/yQ62RKtAADDPSeFZnqdekgU7P56RQrYXMLVwn3edq3qxtzCkTEBgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882322; c=relaxed/simple;
	bh=B6dyFLxN/0OWhF6b9zkvbGQgIWPWizl2ci9AOKR9bYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOqOvG4lHXaot2rf+n2h2zVsrie3kCpsv4ziNDbqcEjde7hQGw7cprgJhUKMeNnrenrwYW0z7kgaNmNTekpxSttAK0Oh33TmsNcm3PyEjKedAH1ig202GDsqNrXMVNQLisMPFCKG+XbbpiccZFuTDmhVahgG42ezS2T+PvGkx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIF94HpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIF94HpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0DF1F00893;
	Mon,  8 Jun 2026 01:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882321;
	bh=w4Ux0WLWBUbFl2E+Iwv35lwtNI615EbPsu51cw49gYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EIF94HpVhlWFyM/NAFgdzU74NXi7f4RPTg8SW8zGiO0ZPrddmht30InO5kxEolc9W
	 r2idRvlB+PoRHxmo8LwOtVB3Y12L+sfST3B93qhisNx/jCujeUqrxnXjwfbB75pQXl
	 eKBVqOqcJpAPgHSNi0gDJ7I1Wu91bXgZQEfDU0Hgk45rRWO84RdzkxTgZLQs0GJMjx
	 BvjsuRRrEojQrrz7lwNEaccrhoZEWUMb6G3npUd95YTEThN/ccbV1+lR7jBXKkvRoC
	 2z2l/PJWyGSyhZfEc4u7t0jTJQb/3gluvfyhJdwumbYnt3IIkh92By4gi3GXcRgjgq
	 sUEszIQd9hDCQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 07/11] perf sched: Fix idle-hist callchain display using wrong rb_first variant
Date: Sun,  7 Jun 2026 22:30:51 -0300
Message-ID: <20260608013057.1942953-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

timehist_print_idlehist_callchain() calls rb_first_cached() on
sorted_root, but the sort function (callchain_param.sort) populates it
via rb_insert_color() on the plain rb_root member — not the cached
variant.  This means rb_leftmost is never set, so rb_first_cached()
always returns NULL and the entire callchain summary is silently
dropped from --idle-hist output.

Use rb_first(&root->rb_root) to match how the tree was populated.

Fixes: ba957ebb54893aca ("perf sched timehist: Show callchains for idle stat")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ded511d8518803a0..85f11d388392d316 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3130,7 +3130,8 @@ static size_t timehist_print_idlehist_callchain(struct rb_root_cached *root)
 	size_t ret = 0;
 	FILE *fp = stdout;
 	struct callchain_node *chain;
-	struct rb_node *rb_node = rb_first_cached(root);
+	/* sort() uses rb_insert_color() on rb_root, not rb_root_cached */
+	struct rb_node *rb_node = rb_first(&root->rb_root);
 
 	printf("  %16s  %8s  %s\n", "Idle time (msec)", "Count", "Callchains");
 	printf("  %.16s  %.8s  %.50s\n", graph_dotted_line, graph_dotted_line,
-- 
2.54.0

