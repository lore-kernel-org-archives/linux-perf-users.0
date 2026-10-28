Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211030;
	b=i8OXe6BvEPlfsuLjHN9mV9jmKMKXU74RAHbtOCIpFczo+zqg5qvrIO9t9x/Fk7zGXzmq
	 ekBK0mNgPUaSOu2jOjPzh1QehIBkEhxwN/MyM+OtIPSE4byvxCuELM/u5wB4Ik7ME1idH
	 7Pb/gk2VmerYxQUepLz7s5mv4RfyQvT9Jgwro1QrSnP7tHLLIz0i/zh6p4NYFM2dFOCXv
	 /JT81CilUgz+kUbs9uy76n5dkHxscjgr4sNa+lhifIPhe+mIKSf8OFjwOj75mFkNWcDgK
	 tznCZqTa52gBqXiv+2itQPxeIAIrh00VTticBg/RhWPLYACtwN70uNL+08UjKtc8Ewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0lq4m03NYrQCtBsxB0aXuqoBWVs9ilXBWT20OwQFnLM=;
	b=MDCVwgWziUnfGFFWoDegPfUlGvftuF+zFYlyrUXe9WmPFE7lASQhiS5YpYn3H7MTMUge
	 OtrhoYYvP59mC++xJuFMfmdFfARQXFRQdVJABsO9Gy7kUa5QAK5lZR3FGU5Y5xOO1/W5/
	 JK3shcYLdhiev0Xtd20HvkmLNGlf8yAF4l7+OTgZQRJcfxHQpET6V5sWWJBAH1zQUi0Oo
	 w6d7acHBRvP6PmEXyWcSvGMwzip7fCUIW8hmzVE8FhByQLYVE0gKWLjTx6r4fCm2GB1n7
	 d3A2peZmfUjqkWanXJv1aquohWJ4WYmWwPppNytODZJEEHQ/9+9OnxMMqkCXf3I9pTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LxAxMBBM;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE77606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE77606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LxAxMBBM
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac8a2ac52bso16352257b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211029; x=1793815829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0lq4m03NYrQCtBsxB0aXuqoBWVs9ilXBWT20OwQFnLM=;
        b=LxAxMBBM/NmHZtcou1sI50Ngj6uKMhx7tBBvdweM1uo6kBa/y0PzU0zctVMSpLm1Ax
         ApjFxoRBDM8x7gqa2FvXJ4jUE6yfoO6WGdAOSF3G9FeYnsvdEzH+VfDuFQ3c0gPioYRA
         xcaRcKKEmdk6KgHPzSUFa7T9e6qys8dFxk5yAOr9bwnVf/U3XwSoA0ClzesKlHMxavez
         Jt78pqVy3j2SUdckIhJQgAjWfEW10JURgDIrpwAKrrjqPOCPiy91ctPbKGWWgfWJW3OH
         iO1gECGURnzNNQBzZasGlBSd8+EFKV7emyCr1nNE+XThFgkGj86mdH9P/jRe/Q16mPBu
         EmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211029; x=1793815829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lq4m03NYrQCtBsxB0aXuqoBWVs9ilXBWT20OwQFnLM=;
        b=kOa2TbPVu0XfxXHkFgDotjAHtshjNwwaJRud0rIJGO3jleBAeGN7vGGabotrkPEvh5
         emZ2V6zXqTEsAidLoECUErLVW8iX7et0I26Pu5Q62rOcA1YQyIB+eSGLOV8ElB7xnKyD
         PwADDQPOmMDYbQJo2w7WaXEvQ3PiaptgSPxwhKCjTYBL5FwquxkTTwHqHgFuIZwMTXoG
         rQ070S4CM2NrliCOJcYLywcioaG45ONRgTp3XD1dLEEkD3xlGA+bjXViWIp2fbWwZT7a
         fwhGBCKp7Fu8Qml/WadSvG6wXEubhxjN4KJqzz5BXRRvj/XzMM23UEWd+fotmFGVLO5E
         FZ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwxCcoZvtzHHoYz18MXGnHRM4/D8zzRhyaxLdRu2vSLKdktoauxnMXkDN/xbcmtWM4SMM9u8OQNwO+qLthxZF2i@vger.kernel.org
X-Gm-Message-State: AFq9FYI9vutJtp520uu9r4bIvLhnZ0OAn5lAT3/H4dEYFntU/Y4H36Mx
	fcgVD5cuQmwqbwnvWsllLKoZq7pbC4oFmGhxaj+ZLsHmwFzIUJnWK3TR
