Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB083ACA50
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157503; cv=none; b=sK8HCaOsm0bv2ZOYCXgZom5HQcoU9ydhSRi0IoUiBeRScypLO1LPX+Euu34Ont3NPPS0mKveoiUV2tdJi5Qsyb764Q0ZwTZOp8L2PEDQI7CL6QcabZVkPv5FDtFZC6uvPABBbfQqpFLxRLD1u6Vt6Ufkh8N/dV6t8LZKIjxhaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157503; c=relaxed/simple;
	bh=m4evdrAfFdloOFUinFFaS10MkOUODfOhUsZC1qEcLyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BnAJOGlDxbUk7bQJP9TqZCnTXtJokGFZfgj4dc+C3Ru40VhsOEtbbkgBeaXcuu/MLsq6hvvnYoEAjRlJRXrK4A70r4gGG0CR2P/X0MdEwQ47baPJvc5SgUlvVx+AiATE44aE7rrMt5LMJ1ZDcBmkLAcbgU39IPjAY/ED6SYKiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjfxVGXW; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjfxVGXW"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8de02a4dso15631082c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157501; x=1777762301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tFkKJpx387LQyGkxFesF27g3u3l0azo1BknyR7NysHU=;
        b=fjfxVGXWHv4TvW2Hpazs34WsyvSJz2W6US8l41F1XvNL24bTsvMgT2ZD3pi+yoyC0I
         KjyuDEUe3u9SSDv8k6JSKDD2d53OZKkHzaJJnvVkgfm8cJ0pgRMSzxeF+LRvlkhUNphG
         FiWeUQKWAOBZ7bszUlAFwT8KlxXeUeZjuzxgUNsGybME9yRYicCDA8AqdtArnvEidv/b
         8Jajx37gAvQ/5aUQzbZ850hwBYewvsIoUM28wz3nNSXOmfvxa2uS1yebjtDe5joI+6jy
         nIYZB8VseWidW+D/I+nRUi3dibtVO7K6jdnpro2DxaDLGfJqRUrSfN+ubaAdoD1pY6b8
         KSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157501; x=1777762301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFkKJpx387LQyGkxFesF27g3u3l0azo1BknyR7NysHU=;
        b=lxTbUHkyQ4ALj0UvMwSwL1h4DiW9J8qm9hyOA5vgRlr2mUi8CAZF9kmrSJWJ7P+pC/
         mEdFh/rW6kUgDmH9IsRVWOfK2MTXWvc3GtWB/bOJI8F3yVnxLCBnmoEhiaWlnCNYpK0q
         VtbAYaaTLiSd41htfYEGulJmLEWsGIWK0Z12aYaWsoHf/oAhfbHxV9tYntkVpvhicDLC
         I9kY9vEbkn8oyInSgmL68hrx0h7sx+hiV1VFTXSZx60/EfGz7mXFPplrMkA1DVjMvo95
         ngj83dHCS9qCdFKxEHwDY5YklvCQSv8MrYgYd7epOizrpgjAWPUSM/bTY7SfLllNRLia
         4p/g==
X-Forwarded-Encrypted: i=1; AFNElJ/scmxe5rrmNrcDUr60GuCOfZbfSp8iZxcCm3ZUO9o0uW9VXNSah+1IjKgGCV3zZUPxe4XC84Z1hUSzqzfI3DlS@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJnB2aalwv7gNC6mrxyD8w4Sdsn+AQ/tGJ2kHprKfHKJMR2mt
	9FcVhBlDiBKn4VXBPUBs0g5hm3Cmfzt70Dj7/7HUU9Vc5wahr2LrwZ/UrA2PsfMdTSWXxdD4uu1
	SA3Sq7FOlQQ==
