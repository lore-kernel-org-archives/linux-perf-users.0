Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A053F6B6
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077621; cv=none; b=eNK/VYbp+nxv6e1heSp9Q+brambHBXtUKzi9l4CyytB2fHZow3wjZYr9iNyI541uE7DIHwddVodKSZu9qdSA8NIAY7HmCv82Zo3+dDNdgcE3u9QhP4p+t7VlQ2cwei00nSBZD443YbkW87KO6dD48zoHf4rrKH2xBFlwykAW6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077621; c=relaxed/simple;
	bh=OjX1ssYSRgIYegjZbrTmi9PNdcpPB0TQFrmlThWg5lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFDdJXwUf87MDoKrJpzHfvCrA5lYDCVrnG4BudCvGh6zpoJ9pVbdcMaoFrI7vU4twEJsYYLRHLVWi+2rkoiYwEU/py/AFAJR/el6mDrPkaEEUvipvObsM3/F9XS9DzCkoXIXPHCUG3GnqfeSSZP99VH6onZsE2N6Hl0AX/TVE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb9Byiin; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb9Byiin"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f48d91ba7dso3940429b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077617; x=1792682417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mha7gBqe+FHTzNhXa015mlIzphM9boxhmgV8ZQMkPHE=;
        b=nb9ByiincjtpQVbIh/uv1EeMty5ujEoaChNT0evUyWx2pshiKDjXrOQM1PDxv92NUu
         YwQk0GKyREgAHVyAFLRvk8MJJNx8GIB62Jx+9iji+iSTBLFS2aq/pHglzf2BbxQWg1qL
         bmoFg3O5ccfcggYSSRln4Vg4Fakv1VEH/N0nFT5n4+Z4SAxGQIzOSr9z/7fBzFcZOTDp
         fnN5OT7H/bAqrH9c1013hob/lhJ3Xr8zG+S9Fj6XPTcpwGJM6fI331GcqMMZigIdB9Nh
         ZgrHLHo0OSVhgnzD3keu2BZziwvCx2IGbD5rMjZvzYgWTsaoBAOcIs62/KPRve1l+dOy
         is6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077617; x=1792682417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mha7gBqe+FHTzNhXa015mlIzphM9boxhmgV8ZQMkPHE=;
        b=lCLiiDFB2T2hVTKILaAh3J2Q/vowwLjkwyNSW/rYb99pOa7SOJBFsLSwwTxq0gz/yI
         523J+Bf7AAWVgYCI8X4x6hBMQzu4bgdETIji7JoR2A4rJxRqn3T+bjF23szMgBXIDvaV
         k86m5JIS6aXOhjJ5UJW3ODH3vlohbQCAVCW/whVDuJdSaNGtWTk5CQQ7+vp6IR+Q2+IX
         yIhx1yg0Vz4XvuxfMct0OvB5Eaan5oNgra2wNotQE6yjLXTEkcWKuDJ+58iMg9cqG7v+
         T0bkGnpyn1mhRmoiQcZa7pdtGdL/x2W/TP6DooMfjLp4LZ9vrM2KjdsmE1hNMtl9FfwZ
         fTLA==
X-Forwarded-Encrypted: i=1; AKwUvBzVUdb0Jkq0XFsuctnOX5eRb2n1zuSBeGw7PhGXl0uzagkyRZjWfVhc4x6xMSipr7qu/HMC95nlzFsh8hqcB5jd@vger.kernel.org
X-Gm-Message-State: AFq9FYJMPemAcEm3iv7nV+8F8m269sw6BODI6f/f0pVi7hNfjbq6hFP4
	kJ48jJwo+YfaaPuWEqkQ5J0ig6eO6yGTGQ5ZCoOMQTfEqNHIqkZvbqPp
X-Gm-Gg: AYBFou0Wm+JUdE7YVZKARuD1Xt/c1f3EyjtZPylTZzqRA3xP/Pti09ZnOlVWaSzKX4I
	GvtWGM4ejpL2vpXyyI0kcc0morNiPF5Ur8S3R2DxJ18B2B9Vb7zqUQxXyup0QrWDD+lnupfU5mN
	CzGAxJA2m1+vBwgnawdekKMk/yKl4dWCsn6Yfj6AekJqiB2hSoMs6zlrdsebjGE1EbiyFkRDp7H
	eHMUp3+roL/2IpRNm+kxwFDJdR7SBRG6ZTZDay8D1F4zi40gv65ml26EEkd4r3ruXFo1XcSVKIq
	KCfsf5Lb1Wfk+9ddMLXPC3sDXDa4swDek9CrluDRDwvE/aHBKVwHh+GiYvt3d40P4Eg/dHis73i
	lNYccHRbmjl50yIIDuZSi4Sj5Aee1k4NhIX040ezRxRiLV+7tkyMNmgC0axf7f2+Hj5U7NDd0AK
	yuRT0b5QL01WaO40zg30qchA6X6mI/ibAe39Jro4HTTK+wuEu3EWggpYXKLMhwcMhMqdD/jX2zR
	AAgM8fqlODZ6X89I+IISwsv2gJp1ETlRhdQHIp9XiTeKFFojXU=
