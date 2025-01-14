Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98B215F5A
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896420; cv=none; b=ryxv4dQJkUsqPfrOsG3nSWOV51gmgkr52rJxAq+Mg29qwx8urHBijnSSq9gFRe0wR9o739B75qsx7NtiBPsWAmQI2YIdTaezp3ugSo5cWG61l0r1pb1xFNVRa6tkCoh4yj3DSfAbMFrWX29lx4HQssETxf5TIp2nl7zMLXpWHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896420; c=relaxed/simple;
	bh=A/eR8uR1yvM5eqZV/QlIrCo0vWCFnc2aKBHW8D8fiZw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PGs8HKvNK+3YJtDrZ/HlBX53kUsVoIUzgB/BVH4yn/LcfK7TvYVUyXRSAwrXioEVs5VV94quHSAvHWMEdt+BoOaUf68gkpoOYU7hQo6o/1fVCbQV0sRXPwK1NWnlYUyhwVkQIWmPq0WGL4tfnI2XWlXUUt/DcgQUjnKm/yEQ39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJII4XFE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJII4XFE"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549e7072fbso11553094276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 15:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736896417; x=1737501217; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDCtpsQOxkSPlmEY/69U0PEtnOYFr9Y2An71RRy2l+s=;
        b=vJII4XFEosutUic40r1P1ee5Xpoiq3H+NgXbxDHq2i6sv0OJesTLW/wPVEaygjbUWN
         eJpKUY+TQ6y+1MEUCwYqDL2oMTtOzlwi9mT5t6cQSwXWk0NIvj/lLQ5Ky9cSjKui28t/
         4BWaAwJPAHyLKePW941RqFYqqO0CrO2IoRrM2y2NJiK/pbRdYHsmFSyCdc1KP/dPZFxk
         lewKwHWqKUqlUI8hmefANKJoQ7f21vZ+WJcYjSJOF9f+iUNCGySZ4tnDbb3SpHKxlhmK
         WeoYLjrtoRLP4G40nZc0m714DxqLOCvTWj1F226QQbSwwSDRsU8/w4sCoVfV2ZxbpopK
         VenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896417; x=1737501217;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDCtpsQOxkSPlmEY/69U0PEtnOYFr9Y2An71RRy2l+s=;
        b=g90+Qosj4ledAOsQ1zpeWdIuDT7xCVkYG/4bwzC+G9ZtXvEfGhPgMsx6cQb6TJcn9Z
         Q5cM1CoXm7VTcpNQNXTbup7HoVKy17GRSzLLQ6Pj6Gw0mTSohwfxFD1MhMcA2kvNZ3Ek
         VJbGuSiE/s/YiEdXxtk02aCMm3HEc8C3gcZH0QdD/fGu8NUs7+uNNFlGlLA2k3oUmUec
         DJ7CAHn1AxEqJqlx7QZCnggR9GtkTMqjFaFaWkxfXI+jhMQHNhwMvmn3+5zO422LrhPV
         aJu9XPja4CsR6n2EWwZfu0INAk7digvarT+n+q5fVSTrxvdppyIWodHTiW7rphaUTCJp
         HTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkXtUJ33D0dTg5y18wwobvcPOfThS3JG0Dlchbd1+kllM4OwJ1KA0y+61hjD5zq/8m9Y6MT62F7P4oLntds4Zp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mmhLWvfA7DPfz7UTJMEpo4TUsZlh6ItjU33JU5KI22X32/rW
	LPJco/bNPEQ9y2wWWVM+5sa3PzpoGalmycPJvCajjftvcBHR3vgHIZQEKuy3JIko0QH5RAKcu8r
	LKkYX8g==
X-Google-Smtp-Source: AGHT+IHXFfkYqmyJHnA919HVCDNWdFFmo0150gT0EPvhDiX6howpfgKkpYwXQYkO3qFXWT31gATzIw/H9nFh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b3e8:96da:3fa1:5494])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b85:b0:6f2:8819:2318 with SMTP
 id 00721157ae682-6f53130b447mr711217b3.5.1736896417686; Tue, 14 Jan 2025
 15:13:37 -0800 (PST)
Date: Tue, 14 Jan 2025 15:13:29 -0800
In-Reply-To: <20250114231332.13419-1-irogers@google.com>
Message-Id: <20250114231332.13419-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114231332.13419-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v1 1/4] perf evsel: Reduce scanning core PMUs in is_hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evsel__is_hybrid returns true if there are multiple core PMUs and the
evsel is for a core PMU. Determining the number of core PMUs can
require loading/scanning PMUs. There's no point doing the scanning if
evsel for the is_hybrid test isn't core so reorder the tests to reduce
PMU scanning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc144388f892..ae20691bbfae 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3856,10 +3856,10 @@ void evsel__zero_per_pkg(struct evsel *evsel)
  */
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	if (perf_pmus__num_core_pmus() == 1)
+	if (!evsel->core.is_pmu_core)
 		return false;
 
-	return evsel->core.is_pmu_core;
+	return perf_pmus__num_core_pmus() > 1;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
-- 
2.48.0.rc2.279.g1de40edade-goog

