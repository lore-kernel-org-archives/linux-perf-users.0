Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7C30C147
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462249; cv=none; b=ijlJqoO38MvwM3qlUrUI3f4f9Ok972ME09CJloIG0EaanT2ZXjcMxoO0IH57wBgSUPnHfkFwx8FYas/kzI5JG7gOuU2Akxg3u7B0awVWvQ1pfuLyvnI7ma59ISPPS+1NRQudSg6vcIm/NFnmNXIM/bE685vT0BhntDi3+7BCzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462249; c=relaxed/simple;
	bh=jkGm2XnEEYvI3D+wc+k8mgIXGLOkNXkPZcP/RQghtd4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jA5hfLVf/YRbHM3GuzJVL7EofVi5VvKvxkXt7JuF5STcdrJQD43l+PX7OuNQUC10EwZ2hc/i1cD8lzYi/j86bpNhtYlWo46br+pWcyClLpz7PdxVFzSyqPzKIlLjKZvsH3eZYnVed8omnvhNrrwd3q7mehU+2GMCe7k1Tsu0W/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kC3rP5hk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kC3rP5hk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49553515a8bso51310915e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462246; x=1787067046; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qG1LYmIXQwJhNszNA6JSaXd2z4OF9GJH1weAVjbiHlk=;
        b=kC3rP5hkgN4sClZg1VauGmPR2XBcWF7X+u5bcrbGwVlGzpsrj9wvr8T4qCvJqOl7dN
         wbDMq3SlGRN3OuPrIJjAafzbeG+Tq9z9txmeNj0iW81OiXgUXy/MI0j0nSfZsm+QZSO4
         JTnJPSb05SSv9WgCVIAA8laM3STH5hPqgu8ioje44JFSn1+ujlfCjMlu2NIOsCVHg6bR
         jbAdQhPKa7rcJ4Chq664KDJh6YoMEl1bm9WrfsdE4YLEmWHHKFmqNel4aA2lg3k97vEf
         XZzRZRv9fFEOkBOny9+6uQshGATyU3pjub65/FkEmeo/QQQ4690CObQgIqeeD3dOrIhM
         bR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462246; x=1787067046;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qG1LYmIXQwJhNszNA6JSaXd2z4OF9GJH1weAVjbiHlk=;
        b=cc7xRwVcLN6JSjvt6w+Ja04iZLC+qy2X6Vgt1Q7ZyxpVO5Hkk5xuiv7GOhCQB5nU3Z
         6cgWg+BKE9kmjXx8dfO7crXAlIdA4gHmOxK8VEbEOnrcR9gcHnwnCmDJZ0D2lYl27MeT
         +wMs5vCJbnT8uswkPSHZVe2HMdjUZvQHwnUAG1+WoqNmUSkICu3VYavVvIAjYPQwDRqc
         6MfzTa3siRb0jaGvfMO+OYAhd3OC/kX1c2x2A2Lrl1br3D4DKlCrY7BUdFwkENliETBW
         UHEuESMG5DVxHJdsQCLFvCr3LR/VMJr+0p6AenTheZ85ii4asIIt5yGW2La4YqwRO93G
         XtpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXDvL8KzjZU9A+yVzcWnkOaytEhgRJuqV9sQyhv99RpFNljoXPkJWCfIyxn9dIKrp9ziikb+isv+y13toAD08B@vger.kernel.org
X-Gm-Message-State: AOJu0YznkiAePuY4ndWrI4e3q8hUaMe20cMNTgrBiRgG68w2tbAzKC+s
	nftNEipjrHsOF1faHDZ8o2gTYHMnJrvzSRKtE4AkRK0ahTx6cBjURwPUjJBdtTNyGF0=
X-Gm-Gg: AR+sD10w9YBIyMCDMK0JlZs8M1IWXpOt16YBiXiG8ViEP+fUkPh9DqB7xwTMD63UYmP
	Py2eU5bH3tmutZeRhy8KDPp0eoQzuwDzPlps82pywagDB0UFC7yIi08oTbPO5qzwKLIAjNZTDgL
	BXac+XnwWuUOFVpb488FLBhT9hGsYK+riBoA2esDMA6a7T1TwC3hMySVFG9t02Xp9iyybhGyuXG
	bmlEol8myjkLCRbf6zi/WB9RhrpuMRr7EVe8IsFoGbS6uyULlaJnIFIm8SXxpRoNMu86i7glMdk
	Vx0cXoQCDx3ys2NXd4tYpk5Vj+4pcpKThTTSb9UMMK82b4Z7NS76Bk/C3UVAwaihALPCVTmYLfw
	qY8KZUy70dWr5KKboI1/YHscnR7B4aRASRa+TAQIM1YifK/TpTkZNPsg5t9Rc5ueyOpt9j6m50p
	dTrS8eqBKQTVsWPtQ7C0UtL6VZJQM/GPkIZ3e3h1imn4wsvU9INgAgGYQG0oDL9bwz
