Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A12C0298;
	Tue, 16 Jun 2026 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573532; cv=none; b=m/vrw0t/67ZWmIU1xC8XB9kPsuwnbl0px6SUiJOZcuhgVQ9+dvRY/kw8G2ctO6qRS+jOR90b54lc/o+PyWFbQ2sGfRPL25Im/bVA8Ps8JjNMZbp2Y+UAheyd+Jyjto5SBwexWn8un4W2ZzYMGB7BuZU1Rbe4J/W/hQzrqcf/lzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573532; c=relaxed/simple;
	bh=8HpHXjdvoB/H186NQnvR8krdf51dFEvK1rCahwHaeHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9h+7QcRMjrlTMddNlcx+3CDCjtAm908/7XYDwBy2uqsMpxJgYGT4AfldVLbSCtzjlOucIV8eH+0kPPKjS2vjdTAkBM+RwzliF+S0TypJASXMDukXj5ZWLi0xK3pogfGcXWbSL0PQ0gViXmqHJRydtJliogj5B4mmKkLf9KKP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0inRHKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0inRHKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD5E1F000E9;
	Tue, 16 Jun 2026 01:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573531;
	bh=aqLeXTYDPfHDD9hPHLBfuJ10gNaY/+zrcefpUzfhllo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0inRHKmuQr0XlcNncwRuiCQWS69Xl/WDxLrLA3RhSvzyd+SCxx6Kss5zCuGmRzDJ
	 cxILyqUJBJnLv18WVeh/7uzsedvdvRTLio4AmU55NzoceaMovIeT0/9TSre3WVWHix
	 yfALteIkVjZ7xLW8k6MsWJ940USEhtUPQ+jwlir7j+viB/eyHk8nIKiJPhNpQb98j+
	 BkmT9/YO5G4jIeQ88BBxxFdhlErmLNU/juvgAUnqhe74cfApfQ0Z/jcffXk3+8FHT7
	 DMv5b5D0MKwu2X27OtR9Jt6n5TdQgdzabIf5gsd9ca1KKkEv42wWJyEcI4SCC+QMS1
	 RE1+J9U7U+RnA==
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
	Aaron Tomlin <atomlin@atomlin.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 2/2] perf trace: Guard __probe_ip suppression with evsel__is_probe()
Date: Mon, 15 Jun 2026 22:31:57 -0300
Message-ID: <20260616013157.38960-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616013157.38960-1-acme@kernel.org>
References: <20260616013157.38960-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

trace__fprintf_tp_fields() compares every field name against
"__probe_ip" for all tracepoint events, but this field is only
implicitly added by the Ftrace subsystem to bare dynamic probes.

Add an evsel__is_probe() check before the strcmp so the string
comparison is skipped entirely for non-probe events.

Cc: Aaron Tomlin <atomlin@atomlin.com>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a8492da23a9cc178..57f3f14c5d435805 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3267,7 +3267,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 		 * If verbose mode is enabled, ensure it is formatted as a
 		 * hexadecimal memory address rather than a signed integer.
 		 */
-		if (!strcmp(field->name, "__probe_ip")) {
+		if (evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip")) {
 			if (!verbose)
 				continue;
 
-- 
2.54.0

