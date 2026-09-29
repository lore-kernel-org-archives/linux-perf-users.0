Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F72BDC0F;
	Tue, 29 Sep 2026 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644310; cv=none; b=tu9y5Us8BbvQp8UoXKh7vaDgdmbqRyo8Oc0CsoVonG0xpkX7nBe0ZhMdTciA5q/z5sDt1XpQNhVhxcDJk9jK8g8XFSVDm5z2N2rrgWwRpq3ZpDxD9b5qto9yajdumxDxungrXRsACzmV2hroUR8XPK7cHzZ4f4XCmVOkthYZt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644310; c=relaxed/simple;
	bh=18Djt8dYO3QiVHynPo3hB9gIagUVfA8ugDtT5B0G0vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F01J7MWAad883Ry7536JLFgRFiQVv3OZSqb+usRwE0KI9+QArGLKQmP0++lCgW3AToVAWuSsch2muG0lqtSW9bIwZ6+H2o+GmU0jHnU0nYa2IdT2XcUYLyUxqj2ashJIIsQvkiUx8KUVZ8KzuLjg8Oewzx4eNEmd6vmxzTeTkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KarE43qM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KarE43qM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2611F000FF;
	Tue, 29 Sep 2026 01:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644309;
	bh=hUR86lBmsadyYk8/+3bcb1Ps4lRyzHJyJ5U9V0WTvOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KarE43qM2JUUFp/4nqTZyepsmI3J2wMBK1BtWazUYPfuWVPGX1vMlxBfC0Y5N0JH9
	 c04ABAB/b+vpnIxpq9xF0MzXSzypHdXtrFTJZQooSinZa7Uk9c29BDM5+N2yxbTWyo
	 WUE3t2BUefVFevELRWPYFmTCqrIx8FJcPyKpF+c08hEhTfOMLnEZqGAoO2DE88+9qt
	 dCMi2N6xdg1pQ0aacUTALiUJ8tsJvuF/CY+zmyx/x2wLa+vXDzf8etCy+ImHKm6oNq
	 +fODdUoqoqEG5iyY2kYxw7bXkalsF0614Qb/qWZoNDHl8bWdBko2E7yPpSgs4lPo0w
	 ib7xDWAgl6kPA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 1/8] perf tools: Add dso->dbginfo_type field
Date: Mon, 28 Sep 2026 18:11:32 -0700
Message-ID: <20260929011139.53242-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929011139.53242-1-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It saves where the debug info is available for the given DSO.  It's
sometimes different than where binary data or symbol table is located.
So let's add a new field to save the info.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c |  1 +
 tools/perf/util/dso.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 11db461f2032bc41..90a6f661278a9c81 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1721,6 +1721,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
+		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->is_64_bit = (sizeof(void *) == 8);
 		dso->loaded = 0;
 		dso->rel = 0;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e7d5f4bbf89497c0..34d187d1fc00efdc 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -328,8 +328,14 @@ DECLARE_RC_STRUCT(dso) {
 	enum dso_load_errno	load_errno;
 	u16		 long_name_len;
 	u16		 short_name_len;
+	/*
+	 * DSO file data can be spread into multiple places.  Distros usually
+	 * place debug info to a separate file.  Symbol tables may exist in
+	 * the binary or the debug file.  Let's separate them.
+	 */
 	enum dso_binary_type	symtab_type:8;
 	enum dso_binary_type	binary_type:8;
+	enum dso_binary_type	dbginfo_type:8;
 	enum dso_space_type	kernel:2;
 	enum dso_swap_type	needs_swap:2;
 	bool			is_kmod:1;
@@ -997,6 +1003,16 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 	return is_guest_kallsyms_pid_name(name);
 }
 
+static inline enum dso_binary_type dso__dbginfo_type(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->dbginfo_type;
+}
+
+static inline void dso__set_dbginfo_type(struct dso *dso, enum dso_binary_type bt)
+{
+	RC_CHK_ACCESS(dso)->dbginfo_type = bt;
+}
+
 bool dso__is_object_file(const struct dso *dso);
 
 void dso__free_a2l(struct dso *dso);
-- 
2.55.0