X-Received: by 2002:a05:600c:8595:b0:499:518d:ebd6 with SMTP id 5b1f17b1804b1-4997846c98fmr70953065e9.17.1786462245612;
        Tue, 11 Aug 2026 08:30:45 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 00/14] perf cs-etm: Per-thread mode fixes and snapshot wrap
 support
Date: Tue, 11 Aug 2026 16:30:03 +0100
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPw/e2oC/x3NQQrCMBCF4auUWTsQI23Bq4iLoZmYEZqUmViUk
 rsbXX5v8f4DjFXY4DocoLyLSckd59MAS6L8YJTQDd75yU1uxCetbLgYvnIsulKtHHBjxZqUKWC
 UN46OZ38hmqNj6E+bcp//ldu9O4nVop9ftLX2BR8T+p6EAAAA
X-Change-ID: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Fix a few issues with per-thread mode:
  - With TRBE, thread migrations hit a queue without a decoder assert
  - On nVHE, everything looks like guest trace instead of host
  - Tracing multiple threads didn't really work

After adding a tests for those, it turns out there were some snapshot
bugs not picked up by the other snapshot tests. That showed that the
different snapshot searches for Intel BTS and Arm SPE were inconsistent
and I think all tracers can benefit from using the same pointer fixup
logic, so that gets refactored into the common auxtrace.c. Then SPE can
just share the Intel BTS search as it was obviously copied from it
originally. IntelPT keeps the more advanced duplicate data search, but
in the future that could probably be made the common one and all tracers
would benefit from using it (except maybe BTS if it always has a very
small buffer, but I doubt the overhead of the duplicate search would be
an issue). For now this is more of a refactor rather than behavioral
change so don't do that yet.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (14):
      perf cs-etm: Fix nVHE per-thread decoding
      perf cs-etm: Warn for invalid timestamp option
      perf cs-etm: Turn on context packet timestamps in per-thread mode
      perf cs-etm: Use per-CPU queues for per-thread mode
      perf cs-etm: Increase default timestamp generation period
      perf auxtrace: Turn Intel BTS snapshot search into a generic one
      perf arm-spe: Use generic snapshot search
      perf auxtrace: intel-pt: Use new snapshot_has_wrapped callback
      perf cs-etm: Queue partial AUX records
      perf cs-etm: Don't print missing buffers in snapshot mode
      perf auxtrace: cs-etm: Capture wrapped snapshots
      perf test: Allow infinite named_thread loops
      perf test: Add test for per-thread mode
      perf cs-etm: Test multiple per-thread threads

 Documentation/userspace-api/perf_ring_buffer.rst   |   6 +-
 tools/perf/Documentation/perf-test.txt             |   2 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  30 ++++-
 tools/perf/arch/arm64/util/arm-spe.c               | 147 +--------------------
 tools/perf/arch/x86/util/intel-bts.c               | 115 +---------------
 tools/perf/arch/x86/util/intel-pt.c                |  58 +++-----
 .../perf/tests/shell/coresight/per-thread-multi.sh |  78 +++++++++++
 tools/perf/tests/shell/coresight/per-thread.sh     |  48 +++++++
 .../perf/tests/shell/coresight/raw_dump_stress.sh  |   5 -
 tools/perf/tests/workloads/named_threads.c         |   7 +-
 tools/perf/util/auxtrace.c                         | 136 +++++++++++++++++--
 tools/perf/util/auxtrace.h                         |  20 ++-
 tools/perf/util/cs-etm.c                           |  98 ++++++++++----
 13 files changed, 382 insertions(+), 368 deletions(-)
---
base-commit: bf10e6ee2ac3034c9068e03eed418fd16961984e
change-id: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e

Best regards,
--  
James Clark <james.clark@linaro.org>

