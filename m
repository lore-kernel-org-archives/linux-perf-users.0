Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11215FA67
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323018; cv=none; b=iu3Be1TnKpTz5ZmmZrsNg5Fv2goHgWdS0wPbBMMVMZJpl/lE7wrwj2hrQMJ0fwKoWNUv4gCcafBIuU31Cly0zExjjFGBiTaweN3r7g9Wg5BI9SvdirVmxZCFHYxmffZvJRNPmBymOQK0RLsuKVZpgXUChlH61caK98AMkWb79wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323018; c=relaxed/simple;
	bh=8kGTS4HVT8KpR/eO601IHXpA2FvItFD8t5X6wz4AxBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaLkfTKNTLjsypj3HxqHqnUq4Al5D3CNuk9+uJwp4mmbhvpiQk2u4VdN3cUM4z3cbwIgPV4aC4qZOwWZ/wc9c9wMa1N7KvYDLHR+Jaz5jqQMEiY4vez2lo5HcWWNXlGw4/DWRmR0doCWtOmLh+ANZp9tnCi0xUGcsoEenTM+sNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+A5AlIg; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+A5AlIg"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-80f4f7e6856so1299860241.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719323015; x=1719927815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+WevDy/zbmH6/gNWgICGHdme8Bw7y7CeAZkS+a1N+I=;
        b=I+A5AlIg4QMe89zjakL4DoBKOISR/3jE9FolHRi+GYQHGx8xOG2pQ3Vgv8RfBs6iVe
         Vw/Xw3ejgqXfTf7+naiqo3ir/C2zod34q2FR9w3JIMfbHj/GkPrKb40zllvQt4ClYhJ/
         DU1aDJxBxK90KdHVwbKYOCndkSOobs0GGwuy0stPLnuVVAiZPkBgMPAO2twspEmVCJFC
         UsGhd03zk+u35GUd9oI+mYP3a1yy7bD9fui3M2PNmqsDifhljB33Gk4VjAKdrG4qKvn2
         IMS7LwIrZH5EjKR21f6ABFGORUK/B7q+2nXXxlcC6NWTSGandIcUotlO7GeRVaew4kbc
         6ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719323015; x=1719927815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+WevDy/zbmH6/gNWgICGHdme8Bw7y7CeAZkS+a1N+I=;
        b=Vw2Wg9LmuJbNFuMfHILRKZMileehR+DKJ3oadl1MCwYmehp2DTw0ohRQnXnTFrkPch
         6SzuHeUDTDJw8sVnKVHuQ9Mt1ojiWvNiIAnKeGCcCDYAvWkRm7K5jX+NHcwfFYYUdsjj
         No/9aNUsMWc8Piv5dvyJKoblw5evB2tBXwUvOvUPP9rHBwGWm291MP7/J631ngh0Vo5v
         vIfQNIhxOSaXbJTREHzclOhGc4d8V0XNHs2iKUzFAj+HB9geuEnebZsS24MgcoN19U3N
         aBucep6hZbcgDXXvCTQvodt/+bu4nRlqgTmUE/c4GFeko5VcBSd8dpt6TsuUmnByjV/r
         LVKQ==
X-Gm-Message-State: AOJu0YwME35zvcjJIYvc3CFBYyCud7mbHmalp2C4VGq/6k4Kg0jNnqQP
	PQdq25N1bdYYNBCwuZlnj2IWkEv+YRyMDt6i+ugj0sxKAXMn8Da+MZ92A/WXU7TwF+Yfz8F/TCd
	4FetHUdBrL8NI7XgYAY3hjfxj3yJJPcr4Bkk5
X-Google-Smtp-Source: AGHT+IFWEAS2SBcf9yuEn3swxZTPFQNVF8VlquVOGiWY6zTmxPMkkM+98oeIg2tZ2xQ3whJci6IkmR9GFjctp8UESzQ=
X-Received: by 2002:a05:6102:5fc:b0:48f:147f:c022 with SMTP id
 ada2fe7eead31-48f4ef4c9a6mr7045582137.4.1719323014575; Tue, 25 Jun 2024
 06:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
From: Marco Elver <elver@google.com>
Date: Tue, 25 Jun 2024 15:42:56 +0200
Message-ID: <CANpmjNOGpeogkZrGoF82MVEK4NYHFqn7V_kTU_1z3jQhaq5iWw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 at 17:27, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi,
>
> Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> the signal gets delayed until event_sched_out() which then uses
> task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> signal is delivered with disabled preemption.
>
> While looking at this, I also stumbled upon __perf_pending_irq() which
> requires disabled interrupts but this is not the case on PREEMPT_RT.
>
> This series aim to address both issues while not introducing a new issue
> at the same time ;)
> Any testing is appreciated.

Tested-by: Marco Elver <elver@google.com>

Ran lots of concurrent copies of the "sigtrap_threads" and
"remove_on_exec" tests (with lockdep on), and it all survived. Fuzzer
is still running but hasn't found anything relevant yet.


> v3=E2=80=A6v4: https://lore.kernel.org/all/20240322065208.60456-1-bigeasy=
@linutronix.de/
>    - Rebased on top of Frederic's series
>       (https://lore.kernel.org/all/20240621091601.18227-1-frederic@kernel=
.org)
>    - Frederick pointed out that perf_pending_task() needs to
>      perf_swevent_get_recursion_context() in order not to recurse if
>      something within perf_swevent_.*_recursion_context() triggers a
>      software event. To address this, the counters have been moved to
>      the task_struct (#3 + #4) and preemt_disable() has been replaced
>      with a RCU-read lock (#5).
>    - The remaning logic same that means the event is pushed to task-work
>      instead of delivering from IRQ-work. The series was tested with
>      remove_on_exec as suggested by Marco Elver: On PREEMPT_RT a single
>      invocation passes, 100 parallel invocations report (for some)
>      unexpected SIGTRAPs and timeouts. This also observed on !RT
>      (without the series) with a higher task-count.
>
> v2=E2=80=A6v3: https://lore.kernel.org/all/20240312180814.3373778-1-bigea=
sy@linutronix.de/
>     - Marco suggested to add a few comments
>       - Added a comment to __perf_event_overflow() to explain why irq_wor=
k
>         is raised in the in_nmi() case.
>       - Added a comment to perf_event_exit_event() to explain why the
>         pending event is deleted.
>
> v1=E2=80=A6v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigea=
sy@linutronix.de/
>     - Marco pointed me to the testsuite that showed two problems:
>       - Delayed task_work from NMI / missing events.
>         Fixed by triggering dummy irq_work to enforce an interrupt for
>         the exit-to-userland path which checks task_work
>       - Increased ref-count on clean up/ during exec.
>         Mostly addressed by the former change. There is still a window
>         if the NMI occurs during execve(). This is addressed by removing
>         the task_work before free_event().
>       The testsuite (remove_on_exec) fails sometimes if the event/
>       SIGTRAP is sent before the sighandler is installed.
>
> Sebastian
>
