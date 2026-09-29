Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D53CE497;
	Tue, 29 Sep 2026 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644314; cv=none; b=XxYWjrmvLlcEaUq12/9RhNS5m5GPJ2LvKm8a9/INHirzHrGqtQK9se+WvdrG+77zXm1TS46MdTI2ZQfyarBMtOeqHx9nQDt/iePj6Fw7l1tTIThhaq2XH7lSiB+VN9CkUsG/u+E3QV/i8XqSKDNLClNzdR2iwyLbEneTVVVz1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644314; c=relaxed/simple;
	bh=eoXQhYN9sMeU8p/1bzfJWZhikmZV1NbIKCRDyuZuUVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqBWzUEMfSSCIuVV0X21dXsLhfTtbMG6WJZTuePqULfawjqgZw0C/TmsVDrblUzIdcsHgkuhu0idpBuKMdOHfX30dNKv6UHIOJABF9BfBIWPC11YJXZAlUecnmd+MRaRwPoOvuvO+3/xLwNMaUYW3W1FtggvV7NqfM8Gab02h4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBkofa6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBkofa6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C991F0089A;
	Tue, 29 Sep 2026 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644312;
	bh=eq90R1hVuWY8HBR+un5hjA8xdBkid34HhaZV9UnHVmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GBkofa6GTJr1rsNS5l9q7KvFR8Lp6kmdnRzoS7VGJo09Do4lUiwnhFJIw83rUqXzi
	 R+soM+qiI+mkJCYgMVrTKoVJ2y4+lCbEtDw7e93j5sNxymhRayy3WZpMJPcQC/9GE5
	 DnV70LOZkcTu0ErnY8ESWycD7CPzyRvcOIqGbiasPtEdfwMzEv/zMkQxbRmSkZZr4y
	 O/cYjbK3gVUMiismHN7PMbbgMFdoqiyJaa99ibASngqElJGjUwlPhbzduvykDZeTkf
	 jJRtmXintkW/RSqln/jrqy7+4MNtdP+YoAK4LULHJEwNEpb0muIeZ6veI2Xr0zsOCm
	 78LmaWcUIwtrA==
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
Subject: [PATCH v2 7/8] perf tools: Looks symbol file first when check debuginfo
Date: Mon, 28 Sep 2026 18:11:38 -0700
Message-ID: <20260929011139.53242-8-namhyung@kernel.org>
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

There's a high chance that the file containing the symbol table also has
debug information.  Let's check that first before other locations.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f7a786e0c3cf6a29..e4a2a0ea38823b5f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2133,6 +2133,20 @@ void dso__find_dbginfo_type(struct dso *dso)
 		return;
 	dso__set_debuginfo_searched(dso);
 
+	/* Maybe debug info is in the same file with the symbol table */
+	path = dso__get_filename(dso, "", &decomp, dso__symtab_type(dso));
+	if (path) {
+		found = filename__has_section(path, ".debug_info") ||
+			filename__has_section(path, ".zdebug_info");
+
+		dso__put_filename(dso, path, decomp);
+		if (found) {
+			dso__set_dbginfo_type(dso, dso__symtab_type(dso));
+			return;
+		}
+	}
+
+	/* Otherwise check distro debug locations */
 	for (type = dbginfo_types; *type != DSO_BINARY_TYPE__NOT_FOUND; type++) {
 		path = dso__get_filename(dso, "", &decomp, *type);
 		if (path == NULL)
-- 
2.55.0

