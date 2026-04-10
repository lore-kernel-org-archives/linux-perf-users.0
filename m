Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B463271471;
	Fri, 10 Apr 2026 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781693; cv=none; b=m+2ahYPzN4GPqufxnB8QUhdYIODMGXxgTgWHZsL/LKMx20v9ZQFJ7XEolZKJd29qnuEqTHp6LKC9Lf88qCNNXO/UVR7ZjHFOegc7RNlucSy94C+fyYKkVMsg6ZeDpPPyMXVjzJrjt0mMzzUi7b82/6QZgBruSA/zvpGc3tsyTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781693; c=relaxed/simple;
	bh=akNYq1Yn19Qgx2qs2DWJrh+BFDtfahAZB0/XJt9XasM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfmTG+5onvfHixBeBck05/4ep3KTfrXGWv+nK+1OJUQWN55m6Vtf6IShqE1IwPstOFnxC9kRsDxRRLMSau2gjwgaMHOjUKRitarDnyJaF6c995g1g+ILEPioRXvNroGFMGpJDtSYV525eRVSl1xPg9twKKRJMjZudMN/d6/ch7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe2deoEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe2deoEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB78C2BC87;
	Fri, 10 Apr 2026 00:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781693;
	bh=akNYq1Yn19Qgx2qs2DWJrh+BFDtfahAZB0/XJt9XasM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qe2deoEIfpWTEW29zU3B9r270MrD6qGYZLhEShJYSVr2mKaagG3ueGfkU6N+UNkhL
	 P0zEpDi/C3YrVmQ7kbFyGxe2AKG9VwZrVHfAhYctNHsBq2D0Z87ieWp5Aw9v0nvp1a
	 5eM9clWp67FFXUYc0Ozb5nsBY4bZdjE/2IXNzRI4UjkA+rGSgzLHUFgWdyu3ZyFaNE
	 2k+iKxLB17wG3zi5zfhxnQwLX4qLHCr+4pX/m70/I+ClZWlhMGpeZjBS4/R9eHJY6/
	 jOvM6ArJIS6Tg+XVlQkXRspNUmYDYgVPsBTt3lh9Psm73/r7SpUxwT/gZDnlxYRO2y
	 qO9fb9Yt4GiVA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 13/13] perf header: Add sanity checks to HEADER_BPF_BTF processing
Date: Thu,  9 Apr 2026 21:40:00 -0300
Message-ID: <20260410004000.148138-14-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Validate the BTF entry count and individual data sizes when reading
HEADER_BPF_BTF from perf.data files to prevent excessive memory
allocation from malformed files.

Reuses the MAX_BPF_PROGS (131072) and MAX_BPF_DATA_LEN (256 MB)
limits from HEADER_BPF_PROG_INFO processing.

Cc: Song Liu <song@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 628d091658c8c40e..f47b040b76292c81 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3619,6 +3619,17 @@ static int process_bpf_btf(struct feat_fd *ff  __maybe_unused, void *data __mayb
 	if (do_read_u32(ff, &count))
 		return -1;
 
+	if (count > MAX_BPF_PROGS) {
+		pr_err("bpf btf count %u too large (max %u)\n", count, MAX_BPF_PROGS);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + count * 2 * sizeof(u32)) {
+		pr_err("Invalid HEADER_BPF_BTF: section too small (%zu) for %u entries\n",
+		       ff->size, count);
+		return -1;
+	}
+
 	down_write(&env->bpf_progs.lock);
 
 	for (i = 0; i < count; ++i) {
@@ -3629,6 +3640,12 @@ static int process_bpf_btf(struct feat_fd *ff  __maybe_unused, void *data __mayb
 		if (do_read_u32(ff, &data_size))
 			goto out;
 
+		if (data_size > MAX_BPF_DATA_LEN) {
+			pr_err("bpf btf data size %u too large (max %u)\n",
+			       data_size, MAX_BPF_DATA_LEN);
+			goto out;
+		}
+
 		node = malloc(sizeof(struct btf_node) + data_size);
 		if (!node)
 			goto out;
-- 
2.53.0

