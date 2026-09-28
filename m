Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E07386C3E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619980; cv=none; b=UKM+3RgmO+BEc9fsjewIgGS/e9Vr23TctdQkE3Y691WfrBQs2Ivn0Gn3maJci3zQ7xN5hVGEO1NDXPdqTlxADD45RR8VF6G8sRzc5D0nio+7zkCtQomjawvA387ganM/9q8zNlYGpAg5gPtj1zS9dHLQDqcb8BKnhd2giKWG1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619980; c=relaxed/simple;
	bh=U+ay24blVG9yYe12Lp8/RlWiXT/kxx+qAdGQnWtqZ90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BReE+UOrAby1A7GmiUpHME763M0Je9lzUtXwS1Pc/lKASmcCrgBu/BYTYJ8RG6xby+Tit4OZtGVq/eWGI9gwAtFdOETSsgjhjRXyxjPiXgarRKxUCVdJdK18hWlwo+XKAKMHrjK91N8f9BIn23v9AUHF0FhRi/LxUe3enmaVdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAui2gXM; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAui2gXM"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-142f4306744so9202413c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619978; x=1791224778; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxwI32SEUHME+PizWajiM1My8y4jC30CJwqCNyqs/2o=;
        b=lAui2gXMhpDWAkN9nFDYqGPC89qeqnk6RqeSVgTJY1x1XI0KirmzpdifwSef6C9jKj
         3dKjqpXr05MLg5EQN1OxL9GYtI14ycEkaAi0vW8kXVahj5uItL2Q34HlrZ7HSWYVYkFn
         tQQIZxolhD5v3gSPMWezy1Y9CqqXDaN3b3zEzk9xQ+c8UR5i+tPyicldRDWwwKJyEZyx
         zG4g5ZA3+ud9VrqLXmLmqbvT/kdSPjqjmJGl90qi+yYNvUu3zPW0VJGZ6Ctm4NwwBDBJ
         9+aiNLjH0FHh8AZ9IRnuoOuGBAfltRUxRdkvDi+KPeKwWC1nsNH2pu7M+zqblp7r4lc4
         EOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619978; x=1791224778;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yxwI32SEUHME+PizWajiM1My8y4jC30CJwqCNyqs/2o=;
        b=JHZfHLY6JDa2M3m8b26maxBTi0N70YIcm3jkmon8V+qn1/uKSyygqBp54NS03y83vu
         wFc21OGOqdIyhSCvhmgdpOOtvwQLJLJU5POaN0yuDfcoMOdXyl9a+8QT1UGXhZrcU76m
         pLqlWwow45Q0camPvIpblF9JCLHYQWx5S5BNYek0s+ImlNoNDI/FJjQQgqM4ogxE2vSK
         ymvIpKdQaPGjzt6d86Z601M9nCUZQ+NpTrZlaI6CuvTM8fWUNw5j5gia1zjJ4MvK2te7
         DEu9v/SdAj+KIV3CoMSqT5V2MQxsIVXPeHiXPVjAqxkxDSIIgykihx5nXebhmaABmPOt
         6DQg==
X-Forwarded-Encrypted: i=1; AKwUvBx06XJxrPlEINfWtTpXy3viACPSjJx2k/S2DSQAMWiOVg2gMmI73XjH/Lr79BkXqEbJQalGZnWfg6+D1ybSjiJi@vger.kernel.org
X-Gm-Message-State: AFuF++nPRdNIpw0tGVZei8DpUmgA4lLlqLrkRVkxEeMQ6qUoG6w9HBQZ
	/LNUQcKrKWtlyCfMeSYDcEexStFfoIYfz7P2CJqRCsG5ioTLk38ZW8yhHh5klKDFi80Z2+NtZ0T
	Rm5aeyWtm7A==
X-Received: from dlev28.prod.google.com ([2002:a05:701b:465c:b0:143:9704:de05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:420f:20b0:13b:3c84:ef77
 with SMTP id a92af1059eb24-146ced41605mr11965715c88.20.1790619977567; Mon, 28
 Sep 2026 11:26:17 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:41 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-3-irogers@google.com>
Subject: [PATCH v6 02/26] perf trace: Include the augmented arg header in
 nanosleep's payload length
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Unlike the other augmenters, sys_enter_nanosleep() leaves the struct
augmented_arg size and err fields out of the record length, so the
output stops 8 bytes short of the end of the timespec payload. Count
the header.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index f7c9eb49648f..cc70861a23d6 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -419,7 +419,8 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *req_arg = (const void *)args->args[0];
-	unsigned int len = sizeof(augmented_args->args);
+	/* the size + err in all 'augmented_arg' structs */
+	unsigned int len = sizeof(u64) + sizeof(augmented_args->args);
 	__u32 size = sizeof(struct timespec64);
 	int err;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

