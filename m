Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5kxKLHc"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FD95
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 13:34:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c994880223so3643407b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293699; x=1701898499; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRVp3dZOza3BPJg1hP4prPeqJnELXQfl8OwEl5/3ecI=;
        b=E5kxKLHc2RkBpypwPjiAH9ejAMmO3mhTaadbxDv1Qe8CJK2fh2aizYvTBTdiBKa0qg
         cTac753lguvqEcWaT5ZpQGOvN1D5bdCpSKRMDm40+73POJOAStfONhJeWn6qDR1wtBtT
         HoPICAI2caJmoDOntjwkiH1uTYoB0jAd7nRvlcaaPKPRk6KIbyhCEmlHSOxFQPR5EK+e
         eNMERwoz3uHWQUU1SoAzHT/+0Peq0rN26eDvcxA9NF3EnDytK7NHSXNF3E4CdmbIR2+i
         ML6lLP9+9Mni0pceZ0SBP5ttuQ9iFj1NYUP55iO86JsnoQR9c8xAyz/XPSN7WSIk5R2k
         4UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293699; x=1701898499;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRVp3dZOza3BPJg1hP4prPeqJnELXQfl8OwEl5/3ecI=;
        b=k1WT+BVn/1AvO1xKjpTBehYkC5UBH5o1a37TBMQ+lepvtgTmBmIgz+8FvmCqk92gn2
         cEHrCqt9s/+xjL/OGl7kQ/t5eIQMbFu4iWrSrOIlgr0NG5rEvYuFZ4UcWNUz2i4SlRY+
         lyPrkkTOMLRirf7Hk4VVKI4s3LWBG/Zi5pIGBFVQnhw769HQYkhrUWAMZiKwMxJpxmCE
         Y+L/14PnPS94JHUQi3lKi8XKvDuFVMTClvxmKZCocg/XyEBh41JARtH4ZSbDzgrVVh32
         s73aj4LJJpf1SKHPF3xO0hVkDJQpllFNpCvw9O6f58ugpe+zh5hRtSgkXj0L2NsLS3ok
         WeWQ==
X-Gm-Message-State: AOJu0YyMPKUtrTC67UNMilqI5o36+vC5wg6HYV2Zcq3y74rbxeUDuCoE
	sProIt3B+2o/uKtXGkADdPbfPJGl0PqK
X-Google-Smtp-Source: AGHT+IEpGmq6z8SUXOSm9a+7bIuqfanFRJQ8FfDPo4Ti3gSXTSrQOwyTKUfJ4iwslN3aoy/Zf6MpNgzkPqLw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a81:ff05:0:b0:5cd:c47d:d89a with SMTP id
 k5-20020a81ff05000000b005cdc47dd89amr666680ywn.2.1701293699266; Wed, 29 Nov
 2023 13:34:59 -0800 (PST)
Date: Wed, 29 Nov 2023 13:34:28 -0800
In-Reply-To: <20231129213428.2227448-1-irogers@google.com>
Message-Id: <20231129213428.2227448-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129213428.2227448-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v2 4/4] perf test: Add basic list test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Test that json output produces valid json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tools/perf/tests/shell/list.sh

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
new file mode 100755
index 000000000000..22b004f2b23e
--- /dev/null
+++ b/tools/perf/tests/shell/list.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# perf list tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+err=0
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+test_list_json() {
+  echo "Json output test"
+  perf list -j | $PYTHON -m json.tool
+  echo "Json output test [Success]"
+}
+
+test_list_json
+exit $err
-- 
2.43.0.rc1.413.gea7ed67945-goog

