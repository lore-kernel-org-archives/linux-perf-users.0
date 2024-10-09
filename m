Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E203C39;
	Wed,  9 Oct 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434393; cv=none; b=NhGQRBalBDTTgKrxo2bSTFSFLicgKEHc/0DmruSNXJDxvl18sQt6n6jNNMKVp0zWUaWyJqJDSFtHdDGcvoZDuzdh6RlPdunk5gXhh8kjh+3wv9MbElrHt8s3OWrwyYHmOP0eO9x8Bm3I7Y+G08v8OAylGCmgPgPnjeXnhLyr5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434393; c=relaxed/simple;
	bh=njSVivvo/nAwZPNIqLrCFDbOZl+NfQmzA8hWJS5xmio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLeyGscjM8cWcsgArccJnp1UB0QtBmMU9EvW2RdCAcevRjGB6zHFDVktYeffF/iAHP541QLs5mhebJY5Dt5GOv66enxkwxgXAoGBRG3H6rgoUc2LSby3EwhyYhy7Od40sXy9qa4M8qJdwf5IArmtIfSLG6S191IxJc5pAaF1f98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HoHRKTNh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HoHRKTNh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=p4vNPXy7z2xM3i64+7rk4jsSR0YVoSda6kzvMXga2j4=; b=HoHRKTNhGa0I0/OD
	35OblhAXSLtAz0UQMjByq/4BQpr2BOE6o567qPqdR5yNTdSYxSgbZNmFSzbLy80XbWLl0miDK1Kx/
	V9TO67Mympgj4JzUIKFWVAeCe4NvUyc7RpDnSaqETnlB6cnfxMjocJeJ+oAHfzqBKqXfLsOCYlHqH
	IN/Y504HuZX05u+OGqvcU6d/uWAsNIj5JJfsoRVVdTA0lKjbGT3w3m2sTCuYr3NTekgx5o0XO7uK7
	teLEB+ULaKrciRJDVN1zbaJoj5VOqyTR5bclIm+1N2tBXIeS8xm4zc2TaPl0mB+fd3DaoGWtkmrkd
	0wGjABFv8STprbS2yA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1syKjr-009q7Y-1q;
	Wed, 09 Oct 2024 00:39:39 +0000
From: linux@treblig.org
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf tools: Remove unused color_fwrite_lines
Date: Wed,  9 Oct 2024 01:39:38 +0100
Message-ID: <20241009003938.254936-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

color_fwrite_lines() was added by 2009's commit
8fc0321f1ad0 ("perf_counter tools: Add color terminal output support")

but has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/color.c | 28 ----------------------------
 tools/perf/util/color.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/tools/perf/util/color.c b/tools/perf/util/color.c
index bffbdd216a6a..e51f0a676a22 100644
--- a/tools/perf/util/color.c
+++ b/tools/perf/util/color.c
@@ -93,34 +93,6 @@ int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 	return r;
 }
 
-/*
- * This function splits the buffer by newlines and colors the lines individually.
- *
- * Returns 0 on success.
- */
-int color_fwrite_lines(FILE *fp, const char *color,
-		size_t count, const char *buf)
-{
-	if (!*color)
-		return fwrite(buf, count, 1, fp) != 1;
-
-	while (count) {
-		char *p = memchr(buf, '\n', count);
-
-		if (p != buf && (fputs(color, fp) < 0 ||
-				fwrite(buf, p ? (size_t)(p - buf) : count, 1, fp) != 1 ||
-				fputs(PERF_COLOR_RESET, fp) < 0))
-			return -1;
-		if (!p)
-			return 0;
-		if (fputc('\n', fp) < 0)
-			return -1;
-		count -= p + 1 - buf;
-		buf = p + 1;
-	}
-	return 0;
-}
-
 const char *get_percent_color(double percent)
 {
 	const char *color = PERF_COLOR_NORMAL;
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 01f7bed21c9b..aecf56dae73f 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -39,7 +39,6 @@ int color_vsnprintf(char *bf, size_t size, const char *color,
 int color_vfprintf(FILE *fp, const char *color, const char *fmt, va_list args);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...);
-int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
 int value_color_snprintf(char *bf, size_t size, const char *fmt, double value);
 int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...);
 int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, ...);
-- 
2.46.2

