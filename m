Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819235203E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617894; cv=none; b=axsK/7OBEsNGZ4gUVznz6U+hYz3/VYayT709EbxFGfpTn+VHFfZhEzKcct4bVKf/qI2xaL+/sI7H3JWDmHgfiUKHZp6O7m2M6Yb+bocxn1oomriLXfkaHgxk9rSFH3V2XT/N20hDs/XzuoZ3qZTXzCckKlwsQdSVonkKi4gzuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617894; c=relaxed/simple;
	bh=VNMwxQxppRW3tdbwoKdNviu76yr1Zn6jW74zhNLGCQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GfV+mFMtSL27aCBKBJwpXCTdlYZcp4+zBjmTYRHbFnrVDgEeNj0o1Hd4m1ZaBH/dJF1zvhzKGggZiCxDTJCIB09ajKXa9DuGfYaYMVuWr5fdYblHOHYIf8UiXwL9NbD46LHQeHu6KRx2GQ1QTLN6hTKFZoClV8Hra7+pfF4qhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GU3EXJXc; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GU3EXJXc"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86ab8302b54so2601675b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617892; x=1791222692; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wSrqJvLhBkyJhZH2O6UR1pCUMv15qswDfL8SIgUikoA=;
        b=GU3EXJXcBnaxeucfn2RKSY02Gw2B4+ENSVUYWd2PLroZU4R1srK/KAFi2hZFUIVQTW
         EbiBjKF+sonTTows7YuW6qs42vtUI7cxGq6xZex+1nH9q4F+1v6ezZUtqpuHNizKhJaJ
         Tq6VgMVXONnPStaUu0i4BpH33lnEN1HRTo8t8NVlxpAO/lpyqjeDpXmnIJ6HktN/MNvU
         Tx7oTMsyYL7D4U3smog3JX52qruQJlPPe8Q5hWLDEzvl/0yP4lVlvZRJ+qCCo2R+mBWP
         IpXZuvSLDCvCjL5ylWZd/+6pZjiGoWUfGd6Voc04iYySWJgpzN+tFvMzZ3gHiqUU7KjI
         F02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617892; x=1791222692;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wSrqJvLhBkyJhZH2O6UR1pCUMv15qswDfL8SIgUikoA=;
        b=zpX8K2EAdcqXv0ItEsUrplHEQZpjYXVDPLU9Ev/pYeaN1SZtY5z2HIeCashtPu9YTw
         dtsZApPe3cbcyUwfEEJIo1LWy0ajOT0UPvHkPQ7CBgE2zW0s41HTcjOyS/BDXxuUmJm3
         ExKrDLJ/Tkp8xGxmQCCTluGEyaqMSYnwKBW7IzTObYzI23Dcr5R0urhBxCwXFzIb4KI9
         5In8nZ/43OPJAvChfvi+/sxG0p7zI/xIiBnMtv+VbiAhsrniRn7IQWlsnFpeqvWxQ1ZJ
         dYOHCcZ7JagJnzNajZeqJW+EfSm+FRs+f49DLofR1afUJSQxd2i9uBt/UzHSn4FLqZF1
         2pOA==
X-Forwarded-Encrypted: i=1; AKwUvBzHom2b0aJFExu+hhuLEhXNyp2dSSUq1B2o5ns1obXUb9MSG1Byjy24MLk3ad+6PJHl6jE/Xh8xiBEaUTlZeh1B@vger.kernel.org
X-Gm-Message-State: AFuF++mHkccLvJRdqz1HYi8F7jC+wLOIUZj6lx1oZkplR3QgON6YupnP
	wVqeKLvigZUHEE4AJ4qEkcCibrei9AdTfBLY6qj8vElQRbmAdvzDoXhQd/rLtYhuDnUPSuqOT/v
	7/qzq8Q==
X-Received: from pfbdn2.prod.google.com ([2002:a05:6a00:4982:b0:884:c5c5:57c1])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:807:b0:881:e626:74b7
 with SMTP id d2e1a72fcca58-881e6268a39mr4686351b3a.49.1790617891690; Mon, 28
 Sep 2026 10:51:31 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:51:25 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928175127.1032535-1-ctshao@google.com>
Subject: [PATCH 0/2] perf jevents: Add NVIDIA Tegra410 uncore DDR and PCIe metrics
From: Chun-Tse Shao <ctshao@google.com>
To: acme@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, bwicaksono@nvidia.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Add DDR bandwidth/latency and PCIe bandwidth metrics for the NVIDIA
Tegra410 SoC to arm64_metrics.py. The metrics use the sysfs events of
the Tegra410 UCF, CMEM latency and PCIE PMUs, and follow the formulas in
Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst.

Patch 1 adds the DDR metrics and makes pmu-events/Build also run
arm64_metrics.py for the nvidia vendor models. Patch 2 adds the PCIe
metrics, in total and per PCIe Root Complex (RC).

Tested on a 2-socket Tegra410 system:

 - memcpy with multiload (from multichase) on socket 0 CPUs and memory:
   lpm_ddr_bw is 740-744 GB/s at steady state (perf stat -I 2000),
   multiload reports 708063 MiB/s (742 GB/s).
 - Read only (stream-sum) and write only (memset) loads on socket 1:
   lpm_ddr_rd_bw is 608 GB/s with 2.4 GB/s of writes, lpm_ddr_wr_bw is
   628 GB/s with 1.1 GB/s of reads.
 - memcpy on socket 0 CPUs with memory on socket 1: socket 0's
   lpm_ddr_rem_rd_bw and socket 1's lpm_ddr_rd_bw count nearly the same
   bytes (258.03 vs 258.73 GB).
 - lpm_ddr_lat idle is 150 ns in the default aggregation, and 132 ns and
   194 ns for socket 0 and 1 with --per-socket. Under the memcpy load it
   is 555 ns by default and 563 ns for socket 0 with --per-socket, and
   stays at 551-558 ns per interval with -I 1000.
 - 8 GiB O_DIRECT dd read from an NVMe drive behind RC 0 of socket 0:
   lpm_pcie_wr_bw_0 counts the 8 GiB at 8.7 GB/s (dd: 8.7 GB/s). With
   the buffer on node 0 it shows up in lpm_pcie_loc_wr_bw_0, with the
   buffer on node 1 in lpm_pcie_rem_wr_bw_0. With --per-socket, socket 0
   shows the same and no metric of either socket is nan.
 - With the nvidia_t410 metrics forced on a machine without these PMUs
   (PERF_CPUID=0x000000004e0f0100 on an x86 JEVENTS_ARCH=all build), the
   PCIe metrics read 0 rather than failing to parse, also with
   --per-socket.
 - "perf test 10" (PMU JSON event tests) passes on the Tegra410 system
   and with the x86 JEVENTS_ARCH=all build.

Chun-Tse Shao (2):
  perf jevents: Add NVIDIA Tegra410 uncore DDR metrics
  perf jevents: Add NVIDIA Tegra410 uncore PCIe metrics

 tools/perf/pmu-events/Build            |   2 +-
 tools/perf/pmu-events/arm64_metrics.py | 126 ++++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |   2 +-
 3 files changed, 126 insertions(+), 4 deletions(-)


base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
--
2.56.0.rc1.315.gc6ed9934b7-goog

