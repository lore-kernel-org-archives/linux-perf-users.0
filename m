Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB152BE55
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766435; cv=none; b=elgs2fssrGMbl7F7y2bboGHm5Rkb5AupqgIty26ShZaFxooTxmLsaos8v3D9pVqDczdUHoH/il8YLpHB755yhX3w2Xh9KqIhHCP3ftQztbosb5yIgYSHgdCmlVnKk2W+xeESGMViRAuW9U8zLQ4j+ieSG/ZoLHjDZE/EZA5UogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766435; c=relaxed/simple;
	bh=Ndq3XZzi/EfqSQhUKNfVgunzhKMGpjb6wAnuZVaabKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mjMmOx4zYuGp5NMpmZgTZ8IIdJei6pXaOmv+vKe6F1CngDcOtqTqFHYixcJ2WdaHmrm0mdNA/64SVsslS60A29tr7Z4+LgfNK8wA1seUsqi6Et0AXFO4tUMc1rdKU7RvrlqwiZLH6StAYe9H2OrYROz7pmzKfd6pkQeV7WF5UxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuepbUCj; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuepbUCj"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-868db1b2c64so2169273b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766434; x=1790371234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=kuepbUCj36cp3VeY/T8rX8TF5lEO1AOKGx8B0LJWNR1WV8RVMfAzrAS/uddCiPIbOc
         lcTOLO+WVMIGUoeVFCZjl0Ld/EaVTVyQ8Momw7HXjz4c51d9VcxhFmgO9tIVlU4JSrIO
         mqBthpfyb6w80HnE3e/I91G9qPasYKdaFKRbkgMjkx7IGX+Rk9ar0KEAkfzCuxClkDSw
         G6lwwactgOWOU6STzao9gdSq6tEOYWuOV5AT/ED6WndX850c1MsVHDv1KiBqebxzP67W
         9uJZlnAh3w/dxnCstijKx2XqD9QlYltAsOT59FKqcC29cJufcxQq9QbvFeNj//Ve3GOo
         woIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766434; x=1790371234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=fLG/RwinaVQ+laJAQrWHB1d3rxws7poEg6YhEspfAYY8ok/O74fna9JwI2uurjNDPK
         hQQ/kf3tVXvLwU4VQjY2dh/uhriOJxoha2MtNB+QPlHW7YxQIaK0Ecqjv5bWXYnU/zs+
         0GoUElWUabhZOIsY/XSIRRsr+nsqA/aWOwuHJ5lperzgAG0bVu/AvOwEWdz3srTLHBFO
         /YotgJ3BvwZdf2Iff9T8hWJpd4kK7mu+kMEqbzCvBWkixVEi3zVMlrYEQlWCiYYLA8lY
         weplmDLtcaSG6IlKt2ihZXlDE49sxxv+kmJOatiBJnkHgY/X75DQyHhMAIqjvnzN/awe
         SktA==
X-Forwarded-Encrypted: i=1; AKwUvByuO1dziROuOUpDsNE5bocOXtWSAYhBTm0SssMQC+niFpuBoLcSVc7PP8S9tvbHsOW94zpoxO5h3BKJC3/KhO+Z@vger.kernel.org
X-Gm-Message-State: AFuF++nO+GqbRImv5rZoQixLigyzH0mk50MLMA68Pdc8tkLBeAbyHN9J
	0hUEXMhB6Ph1+7zXg9DyadJtotpCWAmYMfrASwEPqOTxWqJCgezIB3bHBqLGIvELS+zMBRRbxGy
	vU4yDswd5mQ==
X-Received: from dlec1-n1.prod.google.com ([2002:a05:701b:4281:10b0:144:cfa3:9a66])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:140a:b0:3dd:a197:cf32
 with SMTP id adf61e73a8af0-3dda197d889mr1022801637.86.1789766433437; Fri, 18
 Sep 2026 14:20:33 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:32 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-19-irogers@google.com>
Subject: [PATCH v4 18/18] perf test uprobe_from_different_cu: Scope probe name
 to PID
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

