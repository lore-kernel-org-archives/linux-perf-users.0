Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE12153D5
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409094; cv=none; b=qIxaS4l8v7/K5nXw0sHa6AupPXEzIw/1TDyLYpmd0D61jop/2Ha4AfMZBaT4UNuKAKP7iZChONmDizylkWxbJFLHljc5/OGXBYSxZD+xZLTwpSnQ/xTBwlCGn3zC5ysIDaSeU3qyS1HENamSg5JlrXrIdt1lkNXyBB9zdOwSPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409094; c=relaxed/simple;
	bh=R0a/vHYzWVhgCJQ6DCPAIedrH3ihtnvq6XuWZjEKuYU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hI+qXCkOq6Ds554gkjPm4CEzDGJlHkuaVGqJLYEBoaObPdEP0kUb3QpSwxAd9R5Cx1W9B6duBSNU73OAAqKzUpkFT3Tj3L2sri0VFkkV710s6kLq09nSvulIdrxDUOaMQvyq9YllWokS6Bwj6Fgo8uKh3NqRQ2stttXGVx46cGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmAkkuDv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmAkkuDv"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a109984a5so1240631276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409092; x=1737013892; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsmdkEmDEGEnP7ScF9FDAmVtpJbV7ac2JPwBDemRuGE=;
        b=dmAkkuDvLR4o73fQq5W/aK4RIa/3oHhimmKoMR2cuRk6+xW+MKOM1mSdNxtvO5pZY1
         meUgwpCjJASaU1dh+tQRh5BAg39xXPGOQZW3z93epF8QOeruyCLs5QA0DaqkZC1Ib5n5
         m6hjPiAKcIEjfya3RtiYeiqzQpYXghXWdO2uadOaO5C8b65a+8wPT2dDi2wAY6vNVApu
         SSfZVewVXDSn728mWgYYK+6kgCALEVORCAxtS7EGxJuPzJKOqPhPxYL/LS0mtON9Ivwl
         SuHT+fn4OGWbVW56XslH35gBpxxacvBBrHl+kvm+f8Q5EHSkSJhJAeCTeyDnwP4/NILO
         NNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409092; x=1737013892;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsmdkEmDEGEnP7ScF9FDAmVtpJbV7ac2JPwBDemRuGE=;
        b=TiMlRwGzm2rKyT6NJgYbJ/yQuk/Hzr6xjy21iuT4U17IzVEqizLIktaxianla+HRuy
         bu1LvO4XdMpxZ9mqhdbuIRWKCF/oxu0049oRFa0IXPCARVH9Jhm5w6uVX78KyvIYfXvR
         NItJszTpn+ZEtySbFrN2nj53uxWREMKdB6iaSAiqzKBkbfp9GCrXy0P2QBDrQnm5NK5N
         SwIqAkQOt7pWe+MNzPxiCJxvv/yw/V6wyE8wPu4U0ZZAYGL2nw+YTIRdIOAbqSq0bhbf
         z7DIcYQR3P0aV6ydXewvF5KNAHkM6iQ5zpCOBHHPljiw30M53J3lIJzyfnsd2Zq/CqHH
         SiXA==
X-Forwarded-Encrypted: i=1; AJvYcCU4PF0awxDUP4Cx3KFNtvO1zQ6UbDBFlYGii2AjZ/WZUemplHfrog6rHuui2iKfuz46mHoBgxFryuJPXAdNqH/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn82FyMkbtSHMUDyYgLR08puRngD4WLvv+vS7OpiiBmto4zq0W
	QVbIUNNTfZjm4MwRxEN5zXp9qzFv2neTHfSitIlM5b4lMoKh8ILNaX9XPlSKuiIv8gG7BGrNFy1
	BYd0Qqg==
X-Google-Smtp-Source: AGHT+IG8GYH2614e5n/bWNWP2I7UIMRcppng/RXt8U/s+jXzYYv6/E859Eu7ehMh8UQyDSfEYrPtJ9yye5ef
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a81:b547:0:b0:6ef:5754:49ef with SMTP id
 00721157ae682-6f53122646cmr124157b3.1.1736409092375; Wed, 08 Jan 2025
 23:51:32 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:04 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 07/11] perf python: Update ungrouped evsel leader in clone
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evsels are cloned in the python code as they form part of the Python
object pyrf_evsel. The cloning doesn't update the evsel's leader, do
this for the case of an evsel being ungrouped.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 45ee6479e4dd..9ffe1b633027 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1303,6 +1303,8 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
 	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
 
 	evsel__clone(&pevsel->evsel, evsel);
+	if (evsel__is_group_leader(evsel))
+		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
 	return (PyObject *)pevsel;
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog

