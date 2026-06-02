Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC33ABDA5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385528; cv=none; b=oRbICa+oIvyJ+QW9k05DqYs3bDZmqjLuuxDvRdKXbaDehLlN6Si+DcN1AHXyraj2AL8D3GfmckQXMT/Z3UTYWusuVP1zh5Yr+zbuLgstebzwVyaBqBMji0YyjOkr+4gwMFT4ejLznw6gH8rblsdpgxVd06hSaiZ0/QGm8jScH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385528; c=relaxed/simple;
	bh=lkZjuQfapU/7rQCDqcTy+kcBh+0vHyjvzR7VJqhjEBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RxRLb/b8LUM6ap+6uCLKCrUwe4AA4VpIBtWABDIjMa3Y/qCrOdLkHIhwdKrRGbYhBaUpSTtIuAx1fJ4X3V4g0c8MOrA7rKsTd6JVm/xQQCZpqMN2SCdf8363qvFjzeHIHtBnJlV0WqB3zhwsSpdSpa15b70tqVwyVgIa5imLStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTcRltQy; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTcRltQy"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135fe34cb98so673529c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385522; x=1780990322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0s4ZMEM0Y1byVlQvSdV4cQcn8spi48hn9wCUoI5QRmQ=;
        b=mTcRltQyrh+7++zmlLVvnUBmnO8PavdxbbWakd9W0Nb/IhklRKzxziargqAG2GrZ4z
         DailMU6Ck3o6VnfqRsCmrZYZfMZGvtcCTcXE4x2tXfFVgqCMwgmepmQ5+bokdGt0pbgq
         JWQDC+AzV2OxjSPle+bQ/Z3ZM2Xsl2lhes2LkwPVh/bLuP7ki/11NmvaNrQtuH6UrtN+
         3rqohAaus7JE6R/bpt0MbBJ6ENVnZCLDJGySD/O2iJWE7uy7/ZVJq54cOzfPQQ/h/Zhx
         M/uXWtSY0Q/TzRO0Pdt1H7CAKRjS02Xx3LVlXSCO7hPiFrfYSwGGy2CSMTDUT0oEuypH
         a/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385522; x=1780990322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s4ZMEM0Y1byVlQvSdV4cQcn8spi48hn9wCUoI5QRmQ=;
        b=J1/sYmozxwFJWYWMf1704pQrXScLajGyQTWApxF5VFAp0Nc9zsUSmee6M9lhSXf23y
         NW+oAo3o5B20KPVIUcjifXTcBzSd0GllU4o+GBlwJ4JEYMmJuqV9CdpyR0UuhGGFyBI5
         SDVBnMFPJ4BvltRmOK52qBMc5uoA9g69uerDjN86RnoySkmmI5eboqBdt4MTyxN7V7dj
         wC7OMn4/b5pcDve87zQs35RRrzemoRB61HGSqlhUjQM08KtKHxEZLudiN3+in65zvZQb
         MBVrbGUyRQwk011sLum/jMerq5Gj4ElQx/ayip3aZPg+HbxNhtvc+vxlLJUXmmBVHX3w
         QCng==
X-Forwarded-Encrypted: i=1; AFNElJ9t7cg58CIQi/ymUnbfWRdXShn07ejt8r2N2rRPlAO+5/VWjuynP6TAzosVjTy1TIzGyHXV/ElKVoWOF6UWNP4J@vger.kernel.org
X-Gm-Message-State: AOJu0YzLj4fAUK02GRcMep9j9HeTmX5mV4IQ/U/IYWBwWGQCBiKd5Mby
	FmvvFuEJwS30IaEyf859NjTWSMZAzPuyKhO0pszKq8CkmDkBrCZbWNfwkPhtBn/gZGgyY3zqyvS
	OUqUZ1xF7Mg==
X-Received: from dlbvg16.prod.google.com ([2002:a05:7022:7f10:b0:137:ed01:78c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:527:b0:135:a6a:fcb9
 with SMTP id a92af1059eb24-137d424acecmr6305837c88.28.1780385522003; Tue, 02
 Jun 2026 00:32:02 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:26 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-12-irogers@google.com>
Subject: [PATCH v7] perf test: Fix subtest status alignment for multi-digit indexes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running perf test, the status column (: Ok) became misaligned when
subtest indexes reached 2 or 3 digits (e.g. 9.100 vs 9.9 vs 10.1). This
occurred because the subtest description field width (subw) was
statically fixed to width - 2, assuming all subtest index prefixes were
exactly 7 characters wide.

Dynamically calculate subw based on the exact character length of the
test suite and subtest index prefix. This ensures the status column is
perfectly aligned vertically across all test outputs regardless of
subtest index digit count.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index f6bb876a271d..486f563ec04f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -376,10 +376,12 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
2.54.0.929.g9b7fa37559-goog

