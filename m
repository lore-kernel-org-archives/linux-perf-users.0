Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E982045A1;
	Wed, 12 Feb 2025 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398487; cv=none; b=reLtFSji+3EDU+rX/n0Arr/OxXHKc4br6agrfapcaajNUlyRGi8J43Ah6owJaYyullehgKZxCQhmgcUk/0oiof4FNpTbQkNaEj+/li8O/NWp3T/fhoXvb8K687lkNUT9H0t/zvbYWi409yPQgxwGoPy68cZxQeAtVwOabzDJ4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398487; c=relaxed/simple;
	bh=NZW/9uBsUIjGoRgqr43K+mpay3vj7uS6/3JlM50sCdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzw9eOz4xfO3MTCZVCAaLlqLh8wQijZSfnBB9gWYW1ePlD49JG6juhwUE9v51t9sfYGXdcJdeZEPlwzeLUMEtAAyHzbYWyXQ8M3nssB4QEZRkxqT1+k+r1YSU2Jn2ph7jOMc/f0CnpdWV2D5VOML+f05sMJVGdwm/FqSRMpc5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY3/kzF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY3/kzF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDA6C4CEDF;
	Wed, 12 Feb 2025 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739398487;
	bh=NZW/9uBsUIjGoRgqr43K+mpay3vj7uS6/3JlM50sCdU=;
	h=From:To:Cc:Subject:Date:From;
	b=BY3/kzF0cVm/Vkm6KiKsM1Vc/PK1cnV8tNW3FWMStTVMpTnSl6XgEqQRaJ1YrQI12
	 nNOi4B8lstCJK85H+0LhMTZU+MRcWRRGBc6sVF+gE2v6aUWdw4vYvjcDWJ/pjc4zQO
	 NZXnGslum6p98bvpcT4egXyQnh4I0B3PEF0RWjIRHXSNDewbRbmM4mayG1VNHa1Ptd
	 gwo3pqwnn9JdhzJ9FSMlX5TGLiJySkNp4Nx8ZC5ccjQa2LlPX8qPJDUyuLXtnc5u2d
	 W1NRllTKIMEAN80sltfiBi6m4Kr/bW8MqJfhZZs4ZprkyC+Y8DGH41mB6hmI7NotAh
	 QyrrDdAb2VmFQ==
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] perf tools: Use symfs when opening debuginfo by path
Date: Wed, 12 Feb 2025 14:14:45 -0800
Message-ID: <20250212221445.437481-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found that it failed to load a binary using --symfs option.  Say I
have a binary in /home/user/prog/xxx and a perf data file with it.  If I
move them to a different machine and use --symfs, it tries to find the
binary in some locations under symfs using dso__read_binary_type_filename(),
but not the last one.

  ${symfs}/usr/lib/debug/home/user/prog/xxx.debug
  ${symfs}/usr/lib/debug/home/user/prog/xxx
  ${symfs}/home/user/prog/.debug/xxx
  /home/user/prog/xxx

It should check ${symfs}/home/usr/prog/xxx.  Let's fix it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 19acf4775d3587a4..b5deea7cbdf24620 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -125,8 +125,12 @@ struct debuginfo *debuginfo__new(const char *path)
 	dso__put(dso);
 
 out:
+	if (dinfo)
+		return dinfo;
+
 	/* if failed to open all distro debuginfo, open given binary */
-	return dinfo ? : __debuginfo__new(path);
+	symbol__join_symfs(buf, path);
+	return __debuginfo__new(buf);
 }
 
 void debuginfo__delete(struct debuginfo *dbg)
-- 
2.48.1.502.g6dc24dfdaf-goog

