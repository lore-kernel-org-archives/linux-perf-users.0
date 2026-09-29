Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AA3BAD89;
	Tue, 29 Sep 2026 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644311; cv=none; b=ISyPvcmkM2XIoi/C7VtVQjewZkL4nBQ53/RKqhisTL4nL/Je7hedut9Vf1LSEQZuRMBY196dd1TIptngo9tXMlU5NaexgnSfVJ4GUl72lTCsV3pOJxcKYpQs61OO3ho0eNozKbQIfUud+xWekPsIZf+c1VljbzvpT/SSPev+nvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644311; c=relaxed/simple;
	bh=ovW17HKw6UnpQxg5++WuAm0L1c+P6qAADrEGKZ2I/zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fT9iyMiMlucDVmkDYA3pBRl5AGl22iCcwZkUwy8TSIr8ss+4BjfHX6n0/R3jMxZqlSv/cRjQU1uhfKnURDzTRyvTqO0TcRbDbgYHeo8/qdb7i8HzNv2twW3dxVNJ6NHv8nCBzt58r2UU+cceYUAxC/yAiU9Pcu6VLynM67NcWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghMADEyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghMADEyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D8F1F00893;
	Tue, 29 Sep 2026 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644310;
	bh=HiQP9iy369M7bSyc4digSFdkLwrCUk0DRioLZOLLzJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ghMADEydTANE+xhyi1Hlj86fQncyApIKi3srcX9P90vfu6Ny86bm4cyTEovJEgfig
	 yOO40UkYv6k6C6tkpkVmHyn/WyIFelS1n5rUWqGtMLEZFRClYL9DMR7SBMT4yDdRIg
	 bLe03RZmvhXKKIfSsDdIlgWYpufxKHHzZi0le/7y+Malk7DMTPOKBhWVBnKfRNqIaZ
	 jUwFOVnyUdV2Ql+nkemRDspX1YOGji8D/nzlO5Nx3QPLrbxVJnyl/FaQzvc/UdhTr6
	 QPAnZqyTAjjJWbh39/pPwvSunbgQWom7+r8fzntc4EBxOr/fgcTlLjAJzKSsGs9h29
	 iKn5hw8YXGgzg==
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
Subject: [PATCH v2 3/8] perf tools: Check system path when check debuginfo
Date: Mon, 28 Sep 2026 18:11:34 -0700
Message-ID: <20260929011139.53242-4-namhyung@kernel.org>
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

The debuginfo__new() has a fallback to try the given path, but it seems
that it can check SYSTEM_PATH_DSO type in the dso__find_dbginfo_type()
instead.

One corner case would be when dso__new() fails in debuginfo__new() but
it should be rare and memory is exhausted.  I think it's fine to fail
for that case.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 44cfc16cfbe49600..ceebb32d0a48a96f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2117,6 +2117,7 @@ void dso__find_dbginfo_type(struct dso *dso)
 		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	const enum dso_binary_type *type;
-- 
2.55.0

