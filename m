Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA641AEFD5;
	Thu,  4 Jul 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097062; cv=none; b=cxBDx14DwZE/ib6BcBnsIeTPmHGmy6MPHGThADB7NMchfGm9Rf2vMlRHBBhhGvSwet6xkzqRgyYON9F4kcFqfKlZz28U4rJ6GxxYNF+agby6gXwMyzYxmbspAdwWnDRKV/r4DFztU93RKdkeOlh0KJ/SrSuDIONOaXQEC7HFDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097062; c=relaxed/simple;
	bh=BEB58jmhgFBt8hBVpkDwswlsxmcPeMe5P4dNnOzglMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsKnAnorCf6KLAppRmdpDa1nXABA9q18VrsZS+tbYZBsoQKwE8mVa99mrfln9yA4DjGmvSlJJ653xNAuEHQp/VYsj+4gT+FBHSJvpX//8jn63N+IybVLPBbOTKCvN+pQwxEvv5UtcqQcEYlELOjBVF1o1bC/TJdynpYRfuhKrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUSTUsL2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUSTUsL2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9de13d6baso3819645ad.2;
        Thu, 04 Jul 2024 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097060; x=1720701860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkbwA9Ypz3p6Kbh2EzTzzipYEVc7UpegE9m4rYBdh/I=;
        b=mUSTUsL2n+dkpkl9y9siNDqx8tNTh9avlz//NXmBPu37J/4A+WIPmYIkkBA/3LXn8G
         uAuR/hrFCMhqSo7HEh5/gUxnC1VCzaGkvNhnLqqEIDbWmw3SxDP6roa7/1TrcYru2Ia9
         Kew9cuoTPwoAuQOoW4vyCNPDGGxIxljcaxulH9v+7OdxuCzcdx75DtqnGVSWLVxNlsPO
         hCxwthOqholaPZ+CxBKwvdjxZyynpHQxGLPYbSCyt0d972OwN9ypfUfIfNx8H4LMAJC0
         oPSiEiTztGlNxFKxPEeRGLCbA3RXuM/XfPK5EJg1D/tQ5NH0bPepsCQkQ0ZpOk/dxxaS
         eZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097060; x=1720701860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkbwA9Ypz3p6Kbh2EzTzzipYEVc7UpegE9m4rYBdh/I=;
        b=PPI4ZrkjsjhN4GokWZ3j0jCJaODWfpxVi5uOMSaxrxoriCIJCKaz34oQ7GiEpZH7f1
         TkB3VbSUJNjOIQAnQlqnZCt7kjk6BXfEHc6XNxlbYapuNLPhlR6sAVQAdbfDrJLKcPia
         vsH59xRHz4riFJJGDNdJUwimWGCtn8ZuE7nHRrq4oRibBiNpS5tVQnz3F9GcknEZZIhj
         HZOFj88EW5NbU2MielzDiLg0pofegHolp7gHTavhBPGgXk2GX24Vh2iXfLJJqPaC2NVv
         HxM7RTzFC8r1R64a1ONc44Wo0Sl/M9xVhgbfJnVCjXZr91XySvJM1b21uLWssAb1s/cD
         2HXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTgKSKYL1zn9far2r1924+cLul/B1Ii6HmXuMNC7drC37ZFdDr1s3lvp4jHvoVAGFIs5gOI+qINaRoHGTsScBT0STnpd0TM74wXbregrS2lvV1qQyAjsGrR/EzfparnDqL5upCyiVZ8PurXu6lhw==
X-Gm-Message-State: AOJu0Ywi7OZtNdx+UbdwABNg9xN8Mx/8uk3aABRj5wb8FA1/y7kQh2Xy
	7FZpGKLNh2jx1kxHO+kSNLZNc1i7PJGTHSTV3rHK6MPFxi4gOb5O
X-Google-Smtp-Source: AGHT+IH/CsRGzP6TacQehRyuxdkQycNMahPZJQy11YgaD0BoOj5GL/uSUKVi5Ji5WIZ7GtgRR7UDhA==
X-Received: by 2002:a17:902:d2c8:b0:1f9:c1f0:7150 with SMTP id d9443c01a7336-1fb33df5a3dmr11130625ad.8.1720097060430;
        Thu, 04 Jul 2024 05:44:20 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm121578245ad.285.2024.07.04.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:44:20 -0700 (PDT)
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
Subject: [PATCH v4 6/8] perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'
Date: Thu,  4 Jul 2024 20:43:52 +0800
Message-ID: <20240704124354.904540-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704124354.904540-1-howardchu95@gmail.com>
References: <20240704124354.904540-1-howardchu95@gmail.com>
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

