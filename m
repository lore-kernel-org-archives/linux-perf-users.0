Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451A3DA5C3;
	Thu,  4 Jun 2026 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603901; cv=none; b=L3orvLZxdO20uE7A7080YTYR02XJJi4LVWMxoSLyi2aPepnoxJd6SxQRfZawdwUJjcYisdLfBaSHT22m2TtQu0B92hR3T0UErxmMg0agOU/Xz8nfEmExxNjTcTeCUn12EWJ379C1ak6UdPvhoMU+oHNL+O8uBQHGX0ZJs6X+Wtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603901; c=relaxed/simple;
	bh=hVL3CNwOm4qEIBGaXnHed+ZljEbyAhdPKlmaoMqrM3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr2PeR3vnhHWEjfj6GNAc9CARjg8pH5KT0cUiRcsKkiqza4TuSvNon8j9xHIv+vfvCEH5MKM4QR/wRKx4BdgdX7eCVkgRTeVgkM955aePIzvdHuQ8EdK1Al/SMWB1v3lfCBA1IluwU2ELENzD1IEGyfYMAV7DPncy9FssyOlND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbzSktzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbzSktzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1631F00893;
	Thu,  4 Jun 2026 20:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780603898;
	bh=vRh5S56EQv1X1h39iR1LYgRUJbiu+AHhqUAOnoJvepg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MbzSktzRyWCS0JqU6fSU9RKMqfq+mnWa/ybzGElA7cv3iQGrIo42RITInr/fkiw/2
	 2mukSAZLptBlVOxNNzGXWIHR9LKlqaJtKZpFimbKoJOPLRV11M6Uh4Jbd68AAMyRjM
	 xUEoW/DZbrUbdIz43VFQaMdFYbQl/fcHYRUU/qXP019mqqI5rJBMfFfUqZOLoam29I
	 Sy3ZvmoAhQ6ZZZSFYtVHI9CNn1LH9a9hgAplFzSB46Z9zpICRpO3rcIBtTRPnN6QE1
	 3r0XxkxRGrqOKqq7C6SS8+b/I3eRrK7QN0UfORcHPJ9E7J2KiER10BOO/Upnxh5FTT
	 BMcJPa/Oi2aNQ==
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
Subject: [PATCH 2/4] perf sched: Fix thread reference leak in latency_switch_event
Date: Thu,  4 Jun 2026 17:11:14 -0300
Message-ID: <20260604201119.1702338-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604201119.1702338-1-acme@kernel.org>
References: <20260604201119.1702338-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In latency_switch_event(), after acquiring thread references for
sched_out and sched_in via machine__findnew_thread(), the first
add_sched_out_event() failure path does 'return -1', bypassing the
out_put label that calls thread__put() on both references.

The second and third add_sched_out_event() failures correctly use
'goto out_put'.  Fix the first one to match.

Fixes: b91fc39f4ad7 ("perf machine: Protect the machine->threads with a rwlock")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index e7bd3f331cb8e889..13b801496a01271e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1180,7 +1180,7 @@ static int latency_switch_event(struct perf_sched *sched,
 		}
 	}
 	if (add_sched_out_event(out_events, prev_state, timestamp))
-		return -1;
+		goto out_put;
 
 	in_events = thread_atoms_search(&sched->atom_root, sched_in, &sched->cmp_pid);
 	if (!in_events) {
-- 
2.54.0

