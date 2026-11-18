Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019402;
	b=LX7oAU2xgJk9iLG2qCvkmUStjscrjJ+NH/Pr/qf18gMCJEplpnYOGY047sq6bYERIChS
	 3kKwVzt+fPZlIcCwwpJoouo2OT6Te5ruHk2kA8b/20WKJuhEoP4ZhOEeWm/UQIGxoUA0J
	 JD1z0mj6ayeHPYXtt3/Ecg9dQXDt8lcb5eObAKKNTsFP0l6ebHO4ThLxfHtGS1M/GzStJ
	 OexMQBskTZeo9STyyAtmBBhxE3UJPaWeq8uKkx4C7E54zdAWSaOVkZFpGNW1Swp+5mXrQ
	 ZaYcjAwEimOSvRUlqnRhAbcIyfJ4+gvfh5GtzTHzkoDRZzr/1LfLx2yxnQp5+RiWaIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=p5DfdVn/AdFJR7mLtmlVcoQWNFblslFrL6J6esnTWlo=;
	b=ZbB9gzkxhDWs0ZwP+rdjIy7GDqoGLhaE2PTfdsSEoyvElrlhTQGGbwaB0AXGelQLOCJV
	 EQg2i2Hu58pv2Lnc/s8DKUyAv3K4hcCSsYa/mZAOKCTe/Y7QayTY32AqxIxT4quGL/m5k
	 suFIpzMb3c+Pq37zM4n2i5mQ2o2/wi3Sw1HnXbRzje56bF9m+rOGQEuq6BYZbXE6UkC/6
	 ZFCu5PbIMINNOHR0Vm11JLz/rYDqujmKMroHhO70wKgSyvXLJt89HG9Z/Mby0u+Uk5ITY
	 XBF8ZBrbX4bI8HowIeU2uno1oIAEq+fM7idX5EdDkcWnwNtMSUdHhmDawt7oYIrdmLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VKI5hi4n;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567560A2612
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E567560A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VKI5hi4n
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492690dd5daso986812f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019399; x=1795624199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p5DfdVn/AdFJR7mLtmlVcoQWNFblslFrL6J6esnTWlo=;
        b=VKI5hi4nz7p3XuhX/1nXGDRcdWLXuAbumCNBdhfUXkDtPB/VSli4GDAue29tszfjik
         +7T/HfbohFby4mDSI6V/XoI7DzVtP7+ww6h21Tn9Nr1WCQu7qn/lcaQzvcJVp5+CrZq7
         9YezunoX/FjV+u8y8CjpHG4Ts8Rhu9MNX5KpAWc/vjFCoFWvipqbKW5er+bDndgkCLF+
         dFulvXVMSBlIoaPfkNbswgf8ukOXtP+sTbmdzx1XmZSO5eEZME3ozzy1XvmF2fTn069p
         I0mpvyGe5ImvXddQd1XzTfb1eAJYVbL1QL9iLXCLKgRmUagNe2e0aB5sFq1fOMLa5acF
         m+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019399; x=1795624199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5DfdVn/AdFJR7mLtmlVcoQWNFblslFrL6J6esnTWlo=;
        b=zokpBJio54wuya2//O5nL0C+q51nYt6y5YrOlttXTDlK/5J6vriM3ucSH4dH01YHve
         DzObSnykraKo6WcZwYefQdRvAY7+sEO1pQOZ7FxhC2Sg2TgSaqcaXbdZOLU512YwXZkq
         Ocb8jU+usSBGAJZqPURMhVS2SUSZLo3Ld0HVAaWTcuTsuNuLmshX3v9MgEiSjR11pucf
         jw1YO9B7wiDgk3Hjko0Uwx7FhLP6L5T8xlo2GxssBWsFsATg0Jdu87FvZ7alBC9Wwcja
         7BJPhYJAt0otDKejEpgwy1kDes7ALijQf8PmhHq6irMXpvrOWrYcle49XgNMgTG94Qef
         IqUg==
X-Gm-Message-State: APuU4Z8H4+VbeE3OkO3GJpVt18ANH7IqO4AorU5dSbVwQEZJz278hPjw
	HM3bJqSA3XwfJ6hQp6Ix4WvriFHShxQhehS/5xgFlIp262I7A7gLFaQpbyuiFv2ZVrI=
