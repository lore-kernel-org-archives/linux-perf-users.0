Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BE2F36
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146965; cv=none; b=Uvjjkdlraxzh3c0L3CMcnD+TWfaaJFWUzozh+cZw/ZOpBOiPBDFQ+I+itiU5yk7yPAFwOzxcCV+tL/guzh9ZiXZSwwn6zDXa4dN6RGShkGYAkLrb+yYYNrtG/w5w2Rv+WsfgV8rT8nT0XP6RqsdgBU3K1gnT6STiEcArF7is5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146965; c=relaxed/simple;
	bh=7J/m0cVLAJYE5mzoKbcHuAxM6Fkg0GwDOHT/ePSXW3I=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=VYn73JfAz5ujL88VhkFrn6ZaNjn3t6yO4JOM2SoEevRd+zaOmMSxgdSFs7VSJ4TcaF1JDNL7vrR7F1Br+slvqktCBaPXgl4aAioS1zjrhtwErYDaNntMJP0wa2bvI1sb5QgrlFe6889zFYh22XigEqpOUauO7JZk9ljmcO0chVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1EkKi6y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1EkKi6y"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38562155bso8929277b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729146963; x=1729751763; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uuP62fKgSKaN5wKlRPCIOtPciYOVRGvenvpBJZ6RRKk=;
        b=x1EkKi6yGcgXTkvCJyFbpfraP/+y3PYzQVilo4DH1tXrYH7QfDWa4f2/al+qJHBNob
         sYhVYcllDNqWAogO5cSqbyiN3VAX1H/q1K3sxZlzcmjEkqNZCjwY8AxmKGZIvR9JKsG/
         MKFPHd25vCOA3EBcbVcN379HUfXBywoUAKVJrtDw+rFjGEd7QS/WwTt71CWiO8tbjo1q
         N0fabhCBiLfa5t/QfQ7aNQl3ZlchT2mdfEG4OdbVgXjPJF6up8nAr4jZWZgZG4MZ6FTF
         YG3dr3//oeFsiAJXGNVZpVyUghbtupp1ZiYa85SPFi270Wr01n7vP+o7OhJT++EbV6v/
         798w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729146963; x=1729751763;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuP62fKgSKaN5wKlRPCIOtPciYOVRGvenvpBJZ6RRKk=;
        b=UZJ2dogPGLstT+ZV64SIy/ayDdWU89ncsk+axq/zIHYj1S6IQ/ndgHW4z2sE0u8EYf
         3CeZbEVLt47Nc7Si33+WLncEWAe3U5XZfAT6M8TX/ldNjSnSRZDol4J9eCDu5et05+so
         Q0wJpFSIUrQivkqc/iSSTCafAtyHnglKWD0IkU+pACSegKvxvl1Tri/K98GLDsAmAOw+
         OmobGrFkZNFxcc2+Pn1WvZfHEvQqOmnfsSA4Sku+BqO9Af+fCnADVDm2JU/eEKaPD/Vx
         oqL5u0LgQrvY90FWV+YVJwyIk4pvAgQzskTXNHUM5x9e0i08fEjRXtyu0FzwaLukr8tD
         O4kA==
X-Forwarded-Encrypted: i=1; AJvYcCVHZjXOWyK41poCpcWk+Oa7QYkITkyy7WxByWXFhulmN3HhpHFJOV/7lGFhMaYxYxNvsGEPAStFN8234ljfjUZG@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtF85E9c162rmWWup6S2ycckB7ep8Fm3SNAM/ASZnQtGF5j35
	gtLEtX2+VivUbzhhnwAuQ85AeXS2QURwqnSp7p5PAG4nwjD6SVvuyzzL8CCGi1DtEOGXdOQbINv
	rmt6mTg==
X-Google-Smtp-Source: AGHT+IH0c5c2+SOAZYYigGPsrUE5v5DUMsPFhy9hNP8ALMBXGZOLuW9zeqtpiBkyAAhD4EHptZu0Xkl5pbCi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:25c1:b0:6e3:6597:222f with SMTP
 id 00721157ae682-6e3d41c8379mr1193537b3.6.1729146962804; Wed, 16 Oct 2024
 23:36:02 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:35:50 -0700
Message-Id: <20241017063555.366065-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 0/5] Hwmon PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Following the convention of the tool PMU, create a hwmon PMU that
exposes hwmon data for reading. For example, the following shows
reading the CPU temperature and 2 fan speeds alongside the uncore
frequency:
```
$ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
     1.001153138              52.00 'C   temp_cpu
     1.001153138              2,588 rpm  fan1
     1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
     1.001153138                  8      tool/num_cpus_online/
     1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
     1.001153138      1,012,773,595      duration_time
...
```

Additional data on the hwmon events is in perf list:
```
$ perf list
...
hwmon:
...
  temp_core_0 OR temp2
       [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
        hwmon_coretemp]
...
```

v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
    the update to perf_pmu to use it. Try to make source of literal
    strings clearer via named #defines. Fix a number of GCC warnings.
v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
v2: Address Namhyung's review feedback. Rebase dropping 4 patches
    applied by Arnaldo, fix build breakage reported by Arnaldo.

Ian Rogers (5):
  tools api io: Ensure line_len_out is always initialized
  perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
  perf pmu: Add calls enabling the hwmon_pmu
  perf test: Add hwmon "PMU" test
  perf docs: Document tool and hwmon events

 tools/lib/api/io.h                     |   1 +
 tools/perf/Documentation/perf-list.txt |  15 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/hwmon_pmu.c           | 243 ++++++++
 tools/perf/tests/tests.h               |   1 +
 tools/perf/util/Build                  |   1 +
 tools/perf/util/evsel.c                |   9 +
 tools/perf/util/hwmon_pmu.c            | 820 +++++++++++++++++++++++++
 tools/perf/util/hwmon_pmu.h            | 154 +++++
 tools/perf/util/pmu.c                  |  20 +
 tools/perf/util/pmu.h                  |   2 +
 tools/perf/util/pmus.c                 |   9 +
 tools/perf/util/pmus.h                 |   3 +
 14 files changed, 1280 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

-- 
2.47.0.105.g07ac214952-goog

