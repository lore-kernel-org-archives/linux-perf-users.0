Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC392BEC5F;
	Thu, 11 Dec 2025 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765491494; cv=none; b=XVCnaYSRmqXYiCT3BI4+bpjqhquSMyXjmMrNNabZ/jRE6U9ILxGKrWKwNVNn61H8ledGOJqWP/9J5ciXF+L5pZY3i8I3mlkoJhdhCYexXv2XNxQtwheucq+AvMBi/x36F0VULvGq/qhJ2GyqiDUcdFUJR7k5ODjb6ULdyfgImXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765491494; c=relaxed/simple;
	bh=HN+YbeRKhYRIdIIuxnmwLla4awRI2Nl2a3IsnUvLQIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoNwMFY4TUU9qsFZ/5MhsV2C0korb6NO/MtXOAcU+HIqn3H1lZJ7Vu134EqZ4Cwu+/tXo0evWxUokNrbFo/RT91bDiyyZxjS+PUdpBTl/I3k1zqrGaDHO7x1KWT2lLI5L7GKzrs4FoU/iOwNBMx4mM4NRc+9v7Er4PkAKGhRdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYATVGUI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYATVGUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0F5C113D0;
	Thu, 11 Dec 2025 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765491494;
	bh=HN+YbeRKhYRIdIIuxnmwLla4awRI2Nl2a3IsnUvLQIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYATVGUI4DSWrv5gl8k8u3sKP9y6Y38ZeRQ9kIEHRhCuHRSbCeFOavGGcNtSQ7fcu
	 MmoXGH7S7X1GgNumXY7/0b8RG277WNUuKP2DjqbgwFkD035p4qCoPJBArA3nOGsjXJ
	 6J6QGFdxjPQp8O+KH1cbL3Veaf4B6E0WpPydyYZ1WomrZw3pI4gjL8waChmpdAtlpo
	 fEfr/K2KhJpUBMIsM1cN4Wkd4+D3fbZU/lN0M7Rf4x3tu0IBDrD5X82AdiOo1aUKAV
	 wEs0wUJzsr3V2A9oOauCk1zjE1Ql03iJpdMDQSmAeSWXVEC028yd6BmRG80tWRD4Su
	 jvkWJWBx/6hNg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/4] perf tools: Use const for variables receiving str{str,r?chr}() returns
Date: Thu, 11 Dec 2025 19:17:55 -0300
Message-ID: <20251211221756.96294-4-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211221756.96294-1-acme@kernel.org>
References: <20251211221756.96294-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer glibc versions return const char for str{str,chr}() where the
haystack/s is const so to avoid warnings like these on fedora 44 change
some variables to const:

  36     8.17 fedora:44                     : FAIL gcc version 15.2.1 20251111 (Red Hat 15.2.1-4) (GCC)
    libbpf.c: In function 'kallsyms_cb':
    libbpf.c:8489:13: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     8489 |         res = strstr(sym_name, ".llvm.");

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/jvmti/libjvmti.c     | 2 +-
 tools/perf/tests/parse-events.c | 4 ++--
 tools/perf/util/evlist.c        | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index 82514e6532b8c3af..87bfd4781003a331 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -142,7 +142,7 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
 	*/
 	if (*class_sign == 'L') {
 		size_t j, i = 0;
-		char *p = strrchr(class_sign, '/');
+		const char *p = strrchr(class_sign, '/');
 		if (p) {
 			/* drop the 'L' prefix and copy up to the final '/' */
 			for (i = 0; i < (size_t)(p - class_sign); i++)
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 128d21dc389f869b..2bd6229721145e42 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2609,8 +2609,8 @@ static int test_events(const struct evlist_test *events, int cnt)
 	for (int i = 0; i < cnt; i++) {
 		struct evlist_test e = events[i];
 		int test_ret;
-		const char *pos = e.name;
-		char buf[1024], *buf_pos = buf, *end;
+		const char *pos = e.name, *end;
+		char buf[1024], *buf_pos = buf;
 
 		while ((end = strstr(pos, "default_core"))) {
 			size_t len = end - pos;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 03674d2cbd015e4f..64951962854104a5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1945,7 +1945,8 @@ static int evlist__parse_control_fifo(const char *str, int *ctl_fd, int *ctl_fd_
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close)
 {
-	char *comma = NULL, *endptr = NULL;
+	const char *comma = NULL;
+	char *endptr = NULL;
 
 	*ctl_fd_close = false;
 
-- 
2.52.0

