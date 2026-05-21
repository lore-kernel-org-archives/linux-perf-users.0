Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476582E6CA8;
	Thu, 21 May 2026 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325865; cv=none; b=PwEe3AiFTkUN4wnzZWwaXA3ta0+oLdFJ79CfQOUcoEoyrsOwox90fpM2wRQm6pH6W7d92NLF50JtGTkasFjeFcd1EiY1YmLc53ofca5XfXiuam2EgFHZJO0vw/8wh4dLsKeGPFneb8am4FQxoSQXNXJvio4kfBoSD9FJS83TWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325865; c=relaxed/simple;
	bh=t+idU042Cx5ws/JW6K+HOlTGwWpBBhFprs8kNyeP2Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRkShrosWlwGxmiFG6OGKavItW14VP7+llHP/RwTQ3QMGvm68ErTSYjpCvUBqI5hsZvO+bpmX6BFDMpM5ABKusvFB9MbgiX0vFysUAnsI+3V8XbC3Xwy6pRpEo3e6S55aOke5Pbof9N4qbKOgdA3euR/2HW/UUUnw5+G8abNPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY2zM+aO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY2zM+aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A143D1F000E9;
	Thu, 21 May 2026 01:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325863;
	bh=NCbYq53wCHBkxej+rb4q12NWrKbzq9frKq5i/xmjX0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WY2zM+aOvdsjej3wYVA7BNRX3TF5d+uWKqVfN6DBfWscoxBGWTi8RcwRZNY52qgQ4
	 JVQBb7vIVMiA/0IxgyYtl1KQyKQ63uEolzfllc2jU/D6a4bGu0BjXD9Fk6Pfh/6m3B
	 gBjn4Sa6F27szTDcHc5W8EnPuOE78aOdZ+MpDms2KztkPjFX5fGd+KqEg45V2iQr0p
	 w+K1CP/vY1aUiVysRiOnerfFIhx98cdgjKQrpY2Js/koFR48cSWj8a+GYc6yQkpych
	 m+LBZvRZkmYuusfDQws+qH4mdxaE3V725Lw/s2FbNAWbIztrLwgwLCj8RId9jWrUi+
	 RjMvqOB44doQA==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 06/27] perf session: Fix swap_sample_id_all() crash on crafted events
Date: Wed, 20 May 2026 22:09:51 -0300
Message-ID: <20260521011027.622268-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

swap_sample_id_all() calls BUG_ON(size % sizeof(u64)) which kills
perf on any event where the sample_id_all tail is not 8-byte aligned.
A crafted perf.data can trigger this trivially.

Replace BUG_ON with a bounds check: skip the swap if the data pointer
is past the end of the event, and only swap when there are bytes
remaining.

Note: the strlen calls in string-field swap handlers (comm,
mmap, mmap2, cgroup) are replaced with bounded strnlen by the
next patch in this series ("perf session: Add validated swap
infrastructure with null-termination checks").

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 08fbd6a248ea949c..415693a3450a7138 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -276,10 +276,14 @@ void perf_session__delete(struct perf_session *session)
 static void swap_sample_id_all(union perf_event *event, void *data)
 {
 	void *end = (void *) event + event->header.size;
-	int size = end - data;
+	int size;
 
-	BUG_ON(size % sizeof(u64));
-	mem_bswap_64(data, size);
+	if (data >= end)
+		return;
+
+	size = end - data;
+	if (size > 0)
+		mem_bswap_64(data, size);
 }
 
 static void perf_event__all64_swap(union perf_event *event,
-- 
2.54.0

