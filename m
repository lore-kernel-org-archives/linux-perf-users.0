Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA7381AEF
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215789; cv=none; b=d188EuMrUYKRnfWIUGUUXksheIEd+MOSVGoFo2Cnye2ttzQPgYY+DCvMuTfJqNNYOvfHhktubcAXBAFD2iXkMn3Fteni58UiGwDBkcHAbU5o3N9WQOPuwQzRym6jVlXNT8PnizxLrMh0xH2Z8HBNiV++YM9rE4oC9aASpQ5WXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215789; c=relaxed/simple;
	bh=v+uQb482xCIMi9HmoWUGu58IjoDszSuB2IlHYCHiaSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rx3D+Y5P6eUrZwsqlJtfAYC+BtwwEFJEj9n+tMW0/lRU2PieaCfqqRxLNihMlDMmVbdMJwfCd5eFN+285zapcmXGrQnqhBzSYoClPnBxE2gk2GsO0IX0NyXzRCuB4Fv0cIK3slT+mxf7+EhCwJhyxdB7if8PwM6FGroe6W7vZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CR4M/5So; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CR4M/5So"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304df51ff3eso3113484eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215787; x=1780820587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oWF0bxxyu3W0maVW6LzGoakYua7rlvwmHaeizM/uC8=;
        b=CR4M/5SoILThJdNb3MApLjEzBblVxIKslyj47ShwTRjPcm4GRVcHBZBFVQ0y6R05c1
         jKCqOVNtmNk3n4O+5I4jkiNQS9QfCNCRfuDrc/RsX5MAoy+YYD0lQ1yrJhat1HnQ37E1
         HWbstQC+l0524gQM88/IblGfcymJCBoXbPgG/9WpkstqLu27QNGvzbPOYel7jPdxZUDs
         ufFUucotCtcbBQIgim0Xmvn0DOKTdAHGaZrih1RkhhVVjIetBS3CUZC3M/fJxx5cNUiY
         kzA5We9q2zdd8ptL/rfowonwDIMIBiD+/zZU6El60rzIxbOzFSINeK3M62GLgnR/G31T
         bIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215787; x=1780820587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oWF0bxxyu3W0maVW6LzGoakYua7rlvwmHaeizM/uC8=;
        b=D051+HGhfV5dNuZi3/Rq38HZDOHTGxi6W1Gto65oB+DDhaSsCqwJzxjSXUBw7l9ZXG
         WHg9NOlfW+fIU4N4oDBCYq1B5o4U19B5JD0Htkb7rS3ETJUip/WF1oRl7LsKqqpqwFAF
         OdD6ia+B64WDPywcqnVDyHybtWEIVP4Di+Z/qWG6iIWpHjCrPBEWYiJ8C3IGb9hi7cad
         wgaSneBQIk3o+LYDD+jWQtk7BapXb1oUXpLMqaSm45zwz67TNOf40sO9OceJ6xjBn5GC
         ec08PTrBezOdaYJkOMIGZ/bavpH17BZ1awL0nWJXTkmVkOiXV8TldLYZqr5JT7T7C8CA
         NYJA==
X-Forwarded-Encrypted: i=1; AFNElJ+RpCQeDg9lbK+mMCBDgEIHhSRkScPKyjYrwGKw7QVL1D5KQddYKZUBLQrklbmB8beBNjEvxFhgd0uAfNJEp1SS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27s0r3PFm390EpZZiowiegce+vHln5CLJ0aVPw7OnGlToTmkd
	UV9rqB0/WvIHL0iacJdX5IZ/SPBkw56adcAfZvtRhiEEzEP8t/lh3+5P4xZ9+dWykgmstRjkT6Q
	P7hkMHIOFng==
X-Received: from dycoz10.prod.google.com ([2002:a05:7301:fc8a:b0:2df:46bf:2390])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c0e:b0:304:7a67:6104
 with SMTP id 5a478bee46e88-304fa4c8570mr2837817eec.7.1780215786668; Sun, 31
 May 2026 01:23:06 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:30 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-11-irogers@google.com>
Subject: [PATCH v4 10/15] perf test: Fix subtest status alignment for
 multi-digit indexes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running perf test, the status column (: Ok) became misaligned when
subtest indexes reached 2 or 3 digits (e.g. 9.100 vs 9.9 vs 10.1). This
occurred because the subtest description field width (subw) was statically
fixed to width - 2, assuming all subtest index prefixes were exactly 7
characters wide.

Dynamically calculate subw based on the exact character length of the test
suite and subtest index prefix. This ensures the status column is perfectly
aligned vertically across all test outputs regardless of subtest index digit
count.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 336d24105c9f..4c0caa8d0b27 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -373,10 +373,12 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			     int result, int width, int running)
 {
 	if (test_suite__num_test_cases(t) > 1) {
-		int subw = width > 2 ? width - 2 : width;
+		char prefix[32];
+		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
+				   curr_suite + 1, curr_test_case + 1);
+		int subw = len >= 4 ? width + 4 - len : width;
 
-		pr_info("%3d.%1d: %-*s:", curr_suite + 1, curr_test_case + 1, subw,
-			test_description(t, curr_test_case));
+		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
 	} else
 		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

