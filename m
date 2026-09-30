Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607D2F6565
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779381; cv=none; b=nBAjMjZR1lrRE3r3DCE8wNxUcLCSPUF10OcSo8Jxg9yLVbgFwRnB7QvdsZL/BkVuoYTzYu1QXz2C9Aokrh5DBXE0GIIxRrAoF6i5C85XzglYyxkep2QYPSttOOHAtdweCiJzlW+ARgfoxocQQuN00oDs/7KBcZMZjF4ClrNGe5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779381; c=relaxed/simple;
	bh=8UcWVXM+EmggUJG9RPNWsrlMH3hzHO+NyygDLU1YsGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkKVy67KvU/W4Icp79cMdoLTKZbCxQTvjPrVvOb9F2Y3m95DX8dNBVUz9pl6ubJHF+G7SXYv0Ee+UKD5p4YHxzUfciFpw+1NbGz3Z5iEqtY+c0iMnsIb0IGsyGUoows4ZbkrG75S3zrP6ssmcEDVHm6dG+AxAA3Z2Qb/lqVqQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy32UqnP; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy32UqnP"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6c72bd8a02fso2947411eaf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790779371; x=1791384171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCYghwym+9Y4w6eXWM454UE/qTUCfuDedvhfnXRMawY=;
        b=dy32UqnPl+BzkaikiClvupMqvPh0AuM/W63XwSJmOz3zVdaePgQuOESYOQyeo8Tc9R
         PcH1UnP0d68nfvfRIpnqKYXCjNIHpkmIMDqTK4ekfip38Ur8PuKC7xRXpxyc2JXlU27H
         HBApB4YGWEtZGNL4it5Dbokc2b1me2xYUnEmPhN21LCP5PmZYV5fOG0TdAaI90kTVORZ
         OVbnnHvHJPsm+7BOsvUCZ0339uG7ptC7F/+lUEdn/KrhphQcXL8GeoYj6O2c4NLy2DPy
         1lTbHy9V0T94+QeRMYLACUBLcOLzV73wvB402U48SBk5ZZjHXm+P0MSEMJpZ+cRIBNPf
         OHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779371; x=1791384171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCYghwym+9Y4w6eXWM454UE/qTUCfuDedvhfnXRMawY=;
        b=E+601YX79t1mo7529swmpNDa2Px27jAdF+zIM1F4IacLOHviCDeDXyL/qNSIqUzaUR
         YyTd2XIUGTLfH7OcSVRtWGwliFW6cEWkeOoeZACjB0TTF+IKB+SG5a6rFsfcRu+NDPPY
         Tttz6bGd3rfvYti3fgBQBCevAZswV2vsPk2f9TWjc07U/wOZL7ClpyUcNHFHTjfh3M/2
         Xpi5gfS1vy638dsb38ganOflnwcqzcUK7zt8YNikkPm1OmtLU4YJDFRO8+JOI1f3jnyH
         vG6MyLj3SgmoPLkycULjpe61oqWz+6RByO3WLNi4lvaXAVeVg2tBS5OtySF+jw105ssI
         1bIg==
X-Forwarded-Encrypted: i=1; AKwUvBx5Q5Fj0geKGF0H2Ci85NtKllTViiMucqLT+VXdLYqfOHJWMB/IhmfHg6AgfN5JuFA0YR/4W3J3/BRAs91OIrfx@vger.kernel.org
X-Gm-Message-State: AFuF++npM+uxs/a4TygvrSUyDkQYtbEF8SF48R9mZZPk3LgBJSQk3Ood
	8L4mz11K0MC5cWradgNAMUyfP8EIJlUkBdLVUtPmA+ei5wI8WLumwG64WgOc2w==
X-Gm-Gg: AYBFou1ojNmF3WQlMV3yBjV6KYmf4mzeIeyeaRxfU04FH6uwGnjC0U+Qjd3aBlio12k
	Le1Ongj3bwoQKdjFHfXMyt+rnffT/xFPjewWLKH4SGFcbdEO82ndn0GEDYPRzFsU3cYtNzVtvoW
	zIUzErHWWEyWh5JHQMzpiww4DzEwZHLS2Aq3H8r9nIbXdRvL2r79Svn4CdGTDXDmviTk+RBAMY6
	S6GxkwUmryQFSEOduzYMqNTIVc3jOFo0bk6f17knTNBajnqP+x553s4t7NTlDAbryWYKZpAvlPo
	XDlB93yXVWf7AvUbgzvtoLzZtuD0tfrlkEdjTQhssJVsWCpvkM8Ekgv97606JFYaUq9+5PI1dk/
	7yYTQv2r9XTpnMeRp9NS1AqDq7k/VUsUa2vVyWupTD3yKG5RtXawRdXWQI9a9EFEiiYdV6ePRCn
	qG1rxtCa5S/tZnsCe4s7xAulT8H9P6pcbJzRSHXfQOI+BFooElGM/8kr9yaElYAnM6oKsVhjxRP
	KAcJBRMMmGXqFUFyFh4WGyhASsV14tsoJu5n/mt8K+uz3TJuYE=
