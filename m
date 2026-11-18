Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019428;
	b=rLKutDyfIzKLcNmYL+ShIJ395yiVN4VeCGxRY3off4tlQM8Kc9xmiyBrN7xGNxv4bD90
	 if8or9Q3V9mzxE2wSEIpeMXzAh4AP5QcSd3tiLbyZ1Fx0V4a9w/GQ9DoFZ4qvdO0U5b25
	 MdmSEx7PaQrYdkZTENvMCvYHEg5JxE03dKytdw+6a0/E+MTAgIw4NorUDjbEPiKepoOGq
	 UHpcJB0TFUh4DkK6eY5ZnU8jrPBfD4+1s2uaQmWZgBbv05ZLt8U3exVnE/bj3Y+aESsHY
	 WRuG8m6Bdt4oHC+Ze26JO4yGEMhTdcYn9C4ny0nQ0XaeBgnHfOZRyaWcBjwS0NnSQaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=oCXi5c27gxkETQPEkp8qfLLdejyp5sedYaxTjamqL5A=;
	b=tWKd2o7CDkXL5A9xd6/ewdyAiz+OAslHZE3Kf6pQWFnta/BoTQZPioVnT4W+tJ+ZSkKK
	 4Vt8ph+KcfiQAOk/NVYirooOLe7PoTyklYjHK2dz0TRwlW1dL8UDiu1tx5N3GY0p4RmUl
	 khMgVcBTKpjmmqILToXNukVSJIPm2Fv1mJrtRt4bwS1akQSispZ7jbAwPGjEkjXSmVGuX
	 Qzgwf6JmRiAlk60xjk5gAJfUdOb5vQK8AQHTdibYEICGfMmjLZrRChhqvcdB4vzCo9dXI
	 WEGoXjmNg0kxcvbURvYTmUF/cmdNT/KOwAmyjdwjQROvoTy0LH6xqZV2wnQXNT+hVGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xnSA56rT;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E360A6F4B
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC8E360A6F4B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xnSA56rT
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-492690dd5daso987340f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019425; x=1795624225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCXi5c27gxkETQPEkp8qfLLdejyp5sedYaxTjamqL5A=;
        b=xnSA56rTuhEKTBnNx9gEjZEUUyG0bfkdmDokZuVVyepEEewvWYPFfroZ9LrD1HI5to
         je7PpnzqWmp1MfddWISl+13PBH+x49rn+E3I2USb8SL+CJTqL1RFh2rU+X8t5IwqL/Xq
         B6J5ES6rizofEX6YEzeUdTd83s6uZ3uqszbPCStQeKoqdgavVpgUZJCP9dkPDcWp5Rpi
         0in0AeNDKitnado43ReZlDEBOWrTW+1HHMSpjuoZMLNDd79EOWWq3gKIqiprAeoTxZbN
         yv2/eaijh9uha8x+rKkDVUmNJ362HpBDM1lXWak5QKo9AvsTpLH3UeueKNwmb9kJBzjh
         AY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019425; x=1795624225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oCXi5c27gxkETQPEkp8qfLLdejyp5sedYaxTjamqL5A=;
        b=x0HGvQPXMlGiXcMEheD2i0Sj+dBxug7PYJQFHsNBa0LlroRosPYIu87C3DcxR5n4YG
         ylgm8O97MTVIe9TJgfoR7sOHmvKyRAjdmPSRpyOuAdHD6OTF0YIheAlokRUR0veHallz
         FWyL1AhJj6ibi3VXxYtAEUX+UQ/E5i2CT6QzHDeXSvHpCxvVXGmMB93eJPO4E4ZGpAVf
         fwuvIcS3/NmAU3K38b5/5z00X6kJ1kU77aajq0GXz1/eEauBhW5NX9miK1SDKMpDc/9Q
         5V2/kcO/mSj1ThXgWJ3fJoxBRc9dSt5KSToZ1SR4o1CMivKypEYFwFI52WOQrYLMsWMv
         OtTg==
X-Gm-Message-State: APuU4Z+sihOYz6HS4yKhCpIFLyBY7PfvYqPFRWlBdK3Imr8R6d5yRsko
	z8OKv529pajQaIHWV0l4oI44lAQw8A47UqNP56pryWoEQs0owFnySyqeD+9hFO6k/8s=
X-Gm-Gg: AZFdTZfRREF0KgbabJ6F4tRd9j0N2jEjf7O1A6KXK3B6OKFHJeMP9WCUoxKJbiSMiBF
	KXByaRQf2c9CeTszKuwKLjLJPNCs7IMETdKY+r96+7eHyoOGNC6M7PgxfutyXBw5PtETUjyEZI9
	uCMhlAyy2kEIb5gDhgjPyisMWHO762b3EJtuW+BaInNzpcn0He4JmoY1f9N3kKgsyUjQHRE9os0
	31iEuZ+4jJQBpP9uGn9b1j12UNtAd8tnTnOBtBEHf/8/KKpJ0D1wZfPegOxQQJ8av+QWIutHggs
	cssaWesfj9q2UA5+1Lps4WaRlQvckMrzu6NjCOSKpG6rMZpxqj4+gj2gdH/gMDouVwaPRNzcnUi
	hk+BkTgx8LdtNlsVqHG1hJfTPpN5fCG6EbeflmrfFzBBTQmzimGVQCshlGtgg1adpi3+9217b6C
	rx4MOnroYwn0XVQyS2XrwlRvlJTYtOhWPnDfPkHF3ocC4LuWdCBok55AKO4XvEMdaNMqcWEbHqF
	NnaV/TmXW9Z/NAs+WCbmkPI+4ahj0nvlpILQafLJjb71QhVo/dRfVbF0xy/WYZLgfXMHsPfT1jI
	e7d1mMxvYG0rnTdZzYQu9/PcHxsbWep8
