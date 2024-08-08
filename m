Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604563D
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075364; cv=none; b=Bb0n54oljk0afrId8nixM3X2j2zhcq1YJqfpLwGwzp8j4Q59JKa7lrSh0EB5aOd6yYen66D36C9IP27XENXbGri2sAkLVhdDpgoDykaxLEoqrwcOZXvWlzFaowiPXoVwlsW/9bsqXaG52L7ANWlHT+oZbVXA+F0/ocAvnxdx/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075364; c=relaxed/simple;
	bh=uQzfOazldw0JqLknMciKwbbWbhbiTHUfGut9jw12Dw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tosUpda/TX1+BikB7sZklt+aP9yEUnT8IrH+zdTYUavKMLg3yHmso7wqUDDaoaZrekv1BZG+PUfzZPFo8fyTv3q9LS52H4a0imgC4vllg2rY9MKSylXGfLU163P81CC9FmLqffFTkAncGQVwrC53KWztHxkgAWaM5Pg2wT+mKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YVy1SseF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YVy1SseF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc5296e214so4766705ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723075362; x=1723680162; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEfCkxFQLUR1wlu3iGSRC4aT3NV0D15wJnp8kFW8Q1U=;
        b=YVy1SseFVEUPDHHs0N1J3dgkTTcujPko37Gu/2vQR/vitBCYi5O+DQeIbFIRVHR+Vj
         KoLRFtHkCbURyN1/rDphJek4IrT0peiQc1lOPhQDjoR7GA38vH4cgSXggmEv4FfD9s6j
         BIICSdsu2DEv54yDKLL6zqlVRKUbxOT6mSZ+AJOZDrAE3pHQEDZGEt2+h2ltuYnO6rbv
         NVAyZqS3csk9ZZ3PQCtjHeObsCsbd/B8HmD2HNDxvuvdDcUa3NPmyQ/fJSw8sJq+KO98
         qj4pw7K0uHb7VQBmTiW5oMdCMSp4k2RIskJ5f0WjyOqUgPha9SbbXAxXrjnKGi1A8ajA
         Hjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075362; x=1723680162;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEfCkxFQLUR1wlu3iGSRC4aT3NV0D15wJnp8kFW8Q1U=;
        b=WB6kepYWDRF/yVzSVtPBDb6E11KoNOp12/uO0IOFYLXUSwMTUTZf18QqU9H3jMDXBm
         gL+B/WyfsBCuvVXzIfdICG5ZhIWJgaMjv4A4s04+L+uzSVPh+DnZt7hMMcDZ8e9TLuvU
         3tDSgKBOqbyKJE+y6VRcwaR3B4zMEEjy/kFF+jY7rBDBDvAUd+7IsPGA9PDAmZOeDZf0
         C+t9Ef/xL3KEI85uH906iz6reLQO6TMRsYmBCVxI5hQ1DenYQNqPIFmNmcpyaKlzFozt
         5Sv7Y9oChiQqjazSZN+AOiLVTNcvn1dzhIkMBQ8gPJHxV6wQNz3mEbWU1qW3bliep4na
         8fuw==
X-Gm-Message-State: AOJu0YzbqdB/Gt5bMCkBtWhjQUukJqvbnNf3C9WV5mNmxIcrxdqVeK2F
	akR5Ps7woeYaSl2Zny9C+L52NvlbNoMCtaSJe78HBaceMGEh07/PzDDtTQt7/6M=
X-Google-Smtp-Source: AGHT+IFnTaa6CIGV3FF+O9JQgn1iOVDOPLYnXb2/Gg7xfean2NodOB4OlysTEdXKXvFFQJxkiUEgDA==
X-Received: by 2002:a17:903:22c6:b0:1fc:a869:7fb7 with SMTP id d9443c01a7336-2009531dfb9mr3988265ad.54.1723075361799;
        Wed, 07 Aug 2024 17:02:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f586f7sm112867015ad.90.2024.08.07.17.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:02:41 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/3] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Date: Wed, 07 Aug 2024 17:02:39 -0700
Message-Id: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8LtGYC/4WNQQ6DIBBFr2JmXRpExeKq92iMsXSok1QwQEgbw
 91LvUCX7yX//R0CesIAQ7WDx0SBnC0gThXoZbZPZPQoDIKLlveiZRt6MwWMEya0cXrRSpHxXpn
 6rpRsegllunk09D6yt7HwQiE6/zleUv2zf4KpZpyhvHCtGtRz1109JRfI6rN2K4w55y+DkxNau
 wAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723075360; l=1643;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=uQzfOazldw0JqLknMciKwbbWbhbiTHUfGut9jw12Dw8=;
 b=cTf8edNn/C7Hbg9rpIPrx2kKi0BnrYIcjUmH7YGGTa/0iMFXvyrG5XO+k/e76uPxnTJsyThIa
 pmb/3rXC7KrDgpfXjUSYO/PgRcMqKe71dAP7rmsTlRBx3N5oDH/f8lx
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce a new perf ioctl key PERF_EVENT_IOC_INC_EVENT_LIMIT that
functions the same as PERF_EVENT_IOC_REFRESH, except it does not
immediately enable counters.

Also create a libperf API perf_evsel__refresh() to allow libperf users
access to this ioctl key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Drop discussion about signal race condition
- Add new patch "libperf: Add perf_evsel__refresh() function"
- This newly added patch was pulled from a different series with
  modifications to fit the new ioctl key
-
https://lore.kernel.org/lkml/20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com/
will be updated
- Link to v1: https://lore.kernel.org/r/20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com

---
Charlie Jenkins (3):
      perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
      perf: Document PERF_EVENT_IOC_INC_EVENT_LIMIT
      libperf: Add perf_evsel__refresh() function

 include/linux/perf_event.h               |  4 +--
 include/uapi/linux/perf_event.h          |  1 +
 kernel/events/core.c                     | 17 +++++++----
 tools/include/uapi/linux/perf_event.h    |  1 +
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 49 ++++++++++++++++++++++++++------
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 tools/perf/design.txt                    |  5 ++++
 9 files changed, 67 insertions(+), 16 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-perf_set_event_limit-079f1b996376
-- 
- Charlie

