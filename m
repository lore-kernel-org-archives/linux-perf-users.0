Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A120010A;
	Sun,  7 Jun 2026 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875029; cv=none; b=ij8AsvFQVJnDryTn3VBYoZ1D/pyS19J0wcfXH9q9M7fmElWvS3fCx+NYAQjrMM1x+RrnJa2AGNogDRJzoG67QW2wf9TaTYRAh89VZYZGL718B0gizKvMsTrE2SdtmEWzkZST3OYLEwG+oVXUdZXu93lweMCO62QZC3oYl28VKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875029; c=relaxed/simple;
	bh=RgxiUMC4Gg5WEF6siaaurrn4gvKK0Ztv89csTlsz4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOVK1Zbg1uvZXMdK9dhzyywE+0gALTSDlosjp2CEyvYv85a5a18d8e1qiwQ16PLHy8MA4txh+PmZ6qgSa06WW+cv/oyH+JvB3R1hb819gOSR/YK8m3AC/8p8BZDk+6LpHOnn/Zqx/32ErHlmcRGlYtu7aHGkQ8Pk4wox3wGVxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCd7LEYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCd7LEYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF001F00898;
	Sun,  7 Jun 2026 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875027;
	bh=6pMIQ8hAJLYUSx6puyBFNWmCE2bhbXzI8u3T+QlW98w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCd7LEYY+3qAely82aMK9LPz1K25hLGlUCoMv+ExsRc+jngmM1tjgxq+1xxujK6dc
	 Y9603/Ad2pZe/EmVH7AleKbsE1yIj741dgu+8Ka/0faz29HmP/UOwNA6buYg9DSjkv
	 aItCNMERt24bNOdixFHymqbyBYW39Cwfggzdjz5le2FtOIICWgXx3axnI9eTUpm3H9
	 R5l/7iEX0LYEWPFvcvfUJAZczFF1XsUqY8ubBshdKvOI0Z9JeqTuuZUnKCepOA9efc
	 h8oYrcvq3+CVi0SUu+FUmP8pBjDJfZFRCnlKjKw7W7J6pUREls2PbcwrKL5M8RlbI+
	 KjePsP27bDn+Q==
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
Subject: [PATCH 09/11] perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
Date: Sun,  7 Jun 2026 20:29:22 -0300
Message-ID: <20260607232925.1935819-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
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

