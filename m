Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425010;
	b=m4EKdCVoL2Sa/ZPllu9aKAvNARKhNG9IjRUpPikGHEqxmHifczoOfmHvtieCyvczMFHo
	 w5FGUV/Xz3XZCDqed8a5uDnBOoL3oLf5ic4K7iuirNdyNTPSLqUS9MN3MZKCGhoPgO0N7
	 Rt/Eej/3mBpAi5I2ywgkpnNEy0wIcs6xhScrlYErutuGSdCE9gb1UGkSp40GAyiIb6c4l
	 ZXaZi8AO43EKzBUEGhje1IfYITNzBmu3BijB//v50vfuqWKvRezbNgfhInCP0HRWlXTHk
	 HbkeXoeaq4go7BcZmlWriXL7qfCeiTDq5vbCcI/L2k1AlUyNaMa+dL4OfN2CCgUrImw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kvq0T2H97qGOEvvgPR1sBE6gcPaWF4mltCtk4IwF5+o=;
	b=xnpTuZCiYBetsha2hZpM29Gi2HNUqsup8zStqQC2V9OioISBnwOH1x0qRKmW+NWzACNb
	 epJlpMATZCJ/7aa/6PO8vApg+QnnwidqxxDoxCsqRCiF3+SLfkqHixKbadLHuLuX0GJf6
	 s9ShVgj8lvyHzInlO80kp5WoQqZbVwwZl7TUnuTSiwjypT2ORv9ZOuGkbO6a5VrGIkAjz
	 XY7Wb5JYsTa9/5Lkemwziu5fko10dp0bVHgZ+SGOoFTX/kogEDaapLcDlsmfV6aVVLsCW
	 ly3SFh2RUusqr9TDI7tHGMGm8YUJ1Jd4HWWfgf48l22egu/k+h442k8+8lC9LmH2JiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBJhqm6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568260A3839;
	Wed, 11 Nov 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBJhqm6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA43E1F00A05;
	Wed, 11 Nov 2026 19:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425009;
	bh=Kvq0T2H97qGOEvvgPR1sBE6gcPaWF4mltCtk4IwF5+o=;
	h=From:To:Cc:Subject:Date;
	b=UBJhqm6Bt3i6cJlS/Cqj2p/RYgZyP79d1rbxaE77F5Mxxw8EQZCzlDBfLxu8A5H+l
	 A9/slJEEGsFS7KfZyAgHRAT57khjshc0aQ7NKfo1klkLsUxoOylCEZhUAldkeULi+v
	 Lb/tajvktIPOVH83gBcQ3iwhuFBzVTIUalQznxaT128FVZObzjDtzQiEeCPtRjQCE8
	 KQtps0NY2pdKCt6bxtxjo9zwSINeaD3eUla4AE2kFxiKLJ6BrET5tvo5astfh6DmAn
	 fOBQnWrgBwx2vY/0tSxterrn+Nlwg2NYeRTbpZX4HXR6bI9ss9fX/li7BamaqOMyk1
	 le5ZX9Ai95PKQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf record: Do not fail with an exiting thread
Date: Wed, 11 Nov 2026 11:23:28 -0800
Message-ID: <20261111192328.3917311-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a thread in the target process exits during the synthesize, it
can fail due to the missing /proc entry.  So __perf_event__synthesize_
thread() ignores the return value of __event__synthesize_thread().

Do the same in the perf_event__synthesize_thread_map() too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b9dbd105cdc37f38..3c8d29f27fd91a2c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -991,6 +991,7 @@ int perf_event__synthesize_thread_map(const struct perf_tool *tool,
 	union perf_event *comm_event, *mmap_event, *fork_event;
 	union perf_event *namespaces_event;
 	int err = -1, thread, j;
+	int synthesized = 0;
 
 	comm_event = malloc(sizeof(comm_event->comm) + machine->id_hdr_size);
 	if (comm_event == NULL)
@@ -1010,16 +1011,19 @@ int perf_event__synthesize_thread_map(const struct perf_tool *tool,
 	if (namespaces_event == NULL)
 		goto out_free_fork;
 
-	err = 0;
 	for (thread = 0; thread < threads->nr; ++thread) {
+		/*
+		 * We may race with exiting thread, so don't stop just because
+		 * one thread couldn't be synthesized.
+		 */
 		if (__event__synthesize_thread(comm_event, mmap_event,
 					       fork_event, namespaces_event,
 					       perf_thread_map__pid(threads, thread), 0,
 					       process, tool, machine,
-					       needs_mmap, mmap_data)) {
-			err = -1;
-			break;
-		}
+					       needs_mmap, mmap_data))
+			continue;
+
+		synthesized++;
 
 		/*
 		 * comm.pid is set to thread group id by
@@ -1037,17 +1041,19 @@ int perf_event__synthesize_thread_map(const struct perf_tool *tool,
 			}
 
 			/* if not, generate events for it */
-			if (need_leader &&
-			    __event__synthesize_thread(comm_event, mmap_event,
+			if (need_leader) {
+				__event__synthesize_thread(comm_event, mmap_event,
 						       fork_event, namespaces_event,
 						       comm_event->comm.pid, 0,
 						       process, tool, machine,
-						       needs_mmap, mmap_data)) {
-				err = -1;
-				break;
+						       needs_mmap, mmap_data);
 			}
 		}
 	}
+
+	if (synthesized)
+		err = 0;
+
 	free(namespaces_event);
 out_free_fork:
 	free(fork_event);
-- 
2.56.0.567.gdb80ae8cd5-goog

