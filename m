Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61792305677
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751163; cv=none; b=IvdksR/Dm5i7l5FfgXsCfF7lxvA9VBLG+f48CrWZJon629etN7EhDGLAuFRd5WWo2aqgDPyRzm/ZyU5lwQfvewzpVKkV+BaYPb/0WYRumaWyQvSGG7ZZyAXym+O7UqdhqOhtnrAjtv0OXcr7MarapHeHDShPeSdlXHMmmlotru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751163; c=relaxed/simple;
	bh=U80gcFi4WzNGNIta+dVGhXSOXfz5DYs1o+sarzUoYQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fOvrl+gdTlu/De6sHPiUQIwqouv3GOQ/inBHEZcvOxPMb898hoBwStfNiALeHWq9snx+1Na8tJTC0OvHSu2EwXo9UVOKanuQdGvlEmGzyJOb3yS3n+/auYrv1GsFKe4QOCfGlAEdFMeGkMULvmh2b3cPFZHxBj595/vkw7OvEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eszFliYQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eszFliYQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1370417c0bfso510933c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751161; x=1780355961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDxe37y4tS4oHNnjFdOdFfV5ZDDklsO1V/H5cjSQvn4=;
        b=eszFliYQib+/XsItFNeDbHlXSGBZxEeJMNMBrph9OKbf8DqyPcQA1O2xu7fiatvniX
         PkJM2l64DjOSLvUCLdDG++pLa2cVhzuXgN4wEqlyvYJTBjvlen24URj7rtFH1HmCZ0OZ
         f5zvJJCC2uNtl/tOm87Spszo7o0DUymWcucdNqrt7LCik4iSdzEXES04IDaRi/ilr294
         BdLGMfHdNfwEMx2+ZHcc1lswIygwPq6+h2eHWer8zxhz21nmgntLrHcqU6c/FhY6ilyH
         OHl9EM4YtphP4QWpZmrKkpkqrhzU0+OVyHgaR0VANz0MjKdd2Je2h1j/AC5MbHP6XTTQ
         nPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751161; x=1780355961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDxe37y4tS4oHNnjFdOdFfV5ZDDklsO1V/H5cjSQvn4=;
        b=i8V9MkqZCYBVECIC2v+LxTF4y+1trCSMA+n4A9zW6xIwM9ntjrp045FrzsVZ6dw+Bn
         Nq1wCO2Y75x2iF6VslRaKHWsUt49jnUBHlp65nq9Lv73ymQIrIfKqD0AJIGhB87uJSXQ
         R/UGCrUSLb9XJ47dc1PK03sttC6SzLbcl3F66c8V8yumcL9EGHrzlxcKB4W28rRrff1T
         JXtvlsBxokJmoaEV+281Tf1nvrJIsbaMReV65NIe6YWUK078jbmFOhZ6mxPH+J55GjL3
         kpDo9aV+5f7SxdcfwNdUCxCmfIxjBRHk09ro0I7x5f0SBaehSoggTEFYk9G8/ogRoRGE
         C/ng==
X-Forwarded-Encrypted: i=1; AFNElJ+nCi84VNKPYLW/7STvUxVFGnGb3SrQSnTXT9CHJAoSxZKnKyrln+PZkUMpa762F39i8o/BPN9YNZbBRh/sYgQ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yycc7AaPXKTJVB/b2Vq+uraMB9tC8g6xEwRmM/UtWqWEPTnrwgP
	PjlhviODYpjdu4xv/cONxSVMcVB5Dq9M8xe1nQHlrN5HHMeaCn9mNoY9ySJLK31wfXHvA4CAmDA
	x9CGFzctoUg==
X-Received: from dlcip7.prod.google.com ([2002:a05:7023:c087:b0:136:9e6c:868b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ed06:b0:135:40b2:ede0
 with SMTP id a92af1059eb24-13633b6ccbcmr4108255c88.6.1779751161128; Mon, 25
 May 2026 16:19:21 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:51 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-6-irogers@google.com>
Subject: [RFC PATCH v2 05/14] perf stat: Extend STD output linter to test
 advanced PMU checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run
the advanced hardware PMU and topology checks under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster

This ensures that standard console outputs are verified under advanced
topology-aware aggregation environments.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
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
2.54.0.794.g4f17f83d09-goog

