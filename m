Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C906F307;
	Tue, 18 Jun 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724379; cv=none; b=VkLD+m9zsSaXOBlorq+EJx3/jzCvlCuIkn5dK+Gk/MeihO7NSX82mAbtHwW+EKtbP4B96++IhpKXyAMsPUxs4bo1vTo25dAN5T/7P4BXesxp7CDQ8TSRgrPdtwB1RWABQ7vgglXlcJ4mSGAyBPxtN/ztE6AjhxpyGFjMYexopQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724379; c=relaxed/simple;
	bh=KacarSMJ2WTh7lJDtLEVdRO+H2BB7UwFV8aZDrR0HBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvmZBiHpVypNfSikcsIOeD7I4rCOaFJyjjFWhSQYbqUSgyTs1XvQlPoc0k5xaPtaDwXcK054R71AAVPWdvGemsnCuBIdmYRTEm7DN6XjxwdIA2rAlO1hS5KlXJULXy6vltmtM5+7Jbdhj+VD80VNtw2//NvvYUcksQjrbl5v42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auvvxpp2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auvvxpp2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso871733b3a.2;
        Tue, 18 Jun 2024 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718724378; x=1719329178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hkvZkfg/GcNlPEHzOoz4co9rHTk55S0Yh7Q8va3D4Q=;
        b=auvvxpp2Sp3dYKZaFxjdE9ADRuRLThDR7cZUXKKEOD7aoirKynqM5dYgVeJoSwPJPv
         5l98e8W9RyCjc8gGelXtvMkNGC2eyPEdhhaPAWVCJeGzzSEKf2Ww8uILRtdSpuKWIGvK
         1fa3a0KfN61WySRJavU/fmTkWxEUCNZWSvbfIbCK7xjPNmoOq4V2HWQL8S1Hd1axfoaB
         kSpx48z8Givte5CgysL0FswOJJGLbPix36r+9hlWoHCmFE5q7Dn4wndMWXwF/4RdqKIb
         PDU7ACmBbMkvfDcamhx/C5Q5ST4q4XUnqbKpZBKrq6zDzoWIT1PWLLBnBGYa/FACjh9s
         3Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724378; x=1719329178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hkvZkfg/GcNlPEHzOoz4co9rHTk55S0Yh7Q8va3D4Q=;
        b=DbhygaWEjUugvNnWuEwvdp4mxKGhxCW2uI1xymU6fiz1F4BdCMftvxGVgDId8E85vK
         qBXQ0AbfYPUaFgZoTQwalu3ygV33+Ie8y6aIOQY0mJnZcfjPqPXvB6CgHQPxUC7X5bOO
         hqTZ4u2NsfNOeO16kKUGECRYZNkzXMh65EjCOC/eM1F/OIi+JgyOpZ3y1wYaGxVqCSym
         CBNr7R48cY7y0lMeHCqlyB7RdN5nhx+AGyImRW06RylWW/0jRw61fZPNjxvIgwobo+IW
         wEcCoMEPUSQ1PgMa2W2UPkhK9e7d1JIlMNEt2Dbf5Dp4IAcpYrlQJmXCftuN8yxyaq6W
         DAqA==
X-Forwarded-Encrypted: i=1; AJvYcCUHxbHjfOzaaBzHwWy3jxPBx5SfyAxCoBZoXQYvFYg86fj35UkfIzQYJnyhmKYwzHJzzjg4Z4q0RChvP/TcIAAjQBQUF+hAuiM79N08d1v0s0Hfc+jVTqW8aecAnexhnO6OPlXG11B2Ik2nAhxNbA==
X-Gm-Message-State: AOJu0Yzqh4qEQtH9wdbBeSm+oG+RFL7v6o/NxB2kQUhxWR/IzrGdoiXF
	D42opAmPWW2CgpVqcOUA40kii5SYlCaeLRQ92P42+UFPoE6K4byj
X-Google-Smtp-Source: AGHT+IHVbXPCeIWuYQGFM4Jjl8JWCQvhHH5BHXSuStg2xo0hpePlgku4VHHkhCrUZdCVvBzQC2YcbA==
X-Received: by 2002:aa7:8702:0:b0:705:b81b:6ee2 with SMTP id d2e1a72fcca58-705d7155f7dmr12156188b3a.19.1718724377923;
        Tue, 18 Jun 2024 08:26:17 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4265esm9071388b3a.116.2024.06.18.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:26:17 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 5/5] perf trace: Add test for enum augmentation
Date: Tue, 18 Jun 2024 23:26:52 +0800
Message-ID: <20240618152652.3446472-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618152652.3446472-1-howardchu95@gmail.com>
References: <20240618152652.3446472-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for vmlinux's existence in sysfs as prerequisite.

Compile and run a script which calls landlock_add_rule syscall,
trace the syscall to judge if the output is desirable.

Trace the non-syscall tracepoint 'timer:hrtimer_init' and
'timer:hrtimer_start', see if the 'mode' argument is augmented,
the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
in its name.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 104 +++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
new file mode 100755
index 000000000000..14c73b0b594d
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -0,0 +1,104 @@
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
+landlock_script=$(mktemp /tmp/landlock-XXXXX.c)
+landlock_ex=$(echo $landlock_script | sed -E 's/(.*).c$/\1/g')
+
+landlock_fd=24
+landlock_flags=25
+
+. "$(dirname $0)"/lib/probe.sh
+skip_if_no_perf_trace || exit 2
+
+enum_aug_prereq() {
+  echo "Checking perf trace enum augmentation prerequisites"
+  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
+  then
+    echo "trace+enum test [Skipped missing vmlinux BTF support]"
+    err=2
+    return
+  fi
+}
+
+prepare_landlock_script() {
+  echo "Preparing script for ${syscall} syscall"
+
+  cat > $landlock_script << EOF
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <linux/landlock.h>
+#include <sys/syscall.h>
+
+int main()
+{
+	int fd = ${landlock_fd};
+	int flags = ${landlock_flags};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+	    .allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	struct landlock_net_port_attr net_port_attr = {
+	    .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	    .port = 443,
+	};
+
+	syscall(SYS_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
+		&path_beneath_attr, flags);
+
+	syscall(SYS_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
+		&net_port_attr, flags);
+
+	return 0;
+}
+EOF
+
+  gcc $landlock_script -o $landlock_ex
+}
+
+trace_landlock() {
+  echo "Tracing syscall ${syscall}"
+  if perf trace -e $syscall $landlock_ex 2>&1 | \
+     grep -q -E ".*landlock_add_rule\(ruleset_fd: ${landlock_fd}, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: ${landlock_flags}\) = -1.*"
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
+cleanup() {
+  rm -f $landlock_script $landlock_ex
+}
+
+enum_aug_prereq
+
+prepare_landlock_script
+
+if [ $err = 0 ]; then
+  trace_landlock
+fi
+
+if [ $err = 0 ]; then
+  trace_non_syscall
+fi
+
+cleanup
+
+exit $err
-- 
2.45.2

