Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F833FD96D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422138; cv=none; b=XUBdFGA9d/obiucCZcG5deiJrX9KfbZ8xK9wTWuZU8qG6KULEmqGDlvWjPbXv5oIjkf5kC3gc77wrJdv50o5MJmy/0GpE++SJmxU1Y0sXzzyXINaDyIrLJnZMsjx+PlFd+7xV7SID4MoSs85cSgfOEgdT4+xlfdErUiXn5eCT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422138; c=relaxed/simple;
	bh=87PS40B4NZL0PtOGoeCrpk/fmdap/pixh4E8PlvHFXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVQkq+7waHix0sZKXtowC1K8HiHpDQTB0xdHG6VNEfjfryHvXjEebPtbtxAelS7JG5mZSSLizxwMtox7X15yosiOIF8SPSWw0onfaFZ1taQTl6Q2AQUf0IEsjXiDAe+K5FDY9S6zt3sjxm0tun5ufoJU3fwHScxyK/Ww6IItoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHOf5E5M; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHOf5E5M"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f1820babso5566911eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422137; x=1781026937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/cmFXth8qMRGDlK5Lq4KLyYHwWlJDRX8xEMkKeH0+0=;
        b=oHOf5E5Mjd23hCoW0oFQMKp11Rc6Klm/wSH5OAg3RsaHxzxRCg3ikC6+OVYFue7LiG
         79PLkI0lx5qUdOuMtaBLFPaC6lyDNlGqEtNceOOWzxqOpRUTeHlwKOaGzv6VdkqKzC4A
         BvHt/6JscRqlgBIrOSpxJOE+cMOvQWQitJ5sVEVU5AXNnc0ypj/NtLOjU/p0plaMh85Y
         F+IQootq8Rl3f9SSMAA/xDXSaLFJ/9PdvTYTf5HuAep4zHhhh6iHax65id6ded/P/DUL
         /VPri/PaYzBsyjdvA1dTC5bQ+COwvJHsYbeg9u7rNkM9SEfM0r06rFhxBZmiZRH+BSlq
         zDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422137; x=1781026937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/cmFXth8qMRGDlK5Lq4KLyYHwWlJDRX8xEMkKeH0+0=;
        b=DJS4RjfPhhLqXop/u908dVoaytklGEfk2tPZKOnpbOMeOlKl3PEpGli1jlj5pVMSyp
         CziUXHjzIG/eTxUvEyjF1jepmPLlp88qAhB1JMla8KhxNXopBDPtuiD5qkHB6m+nTT9a
         wKb+1LBHhe7HNKsmCqLIXO2P9GlS0uN9fq2omFy/eYM/NUXJNqz2Zc+SmQINI7ABn5qg
         iaL4cdN/NYJX5Sxg71mqax71gKQcMfAtmCaYvMB+NDI6oIP3cFyQwd1ajS2SkQJMqnye
         U83VJuuZ9Ch3bGrREZsPxKhhsIX+dDPN5lWpu/GWwBqQwD+R8A/uS488Zx8VeRc1xPC5
         zIvA==
X-Forwarded-Encrypted: i=1; AFNElJ8b2FWfPW5WgTxzW0JVR4mASZ3FBPC/mcOiokDAWHm3qBNcELVR8/MS5A9mShyxoPhMkd2PVorFYjr7YXhIupnX@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3TqJ2jDM4+NRAsDRs0D5FNaLRycLet7fYnKf0Yu/MYk1lPgL
	jvVYDzEyVcPqtx7WKfXDOCLA5srPP0X6r1rhLXs8tbg9KDeDvNhPwZ+o9HQDm6xDoOTUXjGsNsb
	WyFloBvbcew==
X-Received: from dybvi11.prod.google.com ([2002:a05:7301:530b:b0:2ed:d9c:cdae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:580b:b0:304:5a9c:6479
 with SMTP id 5a478bee46e88-304fa4ec8f6mr7835509eec.9.1780422136487; Tue, 02
 Jun 2026 10:42:16 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:22 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-12-irogers@google.com>
Subject: [PATCH v8 11/18] perf test: Fix subtest status alignment for
 multi-digit indexes
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
index 8883d4744057..4773000f3199 100644
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
2.54.0.1013.g208068f2d8-goog

