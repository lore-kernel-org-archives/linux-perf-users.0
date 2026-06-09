Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A02F747A;
	Tue,  9 Jun 2026 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967158; cv=none; b=cPXOZupk/a61ofq3hKRfxHzTASbMsYeV9PPy4Nwld6f1ejpj9igtejMDLxHoOmCalfocj19rvTnQWdFl9qWPbxXM0Vdvwt5QdH0gZulStOstE0H5ZbFWbdYat1tU10B4GPAq5eYj+qs4Sk8jl3vO7pUGZ3DD75acjWkQ1m3EAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967158; c=relaxed/simple;
	bh=ChZ/VzETVjFxU1t8/XJV+KvRhbiU9Z++AiHo3rLz4CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dC1zRSor4nwOLL/TdIO6PfKvAPh3n6n4Ui+z/0eDq14B0Yly3i9AT3taXxDW/VlXs/hI9DMbzzIK8L+WOJaIyOPvtYiEv58VBZbYJKM9lGLos7pEft3YfSrK5tzYv/LHoowTpGVRimATJlKQQ9htJJQ8uiLIDxhxVc+VUE4BREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOCZKLcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOCZKLcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5DB1F00898;
	Tue,  9 Jun 2026 01:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967157;
	bh=GW9heMHecXhASh30FDBJHV61LxuCJ+9Zw4ZSxVAvLJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GOCZKLcc1aA5Se4KvaHOH3jZd78wzWX71aWDkkuByKkLdAjVVm5uWNlXjjZXr3dbi
	 QCMN0nGjbSwg1Ie/35G67VmnNmLWbk4gfRq4zFUyYjERW1wG2F2H3AezAhF19zZhYt
	 u+2Oy84iZnTN1ItvhS+s0cg+n0pe+doNnHB5JIkcA763tZj2kKl08gkNIhb9QI/9l5
	 jtjWYDVe75qP56O6KkEOXMu3fY0vxE1ezJmmroHdAEgqcNJU75nVL7y7KBLHqyGp/+
	 hrRpoBFnhwCfzVEwv73qvDHOiIwuVix144NvRW08PCIMTrOiUfYCa7DPxT3YUlfa6d
	 mD4xWWvvorKZw==
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
Date: Mon,  8 Jun 2026 22:05:20 -0300
Message-ID: <20260609010526.1998472-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
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

