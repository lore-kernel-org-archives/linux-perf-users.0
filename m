Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E03F929C;
	Mon, 12 Oct 2026 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848824; cv=none; b=QbNZNRr451o5uFbcDG7Qrt00k0+F7MhvUuKHD25DDK0OmgjnPmuWRJWUyLRftcutAsRRiw3ycILdd/VP4vsKJRDPCssues6svW4gXt2usOOv3Q0SR/CQwwfFKXaIIaOrzpNZSKSG82jgjKJE91wlYKW+m5kgwiWwJbAtGvsUSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848824; c=relaxed/simple;
	bh=1bHuMsrEsQD5wEmz06IFmkb1QgZXlOqLPr0G6/eia1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5kj5NayKWIT0h6vIQLr1MYEe5KA3gpbLDCSSI9k8QikCLWFf7sTckDj4v3ZzOvtjxEry+Uggo3u6V8fJmDfZLY7W0xFQsA/eKtPre7aj6wYZQDB60onleyulTrZaOEAVeQMVg4+qsbTY3KOXjhGeZUv04snHr+e+INUa7nnBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPWMv201; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPWMv201"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672C1F008A4;
	Mon, 12 Oct 2026 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848822;
	bh=0HHVkRhgsPcJzdQTEl7ApOCJ4ty0rF61qluUNEmc2qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPWMv201r58rpp/5YQo7tPeefXM/Z6rQYb+zNpVdJAv4O4jZoUbSmsHAa3opr9184
	 Dh6IlBg1583ELxhMMnygUyGSJRSFf7jWmQHc8LAONDmw9GGCdNPneTuF9AEnVSOEWz
	 cBNCCRYwqxm6lOlR/FcN8oHv3h8tTSggt3CqLdVHUOQYlRDGRpe1RhlsUWAfsKwx5f
	 LXtEq6V+1TXLZ8nN3TYevBFdyXgzwTrJ/hYDqL3kvfNu/eq4ideQ8KrA5Z/aUr1Fog
	 VmkxsMUSbLmTDYgh2ZY1TXONzWTmtGVXHVA+eVUXBrV4Sm64zxEZDmA/EQE48LGbzZ
	 UnOH9vn2l++tw==
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
Subject: [PATCH v4 10/10] perf test: Fix dso data tests
Date: Mon, 12 Oct 2026 16:46:54 -0700
Message-ID: <20261012234654.60666-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012234654.60666-1-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
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

