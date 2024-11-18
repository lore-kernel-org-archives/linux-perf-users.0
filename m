Received: from mail.bsc.es (mao.bsc.es [84.88.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138B208A5
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.88.52.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955922; cv=none; b=UG7sv9/0lKQIWDtpgokuZYEhJ30Q7XNdn/GJQPBPjU2g9JenmttLl4Kzzc7o9GWI0kZmsUJjnYPkc7yVKvndwAuWFlca99PATEzSKcpyf2c31TuIL1ib7FL+RuLGM6w/WR7mHhZj3C5wcrEGWcDxY7LApA1ZCKVDXTRfFyJ8X8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955922; c=relaxed/simple;
	bh=uHUDgaFXYo6KHsHfWOY5vh6KrbBPS0jF71QNpKobBrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6svL3P7PbSNTyIZJdQ6FxiJerb2r4pnjZOcLpKlHnRsdA8JmkDXJx0CLKFeqr3zQrMftru1G2T1CMoKrXL/33j2k9itbCBY4PuxSwlGrHHIzhIEqAla2OmWv1BMlvD0De4t1dYduPB0jnkS/a4yPigqLlfj+nXDVLWpeORcXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bsc.es; spf=pass smtp.mailfrom=bsc.es; dkim=pass (2048-bit key) header.d=bsc.es header.i=@bsc.es header.b=gW9f/JGV; arc=none smtp.client-ip=84.88.52.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bsc.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsc.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsc.es header.i=@bsc.es header.b="gW9f/JGV"
Received: from mail.bsc.es (clients-xsf-101.upc.es [147.83.201.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.bsc.es (Postfix) with ESMTPSA id D512F4061D7A;
	Mon, 18 Nov 2024 19:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsc.es; s=20191012;
	t=1731955533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DZ8SxW5P1DTu8Rp4m2QvBBrZuHr1xYCUTI+y73VcK+4=;
	b=gW9f/JGVcTFQtFfhfO6apVBRGgZ0+gxLXR8DuO8ws+gv+W55PUrDyTFeqggtXHvRIR+Bow
	nVUyc6iAhmPyTQysUOrbEKiGNQUFrK0fTDGwi9EObieypiOU7Tiwm4kQs0NSLHSA9E6fdZ
	zmzlkAyAlx0kBRv/iwAdVKk0PPDsqq1ZcLBI6WvsV8uCjzns//Z2mKV25TTusmyrNRzpZI
	Zu2VEbwqQLnfXZKPICoOgdVsHkvoXT/er6KuYEhX9iTGf5blKwsIXHVovTiCs8LRbm18iQ
	a4suxr68Lxuf2NR06h/Fh81HUzeQc1rZjJ1eG8hfc/3Z0poDj0xfFjbwi9diTg==
From: David Alvarez <david.alvarez@bsc.es>
To: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>
Cc: David Alvarez <david.alvarez@bsc.es>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: use C LC_NUMERIC locale for json output in perf stat
Date: Mon, 18 Nov 2024 19:41:45 +0100
Message-ID: <20241118184145.8829-1-david.alvarez@bsc.es>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: opsmail02.bsc.es
X-Rspamd-Queue-Id: D512F4061D7A
X-Spamd-Result: default: False [-4.10 / 15.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[bsc.es:s=20191012];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM(-0.00)[-1.000];
	 WHITELIST_SENDER_DOMAIN(-5.00)[bsc.es];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ASN(0.00)[asn:13041, ipnet:147.83.0.0/16, country:ES];
	 BAYES_HAM(-4.00)[99.99%]
X-Copyrighted-Material: Please visit http://www.bsc.es/disclaimer

When using perf stat, the tool will use the system locale to format
decimal values. This is incorrect for json output, since the user locale
may lead to incorrect json formatting (which requires a dot as decimal
separator). The following example is perf's output under a ca_ES.UTF-8
locale:

{"interval" : 1.005100134, "counter-value" : "0,486755", "unit" : "Joules", "event" : "power/energy-pkg/", "event-runtime" : 100240331, "pcnt-running" : 100,00, "metric-value" : "0,000000", "metric-unit" : "(null)"}

Solve this issue by setting the LC_NUMERIC locale to "C" when enabling
json output (after parsing arguments).

Signed-off-by: David Alvarez <david.alvarez@bsc.es>
---
 tools/perf/builtin-stat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 689a3d43c258..b9ebb06b254d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2840,6 +2840,15 @@ int cmd_stat(int argc, const char **argv)
 	if (evlist__alloc_stats(&stat_config, evsel_list, interval))
 		goto out;
 
+	/*
+	 * For JSON output, we cannot use the user's numeric
+	 * locale since decimal separators must be dots.
+	 * Set the locale to "C" instead now that we've already parsed
+	 * all of the arguments using the user's locale.
+	 */
+	if (stat_config.json_output)
+		setlocale(LC_NUMERIC, "C");
+
 	/*
 	 * Set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
 	 * while avoiding that older tools show confusing messages.
-- 
2.47.0

