Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B7466B6E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582132; cv=none; b=qGsvUl9GOF4Nii00vDSPRdsA7C2SfkpMTznTA3Vm3AL75d3UNk+ZAdfSro76ohYnky47RO2JN2HYDHc7qLHeK0fBFKm9dQWNHJWMwkHgl5mBH8zncAE2CUzZ5mpjXd2ltWxYavu10jP5IHVg3kf/yxoSnMXJz2ihxRqDYqk5VFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582132; c=relaxed/simple;
	bh=IYfBliEovmHApazL8W4A9U9SKaT+AFtbRztssz+EIkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Z7P0YKaHa048g/Dcup8Sh6hKD9WL8ELOlAA1278ZNkjnEC/jL/kx0fKeVyhhMJ2RPXtuVvoFwfFP1cTga1CQaZPfb5/bkGPv+CdA8KaBKzIAS3AchUbSzgwwulFKn2mwe3xvq2XU3oS1WeaJSXX6GPJcKA/7+2bpcCHaUNpLRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA2ZXtoK; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA2ZXtoK"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1384427c3efso4125306c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790582129; x=1791186929; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zZjBVF/akum3LA4mMtKqOcvN3zY8xllmEp9ZKrvY4Zk=;
        b=XA2ZXtoK41JhflEDF/J08Q1rEPeZDGMYhpoPuNoHDbByY931i/d/4jFIu1Yn80Zx9r
         osJzd1MYKstIneAz1pPBL1UBgeRxAYpjXNAXzZ4Ef3W0mWmTEAci8/WCvF1GHf/eLGQi
         4EQHhS0bzUZCYwvy5K/jdaN65hFfvs7jdwL8QltRkLqMz1HLj854yFPaakENlCyGpQSm
         FsRuSXAp1IEBcPXItCZgi/MtnTqSXE8luZH5EJ0O0wDlJ+Mrl0O7OtNy7JUbljq7tbo0
         eujgNnJ+WR15nmgDZm7mvcWF1jOc3H6SNWOEG02ytDkY5RLvh5VF7gINbijoLOPVbh/7
         UZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790582129; x=1791186929;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZjBVF/akum3LA4mMtKqOcvN3zY8xllmEp9ZKrvY4Zk=;
        b=UnxDEGux4Vr9E2D5Nob/DlWzzbsBqVjmfAiZslJZ0Ki1hLXwgglah9Oj3j8WC9H4IP
         2ByMJtf4iVILqMJlGvuYiTri+SHxFTySNVqdiCsFyRDf3Dp+GApZXEGLfWW+YV4A0qxX
         YkwCwOKtDhJNjsCW4kMtmXyGEA9iQQMDSPy5ndv37RMSfJkAVmf01qPaHr3DR1sVVmLu
         YTAd/B6N+O8L/I+YyiyRa2bJPgsYFsCapvFguygdaryUBz81pp+99jxnLSXXpzwKI0rI
         PB3RdP+TH2sfZn/fPRSIPUcWxbIqAcwuEGvZjdgSwm/J59eqaf4eHaq9+FUI79ZifPDo
         3+Iw==
X-Forwarded-Encrypted: i=1; AKwUvByPL38FXhFBdMS/0cQAYjPwQ+AOMunDMnbpE6AT9n9TFpIa0EOqonyCrt7tMsksZqGNkU2+OZz5GlZB0gCpvOMh@vger.kernel.org
X-Gm-Message-State: AFuF++l9pN/cJS8sO+lePhc9Q87me3fmuA61w8dH3b/e66mmFx30L+oA
	j6TVFB8QDpSrJLBtSDx0cnrT11bOI4l4PRzgr4s1M5CShSZR3bvtUfLIrJSrChZiAgwBbWvtajp
	k6UyyAA3cdA==
X-Received: from dlbuj9.prod.google.com ([2002:a05:7022:3d89:b0:144:d1d0:a66])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:280c:b0:144:eac6:cf37
 with SMTP id a92af1059eb24-146d0c50cccmr7772008c88.47.1790582129192; Mon, 28
 Sep 2026 00:55:29 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:55:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075517.3057621-1-irogers@google.com>
Subject: [PATCH v1] perf test code-reading: Fix duplicate kernel maps and
 machine leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In do_test_code_reading(), machine__new_host(&host_env) already calls
machine__create_kernel_maps(machine). Calling
machine__create_kernel_maps(machine) a second time immediately
afterwards duplicates all kernel module maps in machine->kmaps, causing
dso__load_kcore()'s module validation (do_validate_kcore_modules()) to
fail and fall back to /proc/kallsyms.

Furthermore, when try_kcore is true and !have_kcore, returning
TEST_CODE_READING_NO_KCORE directly bypasses out_err, leaking the entire
struct machine, its kernel/module maps and DSOs, all kallsyms symbols,
and host_env.

Remove the redundant machine__create_kernel_maps() call, check for
!machine after machine__new_host(), and jump to out_err when returning
TEST_CODE_READING_NO_KCORE.

Fixes: 0fd4008ed755 ("perf test: Use machine__new_host in mmap thread code reading test")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index f0e8ea8754ef..c50b526f44fb 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -716,10 +716,8 @@ static int do_test_code_reading(bool try_kcore)
 
 	perf_env__init(&host_env);
 	machine = machine__new_host(&host_env);
-
-	ret = machine__create_kernel_maps(machine);
-	if (ret < 0) {
-		pr_debug("machine__create_kernel_maps failed\n");
+	if (!machine) {
+		pr_debug("machine__new_host failed\n");
 		goto out_err;
 	}
 
@@ -739,8 +737,10 @@ static int do_test_code_reading(bool try_kcore)
 	have_kcore = dso__is_kcore(dso);
 
 	/* 2nd time through we just try kcore */
-	if (try_kcore && !have_kcore)
-		return TEST_CODE_READING_NO_KCORE;
+	if (try_kcore && !have_kcore) {
+		err = TEST_CODE_READING_NO_KCORE;
+		goto out_err;
+	}
 
 	/* No point getting kernel events if there is no kernel object */
 	if (!have_vmlinux && !have_kcore)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

