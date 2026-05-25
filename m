Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F7361DA9
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751158; cv=none; b=XQbMFvt0DNPHDTTCyfnFGrkCjz6WoGajFYXMxmvkxws6545y0IclF9rMA3dvN5sIrNsvuXrlvVAsboUd/ashYmKxyIg9efOXJcisNbJosj319ECKMYT0vo3/EuCYWSY0XifDDpZYhG+DJ0q/k/NSvpR10+43t/Gbqvk+SpLEvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751158; c=relaxed/simple;
	bh=pz9wWtvci81x+rjdPA5mZR7lSPuDfpOtPEnhMowVHkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uqpNo5ToGeNXaAuCeGx9TpsF7h7k9HUIzo0XJExR2nkQCcns/3HEyjIMUWbo6MZOB7db90F5yeIVCD1E98MjwM0wtDMmHmemgMu99PzrShcXj1SpS/y3uLffn9sGRLEqbx7120E0rXnTvpuv6gpPSWx1DsTEAzu+faaXooExgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEGtqDbA; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEGtqDbA"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fded513994so369023eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751156; x=1780355956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkb+vzit+Cca2HE4wAYWYNlzyApLVwRmfy32ufnqmWg=;
        b=uEGtqDbANPOGEwlPjOQyJTPsHVDqLQYKsW5bELrJYASsTNXUO2/IKiTG8wSwi5UEu9
         wPGurg+zwvgjjqph6M9LYjKmS7to3koIjymUfmzqPS9blUH7MOv/roush2YCgKGPSCrH
         V4Nu+k4DGSdNOeDSTQ33RWykJ+J1GZQM9gnDJznOrcOLxQzbIHyjg4+9vGJOq9Sf7n75
         64OK/hHiDNPn8OPaVcgWPlMaup8S1SvqOekGAr9HtwCeN+e0h04BrLWZCvS+ohulsD58
         2DWlXqHnq6yNl5nYPcCpfgQg//Ukym4rEJKiU5gCN4zKrwT5XqgdmCD5iRn49OquRvzl
         p8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751156; x=1780355956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkb+vzit+Cca2HE4wAYWYNlzyApLVwRmfy32ufnqmWg=;
        b=YXKUa1yHtq5M3tl9v48UHNd5JFnKEYeM4uLeNh4oPMWzS+1Qz5+XjSU9ftmbVSN8wI
         4BX7R9XDhlzNxCjUkTW92G52QN0WV6taaVkpt640QO3/VmRAgmHepqoZMNK72l8htUJB
         DTkO/O8gI6q9bbfb7XJIkxRP6MJuTO2gbxJs0IQWt+7EsRLodiKa5oklSeV5wvbYS7H+
         m50dhjCKk95hn9XHUMo3afrhLurSOX5oh55PEgmw3BmSx45/sDfxfzFwQODJvvTPULo+
         b/WIeNz2taP4mol5P9HPK+Yg5WX7JFomdo8nMrOq1Q4YgP9u19TpnoFj4jwXvFH5plNJ
         hFww==
X-Forwarded-Encrypted: i=1; AFNElJ8x1YIoz/JGVg6UUbNW7xOylZEGk8auFaBtTh+4a0nNiOeKGLu8O91Fax++wgVvMZV1JjqiOqxW2r+H5qoRHSNz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zcaParBdGL4xJaBFDg+BMQDBIS5KHnOpRF9/BT+NKVoCgPgP
	WLC2no45JH4AYVu5ItFcF4oGvlm4re1LbdHqKdcMP1gZLH9ZvuXvOylnqcsqwhhGH4w1LyCSRda
	b4cVT56LgCQ==
X-Received: from dyem10.prod.google.com ([2002:a05:7300:818a:b0:2f7:767f:edba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ef89:b0:2be:142f:d499
 with SMTP id 5a478bee46e88-30449148a1fmr7685930eec.16.1779751156198; Mon, 25
 May 2026 16:19:16 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:49 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-4-irogers@google.com>
Subject: [RFC PATCH v2 03/14] perf stat: Extend STD output linter to test
 basic New API checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends the standard console (STD) output linter script
tools/perf/tests/shell/stat+std_output.sh to run the basic no-argument
check a second time using the --new print flag:

  perf_cmd="--new -o ${stat_output}"
  check_no_args "STD (New API)" "$perf_cmd"

This ensures that standard console outputs produced by the decoupled
printing callbacks are formally validated by the test suite.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 9c4b92ecf448..233e0a50eb33 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -118,5 +118,9 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# New API basic checks
+perf_cmd="--new -o ${stat_output}"
+check_no_args "STD (New API)" "$perf_cmd"
+
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

