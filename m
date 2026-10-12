Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691833AFD1B;
	Mon, 12 Oct 2026 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782778; cv=none; b=AZvuBLzvnPQ7hQ9lQjVHz4njmzkadXwuST3KLyCLILu7cJtFy1R9cFwZNMyoGb9IRDVdiTkTduEoiK9lVBZBdzey+g4zZItnsFNlyb2M7rCMVYunbHqyiSOzn2jhYgdVH6DQwxZjT0ceA3x29ICezEBho47STrax4Yv3hI4WeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782778; c=relaxed/simple;
	bh=OgS2WwfnfpjHI0jfxf0TWcQUQNIu+qmt5ky4pmCVAjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdzoqHA7oZYyJ+GudiZk+BegvFYc/QDOQUVizFbc5IqiNCNWolJRhgpU1t4NkNLSQfPmV9/WE+pd4k8Qq6+hGjM4Pd9ePxXywwb5XparhpUnZ4zhwqzn7jwrvKP+SXqyLVo6pzmJKSOSOSt+Xl7mmC+T/9dV2n9jq3Fd0cqon10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU+JFI3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU+JFI3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589F81F0089C;
	Mon, 12 Oct 2026 05:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782772;
	bh=ijf4C0SLHrxKjo1ngl6ceH84reXfF8ohaNWawlSA9Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GU+JFI3HyOiVutr64XKpmK02doCyZJ5MMy00XUt+nuHG/1E8yOEPHKlk4DHVTZUoE
	 Dq4gnruJpNr+t+L70FcPhV3OqSI0ZLfFEEguV5wR3E2O8GW9+0/OH1IyDbGsXNUB9Z
	 OsMTphJtzcxJx9BlPyou8+Vq6cnRi4fCKRD3dLVPXxZrmftp6CqUrNR5WgQ9nMH+Os
	 bnL/nlTVP30KsytGjMELNtN0Odp+DZ6Jkbm2U772G0EpUowixAHE1DZ4EM182hrvcn
	 Un40JT8h09LTKI/Ek8HZS8CpBF+u7VhbNcc/KQanRJFnDtOsxQS2xroMiBkAw39KB7
	 wj/JG/UPcg4Jw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 10/10] perf test: Fix dso data tests
Date: Sun, 11 Oct 2026 22:26:01 -0700
Message-ID: <20261012052601.13920-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
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
 tools/perf/tests/dso-data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 46bc3f59726004fa..18b7052a2dc575c2 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -138,6 +138,10 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	dsos__init(&machine.dsos);
 
 	dso = dso__new(file);
+	TEST_ASSERT_VAL("Failed to get dso", dso);
+	/* override the binary type for dso data access */
+	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
+	dso__set_bintype_searched(dso);
 	TEST_ASSERT_VAL("Failed to add dso", !dsos__add(&machine.dsos, dso));
 	TEST_ASSERT_VAL("Failed to access to dso",
 			dso__data_fd(dso, &machine) >= 0);
@@ -226,6 +230,9 @@ static int dsos__create(int cnt, int size, struct dsos *dsos)
 		TEST_ASSERT_VAL("failed to get dso file", file);
 		dso = dso__new(file);
 		TEST_ASSERT_VAL("failed to get dso", dso);
+		/* override the binary type for dso data access */
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
+		dso__set_bintype_searched(dso);
 		TEST_ASSERT_VAL("failed to add dso", !dsos__add(dsos, dso));
 		dso__put(dso);
 	}
-- 
2.55.0

