Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CD1A2566;
	Thu,  5 Sep 2024 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567869; cv=none; b=KM6l31Isr1ZHt/n5WM1akveNZBcH/j4iMBtikCn8LNj04ZgX+KE6mDEYdKBigGNYBxcGwR6B3sNKTio1T3NHVF+yBDe9XSLdGOeTduJM18yP65DNl7ewdk49+TD0QWiJUO/IAJYERBUOnOyvnU8i/bHPPmgdASmwyxABXcy1PbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567869; c=relaxed/simple;
	bh=gSUbaLQ7uvgo7tFBAaelNB7YgocEIT2lbiYgEKyd2wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7BuDYmyd+Itd5ecmnalHVy+Z17Sr6d9wicII0TkHzp8TQiI5KDM+h/iIOlD/GCd1YJsOYPtCp3H/EgjKGh3Ojn2SKFkDuS97DmBKp+03PznK5JtV0wQqSOIED06IJivy+IeDHNg6rz41TLYzc8w3/DesZREgEnaMYIldBZVTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL8IWHSN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL8IWHSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BA3C4CECD;
	Thu,  5 Sep 2024 20:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567869;
	bh=gSUbaLQ7uvgo7tFBAaelNB7YgocEIT2lbiYgEKyd2wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OL8IWHSNmKRZzwHZFD/pjH7zFKKZvDW+FI8hdAVXnF8sEcECBMtSy3IQAXIWQrFPC
	 91JhU6USByAGMJRYKU+qJtt2D6CkYLZURkfqJO3EVITrzJeyyQ8Eyk0BRSpktW45v+
	 CFmpU2GwqPAJ2xNzbcofdsUKh4OQRrQYxMI7nvsq+Q2A2NfWmgWbCeqyqRQ78PRRzP
	 8+uosM3bsVHhfy8No20OJFa+tkRCnR+f/qJeMO0fZsvzYrlJA+8+lABH+eAt35lpwN
	 JYeAeydXtbtTJfrp5BosW53ZRfqgPPY64JifwjzCI2J6X228RvDRyPsBo2mTrNVcyV
	 1j7AKpRfT6rxQ==
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
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 02/10] perf tools: Don't set attr.exclude_guest by default
Date: Thu,  5 Sep 2024 13:24:18 -0700
Message-ID: <20240905202426.2690105-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905202426.2690105-1-namhyung@kernel.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
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
index 55ea17c5ff02acf7..5e32d4e78fdf2424 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
 
+	exclude_HG_default = true;
 	perf_host  = 0;
 	perf_guest = 1;
 
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index 576ec48b3aafaa6a..8ce6f0a5df5b7013 100644
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
index 639e65a9bf61801a..9077d581c0d05e62 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -933,7 +933,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -948,7 +948,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 			if (evsel__has_leader(evsel, leader))
@@ -1073,7 +1073,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -1223,7 +1223,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -1438,7 +1438,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1454,7 +1454,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
@@ -1469,7 +1469,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1498,7 +1498,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1514,7 +1514,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f5eb1af8302c7bac..8d9e2d4b73822d98 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1761,7 +1761,7 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 		if (mod.user) {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
-			if (!exclude_GH && !perf_guest)
+			if (!exclude_GH && !perf_guest && exclude_HG_default)
 				eG = 1;
 			eu = 0;
 		}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 9d55a13787ce3c05..7e3159faaa1991df 100644
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
index 9966c21aaf048479..d33ae883a54f2f2f 100644
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

