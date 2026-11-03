Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672354;
	b=xOa4W28QfWY7ieywFLDvQ1lENmeSmxMR1n6F41qpsA+H9YlyGhk5SZoI+F23i45HTL8w
	 4iXBYBdZRRkB/qrJSPist6iQdTvrNyCw0xZFN7WP058TmEmGg/Q3vhowgYLz4TJliY9Wg
	 cRV8NyTK2ay7zmXY0vRwQKKqx29kBdyFD3xeiOinPR3f27I34ryRFd+SNEJY3ry7txezf
	 aofXAQAorx0sYC8XY+XFhuQMCuVMYBcTV8qUYSoTsScAzDeXUChSSzoFcCNuUyYMsgCry
	 dOy7MO3AQwSDZKwFtcaxvP9m7oRejGrx9QY4JdvDGTPO8bswK6BnWlhSR5X5ohZZhQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MvDrv7SprQaWmVBVhAVIY6gikWVWszm2+KTVP/5Y8Tk=;
	b=UYtAozMTxjGBY/ajmvmA+Q1Mk6mggqq+UXYJGW9i+BPOrT2rjz2qToJKqvn9C01Ri9aN
	 WtVijQWTl3NEwVDwb7dtcrOGNrNIjfhKI+/MZGEa/JPYevPiJwIAobGOsm6k//fHem2Ls
	 dkNb1Ecail08NbMzSFrCp53CxMXlD4yP3EuI98+tAxVhqm+J5WsKEk9vrmUETcK3plw+2
	 +LUjTbazxAfi98SMtCf85ubkgvwgJCUYDKlrzCwaUlDdUUeMw/JBOKtEaqfHm5yd16pRL
	 JPDdiuDY67sH+jOrEx7M232q3dJknlMnAqBVFtYYkBC/O0xnA8vOAxunrlw18W87qWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xad342Lh;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E06606A32F
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E06606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xad342Lh
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b2fafe2812so1564627b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 18:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672353; x=1794277153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvDrv7SprQaWmVBVhAVIY6gikWVWszm2+KTVP/5Y8Tk=;
        b=Xad342LhSMfiyI2xHtA1S+WvJhHtfSpXgbOD74InaXFn7ncfLNl+49TekVEXvUUujv
         VTt9l2iVZD66xmuNs9oBHfQHnqAe0eQZ/DQfkm0DhLkoFFHYxU2L2g7UXd/jMdfEJnwm
         uW95fDshUASSUDK/FbqMfAZjVQFZheEzWVdrjBys82eWOKMpsXgNvORz6q3mhjQ9chDo
         UtXXP2PqIb7Xi+T/cpgJdCYTAmDTnYJ0/nA296MIWDynSMCnQsDy8N4lmozYqK2h+v/3
         u5VFXGCOPqlLhIN8plezcXgaim8u+bBASxpWyMP2AhP+gNxEqN1bt9tK6WxBbvUYV8zK
         jAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672353; x=1794277153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MvDrv7SprQaWmVBVhAVIY6gikWVWszm2+KTVP/5Y8Tk=;
        b=uMSgU1zZi1AhsIGfD0jW4V4S92Zq8EjSCLHDCsJTlUN5M5iS/bPJpTiOfssdv2oYUj
         xSpNdBZYYXg6NAMcpHef+3PjkRyD7dabOROLg8d61P0I7krChPldf6qKm5DT2QeH8STR
         pLVLZz/PlHTsBscHA4lyVV8Ugt0qkeTWBMEVHqnA/6p1yQl55HXPf0Srl0Hqc9spaSwb
         0SpJYvHr5h4aM6QiaE7eUvSg3phh+gQgkXRGgeLnKxNXBJmDdm3BNPBD+gnR5WbJMlhE
         mJwHKPLFTBeF0GlNlk7ORcYQpaLQiaiviOxuV7ykJ1iMoY7NiRFFJGF9yxC2+3lmTtac
         7Jtg==
X-Forwarded-Encrypted: i=1; AKwUvBw6sao9OPCKGC5Hf6491SmrXRhZHiQmxlw1PsmlPIF/azFUKsGO6lqLLAJnDt8tqzC18UR7PrBwtwN1i2l1CQnj@vger.kernel.org
X-Gm-Message-State: APuU4Z+KYatSWiWxuzHyNplThVrCappkPDevduYRRhFB8ffQlebAb5jH
	Yg1uKgpfWSnxFpM5bprVr659gMrdNlinsoq41BJcX9PGlOi9moThPjfF
