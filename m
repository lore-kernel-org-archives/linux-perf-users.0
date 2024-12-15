Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AA1BCA1B;
	Sun, 15 Dec 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286366; cv=none; b=UM6Rqr+/Ak9Pu6r0NxKTh8R8KbGk5Xs2jjlniwsB3E0jeiCVyqXdf0kwMxCDnYAfDzedxK5DbqaC3TNwYr3eL0+qAD1sWx1zZqIkzg11L3ndI9A4G4vtlvBUSrrkfGnKO4XtFsClltY+X+1fhjUCagt+QZJIr/Ko8n/YMzGx+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286366; c=relaxed/simple;
	bh=u9g7+7bvhdlDEFFYtq1CIea8iEKMWDTyn0VCkU9fehs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or7fVRLgv+TDY6Cpkt6b4sD08qRYaznX6zUhQMIAA8FX0LjdS6jX7jz85OThkEV3ISoBm92BRaejcgpfTsUK7NzNBORWJFNxaql2QQAXKL3XfOLcZbC2kT1AXbAGFMI8BjcSui9N/NsdNQdDBHIYo3RS+roWVjmRR7KMLtXYBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnxzmYZO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnxzmYZO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728f337a921so3470029b3a.3;
        Sun, 15 Dec 2024 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286364; x=1734891164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+5hxkFVHfua/URBhTBN71iEJ316cdDFM1X15VlseMo=;
        b=OnxzmYZOT4UGHF4/b+SI0IyJt4BQfUvluy1YgwMjxAFT+4GRA+90cdN+7kpKqBxDfW
         eOp0I1Qs4fgYoJF4A+kt/dSrvDfCxzQep8H83m/1HjnowQLA2IwXcYLF34Nrq3wrYZv+
         SP6Plmc2Wvo3tmFccqEsr9wmdB5uwWF45UPIy4zRGMRuOtopGyjPV6gIq7/n+ywTaKq9
         BhfCpcym+ut5PNbps0zcb/isnZaF6E3CChc65jqYebFwNLT4jYMPQwJ7Bp/jnl33tiCh
         6AQobssRGEiBaa7oWEE+sEXAR2MF50206GAkSvD9V2UIWuzmo05Jzq1gtNDUZqglbU+2
         rsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286364; x=1734891164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+5hxkFVHfua/URBhTBN71iEJ316cdDFM1X15VlseMo=;
        b=LBEByQcOstJdb6t+BPeR7o+qW5JRzfFyR9YJbwAQYYW6BPIbMR2fFBGytSW151qtJS
         2qbFJdswdWYAMyjdZVjB4Spv2odKbP+1+4WfF7lEPSO94FD+PwGnOiOQzwuwJnzDxShy
         0gig/Xfxb85o7gKbAmi597b5zXDi/cc+PTY+Z7kO5t4X4VqQ6rAkI6G6qHflHaKZ1MzC
         xGxLgCx+PBWrXH41qywVpTnsIRjg8OJnpQtF5A7/JxuQZn/m/sWVd4YkXSowLLftT/Na
         jearefxi6eLXin5JKoL9uKfXbbkiz19TY0acjIBcWLBr9Z2nZOWLbTuTVmg0N/DONTdA
         1w2w==
X-Forwarded-Encrypted: i=1; AJvYcCVdQAioinnsDyWPp88JywzEv6eMPjUOA7bmbYCeHym5qB7Y8+5zKq72LWXAVzCyBsB/yDBFkgWl67WpTFO9gEW6eg==@vger.kernel.org, AJvYcCWdmQnKv1Q9cGGc/glZVsPTAd6J3u9qb3LnG5tmPp5/FcLbx7zlyjKbyS6zWY3nb8sIqUJz9UTHPtAQOxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxTeY7An1WSsKYowfVYt4MfO0BvHEz5ltTgCCMbtYi4GHVAag
	Ljc1NIUBRLo3n3KzryNo2LDicLrP/0ssCHK2y0gSllqq6idUH12EIbtaCwh0
