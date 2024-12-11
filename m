Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07851DD885;
	Wed, 11 Dec 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957374; cv=none; b=Elznbe+PqWCsbzSBl8T3TDKxY+drtJOh2tVeNYcB58e96llPTJJmsRyaFKgtZqEfjZEu6Aam2H8zN3ANqZo5PnoQzJB6+zO9jguGKkEJXM66wujC0rRBGi04M9OQoQ6v4gdslvicGYuBe//HNR7iN51gktVE4rVjKmmX9rBax4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957374; c=relaxed/simple;
	bh=rk4YUziKix9MiU2xUp7uHQoHgcySBfMeFfRvamTBEwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ+3yZ/3bGAsDLIpHEcx9WvSEGh3ex5Qg2VR0aG67JmyO2TUH9Lj/M41B91bWnH5oJQKnUsof1zGNeTNoKMfw0wv4GEyBb8t7bVAxyL8rsrxg7+yd3tjeZcXZWvVClwRQavNo08kFy/hsMOBwJ89YyG0xhaZw2FQVNwp5AmJZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcUkofM6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcUkofM6"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-723f37dd76cso4094b3a.0;
        Wed, 11 Dec 2024 14:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733957372; x=1734562172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAxjdlgYD2vkmT2lI1SrqlCCz/PrWeYd+uEyvzz+ZB4=;
        b=mcUkofM6M45JgoDNHjxLBRPD1GctEYl63BxlIjRvjyGZGYmFu1i7FIcLzdXYwpAIou
         2avTDzIABOp8tIb0jYYLruMScM8S4uwWCQWtTussIbl9tqteI5HY84/inqh4y0QrmhvU
         DNq5nKXI7m9GqMXPfW/ZVUdyPFFZYdxOJkVA9kdjF8MSPrYygMD2y1qnoi7LSIgrQMAC
         9o2xwldcJ7cep7auVLIGtdEPEpg6r/WJRlNWlLuYfKginr7GpKvDpxZJA9SmfjuzgChj
         44tmwnusfPEWjYkUbgCWGpP/gshGswD0boN5aPDKWeabwHMaJ80SsPDif8w3IgfhJ/3q
         XVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957372; x=1734562172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAxjdlgYD2vkmT2lI1SrqlCCz/PrWeYd+uEyvzz+ZB4=;
        b=aq1Mv324FE1PG9ZCHjPWYKQRLGQfdaWeXpaFpAG862DAyGhPRYTsdjfKygKpSCCpaW
         oD7gkW64ML9wLT3huK5QJ+MTvqyZS8MTfSLC+Oicwycmz7PWf1SPxvZXcmWiFlWypfPt
         ZywR3R9Bt65onRTHca8Bcn8R9d/rAH5/UeZyZOfCt4S+iGsrU2yZw9Z2i4XjwJ+9XYpp
         OCl1kqdUoCaHphFnwpr9hpyXXxtjbSu4g8nQvC6zEv9RGrvZaj+WKX296N7QQ2LmVldI
         sVr+eq9Tf21JSlZ0F569KAUqiJkjL7eMn9p19r+FR64FPHfH0/HzVtUpiQ+PYhIXQ+9i
         XRgg==
X-Forwarded-Encrypted: i=1; AJvYcCUSbQyYl0DfSBPEpBXu9CRHEAgtDl5YWr/pT3qsN3IZUfs6LzcMuxWVN8z3NTce4O/bixHoUNeSIXg+efXdvq0ZOg==@vger.kernel.org, AJvYcCXRTZC9Pn9agJsSGyDL557uiCTI75pvEwzvbBgPZ/Ufx/5Oxhf/K92KPHcSCSvL7AwsGJbgjMFdUT4Muxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkfuWjegmZo0mVkeF4F+0K8dlVzQokIAqFw3Yjk02vRfMldUz
	mZdemHrt25VmLAkuWW6Ga2Lny8Vzm2/sdSTFNhscsAB2PRzFpfkP
X-Gm-Gg: ASbGncsATICtGY3eZtnXIKsSLJek9IHdCwkdVhGmwwJv+jlClG/1AlLB7f0/DTG6aUi
	JgGsWaorBZjQIKERrkzGQiQJu4puNwhAgt92IDyaueD8phMs/AQFkfiU8MIsFOFThOBehQH67RQ
	xHGY+NxAJxSXpFTK/z4Z7Wsz+6NnDPvNTCGUfZozwBpvoCXkCrcahDCnydiO5weuXjFsGN0Cuc6
	IdVWHBKZCmfTmJ3jrXPgrVkUSDo9wOGCV+RBCOLy040IuBERlEB+yafIkP+00jDsHwmZekR6d7m
	40fZicjEICKy
X-Google-Smtp-Source: AGHT+IHCF4bzmMDL29xQEbRKwsmW6SIgMJ4OBIJ/rCuoMCCynFO7qAIqmcW1tGjdPybyDJMcarpKYg==
X-Received: by 2002:a05:6a00:92a6:b0:727:3cd0:1145 with SMTP id d2e1a72fcca58-728fa9a8139mr1517333b3a.2.1733957372157;
        Wed, 11 Dec 2024 14:49:32 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-728e2520144sm3430506b3a.116.2024.12.11.14.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:49:31 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v3 1/2] perf trace: Add tests for BTF general augmentation
Date: Wed, 11 Dec 2024 14:49:26 -0800
Message-ID: <20241211224927.968483-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211224927.968483-1-howardchu95@gmail.com>
References: <20241211224927.968483-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only have perf trace augmentation tests for enum
arguments. This patch adds tests for more general syscall arguments,
such as struct pointers, strings, and buffers.

These tests utilize the perf config system to configure the perf trace
output, as suggested by Arnaldo Carvalho de Melo <acme@kernel.org>

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 93 +++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
new file mode 100755
index 000000000000..bef07bad42bb
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# perf trace BTF general tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+set -e
+
+. "$(dirname $0)"/lib/probe.sh
+
+file1=$(mktemp /tmp/file1_XXXX)
+file2=$(echo $file1 | sed 's/file1/file2/g')
+
+buffer="buffer content"
+perf_config_tmp=$(mktemp /tmp/.perfconfig_XXXXX)
+
+trap cleanup EXIT TERM INT HUP
+
+check_vmlinux() {
+  echo "Checking if vmlinux BTF exists"
+  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
+  then
+    echo "Skipped due to missing vmlinux BTF"
+    err=2
+  fi
+}
+
+trace_test_string() {
+  echo "Testing perf trace's string augmentation"
+  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
+    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
+  then
+    echo "String augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_buffer() {
+  echo "Testing perf trace's buffer augmentation"
+  # echo will insert a newline (\10) at the end of the buffer
+  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
+    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
+  then
+    echo "Buffer augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_struct_btf() {
+  echo "Testing perf trace's struct augmentation"
+  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
+    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
+  then
+    echo "BTF struct augmentation test failed"
+    err=1
+  fi
+}
+
+cleanup() {
+  rm -rf ${file1} ${file2} ${perf_config_tmp}
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+
+# don't overwrite user's perf config
+trace_config() {
+  export PERF_CONFIG=${perf_config_tmp}
+  perf config trace.show_arg_names=false trace.show_duration=false \
+    trace.show_timestamp=false trace.args_alignment=0
+}
+
+skip_if_no_perf_trace || exit 2
+
+check_vmlinux
+
+trace_config
+
+trace_test_string
+
+if [ $err = 0 ]; then
+  trace_test_buffer
+fi
+
+if [ $err = 0 ]; then
+  trace_test_struct_btf
+fi
+
+cleanup
+
+exit $err
-- 
2.43.0

