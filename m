Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B74457AC
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627396; cv=none; b=tX95GbK8IHgq408pIKQokJXcudX6jfonfbfX0ZHtNXK/y6hop5dGDmpAj1zZWP/8TovdtHIqUssVzC80aeb0vYLNoCNZjE1e4m1S1iPpXA/qAF5nl/zrNTCshRkbNqetu5Inkf8xXFG5wX30ExLj2wXXeLd5Mij4TzcVHsjHfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627396; c=relaxed/simple;
	bh=Ndq3XZzi/EfqSQhUKNfVgunzhKMGpjb6wAnuZVaabKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VvJnjK/+wvujJWiGqkRTWfJx/hH4Uj0dCnnHlFp01vtgu53BvGyTuOrQmKA7wN4D1czEk4b+nJgQw3H+fbZOeViqx4KTMLxEropnGaJfRs6D7qM3SsNcXP0ztRG27aBOmMgo5CWAIs4wGcmn7lJoL/CXAxkPG4/y0EXeuwlU8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwvRS+AJ; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwvRS+AJ"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396901263b6so1009789a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627392; x=1790232192; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=VwvRS+AJzgJ6yZowNbliN0GTMTsOS2d09TZjbuTKVMyyMZczGVmJt5A4GBc6x7xXkq
         26UGxKrchJWwt9k6HnMHaxIoL8J6llYBAgJudZqCpidY9KmHA0mLTFrX/nxxJENOZZtk
         nMbaAryqpMDe5fYYz1YhMpUFgs/O120KP92OTDqWUnAVJi+G3iOWMVUp4JPPFpZL8zae
         0FAlnWNC3g9oSsa50zq22FRnREuZi3GZaYgvs5ntUs+RCagClUVSSbj6f3FCn9OHGsLm
         jI780lUOvzZMN5rggoy+biO9nESk/XlwJUkicUVYzibP8etuqahD2jXXuekoebjDlF8u
         cBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627392; x=1790232192;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=FIlvsunYKr/pl7psGLtVc0g5SFB6EXZVPX5nF39899PNyXUsfv0gqQ7IHC461n1UWA
         QANzYA70Y102gnw3arpw55kYjGPsmYIRTZN+mAG/fag4eK3d7ggZZscqy6OqJwaUNOw2
         UrmA9xkVU1nN3oeSlPW135oIOwcsOaDVqOLLogfe/T9gZBc4EL4b70fcMxNtLWjBUA4Q
         u9Qy5CdlgeDkLAlJ3J7/hgEaFCmr/GOySexLPM0zSX0hJqpDOPtKKuRaSEPip39uD2Yl
         npQ482DMmuMMvVDh2sme/fAmCuWspqS3FZMIUdZbFYyZ3FB1wEzd5ZMZcBarUJBXKjcf
         JFyQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0sDTYW/8o+fdj1Nq7DrVwF8ZWh5EIyB9tL/BEfkxp+eMjXvngxa/BLDCtQGzO2m4oqQZAugoxYfOTEkTNL0Jn@vger.kernel.org
X-Gm-Message-State: AFuF++m1imWazBob0KahxHoqI+l1NH/rr0SHunv7K6Yv05tADqlIeYjv
	lVDl7mtek0F7aaDiqy/lUrl3s0W5D2DRXTwtJzuzUI/ubz53/hg7UessMgoQQalKY3K8afqArcK
	Lod/qDMD0Gw==
X-Received: from dlc21.prod.google.com ([2002:a05:7022:395:b0:144:bebe:a64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1811:b0:39d:e54c:8658
 with SMTP id 98e67ed59e1d1-39e1e250230mr16608214a91.5.1789627392115; Wed, 16
 Sep 2026 23:43:12 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:35 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <80beb357d1eebd77f99982fbf4741e8b5fefbafe.1789626978.git.irogers@google.com>
Subject: [PATCH v1 13/13] perf test uprobe_from_different_cu: Scope probe name
 to PID
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The test builds a binary in a per-run temporary directory and probes
its foo function. The directory name is unique, but perf probe derives
the event name from the probed function and the group name from the
binary's basename, so every run registers the same probe_testfile:foo
event.

Running the test concurrently with itself, as 'perf test -r3' does,
therefore fails in all but one of the runs with:

  Error: event "foo" already exists.
   Hint: Remove existing event by 'perf probe -d'

and a losing run's cleanup goes on to delete the winning run's probe
out from under it.

Name the event after the pid, foo_$$, so that parallel runs no longer
collide. This lets the test stay in the parallel pass rather than
having to be marked (exclusive).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/test_uprobe_from_different_cu.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 7adf9755d6de..47c99d93436b 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -18,12 +18,19 @@ fi
 
 temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
 
+# The name of the uprobe added and removed below. The probe is placed on
+# ${temp_dir}/testfile, but perf probe derives the event name from the probed
+# function and the group name from the binary's basename, so every run would
+# otherwise share one probe_testfile:foo event, and a concurrent run would
+# fail with 'event "foo" already exists'. Scope the event name to the pid.
+probe_name="foo_$$"
+
 cleanup()
 {
 	trap - EXIT TERM INT
 	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
 		echo "--- Cleaning up ---"
-		perf probe -x ${temp_dir}/testfile -d foo || true
+		perf probe -x ${temp_dir}/testfile -d ${probe_name} || true
 		rm -f "${temp_dir}/"*
 		rmdir "${temp_dir}"
 	fi
@@ -84,6 +91,6 @@ gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
 gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
 
 perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
-perf probe -x ${temp_dir}/testfile foo
+perf probe -x ${temp_dir}/testfile ${probe_name}=foo
 
 cleanup
-- 
2.55.0.1082.g2b9226bbc0-goog

