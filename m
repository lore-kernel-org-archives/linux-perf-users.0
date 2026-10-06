Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326B5013BF;
	Tue,  6 Oct 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330201; cv=none; b=NuvGNSwQ2IxRHfm0wHRaDlLmjL3XOQOqB+spTIXfseRYtMgK9Gek0HuftvzLladkQAYtqfotlUemS9B/TjaMEMO2rnGtPV2R1/fdPMM+JbI0AnMpp5r0XS6ksWMbTBKj3gQL+ZCdaEAMtGBJfJepjPnFktBKKAj2tgoOrLY/T3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330201; c=relaxed/simple;
	bh=8f/RKb+BjA/89igmeOQV9I8FbXkjdz+Dwb7uNrauzrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzn45T3UgZolcrL4HWWdLyFOvEy/NIwkCrfP46omnlRqfNEyLdXfBs9n6MujY72btzedXv3Y7j6+xro86gY6BOzyAmeXG2pl+V0o3R5VvS0SqJufGUVaog/vnH7R5tEJhBfD9t6simnu8ISgZlYkmPBzyA9WyF6ErmZJbutySy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1LiMWYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1LiMWYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1A41F0089B;
	Tue,  6 Oct 2026 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330200;
	bh=nIxesvrOaEvjhXYD7yps37tPk1xBSRh0gdXmlz4Bo5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1LiMWYRobgKt28kJ0wS34Eq44sLtF+qldLOADJr8foM3hkhsRzoAqMkmdAMeQtK/
	 X+Lvo8q3ls8AlM17mHOOAGCSfUCB+U8bxxuSyeYBp0VkFSwQnyMY2RsI6YzqkEqfts
	 vfhCf191BiQF87D74rQqWcCr7HZTaYkvPMCKUfPAq0qM4Qjiw+Ob+yCzQFva26plUy
	 KD5vgOw0a3kUvHJQn4Uuai//Aa+5rJRAxfsxg/gvb9v3SyP4GxzKxNJzjquqyJDHa4
	 3jOGCS+0PTqxpILzDor8vtZaKH/w4yD9lG/je6k8zS/hrhSGFMUrlEAdulV/NvjBnO
	 gqegjKCuvBhgQ==
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
Subject: [PATCH v2 10/10] perf test: Fix dso data tests
Date: Tue,  6 Oct 2026 16:43:14 -0700
Message-ID: <20261006234315.920817-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261006234315.920817-1-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now dso__binary_type() requires that the target file is a valid ELF file
containing ".text" section.  But the test only checks cached read/write
operation on a file.  Let's set the binary type to bypass the ELF check
to read/write the file properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/dso-data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 46bc3f59726004fa..5a027ffab541b4a2 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -138,6 +138,9 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	dsos__init(&machine.dsos);
 
 	dso = dso__new(file);
+	/* override the binary type for dso data access */
+	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
+	dso__set_bintype_searched(dso);
 	TEST_ASSERT_VAL("Failed to add dso", !dsos__add(&machine.dsos, dso));
 	TEST_ASSERT_VAL("Failed to access to dso",
 			dso__data_fd(dso, &machine) >= 0);
@@ -225,6 +228,9 @@ static int dsos__create(int cnt, int size, struct dsos *dsos)
 
 		TEST_ASSERT_VAL("failed to get dso file", file);
 		dso = dso__new(file);
+		/* override the binary type for dso data access */
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
+		dso__set_bintype_searched(dso);
 		TEST_ASSERT_VAL("failed to get dso", dso);
 		TEST_ASSERT_VAL("failed to add dso", !dsos__add(dsos, dso));
 		dso__put(dso);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

