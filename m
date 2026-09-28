Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB13CBE8F;
	Mon, 28 Sep 2026 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574668; cv=none; b=EYBHgfVKWdIabk3ceUmL7b7G6htwTye732fRpzxcVVNLA1tq/kkNfxJhMynvb5ELAOs/cH8d4bBui11N+UkSPR58KJbvdOy006wCgdRv2mwHVSApZoK5gQJ9TJqa6xyRfrUj82wYb9TrSFOa5fPIpmRvkDNidfJidEhpWhVyhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574668; c=relaxed/simple;
	bh=Ey+I2MxKMmpNumOe7tVIfuK2/Ac3YWQEijVNi+Ay4vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOh0yOrHug2lxMeJqM/gFouyTeoviypXrUARoZ0QkcdtTcvz8C4ydqGokw+UFqrrig2Kn0t08LBLuoEx41+oaR/jpSAr//35DHVE4O+32wMnXtrvhau4ALw3wvgfLi9Bn72m4LouRsARlfLGbJK47TkuAO2xZirXCr7+JNv1svM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3sOs7s+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3sOs7s+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB01F00899;
	Mon, 28 Sep 2026 05:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574664;
	bh=k/+KSCZPLkZJ4Pf+BZuilrVbkLtCfeeuYAxm2f+SOFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3sOs7s+obFC/04cTORk5OF6JC4X1WddIzhB32K/chzgFKFtQFsDfHG5Hof0ruwvR
	 a49bWctSdjDo03mhMuEZVqt0lQCK+pXCSza33ZiPu7Oi5cvk0lSSidwrKLBjyubFEg
	 WTqz8XlW/w8A+KBt1hkGOJC8fu/+sZGZZwea8IOy+AIIHXTANdaCuSgMCyNT4sb7DB
	 Bj7pyzQFxxJ1Zt1SPyrW7T71BIzieD6QSQ6uB2O1/rLZXKppV4ixkmmFdbL5jA1/kS
	 geXu2ajiZTmpNwmRORSSlfjVPSvEUGw1NM+L1LRR5+DpMja+MkzrTu1SwIAtj6HD6c
	 aGhQ6XK+pkV5Q==
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v1 3/8] perf tools: Check system path when check debuginfo
Date: Sun, 27 Sep 2026 22:50:50 -0700
Message-ID: <20260928055055.95144-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928055055.95144-1-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debuginfo__new() has a fallback to try the given path, but it seems
that it can check SYSTEM_PATH_DSO type in the dso__find_dbginfo_type()
instead.

One corner case would be when dso__new() fails in debuginfo__new() but
it should be rare and memory is exhausted.  I think it's fine to fail
for that case.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c | 12 +++---------
 tools/perf/util/dso.c       |  1 +
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index d6bd0fcc22648f0e..2669d5f5ee6121d4 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -101,7 +101,7 @@ struct debuginfo *debuginfo__new(const char *path)
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
 	if (!dso)
-		goto out;
+		return NULL;
 
 	/*
 	 * Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO. Don't block
@@ -114,18 +114,12 @@ struct debuginfo *debuginfo__new(const char *path)
 	dso__find_dbginfo_type(dso);
 	if (dso__read_binary_type_filename(dso, dso__dbginfo_type(dso), &nil,
 					   buf, PATH_MAX) < 0)
-		goto out;
+		return NULL;
 
 	dinfo = __debuginfo__new(buf);
 	dso__put(dso);
 
-out:
-	if (dinfo)
-		return dinfo;
-
-	/* if failed to open all distro debuginfo, open given binary */
-	symbol__join_symfs(buf, path);
-	return __debuginfo__new(buf);
+	return dinfo;
 }
 
 void debuginfo__delete(struct debuginfo *dbg)
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 10c4cd35b6d9464b..512f2bb61e8f2a2f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2117,6 +2117,7 @@ void dso__find_dbginfo_type(struct dso *dso)
 		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
 		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
+		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	const enum dso_binary_type *type;
-- 
2.55.0

