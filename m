Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DA2629D;
	Mon,  2 Sep 2024 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241585; cv=none; b=Z26POGL4JzHi+EfZAvLCyrRDu2EZwwGYM9OXuX58EFdLJ6duNxZEFHLdHagvT7uIoDM/iuUWORcYS2qFGr3NhwUi6gCb6IoeuQSAf1rMbRQtlpbDiEzpyGO/Oa+SjNnUEPAtzmEoAyOKcW9Guah2oqbEtGpGCUTdc9Gl3ElGsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241585; c=relaxed/simple;
	bh=U0ncT8Dq85ANDICoElz1hOnaFsagXVOnXrJX3yaEXj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKS4N+MLn6d3hHNGKi3JiQQWEe+fssz2Lk1nqzt6hEq9EpN8LaVJcfuTVgB0j+VXhIW2lXnhJImGOGwVQY/ho+qqB46fQwe8bEfnI/BHcRfWb51XULDTpUYZe4hODVQ8Xkag1/iwMgzgIegspQD9hl5MUFnbOpsfLEf8JKjYXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzJVuZsY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzJVuZsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15E8C4CEC7;
	Mon,  2 Sep 2024 01:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725241583;
	bh=U0ncT8Dq85ANDICoElz1hOnaFsagXVOnXrJX3yaEXj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzJVuZsYNmc4Xfz+rfpv8Laf8qIG0YcvBwf+rjb1pMA9vKTOD0yasoLZxseKoo1QQ
	 qm0Ylu5otkyF/Lb7C9aOpRDpwvKVcMqpzBzD6GlY5s9tUxUvOzDWPVkP9o2BNeF6n0
	 dXJeE32Z8GhOYmD2V5E9UJDYrgOPrgVAGBRGO8sGrAXgxBJnffO6Oa7RaDUJsnmgJE
	 wbkO0MruA32bFjguC+EDPDdriSlxHYJwOQjN8KymZ3MDU2SJCIAdyNcyN5e2RLrE0C
	 p9qxeRvcB9fhAhU62+ZsikU3n2rZocbMswdsczYGoe4kwEQUdfgOh2qFbbkA1JBUu1
	 MElO6lApEIM3w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 1/4] perf tools: Don't set attr.exclude_guest by default
Date: Sun,  1 Sep 2024 18:46:18 -0700
Message-ID: <20240902014621.2002343-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902014621.2002343-1-namhyung@kernel.org>
References: <20240902014621.2002343-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exclude_guest in the event attribute is to limit profiling in the
host environment.  But I'm not sure why we want to set it by default
cause we don't care about it in most cases and I feel like it just
makes new PMU implementation complicated.

Of course it's useful for perf kvm command so I added the
exclude_GH_default variable to preserve the old behavior for perf kvm
and other commands like perf record and stat won't set the exclude bit.
This is helpful for AMD IBS case since having exclude_guest bit will
clear new feature bit due to the missing feature check logic.

  $ sysctl kernel.perf_event_paranoid
  kernel.perf_event_paranoid = 0

  $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
  switching off PERF_FORMAT_LOST support
  switching off weight struct support
  switching off bpf_event
  switching off ksymbol
  switching off cloexec flag
  switching off mmap2
  switching off exclude_guest, exclude_host

Maybe Apple M1 users will scream but actually the default event for
perf record was converted to "cycles:P" which doesn't set the
exclude_guest bit already.  So they need to specify the necessary
modifier manually like "cycles:PH" and I think it's ok.

Intestingly, I found it sets the exclude_bit if "u" modifier is used.
I don't know why but it's neither intuitive nor consistent.  Let's
remove the bit there too.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c                   |  1 +
 tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
 tools/perf/tests/parse-events.c            | 18 +++++++++---------
 tools/perf/util/parse-events.c             |  2 +-
 tools/perf/util/util.c                     | 10 ++++++++--
 tools/perf/util/util.h                     |  3 +++
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 692267b1b7e8..ca94dd3de04d 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
 
+	exclude_HG_default = true;
 	perf_host  = 0;
 	perf_guest = 1;
 
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index 576ec48b3aaf..8ce6f0a5df5b 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -37,7 +37,7 @@ precise_ip=0
 mmap_data=0
 sample_id_all=1
 exclude_host=0
-exclude_guest=1
+exclude_guest=0
 exclude_callchain_kernel=0
 exclude_callchain_user=0
 mmap2=1
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index edc2adcf1bae..9179bf3084c3 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -932,7 +932,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -947,7 +947,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 			if (evsel__has_leader(evsel, leader))
@@ -1072,7 +1072,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -1222,7 +1222,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -1437,7 +1437,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1453,7 +1453,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
@@ -1468,7 +1468,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1497,7 +1497,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1513,7 +1513,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fab01ba54e34..ab73b3d45f04 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1739,7 +1739,7 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 		if (mod.user) {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
-			if (!exclude_GH && !perf_guest)
+			if (!exclude_GH && !perf_guest && exclude_HG_default)
 				eG = 1;
 			eu = 0;
 		}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 9d55a13787ce..7e3159faaa19 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
 
 bool test_attr__enabled;
 
+bool exclude_HG_default;
+
 bool perf_host  = true;
 bool perf_guest = false;
 
 void event_attr_init(struct perf_event_attr *attr)
 {
+	/* to capture ABI version */
+	attr->size = sizeof(*attr);
+
+	if (!exclude_HG_default)
+		return;
+
 	if (!perf_host)
 		attr->exclude_host  = 1;
 	if (!perf_guest)
 		attr->exclude_guest = 1;
-	/* to capture ABI version */
-	attr->size = sizeof(*attr);
 }
 
 int mkdir_p(char *path, mode_t mode)
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9966c21aaf04..d33ae883a54f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
 
 extern const char *input_name;
 
+/* This will control if perf_{host,guest} will set attr.exclude_{host,guest}. */
+extern bool exclude_HG_default;
+
 extern bool perf_host;
 extern bool perf_guest;
 
-- 
2.46.0.469.g59c65b2a67-goog

