Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202D4E431D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602445; cv=none; b=ABX0PZ/8Z7E+85i0OVLYeewSKWn98DplT+UVzFLWJGjmvxT025uaId5/1E0jCkAU92XpkDaPjeJW/cQ7nztZNNCCO7X96NVAb7Ebz1huf6ZFNNhKuqSawUZ1r1CnDBtsQmr0cEGpdUO4qn2xUZUX9F4u4tbaP1/nKbToepjcLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602445; c=relaxed/simple;
	bh=on4JPLScYh1nB1A79ixv0ZIEGxwlL+hJyfIBgoB8xxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C/UNeBAu+r6f9x1YLkQDsI4ym4HiNgKzD7aGMukJP4KfBNyNn1if3htDlhom/2+1R0lIFPyq+EmJk3/a/eEeDhUtcc/ruDz6TS/5NfpRGw7khaHUJv5+m71qkibMhyMYbOzg1sAZw65WDfFeTngi4QLVK8OBbXTuQuC/1J6gNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxCDVqld; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxCDVqld"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f75c1219so5055765ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602444; x=1790207244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VG4f4AvZoQKble5jQ8SQSDqnqITphIJrYwpkQM1Fgco=;
        b=DxCDVqldvudfPxXhcqkFunZXI7qpGpgeBYYefSMgKM+wY+VB+NUaWcLhSq4gc5GxxJ
         b5q2HO5x8jYwUycpD6F/+UszBgGRKqppcEN/ZvXEZ/GqdwtzawVUmpKbf7HrF8aF0Ruk
         B0x5ka+2CDQdR2/cducJzeX0XP91J0jMSxGB+xsTvKKXTe7HWwma4sIvVNpFO8wbxkRd
         m/jbMmsJWZ1fHYvAjNJ27u4sEgms+sXUVyBcNtay4q2NMO3NEy7RX2T4FmJ8NL2ZpDX0
         6E+g3fIMz7tjY7NG0iTBkb/KGJCVeNgTL/dLe20UPUJuDcLJgezdVsBjWditEtUEf2Q3
         eEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602444; x=1790207244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VG4f4AvZoQKble5jQ8SQSDqnqITphIJrYwpkQM1Fgco=;
        b=v6icNbwoIiXJp2utRhvb19+m6AKjhEGJ/Z3R4/mjCl2ERy4nsiiqWhYwxfpHlo17hy
         GqARzXiWGzzy6tNk3sZvy+DC2Yyxr0vgbt+hYKbmoOIYDBp9ZWZv3krQFKfQgkKUsRZ0
         fYvIBmYPGLDRD3iq5roFduKkj1e9FxFxrM9ndvxdDfqrN7KYBDXvlmO50DmNvq5fo6Ay
         MIfR8bmYum0L49Ru9lk+wBprB1o7ywEeOCJwoCQksi2vR2iaeWQkKy83fQlqIKEuj9xH
         K6EqHBZKjuuelWBYOSjBa1+7haH5VxD6cJiY8fd9rgVMNekakmPRpkAuPVfyDev69JrB
         iBgg==
X-Forwarded-Encrypted: i=1; AKwUvBz+7+0yfIBKM5MmCXepRSfCZVMqEcK1yTGTOwKIt6bxwRoPf/KJClN1Mtc/rgbG/n7bd2XaMbT8quc9EnjuhOwE@vger.kernel.org
X-Gm-Message-State: AFuF++me4LSr4teM+LBBCVhCwED9OCK1kBPTibE88zE7L1pyRcbjVixs
	GVr16gfgyBJFWtTZYYxSQ7RUjsQ5+O/3aelPex465coNdg+/ORubi+NCmVayVoZuhdZeaii8R11
	hQzLqYiwedg==
X-Received: from dybsc14.prod.google.com ([2002:a05:7301:4b0e:b0:339:71e4:6d06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2452:b0:2da:f7ad:cfea
 with SMTP id d9443c01a7336-2dd8df0a71emr92515645ad.8.1789602443464; Wed, 16
 Sep 2026 16:47:23 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:52 -0700
In-Reply-To: <20260916234652.439778-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com> <20260916234652.439778-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234652.439778-10-irogers@google.com>
Subject: [PATCH v3 9/9] perf test: Isolate test suite from user .perfconfig natively
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

