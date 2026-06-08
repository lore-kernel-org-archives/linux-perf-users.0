Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375C2F5A06;
	Mon,  8 Jun 2026 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882342; cv=none; b=UEgegnRx+7oxTyx/My6IfPj5W08RCMGpZa7f7elHCzuvuDpC2pk9NJ6v5OPtOgq4iaaDWk13FD/cWW2MyD2QVo3rpzo1bUWSHZX5X/kipdKNLggHK2NEN/AsBVrpDKyRbnCulK84Q0LRJJC/xBWdxP6sbdF0y0cCMDzND/07zFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882342; c=relaxed/simple;
	bh=RgxiUMC4Gg5WEF6siaaurrn4gvKK0Ztv89csTlsz4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db8I24l1KPyJ1orI/ejGlTWOeQt8xflAUMC798OYxeX4kvM7yygp9e/D/q0r2nTzIGGbBi64ydQcdmESiYvApzh12TA9dGUVvR3OdTeSnvcoVSZdidvInOqEelz107N7kjDzq+AT4oYIXLcK2UrcW99rcA7W0jAL8luUNWdBRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ/U14M2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ/U14M2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E86D1F00893;
	Mon,  8 Jun 2026 01:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882341;
	bh=6pMIQ8hAJLYUSx6puyBFNWmCE2bhbXzI8u3T+QlW98w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQ/U14M2+cE68AabdyJMR8v7ttWIb5IINt/Ho0YLBEE3B1HaNzCCTqTJC00zba8rU
	 82L2uk8HBDa5fsQZT8cnENMiqAwyTvb3sJPR3xyE66UIJjVO09Pf90LVav3l5UW3MN
	 i+zXdfv2QptHFbtlfhh+XylnPxEHiiHF+EoYBiKTF4awnQjs7e36hDdcKSXREQyM1o
	 QBCKM0Lk10fweMR8XYrgiDURgwAFtgJivsuhtXpEtuxFybUHAt4roY0l4oSRVKotj8
	 5QM0wBPPtaTeMDzsfxp7GS0tagYfR6/fEucn4QpaZ/wrxqKOzreTQ0qT03l44roeK2
	 z9yaWhq+I1sXg==
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
Date: Sun,  7 Jun 2026 22:30:53 -0300
Message-ID: <20260608013057.1942953-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
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

