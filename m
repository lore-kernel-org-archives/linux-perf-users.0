Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9B143743;
	Mon, 24 Jun 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242860; cv=none; b=cNQKBtDpM3WOHSIkytAl5y2YFv8h5/WuLAUmZNbX7Bf5XLkJBtJk94Gq9lTdwIDgc6PfNMWPuqjFgdmdFa5fDvRcdHczVKZQbulEtmgm8OS9AoYPFWNPYRwzKXJXLupvob2huyt380u0g855JqgIN1vh4FPHcvsQf2p1XIP2AT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242860; c=relaxed/simple;
	bh=R22VLvRBGqkcOaV5Abv9K10MsA60Th5z1YfGvmr06ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRNjfhslmTgxXiFq9tSeJ1PO3EHvldjCxljARXKXIPtEUxPGTPz1h5eQW6N5dKgkyd8i6Qr355lA0bqcROc7nUx9UMhFPn2n1IT/KzquhS9l8suLW3Gy+zs+IGhYizkeQhUsILA6wZ0geEkyyY+EhikZcRv99t3jmCf4k7DVskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M8DeJhSY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=35/1reV0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M8DeJhSY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="35/1reV0"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719242857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ljmcA9yUQ7IuwfFMDJIXUw92GNp5/f/T73VWST4Pi+Q=;
	b=M8DeJhSYnbNxdNL5DTiYDICJJkSxBdYkfHBFUb48/P8qUKVB4tT1Co8GRBM5Vm4l8EHJVX
	0KNPLYHLjY1k7LyrMGoxo7XLX65dVqta8o4m229QiOr89+LOt2gXB3gQ/HYgjU6jxwy6PR
	gc2p6c5Zaf2uE4IS3UHh60D29s5bSuMJmf9RcXauPzikAIUIBiKo6vvuXEGshs5U9ni99P
	60RNvmN6AILhvHB4WT+TwcyWXZo5pkQEB16B8B135msLQOUQaMEMhCT/H9y0A3rya86AhD
	PlM5GFm0cZJRjAW/qt3mBzjiJRW6VQMAxMh2h1mWVgEVg/WjjnVHQePYow8PEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719242857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ljmcA9yUQ7IuwfFMDJIXUw92GNp5/f/T73VWST4Pi+Q=;
	b=35/1reV0BvAD2EtgNYKDl9fQXKRVrMsfshs+Zks/3Mj+XehCLKzkRrKl52WAJCfvuWJ6a0
	VQ0zcgORsbuFheBA==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [PATCH v4 0/6] perf: Make SIGTRAP and __perf_pending_irq() work on RT.
Date: Mon, 24 Jun 2024 17:15:13 +0200
Message-ID: <20240624152732.1231678-1-bigeasy@linutronix.de>
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

