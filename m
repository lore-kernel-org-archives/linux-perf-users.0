Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419C30F80C
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982302; cv=none; b=eU43kqqCJqnrgM0hNTWPda8Mii7gDr9wZeB3V5SrIJHZObAkWg4ZUnivIvOCPbCxNWXTFTGuuRA9nc5azRgOHv2wS6peNLi8r0wIWsIPRC0e8LqhdyqVHnHsQZEtLu+to536iYfOnXE0/rgo2ZhLVjd1Yjo3tO2Gt34RSVNwZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982302; c=relaxed/simple;
	bh=AULg6TS9zdVYAzc0iEIaIlPZ4bBNNUvjdY5hipajSlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nwIvr3Ub5Qj4pA4xyZCqZjY2j7mk1ZKbVxzuzQi7sChzumovF+8l6AM6VIO6+ehscDzDbZu2IZlCuaf1jRzATpMZu8Cc04saOofNbPVI1fxfsds6kpcP5RNA/8eyfTM1eJikC7GdZ8uJ0tK1LxqhReJ0GQOUDFgAOwDW3X1BNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGljWcFd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGljWcFd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f1820babso6397446eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 22:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982299; x=1781587099; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dcjYmV9oSCkLLYv23l2rswMcx+M5a96riI5dhneKmU=;
        b=pGljWcFdWzeJ9jGem+R150+gALjZqWQixpT0VYzI/+dLLDBZy8emUclpPUU9S9AWju
         8hXilTz/d6Cd2rlVpTu0WgxC0fI0uJ7+oj5bg+vXQCiAVxi6qCQ3y5pvnCr6BvGU0Jxy
         xuPKVDu38C3nRW7nZQOL/CUs13Gp+4S841RHP7lkI3OD8T4CNbaNxZRYYjwvyCXCSPww
         xM4BaO+hIGXINyEENPTs79Ekb/3hPfmAwHXulP2T0snEk8NAHOttYg0RY5fMMy1a3z+o
         5j2zdqdyLdPFnOISE4RVYzPCUyNb8IwKsToJhrVjOxAcsXB3Z+0cfSa6qP2/6iZUBJmr
         8akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982299; x=1781587099;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dcjYmV9oSCkLLYv23l2rswMcx+M5a96riI5dhneKmU=;
        b=RHx147he4Ccc9ADovKh4CUgZoOTP15FbMNL8dr/SD2+X218YxNrHyznIZk5A9aYQsG
         WU5Nj+WisN7xIOLbGsP0+9bKPlHORIFKGrBidWPWdbt6D4zbYmwjhbtF4qwtL4haqL4S
         +fHK5bE7qhWz+YqysxEtRmgleAfZaf7YT/idtxT0ormMrBgOcruJ4usTURc+bsX39jDM
         ih5IMU/wrdWLwBi8Tp+fqb34TdobXDmT+UF88KotvDPveUdrrtoiAgBU5EZMWrEcALl2
         vyBSZI9z6BUPgMmP3CwSGwBpvsWLN6Kx11YKbnDWVBesTOgwMh1CMk7Y0n6Q5EIdQB2j
         qxLg==
X-Forwarded-Encrypted: i=1; AFNElJ+E7iNWRsl+8P8fe60h7Y4TQj9QcPGNe0mUcRbUr6N8nHWONUnTmXRpz7zyYCmkDRaMT0BH0SYVxjKknwkSwQ3g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6j1weEK9cYS4qM6K8r46I2+DRH2XPGfSlIciaJFVSmLoLNGWY
	XMd5gbdfSG3VHm/vkjSIM7RyhF4DFFihQN1sCYrpS/QHT0dfw/azEXqsn0hRdEt6SSDuuHAMMhF
	OktjG0X7Yeg==
X-Received: from dyclx3.prod.google.com ([2002:a05:693c:2183:b0:303:f2fa:386c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:419e:b0:137:4061:8cc2
 with SMTP id a92af1059eb24-1380670e1f3mr8837301c88.35.1780982299033; Mon, 08
 Jun 2026 22:18:19 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:57 -0700
In-Reply-To: <20260609051759.405027-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609051759.405027-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-6-irogers@google.com>
Subject: [PATCH v1 5/7] perf test: Enhance annotate test coverage and isolate config
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update the annotate.sh shell test to test different disassembler
backends (objdump, llvm, capstone, libasm) utilizing the new
--disassembler command-line option.
Isolate the test script from host environment pollution by exporting
PERF_CONFIG=/dev/null at the start of the script, ensuring it runs
hermetically.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 689de58e9238..d3bafa7e3db5 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -4,6 +4,8 @@
 
 set -e
 
+export PERF_CONFIG=/dev/null
+
 shelldir=$(dirname "$0")
 
 # shellcheck source=lib/perf_has_symbol.sh
@@ -23,6 +25,7 @@ disasm_regex="[0-9]*\.[0-9]* *: *\w*: *\w*"
 cleanup() {
   rm -rf "${perfdata}" "${perfout}"
   rm -rf "${perfdata}".old
+  rm -f /tmp/__perf_test.config.*
 
   trap - EXIT TERM INT
 }
@@ -106,8 +109,61 @@ test_basic() {
   echo "${mode} annotate test [Success]"
 }
 
+test_disassembler() {
+  disassembler=$1
+  feature=$2
+
+  if [ -n "${feature}" ]
+  then
+    if ! perf check feature "${feature}" > /dev/null 2>&1
+    then
+      echo "Skip test for ${disassembler} (feature ${feature} not supported)"
+      return 0
+    fi
+  fi
+
+  echo "Test annotate with disassembler: ${disassembler}"
+
+  perf annotate --no-demangle -i "${perfdata}" --stdio --percent-limit 10 --disassembler "${disassembler}" 2> /dev/null > "${perfout}"
+  ret=$?
+
+  if [ "x${ret}" != "x0" ]
+  then
+    echo "annotate with ${disassembler} [Failed: perf annotate error]"
+    err=1
+    return 1
+  fi
+
+  # check if it has the target symbol
+  if ! grep -q "${testsym}" "${perfout}"
+  then
+    echo "annotate with ${disassembler} [Failed: missing target symbol]"
+    err=1
+    return 1
+  fi
+
+  # check if it has the disassembly lines
+  if ! grep -q "${disasm_regex}" "${perfout}"
+  then
+    echo "annotate with ${disassembler} [Failed: missing disasm output]"
+    err=1
+    return 1
+  fi
+
+  echo "annotate with ${disassembler} [Success]"
+  return 0
+}
+
 test_basic Basic
 test_basic Pipe
 
+if [ "${err}" -eq 0 ]
+then
+  test_disassembler "objdump" ""
+  test_disassembler "llvm" "libLLVM"
+  test_disassembler "capstone" "libcapstone"
+  test_disassembler "libasm" "libasm"
+fi
+
 cleanup
 exit $err
-- 
2.54.0.1064.gd145956f57-goog

