Received: from mail-wr2-f21.google.com (mail-wr2-f21.google.com [74.125.225.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31B3A0B38
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449509; cv=none; b=kuic2hcEBQqDfT6Knt3WQjZDu+BashmHZ34EHjwvrb4TMc1nDh+XA9Eye/eZGKsC9dZK+umlrdjQyMgpaJbVrAcvT1BMQPUzBRpBeAwQBlTP0fYk8/OT06pSKHl1C6CWfRZXXHwtSyYmtQ/jrH2+SXenikCERmwDCWZVtjU3pb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449509; c=relaxed/simple;
	bh=zlbW//0hdhYGgpt+5jn9RZCUwPsUfySvDtED+EIbmY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9o06Roh0vSoBnfK0dSH8cSdZLWH1BQ2fJRfS798x55eJaoM0I5h8dlPyvXg8/3TdRak/ukE3ksMzonQrfISRbC5MePi1ge/bw8I9WBDZ1NjYbnrgRnMPBXzzrbY6Yk9R8Hdz31Y02m17jM/hloEZO9vntPfiBCw63lLiQcFxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzc0CB1A; arc=none smtp.client-ip=74.125.225.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzc0CB1A"
Received: by mail-wr2-f21.google.com with SMTP id ffacd0b85a97d-48881a62e09so887062f8f.2
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449497; x=1791054297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qKRL8yuzKjUECxvVmxvJc06I62mK9jEC8gKnB5LQ/tc=;
        b=fzc0CB1AOSdun2ve+B53urvoK8Bq0ri7NKKo/KVfM9+A46zBxrvtCmsIyFj44V0dHS
         ftY7X3p+1eZ8xI8jqzmI1c3Bf7LGhFobSgYtVVB/kzuuIBEeQGUvRtHcwXEfZtlvZQnz
         AUOuhka4075QFurd0B0bxbWkvt4+KyyQFfyA4vIUBYmWO5fjz+11nLRWwQ/m/WUoaBMM
         j2JcPPRZuth6iy2/jy2N7WlDXzY3NsaIIcrkqr7B3oAs6k5RJgOznJqUqy96igU8etNU
         B0lUeDHwWOvrQU7mtzPIq3CU6vDmff0HjtWGi8xRRj4CnLGZ0j3btAgcJhcyyDJ+7O12
         7gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449497; x=1791054297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qKRL8yuzKjUECxvVmxvJc06I62mK9jEC8gKnB5LQ/tc=;
        b=HdyUmUxr6xlcUrQuvYsFRiDYsBNxTe3arJr9zQdkf94vpivQjjYELrPT2/6nJTkTMs
         OM6ylZTQWRavQphNvZxENSthuMDG6fff8bJ9opqfLK2Q8YHYH1MfOYpdFRzpcWVbNgfL
         bYq1r8aF88967UAhOXGEAPq+zEPo2eSzPot+5r4AHXlOgxmX+5Dyl0sSqqu/i1tuBK5/
         bjvN2cG/3fEFC3ojgFLQQaek639vMoobqHgRASPWVwnutsFuhlpeQaN6wB4nWzQby7et
         Vd2Gji5gv9pecIwIiNoiOp88JtkdfRGFDAJmTf/ema6uNQT9wsRHCovZoZp9f7749a1v
         XsrA==
X-Forwarded-Encrypted: i=1; AKwUvBz37PW82Tlxy+bnN+4R1MuuL5kwgfekEv+K1/3nEIsjILQiYT3mfgUxQtRMNbWQC3/MUD+8emvFKUvH1hB5DSZC@vger.kernel.org
X-Gm-Message-State: AFq9FYJdRZCz8cVa69zKVYTGaHAqRSUfd6ioUO8JCyhz2z1Vqf0vIw7b
	bhl/jiv5YfHOzm5jRoLV79G1Rw8q+qbzdmfY6Yv4W430DoYgAuWfPK9/
X-Gm-Gg: AYBFou0X0sjl00cnTxoEtKRqc+MTTAaUfcxzVp+bK1EaqOVsoCjz4wDePc4FUhNIbYH
	dHzcBpc1RwVHDOIQgBpcM17gEYIOU13lQ5iRz6PKsWp3VFhlq8PRKq8KcnCqsRroL2FqsmsxlvB
	ZQMz7N6ZrJAUdM+BbBX9ViWh2HwUt8VpkEltcZDNBVs+MDbIbJY3GlbPAhaac2vGB9mYmKHDJzq
	QqorhnDQN2XLDJmlnzH7iF+u6Kb7c9+UlAhuaQy8cKTd/8a3hMcdw4hVRmpy+CtyFkJMaODdWw3
	mV8xV6iluVqB9eRgFi4C1+vHCGGThh7aTQ5BE+gk6HxMsE5IzgXRHKt08HWRsCOQkI1qeIpYPYK
	yQKdwds+MJNiVcHr6gsMUb8UGJVtgpvSdoda946v51c0xN49hjQn/zpJjL9dXVZiS7iQ7/fnVjd
	Ol9+XBlly/TTVMf+czqifTxrGdR64i1AY+Kv06knheiWlYydPLB5cyCeH2ATVWGlNU792PIyEkh
	QjDwjgIjcN8wD8mQOAbCJgLYTi9d9hrz13UFCppMlSmKEuN/k1hRTjiEopp/TQlhaZqyMizuKGk
	dfDsw0tBXC4vbpK/VC2+OuZHiZTwQlrjGaPZGKfxkAwaKRclPHE=
X-Received: by 2002:a05:6000:4024:b0:488:8904:913a with SMTP id ffacd0b85a97d-48889049589mr4517899f8f.8.1790449497523;
        Sat, 26 Sep 2026 12:04:57 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:57 -0700 (PDT)
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
Subject: [PATCH 7/8] perf bench futex: Clean up two nits in futex hash
Date: Sat, 26 Sep 2026 20:04:06 +0100
Message-ID: <20260926190407.1106421-8-michalpl2003@gmail.com>
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

The worker's check for an unexpected futex_wait() result tests
'errno != EAGAIN || errno != EWOULDBLOCK', which only works because the
two are equal, so use '&&' instead.

The CPU map is reference counted, so release it with perf_cpu_map__put()
instead of free().

Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/bench/futex-hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index e18d98664d27..6f4af1a52d1b 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -95,7 +95,7 @@ static void *workerfn(void *arg)
 			 */
 			ret = futex_wait(&w->futex[i], 1234, NULL, futex_flag);
 			if (!params.silent &&
-			    (!ret || errno != EAGAIN || errno != EWOULDBLOCK))
+			    (!ret || (errno != EAGAIN && errno != EWOULDBLOCK)))
 				warn("Non-expected futex return call");
 		}
 	}  while (!done);
@@ -256,7 +256,7 @@ int bench_futex_hash(int argc, const char **argv)
 	print_summary();
 
 	free(worker);
-	free(cpu);
+	perf_cpu_map__put(cpu);
 	return ret;
 errmem:
 	err(EXIT_FAILURE, "calloc");
-- 
2.43.0

