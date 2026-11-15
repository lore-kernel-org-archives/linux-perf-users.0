Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703168;
	b=rdv6JJ6OoDs201jZY2m8cTedIVERasdf4JP81CRZ9/fQ4ce9ZHeJZ3mx1aKlMMatl8H/
	 ZSGA4FLs5yTVG3p6kmPAoFWCNmupHO3hqd4KiC1K6mNpXBX/K7mjrPEszVTiBWlEF0tOu
	 6wqKjOYjC4sScdS9TVg+GQKi+6GoBgFCtf0o8Sugim25Bj//N3Y7Mh23CDd7kwQr9dMqU
	 EiGTe2WsS08nQOXu3vgjhgdHcfkvrpuzdgOv6tnmO9lFeRu+847c+nENkf0BiTMVEBB1D
	 4yj0M9HEkpHHmcsEl4hIp1Y2V726MA2wmqt73y2Scd7th24/EowIl+xv9ffxMd1i7HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vkh9Qcnvd2+Wy0yqcxo4GZOIZmHPFgQnQw+LiX9oMsU=;
	b=ngQRvfp8GHmVBdPg03jxo+/cVUwhtCBUWD4MZFe/h2sVXgVz+Q1ReHfV75IWsY4/WgDT
	 YesCqztyJ3plT1KKb4NeA7CjdV4oCTIxOvbcMQKYo7qzpq2pV1lTe22jqF3zbGng8+zsu
	 Tu6Q0OSpqPRwoEwvP0JLHttvKtz29ypV2viDaLLtNvF16g09Msm8zKBP+MSlQ+JBh05We
	 RNBpQtEk/RKc8SHcceXiyxybbbPovPI1vpVRCIkNhdhldcGGKvwbQ/zEnQ+MPS0RHTtpb
	 0I0KfRp02XlDyqiu625uHaKdMCCTj3GVjkbt2GmsdBKiH0af5tghlA7lG/CMoFSCbwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wAVBCeK9;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C3606A899
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F2C3606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wAVBCeK9
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-677bc4704cbso2319339d50.0
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703167; x=1795307967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkh9Qcnvd2+Wy0yqcxo4GZOIZmHPFgQnQw+LiX9oMsU=;
        b=wAVBCeK9ikq5GjYbHsSDptg+7XOwbMAXgKgFFzNMlOVJI+AZoGWS/lyca49nffH/Jz
         Y9RQhnqMQWwPR4Onrs1Yp4WtjoJY9uLQHy8nxfQOCG5uaoaPv3C7/tmnS24CddKnxn8b
         v4I3S2OfoOBnuYdrgvfPVc3FUPSssU8CH51ura9LD5Jsv7Vee+RaN9qdpb0QzZ73UQx6
         q1GsMr96L0mPBgr/3Gjgz807D5RDszWo1+danhcZk5ZAujJAuiXZ+tyWbdMQbbXPSmwb
         XT70y2Fh7kH6mvZwkD0e5DTQa3BRq1WOnFOyIB34Kypo8x7s25Ha8kLIXfY19XTMXi+P
         jqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703167; x=1795307967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vkh9Qcnvd2+Wy0yqcxo4GZOIZmHPFgQnQw+LiX9oMsU=;
        b=fP6gUWttQSICLBnF8XROBltKJrlZCsc8xB+2+/S/WRr045bD5/wAYsyvk6G46icAJG
         nn5pw6xx2mOvkf4V/jZZTuqBgHbjISB8fv8yeAs9BKwXtTbwRrPVekUXyUs5HJS6SmKL
         jeneMd6r7ZWszJCHWKDETH42M76Kq8ZcAGmTnUHuIwj1llvXkG4BM69vOCqN7P2/GeYx
         m8F45OmqkqW+GNsvSVRfhkPKTpREvK8NLzhDqSE717kN/DzUMWw13k9TlzP2SQ5NBSoA
         MXev9/+C9xc1j4IItRsFdlmmb3gbOWe9dVf0pJnManznNiqPNtthk7My/8D3m1UpPsWQ
         OmoQ==
X-Forwarded-Encrypted: i=1; AL+hErF3FUskpgqh7fwP+A5UhEtjVM7z2HSwMqk4mOUHcO9rAm3FRltre8h5zzRXumdc6HHjn3Fe40fTfDPBTBOpX3Zn@vger.kernel.org
X-Gm-Message-State: APuU4Z/5EUNlzo2Il24P1m1NP6cp0H+L9ErkxxIOGX08bKAokjSMNIe/
	qDtcCRvnrn1mJV5K9dWWgTmDfpd3/UAGkBXWE0OiFuv6mAPp9XwFxp1pU1hhd8wwIbI=
