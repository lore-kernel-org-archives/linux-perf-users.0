Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536A3B9D96;
	Tue, 29 Sep 2026 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644311; cv=none; b=bAPXn2IJpiNxYOikeuuatG6ctwZsPls0uje4njwxXa+pMEPByR2VS0QAO12UYrA/5NtbWkBgOAu0DR2D/CUyVBDrwNFNcOwe6x6Zc5MLhhyiTsJvYQZJNicO+sgL8XWfz4N4izCEQwj9vkkUcQobPHDt2otzjyMeh6WTaj9VYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644311; c=relaxed/simple;
	bh=DbxqdctmvGkNfnXBKKvs2hivk5pylbisRQ3ZkP+b8PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUUKBw8Wznu/FYaa+JaY59zUEt7YxwHvtmMfbWINnjXcz2UMOxZJkm7vAwswK9bKCMsraXhMpn8WkaRHRi48ZrYZhxMVh1Lw32t259YctNseaHS/0mhlkS32jZKXh0NKvDN4ANKpbNuvhvqCwE4ANTnuEHLuYhz80YgMkWhtrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frg9Ftou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frg9Ftou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925581F00899;
	Tue, 29 Sep 2026 01:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644310;
	bh=T1pMpqpCV4ae5fxBOaC1Iu1tpef3aO4iiXQBXZ9wrak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=frg9FtouPQ7/kResTa5fGXhDoBWf9k7GlyDNx62LZd4hNbr5tHi6X0qDDNdEJZgSK
	 cfxTWnpizbpPvKpaLGuJaf0DM7xJjYC6Hfs0cmvu+qM4GAMAT4ZHB/rbAL/+lFsf6l
	 6Jbe00wRuTAGKrRAma52ZZ4OQ/5RbIZjqzB9vORJXULpbaeEfwmzhYigZrDX1H+XC/
	 TD2xA30seARtCrRKuCXkhtiaKN3lTHnb+oC4LUSeYuxyIr8qyH7h52IdxXaZiioTRy
	 g54lIyygt9/vT5WTMJ5KesMN1MROHRD63SI0dWck/q+nngrM6mjzp+USFLSMeBHFMb
	 ON/i6nqr5/NMA==
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
Subject: [PATCH v2 2/8] perf tools: Factor out dso__find_dbginfo_type()
Date: Mon, 28 Sep 2026 18:11:33 -0700
Message-ID: <20260929011139.53242-3-namhyung@kernel.org>
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

It tries to find a file with working debug info by checking all possible
debug types.  It checks if the file has one of known debug info sections.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c | 23 ++++++-----------------
 tools/perf/util/dso.c       | 29 +++++++++++++++++++++++++++++
 tools/perf/util/dso.h       |  2 ++
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 84a78b30ceac1066..d6bd0fcc22648f0e 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -93,15 +93,6 @@ static struct debuginfo *__debuginfo__new(const char *path)
 
 struct debuginfo *debuginfo__new(const char *path)
 {
-	static const enum dso_binary_type distro_dwarf_types[] = {
-		DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
-		DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
-		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
-		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
-		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
-		DSO_BINARY_TYPE__NOT_FOUND,
-	};
-	const enum dso_binary_type *type;
 	char buf[PATH_MAX], nil = '\0';
 	struct dso *dso;
 	struct debuginfo *dinfo = NULL;
@@ -120,14 +111,12 @@ struct debuginfo *debuginfo__new(const char *path)
 	if (filename__read_build_id(path, &bid) > 0)
 		dso__set_build_id(dso, &bid);
 
-	for (type = distro_dwarf_types;
-	     !dinfo && *type != DSO_BINARY_TYPE__NOT_FOUND;
-	     type++) {
-		if (dso__read_binary_type_filename(dso, *type, &nil,
-						   buf, PATH_MAX) < 0)
-			continue;
-		dinfo = __debuginfo__new(buf);
-	}
+	dso__find_dbginfo_type(dso);
+	if (dso__read_binary_type_filename(dso, dso__dbginfo_type(dso), &nil,
+					   buf, PATH_MAX) < 0)
+		goto out;
+
+	dinfo = __debuginfo__new(buf);
 	dso__put(dso);
 
 out:
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 90a6f661278a9c81..44cfc16cfbe49600 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2108,3 +2108,32 @@ void dso__set_symsrc_filename(struct dso *dso, char *val)
 	dso__set_has_srcline(dso, true);
 	dso__set_a2l_fails(dso, 0);
 }
+
+void dso__find_dbginfo_type(struct dso *dso)
+{
+	static const enum dso_binary_type dbginfo_types[] = {
+		DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
+		DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
+		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
+		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+		DSO_BINARY_TYPE__NOT_FOUND,
+	};
+	const enum dso_binary_type *type;
+	char buf[PATH_MAX];
+
+	if (dso__dbginfo_type(dso) != DSO_BINARY_TYPE__NOT_FOUND)
+		return;
+
+	for (type = dbginfo_types; *type != DSO_BINARY_TYPE__NOT_FOUND; type++) {
+		if (dso__read_binary_type_filename(dso, *type, "",
+						   buf, PATH_MAX) < 0)
+			continue;
+
+		if (filename__has_section(buf, ".debug_info") ||
+		    filename__has_section(buf, ".zdebug_info"))
+			break;
+	}
+
+	dso__set_dbginfo_type(dso, *type);
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 34d187d1fc00efdc..a152957322f6b31c 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -1013,6 +1013,8 @@ static inline void dso__set_dbginfo_type(struct dso *dso, enum dso_binary_type b
 	RC_CHK_ACCESS(dso)->dbginfo_type = bt;
 }
 
+void dso__find_dbginfo_type(struct dso *dso);
+
 bool dso__is_object_file(const struct dso *dso);
 
 void dso__free_a2l(struct dso *dso);
-- 
2.55.0

