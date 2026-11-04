Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818447;
	b=wpb3XA8W2cO2/oRChTstKijdts0G+QM7y0rPSnX4VU+EDUitJfv7PTZf9RHtHSjChDg4
	 RT8zVqrsUOvyyX2GZEv6MYFYAex83RyR93Z9SQTsLPSmfRKc8Z/V83UAWYgKELBX6CP9b
	 0ANZ4Dknow9NIoQWIjwBhfJrVQ6ezhszcy55COquNUeuUYbPN37t1QNif4vXNIa8eyQHT
	 mMxqoyQCA/4TRdq2Gk7YlJJO8YSSu8QRY6KpVLPBOicXU5gAwPQO8oUSBsrS4/OEKpP4S
	 vdswqo/r9HDkT1ibLnO7dJ+NhsocvZ1TxhCYF43iHNhFUe9HO+yd4wf0iYmjMMMv23g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=/AOC0zKLt5ZW95N1gJu6YbD87wTpnyQ+KQVNXuHJSQ4=;
	b=VlT2uT/ILzvqTsyjExlU6QumdNzuqUAcBajSjoVdVm5eaA7UOgA/8czR/saNq+5lYNqc
	 y1Pyl1M9/43rgq0gthGJP5mtBUd2cuASjPBYWQMXjTZtV8ig76ve8tHsuwYRUl+HrMWuS
	 mN/cLQQtL8MALIxuHVyPetEe5RSePrQxyF8jy9D7MPFFEN8tizXwU1oCE/EiR+0lkDauZ
	 w85uTsrUZLsMu+Ft2WYjti6lhS1trBzVPZTjpvpyuVcUc43R+4wr5gp2RMu8aTU8RSTdl
	 NCw8pr1rM85ORdNyvZL4JGqmaIX/NcrfeLSwwdZNjMiHo11BF8taLhLoJK231x0k1sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwpKm2+B;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E6606EEAC
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042E6606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwpKm2+B
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab43af5e97so13018137b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818446; x=1794423246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/AOC0zKLt5ZW95N1gJu6YbD87wTpnyQ+KQVNXuHJSQ4=;
        b=DwpKm2+BTX81L1F49YpXO4FykMzzkbsBmX52y6Aoyhk1q1tr7S7S8fOT0IoEbGGV8y
         xjWS0eGhGoPKHYd6nn8AqggGqxIbQ4hM46X9uSk104jN0y0CkptoyXf56Rq4r5xTnDQ9
         OUOdYuJvx3BwwYQivtE33roxbxLbK0RwsucdLcx0rXKXx3JseARLExbH7rE05MLA7sbH
         ftesP0i+YumTj6okaZjZDNCmOihIuIuEhuRPQom9VLpBTWKP2pKvF51T3nDq0uS4ilGb
         4bMafRGtwZkZbNVe+zE//85LG8lEXl41x+u9QAgj2rV3gNlg+mBrq67BN0srVDD+W/ei
         X8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818446; x=1794423246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AOC0zKLt5ZW95N1gJu6YbD87wTpnyQ+KQVNXuHJSQ4=;
        b=It/jkqcY8lz15HmEPSLX21Mjb7HmhyayGN302qLkNLNEgd/EV4W2WLur21wuOJFLP3
         e6IKovi9+zlRXSr4ofBYgP5sheefntmKe8rpWYEJZoxRqtdrwjHXKbpGhHvNEdHgnzpA
         QmVTDrq5Ew8y0LOUVr89xFjmKXhiXvyXJQF5Z9UFpeyZX1ChKZ8icsr7CSipT4YRykBk
         2qmGZ881FO4/U9SkoNrcMZ3+zFnApiHMU4NlqJMKbqMNqK4p42DAYRSCirfCtLizEU7Z
         RBuEZdQtJWIXC2wY92kHLl7meYHhJr5/brM71+m1Ppjo0sSdbqtKvFbVv2OIsRztcZNb
         MWmg==
X-Forwarded-Encrypted: i=1; AKwUvBwsb3g4kbcignraEjvFH58cs+3IijAiwzwkAGT06mjRfMJyDtXFtZOM8pW69Hy/15Ph3+QQlcQFcYxm3h7tJGOa@vger.kernel.org
X-Gm-Message-State: APuU4Z/FG5GRKeHpGjU87MlEE4JOgtu5MTxq4UQg8jZJ0zYf1boFXCSd
	zeZtfI5qGCkKVaIEG8e2RCc7vV0tUd/EVJzdnhvuFR8bHGQkRoBLQy6w
