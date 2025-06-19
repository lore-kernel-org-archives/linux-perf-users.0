Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0883F9FB
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292441; cv=none; b=fFYVa3sD+Ns/p4ZE4Fspz7zSBZmPuREIxXUcuhmTfkzbx+CecGijtpyfaFdMerk5OFH1tC+Qyl/TrR0FM+ibamh04VbF9bDyIMlEJMJ9Myke1yijkp8Cdx3pUZQw/SXK3IiryxzekWB2ggnuy75VJtQ4vAQ5OVyEGqBJVjNhSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292441; c=relaxed/simple;
	bh=TJzEuRcTs3pgnl5+aNUn6R+549T0G5ZtZVRr/ru1MtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jJQrfdHht/1UW3ezYXloq1Q6Jh4B+S/Yk5qyA9uDFfFKJYH5blL13swZ36LqXC7ddhbKG1jpQ9On88h1pZTjUbvJd+eKtTqg1izPk29NMnRF7a5zLBULSrKWCHOThRBptAFvZC3c1u1DjXgSqSaTVKZxmYKnHZcTYRDES0W1NV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AV7aCawe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AV7aCawe"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235196dfc50so1789205ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750292439; x=1750897239; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tPEaY4LYHaNMR9iNHEGQNkRo5fkHgYkHVhgZiejUeM=;
        b=AV7aCaweZ17iqHY8BwvNEwbgWUspFTdDkn9EolAeBp5e2eVrAmqM7VYFElPOvsVEH3
         5sGpznhHVbZXXJLVsYBpR930VIn1L1OhNOtFZ7+4nbWCDm+W2xvIEAQdg/lu9W7YfZ7c
         h6c1bYdcUvZ/f7sb5afdldfGC8i3ZN2EE5HY3lQoo9nRA7XqrHTI4EEGExBN2MPRYL/T
         yaDbjojefIaMCevGAcHMmNfLCF5UWhx30UbOS5IQdYBh/5mCh6/6qlINruqajFPS1YlF
         GdF2wDXOBstb+HBx8B02ofUgWNZ9uf3zrdSHycOxeuie4nZWJiujQb441oT6BcYeHi+2
         CCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750292439; x=1750897239;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tPEaY4LYHaNMR9iNHEGQNkRo5fkHgYkHVhgZiejUeM=;
        b=MUOEX9mmjIK5knIxmgAL5nO/AKA2R5kUoBpd5/7JwdyZIHiY97ggSwwNMCizzizaY7
         NCLyqn9fVfzAQ3B/4UK+zX7A8HADbApD0/hL5YPwNmVjmYXHIRJt7bpxpzuQhgsDhc+4
         3TCJi6A+8dCl/K2PNaXGxPwJZoO+kJvgFhnilSNPyJW2GZzO2snh8155lwWbXsyKdDTq
         5Z6Oz65cyFlGv5BqgnArNOl6VyW3kjn14o6LlTp9oJVWaGrizZKKX2CKsRWDy/fvTA90
         HaYjyLgz1gi2BVIz5gmeiHoSe1mXbvtEWreus+cTUDtIWwVNkpINnvuaA3UO73gsTZ/L
         FHVg==
X-Forwarded-Encrypted: i=1; AJvYcCV6lnzzBRPPdpyl+onbGGzOJk1+BNgg9J6+beDK888kCeHabSmyxgQHbjR+6hr0sbbL/ZN0SEyBLJh0rR79GEUb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xDETHSpfs2AmdwOLRqizd15+AwTByPBXJO+ahx+pklCwFM4u
	Gdo3hPwpe7kudWVPfRBb84VQ7hLFPA3R7euL82+MZfPSSG68r6oDilM16fj7gWTVBTdvwKcQRJG
	Oq9eLq77tnA==
X-Google-Smtp-Source: AGHT+IFVrRcx7oQgwwfjZnSnBmzKEeXLqPtQpJbeQx8kRgrjbWTDw8AznIlz5aWVyIMWMyTUZH+yQf/VYvEV
X-Received: from pjbsw5.prod.google.com ([2002:a17:90b:2c85:b0:313:d346:f02e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c6:b0:231:c89f:4e94
 with SMTP id d9443c01a7336-237cbfbb942mr22430385ad.21.1750292439404; Wed, 18
 Jun 2025 17:20:39 -0700 (PDT)
Date: Wed, 18 Jun 2025 17:20:34 -0700
In-Reply-To: <20250619002034.97007-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250619002034.97007-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250619002034.97007-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Add sched latency and script shell tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shell tests covering the `perf sched latency` and `perf sched
script` commands. The test creates 2 noploop processes on the same
forced CPU, it then checks that the process appears in the `perf
sched` output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Skip the test if not root due to permissions.
---
 tools/perf/tests/shell/sched.sh | 91 +++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 tools/perf/tests/shell/sched.sh

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
new file mode 100755
index 000000000000..0a4fe3f414e1
--- /dev/null
+++ b/tools/perf/tests/shell/sched.sh
@@ -0,0 +1,91 @@
+#!/bin/bash
+# perf sched tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+if [ "$(id -u)" != 0 ]; then
+  echo "[Skip] No root permission"
+  exit 2
+fi
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test_sched.perf.data.XXXXX)
+PID1=0
+PID2=0
+
+cleanup() {
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+start_noploops() {
+  # Start two noploop workloads on CPU0 to trigger scheduling.
+  taskset -c 0 perf test -w noploop 10 &
+  PID1=$!
+  taskset -c 0 perf test -w noploop 10 &
+  PID2=$!
+
+  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID1/status"
+  then
+    echo "Sched [Error taskset did not work for the 1st noploop ($PID1)]"
+    grep Cpus_allowed /proc/$PID1/status
+    err=1
+  fi
+
+  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID2/status"
+  then
+    echo "Sched [Error taskset did not work for the 2nd noploop ($PID2)]"
+    grep Cpus_allowed /proc/$PID2/status
+    err=1
+  fi
+}
+
+cleanup_noploops() {
+  kill "$PID1" "$PID2"
+}
+
+test_sched_latency() {
+  echo "Sched latency"
+
+  start_noploops
+
+  perf sched record --no-inherit -o "${perfdata}" sleep 1
+  if ! perf sched latency -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched latency [Failed missing output]"
+    err=1
+  fi
+
+  cleanup_noploops
+}
+
+test_sched_script() {
+  echo "Sched script"
+
+  start_noploops
+
+  perf sched record --no-inherit -o "${perfdata}" sleep 1
+  if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched script [Failed missing output]"
+    err=1
+  fi
+
+  cleanup_noploops
+}
+
+test_sched_latency
+test_sched_script
+
+cleanup
+exit $err
-- 
2.50.0.rc2.701.gf1e915cc24-goog

