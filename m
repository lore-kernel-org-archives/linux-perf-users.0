Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44330CDB6;
	Tue,  9 Jun 2026 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967165; cv=none; b=I6rlSCRBoVHlUteRpdmIWDQRmGOLwchYYa4W7iQdDfeyXioF+BwTTCqHK89E6u/tJF4KtnN5Iks/CWo2gr8FQUbIahIqe+FNas7voFmOSAi5Oo4xdKcbljdaikmvgjqOnFS08AOmoFstbPyBqkX4ryqTHXzro9HViGKcbPUD+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967165; c=relaxed/simple;
	bh=0ZkG9lJ93rQ6OkApVo1qEuoMs9PIleG2eZHndPbPSes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW5qR+ZmKB/VWf3/xoDXy9HtcsZGd73KgGxEJdRZ34/KYBJXuzgdVUFcsR7nPiE0Kdbukrg+QsNPlDIrANRQheoii3SR4LLaYijkxNO4oy4r7yxsrtGK5643WR0pDvMeDQgGpHW/fuZkdj3BuxH9RQYpSuWU/eXNc6gGcfar91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk3TvCzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk3TvCzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F501F00893;
	Tue,  9 Jun 2026 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967163;
	bh=8wUECwBStxE4t2rg+cS/WhlOkm3lJ8LcJsyOnDKZErU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sk3TvCzV5pcUirx/l2hOIyCb6ncRGeqakm22FqLVyyJHKBVc7mUB0s+QzpmTU9cPB
	 7XrWby4Afaxj7mp+0LoD+7L4zk/sE2+8d3a7Ph9W+ZV0SAK4zymnX9xcdZOaiapJ9n
	 lJSykvHtV0h3vmQMxdVQsmc25NfFCnAt4w3GvJXFWbeS38tjygxxuwl9ckLRmOiUOW
	 PnbcR38RQt7PwD0rtRFhjDyDc22WtzQU+rz8nlC+U9TvyCE1geDIsxjLC018Pp2GnQ
	 B3YfpjTO0/IFfXxmXVQmLw7liF48rdQgFdG/edbFTEoIK7k9vj5pBWIXlqXbnbwWL0
	 wmG/H5z/UmJWA==
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
	Song Liu <song@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 08/11] perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
Date: Mon,  8 Jun 2026 22:05:22 -0300
Message-ID: <20260609010526.1998472-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Both functions accumulate formatted output via ret += snprintf(buf + ret,
size - ret, ...).  If the buffer is too small and snprintf() returns more
than the remaining space, ret exceeds size and the next 'size - ret'
underflows, causing snprintf() to write past the buffer end.

Switch to scnprintf() which returns the actual number of bytes written,
making the accumulation safe.

Fixes: 7b612e291a5affb1 ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Song Liu <song@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index a27945c279efb779..2c09842469f1f28c 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -36,7 +36,7 @@ static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
 	size_t i;
 
 	for (i = 0; i < len; i++)
-		ret += snprintf(buf + ret, size - ret, "%02x", data[i]);
+		ret += scnprintf(buf + ret, size - ret, "%02x", data[i]);
 	return ret;
 }
 
@@ -140,7 +140,7 @@ static int synthesize_bpf_prog_name(char *buf, int size,
 	const struct btf_type *t;
 	int name_len;
 
-	name_len = snprintf(buf, size, "bpf_prog_");
+	name_len = scnprintf(buf, size, "bpf_prog_");
 	name_len += snprintf_hex(buf + name_len, size - name_len,
 				 prog_tags[sub_id], BPF_TAG_SIZE);
 	if (btf) {
@@ -153,9 +153,10 @@ static int synthesize_bpf_prog_name(char *buf, int size,
 			short_name = info->name;
 	} else
 		short_name = "F";
-	if (short_name)
-		name_len += snprintf(buf + name_len, size - name_len,
-				     "_%s", short_name);
+	if (short_name) {
+		name_len += scnprintf(buf + name_len, size - name_len,
+				      "_%s", short_name);
+	}
 	return name_len;
 }
 
-- 
2.54.0