X-Gm-Gg: AYBFou0YmCNzQp/Q0YsTtbVtKdXmwm9LbllheyGWHOMpQnqbth/77O98PJPUhFPkOt2
	wF4lFFfPhRcRpoZrVi59kospyI9pjYa2RUqXRBJ+qjkjMFJQeBBde6Z1P2ryWnqX01jsQHt8qhP
	KvQAuHuQQ9Ek554aCLBns93SFowmW5zGhBurz34mLuVyJVaJiPLA8ylKQcF84QkemXKivMKZ13E
	TK3rttfILaQ8kHfcqWmTsJ5bC959LKIh6ueLPfJVZCIPd3dD3Olh3iJShRXkye72ZpAH3W11Fl/
	FpkCq5nPks9ks7fNkBl0OLyRqC3StaAdHhh8ZW550g8JafjiZcKEqqDxCVxOdOBLqgfnEa0ECTQ
	laJPnAVlu12v/fFmqfljpN7Z02iGuS6yJx86mtf6HzDHluWGHxWeGRvkXXcxkOd0SLUpQJfcq8C
	+Sf7f76yfVMn8KYO/i16cGsY2PtKEQP8H0j1h2pSN+U8eMpmZyfL7dvW2xf1jumnf6r1Qwh+6lB
	j6DbQ9t/TU/KXp9sz5jloNLY2w8FTRKgdH4eIE5uu3pu8FBwtJppv3av0eHx3O3a90MZbtD3z6n
	8zi7DOgLKran9ClIcQ2M9CZbkWtYsaxTirHXOtsjw41SRLBMPWru1I2tkQQnOdMNb7AO0/isMEX
	JskyZLN38CKN7n4/sWWdG3Oso8DYjc/0=
X-Received: by 2002:a05:690c:1d:b0:8a9:9f40:24b4 with SMTP id 00721157ae682-8b328d12ef3mr3485117b3.15.1793818445964;
        Wed, 04 Nov 2026 10:54:05 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309aa8405sm24581687b3.37.2026.11.04.10.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:54:01 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:53:57 -0500
Subject: [PATCH v4 2/3] perf python: Add alpha-profileme.py
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
Message-Id: <20261104-perf-alpha-profileme-v4-2-1771ea02950e@gmail.com>
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
In-Reply-To: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8517; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=EM7SaWCUzm0g+DOjXsNVlrswtdlis/4RXvVxASC7NyE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe17skspRLRGzr+NxUXPNB9nCHAZfTE9t5hvfsLD4ui
 cl5zHOu4yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK6Zb8zwm9X0Moutok
 t2Ocf2tV/+9ZZIPLt1b8FWWz1RLrO6fr2L2xgZ/gk828jOvUbxnM/m9k1Jk+U4L/x/uJWpsZ/1w
 JfCnzs28AIA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf report shows where Alpha ProfileMe samples land but cannot
aggregate the raw status attached to them.

Add a standalone script, using the perf Python module, that summarizes
it by symbol or, with --pc, by instruction, in the style of DCPI: the
fraction of samples killed on a wrong path, not retired, mispredicted,
taken or stalled, the mean PCTR1 window count, and trap counts by type.
Mispredict and trap types are only counted when I_STAT[TRP] is set
and the instruction was not killed before it was mapped, since they are
stale otherwise. Redirect traps are counted by their
PALcode entry offset in PMPC.

Raw data is only read from cpu PMU events, as a tracepoint's payload can
pass for ProfileMe status. Rows are kept apart by PCTR_CTL[SL1], as a
mean over two things PCTR1 can count means nothing.

On an EV7, sampling a loop whose branch tests random data reports that
branch mispredicted in 21% of its samples, and 0% with sorted data.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/python/alpha-profileme.py | 178 +++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/tools/perf/python/alpha-profileme.py b/tools/perf/python/alpha-profileme.py
new file mode 100755
index 000000000000..da374d206187
--- /dev/null
+++ b/tools/perf/python/alpha-profileme.py
@@ -0,0 +1,178 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Summarize Alpha ProfileMe samples.
+
+Aggregates the ProfileMe status that the Alpha cpu PMU attaches to each
+sample as PERF_SAMPLE_RAW data, by symbol or, with --pc, by instruction.
+
+Record with raw data, e.g.:
+  perf record -R -e cpu/instructions,profileme/ -- ./workload
+A precise event such as instructions:p samples only retired instructions,
+so its killed% and invalid% columns read 0.
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
+TRP, and MIS and the trap type with it, are stale for a killed instruction,
+so mispr%, invalid% and traps ignore them there.
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
+        killed = (ctl >> 26) & 1
+        trp = (i_stat >> 39) & 1 and not killed
+        if killed:
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

