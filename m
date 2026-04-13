Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232AB386C22
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053579; cv=none; b=M02M7XL6yjSbghHUSkMSkq5/XSdcMHHIYKEsqSlzrMK3B4KrzfHlkJB4aoHWHSj4VFkbNhcJ6eiAgGbYf7jt5BXzowqVLfbrEei18z6RVyVKbF8VxuOcZ45aKIT+3xMC8qHhn427JKZSdHIYxHMPM/Y9Rwm4QRp8Udyok7ZQN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053579; c=relaxed/simple;
	bh=+R1TjR7D/n+SVy+MvcOVgKHmNVERa5SqQsXwquU4Gqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwWwI0yw3FD+H3npnyflLuU+Lh3x5iPEcMNphPn+hX4amv5SDgpl6v1NXMIyjN0Mu0nh8bUECKQUjsECj/1hSHMTtYy0QZ0s1cvos8b0THujyko/vKhSfuEPLwxZlKAmbocmjc1RJHl9hn6g216eDRjb15cS7S8eeNSHY+MutrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F66PbyzS; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F66PbyzS"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c33bacfb7so292873c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053572; x=1776658372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6cwCi85nL+UMzH5dHBjsjgh7zFGt951FXHMXIOHqdc=;
        b=F66PbyzSBcBOto9yA7GjdkP0zKpD1B2GAutHydknyV94UQRiWOAA1s6d2xgEUVDuxP
         01bNFvxR2Za0KTJjZHF2aGfUQO3TDeYzshn/nUQ51e/XSoV9HR3eLVSZf4bkC8wcEq6N
         M74+iwPtjo9QMtq0ZPm4r2AUPqGYMH9XCouDvwtIIfCHA3bHPqV4aQ4uPpLdRR+um3ec
         QctDbV1cblG3SddfvJkadDhDXU2qQEjzcBsTPOvLLSJMnaZNo2QlTbAUXmwt0mBFycIj
         8/x7nDAbGvWnT4kRVRWNa20b3k6BJD/jaD0NIby599PcqVNWoZhYzBmaE+IiXWp9/HNc
         eyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053572; x=1776658372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6cwCi85nL+UMzH5dHBjsjgh7zFGt951FXHMXIOHqdc=;
        b=D4qkSDywJwwyGVtE/HImyQRR7Tke73t9aR64J4gBXO29hpu1Ok7vaIxh2SxvC8wGmM
         SqttBkY8FANz7kWJ9kcuh77zYiKb5gDr3jjFlQd6cBkasGgEbTmA/sxMvQCfeb5VR5l0
         l76jzx4CjqWoih3evpjqrqpaZw6P/nWB/cLTUbwmrW+wYMkZYedHeIVoW5NKrkrS9mP9
         nYehJLy7S75Vd8yjSUcZ3OQR7Spp+vlYZY9M75GkuPn3Wna26KFDgd5nDai8v08xjuxy
         E+r1LshsQgeQbpL8fsCIxUGUMVEqIv14oC+KtUlpFrO9bxEtm1ptnsVO2COcTWafUR4k
         +eTA==
X-Forwarded-Encrypted: i=1; AJvYcCXAZrPV/5+Ca4WOXug8ToUMHBd7/b0Anaixi6fo9CvyzifvF1le4J0t4SVQgtrZczP0TQfR4EIcWdg3vchdOkDr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W7HgSmoRv5OmJGbiBemQI4zvuZuBrIFm/CtFaCq0GEga68f6
	I8rKTi5DpvL3gNPMSWydzpSPRPnxRYAUVBEm0L9JzJcmjiXSHK83ByT2IfUUEBbBPo/OjmvETkP
	MpRbRn1TwxQ==
X-Received: from dlzz6.prod.google.com ([2002:a05:7022:486:b0:12a:ad8d:be18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec07:b0:128:d4db:4478
 with SMTP id a92af1059eb24-12c34efaa0emr6474927c88.24.1776053571712; Sun, 12
 Apr 2026 21:12:51 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:34 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-25-irogers@google.com>
Subject: [PATCH v12 24/33] perf lock: Avoid segv if event is missing a callchain
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Sashiko recognized a potential segv if a sample is missing a
callchain. Return NULL for this case just as a memory allocation
failure does. In the verbose pr_debug output describe the error and
rather than fail the entire file just skip the event (return 0 rather
than -ENOMEM).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 89a40d385b27..064b3aa4bad7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -938,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	u64 i;
 	int c;
 
+	if (!sample->callchain) {
+		pr_debug("Sample unexpectedly missing callchain\n");
+		return NULL;
+	}
+
 	callstack = calloc(max_stack, sizeof(*callstack));
-	if (callstack == NULL)
+	if (callstack == NULL) {
+		pr_debug("Failed to allocate callstack\n");
 		return NULL;
+	}
 
 	for (i = 0, c = 0; i < sample->callchain->nr && c < max_stack; i++) {
 		u64 ip = sample->callchain->ips[i];
@@ -1059,7 +1066,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 	if (needs_callstack()) {
 		u64 *callstack = get_callstack(sample, max_stack_depth);
 		if (callstack == NULL)
-			return -ENOMEM;
+			return 0;
 
 		if (!match_callstack_filter(machine, callstack, max_stack_depth)) {
 			free(callstack);
-- 
2.53.0.1213.gd9a14994de-goog

