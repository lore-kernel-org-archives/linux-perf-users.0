Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417B270EBA
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763528769; cv=none; b=PZ52etk2TEm0AclzAWHCAKSxFOj+GulMZMyEb2pPqZ05yTJ5ZjveYBpVQAjdvTIF2OSDj8FkJMzPgQ59/Pu0RuXYNNu8rsldN1kC21lF6nuegp2Xw0jACXOg0gzZv258wN+vt2WsMpqXqEi02AYGc5VCLiPd8YyFxTD3zSYEVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763528769; c=relaxed/simple;
	bh=sErQlv+SSX673tGFwuBfJXkDlMGMo806+f7AvH23WLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cv8ghgv6FY1Eh+w9XJ/j/284QRMkWSxOpvDzj66lOPPcIg/7LUsCdKo16gIjl5HNiOsry2bnd4V4b7FTaR6qsUqKKCQi8vCixGYra50l0pC22L0wWqY9h6LtbXDbO4hs09vQlzek2q956bgrkRiFGC36LmOBHP9NboA/ZEllnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TMpEEqr0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMpEEqr0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bb27b422cf2so12682070a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 21:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763528766; x=1764133566; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttkXmYbg68Vro9QoU2QUTcpcEAK5DtQHDGLiWPkC03U=;
        b=TMpEEqr0eyfdkaUEb0Kz2sSUHg0RzO8de8ATUzdRYb0EOHXsQuvIi+YaOBZorWyPHX
         B3/kFVvvXMtSNT8cmNmGH7t54cbvfIeQZnBpEBjAw5LI7+cbiR86FD/PXHUswW5u9jsR
         TEXJOb938x01Lv+ksovtjzu0iKE9bv4W7tQGpZhOz25QqcxjZBo5C8wPy5djyFn2Sy9B
         qOn6y9tKpETt9/7ngtqD47EYnNzWdTqNpP2+tIlR2VMh0pWpy0frx92kM3QjjQ2VeRd6
         rnH9sXiZAeFDlAQLHJyk8NKl6pJ9pzPT6FNOwQz0zU+EwU5w8DkYwxtQeKStIHS2ciZD
         IRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763528766; x=1764133566;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttkXmYbg68Vro9QoU2QUTcpcEAK5DtQHDGLiWPkC03U=;
        b=iHiLpVihx3eyiJjdOXsXA6rBJZTcpU69IiSwrC6qrysTY0LNaRZLLNDrWFqapjmntm
         jEttlvgfXxE5Liv7NnQCR9MCfpEOvZoOWt01o60N965K4j/l7VwdndLMGs8qCLxKVSLn
         SZXUR5Ol0XZilQkRJ3kns+OcuHCiZF9bbn2GJMEbyMZdlAfZvTQtUWXhT1awRuXnw/Gm
         GgHXCmd8bkfBM9rlYF+NNpZ3CinFyd+Nn6Xgz1k9aiHsbmwRDG5ElVLchLtOf5MTpcQy
         k/3ZV3wXu0GA1yLDkuEZWfGpDE2+fXOzWTxeEk2gut31Cx2rhcHZ5EYVl1y2a13WH+2D
         p4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXXwscliC+d+K8wBDluIWAeVqQeIRji1zwirkIKKQeElEZMSriNnnsCYfTthAR+GnGIplISPGZPoiLGvW5s+Qsj@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/CD05MXhlsSUFXDSdCq7qRjbx5H5e/WM0op07wUSzUn2LO9R
	D24zt656dew3CQFl7Br78fPePRMLQ1HDYKDVLrp28TWssDg34puAjqqQz0Pauyt/Ip5iRvE8XJD
	4evJ6kUEgUw==
X-Google-Smtp-Source: AGHT+IFMWHR6ONxAR1O4I5VrA191Wg889KMc+40Os+/1IDDJPJJIBz077B6oD4VN0iciAfxL762efycsBgks
X-Received: from dyau39.prod.google.com ([2002:a05:7300:6027:b0:2a4:75f7:2135])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3fa4:b0:2a4:3593:9685
 with SMTP id 5a478bee46e88-2a6d995cb02mr561372eec.2.1763528765799; Tue, 18
 Nov 2025 21:06:05 -0800 (PST)
Date: Tue, 18 Nov 2025 21:05:55 -0800
In-Reply-To: <20251119050555.2017758-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119050555.2017758-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119050555.2017758-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test maps: Additional maps__fixup_overlap_and_insert
 tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, German Gomez <german.gomez@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add additional test to the maps covering
