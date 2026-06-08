Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52313A9615;
	Mon,  8 Jun 2026 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949904; cv=none; b=N+MtgII0LM+bvfDrv/b88UuctVNDd8bwAlo724t18xq2ICFvnqO84ra6O7586dOumwH0atvDkBZJ8yqP/SZXPzj+z5jXivtqTlYGzb7xSb08o/5UvWZD+nzfjJTxI5Cew8+7/eDi7AxFlbfFJVHy4d8jm+yxkjR7u6d25YH6Cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949904; c=relaxed/simple;
	bh=GXEDCBl+bN1a4zMPkClDUbibNaQ50EoaRRLssS1jg2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1bm7fxuy0616eUc7zD3Ha49361USKB1UzUS8FfSgR9lkN6x5HhJx7jIyYcIo1aEK0nxgnmpeD0Xs6SXMqe2h5GQfK50fI+byTEdI2pFyerNCPwx2WTH06Tf1QdukKAmlgffofH0KX6dMutQXeYP2VGDOIkJSZnTvIKrp9OvPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lylruMK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lylruMK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBD91F00899;
	Mon,  8 Jun 2026 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949903;
	bh=Cs6jyL7mNP1mOsQffemH7BARrW+I13IL52Pz+ofnTkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lylruMK/8I+r+LZ/yz7SYKW7XK82cg0WlH/YK1yZVusz1HMM2LuzVJsSyonAmLssf
	 rWtc5fGuDxDs2k5p8Iu0DUB3gYmJKtK4YYKWJpkZ8Yd3hkMJRlYxdBrxpOKgoF8uVg
	 p1OdoMduyWGZUTf48Z6mV+ryoa2lJnsyudFOf7UiKp1Zmr+RZ9mvKdJNdTq6lCiqqu
	 y5n1HV0wOmZ+NYfBhISJp4c+M6K8VMG7huMVq4Yr34PL8VRDSy+1CJT/6EcKIdUpsk
	 wonsRvPhbiu20rQ47SCNF+KAVddbiizXyxTNPqhExCJAznorye/z0UKgGz5G46+8LB
	 u3As/onCPbGtg==
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
Date: Mon,  8 Jun 2026 17:17:46 -0300
Message-ID: <20260608201753.1979464-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
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

