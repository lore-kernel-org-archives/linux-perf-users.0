Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32137BE97
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982308; cv=none; b=qxX1W9snpBiaTQRsWVCPBlzIf46UfWUwbi5pnQ2WWke3zmzTTDrV9DJWf2QrQNT8t1+aUIpFf1Cj14cYxT4E/YXmEJi5ArBledL7wTW8Bi/x4XrFlBZFfwjov+5z9lmwuCmTV2xEAcuXXSG8Wx23+aKTvVq47wt5Uscu4AmyYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982308; c=relaxed/simple;
	bh=qvz4oeLDy+YWznYpNNUEyf6DwxyVkylxfaL4HrqO2Lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sSwZyhR0fa+BFFokvMGydLqRiuDUB18a9opK+Y8ZHdg9sEJg5dTbo+Cy4dt3HYl4b3ZxPKarJIHSLWfrT1zOnTob3gsM9l/y8w7LX4eE4dc6V4bFPCNB9RZE2AA3k4jY5sDEDS0GsBCRp6cryLgy4DYxHoPvNB36MDyAv2ZuxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcNW6t8t; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcNW6t8t"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f23c55b2so5118493eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 22:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982304; x=1781587104; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIXHmPDGDS7Qgr8fkgDEhnMYUYxH1NQb9jxl9ja86zM=;
        b=HcNW6t8tWJW5zxBRTqT4XDLGAd9v62tUg8PTFi9TwdxiWM1KDbYmdNxHOKUrNBfwrO
         8qz71TTPuYTx/gUuHUr3r98NEo6lWARwfz0AOVKL7Ac1f6L01k6eKTdw9H1DkZjxHd+8
         rbwDXcpadWZ2VJix/2RyuG5HHtlx9F4K8uBHAStaBTP19EB8aW77xzz4DCMqjXUjIfXq
         pFPsglS1fa44aqy7zCHHl4Bc4LQ9LSX9/PW3w2aZBLIwOFFG3ZohpFvqnWc9qrqYIH4B
         abmP+08J3h+6sPmHKcSlxFMrhndnaH9KX1TiNKjSFqfeRuIcqELqYAcqfvZ0ih7cKCua
         KT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982304; x=1781587104;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIXHmPDGDS7Qgr8fkgDEhnMYUYxH1NQb9jxl9ja86zM=;
        b=SUaMPfD80j3lbKbkj718pv4ZOMT3EZY1gdBTyDddOwrjOZ+NaJ042J39vBtHin1qFr
         QocMRP/IXku7dmg0fS7FtEl02B3sLjAwdXNqYKNPoYyk9cwYZEh3fz1eX6OG1qBeCtsZ
         TXMFGnz3NtrSR6q8ZIKHQk+tAvKo9Nngc7jLk9dc9txQRwhMmtcUJoodkctRFGzGhtAh
         IMKOWHAdhsygfU5y39cI1/poLV6Yh813HYVIWB1iPEMQtODr6kHoUIePjciCQG+Y4oK1
         cZpwyIz0TOTIpSF2hitmS3oKpCxQGTQBl2QlnHoiRddQGg5MSFCp6RauEzVOJ0NM+PoD
         bltw==
X-Forwarded-Encrypted: i=1; AFNElJ/cIRmSPhkWf8SOchi9FB0m0fczelW/dKmbJLPdRYs3wY6tljY54qr1k8nfO5sn1qY/u9dHEavB9Nnx79dmHMFr@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZrzYdGQ0QeRF5Bi5Y65xwK42wgx40gkTovHRryNa8c2BJgf+
	+JOgxcgG1vhqw+7CPNECc2ykY13Yxp3rQLdNQjFBfk1FpHfZBkpSfnQbIcGHxEwp684wW8dpkF5
	p9lv7krARhQ==
X-Received: from dycso24.prod.google.com ([2002:a05:693c:3618:b0:304:e89d:c06b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4347:b0:304:bce9:25fa
 with SMTP id 5a478bee46e88-3077b3305c5mr10548935eec.4.1780982303685; Mon, 08
 Jun 2026 22:18:23 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:59 -0700
In-Reply-To: <20260609051759.405027-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609051759.405027-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-8-irogers@google.com>
Subject: [PATCH v1 7/7] perf test: Add BPF JIT annotation test coverage for
 all disassemblers
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
 tools/perf/tests/shell/annotate.sh | 69 ++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index d3bafa7e3db5..d8c710470c52 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -165,5 +165,74 @@ then
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
+    return 1
+  fi
+
+  if ! grep -q "${disasm_regex}" "${perfout}"
+  then
+    echo "BPF JIT annotate with ${disassembler} [Failed: missing disasm output]"
+    err=1
+    return 1
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
+  rm -f "${perfdata}"
+
+  if ! perf record -a -e cycles -F 4000 -o "${perfdata}" -- sleep 1 2> /dev/null
+  then
+    echo "BPF annotation test [Skipped - perf record -a failed, probably no privileges]"
+    return 0
+  fi
+
+  bpf_sym=$(perf report --stdio -i "${perfdata}" 2>/dev/null | \
+      grep -E -o 'bpf_prog_[0-9a-f]{16}_[0-9A-Za-z_]*' | head -1)
+
+  if [ -z "${bpf_sym}" ]; then
+    echo "BPF annotation test [Skipped - no JITted BPF symbols with samples found]"
+    return 0
+  fi
+
+  test_bpf_disassembler "objdump" ""
+  test_bpf_disassembler "llvm" "libLLVM"
+  test_bpf_disassembler "capstone" "libcapstone"
+  test_bpf_disassembler "libasm" "libasm"
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

