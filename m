Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B484258CFF
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Jun 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276797; cv=none; b=QrMRWOi53O4GUiMQHf8fWMGLRdd0ACnqlu9zky1nYWPvgvsB5jImfQQ/MhJIi9fCYtFKFDIyHlqEid8baWvr/WPv1OfKri1nq5OoHRvapCiFsW4o9fjQEWHjcz6aWRaR1lvRK5U/OE5s2irTNzDBb49xreE6mI7uo4rhEbngWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276797; c=relaxed/simple;
	bh=XHL9dgqHm8F7JFYr7Q6WVL17/G7a54iJiS+tQr2tKwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=la7B6f4NfhVqpxoaD1OO2K9sRNimRNo2wqDZiiRzONbP9bDTsrFl6sd38v5tFLMaZPL+6/TII8ZWKhrk/Jbv1GSRySFoI00ffFytwqGTwqqXhnBjLf07tO7vHsZINsvQWDm17n4jAcZIXeCsuu/RI2mz+tTBPPUZxdIGFr/n8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKfSzfU8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKfSzfU8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so2450810a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749276795; x=1749881595; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLZXQWgZR2UOsdC23RnQr5r30UWzDolfedeJ9s30yTA=;
        b=wKfSzfU8oUh62KGuWwLmxJNGybghGg/inkYcOfr9vPp0YI/lYYEGpGV3CspngZpml4
         1GtXI98Ug7xl5sZFpPSJEyipG5PrsX+UDSuJ21mTsgaVZhSryGC9nXBt60NQjMIF8+8X
         rihDUhok+swImZcZDRF8k5J2cJVjNL/RFQacOFjj1EyJibbFZ4bOTFwo1vjwypSLwSI2
         i37C/2BuHxQaikTpGFmqVgNVguelJepiTrKfRa7pX4R7l6TaJuQ8M1YTHF2Rg4AS2rfg
         ThHIp8a6qD2LkkvUldtczoL8BzITTfoz6g8rTQX/lnmTWduaWLoAboEHeyIDv/VCfeBh
         FQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276795; x=1749881595;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLZXQWgZR2UOsdC23RnQr5r30UWzDolfedeJ9s30yTA=;
        b=ilcKOPq1MBef5jc0lPCxIw9WCmFn44xQUczHH7+Uc/P0MDL6tXrRJ0Egu0MFSzDXvq
         fhKgeOL6bTfRvn2flmGBcFDXTv5D3phrZtXTTwrn4U4ocrYXKvwtUTh4B1t5xOW3ICnc
         xPcriMzmd1ilQycvPLBPG/9JJwsiMU+90ZzyOviCd4T3KyXFEQ8sgsrh3heVHHhBmH3/
         nzXf2UwLh8jLXQWuSW6mwXHUr4NWi4HsPbwYYtgGOLWEYcqFf+vnn5KkKJyTjrPQ15vI
         LdUvPh0QuYB+edGM7swWNjnL2x54bkyQbpNGlxsEOK6+cXlr3qqffI0K9+Y+BWzqZlgr
         CjKg==
X-Forwarded-Encrypted: i=1; AJvYcCWKkBPYm/1lwGwG0WLb3f0miJR4VRAKHOF5ReyltCQNpFOzrnggKyJTrrFxKO4BnYlqp5Ye0b3ZTi52UFIJ+LGI@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgMI7ayPsrigrh8ALgQlPt7UHE9BtzMHbNhnCfilHTXd1+IiV
	Yp5pDJtcC8ZTEUYrNO1MhzhlJtDXnt/HT/2HxWMXWshRBBYLei9JWthfwAyNUph1WxygmEnA9gf
	gjXoaPhuLGA==
X-Google-Smtp-Source: AGHT+IGDfodlkWEYrf7QAcS8knOa1CAv0hwiL3yUtFdYjJ9TAySPqKK0flivIrLTcDyOCs4bEt55VDfiy7+b
X-Received: from pjbso10.prod.google.com ([2002:a17:90b:1f8a:b0:311:d1a5:3818])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28cc:b0:313:1e9d:404b
 with SMTP id 98e67ed59e1d1-313472d70c8mr9148867a91.2.1749276795640; Fri, 06
 Jun 2025 23:13:15 -0700 (PDT)
Date: Fri,  6 Jun 2025 23:12:35 -0700
In-Reply-To: <20250607061238.161756-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250607061238.161756-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250607061238.161756-2-irogers@google.com>
Subject: [PATCH v1 1/4] perf header: In pipe mode dump features without --header/-I
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In pipe mode the header features are contained within events. While
other events dump details the header features only dump if --header or
-I are passed, which doesn't make sense as in pipe mode there is no
perf file header. Make the printing of the information conditional on
dump_trace as with other events.

Before:
```
$ perf record -o - -a sleep 1 | perf script -D -i -
...
0x2c8@pipe [0x54]: event: 80
.
. ... raw event: size 84 bytes
.  0000:  50 00 00 00 00 00 54 00 05 00 00 00 00 00 00 00  P.....T.........
.  0010:  40 00 00 00 36 2e 31 35 2e 72 63 37 2e 67 61 64  @...6.15.rc7.gad
.  0020:  32 61 36 39 31 63 39 39 66 62 00 00 00 00 00 00  2a691c99fb......
.  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00                                      ....

0 0 0x2c8 [0x54]: PERF_RECORD_FEATURE
```

After:
```
$ perf record -o - -a sleep 1 | perf script -D -i -
...
0x2c8@pipe [0x54]: event: 80
.
. ... raw event: size 84 bytes
.  0000:  50 00 00 00 00 00 54 00 05 00 00 00 00 00 00 00  P.....T.........
.  0010:  40 00 00 00 36 2e 31 35 2e 72 63 37 2e 67 61 64  @...6.15.rc7.gad
.  0020:  32 61 36 39 31 63 39 39 66 62 00 00 00 00 00 00  2a691c99fb......
.  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00                                      ....

0 0 0x2c8 [0x54]: PERF_RECORD_FEATURE, # perf version : 6.15.rc7.gad2a691c99fb
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..84879d7fdffe 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4341,7 +4341,6 @@ int perf_session__read_header(struct perf_session *session)
 int perf_event__process_feature(struct perf_session *session,
 				union perf_event *event)
 {
-	const struct perf_tool *tool = session->tool;
 	struct feat_fd ff = { .fd = 0 };
 	struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
 	int type = fe->header.type;
@@ -4357,28 +4356,23 @@ int perf_event__process_feature(struct perf_session *session,
 		return -1;
 	}
 
-	if (!feat_ops[feat].process)
-		return 0;
-
 	ff.buf  = (void *)fe->data;
 	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
-	if (feat_ops[feat].process(&ff, NULL)) {
+	if (feat_ops[feat].process && feat_ops[feat].process(&ff, NULL)) {
 		ret = -1;
 		goto out;
 	}
 
-	if (!feat_ops[feat].print || !tool->show_feat_hdr)
-		goto out;
-
-	if (!feat_ops[feat].full_only ||
-	    tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
-		feat_ops[feat].print(&ff, stdout);
-	} else {
-		fprintf(stdout, "# %s info available, use -I to display\n",
-			feat_ops[feat].name);
+	if (dump_trace) {
+		printf(", ");
+		if (feat_ops[feat].print)
+			feat_ops[feat].print(&ff, stdout);
+		else
+			printf("# %s", feat_ops[feat].name);
 	}
+
 out:
 	free_event_desc(ff.events);
 	return ret;
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

