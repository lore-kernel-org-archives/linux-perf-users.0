Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD0387374
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176389; cv=none; b=pFDPSzfNkEgR5C1YCM1SWxde1xF6IELSUJl82U7haNBJ1sVT+wRv6jR7qmwansPlfasufWaW7Qjm0MW+vDha4OKDIbdQU2CxcAT4bVoJoGyq02Hxh84lsHlRUPmIv7vpHAN92gm1GvfQlZdFkv6L1Ccmq0kAU5iznhwfRMlL7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176389; c=relaxed/simple;
	bh=0HOkidq/JgII6EOEBzjcyadgWl9Zn8UdVxiAfdkS3hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oY5tLLJKRSy2Qhq0SOFeCNfGmkywK+mQonQ4jJBbl6FqAwnRRF3oyB/SKU+Na3mGPpudFuqz8raUdmtxtVXH/JVnKb36LzeNbdV5IYhDGk+Nk6libsr3gkBTdA74YKUMYiiQsg2A2Y9hz1xTBoa/SF2Ak7GIZ/U9e3sAulG5VQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnnMfsvb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnnMfsvb"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85798977dcso6411125a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176386; x=1784781186; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDJIkBGbayFSIkGaw5ve84wjBBBADcohPC36m7XQyvw=;
        b=LnnMfsvbgztY8aWrg7/3DcrkkU296xOT/EALFsp+9STL0MvY92cecAvZ45gER4Enae
         /nJ4OvQvgs7v8NRcmc6a7Tms8u9+3iD7Fo6R3OXXWmCJn5GKVGQyVj/Rlkxgq8jV+xjp
         gr7TWdRS55uy2i7vSni42FaK/thXanMpDu5s8MvlUtsr0am3Sjs5Q2jjVe0HGSnsB8pV
         CMN7Sd8uWpJZkou8JY5raM1RoV5PH/7uq9xA6vVydvWgSpdnqi6o3dkdQSYEWuhBtk2J
         OIy0kPLm4q7zCvOqtxbooW0GAuVVAZtGTXPFoNRW6goI4CFsrYGA3XlqQx11zv6BRLQG
         pXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176386; x=1784781186;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDJIkBGbayFSIkGaw5ve84wjBBBADcohPC36m7XQyvw=;
        b=hPXofMBp79FDf+SVxxtKz/8IXGL9nkcWtfG/U8+Xx5nIabHXffDQkX85S81ie10fD5
         j0EvFL0Ehulpp+4HUGSFump+15nVrmTRnTTuwsY/w+xEDS/m/pe7FVz7nZEI2SmVxQtF
         fzk+f7h4HWdSxo/HDX7yHiPOvGaOi942ZbUMe0erxC7JKFtdPlEWvcftHZE3JqSrCV+i
         16Q7Duu5BHtwAPxZ+H6LWdD/04xWd9TNFXYrPFWh9JO0N2xUBZUBc6fVBE3IxuHjwydg
         ZOrI33yQbvvxCC1dST0oFPCK8wZe7P6FFTAg38FyGTzFuQdTbtOetVOBQJ9DhV/DqvTj
         LLPQ==
X-Forwarded-Encrypted: i=1; AHgh+RoY7HlrGUil9qK6HKdK6KDeoXPMSdZfii2VboeutQ5aqgrTHqLOy5bB8yY4YSBC/M+rM2VoKAYJGA4PHfQbB7me@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaHCXwQ5kTHINqs7cpi0hFaoh1XMrCVkO/J9g1b3FfHl4OKur
	17rNxTJCuHs++gMeRpW/LUhhXUTx0Vj3013bKNhRyWZikTMaDnFtOe2SKbSY0cCVXtwT02S8h2J
	BpFx6xPQcdA==
X-Received: from dlbsw11.prod.google.com ([2002:a05:7022:3a8b:b0:13b:9f1a:204])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6191:b0:3bf:9e25:1a0d
 with SMTP id adf61e73a8af0-3c36c3e7467mr5807966637.52.1784176386171; Wed, 15
 Jul 2026 21:33:06 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:14 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-6-irogers@google.com>
Subject: [PATCH v3 05/14] perf stat: Extend STD output linter to test advanced
 PMU checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run the
advanced hardware PMU and topology checks under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster

This ensures that standard console outputs are verified under advanced
topology-aware aggregation environments.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 8dee005a7281..0d38a1283967 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -131,6 +131,8 @@ then
 	check_per_core "STD (New API)" "$perf_cmd"
 	check_per_die "STD (New API)" "$perf_cmd"
 	check_per_socket "STD (New API)" "$perf_cmd"
+	check_per_cache_instance "STD (New API)" "$perf_cmd"
+	check_per_cluster "STD (New API)" "$perf_cmd"
 fi
 
 cleanup
-- 
2.55.0.141.g00534a21ce-goog