X-Received: by 2002:a05:6820:60f:b0:6b8:ce67:77d5 with SMTP id 006d021491bc7-6dcf1ab0479mr1793103eaf.13.1790779371494;
        Wed, 30 Sep 2026 07:42:51 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-820635e68b3sm1091810a34.17.2026.09.30.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:42:50 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Marco Elver <elver@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf/core: Don't send SIGTRAP after exec removed the event
Date: Wed, 30 Sep 2026 09:42:48 -0500
Message-ID: <20260930144248.59858-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sigtrap event must also set remove_on_exec, so that its SIGTRAP never
reaches a program after exec. But the signal is sent from task work,
which only runs on the way back to user space. If the event overflows
shortly before execve(), the task work can still be pending when the
task enters execve(), and then runs when execve() returns. By then
perf_event_exec() has removed the event and the new program has default
signal handlers, so the SIGTRAP kills it.

The exec_stress test in the remove_on_exec selftest catches this and
fails about half the time in a VM. A process that opens a sigtrap event
on itself and then calls execve() is killed by SIGTRAP in 15% to 50% of
runs, both on an AMD machine running v7.2 and in a VM, with or without
close-on-exec on the event fd.

perf_event_exit_event() sets PERF_EVENT_STATE_EXIT when exec removes the
event. If the event fd is close-on-exec and was the last reference to
the file, exec also queues the file release as task work. Task work runs
newest first, so perf_release() runs before the SIGTRAP work and moves
the event on to PERF_EVENT_STATE_DEAD. Exit is already caught by the
PF_EXITING check in perf_sigtrap(). So don't send the signal when the
event state is PERF_EVENT_STATE_EXIT or lower, which means the event has
been removed. That also covers PERF_EVENT_STATE_REVOKED, where the PMU
is gone.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Changes in v2:
    - Skip the signal for every state at or below PERF_EVENT_STATE_EXIT, not
      only EXIT. With a close-on-exec event fd the file release runs first
      and moves the event to PERF_EVENT_STATE_DEAD, so v1 still killed 360
      of 2000 children. Reported by Sashiko.
    - v1: https://lore.kernel.org/all/20260929182935.355892-1-danishkhateeb03@gmail.com/
    
    Tested on v7.3-rc5 x86_64 under virtme-ng (KASAN, lockdep, 8 vCPUs on an
    AMD Zen 3 host):
    
    - selftests/perf_events/remove_on_exec: exec_stress failed in 9 of 20
      runs before, all 20 pass after.
    - The exec_stress pattern in a loop (30 inheriting children, 50 rounds):
      a child was killed by SIGTRAP in 17 rounds before, in none after.
    - Each child opens its own sigtrap + remove_on_exec event and execs:
      756 of 2000 children were killed before, none after. With
      PERF_FLAG_FD_CLOEXEC: 836 of 2000 before, 360 with v1, none after.
      On the bare-metal host running v7.2.6 the same program kills 297 to
      1033 of 2000 children across runs, and 1012 of 2000 with
      PERF_FLAG_FD_CLOEXEC.
    - sigtrap_threads, watermark_signal and mmap pass before and after. No
      new kernel warnings.
    
    v7.2 fails the same way in the VM. I did not test kernels older than
    v7.2. gcc W=1 and sparse show no new warnings.

 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82..eabe6cdf7a88 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7631,6 +7631,15 @@ static void perf_sigtrap(struct perf_event *event)
 	if (current->flags & PF_EXITING)
 		return;
 
+	/*
+	 * The event was removed after this signal was queued, e.g. by exec()
+	 * (remove_on_exec), which may also have closed its fd (close-on-exec).
+	 * The new program has default signal handlers, so a SIGTRAP would
+	 * kill it.
+	 */
+	if (event->state <= PERF_EVENT_STATE_EXIT)
+		return;
+
 	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

