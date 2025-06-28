Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885842A99
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069383; cv=none; b=lJh34bHrwS6+5U5ivEpKngNXcfDh8EO/i60fZnvQ6/5dOgDTkDELBatvy2SC574G/JgMqxGE5Yq/l6jlCK7Kx8qef77T/fws/Gz8x7L6gFsn8lO1VkvP71ADQSjZTARH1MjnXm/vYNbu3lRooieQAwm7vjZUR9zd5ddYFW2kzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069383; c=relaxed/simple;
	bh=LwbHih280ChFbYG9oVDlYtrszId/76RXBNEv7fnSzeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TnxzUQUjoRCEnc9WEYYu6q+6aD9sR+koMofE+IQCP/EuZ4oox69CR4WWW4iE+W0upN6YEPg3jIRRep8dfcj79CeMfB/um5i/zAlHtdwBOJdUoqJSGZyp8UHo0nQsc+SlLcrzsav1QaQDDuj+VU+lOg18cJGOSSabDVEjBMiJp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRO4UF0V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRO4UF0V"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234fedd3e51so967475ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069381; x=1751674181; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2S9i2po54dMnEvHzrB8xMFU7a5iC7aF370u8g2mtdk=;
        b=GRO4UF0VpVxKUpdxzk7s4a+Ta26wWDbfInyCkBecJKUWZq6nRu2UBIYceNgqSQ7boh
         jxW/+VKNFhbIlRZVjeZ3A2+3Dgsib+Xl5Q57beaLPPe/4XBoF7jTLq/Xy/wSbkaRNfQb
         m3Wpdck4d8E+qgvyuJ+fBtHNkQK4ErFfsFsNsn1SBzXimGFE35yaiprRKrROH4FWbe0o
         PjKDM8n+NXPg5wtYoFhQMnKJ8oicSAPnxrslPlXKpDiUeIYrwgG1jreypj+4RKbk3YG9
         cCNFL1z9PUmoU9Mgvg508kxAIXh41cCdbKcnlug1z3k6Pk0V9F8S4tZYVLbTFiSuLrIR
         ZlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069381; x=1751674181;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2S9i2po54dMnEvHzrB8xMFU7a5iC7aF370u8g2mtdk=;
        b=EJDzWDnNUDSopXl8mZM4c6KFtc5Dx3L4aS9KhEV5ApB7f/cUYTKki3Q88BUFZ0Adn4
         g9F/PT9AzAApUhOj7Nc8qvh1NbrW3RXZ6lHKyffaGAg1Kl3IhHMa7zmT+VuDGG4og3vj
         5Z3DlnIWo+cGP0BBvhTjRTbVZJo+e+SYUkEg4wiT7X2cSrXnM5ApF5fP9wj0JwL7K6NU
         0YioMAnGp9t5OxEqsM9mtgOIEqGKXAJIZaRfzCluNRJQMEFwXM0DDerdpEcuGDGPE7Jb
         za3hJSwnCBuI5tWit9cEGKU4xgAJj0yJXg4d+3N2lndEamIxtatdGnfyLTXkbppAD351
         FpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIxJEL7zuVigTbPajSBPBGima5sscuBv/QAFfnblsrtXADCyAWGmkh9TJ6vcYzrAvJxLcDUwm3agfwZq3O5Pph@vger.kernel.org
X-Gm-Message-State: AOJu0YzewQyjpG9LcaAC+zmNz0vB5fVqz7BjywDcsMpZUf0nujLmv+yD
	DknN/NSn2w7Fs/So323YlMO78tUtDZpECeEioyqBcEeIzv+VGt+1n0us563neY0ptSRanWCCylg
	7fc5FdjBaPw==
X-Google-Smtp-Source: AGHT+IGX516F7yivz+ZLZ/vXjO8xw+uXMeaMucnwReGhLmqXBSH/Dq0xYYxY5RjbjyKw3CeFdsL0PsK/O8g6
X-Received: from plil14.prod.google.com ([2002:a17:903:17ce:b0:234:bf8f:6965])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e807:b0:234:bca7:2926
 with SMTP id d9443c01a7336-23ac4605990mr78443735ad.27.1751069381230; Fri, 27
 Jun 2025 17:09:41 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:18 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-5-irogers@google.com>
Subject: [PATCH v4 04/15] perf python: Fix thread check in pyrf_evsel__read
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

The CPU index is incorrectly checked rather than the thread index.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 49e1db3feb87..b724478fe34a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -909,7 +909,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 		return NULL;
 	}
 	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
-	if (cpu_idx < 0) {
+	if (thread_idx < 0) {
 		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
 			     thread);
 		return NULL;
-- 
2.50.0.727.gbf7dc18ff4-goog

