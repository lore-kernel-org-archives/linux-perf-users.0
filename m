Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93253255F2C
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309535; cv=none; b=mfsQuQJiMmH+FCo8AX6hsDIY+vNpsWBZTKwAcYqKjrNGUda2csHwpn6c9TIfd35r43mxiLKz4a17kiyTUhIkkEXps1xYXw3Y/EpaTNHxOsXHW49nC949ZO34ctIjI6RG/SQB5pTIazwageN7svh/q1iQUq5PdxNdJ5GXVZlp+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309535; c=relaxed/simple;
	bh=c4rty2Vnziwjh/LMTOhbLoNjoNaakNpOcQrNVlkkzo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cG6VbAPm1UTdkhzy2B/edBibZWc2Oti2fIRSG7o2lT/2fo140m44X68XaoqzSKGnZHChw/VifWI3N1drcvt09rWxGR6McHUNKqewFuKWcu9BkZbXp8B32e5OpMnHnsBXwsm76g2Zf6v2wsJhAer0Og68jsokARRFlv//pH72xxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5nFIBfW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5nFIBfW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso8400217b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792309533; x=1792914333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRK86LcQ1Gjf003ljRxiOMmeLuULLnOz7TULLZT/4gg=;
        b=i5nFIBfW/4w+3gwpbtc8wFKtdyfhpLDGEzx/cbQ20Zpr0aLQIAQpmGSqwlUFfbjm3M
         6NiGeOSCBR4P4YUct89KFh0Arkz3phmqS7/uniObYI9nuYlPLBKeg9C+PuKPy6g/hj6M
         sM7FXs9YrkmYHwlWCX9zjgWVhQvEWx9LZ32aN1PbNaAv2ZzE5ITi/aK/kXOk+Tp5VdQA
         FEz2o2T1RQmTkAHNfGbvmh6JO5bmAtChzzmXcCYU3OR/ufPFyYrRhI3yspHIch73Tn23
         LSPUZ/obsVEP58LTAP75vdPFRjLdZWY3C5AX2u8XKZbCkFrW+MLJaCJcv1qxrngCl20q
         3vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792309533; x=1792914333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRK86LcQ1Gjf003ljRxiOMmeLuULLnOz7TULLZT/4gg=;
        b=QpTWxLX6gzZMqTbheT5lmL+e0Ifac8VD9EHQSZuOxgVnbL7XzzL8xjHyuX2tWl2XkY
         Td+k+NGEpHdb+mSHFmg0Zmfoj1GjrSo75Bn8RT2jR2MFR5jB79/0uCPTNRsf9oBkYkua
         YN4jAzpvmg8iZH1UWlRcwv6stRNWQ4LkrhZTeOsRku3c1BtYNFjyRqItzrOL80pMNpwJ
         nvuFVDj18bp0fqaKObfq+KZOga04lSONq6CwQK4A2doLi9f/5/bZQ9Dqytq3Y/knWHYy
         ES59E5A6EEkwm6Y7l0EWS39qXwRoSLxJOJ24I3a6RW5Tx4DYi//A2kxNIQ/4SIz4D4oq
         4Xdg==
X-Forwarded-Encrypted: i=1; AKwUvBxtsDJj9x6vxsng3HejOB3GkOe/3mHNKxaxUPSEzgV/wZumUOMyHAiHm4ZmKbEpDfGajpS+agJH3v4jfQu78Q6t@vger.kernel.org
X-Gm-Message-State: AFq9FYJpfG+Lh1HIqPgGtVmvUU3GBP/kIxa7ironsw92cBKqXI32sORX
	Lcnrl6jtpz6bV7twBR/mncOmwpjCZVV+N0ZJnZdlpaxKfSf/K7h44S06
X-Gm-Gg: AYBFou1AQXXPAxDBBSbHdhGstQtbY5HPIqyq/mam7xHbs06taKQjK8pl3dv7YhkZd3Y
	NluEpVeRBWwiwO208G9BtwA546jAqeMakerSWcf9BpPzIgVaaSl65iM0J8RvzuBHeWVYoiu7Qvp
	xBcP0rXUpUoVsAlBqZumnmMX7F/XmyFFxCGneShAQTLnoIMY3XOLHSdcXR1ZD1mpXMSWVt8D4e3
	qDZHqWqLn5gDOa0DmkIn7w6Uw/K/okk0SFgiajABBcZx7jMzmQFO7Fe1ORQp6/xpnQXgHSKlYLe
	y9CIvgKdkHfLFRL83Nb4Jb27ZCHYhDGAv0EGynG8V+/DA41IEOPli0q+nt6gZWevts6zscT+n4u
	D/qNp4EMRGvp0pX2tCCXpjP3KwLmiUWsXg6jz1JPr2nqG0aJ05eZFFeEVqlWURCe6446B6Yuwqf
	dW/Z7gVCvefwwrqdg95s77DhhEFmyhop5HNxhQPDb/qZ7HNFuy2lBKCvfJ4jARh2yvoty+fv8NA
	4EUnKQpFXKHtSV08pQ1fozbyA==
X-Received: by 2002:a05:690c:588:b0:8b0:d4bb:c9e7 with SMTP id 00721157ae682-8b0f21eb43fmr16299907b3.46.1792309533213;
        Sun, 18 Oct 2026 00:45:33 -0700 (PDT)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e57297a5sm28084257b3.4.2026.10.18.00.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 00:45:32 -0700 (PDT)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: irogers@google.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@linaro.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH] perf python: Accept events larger than union perf_event
Date: Sun, 18 Oct 2026 08:45:28 +0100
Message-ID: <20261018074528.974953-1-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Samples recorded with --call-graph dwarf carry a copy of the user stack
and are larger than union perf_event, so session.process_events()
fails on the first one:

  $ perf record --call-graph dwarf -- ./workload
  $ python3 tools/perf/python/stackcollapse.py
  ...
  TypeError: Unexpected event size: 4168 < 8424

This makes all the standalone scripts unusable on such recordings.

pyrf_event__new() rejects events larger than union perf_event, which
guarded the copy into the union that pyrf_event used to embed. Since
commit 2c672ffdad4b ("perf python: Lazily copy events and samples from
process_events") the event is borrowed, or copied to a buffer of
header.size bytes when a callback keeps it, so nothing depends on the
event fitting in the union any more. Remove the check.

With this, stackcollapse.py and flamegraph.py process a DWARF recording
of a two-thread workload, with the same per-symbol sample counts as
perf script, also when the callback keeps the events after returning.

Assisted-by: LLM
Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
---
 tools/perf/util/python.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 60dbe2dad5eb..8b4b2f3d0926 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1792,11 +1792,6 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 				    event->header.size, event->header.type);
 	}
 
-	if (event->header.size > sizeof(union perf_event)) {
-		return PyErr_Format(PyExc_TypeError, "Unexpected event size: %zu < %u",
-				    sizeof(union perf_event), event->header.size);
-	}
-
 	pevent = PyObject_New(struct pyrf_event, pyrf_event__type[event->header.type]);
 	if (pevent == NULL)
 		return PyErr_NoMemory();

base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
-- 
2.56.0

