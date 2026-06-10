Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B931D72E;
	Wed, 10 Jun 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110370; cv=none; b=fyEQhjTyRB8//Kuc+xNYd2GIJBnoXwghwblBDu9PcrYw4WU+DAFZsMkyXmQ300Od43I+xg/EgTExMnr1mwU58LR2HL9lfExyN3x0meH1JomdfS3PTUYoqywCMotDcM+0eUfgAq+atYnoj+VIL5DI8ww7pnMRWQgG/De8E6S+KYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110370; c=relaxed/simple;
	bh=ChZ/VzETVjFxU1t8/XJV+KvRhbiU9Z++AiHo3rLz4CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QA+FnxK6pjfe6/8ue18RRfhH+Q3ezh35Q6VAPY+w9Cuy+pXeeDUl4G8QApv+KK580mlimo8xJNyVjBh05EDvNQ+49LawjRF4NAhfYV45s2QAGy6DeFwJrpZYoTgG9WYAaLZD8dH2LxbziAQ1kbusBJb35SThmAPDia+gf4hc7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/9k/Crs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/9k/Crs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA591F00893;
	Wed, 10 Jun 2026 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110369;
	bh=GW9heMHecXhASh30FDBJHV61LxuCJ+9Zw4ZSxVAvLJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/9k/Crs/Cs/w01FWV3G168IrZP5ouJDnqMEHGo0bf334oHfoKVLKTMGeSW2UGEc3
	 Hv6wwI2teHQ15xLB66EP7kqQc8kpSmlBOPGkCgOr7gfP0iiqN+dBayT4BPoxdC9pGD
	 tFcET8obutBk0pTGU27GfAO2EEgi3fNu3g/Fc+T92xiBgnwYpnf8e0HIedIJnLl8V3
	 S5B5i8BCAEdjGs7glpy22aydf3beaRoBHwiB6SPcVqeQ59JZXPBY1UQ1Fq8wITpat9
	 pbHz6LoiWzjQTNLR6x+I3njCqo9bvzJCB71Nh2ZqCQkKStR46Kh3OoCwDF0w+F5CYs
	 DBGovz8VaF7Hg==
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
	Davidlohr Bueso <dave@stgolabs.net>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 06/11] perf sched: Fix idle-hist callchain display using wrong rb_first variant
Date: Wed, 10 Jun 2026 13:52:00 -0300
Message-ID: <20260610165207.2077258-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
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

The original code in ba957ebb54893aca ("perf sched timehist: Show
callchains for idle stat") was correct — it used struct rb_root and
rb_first().  The bug was introduced when sorted_root was converted to
rb_root_cached without converting the sort insertion path to use
rb_insert_color_cached().

Use rb_first(&root->rb_root) to match how the tree was populated.

Fixes: cb4c13a5137766c3 ("perf sched: Use cached rbtrees")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Acked-by: Ian Rogers <irogers@google.com>
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

