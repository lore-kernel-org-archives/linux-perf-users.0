Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC16239E7F;
	Mon, 25 May 2026 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671190; cv=none; b=W/QXNPgqxQYo/JyBzRQ1Lkp7cWViV0LeBYGow8Mx1rYF7yzAO+juMAJFDuHy32UTfi3Cl6ITzOb4IZ6/qIw0A/FZgp0v5mDO0UJ7fG4HiZPFxjf/TqrtM202mBV0uF1sM0zLIuODpP7Pss9OoDqF1Byw2IfyY2gIfE9aLKnSUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671190; c=relaxed/simple;
	bh=R3GbXHEydvHpCdmv3PE0mn3L5K8/Se/AEjcjuDAAn48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM8aiAiy79gj4tRKaQ0hwhxjR0Yzn8MnSYBaIehy8rGkVC4+dPjxQ+MdYulMV8jc/T5/uyyzg6JoYqZUUHR1OuXNYyFrib7jMZmGaDP691EEcpBUEW/vSwBjwrctXES+xD9nP7LZTzc7gX5xX6Qyw9l/HFC4x1VwHRrVLUJ1vG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4iA0lvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4iA0lvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFAF1F00A3A;
	Mon, 25 May 2026 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671188;
	bh=YOgRclGyuH2hdXdLF1L0y2oloV3n3kTQAJZ/D0fqwIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X4iA0lvfeDKzZe7BWecv+xdjsqwgokW2X/rz6/TxauOjBfgK9S8yUp1DYDcVm3/Ua
	 GCSvOhTnO9qepHxiTHGjP+CRpr99cQvGDlh24Ywb1wz6aEhjgMsds2ddfzcNwRg9Ka
	 r4nngsaRImc0jmxpBenwXGy/uvDuqjWj77CiSn4V74r1GEZiC29a1ddhM4NDJuzXzQ
	 MsdSk19oGJ68MfaYS8d6HckUiKp5TJaOVHDREhmxtMV+ALFBQqqsrpuNJAuGdMEu7Y
	 74c4m2wGeBUkoOhknoBsg2lSD6dZ/ThxW395bxg1kxt9cESWedFbeCLXpoIrdnDCUZ
	 F7sCWFqf45G7w==
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
Subject: [PATCH 07/29] perf session: Fix swap_sample_id_all() crash on crafted events
Date: Sun, 24 May 2026 22:05:27 -0300
Message-ID: <20260525010550.1100375-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525010550.1100375-1-acme@kernel.org>
References: <20260525010550.1100375-1-acme@kernel.org>
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
 tools/perf/util/session.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 24f2ba599b8079bd..37544a3574185bac 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -276,10 +276,18 @@ void perf_session__delete(struct perf_session *session)
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
+	if (size % sizeof(u64)) {
+		pr_warning("swap_sample_id_all: unaligned sample_id_all remainder (%d), skipping swap\n", size);
+		return;
+	}
+	if (size > 0)
+		mem_bswap_64(data, size);
 }
 
 static void perf_event__all64_swap(union perf_event *event,
-- 
2.54.0