X-Received: by 2002:a05:6808:4f28:b0:4b3:7b31:8df7 with SMTP id 5614622812f47-50c524711f0mr21604940b6e.14.1792077616511;
        Thu, 15 Oct 2026 08:20:16 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe916sm20246124b6e.1.2026.10.15.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:20:14 -0700 (PDT)
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
	Dmitry Vyukov <dvyukov@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Luo Gengkun <luogengkun2@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] perf/core: Don't send SIGTRAP after exec removed the event
Date: Thu, 15 Oct 2026 10:20:13 -0500
Message-ID: <20261015152013.106040-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Commit ffb684f2aa14 ("perf: Fix race between perf_event_exit_task() and
perf_pending_task()") made perf_sigtrap() return once
perf_event_exit_task() has set ctx->task to TASK_TOMBSTONE. Exec only
calls perf_event_exit_task() when the new program is not dumpable, such
as a setuid one. An ordinary exec keeps the context and only removes the
remove_on_exec events, so the SIGTRAP is still sent.

perf_event_exit_event() sets PERF_EVENT_STATE_EXIT when exec removes the
event. If the event fd is close-on-exec and was the last reference to
the file, exec also queues the file release as task work. Task work runs
newest first, so perf_release() runs before the SIGTRAP work and moves
the event on to PERF_EVENT_STATE_DEAD. So don't send the signal when the
event state is PERF_EVENT_STATE_EXIT or lower, which means the event has
been removed. That also covers PERF_EVENT_STATE_REVOKED, where the PMU
is gone.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Changes in v3:
    - Rebased onto v7.3-rc7, which has ffb684f2aa14. That commit replaced
      the PF_EXITING check that v2 was placed after, so the new check now
      follows its TASK_TOMBSTONE check.
    - Peter asked on v2 if this is the same problem as Luo Gengkun's patch:
      it isn't. ffb684f2aa14 covers an exec that calls
      perf_event_exit_task(), which only happens when the new program isn't
      dumpable. With it applied, an ordinary exec still kills the new
      program, see the numbers below. The changelog now says this.
    - Read event->state with READ_ONCE(), since it is read without locks.
      Suggested by Sashiko.
    - v2: https://lore.kernel.org/all/20260930144248.59858-1-danishkhateeb03@gmail.com/
    
    Changes in v2:
    - Skip the signal for every state at or below PERF_EVENT_STATE_EXIT, not
      only EXIT. With a close-on-exec event fd the file release runs first
      and moves the event to PERF_EVENT_STATE_DEAD, so v1 still killed 360
      of 2000 children. Reported by Sashiko.
    - v1: https://lore.kernel.org/all/20260929182935.355892-1-danishkhateeb03@gmail.com/
    
    Tested on v7.3-rc7 x86_64 under virtme-ng (KASAN, lockdep, 8 vCPUs on an
    AMD Zen 3 host):
    
    - selftests/perf_events/remove_on_exec: exec_stress failed in 11 of 20
      runs before, all 20 pass after.
    - The exec_stress pattern in a loop (50 rounds of 30 inheriting
      children): 24 children in 19 rounds were killed by SIGTRAP before,
      none after.
    - Each child opens its own sigtrap + remove_on_exec event and execs:
      342 of 2000 children were killed before, none after. With
      PERF_FLAG_FD_CLOEXEC: 1004 of 2000 before, none after.
      On the bare-metal host running v7.2.6 the same program kills 297 to
      1033 of 2000 children across runs, and 1012 of 2000 with
      PERF_FLAG_FD_CLOEXEC.
    - The same program as an execute-only binary run as nobody, so that
      exec calls perf_event_exit_task() (the ffb684f2aa14 case): no child
      killed and no warning, before or after.
    - sigtrap_threads, watermark_signal and mmap pass before and after. No
      new kernel warnings.
    
    v7.2 fails the same way in the VM. I did not test kernels older than
    v7.2. gcc W=1 and sparse show no new warnings.

 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f..61e9a88adca8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7633,6 +7633,15 @@ static void perf_sigtrap(struct perf_event *event)
 	if (event->ctx->task == TASK_TOMBSTONE)
 		return;
 
+	/*
+	 * The event was removed after this signal was queued, e.g. by exec()
+	 * (remove_on_exec), which may also have closed its fd (close-on-exec).
+	 * The new program has default signal handlers, so a SIGTRAP would
+	 * kill it.
+	 */
+	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_EXIT)
+		return;
+
 	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0

