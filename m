Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99C3E9C1C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539198; cv=none; b=EDXz53rGWYf3/naH7ynZvgWLuRejNQ3fyqEfTk5SqwvBTwpJpR/7Q8kXDQSy7T01ardrzbopHLo5YSBrpdBtsAquX03gr7k6cprux9KBefINys3edZA3T0RSLsJifkvVpPP7M3nKCtHhvxMSIQY3zCUThAD5oYZrZjckTLUCboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539198; c=relaxed/simple;
	bh=hNWirlQjs7zzyx6axdyrOn6luGlogerhrckrgySM31E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=u96z40zD5OK/3X7saCOCIQQmtw6pKLujahk7kvBHrpwGMNd2jisjbtifKmi9E5qtXQxkKPlM2vo10mUfTpuHglehVmcCDh4o8yHzoiBMscNSYYDDM65SZ8Tzi8Y0ymUZW/b2yACwFLNY8VvuKyt5c8Tu2jA4g7rU6GWLCxnmUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQ37ou04; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ37ou04"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc44d708055so8874382a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789539194; x=1790143994; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZtP2IcMlbfSjyfjMZ1e0vnZ72bPs3Qn3Gup/k917MuM=;
        b=aQ37ou04p1jA0Ce19hDvU5lR/jXsovQrVorpnaeDzKnbvHXXXaIibvDlLb41uyxuuW
         we4fKNcXUZVPmWj01ZsSOHqV7nbGSBs7nW7XahJ5m5CVcN+UVet/Vp3OqlV7LX99648U
         CZNBEnlWNn8w0TmudgF7f/Yna5tcCRbNJsyuQQnQpiylaqO//GgZAgLPYK2l4gMXLdSp
         TV8fG9t0+Yta5mpEqZOotTAwqxcFTAAJ7U1fj1XRF/kw52lYNiNcnQ+3hXAdp99Sm+tK
         v/e/nYxFvIRKIHYRFEzEDlCmn/0Pf1OKvYSt8bmMG33UeNz70UQZW6E2VMZtngCOu0lI
         rFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539194; x=1790143994;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtP2IcMlbfSjyfjMZ1e0vnZ72bPs3Qn3Gup/k917MuM=;
        b=yVTPf4CDZ9Sz6SEob+4K59kP7eQCeW0HU+/ZWGoiOR0HLHjWsArNruR4HywU7AUbwu
         OzX0rcvqouuB7ilARLUsaqWnCChP8f/6HZmlvom+JMgaemI5PjGNP5z2SmCEKEqRfSMc
         zu3bn4qYgmOWZso0Z0zmvlPmbwchtNNzV6DGxvrex5s+xsRCRdbIRR7ilGNZ+0fTF6WT
         lHz/7LhFopQ6Jb3uKUioly/ajBReRtq3UcgGMlYJ09lJghul1HnMv82SNHDQCUi7M1SA
         HQoS8lMDsk5ZaxujKjP7NH6Rz7k6b62Q573b01625/K26KTZLXQ6eIk4dmQk87zSt7S4
         omsQ==
X-Forwarded-Encrypted: i=1; AKwUvByNN6lIGP4jwqMwEgJOMBW5ucdA7vpQDUZAXzJ6OJ9PD4B1ClXWXznGfb9Awe112Gxs6xd+Rfic6XxZtc9Bj4/W@vger.kernel.org
X-Gm-Message-State: AFuF++kIy5O/6Mthyk4TYIl5tpwugueveFL5XrM/DN2J4ah5R2k6pg8U
	L1ynC201FmWprOTqUUYp8gtlNizgJa2sFTNheszzSN3Uc6fz+apJTKFvsrtjlM6VQMvMcnbE+7m
	l5qLJMxYHPA==
X-Received: from dlep8-n2.prod.google.com ([2002:a05:701b:4588:20b0:143:7f78:e839])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a1:b0:3da:f969:b077
 with SMTP id adf61e73a8af0-3dd5f495c5amr3407933637.11.1789539194276; Tue, 15
 Sep 2026 23:13:14 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:12:10 -0700
In-Reply-To: <20260916061218.3061216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916061218.3061216-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916061218.3061216-2-irogers@google.com>
Subject: [PATCH 1/9] perf libbfd: Fix the clang -Wthread-safety build failure
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

perf_bfd_lock() and perf_bfd_unlock() are the callbacks given to
bfd_thread_init(), so by design they acquire and release the lock on
libbfd's behalf and the lock state differs between entry and exit.
clang's thread safety analysis, which perf builds with as an error,
flags both:

  util/libbfd.c:56:1: error: mutex 'bfd_mutex' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  util/libbfd.c:60:2: error: releasing mutex 'bfd_mutex' that was not held [-Werror,-Wthread-safety-analysis]

Mark both functions NO_THREAD_SAFETY_ANALYSIS so that libbfd.c compiles
with "make CC=clang BUILD_NONDISTRO=1".

Fixes: b72b8132d8fd ("perf libbfd: Ensure libbfd is initialized prior to use")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/libbfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 33dc6158b2b1..8ac6670a39aa 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -39,13 +39,13 @@ struct a2l_data {
 	asymbol **syms;
 };
 
-static bool perf_bfd_lock(void *bfd_mutex)
+static bool perf_bfd_lock(void *bfd_mutex) NO_THREAD_SAFETY_ANALYSIS
 {
 	mutex_lock(bfd_mutex);
 	return true;
 }
 
-static bool perf_bfd_unlock(void *bfd_mutex)
+static bool perf_bfd_unlock(void *bfd_mutex) NO_THREAD_SAFETY_ANALYSIS
 {
 	mutex_unlock(bfd_mutex);
 	return true;
-- 
2.55.0.1032.g73a4cd73de-goog

