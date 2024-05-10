Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5356757
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317994; cv=none; b=c/pxT6f9agF1bYyXpctt2vknV0pY/noCsqTlA5/ueHfPl3ptGzm/dU1t7g5FlqV9cpL6SbKMTNYLeqVfn8r1QDd6TlAySEO7t291I91I49+WWy6mSImtf/S2LBjXoJWNMG4jfF5PZEQZCFiXo1WmmBd68CR2LMafQK2tLAJ/r88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317994; c=relaxed/simple;
	bh=2CSSuDANH+DI3ZSn1/F+R7LCv62bfHS4CcN1mcJHHl0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=CaiqX0ivNrk5RJTxcX5xjv294jxFH6oMWsUX+mSkjsQpZjwQZ/+hmbfqNaTkc6vq7iNExg8JACZU45/V2WnsaUFGiDUgw3fG/cUuI/G2cJUaSFEhrxS/oSguCuBDE3k0SbHfZ3/HK24EZ0CizW/VrmxroNDnOceo8FCN/OFnE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhKEHf6b; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhKEHf6b"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59d580f61so2756574276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 22:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715317992; x=1715922792; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OKjQVp3FAUgk+ze053pkAabzKwTqf9LXD3i69ugyhcQ=;
        b=BhKEHf6bd0kN0LlV9WIEzc2zpWFB3f95GDz68qlfhx996R9+2nnU9+xkWni/2P2ksc
         6ly3W/+dYZPL2sAao4imnuu87oliWZFLmqUQcjdAVyKpAa8HiEK28+bIBu723yDmbJ34
         oQV8QDTcDOCFrodkRlcFzN6rrr9RMBwVmmoJPLP5WwZmO/bufTqcRTYsn8asfsU9zNZK
         wwGPIogd3i9pis/OzZYI2FZfgUkBlSKxZhcFRFB5Leu4oUml9OvLW5PB5ALcz/cyV/z6
         W21nlvvn6sSroVoZWfLsQiHfw2xGcZnKSp7rY9jFAmR4Dm6znrGPrjVuM+ZneKrE1Wui
         snCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715317992; x=1715922792;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKjQVp3FAUgk+ze053pkAabzKwTqf9LXD3i69ugyhcQ=;
        b=QctnPOIqUCKnX6EcxMUvN3EbKV7BLuaPah92sXTLRtbcqLytiXyoHN3FdhC0yd6TmZ
         gidAtzrY5ZeNz5wBSJUJtikjzEunqDVza6GESj30ttxh0c/5iR5HNd9Cc5P7lygN498g
         rInV5gcESv7L788xY04KHhfLCkQZNikV1W3eVl6Udhw+mr+k6zAGlW64WqVgJxCdT4G+
         ztobsGWI4Mp9LUrt6FcrRA4+vgxtQa9Oe0h1Ken0PgWmtluKDIFF3/8ChF/8sQelBpp1
         d1w41UtCLwJibqRSwJPdKNvsjcTQsDm7qExNhq4IBv5wnr7YcqIAc7MwugKXWfPyQjaf
         wNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2329r9HsbHDHRP9ipwNldqdMjG/0r51lUJICYVkPPjiIUivaBLVPZKHxNIE1a61X0HvT+JWDmt6Zk80hSPXvdfZCYa3hljjGD5BgG+nzS3w==
X-Gm-Message-State: AOJu0YyvgI5OuMHfs5UshnJdRL8snx7h4OWlV15BxFsybTzJSShLZtIM
	+gRGhEIE/JhSnEre/5/CBVYlcbxL6KqP9njDRSVYjHsbGRCuI+c6bghKSBpwEoR97GlhjJb4oKu
	aNDURng==
X-Google-Smtp-Source: AGHT+IEyteZvNqV/b2Tct9YqzW6qTIA83prGM1x9o7/VX+ENGd5xhTev2l0+eI7qtwOmojAY0zI1cu7QxLHz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:de5:53a9:384a with SMTP
 id 3f1490d57ef6-dee4f53a18emr445869276.13.1715317992474; Thu, 09 May 2024
 22:13:12 -0700 (PDT)
Date: Thu,  9 May 2024 22:13:09 -0700
Message-Id: <20240510051309.2452468-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v1] perf stat: Don't display metric header for non-leader
 uncore events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On an Intel tigerlake laptop a metric like:
```
    {
        "BriefDescription": "Test",
        "MetricExpr": "imc_free_running@data_read@ + imc_free_running@data_write@",
        "MetricGroup": "Test",
        "MetricName": "Test",
        "ScaleUnit": "6.103515625e-5MiB"
    },
```
Will have 4 events:
uncore_imc_free_running_0/data_read/
uncore_imc_free_running_0/data_write/
uncore_imc_free_running_1/data_read/
uncore_imc_free_running_1/data_write/

If aggregration is disabled with metric-only 2 column headers are
needed:
```
$ perf stat -M test --metric-only -A -a sleep 1

 Performance counter stats for 'system wide':

                  MiB  Test            MiB  Test
CPU0                 1821.0               1820.5
```
But when not, the counts aggregated in the metric leader and only 1
column should be shown:
```
$ perf stat -M test --metric-only -a sleep 1
 Performance counter stats for 'system wide':

            MiB  Test
              5909.4

       1.001258915 seconds time elapsed
```
Achieve this by skipping events that aren't metric leaders when
printing column headers and aggregation isn't disabled.

The bug is long standing, the fixes tag is set to a refactor as that
is as far back as is reasonable to backport.

Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea11e3437444..bb6bbb821b5a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1251,6 +1251,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
+		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
+			continue;
+
 		os.evsel = counter;
 
 		perf_stat__print_shadow_stats(config, counter, 0,
-- 
2.45.0.118.g7fe29c98d7-goog