X-Gm-Gg: AYBFou1EuP2grTFwI4ymEiUm75QIGUazffw55QbadWx7DySnoZtB3bTfjtDfYqM3uFY
	AIv2TqD5h2AzpIUd/YvFAWmml3VrPV8TVeb2vnfNNi/z2m5DH8SMrCvtJub1a1PoNDvoTi0v6Us
	vdjSeF9OKPN5pwTtx6UtQJOHUpZlFn0ouVr6lnT2OIq2ScJy7cQqud/rWIOtdTLyj0l5cCVCZvB
	P/e+XNM25cH/564CJUpoHXprQehVTYLcWT5oAI4vxTo/NuEDupfAik6eVNOwyliA1xvsuHMyoJl
	Du1qJ+w/ow29zgmjzqAlgZEOFAdHjXQZJX08rzvuFPr05oK+N3GWctRgTHc/WPWiFEudhuWWuMe
	zBE7NK+Qyh8/hnQIRlobv21O0hmdld4g2eRZdd/ib8pghqwEVjhZ2YW6wXLV4me4xcky+zD9KQX
	1P/kfoGO7GdujTxoEDklCfKzVvIAwpq8uK7vnKtnGaA8kRImn8BnnrQN7Kf06WuEEHFLo6TcN6p
	E5x+7bCuOBwI7BStvOse5SlyEfjkfQl1op6ClVU37ZUf0PDi6PM0IumkcZ947p9MuHBJm4uGes9
	UbVXcFCWO+a2hTKQrVbrTwKauHALQJZgeeyTPLImqJ+x2KKBLLp87s1U
X-Received: by 2002:a53:ac8e:0:b0:675:617e:6c2b with SMTP id 956f58d0204a3-67d896b224cmr2964635d50.77.1794703167029;
        Sat, 14 Nov 2026 16:39:27 -0800 (PST)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm189602d50.19.2026.11.14.16.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:39:26 -0800 (PST)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: adrian.hunter@intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH 3/4] perf python: Add perfetto script to open profiles in the Perfetto UI
