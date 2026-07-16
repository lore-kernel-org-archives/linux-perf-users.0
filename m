Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5830274D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185402; cv=none; b=Fd9bbSh+ZtWVkTeyVobN2hIw/iwRCVONj4KDDA09kLkOrbqPWH/FJ0czU6iulchqifRiB2Mpg3pJpShShgmhQ6BJx9RpqErzCaSMGSup0c7ycuKn93hyHbLrFkb0Nz/CF1YPITZjU1l7wV1JfzzSAw22IbtBhstGG/dPmcax1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185402; c=relaxed/simple;
	bh=xnmKULBKjWn9ZNLB4yxCMsCYrpFYptWPY1nrp9Rer6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/PPmq1QmcxRG6iJcDpiGeF0buiCM0qBtCuDJQlERR74irt5F1GnC8I1wEZhSkC0ntEu/oL5mXVDGxJYFpp/ISk7J90m2D2JlPSIUTIeW1Vp2wST711IRk5jFTXNRFaP4ToSMbq/dB2roLhMWywMSFttmrng0LN8J+MJNOtruuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPX0d16a; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPX0d16a"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so9456425a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185400; x=1784790200; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rspboKk0H9Ay4WrfHqJFg1sxsAtnF7cVYDfdtCVodfw=;
        b=EPX0d16a3K/OcGcer/7ZV6PdfmVbU+z4ay/x5lWPIXqCWaPM2kR71jvFf3HVe9sSrN
         nQTz/XccrwGYQCWn76I8uhpyV2H3StfHMu8Oam7Y7/4dG8zjpGZks+IdDByMV2WirIyD
         ycFH1IeuZB6dlALpSy41wH4M4RebaDNECd+vGGIsIYpoteuWZUI4ODiPeLLLiru8DByO
         9wXvq6K36aBGhm7c1yli4u2DnQPEG8RAix45YVs6r/mTth0Fij8dDpZNVvpTQcamZ688
         BnP8y20IL4XErGV7XLZA38ExGsfWpvYB5iHdkIkYzHn8ddw6wG4EkIVcpS7aAjiOfvCV
         jOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185400; x=1784790200;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rspboKk0H9Ay4WrfHqJFg1sxsAtnF7cVYDfdtCVodfw=;
        b=nFOpAaiU7Jht7tgqqWmCcojPppPhQ7gnJCI5S/w8kzdM5fUP6oeN2EFKfr+wUIa/dk
         R0tQ5G9JIH8rbJO0F01tFe9pyDpcmOMDTUjMLGFDZjThvKCpGp3nV3UDkjI5vdD/Y9jz
         pRROps0R8KQnymghCI4sCEIwdTDyvn1FRW7ie7mj14kIeXNOtISuT7pUNcu3udQfDi2b
         BtUEArrtXFNBKFPR1Cpgli+Ob71lauwZTWjRMi34lRmj5hdZqfO8KyiqZNmXAuyHDXdp
         iAWnFwRTFKKk8GqpEqqDuDPFW4URHVeYZIsAbdv0yShr18dwch1UjQxHCGLo9bteAzzz
         DB7w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6yeiQtE3A3snq1NB+d3sn5c6oD5jppkIwMHZegBQGnY22paQoNsn+UFA3o6ipbM1vDXgKdtoYt6gMzVpe/emN@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmaFJYfYUMI55SnRXDFEwpBDV0ZF4CWcL7tcR2//uNsIu7EMZ
	epCfB/7bWl2yxdQNCXn+EoV2++5U/OaFS27kOTv+DxJJwGlvNLmh/IItmxN9mUew5cKbK30GtZH
	/1pCOSFvj2w==
X-Received: from dlb30.prod.google.com ([2002:a05:7022:61e:b0:139:a938:eeee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a41:b0:3c3:875d:704d
 with SMTP id adf61e73a8af0-3c3875d81e1mr2641509637.25.1784185400126; Thu, 16
 Jul 2026 00:03:20 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:53 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-5-irogers@google.com>
Subject: [PATCH v4 04/14] perf stat: Extend STD output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run all
standard CPU and thread aggregation checks under the --new print flag:

  - check_system_wide
  - check_system_wide_no_aggr
  - check_interval
  - check_per_thread
  - check_per_node
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that standard console outputs produced by the decoupled
printing engine are verified across all core CPU-aggregation modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 233e0a50eb33..8dee005a7281 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -121,6 +121,17 @@ fi
 # New API basic checks
 perf_cmd="--new -o ${stat_output}"
 check_no_args "STD (New API)" "$perf_cmd"
+check_system_wide "STD (New API)" "$perf_cmd"
+check_interval "STD (New API)" "$perf_cmd"
+check_per_thread "STD (New API)" "$perf_cmd"
+check_per_node "STD (New API)" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "STD (New API)" "$perf_cmd"
+	check_per_core "STD (New API)" "$perf_cmd"
+	check_per_die "STD (New API)" "$perf_cmd"
+	check_per_socket "STD (New API)" "$perf_cmd"
+fi
 
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

