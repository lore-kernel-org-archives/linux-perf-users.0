Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22691FAC42;
	Sun, 18 May 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595408; cv=none; b=rQyE1S81LIxW4m6/2n4uD0ou25CH9P3M16nRiHTH1ZTO/+MHFpm52zVXsGz0hr41B3TvtKi7aJNRCtTkaiY5Z7LxwizoCVG+TS0bn8hn12F3OiRiL79UHyR9zlLXzZIWzOwITsPJqkNbR4WdRbFsXlZpw9bRsd10ahNQEjFJFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595408; c=relaxed/simple;
	bh=pYg8TLTjgS0BjbaSB6NlASqTqqK6Bkw6JNseF6OIUqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI65hsROu5YfybDnpmn6VZ2rLndskoNzYJaL4qiMTjcUnvPv6HgqDhdi0sGYTiTyng5WktnwKoOx3WfmXUrm+7C37YHnideSMELiwwmmhIMa1ePgHoDwDWgbG/PeBAqJa/g7H7AsiBUHhVnRHX3Rls6vMLw5DibjXeXBbjyM0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlyFg7QJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlyFg7QJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231bf5851b7so26729795ad.0;
        Sun, 18 May 2025 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747595406; x=1748200206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg68t38uPzYyo7Ew0hkP+phW30lhRktPX+3plUsKhsk=;
        b=MlyFg7QJkoflbAhwJo95//9hYJuIoUTw7pBdVeeUUTImZuJ1Ref+ZWS8LA5BRC7Q0E
         K/g/Qf29MTI7gTH4UizDNbHfgnVuWoBljqarP/vJ570ES8uhMpBGp/noPculAELeaX+M
         TW9NXhiHnGuUfsk3B1gpoR3fbimwQMSzQBqDKHk47GNl6PHzBcETT38vjQHbdeK+EVS2
         elDIxuZ36UfAmbWRt00BpXzFRrShgKiIpa4a2dykoRJbApqI5APAqw0eHRwKaXXH3N9D
         2aWfjA7GnfHIbvZaejlpHGXVL887QrNa7CKB5TbEX1xiE8Mk+CPu6TBEcKuKS0LYr7dD
         gt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747595406; x=1748200206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg68t38uPzYyo7Ew0hkP+phW30lhRktPX+3plUsKhsk=;
        b=VQWmgdl271DgILtiUuN7OiunRZTR0lI0s6w0gBILhg22CHA81ByuXp1LNpYUCkJcA1
         Zlutc4mIhqNbLvtthbuzKSs8xc30eXL/BI3f+tplWcU3rXvex6nbsUQZ2SuT7Jra/VAx
         IrKbVbW9KonxzirKXYI5UWyjK5VHvwZOgHDNO33n42t+piax7B0AIS8EjBMrjyuGEoJN
         SU2ccxMm73vw38teq4SnpSXBFRsAizTHzwOLnvb+mMmY/JNJ7ySbpqpvq+WxeDo5TMqj
         N438CWPM4ZEimtOYIOMzHWiOHoshG/6zxN3hD7E/SUiH6Eqs0Lo2b05vXdIFn/wIAynG
         iErw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ycl1Zdong+NsW5lFui4OANhE3wEPktEaWtn6b/yDUXSCloPKP/E1/5zchll5f3PtsHEF4SNiHXk44QK+spqHpg==@vger.kernel.org, AJvYcCWIFi9dQZPp7mBtV06N3FhGgKn9ldcaZ4rOKBIrBwkB+P5Xq09VIylICNugBhrZUbYGISlv6dARKXEWUDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJgVmp4dmeoKhdDwuxPmAiI8Xrc+ZKlpklBoIymMUflUtC7Ax
	p5I1A7vFywxE+FC81gn5OgN2wjqucJznZUIw2PjvKgZN8TyfADW8N0D3
X-Gm-Gg: ASbGncu6RFuhMetNlaV4RmdzE5aCDWwdVh6+7TKQsjWSZdHlliaa9PxUUKdxi3voDrq
	hdWVpxXvUpiKd9p8+lKSs10gPE4FR4nOmVOMeWlAmy6e1ee8kp6KoPcyAWr2Rn3xRHv96HohGpr
	Rjn7IxRkxx0YbvE2pZq3tpWTCUv+52D2xb+c/UNEZ4V4nti7XfHOLwDisW1QSziyIYg7C8/yZpx
	BQQtGUSxHFo2dhNeL+H5urVZoxHhpMaLlwnQjQpfk6Gy7Nqacmt/UJkiBMyPkzccxPf+xOJMTjg
	IMjGqMIIIkdmTW3+BFVYsIX8QNmQs7Mmakkf8Jagr7Qol2UlfaQnjSmjB2ZyI7QVE+DRVUB2Y67
	NAObrLr9gqurto4G6d5sr
X-Google-Smtp-Source: AGHT+IEZ+CNZegmFA3/pDVUcTNJ0I3/eER/AjxzmrzrDj6Sf8UCfCIWws5x0zR8IGWZePkLwXSyeng==
X-Received: by 2002:a17:902:e5d1:b0:223:54aa:6d15 with SMTP id d9443c01a7336-231d44e4599mr156668615ad.12.1747595406034;
        Sun, 18 May 2025 12:10:06 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adafedsm46022135ad.56.2025.05.18.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 12:10:05 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 4/5] perf test trace: Remove set -e for BTF general tests
Date: Sun, 18 May 2025 12:09:56 -0700
Message-ID: <20250518190957.58932-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250518190957.58932-1-howardchu95@gmail.com>
References: <20250518190957.58932-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove set -e and print error messages in BTF general tests.

Before:
    $ sudo /tmp/perf test btf -vv
    108: perf trace BTF general tests:
    108: perf trace BTF general tests                                    : Running
    --- start ---
    test child forked, pid 889299
    Checking if vmlinux BTF exists
    Testing perf trace's string augmentation
    String augmentation test failed
    ---- end(-1) ----
    108: perf trace BTF general tests                                    : FAILED!

After:
    $ sudo /tmp/perf test btf -vv
    108: perf trace BTF general tests:
    108: perf trace BTF general tests                                    : Running
    --- start ---
    test child forked, pid 886551
    Checking if vmlinux BTF exists
    Testing perf trace's string augmentation
    String augmentation test failed, output:
    :886566/886566 renameat2(CWD, "/tmp/file1_RcMa", CWD, "/tmp/file2_RcMa", NOREPLACE) = 0---- end(-1) ----
    108: perf trace BTF general tests                                    : FAILED!

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index a25d8744695e..5fa50d815203 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
-set -e
 
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
@@ -28,10 +27,10 @@ check_vmlinux() {
 
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
-  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
-    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
+  output="$(perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
+  if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
   then
-    echo "String augmentation test failed"
+    printf "String augmentation test failed, output:\n$output\n"
     err=1
   fi
 }
@@ -39,20 +38,20 @@ trace_test_string() {
 trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
-  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
-    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
+  output="$(perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1)"
+  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
   then
-    echo "Buffer augmentation test failed"
+    printf "Buffer augmentation test failed, output:\n$output\n"
     err=1
   fi
 }
 
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
-  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
-    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
+  output="$(perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
+  if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
-    echo "BTF struct augmentation test failed"
+	printf "BTF struct augmentation test failed, output:\n$output\n"
     err=1
   fi
 }
-- 
2.45.2

