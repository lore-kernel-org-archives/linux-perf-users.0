Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FD2B9BA;
	Fri,  5 Jun 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661740; cv=none; b=YQx48WPTaOu6mT39cGD4vQ0VzFRUaK4Z5/amKG6qPVY5T3rz1q+cHfj5nxdpjIkUo1OqvXqIPoniJ9x67y0qW7BDOP86Gfi2QhV1qZHTGSCQ2JwNPM6P8X5rMBKwD3FFgcvXxelrh1ZHep1moewdPAo6NTMbfuto1FSFlyWIy8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661740; c=relaxed/simple;
	bh=ZMyhzIxdkE8Fx5Fs8l8voQf5Qk+0NmtxuAJ0555U4yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp1tSddm0rPUMCxEuRByV1xbr12+yQDhryg03hbSr2+jl/IQBT7m8FvqtBstZ8CD68n6uySGNCCnXZddiepntHSZ/LePcbKedrJk0Gpf3KCGTcx9QUiNDpE0OkutRkvt5Oj4VdEMDsGadSYBH1ebuErnSHcTo5e2G1FW+18PlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfdyOUD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfdyOUD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4B61F00898;
	Fri,  5 Jun 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661739;
	bh=ktJQjLRBRQFD3+kFSnPKTRz844UlVkyictA+q1icveI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JfdyOUD+hLqkJGYuLTe7j+TgaMZJL7OaQrv+xh+1x5gDs7Ghz3fExhJ83e9zCxaek
	 ByteM/FRkJxRusGQJkjE0Bnlha/UpDjKwy/IYbeim0VsnSd70SW9RMUnuLywvVSxGL
	 ET5nO/2yoOzo/2X7F5NGbjpi+QYZZpZlnqY8xtoe7ZIGbC9o/6a8uW9OgkGpPdLeaT
	 LUN6gZ35hEg5Zu4x9yCPvDo2smXLe+36HRCvHsKf141ubTiWLDN89GwFpH1CttZKFU
	 n3Xs3+xnjxHun/i7OKxykbgdWtAgjucjCndXL8EwwrbdQfms+in4B3lZjRAmiTZVpn
	 /QHK5GHB9sCkw==
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
Subject: [PATCH 3/5] perf sched: Fix thread reference leaks in timehist_get_thread()
Date: Fri,  5 Jun 2026 09:15:12 -0300
Message-ID: <20260605121515.1725549-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605121515.1725549-1-acme@kernel.org>
References: <20260605121515.1725549-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

timehist_get_thread() acquires a thread reference via
machine__findnew_thread() and an idle thread reference via
get_idle_thread() (which calls thread__get()).  Two error paths in
the idle_hist block return NULL without releasing these references:

 - When get_idle_thread() fails, the thread reference leaks.
 - When thread__priv(idle) returns NULL, both idle and thread leak.

Additionally, the idle thread reference acquired on the success path
is never released, leaking a reference on every sample when
--idle-hist is active.

Add thread__put() calls on both error paths and release the idle
reference after use on the success path.

Fixes: 5d8f17fb5822 ("perf sched timehist: Add -I/--idle-hist option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 4aa7833cae6e36b8..7bd61028327b39db 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2546,12 +2546,16 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 			idle = get_idle_thread(sample->cpu);
 			if (idle == NULL) {
 				pr_err("Failed to get idle thread for cpu %d.\n", sample->cpu);
+				thread__put(thread);
 				return NULL;
 			}
 
 			itr = thread__priv(idle);
-			if (itr == NULL)
+			if (itr == NULL) {
+				thread__put(idle);
+				thread__put(thread);
 				return NULL;
+			}
 
 			thread__put(itr->last_thread);
 			itr->last_thread = thread__get(thread);
@@ -2559,6 +2563,8 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 			/* copy task callchain when entering to idle */
 			if (perf_sample__intval(sample, "next_pid") == 0)
 				save_idle_callchain(sched, itr, sample);
+
+			thread__put(idle);
 		}
 	}
 
-- 
2.54.0

