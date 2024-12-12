Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E512223C68
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024842; cv=none; b=cS0AsMEWyZXUx3aInP7CfC4uRM83cL6k6DT2tueRCSUEC5HLc+rz5giLbKOvWxwwb6dt9ATZHVKEhuhAdjPd2I4Oz0Ot1K91WMJn5DWmk8gbgJwG9gt7SAMrkstlez+prWiNewhZV+7V/ffSsAPGHs6/P+DWk6gD9Mxg0SMO5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024842; c=relaxed/simple;
	bh=FK78yyqVjHCobD9natqpTkBTroblD9K+SecNHatoZlY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZCySn4zJZuSP7wyJzKgrr157KURLBv7STlrbjAH5yq4zZJTXiiuVcgJGRzxOaCnUSEZMqCOu8vSvxu7d2/7WonS8j5Z6SpRvElAsyPpQNzJB7O02YqKAJt1Kh/1B/TC7FEaHKHYqdSntoTYzPpiD4gNkbfcOOY6ZlqiO3ZThiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ilz9gdoq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilz9gdoq"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e38dbc5d05bso1273351276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 09:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734024840; x=1734629640; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=McevHFea/8/GUg9sGU8w00zhvfEuoLepq2oliEuLmsw=;
        b=ilz9gdoq3A1MVXWIIEkngksF+B5tRUTt0eWzKLqGO20dObrXSr6FMss/6v6TdwF8Cu
         yXitL0P6aBcIwrvKbiAnbENKMQzM7oooPEBFGcjftOAhvMj/n1whTZ2NCIeCTYHvyUBC
         wZMgLaWUZ6CsXWaG/85Ni6OB3k+p/rx9OeFkfOQMqdhsNm7yTZVCVQIMsLUA9PFcz0l1
         6bTNEh+9HdSfLqnxqdxlHq3ZCaBHxoNpIsjdP2O1R59aC4bgynmw+tgSv0a3RNUfX6Gh
         CAh364cUCf3+WXerm4BbSkwHqow9HqLn22cZdD05+IpW50SgSUwfSzcr27qNa/MBmLAl
         /j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024840; x=1734629640;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McevHFea/8/GUg9sGU8w00zhvfEuoLepq2oliEuLmsw=;
        b=Wpth49BXEP4Prxos5Fh6NST/jSlBknio4LUo1KCqJf+al3GljALiMaNywurL5j+xvE
         ahFAyqfnHw25Bp8H4u1ilhv17Eh3Gn4pYZ93cGokKiFWh5W76YIzbjB0VkP6pQXF0nTS
         +bVa8wxIXzqnq435/OWOzOgSqFMDgGvOk7SddpymszAtidDqQfg5oc7u0z2f3tPH9Jgm
         UNWIVPbeu//PAQOmM8nRmXC9esvsXd4AA7GKNwvHS+jPHDJJLI+N13JbZIJP1yZpEwuu
         AiojHrPUh6dmUgqT8jLSjufbY8Vru2BP8ST8EuGksZmhlzaUW31hKj+BBnXWoqZlyC3x
         b/7A==
X-Forwarded-Encrypted: i=1; AJvYcCWLPBWUgznF3CZFteZka6S0JPR2gINh64WmFAfmlv22FuIHBrYP0yhdKcO/nUSbuQKX9fytw2OcAOM0phdcCih1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SCJgvQvk7eivv989Iy8sDh7sZzo+OU01Pt89MLvZAdVMiUNA
	Du12vTPtcFpKAn+qJD9Bb7cmQmAc7hQrSzA/dX3+6Z/m/HjX49hijkoJ2KoMDdGhlXbVFgc6U5/
	PSoJdHA==
X-Google-Smtp-Source: AGHT+IHT5WTyXq30AAfRRz/fxMBvZ8YldrnuyFVNGmCaF3LmbN2PZoVphHBf/LGehk9tkdvDjxMehh2jGgr7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c22f:1975:e7cf:849c])
 (user=irogers job=sendgmr) by 2002:a25:5f4b:0:b0:e39:710a:387a with SMTP id
 3f1490d57ef6-e41cb05bcbbmr502276.10.1734024840121; Thu, 12 Dec 2024 09:34:00
 -0800 (PST)
Date: Thu, 12 Dec 2024 09:33:54 -0800
Message-Id: <20241212173354.9860-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2] perf test stat: Avoid hybrid assumption when virtualized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cycles event will fallback to task-clock in the hybrid test when
running virtualized. Change the test to not fail for this.

Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 5a2ca2bcf94d..da42427bb077 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -163,7 +163,11 @@ test_hybrid() {
   # Run default Perf stat
   cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
 
-  if [ "$pmus" -ne "$cycles_events" ]
+  # The expectation is that default output will have a cycles events on each
+  # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
+  # can fall back to task-clock and so the end count may be 0. Fail if neither
+  # condition holds.
+  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
   then
     echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
     err=1
-- 
2.47.1.613.gc27f4b7a9f-goog