Date: Sun, 15 Nov 2026 00:39:15 +0000
Message-ID: <20261115003916.1873857-4-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115003916.1873857-1-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a script that converts the samples in a perf.data file to a
Perfetto trace and opens it in the Perfetto UI (https://ui.perfetto.dev):

  $ perf record -g -- ./workload
  $ perf script perfetto
  Wrote 4496 samples to perf.pftrace

Unlike a flame graph, the trace keeps the time of every sample, so the
UI can show what each thread was running over time, as well as flame
graphs for any time range, thread or process.

Samples are written as StackSample packets [1], one stream per perf
event. Each sample has:
 - the pid, tid and comm of the thread
 - the cpu, if recorded, and user or kernel mode
 - the callchain (symbol, DSO and kernel/user for each frame), or just
   the sampled symbol if there is no callchain
 - the period as its weight

Timestamps use the clock from perf record -k if one was given, and the
perf clock otherwise.

The few protobuf messages needed are encoded by hand, so the script
doesn't depend on the protobuf package. Strings, frames and callstacks
are interned as samples are read, so only the interning tables stay in
memory.

The UI can only fetch traces from http://127.0.0.1:9001, so the script
serves the trace there, only to the UI, until it has been fetched.
-n/--no-open just writes the file.

Also add a shell test that converts a recording of the noploop
workload and checks the sample count and the strings in the trace.

[1] https://github.com/google/perfetto/blob/main/protos/perfetto/trace/profiling/stack_sample.proto

Assisted-by: LLM
Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
---
 tools/perf/python/perfetto.py             | 625 ++++++++++++++++++++++
 tools/perf/tests/shell/script_perfetto.sh |  72 +++
 2 files changed, 697 insertions(+)
 create mode 100755 tools/perf/python/perfetto.py
 create mode 100755 tools/perf/tests/shell/script_perfetto.sh

diff --git a/tools/perf/python/perfetto.py b/tools/perf/python/perfetto.py
new file mode 100755
index 000000000000..e168b146e538
--- /dev/null
+++ b/tools/perf/python/perfetto.py
@@ -0,0 +1,625 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""perfetto.py - Convert perf.data samples to a Perfetto trace and open it in the Perfetto UI
+
+Samples are written as Perfetto StackSample packets, a stable trace format for
+callstack samples from any profiler:
+https://github.com/google/perfetto/blob/main/protos/perfetto/trace/profiling/stack_sample.proto
+
+The protobuf wire format is simple enough that the few messages needed are
+encoded by hand below, which avoids a dependency on the protobuf package and
+generated bindings. The field numbers in this file are taken from the .proto
+files under protos/perfetto/trace/ in the Perfetto repository and are stable.
+"""
+from __future__ import annotations
+
+import argparse
+import http
+import http.server
+import os
+import sys
+import time
+import urllib.parse
+import webbrowser
+from collections.abc import Hashable
+from dataclasses import dataclass, field
+from enum import IntEnum
+from typing import BinaryIO, Dict, Optional, Tuple
+
+import perf
+
+# The only port that the Content Security Policy of ui.perfetto.dev allows
+# fetching traces from.
+UI_FETCH_PORT = 9001
+
+# perf reports these when the sample type lacks PERF_SAMPLE_CPU/TID/TIME.
+NO_CPU = 0xffffffff
+NO_ID = 0xffffffff
+NO_TIME = 0xffffffffffffffff
+
+# Values of the enums in the Perfetto protos used below.
+
+
+class BuiltinClock(IntEnum):
+    """perfetto.protos.BuiltinClock."""
+    REALTIME = 1
+    MONOTONIC = 3
+    MONOTONIC_RAW = 5
+    BOOTTIME = 6
+    PERF = 10
+
+
+class SequenceFlags(IntEnum):
+    """perfetto.protos.TracePacket.SequenceFlags."""
+    SEQ_INCREMENTAL_STATE_CLEARED = 1
+    SEQ_NEEDS_INCREMENTAL_STATE = 2
+
+
+class FrameKind(IntEnum):
+    """perfetto.protos.Frame.Kind."""
+    KIND_NATIVE = 1
+    KIND_KERNEL = 2
+
+
+class StackSampleMode(IntEnum):
+    """perfetto.protos.StackSample.Mode."""
+    MODE_USER = 1
+    MODE_KERNEL = 2
+
+
+class StackSampleUnit(IntEnum):
+    """perfetto.protos.StackSample.Unit."""
+    UNIT_NANOSECONDS = 1
+    UNIT_CPU_CYCLES = 2
+    UNIT_INSTRUCTIONS = 3
+    UNIT_PAGE_FAULTS = 5
+    UNIT_CACHE_MISSES = 6
+    UNIT_CACHE_REFERENCES = 7
+    UNIT_BRANCH_MISSES = 8
+    UNIT_COUNT = 9
+
+
+# Field numbers of the messages in the Perfetto protos used below.
+
+
+class TraceField(IntEnum):
+    """perfetto.protos.Trace."""
+    PACKET = 1
+
+
+class TracePacketField(IntEnum):
+    """perfetto.protos.TracePacket."""
+    PROCESS_TREE = 2
+    CLOCK_SNAPSHOT = 6
+    TIMESTAMP = 8
+    TRUSTED_PACKET_SEQUENCE_ID = 10
+    INTERNED_DATA = 12
+    SEQUENCE_FLAGS = 13
+    TIMESTAMP_CLOCK_ID = 58
+    TRACE_PACKET_DEFAULTS = 59
+    STACK_SAMPLE = 135
+
+
+class TracePacketDefaultsField(IntEnum):
+    """perfetto.protos.TracePacketDefaults."""
+    TIMESTAMP_CLOCK_ID = 58
+    STACK_SAMPLE_DEFAULTS = 100
+
+
+class ClockSnapshotField(IntEnum):
+    """perfetto.protos.ClockSnapshot."""
+    CLOCKS = 1
+    PRIMARY_TRACE_CLOCK = 2
+
+
+class ClockField(IntEnum):
+    """perfetto.protos.ClockSnapshot.Clock."""
+    CLOCK_ID = 1
+    TIMESTAMP = 2
+
+
+class InternedDataField(IntEnum):
+    """perfetto.protos.InternedData."""
+    FUNCTION_NAMES = 5
+    FRAMES = 6
+    CALLSTACKS = 7
+    MAPPING_PATHS = 17
+    MAPPINGS = 19
+    STACK_SAMPLE_TASK_CONTEXTS = 48
+    STACK_SAMPLE_EXECUTION_CONTEXTS = 49
+
+
+class InternedStringField(IntEnum):
+    """perfetto.protos.InternedString."""
+    IID = 1
+    STR = 2
+
+
+class MappingField(IntEnum):
+    """perfetto.protos.Mapping."""
+    IID = 1
+    PATH_STRING_IDS = 7
+
+
+class FrameField(IntEnum):
+    """perfetto.protos.Frame."""
+    IID = 1
+    FUNCTION_NAME_ID = 2
+    MAPPING_ID = 3
+    KIND = 7
+
+
+class CallstackField(IntEnum):
+    """perfetto.protos.Callstack."""
+    IID = 1
+    FRAME_IDS = 2
+
+
+class TaskContextField(IntEnum):
+    """perfetto.protos.StackSample.TaskContext."""
+    IID = 1
+    PID = 2
+    TID = 3
+
+
+class ExecutionContextField(IntEnum):
+    """perfetto.protos.StackSample.ExecutionContext."""
+    IID = 1
+    CPU = 2
+    MODE = 3
+
+
+class StackSampleField(IntEnum):
+    """perfetto.protos.StackSample."""
+    TASK_CONTEXT_IID = 2
+    EXECUTION_CONTEXT_IID = 4
+    CALLSTACK_IID = 6
+    PRIMARY_WEIGHT = 11
+
+
+class StackSampleDefaultsField(IntEnum):
+    """perfetto.protos.StackSampleDefaults."""
+    SOURCE = 1
+    PRIMARY_DESCRIPTOR = 2
+
+
+class CounterDescriptorField(IntEnum):
+    """perfetto.protos.StackSample.CounterDescriptor."""
+    NAME = 2
+    UNIT = 3
+
+
+class ProcessTreeField(IntEnum):
+    """perfetto.protos.ProcessTree."""
+    PROCESSES = 1
+    THREADS = 2
+
+
+class ProcessField(IntEnum):
+    """perfetto.protos.ProcessTree.Process."""
+    PID = 1
+    CMDLINE = 3
+    CMDLINE_IS_COMM = 9
+
+
+class ThreadField(IntEnum):
+    """perfetto.protos.ProcessTree.Thread."""
+    TID = 1
+    NAME = 2
+    TGID = 3
+
+
+# The BuiltinClock of the clockids that perf record -k accepts.
+CLOCKID_TO_BUILTIN_CLOCK = {
+    time.CLOCK_REALTIME: BuiltinClock.REALTIME,
+    time.CLOCK_MONOTONIC: BuiltinClock.MONOTONIC,
+    time.CLOCK_MONOTONIC_RAW: BuiltinClock.MONOTONIC_RAW,
+    time.CLOCK_BOOTTIME: BuiltinClock.BOOTTIME,
+}
+
+# The unit of the sample period of perf events. The period of events that are
+# not listed is a plain count of the event.
+EVENT_UNITS = {
+    'cpu-clock': StackSampleUnit.UNIT_NANOSECONDS,
+    'task-clock': StackSampleUnit.UNIT_NANOSECONDS,
+    'cycles': StackSampleUnit.UNIT_CPU_CYCLES,
+    'cpu-cycles': StackSampleUnit.UNIT_CPU_CYCLES,
+    'instructions': StackSampleUnit.UNIT_INSTRUCTIONS,
+    'page-faults': StackSampleUnit.UNIT_PAGE_FAULTS,
+    'faults': StackSampleUnit.UNIT_PAGE_FAULTS,
+    'cache-misses': StackSampleUnit.UNIT_CACHE_MISSES,
+    'cache-references': StackSampleUnit.UNIT_CACHE_REFERENCES,
+    'branch-misses': StackSampleUnit.UNIT_BRANCH_MISSES,
+}
+
+
+class WireType(IntEnum):
+    """The protobuf wire types used below."""
+    VARINT = 0
+    LEN = 2
+
+
+# A field's tag is its number shifted above the wire type bits.
+WIRE_TYPE_BITS = 3
+
+# A varint stores 7 bits per byte, with the top bit set on all but the last.
+VARINT_PAYLOAD_BITS = 7
+VARINT_PAYLOAD_MASK = (1 << VARINT_PAYLOAD_BITS) - 1
+VARINT_CONTINUATION = 1 << VARINT_PAYLOAD_BITS
+
+
+def varint(value: int) -> bytes:
+    """Encodes a non-negative integer as a protobuf varint."""
+    out = bytearray()
+    while value > VARINT_PAYLOAD_MASK:
+        out.append((value & VARINT_PAYLOAD_MASK) | VARINT_CONTINUATION)
+        value >>= VARINT_PAYLOAD_BITS
+    out.append(value)
+    return bytes(out)
+
+
+def tag(field_id: int, wire_type: WireType) -> bytes:
+    """Encodes the tag that starts a protobuf field."""
+    return varint((field_id << WIRE_TYPE_BITS) | wire_type)
+
+
+def varint_field(field_id: int, value: int) -> bytes:
+    """Encodes a protobuf field with the varint wire type."""
+    return tag(field_id, WireType.VARINT) + varint(value)
+
+
+def bytes_field(field_id: int, value: bytes) -> bytes:
+    """Encodes a protobuf field with the length-delimited wire type.
+
+    This is the encoding of strings, bytes and nested messages.
+    """
+    return tag(field_id, WireType.LEN) + varint(len(value)) + value
+
+
+def string_field(field_id: int, value: str) -> bytes:
+    """Encodes a protobuf string field."""
+    return bytes_field(field_id, value.encode('utf-8', errors='replace'))
+
+
+def event_unit(event: str) -> int:
+    """Returns the StackSample.Unit of the sample period of a perf event."""
+    # Reduce names such as "cpu_core/cycles/ppp" and "cycles:u" to "cycles".
+    parts = event.split('/')
+    name = parts[1] if len(parts) == 3 else event
+    return EVENT_UNITS.get(name.split(':')[0], StackSampleUnit.UNIT_COUNT)
+
+
+@dataclass
+class Sequence:
+    """The interning state of a Perfetto packet sequence.
+
+    There is one sequence per perf event so that each is its own stream of
+    samples in Perfetto. Messages that repeat between samples are written once
+    in the InternedData of the first packet that needs them and are referred to
+    by their interning id (iid) afterwards.
+    """
+    seq_id: int
+    # The iids of the interned messages of each InternedData field.
+    iids: Dict[int, Dict[Hashable, int]] = field(default_factory=dict)
+    # InternedData that no packet has carried yet.
+    pending: bytearray = field(default_factory=bytearray)
+
+    def _intern(self, field_id: int, key: Hashable) -> Tuple[int, bool]:
+        """Returns the iid of key in an InternedData field and if it is new."""
+        table = self.iids.setdefault(field_id, {})
+        iid = table.get(key)
+        if iid is not None:
+            return iid, False
+        iid = len(table) + 1
+        table[key] = iid
+        return iid, True
+
+    def _add(self, field_id: int, message: bytes) -> None:
+        """Queues an interned message for the next packet."""
+        self.pending += bytes_field(field_id, message)
+
+    def _string(self, field_id: int, value: str) -> int:
+        """Interns an InternedString."""
+        iid, new = self._intern(field_id, value)
+        if new:
+            self._add(field_id, varint_field(InternedStringField.IID, iid) +
+                      string_field(InternedStringField.STR, value))
+        return iid
+
+    def _mapping(self, dso: str, kernel: Optional[bool]) -> int:
+        """Interns a Mapping, the Perfetto equivalent of a DSO."""
+        # Perfetto knows the kernel image by the path "/kernel".
+        path = 'kernel' if kernel and dso == '[kernel.kallsyms]' else dso
+        iid, new = self._intern(InternedDataField.MAPPINGS, path)
+        if new:
+            path_iid = self._string(InternedDataField.MAPPING_PATHS, path)
+            self._add(InternedDataField.MAPPINGS,
+                      varint_field(MappingField.IID, iid) +
+                      varint_field(MappingField.PATH_STRING_IDS, path_iid))
+        return iid
+
+    def frame(self, symbol: str, dso: str, kernel: Optional[bool]) -> int:
+        """Interns a Frame. kernel is None if it is not known."""
+        iid, new = self._intern(InternedDataField.FRAMES, (symbol, dso, kernel))
+        if new:
+            name_iid = self._string(InternedDataField.FUNCTION_NAMES, symbol)
+            frame = (varint_field(FrameField.IID, iid) +
+                     varint_field(FrameField.FUNCTION_NAME_ID, name_iid) +
+                     varint_field(FrameField.MAPPING_ID, self._mapping(dso, kernel)))
+            if kernel is not None:
+                kind = FrameKind.KIND_KERNEL if kernel else FrameKind.KIND_NATIVE
+                frame += varint_field(FrameField.KIND, kind)
+            self._add(InternedDataField.FRAMES, frame)
+        return iid
+
+    def callstack(self, frame_iids: Tuple[int, ...]) -> int:
+        """Interns a Callstack of Frame iids, outermost frame first."""
+        iid, new = self._intern(InternedDataField.CALLSTACKS, frame_iids)
+        if new:
+            callstack = varint_field(CallstackField.IID, iid) + b''.join(
+                varint_field(CallstackField.FRAME_IDS, frame_iid) for frame_iid in frame_iids)
+            self._add(InternedDataField.CALLSTACKS, callstack)
+        return iid
+
+    def task(self, pid: int, tid: int) -> int:
+        """Interns a StackSample.TaskContext."""
+        iid, new = self._intern(InternedDataField.STACK_SAMPLE_TASK_CONTEXTS, (pid, tid))
+        if new:
+            self._add(InternedDataField.STACK_SAMPLE_TASK_CONTEXTS,
+                      varint_field(TaskContextField.IID, iid) +
+                      varint_field(TaskContextField.PID, pid) +
+                      varint_field(TaskContextField.TID, tid))
+        return iid
+
+    def exec(self, cpu: Optional[int], mode: Optional[StackSampleMode]) -> int:
+        """Interns a StackSample.ExecutionContext."""
+        field_id = InternedDataField.STACK_SAMPLE_EXECUTION_CONTEXTS
+        iid, new = self._intern(field_id, (cpu, mode))
+        if new:
+            context = varint_field(ExecutionContextField.IID, iid)
+            if cpu is not None:
+                context += varint_field(ExecutionContextField.CPU, cpu)
+            if mode is not None:
+                context += varint_field(ExecutionContextField.MODE, mode)
+            self._add(field_id, context)
+        return iid
+
+
+class PerfettoWriter:
+    """Writes perf samples to a Perfetto trace file."""
+
+    def __init__(self, out: BinaryIO) -> None:
+        self.out = out
+        self.session: Optional[perf.session] = None
+        self.sequences: Dict[str, Sequence] = {}
+        # The pid and comm of each tid. Processes are the entries with tid == pid.
+        self.threads: Dict[int, Tuple[int, str]] = {}
+        # The BuiltinClock of sample times and the time of the first sample.
+        self.clock: Optional[Tuple[int, int]] = None
+        self.nr_samples = 0
+        self.nr_skipped = 0
+
+    def _write_packet(self, packet: bytes) -> None:
+        """Writes a TracePacket. A trace is a stream of Trace.packet fields."""
+        self.out.write(bytes_field(TraceField.PACKET, packet))
+
+    def _write_clock(self, first_time: int) -> Tuple[int, int]:
+        """Declares the clock of sample times as the clock of the trace."""
+        assert self.session is not None
+        clockid = self.session.clockid
+        clock = BuiltinClock.PERF
+        if clockid is not None:
+            clock = CLOCKID_TO_BUILTIN_CLOCK.get(clockid, BuiltinClock.PERF)
+        # Perfetto drops packets that are in a clock that no ClockSnapshot
+        # relates to the trace clock, so make the sample clock the trace clock.
+        snapshot = (bytes_field(ClockSnapshotField.CLOCKS,
+                                varint_field(ClockField.CLOCK_ID, clock) +
+                                varint_field(ClockField.TIMESTAMP, first_time)) +
+                    varint_field(ClockSnapshotField.PRIMARY_TRACE_CLOCK, clock))
+        self._write_packet(bytes_field(TracePacketField.CLOCK_SNAPSHOT, snapshot))
+        return clock, first_time
+
+    def _sequence(self, event: str, first_time: int) -> Sequence:
+        """Returns the sequence of a perf event, starting it if it is new."""
+        seq = self.sequences.get(event)
+        if seq is None:
+            seq = Sequence(seq_id=len(self.sequences) + 1)
+            self.sequences[event] = seq
+            if self.clock is None:
+                self.clock = self._write_clock(first_time)
+            descriptor = (string_field(CounterDescriptorField.NAME, event) +
+                          varint_field(CounterDescriptorField.UNIT, event_unit(event)))
+            sample_defaults = (
+                string_field(StackSampleDefaultsField.SOURCE, 'linux.perf') +
+                bytes_field(StackSampleDefaultsField.PRIMARY_DESCRIPTOR, descriptor))
+            defaults = (
+                varint_field(TracePacketDefaultsField.TIMESTAMP_CLOCK_ID, self.clock[0]) +
+                bytes_field(TracePacketDefaultsField.STACK_SAMPLE_DEFAULTS, sample_defaults))
+            self._write_packet(
+                varint_field(TracePacketField.TRUSTED_PACKET_SEQUENCE_ID, seq.seq_id) +
+                varint_field(TracePacketField.SEQUENCE_FLAGS,
+                             SequenceFlags.SEQ_INCREMENTAL_STATE_CLEARED) +
+                bytes_field(TracePacketField.TRACE_PACKET_DEFAULTS, defaults))
+        return seq
+
+    def _update_names(self, pid: int, tid: int) -> None:
+        """Records the current comm of the sampled thread and its process."""
+        assert self.session is not None
+        for task in (tid, pid) if pid not in self.threads else (tid,):
+            thread = self.session.find_thread(pid, task)
+            comm = thread.comm() if thread is not None else None
+            if comm is not None:
+                self.threads[task] = (pid, comm)
+
+    def process_sample(self, sample: perf.sample_event) -> None:
+        """Writes a perf sample as a StackSample packet."""
+        if sample.sample_time == NO_TIME:
+            self.nr_skipped += 1
+            return
+        self.nr_samples += 1
+        event = str(sample.evsel)
+        if event.startswith('evsel(') and event.endswith(')'):
+            event = event[len('evsel('):-1]
+        seq = self._sequence(event, sample.sample_time)
+
+        stack_sample = b''
+        pid, tid = sample.sample_pid, sample.sample_tid
+        if NO_ID not in (pid, tid):
+            self._update_names(pid, tid)
+            stack_sample += varint_field(StackSampleField.TASK_CONTEXT_IID, seq.task(pid, tid))
+
+        # perf callchains are innermost frame first, Perfetto's are the reverse.
+        leaf_kernel: Optional[bool] = None
+        callchain = sample.callchain
+        if callchain is not None and len(callchain) > 0:
+            leaf_kernel = callchain[0].kernel
+            frames = tuple(
+                seq.frame(node.symbol or '[unknown]', node.dso or '[unknown]', node.kernel)
+                for node in reversed([callchain[i] for i in range(len(callchain))]))
+        else:
+            frames = (seq.frame(sample.symbol or '[unknown]',
+                                sample.dso or '[unknown]', None),)
+
+        cpu = sample.sample_cpu if sample.sample_cpu != NO_CPU else None
+        mode: Optional[StackSampleMode] = None
+        if leaf_kernel is not None:
+            mode = StackSampleMode.MODE_KERNEL if leaf_kernel else StackSampleMode.MODE_USER
+        if cpu is not None or mode is not None:
+            stack_sample += varint_field(StackSampleField.EXECUTION_CONTEXT_IID,
+                                         seq.exec(cpu, mode))
+
+        stack_sample += varint_field(StackSampleField.CALLSTACK_IID, seq.callstack(frames))
+        stack_sample += varint_field(StackSampleField.PRIMARY_WEIGHT, sample.sample_period)
+
+        packet = (varint_field(TracePacketField.TIMESTAMP, sample.sample_time) +
+                  varint_field(TracePacketField.TRUSTED_PACKET_SEQUENCE_ID, seq.seq_id))
+        if seq.pending:
+            packet += bytes_field(TracePacketField.INTERNED_DATA, bytes(seq.pending))
+            seq.pending.clear()
+        packet += varint_field(TracePacketField.SEQUENCE_FLAGS,
+                               SequenceFlags.SEQ_NEEDS_INCREMENTAL_STATE)
+        packet += bytes_field(TracePacketField.STACK_SAMPLE, stack_sample)
+        self._write_packet(packet)
+
+    def finish(self) -> None:
+        """Writes the names of all sampled processes and threads."""
+        if self.clock is None:
+            return
+        tree = b''
+        for tid, (pid, comm) in self.threads.items():
+            if tid == pid:
+                tree += bytes_field(ProcessTreeField.PROCESSES,
+                                    varint_field(ProcessField.PID, pid) +
+                                    string_field(ProcessField.CMDLINE, comm) +
+                                    varint_field(ProcessField.CMDLINE_IS_COMM, True))
+            tree += bytes_field(ProcessTreeField.THREADS,
+                                varint_field(ThreadField.TID, tid) +
+                                string_field(ThreadField.NAME, comm) +
+                                varint_field(ThreadField.TGID, pid))
+        # The names apply to the whole trace, so timestamp them with its start.
+        clock, first_time = self.clock
+        self._write_packet(bytes_field(TracePacketField.PROCESS_TREE, tree) +
+                           varint_field(TracePacketField.TIMESTAMP, first_time) +
+                           varint_field(TracePacketField.TIMESTAMP_CLOCK_ID, clock))
+
+
+def convert(input_path: str, output_path: str) -> PerfettoWriter:
+    """Converts a perf.data file to a Perfetto trace file."""
+    with open(output_path, 'wb') as out:
+        writer = PerfettoWriter(out)
+        session = perf.session(perf.data(input_path), sample=writer.process_sample)
+        writer.session = session
+        try:
+            session.process_events()
+            writer.finish()
+        finally:
+            # Break the reference cycle through the bound method callback.
+            writer.session = None
+    return writer
+
+
+class TraceServer(http.server.HTTPServer):
+    """A HTTP server that serves a single trace file to the Perfetto UI."""
+
+    def __init__(self, trace_path: str, origin: str) -> None:
+        super().__init__(('127.0.0.1', UI_FETCH_PORT), TraceRequestHandler)
+        self.trace_path = trace_path
+        self.trace_url_path = '/' + urllib.parse.quote(os.path.basename(trace_path))
+        self.origin = origin
+        self.served = False
+
+
+class TraceRequestHandler(http.server.BaseHTTPRequestHandler):
+    """Serves the trace of a TraceServer and nothing else."""
+    server: TraceServer
+
+    def do_GET(self) -> None:  # pylint: disable=invalid-name
+        """Serves the trace file if that is what was requested."""
+        if self.path != self.server.trace_url_path:
+            self.send_error(http.HTTPStatus.NOT_FOUND)
+            return
+        with open(self.server.trace_path, 'rb') as trace:
+            data = trace.read()
+        self.send_response(http.HTTPStatus.OK)
+        self.send_header('Content-Type', 'application/octet-stream')
+        self.send_header('Content-Length', str(len(data)))
+        self.send_header('Access-Control-Allow-Origin', self.server.origin)
+        self.send_header('Cache-Control', 'no-cache')
+        self.end_headers()
+        self.wfile.write(data)
+        self.server.served = True
+
+    def log_message(self, format: str, *args: object) -> None:  # pylint: disable=redefined-builtin
+        """Silences the per request logging of the base class."""
+
+
+def open_in_ui(trace_path: str, origin: str) -> None:
+    """Serves the trace on localhost until the Perfetto UI has fetched it."""
+    TraceServer.allow_reuse_address = True
+    with TraceServer(trace_path, origin) as server:
+        trace_url = f'http://127.0.0.1:{UI_FETCH_PORT}{server.trace_url_path}'
+        url = f'{origin}/#!/?url={urllib.parse.quote(trace_url, safe="")}'
+        if not webbrowser.open(url):
+            print('No web browser found. If this machine is remote, forward the port with\n'
+                  f'  ssh -L {UI_FETCH_PORT}:127.0.0.1:{UI_FETCH_PORT} <this machine>')
+        print(f'Waiting for the Perfetto UI to fetch the trace, open:\n  {url}')
+        while not server.served:
+            server.handle_request()
+
+
+def main() -> int:
+    """Converts perf.data to a Perfetto trace and opens it in the Perfetto UI."""
+    parser = argparse.ArgumentParser(
+        description='Convert perf.data to a Perfetto trace and open it in the Perfetto UI')
+    parser.add_argument('-i', '--input', default='perf.data',
+                        help='perf.data file to read (default: perf.data)')
+    parser.add_argument('-o', '--output', default='perf.pftrace',
+                        help='Perfetto trace file to write (default: perf.pftrace)')
+    parser.add_argument('-n', '--no-open', action='store_true',
+                        help='only write the trace, do not open it in the Perfetto UI')
+    parser.add_argument('--origin', default='https://ui.perfetto.dev',
+                        help='Perfetto UI to open the trace in (default: https://ui.perfetto.dev)')
+    args = parser.parse_args()
+
+    try:
+        writer = convert(args.input, args.output)
+    except (OSError, TypeError, ValueError) as err:
+        # The perf module reports events it cannot handle as TypeError or
+        # ValueError. Do not leave a truncated trace behind.
+        print(f'Failed to convert {args.input}: {err}', file=sys.stderr)
+        if os.path.exists(args.output):
+            os.unlink(args.output)
+        return 1
+    if writer.nr_skipped:
+        print(f'Skipped {writer.nr_skipped} samples without a time, record with -T',
+              file=sys.stderr)
+    print(f'Wrote {writer.nr_samples} samples to {args.output}')
+    if writer.nr_samples == 0:
+        return 1
+    if not args.no_open:
+        open_in_ui(args.output, args.origin.rstrip('/'))
+    return 0
+
+
+if __name__ == '__main__':
+    sys.exit(main())
diff --git a/tools/perf/tests/shell/script_perfetto.sh b/tools/perf/tests/shell/script_perfetto.sh
new file mode 100755
index 000000000000..87797b377922
--- /dev/null
+++ b/tools/perf/tests/shell/script_perfetto.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf script perfetto tests
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# An uninstalled perf has the python module next to it, as in python-use.sh.
+module_dir=$(dirname "$(which perf)")/python
+if [ -d "${module_dir}" ]; then
+  export PYTHONPATH="${module_dir}${PYTHONPATH:+:${PYTHONPATH}}"
+fi
+
+# Find perfetto.py in the install directory or, failing that, the source tree.
+script="${PERF_EXEC_PATH}/python/perfetto.py"
+if [ ! -f "${script}" ]; then
+  script="${shelldir}/../../python/perfetto.py"
+fi
+
+perfdata=$(mktemp /tmp/__perf_test_script_perfetto.perf.data.XXXXX)
+trace=$(mktemp /tmp/__perf_test_script_perfetto.pftrace.XXXXX)
+
+cleanup() {
+  rm -f "${perfdata}" "${trace}"
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup TERM INT
+trap cleanup EXIT
+
+if ! "${PYTHON}" -c "import perf" 2> /dev/null; then
+  echo "perf script perfetto test [Skipped: no perf python module]"
+  exit 2
+fi
+
+if ! perf record -o "${perfdata}" -e cpu-clock -g -- perf test -w noploop > /dev/null 2>&1; then
+  echo "perf script perfetto test [Skipped: failed to record cpu-clock]"
+  exit 2
+fi
+nr_samples=$(perf script -i "${perfdata}" -F tid | wc -l)
+
+echo "Converting ${nr_samples} samples"
+if ! output=$("${PYTHON}" "${script}" --no-open -i "${perfdata}" -o "${trace}"); then
+  echo "perf script perfetto test [Failed: conversion]"
+  exit 1
+fi
+echo "${output}"
+
+if ! echo "${output}" | grep -q "Wrote ${nr_samples} samples"; then
+  echo "perf script perfetto test [Failed: expected ${nr_samples} samples]"
+  exit 1
+fi
+
+# Interned strings are stored as is in the trace, so the source of the samples,
+# the event and the symbol of the workload must all be in there.
+for expected in linux.perf cpu-clock noploop; do
+  if ! grep -q "${expected}" "${trace}"; then
+    echo "perf script perfetto test [Failed: no ${expected} in trace]"
+    exit 1
+  fi
+done
+
+echo "perf script perfetto test [Success]"
+exit 0
-- 
2.56.0

