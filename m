Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99911F8191
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026394; cv=none; b=OUfG54uAg49zRG3SQMB/1o7HE2gu4AO6rnOt/FbEQj5V0Y4w2EBENmxtbLBGV8rS5bI3cRXtPC9UuGFxTrmxxraKqeoKJV1qzBp1KifXcf6qChvf82HLdLMiXXN75J2vsTg8H+cKnMO72OQRrDb+1zQYkWphpRmuW+tDewwEJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026394; c=relaxed/simple;
	bh=usrc87swuiIEZtF6d3XncI94QYmPNZzDpOf7pgjoktg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=aO+GXaxYC6nr+rxdb9A4ouqRl19GUyGxfPOTcjd3z8i8P21j6fMcxsm9MYPkLIgtUjNH+IGTTw9kj8IftjMotQoaop/odl0oplyEAte782SMwEedoVbkEmtsuTd60c1xxgzayYOkJ2o/fT6JESNlNszZlYh03gTaxq7evdb1PpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTpM1KAD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTpM1KAD"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso7219674276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729026392; x=1729631192; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V3V7UdMfheJVSkt+63c8FaFurZG67J77B0wKxX03R3U=;
        b=XTpM1KADwjXaBl0R/PLxol+qyRsrTnTWNGdpo9VygKW/kZ2jpWhc+neYxa9Mz01IA/
         csxQy63Rwd4euwfXJ3wNv5MEhSBxxm72hm1ecbo1X9WB1L06ScIIax4bco17Th8cclko
         GOT5opzRVAAh9Dgj+Cz75satN3jEGbBGAcySKJZd87QPCQmEfOJ1+9OHdIdLR/asQ2B5
         tQyShZTzI0betViK1f/8Bvd03Mekx2pqjJJqPKdznUf6y625L93acZOsL7yloqM6XswE
         /lIenm23vuh7yrWDmmsDOkmkinfACND+gRYiJaBT0gPgMEySfPZiYIv+/YaluxarxMps
         BleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026392; x=1729631192;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3V7UdMfheJVSkt+63c8FaFurZG67J77B0wKxX03R3U=;
        b=jEgrMw2D1whFCrYlkUa19Y8vHkWXY3gVx3mtKPCVQHJnpCujxNd9lRB12Vn6WdUiyD
         4/ZQI11hox0TzDg1ZRKD/V9Hye4Tbo1Vnozek77/da2ufzfqAO78cGs5spck+OzdOsxN
         QdnKnMvz3kx4OvUFCv/PxWPDpIKi6P9jzIxyS5zAJNchffnkM1VDXczadgSqoIiif0wD
         Y2UAjpanzIJIbPKeQ8kbMC2KcOLn/O5r8yxgg7tKemCG0I8mFnTUD44s+1OSRmHDAszg
         SkCQs4TBY9lbEmd47gulUyiNRAf0NdtWs8B4B9vz+bIy57kD2nwII6113Pp1Ot0YX5VQ
         +OcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs5WkhSviAY5v3VIrgqrlFHlmTFypwho5lSESu5iqURNXwdNHeUw42g7xC085+0/JXs0IlqFq59Bk4WKFmY9dX@vger.kernel.org
X-Gm-Message-State: AOJu0YzVW6ujmjPUt6J6rbxQm87iV8A8FQFq29vVBrpcdlLxctjgomxW
	f/b68ChG2k6Fm0qc3VRw0z2fgmx+NpJhHNi5JvuHh6ZJzZ1McpCEPCQgFehJQ1AyaFof+dRKpMx
	PMK9Faw==
X-Google-Smtp-Source: AGHT+IFLQsMwt3RmY52ZnYdbWUmPSehl8+s1WJ6zwIO/r6G9EmOdNoktGWTpz27Avayxp+cRjctmzTvF362C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d08:b0:e28:f6b3:3666 with SMTP
 id 3f1490d57ef6-e2978567367mr1383276.7.1729026391842; Tue, 15 Oct 2024
 14:06:31 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:06:23 -0700
Message-Id: <20241015210629.1150428-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v4 0/5] Hwmon PMUs
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
	Yang Jihong <yangjihong1@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.47.0.rc1.288.g06298d1525-goog

