Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6886DDC5;
	Sun, 10 May 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384095; cv=none; b=Gq5CXZuIGhxJKPOciFSP3EJw1bVmZ1ZioYkibyCAm4Z7YC0jEhd3LajLNzoTH+JCcWb05f8iud8h/dV0p2zriruiUwh2YnBbma6HwJIL8jT3pM3cxtj7PlugFfoCD/BlQh7B+Uy/6qLDkzxsIhd0lgfaPuOHNipWX+pEhTVkx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384095; c=relaxed/simple;
	bh=d9DVuMkw2hxA1ZIVbwDnE4Xvxc7Ogkae7qqqjfx3sRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJgp+D3FWY9SPq3SyKNgHJZGDWZpYPNKkzEdlU4MIKYNvOi14gebQabvOvUeGE1hK7U6Vh0wKWgz/kmJAOBcu0Lzpbnffou1tU8aJCuIyQvdvLrtFRmMtIekYY9Hf39GviqBx/jIzUS0GPn+vuA+cmjRf2Vb+R0rAL3oOe1M80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfV2ayvO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfV2ayvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA07FC2BCB8;
	Sun, 10 May 2026 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384095;
	bh=d9DVuMkw2hxA1ZIVbwDnE4Xvxc7Ogkae7qqqjfx3sRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfV2ayvOPqleAp61Ghu6YwTZvGKIc1BlJw2iTl2YoP6RLrhb+L66e92XnEt6qtBgJ
	 oIPEya/GYw6TPjY45TrMayrjpJZaZOZC5LxCVpZJnePrVEQ1proYVYslzFWfVabxpY
	 yEkOfOxhXggDzameqyFytjbQ11c33WdPBacOp1RtelXJAISrwK4a+2M5aAfKmxmxUI
	 ckGcr2aaup3xc/lxwCtJ9R8Rw/zpfvBgX5qoPxTGbOYuu91c8jcxrZX5kLPBxLJ1o/
	 aFVRrxniC3CWQ3OOQpbokSKKqxAinicwfjCM2HARVP6QS9c1UvUUzm+lS8gzaev+yI
	 R/7LhR8h4y7Qw==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 04/28] perf zstd: Fix multi-iteration decompression and error handling
Date: Sun, 10 May 2026 00:33:55 -0300
Message-ID: <20260510033424.255812-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

zstd_decompress_stream() has two bugs in its multi-iteration loop:

1. After each ZSTD_decompressStream() call, the code advances
   output.dst by output.pos but doesn't reset output.pos to 0.
   ZSTD interprets output.pos relative to output.dst, so the
   next iteration writes at (dst + pos) + pos = dst + 2*pos,
   skipping a gap and potentially writing out of bounds.

2. On ZSTD_decompressStream() error, the loop executes break
   and returns output.pos (which is > 0 if some bytes were
   decompressed before the error).  The caller checks
   !decomp_size and skips the error, silently accepting
   truncated or corrupted data.

Fix both by removing the output buffer adjustment — ZSTD
correctly accumulates output.pos across calls without it.
Return 0 on decompression error so the caller detects it.
Add a no-progress guard to prevent infinite loops if the
output buffer fills before all input is consumed.

Note: the compressed event data_size is validated against
header.size by a subsequent patch in this series
("perf tools: Harden compressed event processing").

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/zstd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index fde9907cf4768eff..377be0505e50a493 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -111,14 +111,26 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 		}
 	}
 	while (input.pos < input.size) {
+		size_t prev_in = input.pos;
+		size_t prev_out = output.pos;
+
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
 			pr_err("failed to decompress (B): %zd -> %zd, dst_size %zd : %s\n",
-			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
-			break;
+			       src_size, output.pos, dst_size, ZSTD_getErrorName(ret));
+			return 0;
 		}
-		output.dst  = dst + output.pos;
-		output.size = dst_size - output.pos;
+		/*
+		 * Neither stream advanced — decompression is stuck.
+		 * Return 0 (error) rather than partial output: perf
+		 * uses ZSTD_flushStream (not ZSTD_endStream), so the
+		 * stream is continuous across compressed events.
+		 * Discarding unconsumed input would desynchronize the
+		 * decompressor, causing the next call to produce
+		 * garbage that could be misinterpreted as valid events.
+		 */
+		if (input.pos == prev_in && output.pos == prev_out)
+			return 0;
 	}
 
 	return output.pos;
-- 
2.54.0