X-Gm-Gg: ASbGncv7jVTGuc8nVOktRMcw+PWgDrO/QOclKVJqcf8lvSoZxmp+4WKg/QjoRoVh1iE
	K7Xlf5mlRjq+OTheTrtWGomV8sA7MkQirrYj2r8OIBnH9ErFZNN5m96rhRWwO5Lyr/PDX/Z1F4o
	FXC6ymp2AmnfQpgAmTTLiecfX/Frvw5p+tQYFuuTrddZuqj6xfBFP9XcaEs0MYDS5pkhT9u23zl
	KN/61ZtUQ41X1SYf8/azXJ3KSX57PPwmcSDbyxeSNfftGmCxQgWWZ19+G2cUuGY8GBRkBszWWet
	ecCE58SAx0IB
X-Google-Smtp-Source: AGHT+IGU+vbAKgR1SQ1dT8iqtnXTC0//K4nzFwzu0jnGveQ8YDveFWa72zQGLPmqhSmUVp8h67HAtQ==
X-Received: by 2002:a05:6a00:22ce:b0:725:eacf:cfdb with SMTP id d2e1a72fcca58-7290c27d62cmr15721291b3a.24.1734286364598;
        Sun, 15 Dec 2024 10:12:44 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:44 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v14 05/10] perf evsel: Assemble offcpu samples
Date: Sun, 15 Dec 2024 10:12:15 -0800
Message-ID: <20241215181220.754822-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the data in bpf-output samples, to assemble offcpu samples. In
evsel__is_offcpu_event(), Check if sample_type is PERF_SAMPLE_RAW to
support off-cpu sample data created by an older version of perf.

Testing compatibility on offcpu samples collected by perf before this patch series:

See below, the sample_type still uses PERF_SAMPLE_CALLCHAIN

$ perf script --header -i ./perf.data.ptn | grep "event : name = offcpu-time"
 # event : name = offcpu-time, , id = { 237917, 237918, 237919, 237920 }, type = 1 (software), size = 136, config = 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1

The output is correct.

$ perf script -i ./perf.data.ptn | grep offcpu-time
gmain    2173 [000] 18446744069.414584:  100102015 offcpu-time:
NetworkManager     901 [000] 18446744069.414584:    5603579 offcpu-time:
Web Content 1183550 [000] 18446744069.414584:      46278 offcpu-time:
gnome-control-c 2200559 [000] 18446744069.414584: 11998247014 offcpu-time:

And after this patch series:

$ perf script --header -i ./perf.data.off-cpu-v9 | grep "event : name = offcpu-time"
 # event : name = offcpu-time, , id = { 237959, 237960, 237961, 237962 }, type = 1 (software), size = 136, config = 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1

perf $ ./perf script -i ./perf.data.off-cpu-v9 | grep offcpu-time
     gnome-shell    1875 [001] 4789616.361225:  100097057 offcpu-time:
     gnome-shell    1875 [001] 4789616.461419:  100107463 offcpu-time:
         firefox 2206821 [002] 4789616.475690:  255257245 offcpu-time:

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-7-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fc33104cd659..277b5babd63e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1244,7 +1244,8 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 
 bool evsel__is_offcpu_event(struct evsel *evsel)
 {
-	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
+	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT) &&
+	       evsel->core.attr.sample_type & PERF_SAMPLE_RAW;
 }
 
 /*
@@ -2846,6 +2847,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
 	return false;
 }
 
+static int __set_offcpu_sample(struct perf_sample *data)
+{
+	u64 *array = data->raw_data;
+	u32 max_size = data->raw_size, *p32;
+	const void *endp = (void *)array + max_size;
+
+	if (array == NULL)
+		return -EFAULT;
+
+	OVERFLOW_CHECK_u64(array);
+	p32 = (void *)array++;
+	data->pid = p32[0];
+	data->tid = p32[1];
+
+	OVERFLOW_CHECK_u64(array);
+	data->period = *array++;
+
+	OVERFLOW_CHECK_u64(array);
+	data->callchain = (struct ip_callchain *)array++;
+	OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size);
+	data->ip = data->callchain->ips[1];
+	array += data->callchain->nr;
+
+	OVERFLOW_CHECK_u64(array);
+	data->cgroup = *array;
+
+	return 0;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -3197,6 +3227,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (evsel__is_offcpu_event(evsel))
+		return __set_offcpu_sample(data);
+
 	return 0;
 }
 
-- 
2.43.0

