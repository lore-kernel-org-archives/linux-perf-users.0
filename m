Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AE41C302
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962700; cv=none; b=nxQYVKuig+7901hXfPf7q3hh+R1tEup0eA2Zm6NoUb7keWxXFDNHvjCVHmCeSMLJZ1b+Os/9iVHc76z19YErSyV1x0CaagzSeuWXLA7pgDcs2Rs0LPBzgCL/rGeYyhL7p1yqzbojL2nM0KB0jy9kBKhuw+9d4LMk969vJoYTOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962700; c=relaxed/simple;
	bh=uS+Uo7Uea+sK0cag3i4TRSz4T9zVxU/R2GcBbXVObe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hfxX15xl9ReJJksXXwAgmFbcUb3du/LO87yb4I6PylOd0vX0JxtSaCAeNYmx7orE2ph02H4USQNuRkaUlAFyMbdq9LVtQcL17MfFzD1pm7c3wtl6QAKSRFQeh4Tt3FDFZKfDtjeV78vZ48p52iJxpU73kvOrUrqfqxPx/Wjz+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m78fkXhO; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m78fkXhO"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1273dfdaf5dso854498c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962699; x=1774567499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gUztKY4N8cazk2OKll8MhFt0eTLdZ6QKcUsAqNQqSQ=;
        b=m78fkXhO6nooKGCkbH/KQgw5QgQU8SSs5wDXrNaUXFPsIMUKCxU2lKEaAwRysnwdNs
         sG/r+6U7otUyHujUrZ9ehTArk2RFpNuk3Et/nnn//D+7G8HRh3OfLqtIsgP7nXxcFKz4
         UiWbil0A4TPDA/SW80rDWcA01F6MRNDHHSjak2UDCtPmeC6GD10l0uFgAg9jWGLTMz0I
         HJ9KTyXppdzRdO/oftHH+oDt6PQYgz3ilaPMifXVpkWLLC93/pwPitSdu7XD8Z6ULtv3
         3+y0WO3t5TManrzEwLI+XSz+r4H1We2DS7VsQk/+n7FaRQDBXWtrFnV+zbrdhZ7KQbqo
         9iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962699; x=1774567499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gUztKY4N8cazk2OKll8MhFt0eTLdZ6QKcUsAqNQqSQ=;
        b=qL+4qHzDILcfoP79edlSdRFy5sevU2HJ3BgPuOTH4TbwlT+ebWvCX3BBfHUoG/fP8A
         zvMx29KrD1E7yERbg3zdaqLoLyBzTj++6C3udVoJ3143QXQ3NTpjdu6ZwwWdT3EhaKnb
         aEwiV2QSB7Fl9VM1E2AUIflDm8JRsVVtyOnQ9B5G838dVgASgrk8Mr5JcDjekxLDKpG+
         lv8uk3BL8rJmwS8ccR6rGWrlAEsgDLaIkr7+LLrwd+8D+ucQE15bUpYj0q+40uCW61b1
         28x3ZIhDw9w9KF4dF8n71GZYAuvDqkGoaew8bBV/n7cyWMNumvLngSLm5D+TVr+U3UPL
         MXqg==
X-Forwarded-Encrypted: i=1; AJvYcCWWMFyn+GqZKWWtaptwIW1lpEYVF2m8lV3Za3BcQy8uU9pXxd1oaPPH6tD4tRki/MTa+TgLeM6JH7X7AH/yDEyC@vger.kernel.org
X-Gm-Message-State: AOJu0YymZ2xkLSQq8HoEzGQwdWBA8pEDeHSm3KJRoULRzeTbVh7CGOeh
	/yflViSPFEC1tN/8Z1/1PeGXUR+gjurXgrWHANCPQPdym2l/kXnpZe40sTBucYCMDtRVmPTtCBK
	y0zzMEjrkyg==
X-Received: from dlbrl10.prod.google.com ([2002:a05:7022:f50a:b0:12a:6fc0:69e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:125:b0:119:e569:f875
 with SMTP id a92af1059eb24-12a72342011mr609259c88.18.1773962698382; Thu, 19
 Mar 2026 16:24:58 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:34 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-26-irogers@google.com>
Subject: [PATCH v2 25/25] perf evsel: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 041766d39ec3..21602d121260 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2997,10 +2997,10 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 	return ret;
 }
 
-static int perf_evsel__parse_id_sample(const struct evsel *evsel,
-				       const union perf_event *event,
+static int perf_evsel__parse_id_sample(const union perf_event *event,
 				       struct perf_sample *sample)
 {
+	const struct evsel *evsel = sample->evsel;
 	u64 type = evsel->core.attr.sample_type;
 	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
@@ -3239,14 +3239,14 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 
 		return 0;
 	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 		return 0;
 	}
 
@@ -3606,12 +3606,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		struct perf_sample data = {
+			.evsel = evsel,
 			.time = -1ULL,
 		};
 
 		if (!evsel->core.attr.sample_id_all)
 			return -1;
-		if (perf_evsel__parse_id_sample(evsel, event, &data))
+		if (perf_evsel__parse_id_sample(event, &data))
 			return -1;
 
 		*timestamp = data.time;
-- 
2.53.0.959.g497ff81fa9-goog

