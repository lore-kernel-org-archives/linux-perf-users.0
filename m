Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5D3655CC;
	Wed, 10 Jun 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121143; cv=none; b=O7/g2+Y6x3T/u1jWmTHtGXo/jJRFiF6aWbJcDmjSVG8u34Yzrd+SzPL+ouMdLf4U4OZMO9BrW7xELvmrCWcCEUvw31bIjUcKtjBKiUQkiL8JRtPZfh5xE7jQcdikRBHvhnSv0WioItTmFHyb28rqztNiQ2w4g14nnHbNP6zCzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121143; c=relaxed/simple;
	bh=vShKGluurKkRKTjfEqQ1jrRKVLyvt1Ib/wLJjTl/CZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pilCikezNsemcIUQT/VMRQn+IGuwu4woVFGH+oYBv7BqhWdjcN84LF5STVGWAT5b+Zn9ib/Jm9vKWnUFEhBavppn47hDzqFZgoX8Hf4BTgmQ/cSW/hc5gAiX1lZtBQGBN0NjOZ9A2SkIELA7/0umZoRLCnvMYSrgfi24uZGkfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/Ngw9Mj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/Ngw9Mj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D891F00898;
	Wed, 10 Jun 2026 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121142;
	bh=3srM3phoAEpQCJ2BEqrPS5BA0frGlkkEKdOHF2Ld/r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/Ngw9MjYgv6zfgB2baCSrqgSt8KG99UFsRymgniIgKHRdirgG7esTXaRfGKXdnPR
	 NVhtlclr4miWN/s5wes692qJKAjyziVG87xzQUt8dqSA9PZIA1vc4ISQf0h2m7p/Gk
	 hoq3C7mDB5nyqF7D3dsS+7Uh98+XphjCrR5PSUVL8fHNcD3ReGVLqNZQs+f/Dm+vqJ
	 d1Bh/SXAWHlLrfbSaRPWaiz0Ycud8iZqqZjxOZAoQI3Zjb0m8ZvaZIUO6f2IiVBwAC
	 nkmacoIdrpu/R2LR/oJcrglPbfAnE0f/7G2IqHIrt+CzxsS0FhdgOZ8+7xyAtIEyWe
	 6iYm182ugo8/g==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 03/23] tools lib api: Fix missing null termination in filename__read_int/ull()
Date: Wed, 10 Jun 2026 16:51:36 -0300
Message-ID: <20260610195157.2091137-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__read_int() passes a stack buffer to read() using the full
sizeof(line) and then hands it to atoi() without null-terminating.
If a sysfs file fills the 64-byte buffer exactly, atoi() reads past
the array into uninitialized stack memory.

filename__read_ull_base() has the same issue with strtoull().

Fix both by reading sizeof(line) - 1 bytes and explicitly
null-terminating after a successful read.

Fixes: 3a351127cbc682c3 ("tools lib fs: Adopt filename__read_int from tools/perf/")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/fs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index edec23406dbc619f..3cc302d4c47b1669 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -294,11 +294,14 @@ int filename__read_int(const char *filename, int *value)
 {
 	char line[64];
 	int fd = open(filename, O_RDONLY), err = -1;
+	ssize_t n;
 
 	if (fd < 0)
 		return -errno;
 
-	if (read(fd, line, sizeof(line)) > 0) {
+	n = read(fd, line, sizeof(line) - 1);
+	if (n > 0) {
+		line[n] = '\0';
 		*value = atoi(line);
 		err = 0;
 	}
@@ -312,11 +315,14 @@ static int filename__read_ull_base(const char *filename,
 {
 	char line[64];
 	int fd = open(filename, O_RDONLY), err = -1;
+	ssize_t n;
 
 	if (fd < 0)
 		return -errno;
 
-	if (read(fd, line, sizeof(line)) > 0) {
+	n = read(fd, line, sizeof(line) - 1);
+	if (n > 0) {
+		line[n] = '\0';
 		*value = strtoull(line, NULL, base);
 		if (*value != ULLONG_MAX)
 			err = 0;
-- 
2.54.0

