Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035D1B11EA;
	Thu,  4 Jul 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112672; cv=none; b=ntmG3VQZ1ga/cSMD3Jd41T3I2aC/NDzvTg/nyRuP/q9w16lTfKunjdhGnWjfDvI6UqPoXWm9jLbl6WJLrmQZL5D+xQgCmt08sArxxztgUcR89Uz+u8KV/HGPJSdp5nifNaj0jYhh0M0o1apiXIh04M9tlmLg3OjX9hJB8R8gerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112672; c=relaxed/simple;
	bh=3WfFCHTftvxsbGLRuQ3ylLf6HjzX+2CJHFzwOchYMuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jqwxwaq+9ZcpswPG6trHapEzylatDA/Kq/+UBNJvFxcHgeQLGLb9voofGkebvSpfY4reFdvDtHkbK5DknjbYg3AVobNHk/xC3flnJZP4lzW1756Vywfn8PJqSq1+94RK3Gui58T/gJOWzcMW0McOGbP0G71knSn5Qcx443UwyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=df40TwYn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhEwsS5d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="df40TwYn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhEwsS5d"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YLTV7EHjaqTWVE9vs7iolrAMajWrkh9Agp0VGasT9OY=;
	b=df40TwYn2eIDNUmKOoFiayMc8vb4TCl7az/vk8LGLPo44x5/XbSFjRjhodVIQscK+3K1+s
	VDPxduP4C7R9mdBFfz9rS7CnpUHtNJAcAhcGu1dqIOVTevam/2aNyG7SHfGkNg3PtLavGI
	nqBfH4k5G5m9+cuDBjedFaZI994/kZgSSXkGmfmli91s7MM82IzJAFKAIORA0Rn1VyG4ZJ
	LwhiorOdokapZvok5e2gbJH+1BjMZg4Qj4o7oM2nVsUKjlJllxfgz2Cqiuw9eUMSd8O1iI
	T1FJiO07WTmRAid4McbZmkRijvIt6KcrXIbCov+U5YkNu8A9kEfqfpJ4zRItBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YLTV7EHjaqTWVE9vs7iolrAMajWrkh9Agp0VGasT9OY=;
	b=NhEwsS5dVddS2gbmg35koqcl+l2+8N0IMa++l5GK6x0bBFsaOywVun6RN7M+v1Qsj5x6nt
	yR8T7m+1Q6vi+zAA==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang  <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 0/6] perf: Make SIGTRAP and __perf_pending_irq() work on RT.
Date: Thu,  4 Jul 2024 19:03:34 +0200
Message-ID: <20240704170424.1466941-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
the signal gets delayed until event_sched_out() which then uses
task_work_add() for its delivery. This breaks on PREEMPT_RT because the
signal is delivered with disabled preemption.

While looking at this, I also stumbled upon __perf_pending_irq() which
requires disabled interrupts but this is not the case on PREEMPT_RT.

This series aim to address both issues while not introducing a new issue
at the same time ;)
Any testing is appreciated.

v4=E2=80=A6v5: https://lore.kernel.org/all/20240624152732.1231678-1-bigeasy=
@linutronix.de/
   - Add TWA_NMI_CURRENT as notify mode for task_work_add() and use it.
     PeterZ pointed out that the current version is not NMI safe.

v3=E2=80=A6v4: https://lore.kernel.org/all/20240322065208.60456-1-bigeasy@l=
inutronix.de/
   - Rebased on top of Frederic's series
      (https://lore.kernel.org/all/20240621091601.18227-1-frederic@kernel.o=
rg)
   - Frederick pointed out that perf_pending_task() needs to
     perf_swevent_get_recursion_context() in order not to recurse if
     something within perf_swevent_.*_recursion_context() triggers a
     software event. To address this, the counters have been moved to
     the task_struct (#3 + #4) and preemt_disable() has been replaced
     with a RCU-read lock (#5).
   - The remaning logic same that means the event is pushed to task-work
     instead of delivering from IRQ-work. The series was tested with
     remove_on_exec as suggested by Marco Elver: On PREEMPT_RT a single
     invocation passes, 100 parallel invocations report (for some)
     unexpected SIGTRAPs and timeouts. This also observed on !RT
     (without the series) with a higher task-count.

v2=E2=80=A6v3: https://lore.kernel.org/all/20240312180814.3373778-1-bigeasy=
@linutronix.de/
    - Marco suggested to add a few comments
      - Added a comment to __perf_event_overflow() to explain why irq_work
        is raised in the in_nmi() case.
      - Added a comment to perf_event_exit_event() to explain why the
        pending event is deleted.

v1=E2=80=A6v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigeasy=
@linutronix.de/
    - Marco pointed me to the testsuite that showed two problems:
      - Delayed task_work from NMI / missing events.
        Fixed by triggering dummy irq_work to enforce an interrupt for
	the exit-to-userland path which checks task_work
      - Increased ref-count on clean up/ during exec.
        Mostly addressed by the former change. There is still a window
	if the NMI occurs during execve(). This is addressed by removing
	the task_work before free_event().
      The testsuite (remove_on_exec) fails sometimes if the event/
      SIGTRAP is sent before the sighandler is installed.

Sebastian

