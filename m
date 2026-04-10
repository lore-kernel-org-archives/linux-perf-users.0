Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F133E0259;
	Fri, 10 Apr 2026 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859008; cv=none; b=uaia6nXTQlgDBp8asSYT1zy/A6Vd5y50pzit8ohyUL58t6PH6DORTyvwgUHE1PC/i+5jhKnHbtNm3z9cQF1FpBg0Z3iTdSyQ9jzpZRO6ahJdG0YhjAkFkfAv8xFAFFQeCUndT0vAwYtSPhVjl3x8v5NeLwku5cSF+XuWrbiI6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859008; c=relaxed/simple;
	bh=SVo3R3WcxD6tKYAhSh+q4Dq63jZnP4Dt711T1CWLA5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP2MsPABl3/JogXKmeM4+HeFdf3yZYi2i+esIFLCS855wtzAP/30BzAEnQYWuMnyMWd9YmPDw4lJOVRRaWCAaL2CsfPhcYDGDS7uVQisZyEixrLuRk+XV+cXNMdSe8f9u3Sy/NEShgeNXbD9xTXMxMV1Do+txRtbMAD8VU4Bhww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx+Hig+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx+Hig+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47E0C19421;
	Fri, 10 Apr 2026 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775859008;
	bh=SVo3R3WcxD6tKYAhSh+q4Dq63jZnP4Dt711T1CWLA5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fx+Hig+4WuWOLODjjQEJRvd4wysGljxFWgCsStdd8q1+UZjfTnASLZybs0/ir/v2g
	 gxMkKqtpD+XLILhXbgpzAhXHpNn/1KwZGtblRccuPryVdcwoedUeFjI6Lj/IF11Zyj
	 FmZXKC1t+g1t/lRlWb5WlRkt4RnRXNz8MYD43L30I2qvrmb+XcmV/Ne5/XxZAuaodJ
	 MlEjR1XN5e1r9icDu656tyA2VVXNEoOc8mbd8/OE4gumnf7GfdxiBqLj1fy2ZZJ0Fk
	 8oHyHskeS+MgMttHKiVGPLn2cfWoTHGc3I9ZCJrWf93lzly03Hs0Tq5AGEPv2ArHR3
	 6mK13TncuFLww==
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
Date: Fri, 10 Apr 2026 19:09:05 -0300
Message-ID: <20260410220905.200051-14-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
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
index 705f1ab44bc93486..f30e48eb3fc32da2 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3622,6 +3622,17 @@ static int process_bpf_btf(struct feat_fd *ff  __maybe_unused, void *data __mayb
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
@@ -3632,6 +3643,12 @@ static int process_bpf_btf(struct feat_fd *ff  __maybe_unused, void *data __mayb
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

