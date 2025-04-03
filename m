Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE41F5835
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711900; cv=none; b=niAPPdvHy0aXphm9FeQXmdIYMgXjW0kljNW9+4ZqaLqCK3Hmu/iFaQ1PSkn5fyz4fZhxXeFXkEmZfbzrWLvI9G6a5ATYSzZfvMYPWIJuy3LsdncOy8PjkIs2sWUl7EaDPPlOWl3YHPjAURf9p0GVuFFKXMmQ/HktM0zM/YZkvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711900; c=relaxed/simple;
	bh=gNKtXVPbbB+3G3c1/vIwnhim6kYBeq02fpYtM7jeUSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R5NCEqzhULtlw1GRecZiSpMfpn+mh/GPHIZ5uZG3Vs8lAJNsipeIRUf2aY39a7C+LPjy7DUsvR1RbL/0FQ+/QmS02SuwDB40pfP9ZGN8t7ElPh08gJjCEUa7lYFNBjwiSPE8FhV4Amn8OiYCZATHJxBDob66FRdPQAVW5MlR8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHMl2oCV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHMl2oCV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af9b25da540so896414a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743711897; x=1744316697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5JjsjFOUC3YO0iochXENC9eaId60vwka6iugGNbtu6g=;
        b=bHMl2oCV0NSsEuL75SZKT20HqYO/Xjnbzds/OdHU6ejlw9glzpP/pPQZ2MW+7qt5HK
         8zEbyt3fzWgt3Iab/mzzQreY9gwVJmlUHvXv8T1a9ZVlyLKSTPnCgmehEp8r+Ng9ym1F
         8vEVB/SwZHDr4j4dbBRnK+52FG/cADVS0YAxP/GD4TQy6Bcp/LUu1qckhvijYqpLm+Yv
         MFiLcdrDb0vaMREmc/VTMDbWOHaHBkyiBl4vreQMoyV3KH4OUReEvDhkGALsa4yw2Xh9
         iQLbX8wk9J5uGbMdkfadcDFWd5ROiGy4v77uDBY4qaSkrp2R5v84nwa5EfI6S1ohuuNT
         6nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743711897; x=1744316697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JjsjFOUC3YO0iochXENC9eaId60vwka6iugGNbtu6g=;
        b=JrGA2vv2qlcKOByXMgjCGsXK2tm9z5N5m1iCJYJYQOQb+EP6hzDjPUR5tLWroShEwO
         UQGcGlYWfq+68TT8Z9cHCKc1yAUZZkuTrk+pNHqosuP/PRzPfOPk7hVOkm2EGKlVNTTU
         /CeaZGJHsuTqgoS1tDc/ch4C49uAUjy6N9HL2U8nkxTb0YtoatTQyQXUbp1cA3tQwgbz
         qf+WGID3zPDZhpLku/eAxZb0zM3kk1xtwKihjdYSZpQF8QZK5kNMROETRgygjcok3mO1
         ZKfNoxlKXW9VEAuS2/k7hlYkREJ2GTZe5/4e8o2B9BqOCSbCWyWWVIxTBEDDkBh72G0W
         W/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8PcFyJXYXhc6a4DFzdaavxAxFhJ1dIFzonuYGc/GfWDhaCJ+s+xlFzyZRJc22uCZD/c0shoY/FRI5zqbkukDv@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaqywV1I7fDltdtun0NPC+mYHRlgGjkZWr9o/CM52ZEDO2aas
	ZnKeSiQ/Yf726vKr5pQPwPbCmlrjqID2T87SWYk09+odj4M0pu6yNvemp1c4T6AbOtYwzdHOluC
	D+diMDQ==
X-Google-Smtp-Source: AGHT+IHRfFDzCYIPq5Bp5DbUlRqc8I14sxeIBKF4QG8mXK1Q6lEJ5VL4ONiwvatjg5A7PeaRVPG/gKZbjZDM
X-Received: from plbja4.prod.google.com ([2002:a17:902:efc4:b0:223:52c5:17f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:229:1619:ab58
 with SMTP id d9443c01a7336-22a8a0b33e8mr7237285ad.43.1743711896952; Thu, 03
 Apr 2025 13:24:56 -0700 (PDT)
Date: Thu,  3 Apr 2025 13:24:39 -0700
In-Reply-To: <20250403202439.57791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403202439.57791-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403202439.57791-5-irogers@google.com>
Subject: [PATCH v3 4/4] perf tests: Add a DRM PMU test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

The test opens any DRM devices so that the shell has fdinfo files
containing the DRM data. The test then uses perf stat to make sure the
events can be read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/drm_pmu.sh | 78 +++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh

diff --git a/tools/perf/tests/shell/drm_pmu.sh b/tools/perf/tests/shell/drm_pmu.sh
new file mode 100755
index 000000000000..e629fe0e8463
--- /dev/null
+++ b/tools/perf/tests/shell/drm_pmu.sh
@@ -0,0 +1,78 @@
+#!/bin/bash
+# DRM PMU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+output=$(mktemp /tmp/perf.drm_pmu.XXXXXX.txt)
+
+cleanup() {
+  rm -f "${output}"
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
+# Array to store file descriptors and device names
+declare -A device_fds
+
+# Open all devices and store file descriptors. Opening the device will create a
+# /proc/$$/fdinfo file containing the DRM statistics.
+fd_count=3 # Start with file descriptor 3
+for device in /dev/dri/*
+do
+  if [[ ! -c "$device" ]]
+  then
+    continue
+  fi
+  major=$(stat -c "%Hr" "$device")
+  if [[ "$major" != 226 ]]
+  then
+    continue
+  fi
+  echo "Opening $device"
+  eval "exec $fd_count<\"$device\""
+  echo "fdinfo for: $device (FD: $fd_count)"
+  cat "/proc/$$/fdinfo/$fd_count"
+  echo
+  device_fds["$device"]="$fd_count"
+  fd_count=$((fd_count + 1))
+done
+
+if [[ ${#device_fds[@]} -eq 0 ]]
+then
+  echo "No DRM devices found [Skip]"
+  cleanup
+  exit 2
+fi
+
+# For each DRM event
+err=0
+for p in $(perf list --raw-dump drm-)
+do
+  echo -n "Testing perf stat of $p. "
+  perf stat -e "$p" --pid=$$ true > "$output" 2>&1
+  if ! grep -q "$p" "$output"
+  then
+    echo "Missing DRM event in: [Failed]"
+    cat "$output"
+    err=1
+  else
+    echo "[OK]"
+  fi
+done
+
+# Close all file descriptors
+for fd in "${device_fds[@]}"; do
+  eval "exec $fd<&-"
+done
+
+# Finished
+cleanup
+exit $err
-- 
2.49.0.504.g3bcea36a83-goog