maps__fixup_overlap_and_insert. Change the test suite to be for more
than just 1 test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  2 +-
 tools/perf/tests/maps.c         | 82 ++++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |  2 +-
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0d2fb7a4ae5b..9090e8238a44 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -126,7 +126,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__jit_write_elf,
 	&suite__pfm,
 	&suite__api_io,
-	&suite__maps__merge_in,
+	&suite__maps,
 	&suite__demangle_java,
 	&suite__demangle_ocaml,
 	&suite__demangle_rust,
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 4f1f9385ea9c..2c05d62f40dc 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -162,4 +162,84 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	return TEST_OK;
 }
 
-DEFINE_SUITE("maps__merge_in", maps__merge_in);
+static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unused,
+						int subtest __maybe_unused)
+{
+	struct map_def initial_maps[] = {
+		{ "target_map", 1000, 2000 },
+		{ "next_map",   3000, 4000 },
+	};
+	struct map_def insert_split = { "split_map", 1400, 1600 };
+	struct map_def expected_after_split[] = {
+		{ "target_map", 1000, 1400 },
+		{ "split_map",  1400, 1600 },
+		{ "target_map", 1600, 2000 },
+		{ "next_map",   3000, 4000 },
+	};
+
+	struct map_def insert_eclipse = { "eclipse_map", 2500, 4500 };
+	struct map_def expected_final[] = {
+		{ "target_map",  1000, 1400 },
+		{ "split_map",   1400, 1600 },
+		{ "target_map",  1600, 2000 },
+		{ "eclipse_map", 2500, 4500 },
+		/* "next_map" (3000-4000) is removed */
+	};
+
+	struct map *map_split, *map_eclipse;
+	int ret;
+	unsigned int i;
+	struct maps *maps = maps__new(NULL);
+
+	TEST_ASSERT_VAL("failed to create maps", maps);
+
+	for (i = 0; i < ARRAY_SIZE(initial_maps); i++) {
+		struct map *map = dso__new_map(initial_maps[i].name);
+
+		TEST_ASSERT_VAL("failed to create map", map);
+		map__set_start(map, initial_maps[i].start);
+		map__set_end(map, initial_maps[i].end);
+		TEST_ASSERT_VAL("failed to insert map", maps__insert(maps, map) == 0);
+		map__put(map);
+	}
+
+	// Check splitting.
+	map_split = dso__new_map(insert_split.name);
+	TEST_ASSERT_VAL("failed to create split map", map_split);
+	map__set_start(map_split, insert_split.start);
+	map__set_end(map_split, insert_split.end);
+
+	ret = maps__fixup_overlap_and_insert(maps, map_split);
+	TEST_ASSERT_VAL("failed to fixup and insert split map", !ret);
+
+	map__zput(map_split);
+	ret = check_maps(expected_after_split, ARRAY_SIZE(expected_after_split), maps);
+	TEST_ASSERT_VAL("split check failed", !ret);
+
+	// Check cover 1 map with another.
+	map_eclipse = dso__new_map(insert_eclipse.name);
+	TEST_ASSERT_VAL("failed to create eclipse map", map_eclipse);
+	map__set_start(map_eclipse, insert_eclipse.start);
+	map__set_end(map_eclipse, insert_eclipse.end);
+
+	ret = maps__fixup_overlap_and_insert(maps, map_eclipse);
+	TEST_ASSERT_VAL("failed to fixup and insert eclipse map", !ret);
+
+	map__zput(map_eclipse);
+	ret = check_maps(expected_final, ARRAY_SIZE(expected_final), maps);
+	TEST_ASSERT_VAL("eclipse check failed", !ret);
+
+	maps__zput(maps);
+	return TEST_OK;
+}
+
+static struct test_case tests__maps[] = {
+	TEST_CASE("Test merge_in interface", maps__merge_in),
+	TEST_CASE("Test fix up overlap interface", maps__fixup_overlap_and_insert),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__maps = {
+	.desc = "Maps - per process mmaps abstraction",
+	.test_cases = tests__maps,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 33de16dde737..f5fba95b6f3f 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -160,7 +160,7 @@ DECLARE_SUITE(bitmap_print);
 DECLARE_SUITE(perf_hooks);
 DECLARE_SUITE(unit_number__scnprint);
 DECLARE_SUITE(mem2node);
-DECLARE_SUITE(maps__merge_in);
+DECLARE_SUITE(maps);
 DECLARE_SUITE(time_utils);
 DECLARE_SUITE(jit_write_elf);
 DECLARE_SUITE(api_io);
-- 
2.52.0.rc1.455.g30608eb744-goog

