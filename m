Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613B3E0259;
	Fri, 10 Apr 2026 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859004; cv=none; b=Rte4WSSPVfC2qVN8AIIsklAk/FC1LK0eDofAwr8Z6psHoxRB2N5DXomOEZXt3NiL2Zp8Smg2hhB2McTa5ctCxYJ1kT8tuLIXovKQlxkirfepvh5r3EZK61NNeCMDK3uoKmZRhzKJAPpDBDUQxmmB0AYgVL5hn4FGSqJ45sk2wHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859004; c=relaxed/simple;
	bh=blZeH2Qw9AjfE50oYXpvhhJWGNn8yGA9s1VmBHAPuh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbTi7BV8Ond5i3uDqAFzxEy6vDfWZVRC87J+2ktMVwFY/gXO2f8LBnlcRkl1Dh9vWSRxUXTePb1ZryUUAkz8CeWY3BlRI+nw3Njus5AeypuAg9GaFBdme+7DPq92wzGLPmd9szbG54j3XLm1p3pP4SE2IOd1YiXYdwV1jQJf2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNxwe/hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNxwe/hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5EFC19424;
	Fri, 10 Apr 2026 22:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775859004;
	bh=blZeH2Qw9AjfE50oYXpvhhJWGNn8yGA9s1VmBHAPuh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNxwe/hwy0n8+mhKvBqXYYn1qBGr+QvbnpCuh1zgMIePzAWiRE2j5Ovyy6vcVDAt+
	 GdbThvvh9YpVfM5/3NaIYcpp6CaS6rUEPEXlRjH2J7F1rTSUclueWBhIjQ0OKzhg1e
	 3+L3t08dh/YdKf98LiksuJa/1wtYHwyjq4OepXYW8dhMN2dayyRNwxDEsibcnoxwWP
	 rLjEkTts6JaG9sK7BSp96GOFsF8pUskIZwhWhJScWpWZKl3Jy59rg2T4lK2MH5A11v
	 UwO+ByDw/X0NaMoTOLRSAKjMJRpMknvj7VFSoanOQcLB2cRnoRXITinvmvhee9n1Sj
	 AhU57AqfqAY6Q==
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
Date: Fri, 10 Apr 2026 19:09:04 -0300
Message-ID: <20260410220905.200051-13-acme@kernel.org>
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
index 37c1afbc081672f1..705f1ab44bc93486 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -63,6 +63,8 @@
 #include <event-parse.h>
 #endif
 
+#define MAX_BPF_DATA_LEN	(256 * 1024 * 1024)
+#define MAX_BPF_PROGS		131072
 #define MAX_CACHE_ENTRIES	32768
 #define MAX_GROUP_DESC		32768
 #define MAX_NUMA_NODES		4096
@@ -3525,6 +3527,18 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 	if (do_read_u32(ff, &count))
 		return -1;
 
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
@@ -3542,6 +3556,12 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 			goto out;
 		}
 
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

