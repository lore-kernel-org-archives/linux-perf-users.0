Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784E3911A8
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449499; cv=none; b=doNiIQTdeezUHhb4jWzC2gEKc1i+Orhol4kvCTxOigkPBVevVR9RggQ0Mjb9+yRSn/qoaxcSvwVfthJBf3RrYO+0zCNSfe9X5UVBT6RwFe7bjysbr46BK2Q2Ijoc4k44uVXAdYXjiPWHW3h31x4EUM8Tm+ikNqB2mlY3AztEjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449499; c=relaxed/simple;
	bh=L4A1fxJ3tPV9/tI/nDKPZdkFGHaPTKrChsaQcyn0hoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4qQS3Z9Lm4SV/EPFAmZFl175emQ+eGQ1EQuSj7CCZsQD/3l6EE0PvqG7ckuRHCPsUCsYl7oRYa2AVlfnkxD1cPEEzt/TIetN4HNtOnlS1U4rvMExOFf6Bs7xtO6dvyjCtdnT02dleisMImdbGquBpDdtKptYfqlIPOXoaUj9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jos7U4qJ; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jos7U4qJ"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f6cf16bso1045830f8f.0
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449496; x=1791054296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2mvFNOm4Ish0nzna8egVnRJE6+xNsqM+lxsIY+3qhg=;
        b=jos7U4qJenlDP/AFKbQy3WjIh0PDu5cHjHphO2EKoxxCAgwDdSWXg+hJzR/YNKP+Ra
         Rma5lBpFSJIZJK8BqWeo00sISi2p2iiRQMXrhr72YmJWYRRiQRrwbOc4CeMYZwKYbuUG
         8ivey3H0Isc/ZRIZ7RNCq/mJikrnVjvAfJFfzmYGKsIIITLnd/WMcDpf08/dnlqBzAu3
         TL14AYTktqqp83DhAZnwgnhH6TTbrercQKUEsdSodk04ToO6EUUcJD1H72CdqvS+FN/F
         wYdMz7dtL0/z9ijyxumrVEmIkiwzps01QIhgmFslok73BFyst0mufoMlAeUYrWlpNGGY
         BUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449496; x=1791054296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2mvFNOm4Ish0nzna8egVnRJE6+xNsqM+lxsIY+3qhg=;
        b=JyFdWmcRdACDtyVf5FrG+bAJ5V8+7pcPjhQu9fVHrn/x0DjDhj05a42AYpMEYsHhXL
         tEyGfN8NNAP4IihAusQ4UlX1PMjnE/YeCuE+xJvEFfV+du5j3GVcyR4DndWoJbi1Edgw
         8o7hEi2kZ+tyljvTyMSHZUSGdLQVYJLfDRKB1v6GaFYows2t369kyVp5xdOfk4zNtQu2
         yNSfJ4HG+3UAC198iVTDtOC7QyzZXL9nIhBwscQIA/+QzHyCEaKCyG1y6a2AHNtJQ8S/
         hBVP//eGBNIs7RaO+LoZXkpH9sQ91qaU0qhEwM4qaWCTwajU8bTC+wpklzJ3wnj7YyPA
         dEIg==
X-Forwarded-Encrypted: i=1; AKwUvBzl/Fl4VbysY7HroVr9GnLuaJNMatcAfUAu+w0vWpoA7Wly5eZT42lBjSBci9GkWhmQ+HkOfClOPlMs4r6Lx20I@vger.kernel.org
X-Gm-Message-State: AFq9FYJnls+/9FSbP91PhovOp8WjyjC/xOGw7rt1zZy8XXN5Frj2eZnJ
	8TD6EUyUt+viImxkRSUr8oGurAmLcYcsNOOjm2jdcI9VpL1/aCZIZyim
X-Gm-Gg: AYBFou3VlT1F2Nkq80kgoVlL9mCgabDuQSCyPuF0Zeoss0fgSiAcjZ4Np1esU2Nnv8h
	Rh9L669GwAMNubuxonGexFvabdqj1Haqhjtm5SIAIXpg4SvjBeTeGZ5A7CiyZbux0PYtOI96V9p
	nhToUaKGTLlGdbs9UqsUDsr03KrI04SvjkkdSVozqkmtluNBl9vREzbp/Buin3OrrVuupBq2hoK
	x0sINvl9Dxoxj3K8o0SmmADKcAMyRHv/sXQED0OPauJtDLqsjRmYoBbs7pz277hKAkFt/YxvRuk
	euuzHnXKUUw02AOTR5Uhq8wtovd4gwQSiBEjjr/mXqmFVqETeH1IVfEpvpMOYB1/nvAgnQ5g757
	zVVqWV4chtT2uNVY98Zt9VfL2H18KOIkSkFqhilxbXjSMFWVhzSSH0T1VoKwyHZKmWyOQ7ThRXj
	Nq7nyHN7w/xlYi1x9U8y3nkWuhmGQf2ahpsYcZfH3cewDjY/sCjD+Rly7NCnkDYNdAnek4tSSTm
	wA4ptpwXjn72qKXrg+R1lRmvyVVlCLGQf3UVFAPFFIDygHGhFHfAIKQL93EwnujVQbjyHBBsDBD
	1L7yGOqgP4xAMnx9S0WMs+8fl0A6a+RjjKudqPGhQfsxSSB2K8I=
X-Received: by 2002:a05:6000:70b:b0:484:3317:a19 with SMTP id ffacd0b85a97d-4887db2d084mr9402512f8f.26.1790449495804;
        Sat, 26 Sep 2026 12:04:55 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:55 -0700 (PDT)
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
Subject: [PATCH 5/8] perf bench futex: Stop when futex_wake() fails in futex wake
Date: Sat, 26 Sep 2026 20:04:04 +0100
Message-ID: <20260926190407.1106421-6-michalpl2003@gmail.com>
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

If futex_wake() fails, 'futex wake' adds -1 to its unsigned counter of
woken threads and retries forever. Exit with an error instead, as
'futex requeue' already does.

Fixes: 27db78307481 ("perf bench: Add futex-wake microbenchmark")
Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/bench/futex-wake.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 12a75be077a0..7674622639ca 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -207,9 +207,14 @@ int bench_futex_wake(int argc, const char **argv)
 
 		/* Ok, all threads are patiently blocked, start waking folks up */
 		gettimeofday(&start, NULL);
-		while (nwoken != params.nthreads)
-			nwoken += futex_wake(&futex1,
-					     params.nwakes, futex_flag);
+		while (nwoken != params.nthreads) {
+			int r = futex_wake(&futex1, params.nwakes, futex_flag);
+
+			if (r < 0)
+				err(EXIT_FAILURE, "couldn't wakeup from %p", &futex1);
+
+			nwoken += r;
+		}
 		gettimeofday(&end, NULL);
 		timersub(&end, &start, &runtime);
 		runtime_us = (u64)runtime.tv_sec * USEC_PER_SEC + runtime.tv_usec;
-- 
2.43.0

