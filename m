Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4444CA265
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029289; cv=none; b=toicgR6HVizrj9h7lu1nor8yQ83u+QQ3zf/10PPuPyd7khtBOnEYoHjWXKijHT3mJFgyuoe56IXO+IBRXfurKLY7WREWW0XUi2Oz4DXjb/RwDss1AVfwV9XYUDcElnP1Ja565USid3LNnn/QEZ3Eo5QL7Fne5aRc99iuMPeBdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029289; c=relaxed/simple;
	bh=0O+ULmKdO/a/dA9Gxq4CNrz5SKxYACANlHUXOqA/jNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mo/YmUgj6eofy9J7tV3tBlseCUm+DEaHjB9SNY9hn5PKLikwEcWMf7dCVJC0r2xFxSqO5USzRxBL0UljaFRnDPVKnKEHdf285PLIRz863sJg9lhitk2YIiFqrAkJpPbKVLh46sD0JubnGk+XSK8d/m3R69iuG1KuR+tGrwWTCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M96OvW4L; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M96OvW4L"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-138155294c4so13019044c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029287; x=1781634087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDEzSjqPxx9dU20okUxCziRRGVm1ZBHoh+Sgxu91p5o=;
        b=M96OvW4LHVLVNGP4rhy7/hWOCDrQLhOWRbgMq7Y+IAAaH8o7TmFc0f55+lXaZP17jk
         X19JzLYA6Ka6CFJl+Q8tcEzIAIwRYzf4W8eTt7EUkbD+yFhQGQ5ssAbIjg6h7Tr0KHLd
         tYnb0Hu8ccVAq7oxZc6cUzB/LBgMPORwt8ejwSrJbxth/isFeomq3Zf6mRHB7K9TjE0J
         l0GiNgiGQoLVYO+viz4hTXkaSLgSdAFEcX3ZldPWkco7jKAZYQPvzfKXtiWRQ82yqC0J
         WyjSP/EpcYSSmE5nEpJ/9GnnvdKLjbFPZoaGymbKrFBnb9o0ygn8fw1lrxhkaZZ+Kxcb
         /gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029287; x=1781634087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDEzSjqPxx9dU20okUxCziRRGVm1ZBHoh+Sgxu91p5o=;
        b=JDRAEGFSTVwtOhdofv/lPOgKHlANwrBRa8KD1wv4HTYdRJpPlim26qkmurdkndpFT6
         Pdgg4js6nju+cTDUwLapQmFbEfwM8sEMpu2WVMfWXp0NVRWyYcFVio4oxlb2UtUuMhwC
         M7ThQOb/WokZo6CiJK/Ku9ByHyoHBOdpyn9D/Rcv2WHjajt+jPH/59GWRR/WPvYlqcN8
         PEMWLThakpY3kevC+eJCZhiSrKArREjMIxANpyaRh+EA9COpLJvfaJ5Yox2+bb8qQQYE
         +SVt+OqW2vGO2ZFuBXYSp8xAb2+qbvV+TdBCvMFQMwDI0JJ5YRawajjqCg4lWtgzYdb7
         nm4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+mYO3B9LdGQ/w0tvFxoQd4RexvKxappNvsGery3Jc8cFNLsIajfhBhnQBxMHSf9p83+fFB+L7YZjZZtt3Sl9Sh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2w9iEYmTSakA5+W0Lsdpik+5zIVlCN44esaCFr5HUpRX+jLYz
	J7+a2/s+/ThTNTbOeMpqXlECnxkzndKXjLkmWcirPRE5Md/Eeq6q0NgIWx1DzOAjKz4Dm9RYo4V
	5zelXV8cyKQ==
