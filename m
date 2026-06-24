Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54E322522
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278176; cv=none; b=SxmWkFHaRb5wqfhr5q6VGFQm9dhqIT8FXpw/LMXuBeRMPKbjVfzKslzm8bG7UAZR1Cf7JM281LkMuY82wasWEG9n+O5mjqPW2HQH5xaf8f1xN29yfbn3AmPKdx2dEbbvJfacDZR5Xk6Pghm2KF1WIbvBEcoob0d/sbpC1sCRpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278176; c=relaxed/simple;
	bh=aca6tWU80rhw4alRBrLVqCUEBCE8aC5mBRa7ZGxXCCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=acnDmYsA/4OfmXoqbuRh+ffB5HRyHppBUKzpfL6CgYhjbTNVIwlLSnMPOV/nZO8u2VDe2QTlWeB2DxLZ21DdrP53orqfIKYRKr9MiLTNQIDulRKc2DL+2nN+z/Oor2TctP0b+WwW/D++WSJ2djXCVweDfZSOX5BMln66GiE/QuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdnpThmN; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdnpThmN"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30c5319332eso879358eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278174; x=1782882974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8M7kcNnvHTW8WTcBo7sr2k9glTOl5h1iyB0rTWrstlI=;
        b=gdnpThmNcuuVo+ECGrIeTuzcEFBvxGINR5qOaSCd3xpZvMVE42WO5HzFPEME32Il+E
         HHsu2dQyCn0agjUXPG/hcBPAikyDUo1+7GGhX4mlIkwIaJlHFTBxrbCVJIImKGPZsvV8
         4h6nvJZ8dNcvc5BWWxUYJEVjy77wf5JGUlmSD+In5kLytdQfC6ax00bhuefEQy0sPTuJ
         mgSZCvQ5CS/mDWbbHDAowmPv0IFAMqGNQkyzDGzeDoQZKtpBK2g4dR2KPS+gLf0K5TrO
         Z2htkdfavMJOmOEq0Uv/7ePzLJG1xYsjYIpdhWyn98Y895JyjsrycyfdC2jaOZwJObPt
         DF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278174; x=1782882974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8M7kcNnvHTW8WTcBo7sr2k9glTOl5h1iyB0rTWrstlI=;
        b=qdICZo/CdOGB8lU9aTawrhHqzFKSEpg+GmUKJf1Etx4wV2wXn9yuealGA9LlwVFECb
         ZSyqOctHUk3tktsiAJO7wnQ0KcJgdoCYmnON14onIPdCs7K4dMJsW24kGY3ImltVF98O
         y1caxS7el3f0+nLlO4JUo0CUjpNCyr+t0JPYXXwK5sONDxkNycSSDRYooJkMGYLV4ReN
         LFK45xxuqYf7s1X/FZbKJFKWFREbBoobyxclfLOJZj91MVBp8K5rjtwpECc63GnI28CB
         rXt5g7N9xRXHqWZmBMrNA+xL9yk0pyDpBzWpTngmDEoTEtidSe+aA8VoSDrdFvhFz1cL
         JNCg==
X-Forwarded-Encrypted: i=1; AHgh+RqHp3sqKgHLi9PeHpt6vlsQBLJm7Lf02mlq0chNJ4nCJVzfVQTxOaraCby4U6lB/ExczErn/Q/h3fU8bXcoRbuM@vger.kernel.org
X-Gm-Message-State: AOJu0YwwM2fxHqHLzXg6nr2chJqWy6enVljlpBetUWQY0BwaM3vxQ/8n
	PU6pvFYfDvBBUx5ixqafbcc/jx/c3L15LNyR5EvmrU/2+bGVA1cb0aTrGh4IHXje9HZdiNbO6FH
	ajT38G1FRXQ==
X-Received: from dyp4.prod.google.com ([2002:a05:693c:65c4:b0:30b:61f5:5091])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a484:b0:304:dc05:607e
 with SMTP id 5a478bee46e88-30c68d123b9mr1992915eec.14.1782278173798; Tue, 23
 Jun 2026 22:16:13 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:32 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-16-irogers@google.com>
Subject: [PATCH v2 14/16] perf python: Fix count_values memory leak in pyrf_evsel__read
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In pyrf_evsel__read, if PyArg_ParseTuple fails, the allocated count_values
is leaked. Move the allocation of count_values after the PyArg_ParseTuple
call to prevent the memory leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b17b191b1625..e76a407cb2bb 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2204,11 +2204,6 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 
 	CHECK_INITIALIZED(evsel, "evsel");
 
-	count_values = PyObject_New(struct pyrf_counts_values,
-							       &pyrf_counts_values__type);
-	if (!count_values)
-		return NULL;
-
 	if (!PyArg_ParseTuple(args, "ii", &cpu, &thread))
 		return NULL;
 
@@ -2227,6 +2222,10 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 	if (evsel__ensure_counts(evsel))
 		return PyErr_NoMemory();
 
+	count_values = PyObject_New(struct pyrf_counts_values, &pyrf_counts_values__type);
+	if (!count_values)
+		return NULL;
+
 	/* Set up pointers to the old and newly read counter values. */
 	old_count = perf_counts(evsel->prev_raw_counts, cpu_idx, thread_idx);
 	new_count = perf_counts(evsel->counts, cpu_idx, thread_idx);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

