Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903633D6CA
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779010625; cv=none; b=ApJqRHJhIqz4kVVucWk1oCO+jr04/waO18zlT5DDkXrVomY4t3tbrWtTmJ5kPjkG33QAglgZ0qBBN8Tu6EDoBo4tslOTr7LuNZdR8rU2smko8h77QsWQlzGV+JDEdCg9KFbA9SAmNDzTJ/IxbFh9owIOENgEWL0ip9PSslcy9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779010625; c=relaxed/simple;
	bh=xzVBZ2flXGFguVcbzMoabjkJc1eDqfMp8FxN6E9b3LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+I5cVu65uHsdiaty+sWke4bEqcD7MwUSC9NX5uVeThDZPNk02diiXCVNR766V4OgIVBdyjrrDKPo/OHjjZ0ajDNRjjpfviOdVn3kasS/zxpAQjQQs7vMn4J5ofE6Z06bRYcx1G4SYGEIcfOcFA5+wUxaT+pe9eVIhfpVi7Lvio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpcoHTOS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpcoHTOS"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d77f6092eso578743f8f.2
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779010622; x=1779615422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7oPHBLaVR86h0INHDZIe0Bqjj8P2TpdMeN8jgVgaLc=;
        b=TpcoHTOS/6Px1zVOoAuHlQDVRHRm9QCrQnqNXGYU1KzR4GuTeqJEq31jE8YFxK1PVm
         oumIG4PbyglZ1zU+ARi+8yUuIANnsKxDEWYhnm+WDrwYkTttuAmmu+zo86iEjwUxNQRM
         f9M1snvtXsZJ3oy8VTqbOWyG/krU6+8UNAeSttfO2VmISigtd3vZxf2GtZAfzQUjRIor
         yFYHjEOOqxaDfjRbs2eNtQ57/LE6bJ80PXd6U1Z928PLFvkiYoLTjMSWrzP81JThP0xM
         5MvYEs2oMspYe+QrD67D7dmTTSHz6DHDuoSBii1/xFEmcf9BCd53wdNdK36sA1Zv5eZB
         GKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779010622; x=1779615422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7oPHBLaVR86h0INHDZIe0Bqjj8P2TpdMeN8jgVgaLc=;
        b=pqwHIULjd4+5El7oBW3ubt/676s4hqf+ajR3DsH38cpyAwOwoxCMgx5KHsvnPnAeV6
         pWZc4DVpHjMvhb6faEYXa6eVTZHiJlmHdFP/VCSHg836ZGIPo8E28ciOFqs1LAIQAjFs
         Bwz5R3XGQ/sTk/kNK0mbDKq3r5MART6YiGJbhDZsoFmB+p1d/3FopZUS4lTPEP6cmMzp
         tcoH0UQEPaxvCptUam/+lAW69cZTKlFuvjlf1HKOq0ZKct5P9yh62uT+h0Gbso9IaRoK
         LLPnw32Mb2R5p1htFVCDmlwmYKTFEQuUiRRk1IhqlALhlHVDb26wZ6NXrio1J8/Owt9X
         0Ypw==
X-Gm-Message-State: AOJu0YwOHtL1yFwPluYG5hEQv5DQUNkNIWeCs+GIwQZ0RQ1SDjXFzHCh
	bP2B9iAklxnUCS3XgEZjv3prXq/TnzXSOXqySi0FVMbvf+Hq47tKCcAjTt8Chw==
X-Gm-Gg: Acq92OEtjZAjcKABfjjdBv9kFZYLv7WgKMWtvguio7jRfGn9GJqbyUnxrgAZnfxBu2l
	+ishr/nDB9g3233PaujGF5JfJIlurl2oprGgfHfqcd4jaBseGtVlhssefGsIfx9rVsnB6KfrrJ1
	OIqjKXmZMv5/c86eOX1ilavsL9LxbvOki3GP2e72SmSCIeDTN0Z3VIktVAvAmFF2GYE9AGJ4zHQ
	RKTPW7WYAXJQRPJ/EwClmvEAcVDhIdC+bdlFlIIEBzC3fN1N2p0DsyEROV2dR/fiw1HxyDU+E01
	jaiHHWykYA4LGmT5R5brJfF15rQdQSuLVsfEHrYhKNkyj4Dh5TRjSS8KzQmX4j4QhCZzwBshTP8
	ePRGU80AGzGLieSQzcTey2tVeUyB10X+0jp8OySXtn3xcZyCnk5lkSALbcEiksN3Vrdx8XEw9sk
	fnopQ7uhR0ZpVq5r7qusdt7sJIPvvZhwbU0OltifKps+ET6oglwGH9VdgjZ/Zc/7R7vOVbug==
X-Received: by 2002:a05:6000:290f:b0:452:273:5cd6 with SMTP id ffacd0b85a97d-45e5c5a5e3bmr15500362f8f.1.1779010622124;
        Sun, 17 May 2026 02:37:02 -0700 (PDT)
Received: from fedora (net-37-119-214-243.cust.vodafonedsl.it. [37.119.214.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d16sm29233782f8f.6.2026.05.17.02.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 02:37:01 -0700 (PDT)
From: Francesco Nigro <nigro.fra@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	Francesco Nigro <nigro.fra@gmail.com>
Subject: [BUG] perf stat -D: CPUs_utilized metric includes delay period (regression in 6.19)
Date: Sun, 17 May 2026 11:36:50 +0200
Message-ID: <20260517093650.2540920-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found a regression in perf stat where the CPUs_utilized metric is
incorrect when using -D (delay).

The metric divides task-clock by total wall time including the delay
period, instead of only the measurement window. This was introduced
in 6.19 by commit b71f46a6a708 ("perf stat: Remove hard coded shadow
metrics").

Reproducer:

  # Start a CPU-bound process pinned to 2 cores
  taskset -c 0,1 stress-ng --cpu 2 --timeout 60 &
  PID=$!
  perf stat -D 10000 --timeout 10000 -p $PID
  kill $PID

Expected:

  20,000.xx msec task-clock    #    2.0 CPUs  CPUs_utilized
  ...
  10.0xx seconds time elapsed

Actual:

  20,000.xx msec task-clock    #    1.0 CPUs  CPUs_utilized
  ...
  10.0xx seconds time elapsed

The "seconds time elapsed" line correctly shows ~10s (measurement
window only), but CPUs_utilized computes 20000/20000 = 1.0 instead
of 20000/10000 = 2.0.

Root cause:

The JSON-defined metric in pmu-events/arch/common/common/metrics.json
uses duration_time as the denominator:

  "MetricExpr": "(software@cpu\\-clock@ ...) / (duration_time * 1e9)"

The duration_time tool PMU event captures start_time in
evsel__tool_pmu_open (tool_pmu.c) which runs BEFORE the -D delay
sleep in __run_perf_stat. So duration_time = delay + measurement
window.

The old hardcoded code in stat-shadow.c used walltime_nsecs_stats
(set AFTER the delay completes) as the denominator, correctly
excluding the delay.

Suggested fix:

Reset evsel->start_time when counters are enabled after the initial
delay, not when they are opened:

  // In the enable path, after delay completes:
  if (ev == TOOL_PMU__EVENT_DURATION_TIME)
      evsel->start_time = rdclock();

Alternatively, introduce a measurement_time tool PMU event that
reflects only the measurement window, and use it in the metric
expression.

Affected: Linux 6.19+ (confirmed on 6.19.14-200.fc43.x86_64)
Not affected: 6.14 and earlier

Thanks,
Francesco
