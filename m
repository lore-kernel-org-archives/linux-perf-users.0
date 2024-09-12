Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09801878
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167832; cv=none; b=EkfhAH2l4JtdRZQtoKbCHJMInlvIXplttIHR9GJMyr41w8/ttbNrn0h+uVHSoGgSJMha3J6Kq7ed6IAUA54dlTlX988yIAyzqpI8Y8gmFXgKLOvZE5qwPrPhPkdJMqn1HcQ67O/Bkv/QZD3roEYrwTiEi0cncsh5iilUwuiy95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167832; c=relaxed/simple;
	bh=jq906hnsiq4s2n3KQOjk+80IdRcLz6pmPIU3auCg/i8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BBVE5AsxbJ/IH5q+lDr+NnKhpHJexLbpKkYxaF5EmjWLjcHDZ7J5OiU5lKGxklFQ4sl1LIQJVqSLDwcYXnaoASTtZfnTg9wbyOb5xawUt9rBLu9xFYkPMlTGLPdsZxpad5oueShuq+EawS2ymExvZO5D/HnnePMDYFkLJnErYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpByxZz9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpByxZz9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-69a0536b23aso28708637b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167830; x=1726772630; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2sNGvL2VOu0liFGPuoqfsWHmc/NgIkXkJDvIf2DAgOg=;
        b=lpByxZz97LvYG/1S6b8SpTUAackgtmYJnC1wybljKMzC5XCTAWsJHh8Ziimtf6iawF
         W5K1UYRwZ+9JlVuDbAlkONRASfdy/V2rX3JviPlji2L+0W1oeWIL5YgEt53vlRossmcS
         8Zl8N/0sDqzsiPVudJp12nFSMXZjgaDxZJTVUciXxr8Q5kYwZo9xrp9NwDQFhGziHrhv
         DnzNbCLElu9rAxz+ve+eCLCn/OWcpW7QjnCZ7rztKVz5in4Y1yGLzOcUmAZwrm5OM5PL
         JBqNCji6omdMYLa38f1SAbhobGekiCwBbjXnM2P9C0gYQQTscuwCIQLLJxGw9L0j5cHV
         p0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167830; x=1726772630;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sNGvL2VOu0liFGPuoqfsWHmc/NgIkXkJDvIf2DAgOg=;
        b=oUm69qC0gjXkhfwGahRrNUBLFtdBZdl9WrF8uu0sqv6jDYRHrTuTLKabLATeuohJS2
         LCIPgXBXVuzKk9el7fb21yKS0oP3E/mhmb8KZlNP7I5a7ygQ3hdq0dZL6Dvm4MRMnY9s
         ZF+KFep5DYb1nDMD+ekHZDkFG/8e1Sh1HzxCS7oRIOGfU8XlP7bX551uVUSQJcm/x1hv
         2WJXMegRdTCM1FeMg10a2Zde8eDOFE1Tu/ytI4Y76szu5JUWYMJ4aF9RgHE7G2yiVXTf
         T5C0dg5aKl0tIIH/FuUA1Ez4iGZn+/NhdMYyHl4f6M+qwX8DH4CAyKJZ4Jqb3677ed9a
         8QEg==
X-Forwarded-Encrypted: i=1; AJvYcCU0WN578qAHH/zmLooAzfwJWZKhJ0YW9xevtX1V4DEbMJ4iwmhVOeQC0Z6X80GWOiHieTU2X4zKIX/gS7Xfq373@vger.kernel.org
X-Gm-Message-State: AOJu0YzzsvalZbs1J8xW/SsaucafPz0kGJ/eagudW9pvX1wE+fFJgdKw
	4mZktGdKEjgNz/70brj8iJlWFwYrE1/0tAwbmh1LS/9RPKT5s1tzYZSkfsBAqE/yv5zmf5/dw5a
	Nl4dXJg==
