Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141A383C86
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053568; cv=none; b=EIxcHgZkMt6Vuv4wBxN4chEIMiGACW2TXCpTXDJei9ahO7pSlzYBF8W2dPQwMKZoEYHMDsd2nNxrzRnX86WDq6up7uXTgF9nxNV8MFTioNGsqn9Olrb/lA7cUt/q696g02jLNFVff3GAAAmpUpb7SoXfXsSl/dDWRY+Db1Tvqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053568; c=relaxed/simple;
	bh=D6J4TrILnw+Vd5duIq8Xx5kVQzeF4EcLXmzsOqpDjuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=POQHWr3PJfUKWB8HAL6l8Hg8BlrmfulV2Uyq7hI8ld8nKWfW7nEQcNdITJ7pOeuCtXtncguspBjKbwq9G43uH5iAYfK+ErU8glgm2EB9BToGKR9Aa18e1eXUfW4+RbIaLPfoP3YCQWyA2wUZ2+V0N62YaFHwv7sb3q9KF46q/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSdP8Eo5; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSdP8Eo5"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so4508353eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053560; x=1776658360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=qSdP8Eo5VRYeu4OHMzGCrbGoANdRtQObksiS9/xl1BPpSoBlepOzpAEuL3CMlNxGFP
         Z8w47ol7b+T5LyUjRcouTJsW0jU9slyCS2RCI3feLdAPJNnp4I61ZnljbE5KT0dnFU9H
         QvZ5XYNtUbt43NqKAsmMSDkDbpaVwsS1UTHYAnL547pfktaHs1Z1BJF6tA9ENLQJ5Ax5
         h0Ow7Pwalr2jjfcHfpRG2iwbY2oNM0qECeVpRjf2TP7mbG0J2zCo64Xrs+/EXboHZniJ
         u0TJ9yiOC08GGivIqePqeSJgqOV8yTpIenutUK2c4BHIhM1OkGOc2FUc3kmo2UQCKRA+
         pZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053560; x=1776658360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=TwaitXRoUKI+nenzH6JatpbxgO6HGzXLWKemEq/KS71zYh/pezgblNmozXbBSMmeBG
         AF+W3t65TMsP+fFZxJIAJ7UgotiGb0g16ZUBMynFOFf0Gf8omxnSFoY9KpmERz/dn8yf
         clmFtL6iYCn1qqvM61fcaW1qobfXImHWg9CeSXoDvnumZIDN2SeVKwf9tp0Z33MIlQRR
         lIsQALzYAyuusITlFy6JLZGV7m7MDDeE8Ms0MtuxEWhHV6vKeSuHntfgMORlL5des67s
         giiQt9JQZfj2J8fuJLnOcO6gttgvoCIWEiWvHmxC83yhazYCuuN0X9FejzHixTJdKxMz
         FcjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QdjZJBSITu1gywruf/z6byG0UhMykbql3ME0EC/MzXzNGpv/ndKMDlfWcrRIiSYAULsQ8rxOGYptkXDB0FJyp@vger.kernel.org
X-Gm-Message-State: AOJu0YyElcZnbnYIvvb9BF+puwy02z/tLk7pV5h88Z9feayMCf55IIlg
	xV2JC7ptjtYRmMjqa0iwqHH+LQNE41oATEjZmyhk+3SES4XHMjbMrdlAIiUqY1BM87Z2kuoHroB
	b/TsDmAa3hA==
X-Received: from dybir4.prod.google.com ([2002:a05:7300:c8c4:b0:2da:13c6:f288])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4089:b0:2cc:afce:bc01
 with SMTP id 5a478bee46e88-2d589daf1b2mr6310451eec.29.1776053560269; Sun, 12
 Apr 2026 21:12:40 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:29 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-20-irogers@google.com>
Subject: [PATCH v12 19/33] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6cf73bb0c7af..c8474f7ac658 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1164,7 +1164,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 22b0302252db..e32331fee277 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
-- 
2.53.0.1213.gd9a14994de-goog

