Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940973DA5D6
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988874; cv=none; b=Z9QyIg0ZYLurYkV654L1hwSFXj92Rzy1zsz+ahr+vGvWFE0IrBMQJa1CMiLihF511KUXRGSmB5DltRTlDGN35q8gVJkve86SZepT3RvDk0UysF9yzwaOUU9MUH3vlxdqHNaJ3DwE7GobSuEj2E6zPJRJqdpLkPeFsET+UqONFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988874; c=relaxed/simple;
	bh=H7rLKMOT3wtg0NltCoIV5q2RgoYwHopGnS10VXu5I3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PMujWUetunKLK9KpE5s/ki5OqDEDS5jRTS79iEWZh09UzDV5iVjN8q8KmZP1exwA2+cnWuz0XIZVJgwyiZdCQlgSK6ViL3oo6Z8RXFONqeYBCdOdsT+GxBy2HbzBOaAmqibj1LVeVzXFapHTpyiF316RmQrKgSYvPQmKs/tWWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p9iLakFG; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9iLakFG"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d8613efbso5190612eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988870; x=1781593670; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/juy7qk06nJuTJJeVGuuQioE+EFh0BWQCUQcuD3Ibc=;
        b=p9iLakFGHAwmubh8L9vObft7KMKls+p6z+1f+TtEgQD1q/7qhRgY3AC3RsPR39PlO0
         smZLhefu6cPNRckc746xrJBSAEzkxssfwgKxOh4DQWCwTEpU0dBdtUtft7PGpSY/9RAr
         h1FRRAc6SVQw1yjUDD0hjm+dz7U5T9WFGpzppfZpJry9+6euXjSw5sR/tXEutmsSvStV
         RsyBYNxtXf3K/Susar5qKJL+TteIpSdK2FHjPd4HcgUr/46f8nlsdIm/O+U5lX4vCMCG
         wnIv1hi3Q+7Ie7c2XtvoS4FQLWDywRbOtRjEDFizH4HmfIlOu9BugfGMBFHMkMVCpySh
         T+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988870; x=1781593670;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/juy7qk06nJuTJJeVGuuQioE+EFh0BWQCUQcuD3Ibc=;
        b=tD3pWV2/W/6w8YXcjFN2xJs86TCDPjEoLgwkTr7DQ2HJEmu7z0F6SqWHK7X5s/nBDt
         Bbjfzqb7SnyGvrNwTN8E/4osU+oHGOEu1aSpQFtzKdYrUgck067UuLV3YyPKunzaC7cM
         B5X83UyBXquVllufIUWeqmewSOdJLbU0IqRjmQvy9vypKE6xZzDWZ8e8bAUlM3qORALY
         qvLbwZYIQUKJaY6Rd9FERpIZNsFn21GN725zQWDR5M/hLBKJgZt/YpbuoegvIwgQmgnf
         SkXN4nq6XFMYfkHv+SL/r6Kv0AgtxiK0Kndx4Mx/v8cZeqBn5TyBaRAYgcUuuN3rSbZv
         YkRA==
X-Forwarded-Encrypted: i=1; AFNElJ/irW87KRUFY/HEPy6rCLPXcXF38LQ/HsdgklyhGWjkJareD7Ztxk9FdlndP0OAQ/ksIWSigEK6+6rZCvlC+E/t@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMMovpmGN4WSX/gytxbSLgpW/75AZpwvjEEzxJMxjAq+4g+50
	ds9ss5MfS/VPakqiI+WEfW+lbuRH/Kq0dXEQsKxu/xrV2BHg8A453k2GZ5ZQ8o12ZO5DmF6FKa8
	AXrZnXmMhtg==
X-Received: from dybrh10.prod.google.com ([2002:a05:7300:f00a:b0:304:561f:1afb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8c88:b0:304:d32e:65e7
 with SMTP id 5a478bee46e88-3077ae9d56bmr10393138eec.0.1780988869407; Tue, 09
 Jun 2026 00:07:49 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:07:30 -0700
In-Reply-To: <20260609070732.545416-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070732.545416-6-irogers@google.com>
Subject: [PATCH v2 5/7] perf test: Enhance annotate test coverage and isolate config
From: Ian Rogers <irogers@google.com>
To: Serhei Makarov <serhei@serhei.io>, mark@klomp.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
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
 tools/perf/tests/shell/annotate.sh | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 689de58e9238..2c06d2670cb1 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -4,6 +4,8 @@
 
 set -e
 
+export PERF_CONFIG=/dev/null
+
 shelldir=$(dirname "$0")
 
 # shellcheck source=lib/perf_has_symbol.sh
@@ -106,8 +108,60 @@ test_basic() {
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
+  perf annotate --no-demangle -i "${perfdata}" --stdio --percent-limit 10 --disassembler "${disassembler}" 2> /dev/null > "${perfout}" || ret=$?
+
+  if [ "x${ret}" != "x0" ]
+  then
+    echo "annotate with ${disassembler} [Failed: perf annotate error]"
+    err=1
+    return 0
+  fi
+
+  # check if it has the target symbol
+  if ! grep -q "${testsym}" "${perfout}"
+  then
+    echo "annotate with ${disassembler} [Failed: missing target symbol]"
+    err=1
+    return 0
+  fi
+
+  # check if it has the disassembly lines
+  if ! grep -q "${disasm_regex}" "${perfout}"
+  then
+    echo "annotate with ${disassembler} [Failed: missing disasm output]"
+    err=1
+    return 0
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

