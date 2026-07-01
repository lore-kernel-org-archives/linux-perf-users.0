Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5A420E79;
	Wed,  1 Jul 2026 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934917; cv=none; b=Wx7jGqPKwjnjS2BJtxR5+iQD6aNSqiwbyrz8ZJNt1JbSSOVkkInoDv7QSrymVffdW4HxDn5i3NlKsMOoml3Dxy42WuDKSEfCpjF1joFSX4qwlgIsLl01fFZU8JcuUda1RML6J+aVSGE6zTJGzzf1lXLoQwp+fopSeWHODGmd8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934917; c=relaxed/simple;
	bh=5GPwVtM2RK9ZtuQSCKd9d3k409Kli+UuYVrVSoiH/SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw6BjoSFdiJDmVZs3udcWNsoho+cn4irsAVL0vbIoxhF+eLUxanJYII/HB4Niwnuod60fJkS2x0M33tFD9oD+pVZm075U/mKHqGHQGOKjpRQUyf72lTToa51QqL/4JBAuq7dCcq7UgoAEQu1iBVdM7mf9QkJukenoDTQ3reWWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1jbXDZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1jbXDZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3AE1F000E9;
	Wed,  1 Jul 2026 19:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934916;
	bh=0HitbFM5GCHSs94ipN54RIIzFNOEq53ju1KsWUZezCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1jbXDZ0P7mbYckRZklyR8GuiCwE+OkY+qKSzS7XQ7VNIR2Qntjcwu84JeKfS7czP
	 YsFzLqNN8lUdpYkead47GrsQ0PvOWKLQ/cY95bl8WBTH2wOJBOtcgSlZ2MsEApdZx9
	 Dq8LJ6ryDUiCFYFdhS9ObQW77TRObi8/q+9jjlFq8Vh+zqC94ziuLPZ7jhEbVSge9s
	 F6BsaOVbrUbDPluZksmlx3ffdGBa3BfXgTd4wuKOJphgIlJ9pj7z98brhr9wjTHjah
	 Pb7kmtj0cK3rl4JksalDHv7VRjbrAcKlOOgDo5Z1QYmMgL8QRupXcryJnCK0saCQ9l
	 6E+xzEuN33fhg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 5/6] perf kvm: Fix a memory leak in the usage string
Date: Wed,  1 Jul 2026 12:41:52 -0700
Message-ID: <20260701194153.401218-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260701194153.401218-1-namhyung@kernel.org>
References: <20260701194153.401218-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first element of the kvm_usage string is allocated dynamically by
parse_options_subcommand() if it's NULL.  Callers should free it after
use.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 20ea59e59a4b65ba..00baafb056032970 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2135,6 +2135,7 @@ int cmd_kvm(int argc, const char **argv)
 	const char *const kvm_subcommands[] = { "top", "record", "report", "diff",
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
+	int ret;
 
 	exclude_GH_default = true;
 	perf_host  = 0;
@@ -2152,18 +2153,18 @@ int cmd_kvm(int argc, const char **argv)
 		file_name = get_filename_for_perf_kvm();
 
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
-		return __cmd_record(file_name, argc, argv);
+		ret = __cmd_record(file_name, argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-		return __cmd_report(file_name, argc, argv);
+		ret = __cmd_report(file_name, argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
-		return cmd_diff(argc, argv);
+		ret = cmd_diff(argc, argv);
 	else if (!strcmp(argv[0], "top"))
-		return __cmd_top(argc, argv);
+		ret = __cmd_top(argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
-		return __cmd_buildid_list(file_name, argc, argv);
+		ret = __cmd_buildid_list(file_name, argc, argv);
 #if defined(HAVE_LIBTRACEEVENT)
 	else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0]))
-		return kvm_cmd_stat(file_name, argc, argv);
+		ret = kvm_cmd_stat(file_name, argc, argv);
 #endif
 	else
 		usage_with_options(kvm_usage, kvm_options);
@@ -2171,5 +2172,5 @@ int cmd_kvm(int argc, const char **argv)
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)kvm_usage[0]);
 
-	return 0;
+	return ret;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

