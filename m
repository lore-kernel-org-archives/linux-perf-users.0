Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3B38E8DC
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629454; cv=none; b=jGd0ECRHkBku73xWWwvx82yBPPwArV9p+38FifbtLEupd+s8CA22YOznHFzE2lWzY7+OhCnXe2yC2O4v07osHBM3GmjTRTNE9CbzfxYld0D3a89SWsBimuDbGHGAn3XIrBXA3NiW7tisHNXqSim/BOcCE2CRMXrC1FWwdaS83Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629454; c=relaxed/simple;
	bh=IqhyywWKHyhN8gJlI9rT1jDSsvu0HAESaQ327RQpw8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEE/dofk8ggLTp2Op8EOwJtK1g7Y0PeYdgD7jSnQQLszZPi7zLxVrDUvJg+a7zxWy2kQDNh/aJQb8e+XqINeNCevXDbC+4aFp4wa/dDKf7hfqByriFAfbEjJZEUO0f9nTEfnq35UWjlNe8SZuyfrsNrIGRnIjlyeIVZHQwltMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEKpcFHi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEKpcFHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629452; x=1810165452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IqhyywWKHyhN8gJlI9rT1jDSsvu0HAESaQ327RQpw8Q=;
  b=PEKpcFHijhVBiOR060elW4m0AoyUX/YhiuSjWa7O/y4ExLb1AS3iFCbF
   sDsSNgGFoVar8n28Cwr3LsKRE8SpT3uqAWk62njdtpXyFmevXp8qW5iLY
   O/TvUSvcIKeQFpmdx3l+XGr1pYt0pXFHwEEr+xYpQS1JrldX1UFscZqiZ
   RI4NH8ZGPI7ahauewjD+3hbQ02PRwUw1/HCKwUh1qUz4f0qh6dgrxFjxH
   J/Fy7K1cXg2BdCB0CVkwMfVhUNSaMnT0AWGi23SvbeApmBburGjYBgCJ6
   SHDlWrGYYUJ9jO7yllDolPI3AcylIDpdF9GmzXB5zTQSA0yfP1guqCANP
   Q==;
X-CSE-ConnectionGUID: 1+9/8phETu+QJcfmavHilw==
X-CSE-MsgGUID: 1S0VH+ZcTSej/Wx/phi0Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79663174"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79663174"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:44:11 -0700
X-CSE-ConnectionGUID: BQbWNTC9T1mzjWm8Ppd62w==
X-CSE-MsgGUID: Dv3QRTl0QpKp7BSgJXtYhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="239727025"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:44:11 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf stat: Make metric only column line up with header
Date: Tue, 12 May 2026 16:43:45 -0700
Message-ID: <20260512234345.554166-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since some time the metric-only output columns are messed up and do not
line up with the header, which makes it hard to read. I haven't bisected
it, but presumably it was broken for some time.

There were multiple problems:
- The dummy pm invocation at the beginning did print a bogus field
- The column computation in pm did not agree with the header length
- The color escape strings from highlighting confuse printf's field
  length computation

Fix all those. I simplified the column width computation significantly,
ignoring EVNAME_LEN, MGROUP_LEN, config->unit_width which don't
seem to be useful in the metric only context. It now only uses
the actual unit width as well as config->metric_only_len. The result
is more code removed than added.

Before:

% perf stat --topdown -a -I 1000
     1.000190386                                         45.5                   40.0                     5.3                     9.2
     2.005185654                                         45.3                   40.1                     5.6                     9.0
     3.009193207                                         45.4                   39.9                     5.6                     9.1

After:

% perf stat --topdown -a -I 1000
     1.000810024                 46.3                 39.7                   5.3                 8.7
     2.004800656                 45.8                 39.8                   5.4                 8.9
     3.008804783                 46.0                 39.6                   5.4                 9.0

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-display.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 993f4c4b8f44..402611ecaf42 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -580,16 +580,13 @@ static void print_metricgroup_header_std(struct perf_stat_config *config,
 					 const char *metricgroup_name)
 {
 	struct outstate *os = ctx;
-	int n;
 
 	if (!metricgroup_name) {
 		__new_line_std(config, os);
 		return;
 	}
 
-	n = fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
-
-	fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + 2 - n, "");
+	fprintf(config->output, " %*s", config->metric_only_len, metricgroup_name);
 }
 
 static void print_metric_only(struct perf_stat_config *config,
@@ -599,19 +596,20 @@ static void print_metric_only(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char str[1024];
-	unsigned mlen = config->metric_only_len;
+	unsigned mlen;
 	const char *color = metric_threshold_classify__color(thresh);
+	int olen;
 
-	if (!unit)
-		unit = "";
-	if (mlen < strlen(unit))
-		mlen = strlen(unit) + 1;
+	if (!unit) {
+		os->first = false;
+		return;
+	}
 
-	if (color)
-		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
+	mlen = max_t(unsigned, strlen(unit), config->metric_only_len);
 
+	olen = snprintf(str, sizeof(str), fmt ?: "", val);
 	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
-	fprintf(out, "%*s ", mlen, str);
+	fprintf(out, "%*s%s", max_t(int, mlen - olen, 1), "", str);
 	os->first = false;
 }
 
@@ -633,7 +631,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	fprintf(out, "%s%s", vals, config->csv_sep);
+	fprintf(out, "%s%s ", vals, config->csv_sep);
 	os->first = false;
 }
 
-- 
2.54.0

