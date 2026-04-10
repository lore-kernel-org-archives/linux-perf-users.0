Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981BFF9E8;
	Fri, 10 Apr 2026 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781665; cv=none; b=IveAJVA75HrF9oYTvsk6s0DXLiy0TyG8VIRCbKsZEpyYEpUR5orTNE51x5gh+wbTq9xcKa9OIbJ5qg7LaKovvxCDpZcUEu0Ez9la1KkZBX0HhvoF0x3sUR1I32oyg4O5R1NGdqO9VWTwdtsvwBNoo6crvZ894yDYQyDSiJQQFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781665; c=relaxed/simple;
	bh=J6pfbxHxQLDL7TxpbgBQsOkgpWk08x9y63tTQ4+L6Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyQQKoonVinxSbi+txzWKg7b6xabDDSt61eIPtCx57oOb3Taw8I+FEIpmbLHjk0v2MUD+8n027FU0/NvuTPRb2eVeZjqJBaOKBmDzF3CR1uAZnLVtqRu3fuGKAmsmLcjEEFYlfyHXePhIM6UoCBS7hzAiIx7wa4E5xgRT5+kYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSXFqK3d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSXFqK3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C5CC4CEF7;
	Fri, 10 Apr 2026 00:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781665;
	bh=J6pfbxHxQLDL7TxpbgBQsOkgpWk08x9y63tTQ4+L6Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSXFqK3dgLHqhvQCpuiDfbaaoGJsOAtsvmom2lCZJKHW1PP7zEwBEl4hpizc4TXZb
	 18UMtlmTsDVS3EvfPBgAZMrZSUWkMg8Jayri+rC4KVmJ3ge4nkJrs1Sk0qGo+jWU4a
	 7CuaLyYtjplB8UwktvFFjr+HtJP3X54P0VM3199w0Zez3zm5cyxDMkm+aNLOWfCpn7
	 uqDPQKXIxsFvvzTZjavkrQ79Wh9Ddb6j1l+IdBi9XPhxwr3dghiyZQXtX2fdwwCBtY
	 oMGHEnmvK2L669C/ZScsF/Kb9Q9opyPJKZp9ue21Q1/mAcK2OPgkuakjuyW4RqDc5/
	 mgO+V1M+GMivg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/13] perf header: Sanity check HEADER_GROUP_DESC
Date: Thu,  9 Apr 2026 21:39:55 -0300
Message-ID: <20260410004000.148138-9-acme@kernel.org>
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

Add upper bound check on nr_groups in process_group_desc() to harden
against malformed perf.data files (max 32768), and move the env
assignment after validation.

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1d7ca467acf32bd4..8e3f4655fbacc6dd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3130,12 +3130,26 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr_groups))
 		return -1;
 
-	env->nr_groups = nr_groups;
 	if (!nr_groups) {
 		pr_debug("group desc not available\n");
 		return 0;
 	}
 
+#define MAX_GROUP_DESC 32768
+	if (nr_groups > MAX_GROUP_DESC) {
+		pr_err("Invalid HEADER_GROUP_DESC: nr_groups (%u) > %u\n",
+		       nr_groups, MAX_GROUP_DESC);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + nr_groups * 3 * sizeof(u32)) {
+		pr_err("Invalid HEADER_GROUP_DESC: section too small (%zu) for %u groups\n",
+		       ff->size, nr_groups);
+		return -1;
+	}
+
+	env->nr_groups = nr_groups;
+
 	desc = calloc(nr_groups, sizeof(*desc));
 	if (!desc)
 		return -1;
-- 
2.53.0

