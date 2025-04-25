Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C022D7BD
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617234; cv=none; b=RIYOjuMQmrO1kZxXT/6lw7xDe4BwplRICr8jsKPLwvkjTYciFu5xMbQXanOsESK3p2qUJxF7WdBv6j9K6rLSVQJzrq38E1CR5vfY8oZIeskiuQf4SOoydTBj+If5m0gpo/R8m7oUQoKHOu+RN5nEBYVetzWphFYe3wh7qJuaplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617234; c=relaxed/simple;
	bh=KFCTNZByuOLUewbevYxsI1Ho0Fb2f3tRKqRks+3kA+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ieIKqNSlWzX/46dZBrrdOCXvVhxm+HHTllTL4dnDSLyzINLi3Eusd6G3Xiqme1ti/3aTEcht95fwCLEcLID81UsG+bUzM0YSqWwMK7BDwqNd1J8/5pijAqsV0h+DON8MFaMA6FWlL2OfzrZ492MR6sIkQLTCg/tLz1boT7VCS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSc9L5nf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSc9L5nf"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b16b35ea4aaso1169484a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617232; x=1746222032; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqL5aSRe7NRip5o9p1kJq/fQhTkPb+WAWnf5Z1SdLc0=;
        b=KSc9L5nfRwsf/6gS1THcmVMrPlZr1yr1p6ArcYu4cqna1oOczgtIVlGS2Tg2OU5veu
         vmB/9z7bae7zXFHaQWgYGhz0Ldz7l+HE/cvxAv3ScyEygKEx3jC4YE1QV1xkL4JVTLBG
         9MUw8fGAenXJ8/hfJKTdLLxQy9OohonjSmnFKWihNgH1pcAohROm/xcSio8UC3ZroVPK
         M3TRM2OWdpahV25kwq/uerNbyrcOT/PhVOaCeHqdRgjVHB+XFQ0pb78o0/fz2KrE6Azh
         A6XMcY4jQLBH431DVM4iSuB9PgTCBrjBSzaEdi55PpctbRvohP6xvIqckj+S+pm4gfTm
         Pwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617232; x=1746222032;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqL5aSRe7NRip5o9p1kJq/fQhTkPb+WAWnf5Z1SdLc0=;
        b=DO6lrd9c7cguHBhz/p9bSIqW20+mNz1/QDQLZHKFO5FdilXdeP20jJ+rwkSh8DeUAB
         II//4SNqUulUUB9SElGmT24EZsblm/ImqvzsXIctxJC8w5yKDQvmxg98bdXi3xbHYN10
         8PaPgXUpBGtzOGBFDqy3x0Rh4WseHJKMOxMA6hZC81zyRWDk3EvvyRG1ZGF3zBYuSU6g
         EMmoxbp5fwbD5uEEsFqHH0vJwQy9bj6TedmU7IjnEbADQgPH4lKr7S18uBRLvbhwffzx
         1QJyN3pF8AQsqndyKXzhjT+NNWGm0hYiEMJLX9Mau0ksPbawtQ9abSz7m5242EKR+vob
         2idw==
X-Forwarded-Encrypted: i=1; AJvYcCVKZvCc8QSuBVXsjU2A+/BGyDFexLX6c474VkY2GxVvINvzyd9PzfmiZtWMAgEx6mrxYIaYqcDMh+MjwmstO012@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1AcNw2/XcLaiiB9h+lvDHzdxbSFAcTwkcKd5gpxDJW8LIkG4O
	b6b3ZqifBDGWfN6y5ybzLes3Dm8dG5t4+xy7ndrqyU6eZAu6Vfpf0oAUUi6p6hJKO5snJvB+T05
	c2blXjw==
X-Google-Smtp-Source: AGHT+IFxmTwnav32Ao3wqFAMsFqZ8W3YUDMM4pQmneQ1C4rKRrx4+lyrHc7kj6jkvl5z0GDO6WD92smF7xbj
X-Received: from pgbcs12.prod.google.com ([2002:a05:6a02:418c:b0:af9:5717:cfbb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d0c:b0:1f5:5ca4:2744
 with SMTP id adf61e73a8af0-2045b70317fmr5325258637.17.1745617231848; Fri, 25
 Apr 2025 14:40:31 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:03 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-6-irogers@google.com>
Subject: [PATCH v3 05/10] perf tests record: Add basic uid filtering test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now the uid option doesn't race and fail, add a test of it.  The test
is based on the system-wide test with changes around how failure is
handled - BPF permissions are a bigger issue than perf event paranoia.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 05d91a663fda..308916f9c292 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,6 +231,31 @@ test_cgroup() {
   echo "Cgroup sampling test [Success]"
 }
 
+test_uid() {
+  echo "Uid sampling test"
+  if ! perf record -aB --synth=no --uid "$(id -u)" -o "${perfdata}" ${testprog} \
+    > "${script_output}" 2>&1
+  then
+    if grep -q "libbpf.*EPERM" "${script_output}"
+    then
+      echo "Uid sampling [Skipped permissions]"
+      return
+    else
+      echo "Uid sampling [Failed to record]"
+      err=1
+      # cat "${script_output}"
+      return
+    fi
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "Uid sampling [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Uid sampling test [Success]"
+}
+
 test_leader_sampling() {
   echo "Basic leader sampling test"
   if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
@@ -324,6 +349,7 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
+test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
-- 
2.49.0.850.g28803427d3-goog