X-Received: by 2002:a05:6000:26ca:b0:4a7:9630:7b57 with SMTP id ffacd0b85a97d-4a7963080f2mr4671595f8f.44.1795019425254;
        Wed, 18 Nov 2026 08:30:25 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:24 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:56 +0000
Subject: [PATCH 34/34] perf test cs-etm: Add an HHVM JIT call stack test
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-34-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Record a Hack workload with HHVM's jitdump enabled and compare the
decode matches the expected order of execution.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/hhvm-jit.sh | 89 ++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/hhvm-jit.sh b/tools/perf/tests/shell/coresight/hhvm-jit.sh
new file mode 100755
index 000000000000..cde8725519e6
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/hhvm-jit.sh
@@ -0,0 +1,89 @@
+#!/bin/bash
+# CoreSight HHVM JIT call stacks (exclusive)
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -o pipefail
+
+perf list pmu | grep cs_etm > /dev/null || exit 2
+# Require TRBE so that the trace always has virtual timestamps.
+if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
+	echo "No TRBE sinks, skipping"
+	exit 2
+fi
+command -v hhvm > /dev/null || { echo "SKIP: missing hhvm"; exit 2; }
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_hhvm_jit.XXXXX)
+trap '[ "$?" -eq 0 ] && rm -rf "$tmpdir" || echo "HHVM JIT test files retained in $tmpdir"' EXIT
+trap 'exit 1' TERM INT
+
+# Use the control pipe to only trace the two call stacks rather than all of HHVM's startup.
+# Run stacks() twice to test hot and cold versions.
+cat > "$tmpdir/hello.hack" << 'EOF'
+function command(resource $ctl, resource $ack, string $cmd): void {
+  \fwrite($ctl, $cmd."\n");
+  \fflush($ctl);
+  // perf writes sizeof("ack\n"), including the trailing NUL.
+  invariant(\fread($ack, 5) === "ack\n\0", "Missing perf control ack");
+}
+
+<<__NEVER_INLINE>>
+function leaf(string $s): void {
+  echo $s;
+}
+
+<<__NEVER_INLINE>>
+function a2(string $s): void {
+  leaf($s);
+}
+
+<<__NEVER_INLINE>>
+function a1(string $s): void {
+  a2($s);
+}
+
+<<__NEVER_INLINE>>
+function b1(string $s): void {
+  leaf($s);
+}
+
+<<__NEVER_INLINE>>
+function stacks(string $hello, string $world): void {
+  a1($hello);
+  b1($world);
+}
+
+<<__EntryPoint>>
+function main(): void {
+  $ctl = \fopen(\getenv("PERF_CTL_FIFO") as string, "w");
+  $ack = \fopen(\getenv("PERF_ACK_FIFO") as string, "r");
+  command($ctl, $ack, "enable");
+  stacks("Hello, ", "world\n");
+  stacks("Hello, ", "world\n");
+  command($ctl, $ack, "disable");
+}
+EOF
+mkfifo "$tmpdir/ctl" "$tmpdir/ack"
+export PERF_CTL_FIFO="$tmpdir/ctl" PERF_ACK_FIFO="$tmpdir/ack"
+export JITDUMP_USE_ARCH_TIMESTAMP=1
+
+# HHVM deletes the jitdump on exit unless KeepPerfPidMap is set.
+perf record \
+	-o "$tmpdir/data" -e cs_etm//u -D -1 -m ,8M \
+	--control "fifo:$tmpdir/ctl,$tmpdir/ack" -- \
+	hhvm -vEval.PerfJitDump=1 -vEval.PerfJitDumpDir="$tmpdir" \
+	-vEval.KeepPerfPidMap=1 "$tmpdir/hello.hack" > "$tmpdir/out"
+[ "$(cat "$tmpdir/out")" = "$(printf 'Hello, world\nHello, world')" ]
+
+perf inject --jit -b \
+	-i "$tmpdir/data" -o "$tmpdir/injected.data"
+
+perf script -i "$tmpdir/injected.data" \
+	--itrace=b -F ip,sym > "$tmpdir/script"
+
+stacks="stacks a1 a2 leaf a2 a1 stacks b1 leaf b1 stacks"
+printf '%s\n' main $stacks main $stacks main > "$tmpdir/expected"
+sed -nE 's/^.*hello\.hack::(main|stacks|a1|a2|b1|leaf)$/\1/p' "$tmpdir/script" |
+	uniq > "$tmpdir/actual"
+diff -u "$tmpdir/expected" "$tmpdir/actual"
+echo "HHVM JIT call stacks match the expected sequence"

-- 
2.43.0

