Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C548F015
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905251; cv=none; b=hmj2g1S2c2dzYtSX2FBeHaoIfKCW8WIWPJTxOs/Yb+PNr1Py16sLlN3p3mAluR5iFBIR0CK6u2xYZzm5Y+zmgcx5jINhKG5PCBznxMF+I0IY1X3C0vmdgiwdPsKcrGlkHAKKOk/20TVsUroYI089jF1Q5BzG41FjrJU+3Sp7A5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905251; c=relaxed/simple;
	bh=R6ddLj4qpQcWo28GoaB+VeJdr3ZHW4JbeaEBuc5D0WA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=nIZy41VKCWEYICYOBU811odQdi0gyMQKj1ApYR6I+y9XiemmIBJhXfYHG8OUrMWVxgms+KlQepYqihdKbV3mBIjqoZMBwKK5luMspd4XndEA9XGa6K8AIUdCjgQaCgoDM/mSnnF0Iv9BbRMqnK7ej5dJTYNyqe8xqhJg9ZdlGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUFjYXy8; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUFjYXy8"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b90cc0d5cso2069064a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788905249; x=1789510049; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wq4cyKKlw50Wq2YF/HlUbZTYcyRZ1QyW7Wojt21z254=;
        b=vUFjYXy8otLZxHMt0nsVoK7/DRFNrgich9JlxpHprdtqWZfBy6uMWyUCQtP/EZHnx5
         eYsO32TdqWdYY/r3CNcinreTBu9njDBUk/rNgUj8eAF3dGKhkF5qNfTpBdc+k67s/k61
         egxUAnyJVnfexDMyyebXaSu1b4PT1F6k9C1EoE1NEvRhuC8OHweM/zKDOK54G7xscmGw
         4gjx57lNWiPXCalCx8NnoSU2zLltmHZ032KlpY7AtJUiyv2F4ecv0/naBD7KyN0or06A
         sIJQsZEXwm0b3KXQmOeVBlBB500rBZiKmS4dthte5Q/1tW8oOKOiJndL9J9k5hnCGntK
         tAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788905249; x=1789510049;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wq4cyKKlw50Wq2YF/HlUbZTYcyRZ1QyW7Wojt21z254=;
        b=G76RJJu4fUvfYGIgrGRz92L89DjuA7RXBm7klvTM2OUElgU64+n/j2r2F4txUHg47f
         V5jxZthDXp8UWNzd/lDOWXBla7ROodZq0rCe10q+eElmoYNSTGV4q3cgKz+8hpU6ZrwT
         hwo9OMnx302vIjSBGtsKS5FF4Dxxl+LH3x0oycE4J/3w4THdvsXfSUHONofTvIY5VDGJ
         XQFZioK4tKxT7DU1ilz2iVazB+rkv89Pe7WHZtT9GGoQqN7Z0GSgaSbvkfHPPNlUzHBM
         S4fJVoWU97wL4v3wElxfc5vjcnlOwmnqRea/qprzHSQ8SXKUAbzJNdyogLbqzI9biTjS
         nLaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4vxuZXkNVVL9cPeO1tPNf4aGWAfOBDqtSNt7H0EbwPNpIO8TNzmLvAOQs7Ujz6H+KBF+1qsiEJAw0aAV9xfx7@vger.kernel.org
X-Gm-Message-State: AFuF++m+g17A9gSM3VAor5Or0qjH+WUCn3EFH+oIhpGddCCuvCR6N1ar
	5LSifCh6HtLuHYKaEL9H9C9JkwhSLj2FsHg+n2M+PBLKEtoKjczhOU5iWuuupsPsvjnkfxwik00
	k2JTkQ7j+uQ==
X-Received: from dlbbq8.prod.google.com ([2002:a05:7022:6708:b0:142:efc7:61e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:578c:b0:398:e6b6:acc2
 with SMTP id 98e67ed59e1d1-39b261e7649mr50141222a91.12.1788905248956; Tue, 08
 Sep 2026 15:07:28 -0700 (PDT)
Date: Tue,  8 Sep 2026 15:07:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908220720.564614-1-irogers@google.com>
Subject: [PATCH v1] perf stat: Avoid uninitialized memory read on error
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If has_supported_counters fails then msg was passed to ui__error
regardless of whether an error was written into msg leading to reading
uninitialized memory. Avoid this by always terminating msg at
initialization.

Opportunistically reduce the scope of msg to make its use clearer.

Fixes: c9a8c343ef2f ("perf stat: When no events, don't report an error if there is none")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c50cf230f16e..37752d6bfef4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -777,7 +777,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int interval = stat_config.interval;
 	int times = stat_config.times;
 	int timeout = stat_config.timeout;
-	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct evsel *counter;
 	size_t l;
@@ -908,6 +907,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		}
 	}
 	if (!has_supported_counters && !stat_config.null_run) {
+		char msg[BUFSIZ];
+
+		msg[0] = '\0';
 		if (open_err) {
 			evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
 					     msg, sizeof(msg));
-- 
2.55.0.979.g7e5102b832-goog

