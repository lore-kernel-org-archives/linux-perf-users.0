Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FD21830E
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021712; cv=none; b=UKNzL0iKpUtV3lEwTNmyP4IL0NI9bLC4ORBaMh/WxHhJd+DDM5Xe4ZJhK2aYSsmJ1PnLfEAEVkT2pX//9yvk8P5Ia0g+qG8QIQwXtFbIKM62aKZbzfQGrnf0qqSnrDFS6t/xpEVJiSXboZ3ItbxIFqjMcc/bsZVUdR92CmBdgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021712; c=relaxed/simple;
	bh=ajTnG6Q7byyjECqEyCgacr8k/6C+th/DgduDEADABGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8fWRtX+XVDuEIJlJNyEjWijOgWGKS5N44fJ832kA/o+AjVSki6lxaNtFN0oXsnv0c74tIwEzBOU3V3t4Of14Lnyxu1WYWSRe7vCkPnS4tXPwN5pA5g8j6QvFLTbKZSC8o6dLOoGJDr003PhzlYqDhwM5XcSO5w3BMVdGbvLzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=UUzlyPbV; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="UUzlyPbV"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83aba237c03so62888039f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 15:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731021710; x=1731626510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aeskaT6zkLjjpuoEwx+3cH3yJ2vmgNjTv/hFcPPqA4=;
        b=UUzlyPbVYcgPelhV6mwATmiFQBKa/PW7sBIwJ2RWKwZqV+I4rWasHAGmL7x9potEDT
         l3+9EE2oliCRhWCnvtkdFXFjumVDOLRMcfR0IXW4HjkwjyBj3f6gcMuPY2rehJkU5NKD
         dOfDkdb+XgPQzYsAe9xNGEKNK9fZXxpRiNcTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021710; x=1731626510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aeskaT6zkLjjpuoEwx+3cH3yJ2vmgNjTv/hFcPPqA4=;
        b=jxVl2LjI9wFoxHoQXiiKO0hdeehXi0xUsBdNOzzA0FXMbjbx7itvm+IC5XbcxoH5PI
         Ps2Sck+ZoSXHzS2NfhSeh6ggz4E8AlOiRzRWkvNfewGEW1g/5W4MQ01xQDPpJAWWLWTm
         CXOJfUdPLH1X5yKUwQ9bZFWudWMbctPT10+IUSTML3wCpjQ9WczcmqtAGyimns8iYzTf
         BhKQPY/fIRMpInPLQ54qN2/vd95pJ0gdPEGN6lSNvG4nzSfHinM8iLxOdahhcA67pZF7
         OoK8JYv02Eq8Lh/hP65DLFnZ55tikiN+UOwYXzOZKqFtK39bDYhecDCfZ9tZDe/Bl2N+
         /WxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPf4jgbYu2qDrI6RqYnM4K2Ux0+9hF6qkJPjZ+BJ5D8rfRpJ9zQQSRCDopjfEgV4YCWKFtLU3khAeFziMwX1kF@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6VnWsuA13k838fF4/3yjtWd5D42BWtqXC/imyjQ6M8hzMn0p
	PKJqEKHql+8mfrUYKJNFkfuIfgD3QjoiaIEQwxchGFdEB1GY4HLC+8w4X7hSUTs=
X-Google-Smtp-Source: AGHT+IEz999ziNrkDZ8HCMHUgj6ghL8MBc8L/YlSroKbciLffQgCmkOe8TuOAfHulsCKw7584GQM7w==
X-Received: by 2002:a05:6602:160e:b0:832:40d0:902a with SMTP id ca18e2360f4ac-83e032a1a31mr84060239f.6.1731021710282;
        Thu, 07 Nov 2024 15:21:50 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-b.c.engflow-remote-execution.internal (93.126.232.35.bc.googleusercontent.com. [35.232.126.93])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f82e773sm533023173.68.2024.11.07.15.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:21:49 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2 3/3] perf tests: add test for trace output loss
Date: Thu,  7 Nov 2024 23:21:28 +0000
Message-Id: <20241107232128.108981-3-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107232128.108981-1-benjamin@engflow.com>
References: <20241107232128.108981-1-benjamin@engflow.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that checks that trace output is not lost to races. This is
accomplished by tracing the exit_group syscall of "true" multiple times and
checking for correct output.

Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_exit_race.sh

diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
new file mode 100755
index 000000000000..f9cfe44bce86
--- /dev/null
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# perf trace exit race
+# SPDX-License-Identifier: GPL-2.0
+
+# Check that the last events of a perf trace'd subprocess are not
+# lost. Specifically, trace the exiting syscall of "true" 10 times and ensure
+# the output contains 10 correct lines.
+
+# shellcheck source=lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_trace || exit 2
+
+trace_shutdown_race() {
+	for i in $(seq 10); do
+		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
+	done
+	[ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "10" ]
+}
+
+
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+# Do not use whatever ~/.perfconfig file, it may change the output
+# via trace.{show_timestamp,show_prefix,etc}
+export PERF_CONFIG=/dev/null
+
+trace_shutdown_race
+err=$?
+rm -f ${file}
+exit $err
-- 
2.39.5

