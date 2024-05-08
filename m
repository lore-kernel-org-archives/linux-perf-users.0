Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388F14A9F
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140395; cv=none; b=ZIrwfIG0pbCpN3S/WkraNebvhHwKTpo9oxqzU7MvItx4g9CYSjlVeqoyEeBcMjWYDPIPrOlDIKTBnJ7IQBZQ+0npoLIgyySLHWnWLvilQiyT2WVXfFuosJBqLCZ6CCSpLCmY9tQxw84unLrqf+AXgrcfeVzTw4+CYmPZnDlHVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140395; c=relaxed/simple;
	bh=QMqkJn+f/ByB+G/3NLfo9IraWlPvx4FuOXniSmKNgUk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IV2Vzqoik+tfvVhacsJBSylLfWzxpxHMDg4V1CwTFYx+rcYNcTVjecz276m1UIBoEJfeYgkh2KAXR/Y7VTshqhy1L6USjc7/qyPhJlSKM5Pz4Ss3dj7A10wjDOGQUvfbt8IpYEks8/oq1tsdvLVOK7ifCoKClHYYHvte6/0Q8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWE3yBUn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWE3yBUn"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59d580f61so7193039276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 20:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140393; x=1715745193; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOhzXSP6otJeiz7ZBDaSPLWGciNNQafio/HNsvoqc5c=;
        b=iWE3yBUn4q9qc5Q0zrSomt8CUnuw1EdJsuVjnIyZgBNisvFmDE3hI2iKiPUpZV3uXm
         zNi94ENyYdedtj7nctgqZmJZTK5rv9ORBgB+mscIG97EG8IISKPKZcybDV/wfFDhrPtq
         zVcY8C6qzyTECjTUZnFnmLQ9j5WmXzpFgCza2r/C1EiJyT+6zmyaScTRkQtaBzPCUPCl
         U2sNLfRno8azuujFt7WMyFaXH7Ateww7m3q+PHz8odC7w/ipVmvv8VQjJuxmxegqHPxx
         f41FmZyE4DOk6sZrj9ItN3bcimiFGN3Kx+CijLLO4ZdhYFY5JFZlOLIUufzpi9hMi9Dt
         NczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140393; x=1715745193;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOhzXSP6otJeiz7ZBDaSPLWGciNNQafio/HNsvoqc5c=;
        b=LKQ82QELC1ml42bHPu+9pBqWofa0nLzRDhzDYmekJ/0IfcnthngfzUbKr93AHj3B6z
         5QY+ozEqrf9FjV2tq4sfdDI0URVw1m3vFoYFJPgH3mvGdQFnYuqbkBOUtFkDvJpHZQGK
         E9CSoAL31vDH5kchGi1VAwv48JaGC6jSzHgofKkDF5txOOTCI6Qgu9mLvEH0Fk04tte1
         qV22uz5IWV/ca836obc4B9yTZwtygW4JAgESyscEkwLzbw+Szzzsef2RaIukA5ytKzzO
         0+7X5aWc1CRHm10eaXdlGCvBdjl0gtLxKdqgfu/1emR6Sqwb29PCz0EbI0fHN0haSFyN
         bPgA==
X-Forwarded-Encrypted: i=1; AJvYcCULGzGKynunxdl19GJ+er7ndhaHsSPrkulHQyCqmMVzqIznHhC1M3IGBeLUPd6tayhRDenkhaVztuNzSXpvjOARdRnHz54Lr02tXRetKiMFFg==
X-Gm-Message-State: AOJu0Ywp5jo/9imhQWi9XTzlm5OEG0jXDEWtB85t5p/O7Lu4AfW7jwxW
	VHO8v1NUGCucQbc70IYxV9+jpGCQaVHzyM+2imeM4MIQUh8udm8yR9PECjCEm1utx54kCQW0dKm
	oOFCl7w==
X-Google-Smtp-Source: AGHT+IEgsK4GbMBGYcgoXh83OnGEqcbvFMqSv6z15nT0CT0cVzVJxco0PKLMpw48lVcxJmIuUBGWnChzDWVJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1207:b0:dc7:68b5:4f21 with SMTP
 id 3f1490d57ef6-debb9e38e6bmr489657276.9.1715140393229; Tue, 07 May 2024
 20:53:13 -0700 (PDT)
Date: Tue,  7 May 2024 20:52:58 -0700
In-Reply-To: <20240508035301.1554434-1-irogers@google.com>
Message-Id: <20240508035301.1554434-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 1/4] perf ui browser: Avoid segv on title
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the title is NULL then it can lead to a segv.

Fixes: 769e6a1e15bd ("perf ui browser: Don't save pointer to stack memory")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index c4cdf2ea69b7..19503e838738 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct ui_browser *browser)
 void ui_browser__handle_resize(struct ui_browser *browser)
 {
 	ui__refresh_dimensions(false);
-	ui_browser__show(browser, browser->title, ui_helpline__current);
+	ui_browser__show(browser, browser->title ?: "", ui_helpline__current);
 	ui_browser__refresh(browser);
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