X-Gm-Gg: AYBFou0Rx4ekR0Fc8GSvCNmUP6PgRfniL5XrHtSvv4rtKa2LjHlYZbFeRKbuR4z9lbZ
	g69u9hLs4/GtJnUXV3PaqJ1ONbgYZ9BHvOp2AWIfnF+UWPFlaiRYLjyIeCBULYzYiFlbz4yYyFQ
	QNjkBp7nnzfwoCe660+rcpTIoYz+FkGctphxSCdHTf8QWcXZ/GDgXUFm+ma8iISPHNsL51CZ4OW
	epqDJ45SvJt3lD1i3Kz+pxVqa8gX/2SeZidEOS9TI+IIwFDt1Xhj9zPbFEXNBKGkTK5qnCR7K0v
	oM72LmnD2/Xlso/TmEpKmN4eo8lwKOFA0+Zr8W6wqdW48z7DMpEEDfV4qbfWt13KOvlRIlTBzEW
	JFkRDZIR3yGcA5ycduKnzjuWkIuD0K/HD32xf6T+oks7V9n7Q3XNf1+ZMHlEaw15MteJE7VoGoi
	yU+XWQ3ck3s6TYwyQ57rpiM5NPlv6MZtgMJxhwh5u7jEpC3NPMMW8qjIXquuwjqEo4ikQoeaFUS
	TcB+bfi1XvR+ilTtDv/INxhl/iiLBqFzurLOBADRf9X8R8y3UWuVBYPw25dspevQpWfiKZqYdA8
	f9jQtjUHMCW28xfyTLWzF29RGTw4F3msOxZcDo3ug/OgZ6/maxydGWrTH3MXqZpimBfWcOMO+MK
	aVoO1h4GSvr4=
X-Received: by 2002:a05:690c:92:b0:8a9:8744:c07d with SMTP id 00721157ae682-8b1c67060e0mr2503477b3.18.1793211029505;
        Wed, 28 Oct 2026 11:10:29 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e56e8fbsm32396667b3.16.2026.10.28.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:10:27 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 28 Oct 2026 14:10:25 -0400
Subject: [PATCH 2/2] perf python: Add alpha-profileme.py
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
Message-Id: <20261028-perf-alpha-profileme-v1-2-f46c1938d001@gmail.com>
References: <20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com>
In-Reply-To: <20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7232; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=fJUI/+ceFFMyr7qQjhNww0UZr4SeXmAFPl6PUbddWuA=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIeWfUnTbq6aH2ta4pwwNRTU6wc8/T3CZhcLzngU8Wcy
 K3dsG1hx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFzzW4uR4dxs9r17bP
 8ez5kTaVEoyB73x8mEWXhDLudJhe9bpKrOPGJkeJ5gdfQw+1xTLeEZ1+vvth1Qfrpba9eNsvu2O
 oxfOcIPcwIA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf report shows where Alpha ProfileMe samples land but cannot
aggregate the raw status attached to them.

Add a standalone script, using the perf Python module, that summarizes
it by symbol or, with --pc, by instruction, in the style of DCPI: the
fraction of samples killed on a wrong path, not retired, mispredicted,
taken or stalled, the mean PCTR1 window count, and trap counts by type.
Mispredict and trap types are only counted when I_STAT[TRP] is set,
since they are stale otherwise. Redirect traps are counted by their
PALcode entry offset in PMPC.

