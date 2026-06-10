Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7C3537F8;
	Wed, 10 Jun 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110381; cv=none; b=iydBXe4Y0z2F1i72xEhPvwCVUrkLkzTNyc+3EqRAHzE9d3gQmDaaDBPTNglJPiZpGys8CBk9F954m9JPy1cyUqNGIkPIXhf5ilbjHMQxH3uaOpjwaOGb/o4sDuKZBCQjPS50zpmmkc1o+o5CPvo0AkG3l88rLmcGtLdRSMa2SGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110381; c=relaxed/simple;
	bh=7n6+PW6fm4CnN5i0Kkq2sFG6oHBydJcqFEad0lVdCCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0zF++tHdBmjA8lA8UaPamrMOiI8AyxcvdjnM2/44NvIg9qzOa+w77uAmn0yb47a8MDTT2g1doPgA7fX7tZ9uWOV1kd2SHqv90wXfbGHjwA8YQbM1UoHLQsolqU6gtDBgAKOLT6TDHS8IJbGw7KGIqwZtkv8QovIoLaZ58yOwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSbiAm/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSbiAm/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCA51F00893;
	Wed, 10 Jun 2026 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110379;
	bh=9Sna/5EcUpDAGkIvriG0r7m33IdzGdkBg8h/2wBoRA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSbiAm/zpozYjFF+z1B7Se+I1nlMQ1hjQM7gJFPRc1ZjCyhAd4kj5P1i9qdhcDv39
	 gzgMRlGMjsfrz3Vrb1yjJzyvNQuguEjgGq+dEWt1lHtp8h8nv9YMSH170TuJV5Y2y1
	 xL0TVbth/HcAu61jp3sEtclOCTG0P6KXTd5HXGJqDMlKhn/xvQoiYVLkAkUHj35sMk
	 QJj1ixsu5oKFU2XJBGGc4gxhu77AKn3Q6StgIVMIT1pfEtwoipZJXseSpLT5LOPtcS
	 QpZheylskyuAcO7OU4cNMls/xjgGULAUeWj49X7nW8MEKlutdiRqcE7UBksVzzx1zJ
	 OQcaaMbWkNXzw==
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
Date: Wed, 10 Jun 2026 13:52:02 -0300
Message-ID: <20260610165207.2077258-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

