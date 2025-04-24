Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54B2820C7;
	Thu, 24 Apr 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511098; cv=none; b=bmVl1Khi2AdtM4gjyC8z9kvfl73HkDwE+m7INS8E5q7YCjsqqxN8Yfn+iOwawwrT7Hdat5on19jUBbERm55lIGbelUkh+iME6vAM6xqhuVhVVC0NgPxU0n0nxmcuj7tRkxr9llqWHanlpaTD7Ln4VnbogGB+WrQLfu7j4/WnbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511098; c=relaxed/simple;
	bh=lyvdiLKQ9R+pCnIHW8OAPlcsNKg8JJFvCI/SqBqxElE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb22FK/49iqsLAhQhmBasRv/Y5YIduY9lC+0oxmGfLpH/5qW0pxDAB3iKiM/BCVT5KExmOVsU5UZrjvKHAyFTKex9JouewLvQDzmA+KjUoSCquyXZ8Q2LPDuLjd0KT8xpWrI1fVSCl+9P0iIBSKh12xMY8EX8savdXqgkwFGSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQCA6lVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQCA6lVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB82C4CEF1;
	Thu, 24 Apr 2025 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511098;
	bh=lyvdiLKQ9R+pCnIHW8OAPlcsNKg8JJFvCI/SqBqxElE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQCA6lVCdDznLodL7bazT3YzJbQQObyMuJtsw3tsKizXKa6fjoqidUggWDbMSCSyo
	 mZJE1qyj9T+p8zl9fI1tlz+YI+CADHotG7qpTwUqshZMsFJ5QynUWybYCOPgiW5qYg
	 qIy/SmgZ4vExF4gbJFFJPU7T7w4AqGSmgRaPozfQpnYos3VS372Wmaj0MGtID0QUd0
	 x3I3cfhTcUFJESX9IXbrI2w6HiWoNM0V4+E8oX8m9Z6HKx1iTJucrjr1RjrZAIZbhA
	 Ffs368ws4lG8x8xs62kBAyw6keLN5/Dsgs328SbCJRlknmpIwGi5ziVbyL8Jtx0fyg
	 40CpgD3q70MKg==
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] perf: Fix failing inherit_event() doing extra refcount decrement on parent
Date: Thu, 24 Apr 2025 18:11:25 +0200
Message-ID: <20250424161128.29176-2-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424161128.29176-1-frederic@kernel.org>
References: <20250424161128.29176-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When inherit_event() fails after the child allocation but before the
parent refcount has been incremented, calling put_event() wrongly
decrements the reference to the parent, risking to free it too early.

Also pmu_get_event() can't be holding a reference to the child
concurrently at this point since it is under pmus_srcu critical section.

Fix it with restoring the deleted free_event() function and call it on
the failing child in order to free it directly under the verified
assumption that its refcount is only 1. The refcount to the parent is
then voluntarily omitted.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/events/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 07414cb1279b..7bcb02ffb93a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5627,6 +5627,22 @@ static void _free_event(struct perf_event *event)
 	__free_event(event);
 }
 
+/*
+ * Used to free events which have a known refcount of 1, such as in error paths
+ * of inherited events.
+ */
+static void free_event(struct perf_event *event)
+{
+	if (WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1,
+				     "unexpected event refcount: %ld; ptr=%p\n",
+				     atomic_long_read(&event->refcount), event)) {
+		/* leak to avoid use-after-free */
+		return;
+	}
+
+	_free_event(event);
+}
+
 /*
  * Remove user event from the owner task.
  */
@@ -14184,7 +14200,7 @@ inherit_event(struct perf_event *parent_event,
 
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
-		put_event(child_event);
+		free_event(child_event);
 		return ERR_CAST(pmu_ctx);
 	}
 	child_event->pmu_ctx = pmu_ctx;
@@ -14199,7 +14215,7 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		put_event(child_event);
+		free_event(child_event);
 		return NULL;
 	}
 
-- 
2.48.1