On an EV7, sampling a loop whose branch tests random data reports that
branch mispredicted in 21% of its samples, and 0% with sorted data.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/python/alpha-profileme.py | 162 +++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/perf/python/alpha-profileme.py b/tools/perf/python/alpha-profileme.py
new file mode 100755
index 000000000000..12b9fa04f85a
--- /dev/null
+++ b/tools/perf/python/alpha-profileme.py
@@ -0,0 +1,162 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Summarize Alpha ProfileMe samples.
+
+Aggregates the ProfileMe status that the Alpha cpu PMU attaches to each
+sample as PERF_SAMPLE_RAW data, by symbol or, with --pc, by instruction.
+
+Record with raw data, e.g.:
+  perf record -R -e instructions:p -- ./workload
+  alpha-profileme.py [-i perf.data] [--pc] [--top N]
+
+Columns:
+  samples   ProfileMe samples attributed to the row
+  killed%   profiled instruction killed before it was mapped (PM_KILLED_BM)
+  invalid%  instruction did not trap and did not retire valid (VAL clear)
+  mispr%    conditional branch mispredicted (TRP and MIS)
+  taken%    TAK set; only meaningful for rows that are conditional branches
+  stall%    instruction stalled between fetch and map (PM_STALLED)
+  pctr1     mean PCTR1 count during the window; what it counts depends on
+            the event: inum retire delay for cycles:p, window cycles for
+            instructions:p, Bcache misses for bcache-misses:p and Mbox
+            replay traps for cpu/mbox-replay/p
+  traps     trap counts by type, only for samples with TRP set
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import struct
+import sys
+from typing import Optional
+import perf
+
+TRAP_TYPES = {
+    0: "replay", 2: "dtb2-3l", 3: "dtb2-4l", 4: "fen", 5: "unalign",
+    6: "dtb1", 7: "dfault", 8: "opcdec", 10: "mchk", 12: "arith",
+    14: "mt_fpcr", 15: "reset",
+}
+REDIRECTS = {0x481: "iacv", 0x581: "itbmiss", 0x681: "intr"}
+SAMPLE = struct.Struct("<IIQQQ")
+
+
+class Row:
+    """ProfileMe status totals for one symbol or instruction."""
+    def __init__(self) -> None:
+        self.samples = 0
+        self.killed = 0
+        self.invalid = 0
+        self.mispredict = 0
+        self.taken = 0
+        self.stalled = 0
+        self.pctr1 = 0
+        self.traps: dict[str, int] = defaultdict(int)
+
+
+def pct(n: int, d: int) -> float:
+    """Return n as a percentage of d."""
+    return 100.0 * n / d if d else 0.0
+
+
+class ProfileMe:
+    """Aggregates ProfileMe raw sample data."""
+    def __init__(self, by_pc: bool, top: int) -> None:
+        self.by_pc = by_pc
+        self.top = top
+        self.rows: dict[str, Row] = defaultdict(Row)
+        self.skipped = 0
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Add one sample's ProfileMe status to its row."""
+        raw = sample.raw_buf
+        if not raw or len(raw) < SAMPLE.size:
+            self.skipped += 1
+            return
+        version, _, pmpc, i_stat, ctl = SAMPLE.unpack_from(raw)
+        if version < 1:
+            self.skipped += 1
+            return
+
+        symbol = sample.symbol or "[unknown]"
+        if self.by_pc:
+            if pmpc & 1:
+                key = f"PAL+{pmpc & 0x7fff:#x}"
+            else:
+                key = f"{pmpc & ~3:#018x} {symbol}"
+        else:
+            key = f"{sample.dso or '[unknown]'} {symbol}"
+
+        r = self.rows[key]
+        r.samples += 1
+        trp = (i_stat >> 39) & 1
+        if (ctl >> 26) & 1:
+            r.killed += 1
+        if not trp and not (ctl >> 1) & 1:
+            r.invalid += 1
+        if ctl & 1:
+            r.taken += 1
+        if (ctl >> 27) & 1:
+            r.stalled += 1
+        r.pctr1 += (ctl >> 6) & 0xfffff
+
+        redirect = REDIRECTS.get(pmpc & 0x7fff) if pmpc & 1 else None
+        if redirect:
+            r.traps[redirect] += 1
+        elif trp:
+            if (i_stat >> 40) & 1:
+                r.mispredict += 1
+            else:
+                tt = (i_stat >> 34) & 0xf
+                r.traps[TRAP_TYPES.get(tt, "other")] += 1
+
+    def print_totals(self) -> None:
+        """Print the busiest rows."""
+        total = sum(r.samples for r in self.rows.values())
+        print(f"{total} ProfileMe samples, {self.skipped} without ProfileMe data")
+        if not total:
+            return
+        print(f"{'samples':>8} {'killed%':>7} {'invalid%':>8} {'mispr%':>6} "
+              f"{'taken%':>7} {'stall%':>6} {'pctr1':>7}  {'location':<40} traps")
+        ordered = sorted(self.rows.items(), key=lambda kv: kv[1].samples,
+                         reverse=True)
+        for key, r in ordered[:self.top]:
+            traps = " ".join(f"{k}={v}" for k, v in
+                             sorted(r.traps.items(), key=lambda kv: -kv[1]))
+            print(f"{r.samples:8d} {pct(r.killed, r.samples):7.1f} "
+                  f"{pct(r.invalid, r.samples):8.1f} "
+                  f"{pct(r.mispredict, r.samples):6.1f} "
+                  f"{pct(r.taken, r.samples):7.1f} "
+                  f"{pct(r.stalled, r.samples):6.1f} "
+                  f"{r.pctr1 / r.samples:7.1f}  {key:<40} {traps}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        try:
+            self.session.process_events()
+        finally:
+            # Break the reference cycle between perf.session and self.process_event
+            # because perf.session lacks cyclic GC support (tp_traverse).
+            self.session = None
+        self.print_totals()
+
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Summarize Alpha ProfileMe samples")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    parser.add_argument("--pc", action="store_true", help="aggregate by instruction")
+    parser.add_argument("--top", type=int, default=30, help="rows to print")
+    args = parser.parse_args()
+
+    analyzer = ProfileMe(args.pc, args.top)
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+
+if __name__ == "__main__":
+    main()

-- 
2.55.0

