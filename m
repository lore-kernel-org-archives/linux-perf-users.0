Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9923321DE;
	Sun,  7 Jun 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875018; cv=none; b=NIkWC4iD3NsDFSRfXYqykeXEZiuRJC8AvVimtAEL8Qxc5BBVnvCTqKfBFZoX1jiFB1bWfoDLisZn3CKbx/Q4CFLDquhCbw4+6wq/XSmqli5NFemJ7TMff3gCKaszThN+lkCJql6Hs7m+kiZibWFMQtOX+KoPGHaf8/WLGBBdUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875018; c=relaxed/simple;
	bh=4rWWhglhYlzIqoYfRY/ksHn9iH5j6cc2TFSEsaDuZiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXkYCYCuI/tvAnGhM4aPYAK8qFtI+Czb1vIXHlYJ16ZJjR5DXZJ0CDq49Mu4Abilu23sviQ2D0+QNIi+B5OnwBRDbVge4aXHfBHTZaCSKZVpBOqMPClbEU+T0DBOEtEM/5p/WKdRWWilZs1fOjmm3JTupBJokZ8t++0GU89hzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boPKuUAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boPKuUAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB21F00898;
	Sun,  7 Jun 2026 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875017;
	bh=re/8AXmyLzzdg0p6e5w/T1RH/16/wevRVcz/zwj5TLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=boPKuUAmooY/GOKuuPoac8z1/XY0iUP86sMYfEWuXbz+fQkriCRWPvXsuH4yPz18c
	 4bJCMhmaZEXC9Dl8sQ7h+5dsolc8ZDRHFIP7yzrGQBND/IQz/zhelVP5MUf8S4wuw8
	 qcLJmwajVNxeNf9zOPzmsJbzcU4UjwG3r5doli3fA/MA0FIUzGw+kuJktqKdWcTueo
	 pOcSk0Di5PBy2F9FW58bVbEBYT9tXakkx3vgVf8kAGwlQxbkpStcHSn+I1ZwPkbOvj
	 5Y7Zeub9ZMbm8iPzF0iT32TPIYdciFKAywGqicN9zw+hp7NECGdB/CFgQHrZhEWCG5
	 5ECZda+1LUafQ==
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
Date: Sun,  7 Jun 2026 20:29:20 -0300
Message-ID: <20260607232925.1935819-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
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
index 5f3510f9ca249132..30de749e066335a5 100644
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

