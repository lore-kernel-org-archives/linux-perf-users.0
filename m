Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E934AF9D5;
	Tue, 15 Sep 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487351; cv=none; b=D0ptgsFi/pR5AjBFRg/DHvW85MVVwppDafyQu1cdI2Afvds/BKvD7zI4VLJFcsTz+fzvSNMXg8f7AS5YwIiwlp8feCOZDTDI8k26s3Npg1+NdRRCwoWEPd1LvYFsp161HLgvrFuekfBFaeyfbs4fk6dNoywLCS/9HI6L3bMF83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487351; c=relaxed/simple;
	bh=B0UpuY1UdwYGmq+lypGwMC9Rr8VbjvbhGjJOTbTkvgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OlfcqfjIHTTdtnEn9wc6/O3B4nqKRPNqWeoKeJfLW2tUcAZhFdFVegCwvtq9vf/7oi1ht+lW1B6EE1p7sDDwLKoT0/G5086Sq+TCBf+3wLe+XvMTM7NbrNLrDjfC9ewe9LwUAMtzmLG0XGdLG+8DReFpO4aIJ38Ya8BfSzuRLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y2m8tbMy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y2m8tbMy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F9EB1BF3;
	Tue, 15 Sep 2026 08:49:05 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 881773F882;
	Tue, 15 Sep 2026 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487348; bh=B0UpuY1UdwYGmq+lypGwMC9Rr8VbjvbhGjJOTbTkvgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y2m8tbMyFKI7i6DtKAsBVajowPHcKU+EhCiHmbR02SdpzMuaksIa6cija/04cTuRW
	 BFjZbXoTp5F0Y+v6Jl2HV5YeotzxXmhpa1aQLTzIxhpRyVFhuREeB1FRmSd4LjTVFu
	 3a6HYrVb7e1QnyArLClsly+KB45I/tPvnTMlDeAg=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:48 +0100
Subject: [PATCH 02/25] perf/core: Prevent AUX sampling from racing with
 pause/resume
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-2-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=2358;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=B0UpuY1UdwYGmq+lypGwMC9Rr8VbjvbhGjJOTbTkvgg=;
 b=WfTg/03reVi5kRMDM9V0J2d7OosG9mo6fY4Ts2KQmsi56+F2MvdU4wqtAP9rcPyGIxN0oMUz6
 Fsb+2AOOzf9DzQKRfzEKZ6w7GWnVXSlJRYYruCMouVKZ6rOLWk9nmAx
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

AUX snapshot sampling and AUX pause/resume can both run from NMI
context. Each path currently guards only against its own recursion.
An NMI can therefore enter one path while the other is changing the
AUX hardware or buffer state, allowing snapshot_aux() and the PMU
pause/resume callbacks to overlap.

Use aux_in_sampling and aux_in_pause_resume as a shared exclusion
scheme. If sampling nests inside pause/resume, emit the regular sample
without an AUX payload. If pause/resume nests inside AUX sampling, drop
the AUX action, matching the existing behavior for recursive
pause/resume.

This prevents overlapping PMU operations without waiting in NMI
context.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 17355e4b8b7c6c106117153c9eb8509e6f9a41e3..a524eb381d4b5731650ec0105d9794b8c89fba4d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7990,10 +7990,12 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 		goto out;
 
 	/*
-	 * If this is an NMI hit inside sampling code, don't take
-	 * the sample. See also perf_aux_sample_output().
+	 * If this is an NMI hit inside AUX sampling or pause/resume, don't
+	 * include AUX data in the sample. See also perf_aux_sample_output()
+	 * and perf_event_aux_pause().
 	 */
-	if (READ_ONCE(rb->aux_in_sampling)) {
+	if (READ_ONCE(rb->aux_in_sampling) ||
+	    READ_ONCE(rb->aux_in_pause_resume)) {
 		data->aux_size = 0;
 	} else {
 		size = min_t(size_t, size, perf_aux_size(rb));
@@ -8869,10 +8871,13 @@ static void perf_event_aux_pause(struct perf_event *event, bool pause)
 
 	scoped_guard (irqsave) {
 		/*
-		 * Guard against self-recursion here. Another event could trip
-		 * this same from NMI context.
+		 * Guard against self-recursion and AUX sampling. Another event
+		 * could trigger either path from NMI context, in which case the
+		 * AUX action is dropped instead of waiting for the preempted
+		 * context.
 		 */
-		if (READ_ONCE(rb->aux_in_pause_resume))
+		if (READ_ONCE(rb->aux_in_pause_resume) ||
+		    READ_ONCE(rb->aux_in_sampling))
 			break;
 
 		WRITE_ONCE(rb->aux_in_pause_resume, 1);

-- 
2.34.1

