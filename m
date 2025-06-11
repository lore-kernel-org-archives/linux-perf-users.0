Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F011220F33
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613578; cv=none; b=JGR+0FTGQ8jjV/WUIN9Hgxey351c78fG+LZVSVQhKT4Gf1HB+rNYe6owx1CP5wmdmXmI6QsT6NAKzMVYQwhgT2EfYNCCNpboQraGSaEZWVtd4Yg8ZaTR+KxD0kQNBMcHuC7J5YoCQ8fQliOLurNUKlyWL6hGGIVnJRuuGZaLLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613578; c=relaxed/simple;
	bh=BtcOquUGwsjRLqbBlkEJh0ol3cqkffLVbzVijupKQ7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UuRJhPdJt0uaHkjZsdzjqEGmvUGGnTMG4Q1B45TyUW3hraD8YQiZnWGj+VNSMUQpa6C44Yyl7UG2bTNEeWnR+5pMs/j9ivEsdQ4DOR/Le1lZ8loCHUTjDod00MNxITjTcxz2CtYdp2kTWGGz3wB3x1YqXLG2wjlDMckqCTNzbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0Xolltx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0Xolltx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74292762324so5703921b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613576; x=1750218376; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5Xx6iphroRaR7e/xw5HkqxmSocnFfl7rcbz//2QDaI=;
        b=Y0XolltxE8u9NvLh/vF1sN1DC+/opIMAMguh7FPOeMXxDz4h1l+zfY/escpyrrz8Ax
         PdiR6fehVAhwCltx2YTTMFaHGt+Pl6ZEYtsQxz6UOL6SlTl/GInj+xSkJ5keXbjXBSzE
         a8uZ4G1wWHVL6jZuzv3UVp6ZMJC1UnLvXzA4iMi23FbcUhmxZH7makTK5bXhZ29IXI6V
         +jwJf0DaLTjtlfNKlKG5uedp2I0lil937VpP7XjvbzgJHLCLJKQgoi4RuvRDmPQHtX3X
         QS5LT+MZAb+Mp5htHkuaP1S3XCIvTSGcbrXM6ZOrucAhU95lk8aCdDJJef+HTQyCtr2b
         L73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613576; x=1750218376;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5Xx6iphroRaR7e/xw5HkqxmSocnFfl7rcbz//2QDaI=;
        b=T9SwCC4KttCOaVn0/1fEAXhiG94hkx6yFuw2838v8gjpDCCJOETogkJgAs3qWa2/3I
         dCAjDokOgSSFX3K2N5TwtRgI7XAIPXSts2JeM+238xtUNxKQHPZRMOtRNnvMSX+40jcS
         UHENib8KoUlj1hY4GGa2YrqovFmtydNwjnrMuzC4E5Ordh67umima6rx8ph1chCQsVG6
         haHAp52Bh3kIDDC/7YmozyXkc9roAJK8KKPDGalbh+RBupwxPggB9DI8vgVjO0D8xZiD
         K8hFYdNHA8FKJQ5H7KBgroXJdo9gQAE+S6nwa52A9hEBWSOQ4keUhyZagjCY+EV9XZBL
         Jkag==
X-Forwarded-Encrypted: i=1; AJvYcCW9xYvA5gcKs1yQyTjScDaPcUMpqPVzl8qYj8CewtT8A4gvFqVKBmWr5yDMl8/vgd4IomsbWc6QyNao5zho/8/z@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgVPyShEZluCCa/TXf6QCOQlB/0/XApouairzDPz9VR/9GrXD
	XcpjGH45sU1mhZcbgLPT0YKK257HWk3g0FSVHoxbBWHjIf5ZyFfK5+1ps95O/HNuwUeQyJ0MpPA
	oCcu4GuwwtQ==
X-Google-Smtp-Source: AGHT+IFQVZM1IhRDpBF2ZYGc8nNH0F8JFzlu7zx3JEGYRdMi0czqCNaqZ9Jj8ehUm/ulZYPW7648pVCmdnF/
X-Received: from pgbfe4.prod.google.com ([2002:a05:6a02:2884:b0:b2f:a049:b765])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9149:b0:21f:5674:3dd8
 with SMTP id adf61e73a8af0-21f866f2d63mr3054859637.26.1749613576027; Tue, 10
 Jun 2025 20:46:16 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:17 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-4-irogers@google.com>
Subject: [PATCH v1 03/15] perf python: In str(evsel) use the evsel__pmu_name helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The evsel__pmu_name helper will internally use evsel__find_pmu that
handles legacy events, extended types, etc. in determining a PMU and
will provide a better value than just trying to access the PMU's name
directly as the PMU may not have been computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 82666bcd2eda..49e1db3feb87 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -924,10 +924,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
 	struct pyrf_evsel *pevsel = (void *)self;
 	struct evsel *evsel = &pevsel->evsel;
 
-	if (!evsel->pmu)
-		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
-
-	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
 }
 
 static PyMethodDef pyrf_evsel__methods[] = {
-- 
2.50.0.rc0.642.g800a2b2222-goog

