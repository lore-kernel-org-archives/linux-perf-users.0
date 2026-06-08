Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB739A074;
	Mon,  8 Jun 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949886; cv=none; b=SKyI6L+eKCVwqhiydb4AkZdrFEWVvxbTkk4lmPJj+QHbNxo0tmU/nPP3iC4/O6rdRLsbDPx4epFsxfKtrzVA51v2uN6iEELmcK6J5hicgS0dSzSmyULA/eq2O6F1/eZmKhB2TNS7JDqkpGa/pDLLbe3VwSMfieeJllwS1YJsn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949886; c=relaxed/simple;
	bh=5VWP2TekBIjJm70E0VzMP3ju0hgOjK8Wt8W8C1t9uZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM7e8a8ndEruOjz7fw5Ol7f98PbL6Qgsdt2JV2KeRAZCSaPP7dPs0isY+lNRl3aOZD+aPbAPVL0Iy0fKomfKi+m/pDc+1OXMEU5SrNqlhfKwW1ojG/8GaunfIlANUwdxB3OZqpuAQSDEjJtNgruAMOFgrH8EUMNT7LMHXH3v6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fynMTwlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fynMTwlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB86F1F00893;
	Mon,  8 Jun 2026 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949884;
	bh=R5WxjEJlqlEk6iV+ivR2s+nGEBp270wPJyGXkOmIs10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fynMTwlL1moNGwxc7F16l1JkI/514mGV79oDLfpvYraGNBUcS30KCTogTtmX3BDXt
	 9kLYktb00UBKEWKGUoWoAXMXrq7OdXTn5AVAkf/MnfyJBfKVVieOfQ8ibZTkmgFG6o
	 dkhpl/DkrHwPYaSJxYYh9sJhJOS31gGgXEo4Z58hq/STg2D7qMAlKbYLVoX/Yvo3d1
	 TmaJLd5IxsQ9gbkPFQSjn5delP8q4TDEdTTW6nBr6XDARImb9mxzTxYSrQLqnECrQv
	 zCbzKjCXfIv/0AQ+hQ4wzLNPSAq0jM4sGZwF9pVaKh4OMu7JZt4J2V+2+VH3D+NYKz
	 ohR4TdiDTcstA==
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
	Don Zickus <dzickus@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on empty sysfs file
Date: Mon,  8 Jun 2026 17:17:41 -0300
Message-ID: <20260608201753.1979464-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

get_max_num() reads a sysfs file (cpu/possible, cpu/present, or
node/possible) and scans backward from the end to find the last
number.  If the file is empty, filename__read_str() returns num == 0.
The loop `while (--num)` decrements the size_t from 0 to SIZE_MAX,
reading backward across the heap until a comma or hyphen is found
or unmapped memory is hit.

Add an early return for empty files before the backward scan.

Fixes: 7780c25bae59fd04 ("perf tools: Allow ability to map cpus to nodes easily")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 21fa781b03cc7409..1fab00ec4a59a0c7 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -448,6 +448,12 @@ static int get_max_num(char *path, int *max)
 
 	buf[num] = '\0';
 
+	/* empty file — nothing to parse */
+	if (num == 0) {
+		err = -1;
+		goto out;
+	}
+
 	/* start on the right, to find highest node num */
 	while (--num) {
 		if ((buf[num] == ',') || (buf[num] == '-')) {
-- 
2.54.0

