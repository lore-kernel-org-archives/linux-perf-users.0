Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D31DDC1E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050934; cv=none; b=rPa9W+R67Mz8njk6UIWDSoN2SHHhgfYMnMD1bIMOlobj2tq6N2A+188vPCoBmByM7J0UJlka83RA60G3JBs0c0m9HFnYgAHMod1D1/2+FpSLrhzUsbrHu/kUgSbylrHZohFU7c+wta/P+7qVW5Bg3Q0+ZFbBvZPKGlnZTxyyZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050934; c=relaxed/simple;
	bh=SsXRDJHGxhBiVFvbMp5Va3kQ1XX9V2ptMIP6IAJfjik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qhEJRwl579IktNVTxM2F4xZrU+yF7Bi8bT90JhzSate3MM+BIZ26GNuZJ68rjI87Eem/565B1JSWyNI0DEYuvZTLAvT6FpLrtqeXvjr5DtNxxbgSjCxGwls0N5lqn2livgsDHO9JNVOM7qKcgFSlioBXmiiBUoSvt+XVEw054dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ez3U4JEw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ez3U4JEw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2585908a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050932; x=1750655732; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKPUrJSvkU3DHLcEcQ+79yvgqlWdK0rvwPvnQ7AV5Oc=;
        b=ez3U4JEwP6XDacPl3pw3k5xOwLXxb/CZT+cYmSAo/rO/TPl/WjKazeaLvibf8NiaAQ
         eMVfmuTldSGcWxuF4unKq9BQzz2gSeezCxw7aSxkYVkltJIt1r1YQRa4jV6UjLT2fpno
         WcqwdaTpe4gSYMLFPKKgegZRSGeljqTyHltVHuMTMOdvxlsBmFlgLbGGx1K92W2u/NUE
         b1IFvDU9fCybCI5MUXc/K5o68HSgTll89n9sexCMBF9h4lW8gYlCyiWJH1/r8RmvocBZ
         yR3n6eXVqbgcZNQ0gh1C0j2I0st7TwoUeqMZzHg81vp5y3ul51d7dv0CsxUgkO+sZMK0
         X3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050932; x=1750655732;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKPUrJSvkU3DHLcEcQ+79yvgqlWdK0rvwPvnQ7AV5Oc=;
        b=NU2xDDqeDf66n3aMLZiN5o9eyA2SpvmmRVBayWVRfJe3woylfwL0IbTn/ea55r5tzd
         13v6VrdzHwgtT28szNO02qZ6Ykp+1XRUF8DGeRG2xjd+KoTHkTUfnCAruGWypr4kIs+y
         0X9Hpy+18pZmMSMRdWQNkAU+22Sp7cSiP9VC5PsAMisemHBwjlQETLUTYXyaqxrw/RZL
         6kA1ThpRFAlsRhUCwSVd5vWVBr8ci+2OysGYOvqWRASpaBfXjzv/smuNOvHLMc1yBXjc
         0R1YCvIovzekIylc3SoF5R4YyvyKIBxnTEfZrGthYA3f8cW9VxYeoiBZCN2D8r87IOSY
         VJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCUkczbZ3gvSKYgoEsj/5OKmRgZMGemTY71XuQ4wIn/uroyJGKhy5z01ihOUWW8wxhfdr9oJGJeLX439yL+dAYBg@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4cuTej933LwkEfcwzp3t1iDpi84397cFXeLynhuUEWHT5DWZ
	fMRkMhFNpR1tYV5feqjr+ySb6ctUyFVXiHUPrfoBC3K+4bYieAGwGcEVvxODMZQrr1TPrJG918z
	QFKKh1CEBwA==
X-Google-Smtp-Source: AGHT+IH0O2STUfLj/UIOx0adavcx35iiADUlahiPG/Xf/979SkMc7TFDRmdyv9KtZZr+1FEkeToo93gA14P8
X-Received: from plzw5.prod.google.com ([2002:a17:902:9045:b0:235:6d5:688b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c66:b0:235:f45f:ed41
 with SMTP id d9443c01a7336-2366b32ce9dmr119423765ad.19.1750050932608; Sun, 15
 Jun 2025 22:15:32 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:48 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-4-irogers@google.com>
Subject: [PATCH v3 03/15] perf python: In str(evsel) use the evsel__pmu_name helper
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
2.50.0.rc2.696.g1fc2a0284f-goog

