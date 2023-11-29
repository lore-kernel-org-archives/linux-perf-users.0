Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DA2CCB8
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA1aly/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C68C433CC;
	Wed, 29 Nov 2023 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701272854;
	bh=FaUbZPDs3dt6xgm6CO9qGb61yKAwRh5X/pwZrBp62xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VA1aly/Fp3gSP7LuZ7/s+dY+PMxJDAQaobgrt25L9Z2lj9nKsxjpPMhA4rxS9xxaA
	 RwW+biJB+8E0Q2gMYVyOM0fc7v3XJTbW+MGqzxQzcxInr0Uh5lAzNU2upoQSScrtn4
	 /4Yy64W9X7bjutY3VQjCvJ/QWQKBqFohG/zGEZgheOe252paZPs/5L/cu13aVU01mh
	 YGXSal/qgNGpGrxJFYSTNYDzt7khvS3NW6QwwgAs8HL2DVz9sWbcEwvRoqnBCRs9aA
	 CHEP/29AHa7JECcA/V5lpHveTi/s9KDmsVqCQYJBm7hSXlbxquaA1Zr/p/z8EHUNlW
	 6CNgEh42SOmnA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/2] perf test sigtrap: Generalize the BTF routine to reuse it in this test
Date: Wed, 29 Nov 2023 12:47:17 -0300
Message-ID: <20231129154718.326330-2-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129154718.326330-1-acme@kernel.org>
References: <20231129154718.326330-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Move the part that loads the BTF info to a "btf__available()" that will
lazy load the BTF info so that if we need it for some other test, which
we will in the following cset, we can reuse it.

At some point this will move from this specific 'perf test' entry to be
used in other parts of perf, do it when needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sigtrap.c | 60 +++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index 1de7478ec1894d77..a1bc7c776254ed2f 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -57,36 +57,51 @@ static struct perf_event_attr make_event_attr(void)
 #ifdef HAVE_BPF_SKEL
 #include <bpf/btf.h>
 
-static bool attr_has_sigtrap(void)
+static struct btf *btf;
+
+static bool btf__available(void)
 {
-	bool ret = false;
-	struct btf *btf;
-	const struct btf_type *t;
+	if (btf == NULL)
+		btf = btf__load_vmlinux_btf();
+
+	return btf != NULL;
+}
+
+static void btf__exit(void)
+{
+	btf__free(btf);
+	btf = NULL;
+}
+
+static const struct btf_member *__btf_type__find_member_by_name(int type_id, const char *member_name)
+{
+	const struct btf_type *t = btf__type_by_id(btf, type_id);
 	const struct btf_member *m;
-	const char *name;
-	int i, id;
+	int i;
+
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		const char *current_member_name = btf__name_by_offset(btf, m->name_off);
+		if (!strcmp(current_member_name, member_name))
+			return m;
+	}
+
+	return NULL;
+}
+
+static bool attr_has_sigtrap(void)
+{
+	int id;
 
-	btf = btf__load_vmlinux_btf();
-	if (btf == NULL) {
+	if (!btf__available()) {
 		/* should be an old kernel */
 		return false;
 	}
 
 	id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
 	if (id < 0)
-		goto out;
+		return false;
 
-	t = btf__type_by_id(btf, id);
-	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
-		name = btf__name_by_offset(btf, m->name_off);
-		if (!strcmp(name, "sigtrap")) {
-			ret = true;
-			break;
-		}
-	}
-out:
-	btf__free(btf);
-	return ret;
+	return __btf_type__find_member_by_name(id, "sigtrap") != NULL;
 }
 #else  /* !HAVE_BPF_SKEL */
 static bool attr_has_sigtrap(void)
@@ -109,6 +124,10 @@ static bool attr_has_sigtrap(void)
 
 	return ret;
 }
+
+static void btf__exit(void)
+{
+}
 #endif  /* HAVE_BPF_SKEL */
 
 static void
@@ -221,6 +240,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 	sigaction(SIGTRAP, &oldact, NULL);
 out:
 	pthread_barrier_destroy(&barrier);
+	btf__exit();
 	return ret;
 }
 
-- 
2.41.0

