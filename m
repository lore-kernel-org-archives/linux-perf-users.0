Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF25275A0;
	Tue, 13 Oct 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912124; cv=none; b=Fq+LJmdSefDvGFP184GiIiGEOUbJOitAVgl145n/M3AjtD63ziRll9BAkPFldZNJpqP6d9Z2yNqSPR1mh3SA4yMaWGl0g8AlZbe9/0PCpmHSBn9sADqW5uKsVdQT5G/ltShwmv5urRyG3yVunm7qfQcHre6felO2NZ8Gkebm49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912124; c=relaxed/simple;
	bh=1bHuMsrEsQD5wEmz06IFmkb1QgZXlOqLPr0G6/eia1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtrjkpCMsxgKqSOD2Z4iyPG8hXQaatdsHXmsgkdCEfX/0Zi+/8ReTFksQryAtGYk6gMUBHihRkyJVhS3JmFBpGkWu/oNNYhAj8+tnk+ucK9aXI3M96HfhurfwqlwGKHSEDf/QXvM7z3XsJZVlreErU99GbjaDbQAyWRxwyh68B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDLjQGKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDLjQGKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE48A1F00898;
	Tue, 13 Oct 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912122;
	bh=0HHVkRhgsPcJzdQTEl7ApOCJ4ty0rF61qluUNEmc2qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDLjQGKuh4t7R9JtBo59Aj3gmdMVcp5ESDbT4zmnJhPBvtuoZnZF0QDEbTrR3Xvly
	 OanIu8M3B1uGoVAcjCCDrv+7xSqkuUboA/tmVVv3kM/P82tSam3h/9zZZJc36BFc0N
	 ppvS7VP06ZbbveXk3oXRxs6FUl5lYR82rXgTBOI6fTmkC20yC/3fCKkBcCVLDI/hpU
	 gX0aIpKna/xHsQ8IsjVs+M0h5vtCNfG234hrxgkwmYBSoajzcPrIk7c0u1cTVuhrTY
	 VVoAcrs4GFJFzi+4nOrXREmidmF0c2tBCYylomHfd3WkkPMirAthWrgnJ1KnfTf1FO
	 Zy4B2nrgIjdjg==
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
Subject: [PATCH v5 11/11] perf test: Fix dso data tests
Date: Tue, 13 Oct 2026 10:21:55 -0700
Message-ID: <20261013172155.160869-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013172155.160869-1-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
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
2.56.0.385.gd3acb90ef8-goog