X-Received: from dlbpu10.prod.google.com ([2002:a05:7022:e88a:b0:12b:fba9:5eb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:418e:b0:12c:87f1:f41a
 with SMTP id a92af1059eb24-12c87f1f772mr17623182c88.21.1777157500791; Sat, 25
 Apr 2026 15:51:40 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:34 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-43-irogers@google.com>
Subject: [PATCH v7 42/59] perf powerpc-hcalls: Port powerpc-hcalls to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/.
- Refactored the script to use a class structure (HCallAnalyzer) to
  encapsulate state.
- Used perf.session for event processing.
- Tracked hcall entry and exit to calculate duration and aggregate
  statistics.
- Moved the large hcall_table to a module-level constant HCALL_TABLE.
- Cleaned up Python 2 compatibility artifacts.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/powerpc-hcalls.py | 211 ++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100755 tools/perf/python/powerpc-hcalls.py

diff --git a/tools/perf/python/powerpc-hcalls.py b/tools/perf/python/powerpc-hcalls.py
new file mode 100755
index 000000000000..c4fa539174c9
--- /dev/null
+++ b/tools/perf/python/powerpc-hcalls.py
@@ -0,0 +1,211 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+"""
+Hypervisor call statistics
+
+Copyright (C) 2018 Ravi Bangoria, IBM Corporation
+Ported from tools/perf/scripts/python/powerpc-hcalls.py
+"""
+
+import argparse
+from collections import defaultdict
+import perf
+
+# Hypervisor call table
+HCALL_TABLE = {
+    4: 'H_REMOVE',
+    8: 'H_ENTER',
+    12: 'H_READ',
+    16: 'H_CLEAR_MOD',
+    20: 'H_CLEAR_REF',
+    24: 'H_PROTECT',
+    28: 'H_GET_TCE',
+    32: 'H_PUT_TCE',
+    36: 'H_SET_SPRG0',
+    40: 'H_SET_DABR',
+    44: 'H_PAGE_INIT',
+    48: 'H_SET_ASR',
+    52: 'H_ASR_ON',
+    56: 'H_ASR_OFF',
+    60: 'H_LOGICAL_CI_LOAD',
+    64: 'H_LOGICAL_CI_STORE',
+    68: 'H_LOGICAL_CACHE_LOAD',
+    72: 'H_LOGICAL_CACHE_STORE',
+    76: 'H_LOGICAL_ICBI',
+    80: 'H_LOGICAL_DCBF',
+    84: 'H_GET_TERM_CHAR',
+    88: 'H_PUT_TERM_CHAR',
+    92: 'H_REAL_TO_LOGICAL',
+    96: 'H_HYPERVISOR_DATA',
+    100: 'H_EOI',
+    104: 'H_CPPR',
+    108: 'H_IPI',
+    112: 'H_IPOLL',
+    116: 'H_XIRR',
+    120: 'H_MIGRATE_DMA',
+    124: 'H_PERFMON',
+    220: 'H_REGISTER_VPA',
+    224: 'H_CEDE',
+    228: 'H_CONFER',
+    232: 'H_PROD',
+    236: 'H_GET_PPP',
+    240: 'H_SET_PPP',
+    244: 'H_PURR',
+    248: 'H_PIC',
+    252: 'H_REG_CRQ',
+    256: 'H_FREE_CRQ',
+    260: 'H_VIO_SIGNAL',
+    264: 'H_SEND_CRQ',
+    272: 'H_COPY_RDMA',
+    276: 'H_REGISTER_LOGICAL_LAN',
+    280: 'H_FREE_LOGICAL_LAN',
+    284: 'H_ADD_LOGICAL_LAN_BUFFER',
+    288: 'H_SEND_LOGICAL_LAN',
+    292: 'H_BULK_REMOVE',
+    304: 'H_MULTICAST_CTRL',
+    308: 'H_SET_XDABR',
+    312: 'H_STUFF_TCE',
+    316: 'H_PUT_TCE_INDIRECT',
+    332: 'H_CHANGE_LOGICAL_LAN_MAC',
+    336: 'H_VTERM_PARTNER_INFO',
+    340: 'H_REGISTER_VTERM',
+    344: 'H_FREE_VTERM',
+    348: 'H_RESET_EVENTS',
+    352: 'H_ALLOC_RESOURCE',
+    356: 'H_FREE_RESOURCE',
+    360: 'H_MODIFY_QP',
+    364: 'H_QUERY_QP',
+    368: 'H_REREGISTER_PMR',
+    372: 'H_REGISTER_SMR',
+    376: 'H_QUERY_MR',
+    380: 'H_QUERY_MW',
+    384: 'H_QUERY_HCA',
+    388: 'H_QUERY_PORT',
+    392: 'H_MODIFY_PORT',
+    396: 'H_DEFINE_AQP1',
+    400: 'H_GET_TRACE_BUFFER',
+    404: 'H_DEFINE_AQP0',
+    408: 'H_RESIZE_MR',
+    412: 'H_ATTACH_MCQP',
+    416: 'H_DETACH_MCQP',
+    420: 'H_CREATE_RPT',
+    424: 'H_REMOVE_RPT',
+    428: 'H_REGISTER_RPAGES',
+    432: 'H_DISABLE_AND_GETC',
+    436: 'H_ERROR_DATA',
+    440: 'H_GET_HCA_INFO',
+    444: 'H_GET_PERF_COUNT',
+    448: 'H_MANAGE_TRACE',
+    468: 'H_FREE_LOGICAL_LAN_BUFFER',
+    472: 'H_POLL_PENDING',
+    484: 'H_QUERY_INT_STATE',
+    580: 'H_ILLAN_ATTRIBUTES',
+    592: 'H_MODIFY_HEA_QP',
+    596: 'H_QUERY_HEA_QP',
+    600: 'H_QUERY_HEA',
+    604: 'H_QUERY_HEA_PORT',
+    608: 'H_MODIFY_HEA_PORT',
+    612: 'H_REG_BCMC',
+    616: 'H_DEREG_BCMC',
+    620: 'H_REGISTER_HEA_RPAGES',
+    624: 'H_DISABLE_AND_GET_HEA',
+    628: 'H_GET_HEA_INFO',
+    632: 'H_ALLOC_HEA_RESOURCE',
+    644: 'H_ADD_CONN',
+    648: 'H_DEL_CONN',
+    664: 'H_JOIN',
+    676: 'H_VASI_STATE',
+    688: 'H_ENABLE_CRQ',
+    696: 'H_GET_EM_PARMS',
+    720: 'H_SET_MPP',
+    724: 'H_GET_MPP',
+    748: 'H_HOME_NODE_ASSOCIATIVITY',
+    756: 'H_BEST_ENERGY',
+    764: 'H_XIRR_X',
+    768: 'H_RANDOM',
+    772: 'H_COP',
+    788: 'H_GET_MPP_X',
+    796: 'H_SET_MODE',
+    61440: 'H_RTAS',
+}
+
+
+class HCallAnalyzer:
+    """Analyzes hypervisor calls and aggregates statistics."""
+
+    def __init__(self):
+        # output: {opcode: {'min': min, 'max': max, 'time': time, 'cnt': cnt}}
+        self.output = defaultdict(lambda: {'time': 0, 'cnt': 0, 'min': float('inf'), 'max': 0})
+        # d_enter: {pid: (opcode, nsec)}
+        self.d_enter: dict[int, tuple[int, int]] = {}
+        self.print_ptrn = '%-28s%10s%10s%10s%10s'
+
+    def hcall_table_lookup(self, opcode: int) -> str:
+        """Lookup hcall name by opcode."""
+        return HCALL_TABLE.get(opcode, str(opcode))
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process a single sample event."""
+        name = str(sample.evsel)
+        pid = sample.sample_pid
+        time = sample.time
+        opcode = getattr(sample, "opcode", -1)
+
+        if opcode == -1:
+            return
+
+        if name == "evsel(powerpc:hcall_entry)":
+            self.d_enter[pid] = (opcode, time)
+        elif name == "evsel(powerpc:hcall_exit)":
+            if pid in self.d_enter:
+                opcode_entry, time_entry = self.d_enter[pid]
+                if opcode_entry == opcode:
+                    diff = time - time_entry
+                    del self.d_enter[pid]
+
+                    stats = self.output[opcode]
+                    stats['time'] += diff
+                    stats['cnt'] += 1
+                    if diff < stats['min']:
+                        stats['min'] = diff
+                    if diff > stats['max']:
+                        stats['max'] = diff
+
+    def print_summary(self) -> None:
+        """Print aggregated statistics."""
+        print(self.print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
+        print('-' * 68)
+        for opcode in sorted(self.output.keys()):
+            h_name = self.hcall_table_lookup(opcode)
+            stats = self.output[opcode]
+            time = stats['time']
+            cnt = stats['cnt']
+            min_t = stats['min']
+            max_t = stats['max']
+
+            # Avoid float representation for large integers if possible,
+            # or use formatted strings. Legacy used time//cnt.
+            avg_t = time // cnt if cnt > 0 else 0
+
+            # If min was not updated, it remains inf, but cnt should be > 0 if in output
+            if min_t == float('inf'):
+                min_t = 0
+
+            print(self.print_ptrn % (h_name, cnt, int(min_t), int(max_t), avg_t))
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Hypervisor call statistics")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    analyzer = HCallAnalyzer()
+
+    try:
+        session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+        session.process_events()
+        analyzer.print_summary()
+    except KeyboardInterrupt:
+        analyzer.print_summary()
+    except Exception as e:
+        print(f"Error processing events: {e}")
-- 
2.54.0.545.g6539524ca2-goog

