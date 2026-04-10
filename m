Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C32EB5A1;
	Fri, 10 Apr 2026 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781687; cv=none; b=egEvms2KRqUf1w6gjJzssyFjQClSI5TKo6vwYtHlbU0+7S8HDP4FeI1S7s/yIv4e9Zmv9pNzOeRDk0Aj17lg2Emm4Z6yHGpzg9lRjeR1HcA6u+naPBGk580ao+CYQw8E2oCHFg3lC8tharruK/Y4MIHe+LWGE9776+P28H24dzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781687; c=relaxed/simple;
	bh=I5wH84ne+msWd16qa86r2JztEi9n3JfJCGkKESKylck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ragazyHTTiGkjinaZo9LiBguoXDS59TjA07E7oNnowduHg4SpgmtHuiMAuwm3Wy1z+z5VYUgRBWrZyyHYUo0E3JUnOfr/uVqDs27cW05DsVGCxVVCRqVlcuPpHL5DDuAQN19HNQzhOdryXaT/g2fdBzkI4DVlFDDSOGJJcM6gvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+52n158; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+52n158"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080F7C2BCAF;
	Fri, 10 Apr 2026 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781686;
	bh=I5wH84ne+msWd16qa86r2JztEi9n3JfJCGkKESKylck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+52n158dv6rdAJUc0tR/zmsW6mGUrbxK04xNV/ifIxJ3Z8xmcTir08sW2ovHr3Is
	 RrXftgfIpYdAU8Y5rLDfZjnSnktRpL6UzHmE9voDfWL0WI+4BOQR8cWkWAWCCHqVum
	 cHBG1sqqqzprepp0Fg0WfSBGCIn4WJNuu6NuJrEIr6296dLJuI+tgvCwdm5rq+TFEf
	 aYSx7JsAPcniZHrvK9lOYyA4Ay2hbze7ANqpO7TVJ/CoeSY9qcIxEuCrtQNe++3jNB
	 9VHNPFwhODAnGnHKCYoeU3Uy/plgzAS6mZC4fm0ujUSVqr8RnipN3GX9sKLTRSbLTw
	 MK7G7pfmFTrnw==
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
Subject: [PATCH 12/13] perf header: Sanity check HEADER_BPF_PROG_INFO
Date: Thu,  9 Apr 2026 21:39:59 -0300
Message-ID: <20260410004000.148138-13-acme@kernel.org>
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

Add validation to process_bpf_prog_info() to harden against malformed
perf.data files:

- Upper bound on BPF program count (max 131072)
- Upper bound on per-program data_len (max 256MB)

Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 03426132e58dc933..628d091658c8c40e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3522,6 +3522,19 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 	if (do_read_u32(ff, &count))
 		return -1;
 
+#define MAX_BPF_PROGS 131072
+	if (count > MAX_BPF_PROGS) {
+		pr_err("Invalid HEADER_BPF_PROG_INFO: count (%u) > %u\n",
+		       count, MAX_BPF_PROGS);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + count * (2 * sizeof(u32) + sizeof(u64))) {
+		pr_err("Invalid HEADER_BPF_PROG_INFO: section too small (%zu) for %u entries\n",
+		       ff->size, count);
+		return -1;
+	}
+
 	down_write(&env->bpf_progs.lock);
 
 	for (i = 0; i < count; ++i) {
@@ -3539,6 +3552,13 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 			goto out;
 		}
 
+#define MAX_BPF_DATA_LEN (256 * 1024 * 1024)
+		if (data_len > MAX_BPF_DATA_LEN) {
+			pr_warning("Invalid HEADER_BPF_PROG_INFO: data_len (%u) too large\n",
+				   data_len);
+			goto out;
+		}
+
 		info_linear = malloc(sizeof(struct perf_bpil) +
 				     data_len);
 		if (!info_linear)
-- 
2.53.0

