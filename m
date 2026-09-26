Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ECC3403EF
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449495; cv=none; b=szLNFfT67y0kw9qJ73ByyeYY3UINt7r26eKFtPFBGaiJ5f+CMonSlLfvDqCJgn12DwIWKNUUiPqRdogS1ck2QtLPYARLX7pYRlDM6SF0vlebgWW2vAz1rBB7MypPCkR8GvVIgVZCG6w9lFgR28HL6G1dDpxqkwhDRVOwC3xOwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449495; c=relaxed/simple;
	bh=qlYBWl56ohuk0vukwzDlkJr5+/McJUKq456eH5NMYLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8L4tS3SUj/gH7zAwBqSII9oLFRXSF1WYdG1u/LnUI+Q7sAWIbUyh7MrlXGxyio9EAzane3P6CDp7XHOM6vL2k0WrXpb6HSg27fJzHCFjbLxaKsosp1q8QRXx9GvZ3ycy1mQCRJm0UMJ0SeY5D4xbSyK4vXuL/LzHLqCOiw9yrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImEFymGO; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImEFymGO"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso1430912f8f.0
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449492; x=1791054292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A05tAdwDhEFU7wzDQtZ8/k6Sz16JkQZpTUFUrH3gMTc=;
        b=ImEFymGOhwkaudkXFfPMNYB5R94PWNx9hSisSrtikOeurC7vyVAb5b43ErDrcot3XZ
         00+v3rsigEKV8ZvJ7LOXg1RsnzLL1xMmo7TsTdh6hk3sh+yahNRIp79q5KkFPTIB7+Wc
         8ZSdER9lVgXoXaZBPEKlntPQtDOlf7vU0gypzjwUQkJz0ORcM0VbHBO8WeJ31L58oGTm
         4nZbzVs0skx3rdsinPJdeJzohYexhlHdQ1xhQMCcdnhRx9JV6bx7Yrh+cw1x+89Ad5vb
         uRMHOrYHXYVoMesFaM5ls0jO4yGa6LglJV21aiHuNIy+GEHTzHovMRyF8Clc2Tvp8oee
         q3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449492; x=1791054292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A05tAdwDhEFU7wzDQtZ8/k6Sz16JkQZpTUFUrH3gMTc=;
        b=m/bwTkvaiqWRmuHJRfxG0S0wjCTjim5B48qzjtHMX/hLqltSi9aXbb8ZDEpyGgMi3g
         i1LbDCMllmWur0H9v6SNo6hWtb2WxZHbgX4bnoxtPiK5GHOjrPW2pha4C5k+m/KgtZcs
         8IxvTtfQf/p2gHqfmRZGtKPMn7v/JCY1V2fdAiecgu3EmE+BShhn0Mt2rfdeglSySwVy
         z+6m2srj4m4iPKUQHHFlXRU66ERRKs1sdYSkybgRJw1HayzUl3HTM4ELpoMHqShAq3cV
         DbWPt/Lsv5IaaTji26FmHq0nxWjaa3NHuyZ4jpH+VGs2GB1JXHvxc6oiZjO2PL0v7jOJ
         vTLg==
X-Forwarded-Encrypted: i=1; AKwUvBxwXhSAXl0BzQQ5fEVgTgYJKVMA/3TbdbhZhItd4+yPMFLutVp4XTonPkrLCPoJsB4+ey8NuLUGHn9lVyKVlelS@vger.kernel.org
X-Gm-Message-State: AFq9FYKhq6Qi1+AddHWeUB4UWD43N+oNb4v2DWhwcsORAxAkJ53Jm5lV
	IDoWwmY3CPA2VRXdoKEXqUr8Kfxou4B4lKyRtwgNyXb09Swqc4OuZNoB