X-Google-Smtp-Source: AGHT+IE2Py4W0sZ2T5cgNqZ17XiwhcfJ06rRdCbN0ZeLEM3LB0/2WFJy/hiLXZvpx6BVirC8q0nhe9qfZ2k8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a05:690c:7449:b0:6db:cddc:a202 with SMTP
 id 00721157ae682-6dbcddca3d4mr15947b3.5.1726167829840; Thu, 12 Sep 2024
 12:03:49 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:27 -0700
Message-Id: <20240912190341.919229-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 00/13] Tool and hwmon PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Rather than have fake and tool PMUs being special flags in an evsel,
create special PMUs. This allows, for example, duration_time to also
be tool/duration_time/. Once adding events to the tools PMU is just
adding to an array, add events for nearly all the expr literals like
num_cpus_online. Rather than create custom logic for finding and
describing the tool events use json and add a notion of common json
for the tool events.

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

v2: Address Namhyung's review feedback. Rebase dropping 4 patches
    applied by Arnaldo, fix build breakage reported by Arnaldo.

Ian Rogers (13):
  perf pmu: Simplify an asprintf error message
  perf pmu: Allow hardcoded terms to be applied to attributes
  perf parse-events: Expose/rename config_term_name
  perf tool_pmu: Factor tool events into their own PMU
  perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
  perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
  perf tool_pmu: Move expr literals to tool_pmu
  perf jevents: Add tool event json under a common architecture
  perf tool_pmu: Switch to standard pmu functions and json descriptions
  perf tests: Add tool PMU test
  perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
  perf test: Add hwmon "PMU" test
  perf docs: Document tool and hwmon events

 tools/perf/Documentation/perf-list.txt        |  15 +
 tools/perf/arch/arm64/util/pmu.c              |   5 +-
 tools/perf/arch/x86/util/intel-pt.c           |   3 +-
 tools/perf/arch/x86/util/tsc.c                |  18 +-
 tools/perf/builtin-list.c                     |  13 +-
 tools/perf/builtin-stat.c                     |   7 +-
 .../pmu-events/arch/common/common/tool.json   |  74 ++
 tools/perf/pmu-events/empty-pmu-events.c      | 208 +++--
 tools/perf/pmu-events/jevents.py              |  16 +-
 tools/perf/tests/Build                        |   2 +
 tools/perf/tests/builtin-test.c               |   2 +
 tools/perf/tests/hwmon_pmu.c                  | 243 ++++++
 tools/perf/tests/pmu.c                        |   3 +-
 tools/perf/tests/tests.h                      |   2 +
 tools/perf/tests/tool_pmu.c                   | 111 +++
 tools/perf/util/Build                         |   2 +
 tools/perf/util/evsel.c                       | 287 +-----
 tools/perf/util/evsel.h                       |  28 +-
 tools/perf/util/expr.c                        |  93 +-
 tools/perf/util/hwmon_pmu.c                   | 818 ++++++++++++++++++
 tools/perf/util/hwmon_pmu.h                   | 154 ++++
 tools/perf/util/metricgroup.c                 |  35 +-
 tools/perf/util/parse-events.c                |  62 +-
 tools/perf/util/parse-events.h                |   5 +-
 tools/perf/util/parse-events.l                |  11 -
 tools/perf/util/parse-events.y                |  16 -
 tools/perf/util/pmu.c                         | 104 ++-
 tools/perf/util/pmu.h                         |   9 +-
 tools/perf/util/pmus.c                        |  16 +
 tools/perf/util/pmus.h                        |   3 +
 tools/perf/util/print-events.c                |  36 +-
 tools/perf/util/print-events.h                |   1 -
 tools/perf/util/stat-display.c                |  14 +-
 tools/perf/util/stat-shadow.c                 |  22 +-
 tools/perf/util/tool_pmu.c                    | 508 +++++++++++
 tools/perf/util/tool_pmu.h                    |  56 ++
 tools/perf/util/tsc.h                         |   2 +-
 37 files changed, 2376 insertions(+), 628 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/tests/tool_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h
 create mode 100644 tools/perf/util/tool_pmu.c
 create mode 100644 tools/perf/util/tool_pmu.h

-- 
2.46.0.662.g92d0881bb0-goog

