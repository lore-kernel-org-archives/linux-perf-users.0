Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC951448C5;
	Fri, 11 Oct 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657564; cv=none; b=A8XiKPsxYlm4wik66DF+QSNOuU0MZj6QxvNb53JmYX5sCt4G2Q9DpISYn5kvXcSjrvj19IgjWmFoZUYnuWPMD8ZZx7lk4Iloalg9dXaaqfDkDmpmIIMsfVaANvDFuZGAYFoNXMtcP8z9TQ5mA/o6s13rikYukqiH4Vhf2Hwfo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657564; c=relaxed/simple;
	bh=HyPQqIrYRFgt5XqFmmijbWcVkh1OJkkmK7bDD2qKDn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFb1FXmVYdZvb5UfTycRtBfDnBJlVKrYf7v8MLzVF8ySPCwoAf6Ahee6Cusw5NiI9ndwPNFOdyRTx+0lYJFatMY9X2vCUNa6pXZTa2hIaH0fjWKkqcrbzNv4CwxIDFhbGZXtvu4fMCqvpj/dkJiP9RJcBM2UoxLjCXEuDDKdPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3aW+t14; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3aW+t14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABEBC4CECE;
	Fri, 11 Oct 2024 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657564;
	bh=HyPQqIrYRFgt5XqFmmijbWcVkh1OJkkmK7bDD2qKDn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3aW+t14ZO9nprJoiUdCADdZT/wUYKI7XO72GEgeH5QmsqIfDW7uDzhQUWHlcHfYJ
	 VJYkj1GQSA5SIWXAzUoWnzfEjRbH9813wAQcuv3S/SMSNROEmhc0ADQHq2K0n4Eh9n
	 Brnx8M8765PK50V2y4Qu+KPrRX+NUUbP9OSFY2n02gEbXM4l8VrY2lAgHtMwqGr5Xl
	 qH5QyAqBCWCgxzgt5OfZ6ufHKxiINx/GrutJRxu78XNhmsFHNOZMtdsVUBzm8WJo8p
	 kSgI/Bw8XOk/U+cSRSLGvjFIYLgzpPkTQbIZVMcZgYKuPoXct3Et2etFjP0tsA1/aq
	 nT2CpSm0XwAOw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/3] perf test: Introduce workloads__for_each()
Date: Fri, 11 Oct 2024 11:39:04 -0300
Message-ID: <20241011143906.1285675-2-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011143906.1285675-1-acme@kernel.org>
References: <20241011143906.1285675-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And use it in run_workload().

Testing it:

  root@x1:~# perf trace -e *landlock* perf test -w landlock
       0.000 ( 0.015 ms): :1274331/1274331 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd3fea55e0, flags: 45) = -1 EINVAL (Invalid argument)
       0.018 ( 0.003 ms): :1274331/1274331 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd3fea55f0, flags: 45) = -1 EINVAL (Invalid argument)
  root@x1:~# perf test -w bla
  No workload found: bla
  root@x1:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427ddaad..2201f7ed432ce9f2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -155,6 +155,9 @@ static struct test_workload *workloads[] = {
 	&workload__landlock,
 };
 
+#define workloads__for_each(workload) \
+	for (unsigned i = 0; i < ARRAY_SIZE(workloads) && ({ workload = workloads[i]; 1; }); i++)
+
 static int num_subtests(const struct test_suite *t)
 {
 	int num;
@@ -504,11 +507,9 @@ static int perf_test__list(int argc, const char **argv)
 
 static int run_workload(const char *work, int argc, const char **argv)
 {
-	unsigned int i = 0;
 	struct test_workload *twl;
 
-	for (i = 0; i < ARRAY_SIZE(workloads); i++) {
-		twl = workloads[i];
+	workloads__for_each(twl) {
 		if (!strcmp(twl->name, work))
 			return twl->func(argc, argv);
 	}
-- 
2.47.0

