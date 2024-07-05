Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FD155353;
	Fri,  5 Jul 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185667; cv=none; b=p8eSatjE46EMA1XO4m+9FBUkUGxB/77gdJAs65mnigF3/LnUTSX1o2IDYAI4w0zlbBX37lDNTIpdU2j7k85ydPccwFv8sF4/MAmpAXTk258c+MgXo1noIYblOsgYvcSTfo17u88CGuuWehT6XFdgjzVaWZOq+yEUIDg95+Nx4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185667; c=relaxed/simple;
	bh=CpvgJue7O4MWaSyHmJCoq1ukXf1YzFWD1+T3USR8SlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c80lxDToew8Wl+E1oKmrH8YV28RWnT/VDpeHBfCfTBOezo0ZVBd8hL1Iq2x45BvEKdPkerMPhYOgXB+nBrPRGZ0kiMvtbwPQYoaCakAZocH9bPgFR7Vn9EZT1EXs+idsCeeiioWq+1TuKtVmCn3eHxqRjeVSCBe4IHRXeD9j3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1+OizNz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1+OizNz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so1130011a91.0;
        Fri, 05 Jul 2024 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720185665; x=1720790465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDEfGupzV1QZZP9bDVKEPg1EQ2BMXRdRN/4z4Ft9J/0=;
        b=K1+OizNzOUqRXTYcVaY+B9bPeC9BtpWE11z+6Gn8uUU4XJentb49Egk4ICEKadslmB
         HSwK9q0B0ETeMh41kvoFdNMsrMyti1m//E1hn7CWb7TRwKRCkG9mZ6pOo9u+AaQBUwAU
         uBGOZI9QOoD8dKJmtR3rX706tQXHMhKro0qHsHtv3Ki17wFhOjF/F0Ctszj/wOP18Bm3
         52D5v+nC5RWNfs29U4QxhyavegWW2JRHhSVOgr/iO04w/HfrrBCE+YenyNqMkruVkqQ5
         rW3iiVEF0KSChRJxNukXj9zAFOemKS7BhLLh8muV1GbKHFyJANjYpDseU0vplG3u6YiN
         F+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185665; x=1720790465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDEfGupzV1QZZP9bDVKEPg1EQ2BMXRdRN/4z4Ft9J/0=;
        b=frt1C6xoGbLQBAHkhoMr/+q5wmsxG87bit6kdSwF3my+jFQ0+OcmmPS66uBGQItZ0c
         0AKo0ij4ZXnHYviPv8ydgTG3IlmBbcR5DvLql1o2HjffCXkI/h9S4ts+bnDQfeWn/SYQ
         9tFfeG92aLXLn3ZGX6CdduwtOt/O+pTRw77CJnhoXgSwtdjHm4bl6GrGcWsxnY5XmWkx
         i7AIxqkUNSxF5zq75v0l+/pDLo+5uIiZFjZEqOsniYz1VJz+0d+Asru5nBOfcE50i+sM
         4p+dzguz6hbWDtWTShzU/jmhiLVk42g9Im4OFgXdVQ6iwvaEHGLdTwxSQbgTVgi79QL0
         wFfA==
X-Forwarded-Encrypted: i=1; AJvYcCWpltIwcFtFL1FcxA+zg+qGoJGYgj24QlNn/ginJFlmr4hIF3uH4Nqn2iGadlSygoDGFgx/llpdPc4j4sZ26/cbVsZv+FoEMgBZdfXY0SWaEvPwjB/qGmOS1J+JGgSR6VrA2RkfGI59ST2Lzi0C5Q==
X-Gm-Message-State: AOJu0YzLqom37Azvn2o0ykh/cFkS2FbOiABOZEW53GtjaNVxehSwU3Tt
	nnRiZ4iKTU/yxQ7kp+Ji/sxV74S4r6kQwyPQS1B/fLZhJK7zyJCg
X-Google-Smtp-Source: AGHT+IEPN/HG6eB9nCtBZ7y86WQQRj2QBqQqZw29SiAFMQAjveicX9k1pyHGfibhmRKVLLZznL+l0g==
X-Received: by 2002:a17:90b:607:b0:2c9:6ae7:20e4 with SMTP id 98e67ed59e1d1-2c99c6d0d70mr3148009a91.45.1720185664803;
        Fri, 05 Jul 2024 06:21:04 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3328974a91.19.2024.07.05.06.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:21:04 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v5 6/8] perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'
Date: Fri,  5 Jul 2024 21:20:56 +0800
Message-ID: <20240705132059.853205-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705132059.853205-1-howardchu95@gmail.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trace landlock_add_rule syscall to see if the output is desirable.

Trace the non-syscall tracepoint 'timer:hrtimer_init' and
'timer:hrtimer_start', see if the 'mode' argument is augmented,
the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
in its name.

Committer testing:

  root@x1:~# perf test enum
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~# perf test -v enum
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~# perf trace -e landlock_add_rule perf test -v enum
       0.000 ( 0.010 ms): perf/749827 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd324171d4, flags: 45) = -1 EINVAL (Invalid argument)
       0.012 ( 0.002 ms): perf/749827 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd324171e0, flags: 45) = -1 EINVAL (Invalid argument)
     457.821 ( 0.007 ms): perf/749830 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd4acd31e4, flags: 45) = -1 EINVAL (Invalid argument)
     457.832 ( 0.003 ms): perf/749830 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd4acd31f0, flags: 45) = -1 EINVAL (Invalid argument)
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~#

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/20240619082042.4173621-6-howardchu95@gmail.com
Link: https://lore.kernel.org/r/20240624181345.124764-7-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 61 ++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
new file mode 100755
index 000000000000..7d407b52bea5
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+# perf trace enum augmentation tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+set -e
+
+syscall="landlock_add_rule"
+non_syscall="timer:hrtimer_init,timer:hrtimer_start"
+
+TESTPROG="perf test -w landlock"
+
+. "$(dirname $0)"/lib/probe.sh
+skip_if_no_perf_trace || exit 2
+
+check_vmlinux() {
+  echo "Checking if vmlinux exists"
+  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
+  then
+    echo "trace+enum test [Skipped missing vmlinux BTF support]"
+    err=2
+  fi
+}
+
+trace_landlock() {
+  echo "Tracing syscall ${syscall}"
+
+  # test flight just to see if landlock_add_rule and libbpf are available
+  $TESTPROG
+
+  if perf trace -e $syscall $TESTPROG 2>&1 | \
+     grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
+  then
+    err=0
+  else
+    err=1
+  fi
+}
+
+trace_non_syscall() {
+  echo "Tracing non-syscall tracepoint ${non-syscall}"
+  if perf trace -e $non_syscall --max-events=1 2>&1 | \
+     grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
+  then
+    err=0
+  else
+    err=1
+  fi
+}
+
+check_vmlinux
+
+if [ $err = 0 ]; then
+  trace_landlock
+fi
+
+if [ $err = 0 ]; then
+  trace_non_syscall
+fi
+
+exit $err
-- 
2.45.2

