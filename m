Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F74DBD70
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622402; cv=none; b=I4KJpxsk0351JEYRm/xhTWndE3+RUlyRl8nuOyzRk8WyhEdcTd36+nkna8awri4CdINXYil/iI3st72waB0Tdz+7ss9Jzesl7Hjktid69zu1LktFQ0Umj74cF5kZ8E6TazCgJK5HOObsg4X4d0awnp7vdL+wACCc4wABYqJgrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622402; c=relaxed/simple;
	bh=yi9BYXHrJ72mD7oJRT1CWFB47zzVyJStwP2vBl0yzog=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sw9jtDug3e6yk5jG/6dRt3vvsTdK31W8FFpJbRPdO7hDb/QUycOG8oQXBVtvtXnDMt5FwO/1WaN8B9q2wGanzUmIXs5sfDC03hSgPfF/j0raE2ZKX2ov12pVgyRaoT32KjsosBo4RIWEi2rKvCBlZ2ksy5xxL6k37RxW6kQMfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIvteoF4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIvteoF4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8484ba00601so65545b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783622400; x=1784227200; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HyjiNfo3fZbABjcbTE56H4SbgYoMcRaxhfPlz1HFiqI=;
        b=OIvteoF4vhT/tFoXI5Qn2ATnLKYJZfP+SX06flinctDzr0bfMRFACn38AHdrKItcMO
         VP81CqFIhfGlVCIn0A97r1w/siL4TgEb+TD5UeRwj5zs4EC0ga5Rhc80rJ6qpPTsYhmF
         32VGRCwQYX/7/gg2FsWhAb2biE5dbTp3wksnZyw1LjIlQ0I/NLH3busLv111k3fsiIpZ
         nI3AxbmmuSIpLbdcdeFtt2pc7fD7xHeRkGEggiZzqg4o9LnAAj3pNYL8bxxXKBwzQt/+
         G9C3M+BhhNXOrBaCNqtc6A3BzEf1qjCpK00AfbtybshWgZgpxmQdEp2n+9zlgKXhqFwN
         iPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622400; x=1784227200;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HyjiNfo3fZbABjcbTE56H4SbgYoMcRaxhfPlz1HFiqI=;
        b=sFkDrjAmGmgKOWbMuLcPsYJQQvy2OBxB8tPoP67gg6Ba5K0OsbTcrSwNUztHCSwTix
         aYdJLt+AOk06NYWGHaFOj7+W2pnR1lwF8+yatEtmGLSxcKc41qATueJDxdLdhCfTIqfb
         QWhaICPgCpX4Bxyg6kFa7Xrk55+/Laz940htxFJ+tQ+ThvVPYRdcWywAECBQf1Reoj9X
         wKn5CdWQC5rjYr/3nm793euGRXtYkRPz93X1qP6lCjHFG/Z9BqNo2wlmZkJxoP/zd3H2
         FkM5+7REfp6JkwDMKVEld9i0RZLjiPRMeU/0MF8axxlC6Bi+U36gmw0itOqwmPRxRMiZ
         oxtw==
X-Gm-Message-State: AOJu0Yw7PwBrPF1l0Lp9dkQ7xddGovOhdGRTh8yPgN7v4WaZC+DHdh7/
	oqXhFyMm/cpsp8nw9YT2uyuNEnG50VRgUtt9KWDBeXW4NdoJj8jX8SZ4RDY6b5ofhnr1623kXtz
	vZikXW3pfwgP2SVfm3JhHPgHo8+9WIAjJclrU2IEfmD6L3q8WxaoyldQOFQ8iMDRj6NGqN/Yf9D
	c8u+TbZ7Vv1h6dV73HqiGnR8IbwS+Ll/Ti68hwrNjpX5QgF5y5kw==
X-Received: from pfbhu51.prod.google.com ([2002:a05:6a00:69b3:b0:842:3bd7:f2bf])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9066:0:b0:848:6537:580b
 with SMTP id d2e1a72fcca58-84865376096mr2273211b3a.51.1783622399300; Thu, 09
 Jul 2026 11:39:59 -0700 (PDT)
Date: Thu,  9 Jul 2026 11:39:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709183956.1545402-1-ctshao@google.com>
Subject: [PATCH] perf jevents: Add dynamic IIO PCIe bandwidth metrics for Intel
From: Chun-Tse Shao <ctshao@google.com>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate per-IIO-device PCIe read and write bandwidth metrics
(iio_bandwidth_read_per_device_0, etc.) grouped under
iio_bandwidth_per_device for Sapphire Rapids and newer architectures
in intel_metrics.py.

By using has_event() checks across up to 24 possible IIO stack indices,
runtime perf automatically monitors only the IIO root complexes present
on the system without failing on missing instances.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/pmu-events/intel_metrics.py | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index bc2b920d3a0d..4f8a123a375d 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1132,6 +1132,57 @@ def UncoreUpiBw() -> Optional[MetricGroup]:
     ], description="UPI Bandwidth")
 
 
+def UncoreIioBw() -> Optional[MetricGroup]:
+    if _args.model not in [
+        "sapphirerapids",
+        "emeraldrapids",
+        "graniterapids",
+        "sierraforest",
+        "clearwaterforest",
+    ]:
+      return None
+
+    # On multi-socket x86 servers, there can be multiple IIO stacks per socket.
+    # We generate metrics up to index 23 with has_event check so runtime perf
+    # only measures the IIO instances present on the system.
+    max_iios = 24
+    metrics = []
+    scale = 4 / 1_000_000
+    for i in range(max_iios):
+      rd_event = Event(
+          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS/"
+      )
+      wr_event = Event(
+          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS/"
+      )
+      rd_bw = Select(d_ratio(rd_event, interval_sec), has_event(rd_event), 0)
+      wr_bw = Select(d_ratio(wr_event, interval_sec), has_event(wr_event), 0)
+      metrics.append(
+          MetricGroup(
+              f"iio_bandwidth_per_device_iio{i}",
+              [
+                  Metric(
+                      f"iio_bandwidth_read_per_device_{i}",
+                      f"IIO {i} read bandwidth",
+                      rd_bw,
+                      f"{scale}MB/s",
+                  ),
+                  Metric(
+                      f"iio_bandwidth_write_per_device_{i}",
+                      f"IIO {i} write bandwidth",
+                      wr_bw,
+                      f"{scale}MB/s",
+                  ),
+              ],
+          )
+      )
+    return MetricGroup(
+        "iio_bandwidth_per_device",
+        metrics,
+        description="IIO Read/Write Bandwidth per root complex",
+    )
+
+
 def main() -> None:
     global _args
 
@@ -1179,6 +1230,7 @@ def main() -> None:
         UncoreMemBw(),
         UncoreMemSat(),
         UncoreUpiBw(),
+        UncoreIioBw(),
     ])
 
     if _args.metricgroups:
-- 
2.55.0.795.g602f6c329a-goog

