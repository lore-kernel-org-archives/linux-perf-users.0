Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40422D949F
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799581; cv=none; b=Kujmtm258AA0JJOUOjMoj/PeTVz76NLYcRNVcqxsFAx6jIPbekctguTdL7DOyoUM2hLFO/no2DSegYHmqsD/ykyEGeu6SdGsKyllbBXSdlnuuWc5DQLLHFssLEEJod0UEXl/qIUx3j0k8Us2t49IRnAHsltkL/Q1MKY7iB8CBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799581; c=relaxed/simple;
	bh=lcitgjEQcXl1ueB+btDph/z9Qk2ubVjcj5n/+Z1wp9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nN0lIAMjT2kaZnLNlpHACvfmO4TQ++SaiK8YrSTQri78VXJxP/f1d1tf25jooCID0uqDp/MhD4IUh6xNh1N2d5lr0rLXONK4WEr17IZVUE37YgnZDAC1De8GTvultjww/E+1/xwa3Fc+vG8G/eomYROezz7VmMvI5ygiXNqV+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHOIFRai; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHOIFRai"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-341aec498fdso3904806a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799579; x=1764404379; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olDcTWaXoeAAZhaDM2EEwFLEFX4r4XtX7pbuTmW4sUE=;
        b=LHOIFRaiztihTktBVsUZdTuoAT/BrzAewNIh1SG0Tby58D3i7461k1VqIpobLGabGl
         6Tai++nW7nXnChlS6IohMjAwPfXARA6DRY3xhVNOEfeBZramj901CSeZahKsL4EFdZZG
         uZ9cWOuPcOAtCrht+uuEt4+gQ+jqcpoXPY4vdrPR/XAEaKINgpxqJqYogUKRFd5/bdGa
         0ohsCNImSASLqi/Gupsd2IP1uQzwajxgVHHCx8uBAiE/guyf+S9zAAXVyxJh7IYxsiBi
         MTsOEo/B8+tRYhOVtZPQAeMSoKvNaF+mj0UHDA62Fa/Uvf7Fq/gotoaunkMb7ZQO+fdc
         OR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799579; x=1764404379;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olDcTWaXoeAAZhaDM2EEwFLEFX4r4XtX7pbuTmW4sUE=;
        b=R5kEGlSJ+xYbnliudTpjdvoYyKZ8rROMYgT97TF81tueeg1+J45SZjcRZHxX9gwwwe
         jWCcGCjg5A2h+z9Dq9wG8jPiLf3oNUwiKgHnNrvkWcqWKpdMIJjz0juF+CKuEdtia/mq
         6cEge2TvFI4V4CotFrf3KsdIeVoGbk6zDbTZo/cQmHFtTjPh+ovUqGQyYcckmXh2bYJg
         NG00HIGsgrcztALQMbLH61Xytma8lrWPGaeu9694C4KgZh9TXwVq8h1W1TiFmZPUjOJC
         Fen6Ar7xug3ph3vac9AEzDc4k1SmrPx/jqmloLxhirjbsQr5RzxvIolZeC1eY5awLWoA
         iTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUglo9N0HyzLvZXCBwkZ9qScQcS4eaHww9anivkBsjbpsxSPtWjqOanKo/V3XSfIusXY2SPtzl+jnbNiu8/7vNf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BU3/+OqE3mujRXwb6MoxUl98OqzkN0HUxWFoKcBPNVh9yOjh
	ksNty6Tkkg9Bih3BUkJpdSyeC7Y+4J0clOCrLMXUMeIY5JABZxvlH0rho1VHis1qQDJeo28FFsF
	5PghtVA8jbg==
X-Google-Smtp-Source: AGHT+IFg6Ktrj2zIwJbXlbe5LDlc+MS/s38n577fvz01e7jf8fE8U5cwWbIJlEx4XNUPC4DWxaE7w06J0Wjy
X-Received: from dlbqy19.prod.google.com ([2002:a05:7022:ef13:b0:11b:c1ab:bdb1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec88:b0:11a:4b72:35e8
 with SMTP id a92af1059eb24-11c9d7092b7mr2588098c88.6.1763799579085; Sat, 22
 Nov 2025 00:19:39 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:14 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-3-irogers@google.com>
Subject: [PATCH v1 02/17] perf timechart: Add record support for output
 perf.data path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The '-o' option exists for the SVG creation but not for `perf
timechart record`. Add to better allow testing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 22050c640dfa..f8b49d69e9a5 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1651,7 +1651,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 	return ret;
 }
 
-static int timechart__io_record(int argc, const char **argv)
+static int timechart__io_record(int argc, const char **argv, const char *output_data)
 {
 	unsigned int rec_argc, i;
 	const char **rec_argv;
@@ -1659,7 +1659,7 @@ static int timechart__io_record(int argc, const char **argv)
 	char *filter = NULL;
 
 	const char * const common_args[] = {
-		"record", "-a", "-R", "-c", "1",
+		"record", "-a", "-R", "-c", "1", "-o", output_data,
 	};
 	unsigned int common_args_nr = ARRAY_SIZE(common_args);
 
@@ -1786,7 +1786,8 @@ static int timechart__io_record(int argc, const char **argv)
 }
 
 
-static int timechart__record(struct timechart *tchart, int argc, const char **argv)
+static int timechart__record(struct timechart *tchart, int argc, const char **argv,
+			     const char *output_data)
 {
 	unsigned int rec_argc, i, j;
 	const char **rec_argv;
@@ -1794,7 +1795,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 	unsigned int record_elems;
 
 	const char * const common_args[] = {
-		"record", "-a", "-R", "-c", "1",
+		"record", "-a", "-R", "-c", "1", "-o", output_data,
 	};
 	unsigned int common_args_nr = ARRAY_SIZE(common_args);
 
@@ -1934,6 +1935,7 @@ int cmd_timechart(int argc, const char **argv)
 		.merge_dist = 1000,
 	};
 	const char *output_name = "output.svg";
+	const char *output_record_data = "perf.data";
 	const struct option timechart_common_options[] = {
 	OPT_BOOLEAN('P', "power-only", &tchart.power_only, "output power data only"),
 	OPT_BOOLEAN('T', "tasks-only", &tchart.tasks_only, "output processes data only"),
@@ -1976,6 +1978,7 @@ int cmd_timechart(int argc, const char **argv)
 	OPT_BOOLEAN('I', "io-only", &tchart.io_only,
 		    "record only IO data"),
 	OPT_BOOLEAN('g', "callchain", &tchart.with_backtrace, "record callchain"),
+	OPT_STRING('o', "output", &output_record_data, "file", "output data file name"),
 	OPT_PARENT(timechart_common_options),
 	};
 	const char * const timechart_record_usage[] = {
@@ -2024,9 +2027,9 @@ int cmd_timechart(int argc, const char **argv)
 		}
 
 		if (tchart.io_only)
-			ret = timechart__io_record(argc, argv);
+			ret = timechart__io_record(argc, argv, output_record_data);
 		else
-			ret = timechart__record(&tchart, argc, argv);
+			ret = timechart__record(&tchart, argc, argv, output_record_data);
 		goto out;
 	} else if (argc)
 		usage_with_options(timechart_usage, timechart_options);
-- 
2.52.0.rc2.455.g230fcf2819-goog

