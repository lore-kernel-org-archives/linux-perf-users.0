Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4973A5E6F;
	Thu,  4 Jun 2026 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606182; cv=none; b=fNMcXDxDMTOeP0ymu4zdCodbmiycWEVgt6xds26cxWxwsdCZLS96ha4uupna/um/m/ciDfUIRM2SkdBvcKrBQRQmZcqKHvVwO/MOEaNvDyM7De1xfgEtqAwRUFScy1uvo+UM+MPDwEA+A7SxNhFEBuq9eO3wKKuTdK5acFXN1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606182; c=relaxed/simple;
	bh=hVL3CNwOm4qEIBGaXnHed+ZljEbyAhdPKlmaoMqrM3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f87cMVYh0eROyGeVtkwdBEHNinW4ro1zFDNkiiUCcGwysMJOREifFO/cN35qt2ZC6IK2y9Qi9Q7mGg6xgrs4vE14oJr4fwl6iuBhElpnHlWbJLW8LMdnntHnOqZEz/HPTAg333VoXktpJYndvwxImXOYU4Jk4ebCFpCYLH05yaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkBvPtN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkBvPtN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7624E1F00898;
	Thu,  4 Jun 2026 20:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606180;
	bh=vRh5S56EQv1X1h39iR1LYgRUJbiu+AHhqUAOnoJvepg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkBvPtN3ojAGrXB5pqYjRHPLJtPuyCBKR1P+iOi6ckz5twl/kXFRbrvNjY/NEJAwk
	 xOAZs8izPjVj9EXbm9PC5vGJDACWe3Ocg+sYGLCQlXa6HueMKZsUq3SXsO5NZ92bpn
	 U5lxErkRcM/h4EWzgIt7JBUuvsOGa/6Olnv/dtoUmIp3IbeP3qsyHOG5mTI/LYlEuE
	 wC5wYPksBkZpDpy8J+s2wG6ue4hYNG0GUQ943UFVhcPg+NP3O2yh2lritfTWZP3Um1
	 vQXSH2905bJw6bYLLVghkXA8hEKq2ThJm+7+KWP/jvOeGTlEmJpIRo4m9M7doLhHRM
	 iPlm2PTT0pJxA==
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
Date: Thu,  4 Jun 2026 17:49:17 -0300
Message-ID: <20260604204921.1707333-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604204921.1707333-1-acme@kernel.org>
References: <20260604204921.1707333-1-acme@kernel.org>
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

