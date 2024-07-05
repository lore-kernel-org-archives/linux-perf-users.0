Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF5149006;
	Fri,  5 Jul 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172600; cv=none; b=ijQMK/BfnPDIVPbwnqe5oIAbInKcvpuOLFyQ9Ae5M11vH+b9VChmSNqbmoqU3GNBgI97lTXx5FzPC5Dcbht/zIAx9QKTY3PGEwQnlJNC5vgXmTxRgeYAepccMhn153vcdSi+TGsLLFP3cqeLQrd8+U8YvJcqxeONR6cY0wZreWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172600; c=relaxed/simple;
	bh=CpvgJue7O4MWaSyHmJCoq1ukXf1YzFWD1+T3USR8SlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVkKEPsoKTFX1+eNiyqTBWm5OX7ydCZNHOPkflRz25aoIEfB+029r9pWB7s29cLUkOEZQYlwPYEcc3u0qOT1LI4yF9irYDxF7UEgBXPXMI9dYzEP86DaUU0M3axpeaNE469eoVFGxXg6CiPpUqRFrkYQjmTggoKJJL67FGSmmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JduqxKjp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JduqxKjp"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c9a8313984so670642a91.2;
        Fri, 05 Jul 2024 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172598; x=1720777398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDEfGupzV1QZZP9bDVKEPg1EQ2BMXRdRN/4z4Ft9J/0=;
        b=JduqxKjp+PzzA7J1e3Q9lXaAGBZJHL1sXGKi/q0UJBWOBAs7i5DQn3WQ45s7cgRhsr
         tzHKfIKwgP2bM8JM9Km2GQmtwD0OjfwFyOUsyzA0Ark4oMC2vay7k2u+F7HdQx0CpzSd
         SdM/G+fH0Fm0MdZXdnaCkiKROiH3IWz4pnp65tlccg3PWWqkU3OJjXIZkHKPQ+dm/9Kz
         TUGLo/nJ3ZES0Ll847+bIzsTh+mz329MEh/Zx9jjQ7l14PigvX8s6Spp/PBKLu8N5IXs
         RbvFhAufmRQ3sfHd3zUOMHUODiYDNrQGQZ+3movAq69OFQOmxJX7yCDpfUYbuS3vIa6K
         Zuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172598; x=1720777398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDEfGupzV1QZZP9bDVKEPg1EQ2BMXRdRN/4z4Ft9J/0=;
        b=UvO3g5ryrzpTuWpJHh2WRA0963v9biBPTCPCpZ94Dh8VS8ZllIpbQMjQq6B/q4EwHa
         dxxwk9zSW73egMaER5R4Nk3RASL4Yv4tnkrEZCC9EdGS/cep1y8HnZxd3HwFXLVmuA9N
         RvuIOJ/xbGnn6IPUfmR6C9DE3mZkthZwL/xyZzseJDZDcQ0G/3EItPyFz5xTketlIuYX
         2+lRmdto/HfA3f9wSx0gdy5tF7deAEikD599VfjLXGrK+f2qp9B3Auldx1GwwmroAO6F
         4JwllrcIDEHha2iNtsSd9H7xIwlUnG+SknfjaGTpkWK2Ll7GI30QRhgJlN2o/I5WdZvc
         dlsA==
X-Forwarded-Encrypted: i=1; AJvYcCUhT5o7B2cNCFiocWYtNPoAdCcowq3E8ZhYS2mp54Xi6Di/UtPAZJiTwVaKrhoMLPa2g+XXhfVwYLc+i19fEtV3DD9o7zXM+CiOzDKAoNpoLgpunpyvf97sFEfptYzL+OFQa6przK/KFm4ySVKwVw==
X-Gm-Message-State: AOJu0Yy9XyZeFqvs7G4bddry56ENP7Q0ORuV9b94w57iFwNWZiYHf0I+
	LDm3HhQcxNX9v402devTMQswxxG4Y/+AMbbG+XrjbMk+9hA/s9l8
X-Google-Smtp-Source: AGHT+IFzOurEbabGnGBT/WpDtvo44CVzKyRva2rHCUUjx1stBQVbaqa1Jd149Bqbqw1xGuk4/Q6fmw==
X-Received: by 2002:a17:90a:17ca:b0:2c3:cc6:636e with SMTP id 98e67ed59e1d1-2c99c5057c0mr3039248a91.2.1720172598566;
        Fri, 05 Jul 2024 02:43:18 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9cd133sm2958138a91.38.2024.07.05.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:43:18 -0700 (PDT)
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
Date: Fri,  5 Jul 2024 17:42:58 +0800
Message-ID: <20240705094300.585156-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705094300.585156-1-howardchu95@gmail.com>
References: <20240705094300.585156-1-howardchu95@gmail.com>
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

