Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D81A08D3;
	Mon, 24 Jun 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252748; cv=none; b=DwMIxlxOJr+6L4/2x79Ws6acikj4SJtnCTKA25u5KRKoe9wjneqD5G/vyybGR4JSwdZJVsKcbhyMlGBpPKHG1aGjEGF9iOxphVDVzk+C0d8mJu0VrBb15gqQNigdA+dZiQ5T7bBGAYs18/ockdYupu0YuSw/qrsomKQEt5tL1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252748; c=relaxed/simple;
	bh=BEB58jmhgFBt8hBVpkDwswlsxmcPeMe5P4dNnOzglMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRwqNhIxc8+Ku0CKRBQF5cckCqU5iwpn3ixgJRhj300j1lINQG6chOF9SQAbj1dvza9Me4Zndel13+Lsut5V+pERaLzhB/KT3oMYU0dYu8F+i1tB/SauKp5VPElI8a6FtuiNnJ34ZQTCShBBm+pP0UZUAOrIUI8XM94Vf+sdOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSkYDhIo; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSkYDhIo"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70675977d0eso1566792b3a.0;
        Mon, 24 Jun 2024 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252746; x=1719857546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkbwA9Ypz3p6Kbh2EzTzzipYEVc7UpegE9m4rYBdh/I=;
        b=PSkYDhIo33unuX0h5PVh/sOk4nWvVoFg6WECpheidf4PpiKKNQ90Wa+7TCPNtz9596
         DIx9SNXHlVRWwAgSBkhE85TjtS4xhshEABGWkpNYBjrb9HDRmJnhmRb/QUprusvkmGeq
         TKya0/F5N/ahGSgxsaJZpGSQbU1Szri4fwhhLlG9y0qUOJy+ZT8c/KEa6qxS5GX1+cA3
         /MSq/HmKNAvqpOxLYkNY63s1VE9EOeaUSojueSVWJP4yStU12C69ZcLtsxQGunrCP8V2
         Vrb+/vWLytdIgLPC7azCOpoWOzSdx/Iwq/KUE0mrkRoTFTjKckuZbEJDBk7n+5w0oAx3
         sowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252746; x=1719857546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkbwA9Ypz3p6Kbh2EzTzzipYEVc7UpegE9m4rYBdh/I=;
        b=u32VGGIY2b4dlDysBWuOYBgZkYdZzyzWIZGei/UWyDNFiNtFSu8G/oxqYJh2uY68K3
         nc2mestWIlgFos4y37ejaeArf+qp3EHIgYINzVJ62O5pUhGPE/dLmzIhNf6dLt4wLuYl
         tufvKvmmi5n8AeU7xV9hewbG/RBbOlgxLZr0g3oplR0hj8Kfb8btW4petllgV8DeI0dk
         N9cIfWFQfMY55PkSD7iPRnuC4SNY+YqEy6YP2mNXoXV8s903T6QeMkuBndHMGkniO5Z0
         QA45IpL735QOU+1pjrrjTiFr/oASxs519/486ej5/dTzWf7BA9YvevODFEsxaAtIDpqb
         HzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTEiEpx4j2hzRlxHZbyBhx7NiRceIEOLIJ0Y4veWpZul/N4tBE7im5HtxHffZRCh4PXWEm70Yzu33FiFyYytIvjIfqY7qk9dI2QdHDk5AKMETOO+Ni9PxKhMmoB9P/ST8lXeRh5gYk5a0pZR5Apw==
X-Gm-Message-State: AOJu0Yz/MvfBnDZbIzNz1p8HoS5JDj/sNsCqPHDAEgfOXYGEim8qEkju
	buM6KvV7cWNwl128K84NMHxBqLjdslLom1+RBKgHmXvNiWdxcXZZ
X-Google-Smtp-Source: AGHT+IHo/q+eKujXArhfP7gB2Y0dwQ8xkaKeJ5W+N7ZI1l4/0olgDehxoW4Mwq8FEWDMEa1jApC90A==
X-Received: by 2002:a05:6a20:daa8:b0:1b4:3f96:f1d8 with SMTP id adf61e73a8af0-1bcf7e6a5e3mr5248832637.13.1719252745926;
        Mon, 24 Jun 2024 11:12:25 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651290157sm6525157b3a.150.2024.06.24.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:12:25 -0700 (PDT)
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
Subject: [PATCH v3 6/8] perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'
Date: Tue, 25 Jun 2024 02:13:43 +0800
Message-ID: <20240624181345.124764-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624181345.124764-1-howardchu95@gmail.com>
References: <20240624181345.124764-1-howardchu95@gmail.com>
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