X-Gm-Gg: AZFdTZf+lZEfvTc1RDWCurtRDMzUXPpBqEgDofjpTSNF3lhKlJyBe5nfy/yd54icLgN
	M3KMy85ptY0zYhiOVU+nvhYMDvAHtd3d30Wu0ILQmAKcg6qyHEFq2pbEbfNzd0JLbNPZRA/lhfF
	t8tfCp6lU9qlCGv+xQv/BPqgvY3ixGsM+uGSWeypxnJ6vjkvMxGGiVYYNb5dgo4vKTd9CaRL7mY
	G1UoGki0J2Na6TyKX8wbS4DZEsDpnbAg2pbw9KCOyR3lKF95zcsfzCW/MaMrGBMrKR/EVpAIFNt
	giIHrLyE9ZdUL0nCImXU65iWHzdV3vvKKTolNvW/Unsod9mTQUpMKxzKj6QlitdB1Hl3gXm+b/+
	HzHt15Mnknz29U1gYg+9sJyWE3DQoJmbNOBIc415DR62wl7/KVv2NTKHbikWyaJg/En6cGrK3Zs
	q+kbbiVd/CsnTNytOpLKcIYURS2mD+l2NWr/bFO+axHl5CHEo0jbT9Yh6pYonljryFkVoKkKJD4
	FZKI8MdzOaGWXQlBx536SCoMdoejT+zOZFC/T+ejG8LqhD4NXXbTOgNpJXHF6VMzVQv0wgAUJvH
	OUzcr1JbpAdmfSrM6uUAaJ1/jxaVJQsA
X-Received: by 2002:a05:6000:46c5:b0:48c:7f18:c85e with SMTP id ffacd0b85a97d-4a63b50cdfamr4894691f8f.45.1795019399370;
        Wed, 18 Nov 2026 08:29:59 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:58 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:33 +0000
Subject: [PATCH 11/34] perf cs-etm: Track threads in timeless mode
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-11-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Associating TIDs with PIDs is useful with and without timestamps. This
is an old assumption from when timeless == per-thread mode so remove it.

Update the comment to say exactly why this needs to be done and move it
to a single function so it's not repeated.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 53 +++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 11ebfdf1e933..67e3e2becd0f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2984,23 +2984,22 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 	return ret;
 }
 
-static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
-					union perf_event *event)
+static int cs_etm__associate_tid(struct cs_etm_auxtrace *etm, pid_t pid,
+				 pid_t tid)
 {
 	struct thread *th;
 
-	if (etm->timeless_decoding)
-		return 0;
-
 	/*
-	 * Add the tid/pid to the log so that we can get a match when we get a
-	 * contextID from the decoder. Only track for the host: only kernel
-	 * trace is supported for guests which wouldn't need pids so this should
-	 * be fine.
+	 * TIDs share their maps with their PID, but the association between the
+	 * two is only tracked by Perf on COMM, FORK and SAMPLE records.
+	 * Trace doesn't generate normal samples, and COMM and FORK may be
+	 * missed when attaching so pass the relationship using other record
+	 * types.
+	 *
+	 * Only track for the host: only kernel trace is supported for guests
+	 * which wouldn't need pids so this should be fine.
 	 */
-	th = machine__findnew_thread(&etm->session->machines.host,
-				     event->itrace_start.pid,
-				     event->itrace_start.tid);
+	th = machine__findnew_thread(&etm->session->machines.host, pid, tid);
 	if (!th)
 		return -ENOMEM;
 
@@ -3009,19 +3008,18 @@ static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
+					union perf_event *event)
+{
+	return cs_etm__associate_tid(etm, event->itrace_start.pid,
+				     event->itrace_start.tid);
+}
+
 static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
 					   union perf_event *event)
 {
-	struct thread *th;
 	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
 
-	/*
-	 * Context switch in per-thread mode are irrelevant since perf
-	 * will start/stop tracing as the process is scheduled.
-	 */
-	if (etm->timeless_decoding)
-		return 0;
-
 	/*
 	 * SWITCH_IN events carry the next process to be switched out while
 	 * SWITCH_OUT events carry the process to be switched in.  As such
@@ -3030,21 +3028,8 @@ static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
 	if (!out)
 		return 0;
 
-	/*
-	 * Add the tid/pid to the log so that we can get a match when we get a
-	 * contextID from the decoder. Only track for the host: only kernel
-	 * trace is supported for guests which wouldn't need pids so this should
-	 * be fine.
-	 */
-	th = machine__findnew_thread(&etm->session->machines.host,
-				     event->context_switch.next_prev_pid,
+	return cs_etm__associate_tid(etm, event->context_switch.next_prev_pid,
 				     event->context_switch.next_prev_tid);
-	if (!th)
-		return -ENOMEM;
-
-	thread__put(th);
-
-	return 0;
 }
 
 static int cs_etm__process_event(struct perf_session *session,

-- 
2.43.0

