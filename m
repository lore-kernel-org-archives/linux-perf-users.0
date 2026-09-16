Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F03EC69C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541593; cv=none; b=TyZj4ZnlEieA1WJ+02F2UCHBhKbNDpbZ0RGzBsmUCB+vf7QPDggURDsR3TfyQ2AAXwW99NbA2t+EbblCV0hfOB8NaQb+Ae55BxXUEu/7XKpEBFJIdSmiuca9q2XDcyCoaldlpC6A3/XyNmGyzZxCNyY+sXvzsGH6TRp6a6Je71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541593; c=relaxed/simple;
	bh=9SZY0Z8lU7pZSMz/2MxKMpQE3oWUENfMNgd6CyRcr2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qSyyrM346wE50F6Tl8qejGMD7bDM2ieuQ/I16pqznLbiMsaiZ6tsfk4Dy5L0UZEaAplpnQZMjXE2FBMWLq0EH868PkgD2/Q58tD/ZqHLxj/J99EpBeXd9XLsTcDq24LBk2jtFnLaopz8jmlCDrgaLvMWt5A9Igtd8ary3wfur0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npHDduOj; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npHDduOj"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so10605696a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541591; x=1790146391; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0m9dZH3EldCRs8re+Q2ZmSyVP448njCrkClOyVCYLw=;
        b=npHDduOjVcdGWCD6P26m3fJ2a3tIF+SmkVgNhuJqC78jYoCOehR+yS59zay4v3PYlT
         0B6HqC5nwy4BeNsTcyX3eZ1NnyXJHnUY/hWak3fDKpxdoWSe93YJWpj4ry4vLD8dVitp
         bVcMGTWJP8CmVLFdMifJj5bgE/F66Dru8Hva+ATRb/6EJ+/s3iGWh6JobFy2Cd2s3hbp
         RbBlyuNbFNNwTMy9T+cdLHCnchsobia6wguTTKlg/67suseqI5HFxaG/dzlfeFrbka2O
         w65t92qvkdChT28cFmjqmWjJnNdk5bTGWvogKpTglfS2UPWWyThnfAe6tvVZ6TIWtzko
         zjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541591; x=1790146391;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0m9dZH3EldCRs8re+Q2ZmSyVP448njCrkClOyVCYLw=;
        b=rddnK3U5NiBaVPhJza9cVx0R0d9Ee0/Noffjy0SvaSk39icHnUQ4dL3CK/Nn/puUfu
         AnLJh15B7GZ1YeS5hE6w3zLpYZMmWnXMoS0vhc1h0ab+jpldTm6X8EE0FTUvO782LJ22
         lG33E/sahP1g61zwmbOEYzd9XSIUrfxwE3yNJ0nQ4gMu5fagvlFqdzf8CiUMaSqB4r4e
         5c8EgTB8W9xK2bqudPwnLegnFBbeVllMavW8QUeI4CoH81BGOqli2cJslKk64AlylaBZ
         oM6uvvxfNaic36UqxYap0qlGM7zTjzsr5w5OfgOTzfvwVxK5GU+vwLdJ1a+qltnHi3zV
         97XA==
X-Gm-Message-State: AFuF++k8Mc0CxCJwFhh1DyOJsKK4zFsYy4pb8usVrvudS+p7NmlMHP2v
	wkHE3qKdgkJTfOJRzLjtZYaf+jiKjtHoTLqnAzK4Q7xF7NLndwr/eWv9vSQfZ3T590ZjdTUX727
	Vwda37EUNBQ==
X-Received: from dlbqe9.prod.google.com ([2002:a05:7023:b89:b0:143:8f03:a69b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e88:b0:398:cb56:e92
 with SMTP id 98e67ed59e1d1-39e1e30ba45mr3859082a91.11.1789541590804; Tue, 15
 Sep 2026 23:53:10 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:48 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-10-irogers@google.com>
Subject: [PATCH v2 9/9] perf test: Isolate test suite from user .perfconfig natively
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Running 'perf test' should not inherit the user's ~/.perfconfig
environment as customizing core properties (like core.hybrid-merge)
will trivially break stdout matching checks across the shell suite.

Explicitly set PERF_CONFIG to /dev/null inside cmd_test to globally
sandbox the environment for the entire test workflow. Test specific
config, like annotate.objdump, is read before the sandboxing so that
'perf test' still honors it.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/tests/builtin-test.c | 49 +++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 6293b37266cf..2d53414d8271 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -14,6 +14,8 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "util/config.h"
+
 #include <dirent.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -1655,11 +1657,30 @@ static int run_workload(const char *work, int argc, const char **argv)
 	return -1;
 }
 
+/*
+ * Owns the string test_objdump_path points at when it came from the config. It
+ * is reachable for the lifetime of the process so leak checking won't report
+ * it.
+ */
+static char *test_objdump_config_path;
+
 static int perf_test__config(const char *var, const char *value,
 			     void *data __maybe_unused)
 {
-	if (!strcmp(var, "annotate.objdump"))
-		test_objdump_path = value;
+	if (!strcmp(var, "annotate.objdump")) {
+		/*
+		 * The config, and so value, is freed by perf_config__exit()
+		 * below, take a copy that lives as long as the tests.
+		 */
+		char *dup = strdup(value);
+
+		if (!dup)
+			return -ENOMEM;
+
+		free(test_objdump_config_path);
+		test_objdump_config_path = dup;
+		test_objdump_path = dup;
+	}
 
 	return 0;
 }
@@ -1755,13 +1776,31 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char * const test_subcommands[] = { "list", NULL };
 	struct intlist *skiplist = NULL;
-        int ret = hists__init();
 	struct test_suite **suites;
+	int ret;
 
-        if (ret < 0)
+	ret = hists__init();
+	if (ret < 0)
                 return ret;
 
-	perf_config(perf_test__config, NULL);
+	/* Read test related config, like annotate.objdump, before isolating. */
+	ret = perf_config(perf_test__config, NULL);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Isolate the test suite from the user's ~/.perfconfig to ensure
+	 * behavior isn't impacted by custom variables (e.g. core.hybrid-merge).
+	 * Setting PERF_CONFIG isolates the perf commands run by the shell
+	 * tests, config_exclusive_filename does the same for this process.
+	 * Config values already read by main's perf_config are reset here, so
+	 * far only the hybrid-merge value is known to alter test output.
+	 */
+	if (setenv("PERF_CONFIG", "/dev/null", 1) < 0)
+		return -1;
+	config_exclusive_filename = "/dev/null";
+	perf_config__exit();
+	symbol_conf.hybrid_merge = false;
 
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
-- 
2.55.0.1032.g73a4cd73de-goog