X-Received: from dld33.prod.google.com ([2002:a05:7022:321:b0:138:281:799f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:619b:b0:12d:de3e:86a8
 with SMTP id a92af1059eb24-13831bdbdbcmr3002474c88.38.1781029286870; Tue, 09
 Jun 2026 11:21:26 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:08 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-8-irogers@google.com>
Subject: [PATCH v3 7/7] perf test: Add BPF JIT annotation test coverage for
 all disassemblers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

Expand the annotate.sh shell test to verify BPF JIT disassembly.
If the test is run with sufficient privileges (root/CAP_BPF) and
captures system BPF programs, it will extract a JITted BPF program
symbol from the perf report and run perf annotate on it.
This validates the temporary ELF generation and disassembles it using
each of the supported disassembler backends (objdump, llvm, capstone,
and libasm).

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 93 ++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index eae6a46a247b..ae03580fa023 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -18,6 +18,7 @@ skip_test_missing_symbol ${testsym}
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+bpftmp=""
 testprog="perf test -w noploop"
 # disassembly format: "percent : offset: instruction (operands ...)"
 disasm_regex="[0-9]*\.[0-9]* *: *\w*: *\w*"
@@ -25,6 +26,9 @@ disasm_regex="[0-9]*\.[0-9]* *: *\w*: *\w*"
 cleanup() {
   rm -rf "${perfdata}" "${perfout}"
   rm -rf "${perfdata}".old
+  if [ -n "${bpftmp}" ]; then
+    rm -rf "${bpftmp}"
+  fi
 
   trap - EXIT TERM INT
 }
@@ -169,5 +173,94 @@ then
   test_disassembler "libasm" "libasm"
 fi
 
+test_bpf_disassembler() {
+  disassembler=$1
+  feature=$2
+  bpf_perfdata_file=$3
+
+  if [ -n "${feature}" ]
+  then
+    if ! perf check feature "${feature}" > /dev/null 2>&1
+    then
+      echo "Skip BPF JIT test for ${disassembler} (feature ${feature} not supported)"
+      return 0
+    fi
+  fi
+
+  echo "Test BPF JIT annotate with disassembler: ${disassembler}"
+
+  if ! perf annotate --no-demangle -i "${bpf_perfdata_file}" --stdio "${bpf_sym}" \
+      --disassembler "${disassembler}" 2> /dev/null > "${perfout}"
+  then
+    echo "BPF JIT annotate with ${disassembler} [Failed: perf annotate error]"
+    err=1
+    return 0
+  fi
+
+  if ! grep -q "${disasm_regex}" "${perfout}"
+  then
+    echo "BPF JIT annotate with ${disassembler} [Failed: missing disasm output]"
+    err=1
+    return 0
+  fi
+
+  echo "BPF JIT annotate with ${disassembler} [Success]"
+  return 0
+}
+
+test_bpf() {
+  echo "Test annotate with BPF JIT output"
+
+  if ! perf check -q feature libbpf-strings ; then
+    echo "BPF annotation test [Skipped - libbpf-strings not supported]"
+    return 0
+  fi
+
+  bpftmp=$(mktemp -d /tmp/__perf_test.bpf.XXXXXX)
+  bpf_perfdata="${bpftmp}/perf.data"
+
+  if ! perf record -a -e cycles -F 4000 -o "${bpf_perfdata}" -- sleep 1 2> /dev/null
+  then
+    echo "BPF annotation test [Skipped - perf record -a failed, probably no privileges]"
+    rm -rf "${bpftmp}"
+    bpftmp=""
+    return 0
+  fi
+
+  bpf_symbols=$(perf report --stdio -i "${bpf_perfdata}" 2>/dev/null | \
+      grep -E -o 'bpf_prog_[0-9a-f]{16}_[0-9A-Za-z_]*' | sort -u)
+
+  bpf_sym=""
+  for sym in ${bpf_symbols}
+  do
+    # Check if we can annotate it (meaning JIT code is available)
+    if perf annotate -i "${bpf_perfdata}" --stdio "${sym}" > /dev/null 2>&1
+    then
+      bpf_sym="${sym}"
+      break
+    fi
+  done
+
+  if [ -z "${bpf_sym}" ]; then
+    echo "BPF annotation test [Skipped - no JITted BPF symbols with code found (race?)]"
+    rm -rf "${bpftmp}"
+    bpftmp=""
+    return 0
+  fi
+
+  test_bpf_disassembler "objdump" "" "${bpf_perfdata}"
+  test_bpf_disassembler "llvm" "libLLVM" "${bpf_perfdata}"
+  test_bpf_disassembler "capstone" "libcapstone" "${bpf_perfdata}"
+  test_bpf_disassembler "libasm" "libasm" "${bpf_perfdata}"
+
+  rm -rf "${bpftmp}"
+  bpftmp=""
+}
+
+if [ "${err}" -eq 0 ]
+then
+  test_bpf
+fi
+
 cleanup
 exit $err
-- 
2.54.0.1099.g489fc7bff1-goog

