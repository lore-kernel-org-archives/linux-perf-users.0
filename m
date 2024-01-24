Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9B12C532
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139731; cv=none; b=FrxFHP8JXickouhgfcsHnfP4yEB8oQ1fVZMbrNWjEMPoGNzm5I8CbuUFOvzRunzcWlegQKgUt8Ae75XHnmjhTJ8FnrDedDKj5IehecCsP/IBaqhQDPkJvEqjm9ZIW7108naX519Ukv5ZvHSxTivEbO/2Jn6gwF/qXGZ8UwlBW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139731; c=relaxed/simple;
	bh=IKmIcga6k5Dg0BlXa1TCH4mzfOReTRLYuv6E/ZEXKag=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=LZoG7p6Rzua+U9f4giVz+ZiMTTN8CqkzfFRd90AbnDdale64yGny1oWpl5jTztYqADnfkw4wk5YEIEkNcUoivNNLz54arNxNgHwzgak/UdK+OQ+MlIAvt63AvxmtWzOFSRnhdQ/TD8HrK10kRvif36gQbgDlHsG1mmYx7u6dGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9gzdftA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9gzdftA"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f6c12872fbso95804267b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706139728; x=1706744528; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfW74auTs+0F7HhMDAnZCc535TjNzx9jhVgMO/Hoggc=;
        b=a9gzdftAWUoGzIOczaW8J8FZ3/SM/8jxR4RKGiust+1szKi4gjEZYg0RW0HQYJ3dZu
         rH4Ha7vePH5Zo3TFltsQn6G6Vlr5/5X6gGfsGJJnLcQZuGC0vY5Dw1lSskIFUuCivYX0
         5p9ECpRocpU7PDTSxJzUzzbPNI7e2g1IkqbTnVPGCNUY469XzdkqYeoiHtCSmJZh2ONQ
         hn4NPPxW/lYyTTNQ6JxCuYlBm7m5Xu8XpnqWWahZLc5Om+k8Cbfrac2F9oahBpPYamjB
         3Vtaz0UD7Wx7b4/Z/QY0sMKduvPn7zjxCO1H239uKwMzC+fCYBGv6mEl/pNYBbiiW0VQ
         RT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706139728; x=1706744528;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfW74auTs+0F7HhMDAnZCc535TjNzx9jhVgMO/Hoggc=;
        b=KDDwgVy+ZHJ7zsCWGwNoVdvQbJrjaZxvmCFARSTrMmaVVpOlQxpyAR2DyT5nAg3xId
         4A/3HEq4XuwsmOpoQe+G738raMd7OJNZvl5A3OaUy/sapG8ABQaV/rcpoBlKUUvXOs6I
         dI1eo/Bi9boYTGoBRtRcFYBA7cRMKgr/wMgZsu+7ZhKnuTf/s9xo15j3Tpf0Uv0143ox
         eIvgKxd1qQthDj1TeqcwIDrxwtXXRYAY2NdSbNiBThRywdSIE7zzCA5bmHcGip7N12uE
         C2ndOSDoXOp1b3QvTo0eRk9v830buF4/RTXcUvT8BQBDyjlwAFIIgQIaNMeRSo5WRsFc
         xaVg==
X-Gm-Message-State: AOJu0YzXFkt+WNfRDEHCGZORvHUpEtsUEbwcZUzEgKyy8frNfmAkWwij
	J/Tclm4nVkQkYRzvJPXeK5w5ynw4PhaVsUU2skieEYYk6BvG4DXPr/KXaLjdiTQ7UT1nadAnswU
	hXBMekA==
X-Google-Smtp-Source: AGHT+IE557Wa0s97f9sVCD0XX8RUVF49ObClcOfweWvyxtSeP1M6VsyAtIF2K58FzML/bjhFjlX1mr8SeV+Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4e5:2ab4:c78c:bc24])
 (user=irogers job=sendgmr) by 2002:a05:690c:a90:b0:5f3:f658:ba2a with SMTP id
 ci16-20020a05690c0a9000b005f3f658ba2amr569226ywb.7.1706139728536; Wed, 24 Jan
 2024 15:42:08 -0800 (PST)
Date: Wed, 24 Jan 2024 15:42:00 -0800
Message-Id: <20240124234200.1510417-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1] perf pmu: Treat the msr pmu as software
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

The msr PMU is a software one, meaning msr events may be grouped
with events in a hardware context. As the msr PMU isn't marked as a
software PMU by perf_pmu__is_software, groups with the msr PMU in
are broken and the msr events placed in a different group. This
may lead to multiplexing errors where a hardware event isn't
counted while the msr event, such as tsc, is. Fix all of this by
marking the msr PMU as software, which agrees with the driver.

Before:
```
$ perf stat -e '{slots,tsc}' -a true
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'system wide':

         1,750,335      slots
         4,243,557      tsc

       0.001456717 seconds time elapsed
```

After:
```
$ perf stat -e '{slots,tsc}' -a true
 Performance counter stats for 'system wide':

        12,526,380      slots
         3,415,163      tsc

       0.001488360 seconds time elapsed
```

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
The fixes tag is close enough rather than being fully accurate. The
regression was introduced earlier by the automatic event regrouping.
---
 tools/perf/util/pmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3c9609944a2f..88b9aa7d3a27 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1760,6 +1760,12 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
 
 bool perf_pmu__is_software(const struct perf_pmu *pmu)
 {
+	const char *known_sw_pmus[] = {
+		"kprobe",
+		"msr",
+		"uprobe",
+	};
+
 	if (pmu->is_core || pmu->is_uncore || pmu->auxtrace)
 		return false;
 	switch (pmu->type) {
@@ -1771,7 +1777,11 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	case PERF_TYPE_BREAKPOINT:	return true;
 	default: break;
 	}
-	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
+	for (size_t i = 0; i < ARRAY_SIZE(known_sw_pmus); i++) {
+		if (!strcmp(pmu->name, known_sw_pmus[i]))
+			return true;
+	}
+	return false;
 }
 
 FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
-- 
2.43.0.429.g432eaa2c6b-goog

