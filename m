Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5138E8C1
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185418; cv=none; b=pj06/MjJ1/4tGMScSeQjcFa3UbkqrRvL5RvLXaLHdDwaGjY4fAKpU7QNuJ16pLWLM5LC1hjlDOJg9DzJ4vB+tsximhpAhDtdNANU2Zs0HL8hJheHejqMJzouKMMROITmN3G6mdMJ1Jn8OBawXZ+43vn2ISOuojp9vX3EScBkKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185418; c=relaxed/simple;
	bh=n3k27QJCIoNJRzPm7J40vLj7crVqdwZ1mpVk2AWukf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vhg24dIUPYkGq54Wwa74Ales2TPRPlWYAXLC6MDm/myR7ioQ8/noYc6dKZY0FmcOLZyjf4bjKHH81fN3tB8Pb9LjaHuuEJEyUEVsWqHeRN0FrOGPj6OA8sqXpb+oln8yS8QegcdGsBYfxR4Hxyn8NiLwIt9zAcvDbS5lc9et8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkYWu/nO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkYWu/nO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so4675162a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185415; x=1784790215; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6g1rpDOHm8pAfjUBaAbALxk3paqpS889TKdqZf1z3UQ=;
        b=IkYWu/nOtqMbD4V149BiasG3D2HMEoL5Lz518I7dX6SVBEMzDjBQlFpdE6Qi+BADQ+
         booKWgPyPqqRTvDkteopKaeHcYlmh0Ol/V3kjCwTlOc+MTDHVkkUWcueB5MA3XQLJaDO
         H4dM1V8AHo18ONo5MXfAns+ODVdQyING3c0Dh+GL/tLQohHJgHVelLCWoKqxG8f+wnNp
         MNn3sGq4f1W7mvc0CuW8/6Y3r8F/gUAZu8nmmC5q/v82VMVy6tAiOoGYPJfAToS+jaoy
         ryeCCR2YQMY5dh85WdI0pDF3C9G3nutSCryZVun5KM359BYlrY59fR0YCFsJb0XU+gnd
         RMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185415; x=1784790215;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6g1rpDOHm8pAfjUBaAbALxk3paqpS889TKdqZf1z3UQ=;
        b=kHxmIWRs8ALQkNWUgHwLZhzsbNJWViC1DO9Auqigq/JI5s1vG2IZm2dIsJ/cOKNYT+
         J2Q0XpHmvEJ1ARYPW1BvfpinZH9sS41KYg32r7fjnW/ZjYPlnUk7huYOrEbeXvbiuU0n
         jSYMpS47soXxFboSyVbwYlKYsR4+LFLy8LovqwvCcyCsgDPHXWP8y8PtiuTFSFdDUUAh
         LOcjmbu5TCmkklNdbxFbVSC0zADwjUQMJtlGvLw6TfG5+1zvjssKFUxxSzpIDih7KIt/
         YdjCj6ZX2Daw8nLymiU3///SzKq+BcqLuP4EltBtfDVL6MRLRqFvU5ZzwIwQK8Mu/JhO
         sUFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAf0N1Uuxg0Nc6fXSugdC3M2Owz++nRFrbKn7NwkpjawZTDayzsAMI0fxhSa4YNof9yXDLoXUy72mLRUj9gJMu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdx3t6A/lcJ/AsHEFobfrEQ/0YKBGqYka6O+7VD8OzErJe//Jb
	vfxvzneap/XOREyTyY1/smjFxhrd7np9xaVP54OtbOwMMvW0lrLZwktxmkQvSb8RJhCHkbS+2Vs
	t2dgF3w8hXQ==
X-Received: from dlbpv1.prod.google.com ([2002:a05:7023:901:b0:138:62a:280c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:495:b0:3c0:9c1b:d0b5
 with SMTP id adf61e73a8af0-3c1109f44ebmr22649357637.64.1784185415273; Thu, 16
 Jul 2026 00:03:35 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:03:01 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-13-irogers@google.com>
Subject: [PATCH v4 12/14] perf stat: Extend JSON output linter to test
 advanced PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+json_output.sh to run the
advanced hardware PMU, topology-aware aggregation, and metric-only JSON
checks a second time under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster
  - check_metric_only

This guarantees that JSON outputs produced by the decoupled streaming
printing callbacks are verified and structurally valid under advanced
topology-aware modes and metric-only JSON row-column layouts.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+json_output.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 8168b861ade7..d18cac5dcff1 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -249,7 +249,10 @@ then
 	check_per_core
 	check_per_die
 	check_per_socket
+	check_per_cache_instance
+	check_per_cluster
 fi
+check_metric_only
 
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