X-Gm-Gg: AYBFou23Lo2qYXHw/Xo8q6ALsDvaWoagzt4UzPaGIfdGT7pQOluOpAm/g3W12Qp5zlK
	GN0PClGiFL/JaP56jRdROB8jiQ0K4WN3Qql5qMdD+9tQdPiOXTJf57m5Un5LyVaOL7UEYjmAM2I
	7da1g0Xe9IZrLKiOER2QEPv0bFuuzF8CP/hdASDCKey1arM0PVdHeEWC6DRlH81g8qkNtjHXOxN
	wu7ZZC9TA05shY1CLbaCN+HIWexMNfDYVEykc6OMtjTbAzKYHQ+0xhE9LDe6SZWMFHZe2eKBlTv
	/Bw7Wt0D+4zGYRuoPQJIFV6YD+itaaHsVfPTvOB2tOlS3pNQ/jhuE3sC58hdeypYaS72sbTwv1j
	Pdtx78f/Bv9/WB2vAuW6cos2HsPQHQGkTjFq9bxhZkccnMsGvljhtOluhO42EZ4VHZjKx2WLLcE
	PuVbjX42tpA3bFR5tp1xr5SF9LoScljdiXJB34ObmxJLYwo8ZPnXMtj+F3aXR+vbuHLZFWJlM4j
	QMe46Cp7f5Elgm8N7F786CpVteVMzdBY3nPLOi3v2VY3PPlXGoycG2n0RCUF3OUYN7GR9jKDcx+
	6a0hD5p3rrMZsbjTZeCluU6TX5ufzgwUGroXSdK7vQ9MBi/y45VkjxP7E/ppkrvDtSLeu0Y7BjY
	tE42Kosyjfg==
X-Received: by 2002:a05:690c:6b12:b0:8b2:bb94:8cc3 with SMTP id 00721157ae682-8b2bb949006mr72128037b3.4.1793672353112;
        Mon, 02 Nov 2026 18:19:13 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716d420sm64921327b3.33.2026.11.02.18.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:19:12 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 02 Nov 2026 21:19:09 -0500
Subject: [PATCH v3 2/2] perf python: Add alpha-profileme.py
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
Message-Id: <20261102-perf-alpha-profileme-v3-2-4bf6e1dda733@gmail.com>
References: <20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com>
In-Reply-To: <20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8152; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=DgT96Z0hihdJ6DSgtpMcvvBYBQLCqGIOXeDl+xKLPWI=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeuswxylEXEe5Mm8DgLjyHYdGxza5u3uaplxR+35j3K
 HbN7at6HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNfz2Gf6aSXo919i
 s2qJ8tFmBYpbjZdRaDk/emzX8v6Swps3dR62P4Z/axfvvTkylrDlga6lSq25+feziY3fbw0Xffx
 b4azvslwgQA
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

Raw data is only read from cpu PMU events, as a tracepoint's payload can
pass for ProfileMe status. Rows are kept apart by PCTR_CTL[SL1], as a
mean over two things PCTR1 can count means nothing.

On an EV7, sampling a loop whose branch tests random data reports that
branch mispredicted in 21% of its samples, and 0% with sorted data.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/python/alpha-profileme.py | 172 +++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/tools/perf/python/alpha-profileme.py b/tools/perf/python/alpha-profileme.py
new file mode 100755
index 000000000000..366b288c6e1b
--- /dev/null
+++ b/tools/perf/python/alpha-profileme.py
@@ -0,0 +1,172 @@
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
+
+Samples from events that set PCTR1 to count different things are printed
+in separate tables, as their means cannot be compared.
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
+PCTR1_NAMES = ("cycles", "retire delay", "bcache misses", "mbox replays")
+SAMPLE = struct.Struct("<IQQQ")
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
+        # Keyed by PCTR_CTL[SL1], which sets what PCTR1 counts.
+        self.tables: dict[int, dict[str, Row]] = defaultdict(lambda: defaultdict(Row))
+        self.skipped = 0
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Add one sample's ProfileMe status to its row."""
+        raw = sample.raw_buf
+        # Raw data from another PMU or a tracepoint is not ProfileMe status.
+        if (sample.evsel.type not in (perf.TYPE_HARDWARE, perf.TYPE_RAW) or
+                not raw or len(raw) < SAMPLE.size):
+            self.skipped += 1
+            return
+        version, pmpc, i_stat, ctl = SAMPLE.unpack_from(raw)
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
+        r = self.tables[(ctl >> 2) & 3][key]
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
+        """Print the busiest rows of each table."""
+        total = sum(r.samples for rows in self.tables.values() for r in rows.values())
+        print(f"{total} ProfileMe samples, {self.skipped} without ProfileMe data")
+        for sl1, rows in sorted(self.tables.items()):
+            print(f"\npctr1 counts {PCTR1_NAMES[sl1]}:")
+            self.print_table(rows)
+
+    def print_table(self, rows: dict[str, Row]) -> None:
+        """Print the busiest rows of one table."""
+        print(f"{'samples':>8} {'killed%':>7} {'invalid%':>8} {'mispr%':>6} "
+              f"{'taken%':>7} {'stall%':>6} {'pctr1':>7}  {'location':<40} traps")
+        ordered = sorted(rows.items(), key=lambda kv: kv[1].samples, reverse=True)
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

