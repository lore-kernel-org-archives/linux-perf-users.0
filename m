Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA93DB337
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988885; cv=none; b=SVvBn54zyDlosN7lBdt2t5i3LV9bg+AiBT9a/uzymNHKZeKcxcLuK1VlZ6J2R3rhN7fdYpfOAN6110IiE6iJkbRqIqFRzViznB+eNjLxF1NgOlUB5CWz9ZKYLLqJKo7jOVLYbtyLjOIKaLmEej1XlfGYb2K2xojL32ZtGi45Dpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988885; c=relaxed/simple;
	bh=gZ8M38yaPWQMUh5IQOrNx5lYfy4Orh9NGNPa8bKckok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=szTtosRsyQ1WNGBS+H2XvTfL0wKb+sA74gZMOuz370BOdS9Nu/ztMKKPZyvJivKJbi97YvvsvXpXA2KdqJj8Wmq7hhW3WY6zXVH7e0Vtv+3y1bWjCjM0SFHmids8Jx1i0qZsN9BCksj/9bygbKVu43fwxzw3zDhMNUsbQDHJcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVT3kX0K; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVT3kX0K"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd3a60e8so6666912c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988874; x=1781593674; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmjF7cpxWrbBKhUHXvgT7w2ieRaQjttZ0h7t+S6dB6I=;
        b=SVT3kX0Kwj3ReBSZdVgWPoJe65NIU7cHl/9PEmbYtdQLlLjbkvHNBrfbRw1GonPlh1
         sOGQrUOlniEJlzTUDKEBcFp6BDCD6+kK/86Ynkx8Z4UVT2CEsEbqO3ieB6hriw24gJkn
         yYsFC5n6nFEVAWi5wT7231AwMOjjwErVoPPHo4ETFWHYv8Fpd1HWRCeBWXjkNiht/WFp
         VGwOBycVax24khZsDMXNIuh52inq1nC362Sxd4nMEc4bZPHaAomS7NAfJYOcQXyClUIc
         XA7lh0sFAtyl6K4Z3KMfSldM4irIc9kH4cID+3YWcLM3DVKTT2itkBUXFiwlWFKuUAan
         YqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988874; x=1781593674;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmjF7cpxWrbBKhUHXvgT7w2ieRaQjttZ0h7t+S6dB6I=;
        b=qw7A9TSa9NTNi83hi4a/qOS77z5OmivvgDwh+XyDaXwawT9clMpdDI27OdvXhGfh/P
         bCMdvElJMVjMTbsk7/m8HK87Lrn5gA5XvKcnYjONyDZIyqxwrGj3STN7XVAd+kN1AqO9
         6WhN2m6SSmpGkLSAQ5iF3iF3GTb+naK6xiO0Lscsn8f1HEyBfYewD3dC1GUzNhpXWYTE
         srTgLDavtNtTCL4OdkiLEDaPuoYyzubQXaA+Cpi/WWiOo1dxQMXmsFzn7yzFzWVYY907
         ArEOrXgQAzxsmdlq1UOu43W3FFIGSRfyEsGJsPGpprw4I26u2/MMUvAx/Zc0lx4O03Qr
         OQuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+r0WEBsScnD0esYm5BCH3nTl1QNqn17LhUcPw+hJ+RBWw8uRhgOtpSCLA/RbtqbAkjDHyRq6NdX8UmDWEvDd+5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4vDiE3j1DQQJ7skheyYsxg9P2Kt0c48yxCl5RQDanOd8r78S
	304GlDpPZaxoFOH4+BtV5wYK47lpRBVxhG/yu/7ntmETtDW1ZOkxr+Jvs6CjW6vxiIdpQYCJ7SD
	Uo8zN/x2QAw==
X-Received: from dlbvv25.prod.google.com ([2002:a05:7022:5f19:b0:135:38fe:4472])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62a6:b0:137:9399:fc59
 with SMTP id a92af1059eb24-138066e0064mr8443142c88.21.1780988873423; Tue, 09
 Jun 2026 00:07:53 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:07:32 -0700
In-Reply-To: <20260609070732.545416-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070732.545416-8-irogers@google.com>
Subject: [PATCH v2 7/7] perf test: Add BPF JIT annotation test coverage for
 all disassemblers
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
 tools/perf/tests/shell/annotate.sh | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 2c06d2670cb1..9719e592befd 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -163,5 +163,84 @@ then
   test_disassembler "libasm" "libasm"
 fi
 
+test_bpf_disassembler() {
+  disassembler=$1
+  feature=$2
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
+  if ! perf annotate --no-demangle -i "${perfdata}" --stdio "${bpf_sym}" \
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
+    return 0
+  fi
+
+  bpf_sym=$(perf report --stdio -i "${bpf_perfdata}" 2>/dev/null | \
+      grep -E -o 'bpf_prog_[0-9a-f]{16}_[0-9A-Za-z_]*' | head -1)
+
+  if [ -z "${bpf_sym}" ]; then
+    echo "BPF annotation test [Skipped - no JITted BPF symbols with samples found]"
+    rm -rf "${bpftmp}"
+    return 0
+  fi
+
+  # temporarily override perfdata so test_bpf_disassembler uses the right file
+  local old_perfdata="${perfdata}"
+  perfdata="${bpf_perfdata}"
+
+  test_bpf_disassembler "objdump" ""
+  test_bpf_disassembler "llvm" "libLLVM"
+  test_bpf_disassembler "capstone" "libcapstone"
+  test_bpf_disassembler "libasm" "libasm"
+
+  perfdata="${old_perfdata}"
+  rm -rf "${bpftmp}"
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
2.54.0.1064.gd145956f57-goog

