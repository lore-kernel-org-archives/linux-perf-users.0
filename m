Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A83B3BF2;
	Sun,  2 Aug 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680855; cv=none; b=g3/+mxJrrXwMlJMypVO5BkeS+NPc0yRC9koRzf7IDpF/AA/g6zNA+RYqazxVSeVpcMXp1jsTn6DnRLl/u+2wGkBzWJyqpuECOiBWBZQPW8/tdT0whUgHdNGf+LE8UxhmfaNgBIe25oYvTmc9hmQD5/fyrHcAr8by/2km+McYDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680855; c=relaxed/simple;
	bh=x0unN/UQx+AgsfupzIsukpdZ6hVjrnR2Yb7n+UW85dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei3bgbEqqCzqPLytw/h2h7GYU2hmWGIZWhJgfWjn0hkLjTL16oCTi3J3ckfDdaGB/m6aEquyPNzPKY8OkeBs6iZgm32T89wYap6otH4HfR1VyZ/QYocCyu9bn6qnvgK1HjjwhNQQ4CixrxUQDB+8Cy3FHPolFsU+lVwc1y95KMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avj2MTpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avj2MTpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008001F000E9;
	Sun,  2 Aug 2026 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680854;
	bh=RiCwrxeVEM+TddSPFLmqOr/uymJkz7tQ39k0YA6dst8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Avj2MTpErXHcGwYyRC+KCF9G9VW2bK7ObLbK7bXX6HDPUUiZw71tbQIL/vECYT21E
	 AIOL5G3/mCipwutqrSLbcCW6mu+uEoHRS69Pa5U5Pa/5JXLWTs9FOfvy4WS2jpT9mU
	 WHblG9xlMmJ06pTbYagd8rbXwwfxuO2RxBdUcEyNNCYsS2dTKto6yjJNmFYaoKrS85
	 SSVpFcklJutYq/vCE7xOGF4xpbLnNCcuQtyVQquyJ/caGpMcfx3xQMAwZZIHcKCGGR
	 3mVPJcMfsTJ+VIAByb+myxR9YLbjeu34WkUD0bMGecak0xmaoVwOsdlL/3yiv7/YH7
	 CDu/xdeeOSRrw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Song Liu <songliubraving@fb.com>
Subject: [PATCH 3/4] perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_prog_info()
Date: Sun,  2 Aug 2026 11:27:11 -0300
Message-ID: <20260802142712.154726-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142712.154726-1-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

synthesize_bpf_prog_name() unconditionally dereferences prog_tags[sub_id]
(line: u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags))
but __bpf_event__print_bpf_prog_info() only requires JITED_KSYMS and
JITED_FUNC_LENS in its required_arrays bitmask.

If a crafted perf.data has the PROG_TAGS bit cleared (or the array was
invalidated by bpil_offs_to_addr() bounds checking), info->prog_tags
contains either zero or a raw file offset.  Dereferencing it causes a
NULL pointer dereference or an arbitrary memory read.

Add PERF_BPIL_PROG_TAGS to required_arrays so the function returns early
when prog_tags was not present or failed validation.

Fixes: f8dfeae009effc0b ("perf bpf: Show more BPF program info in print_bpf_prog_info()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index fa3ebc8ea7f09cdd..e67f28a8e92bdeb0 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -969,7 +969,8 @@ void __bpf_event__print_bpf_prog_info(struct perf_bpil *info_linear,
 {
 	struct bpf_prog_info *info = &info_linear->info;
 	__u64 required_arrays = (1UL << PERF_BPIL_JITED_KSYMS) |
-				(1UL << PERF_BPIL_JITED_FUNC_LENS);
+				(1UL << PERF_BPIL_JITED_FUNC_LENS) |
+				(1UL << PERF_BPIL_PROG_TAGS);
 	__u32 *prog_lens;
 	__u64 *prog_addrs;
 	char name[KSYM_NAME_LEN];
-- 
2.55.0

