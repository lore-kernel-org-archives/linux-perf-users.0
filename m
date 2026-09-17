Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DE3ED3BA
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621664; cv=none; b=lU0e5BrXEzVJVuTXPjdq/gpQ41HZS89krYA2+XiuLkrgxIpZioMAIF7nWzVQS4X3beLLP76kZoKQBkM5/2eMsOKzVTU8JMItoJPgfWu2ynimyhd2ru3XfiOilRhm8Ha4h8SEDyAZ6/9z54fu/GmK73nnXbiC7OitEt+nRj8UtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621664; c=relaxed/simple;
	bh=on4JPLScYh1nB1A79ixv0ZIEGxwlL+hJyfIBgoB8xxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cn8MjS3TuGfwhmA5BzdPUltJzHmN96/YL+sHQGtBwbAkyAS2AV74Y51515GD/sCGCe+rMF8Gy64jr9yMO+eo0qLxh+K7TOo9yFSn/V2D5FSEj6GEJYMjpExTAzEd0r065OIx3bBJNpoBn8/059ZSUNYV7agcdpH7lSdH0qKfais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huDTWQKF; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huDTWQKF"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so740434a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621663; x=1790226463; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VG4f4AvZoQKble5jQ8SQSDqnqITphIJrYwpkQM1Fgco=;
        b=huDTWQKF57HjYb5BTvBr63AHWOwdQDq+MHZ9CoZ1IrbWUU1dDyvMR6UpAoigsHryIs
         0gDS1n/JivJ33JDL2Eq2KhQKP55BwBOgARWjY4ebI5d5JYRcPBbuyCiTcmgH2bF/WvvI
         RPdkk/gcEw2VrZ8YuA/2GrDBylhyWm8o2psDRX00M3bBoMUjnRT+UplybOv+zEnGrL97
         M+UuvCWNXAtQd6Ui1gWfFTsDJBhSvtuFHzcfpS4mTEXFYftnBSl2PR3akZPXxTYMKa/0
         DIbAxIj8PNQ2hsQctWrPW1yh78kUZgaGLAB4fvPUXxDW9Y5+0xKV3ahKD8Nx/PE7kyZh
         M1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621663; x=1790226463;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VG4f4AvZoQKble5jQ8SQSDqnqITphIJrYwpkQM1Fgco=;
        b=dIQoVGPZXkwGzY6tZv9sF4zBoq/ZeXqRrKyhXbiopGI+lLLMpbhzzY+wO9FqWkPVB1
         /jgn9Ygbs1oOP3btfsqidrtonTKjjpUR1Jlt9W8LvqU/I+i7QgRbG97gPNXwTdjkvXu3
         xmLzczglZlHpT+m6YlIgxQqrr4YGdpc/yzEavvsC3odD7Ak/pm7WjdbnYj/gO0xYiG9K
         yv/YB8vWOuxxNrt77tLgj1ar/2xn/8iDGv6ClLbWG4uXLQ2wf5O0HeKh5i+gTsZq0u6V
         /asIXeg7AFsrYiKp72fTOWf1cplJKFmIazpPZtm4A88EjJQxl4a5ijDL6QxO4qfiHxvv
         qPsw==
X-Forwarded-Encrypted: i=1; AKwUvByfAqGS8OUBXZYBrim1DDQ4cv7hzI1rZBgYaBgpJ/HuucJAOeB2jWJSwd5yG/2MdXJCjwN9wSGQP1s8PFieADRg@vger.kernel.org
X-Gm-Message-State: AFuF++mEpDQKSBdwNIl5oDfp/L0ua51irqdebZtUbYd5MN3BCKXgU2R9
	joC4FpXz9brqKoIAgUPUh5XZq++Sfii/FMmcDylB4PK2pC+4dG5KXovMrSd6vAmaCmGxKj+MqT+
	avDgthu161g==
X-Received: from dldyq18-n2.prod.google.com ([2002:a05:701b:4552:20b0:143:75c2:6d21])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8c:b0:37f:e5b1:ec4b
 with SMTP id 98e67ed59e1d1-39e35da0512mr3873387a91.5.1789621662586; Wed, 16
 Sep 2026 22:07:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:08 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-10-irogers@google.com>
Subject: [PATCH v4 9/9] perf test: Isolate test suite from user .perfconfig natively
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
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
2.55.0.1082.g2b9226bbc0-goog