X-Gm-Gg: AYBFou0GUhMw0B1GasH4T01kwyu2aMuKvnNpOmBOtYdtTOC37SEjzGGUi7Wh3FrFMjL
	2cRmRfv7WCQd/RJURFLwTQCiG6majfADGCy67155Y9EEpaMo6SsvVjRQeLWigzo8XI9Kqn5FKmv
	If60f0/UvS5S/XsAj7/P7Rp00FRuMmhE700vDzDNRNwkjo6BqShPp/z+8khhHikDKJQjaa4Y5ZW
	wTiqkBeOffsreL5uOJKB4Xn5NAsGI8MnPj59rUTCNmEm+V2pu75Q39+v7uxEg4cWwNyt3w1lK3q
	Ee5IR7FyhxSHEXg1TdkvXW7z6HgAYEdIs2RzZlI1Crp4nxajZfxZTY8ZKHKzgqN+ZXwfqgROGLI
	gH8UMGixP+K7C3YIOIuikTNytluDlpatixPp4ZlYOg9g7mIm0nldQu4CYQnAQ4Loyg7GKz0Y+q6
	mMoSAIwmyTFhoTa6vEVU1Bt+Ntm+5VuVKWiMHzinzXzkB6uRj7JEB2sdy5ggO0NzX7Dp4aeNHjD
	dhshTuc/qmpag+xWXvbmQQ6TmdknA6gjSA0Tu3M24XizP2W3EnsNsRWLQXWm1X1eACgvU+HzIKM
	/uUmsZ5hsr3oH2YtU+fvxamsOrNNp9E7XWnCzP39JsXsvWCLejReTv2NDzdaFg==
X-Received: by 2002:a05:6000:3105:b0:488:8192:c768 with SMTP id ffacd0b85a97d-4888192c8f5mr9454342f8f.30.1790449491985;
        Sat, 26 Sep 2026 12:04:51 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:51 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/8] perf bench futex: Retry futex_wait() when interrupted by a signal
Date: Sat, 26 Sep 2026 20:04:00 +0100
Message-ID: <20260926190407.1106421-2-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926190407.1106421-1-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The worker threads in 'futex wake' and 'futex wake-parallel' are meant
to go back to sleep when a signal interrupts futex_wait(), but the check
never works. futex_wait() returns -1 and sets errno, so comparing its
return value with EINTR is always true and the loop ends at the first
interruption.

The worker then exits without having been woken. 'futex wake' keeps
calling futex_wake() forever, because the number of woken threads never
reaches the total, while 'futex wake-parallel' finishes but shows the
wrong number of threads.

Check errno instead.

Fixes: 598adc5c9c1c ("perf bench futex: Handle spurious wakeups")
Fixes: d65817b4e707 ("perf bench futex: Support parallel waker threads")
Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/bench/futex-wake-parallel.c | 7 +++----
 tools/perf/bench/futex-wake.c          | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 6aede7c46b33..a089d8ee4b02 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -139,10 +139,9 @@ static void *blocked_workerfn(void *arg __maybe_unused)
 	cond_wait(&thread_worker, &thread_lock);
 	mutex_unlock(&thread_lock);
 
-	while (1) { /* handle spurious wakeups */
-		if (futex_wait(&futex, 0, NULL, futex_flag) != EINTR)
-			break;
-	}
+	/* Retry if the wait was interrupted by a signal. */
+	while (futex_wait(&futex, 0, NULL, futex_flag) == -1 && errno == EINTR)
+		;
 
 	pthread_exit(NULL);
 	return NULL;
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index a31fc1563862..66d30ca91405 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -75,10 +75,9 @@ static void *workerfn(void *arg __maybe_unused)
 	cond_wait(&thread_worker, &thread_lock);
 	mutex_unlock(&thread_lock);
 
-	while (1) {
-		if (futex_wait(&futex1, 0, NULL, futex_flag) != EINTR)
-			break;
-	}
+	/* Retry if the wait was interrupted by a signal. */
+	while (futex_wait(&futex1, 0, NULL, futex_flag) == -1 && errno == EINTR)
+		;
 
 	pthread_exit(NULL);
 	return NULL;
-- 
2.43.0

