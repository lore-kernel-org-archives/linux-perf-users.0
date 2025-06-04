Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F235224AF2;
	Wed,  4 Jun 2025 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749079325; cv=none; b=QOk0oZMmaJZYpjYBF255bnzncSv50ZvhaBaz1oJKTpGkuxdlwerejvfMCh0UexhthpybzvAito7mSyZUdqXur1fPWlC1EEX4n87itAq/dkz5WF6LpcXiSPK11nSZs47H24Hduy+AzCM0wll+lxjYgj/lRNCwr/gUyVnPO2m99tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749079325; c=relaxed/simple;
	bh=DavXPLOA4qBd5zWmNksvx+nP6XzrqdzB4n6SWig+8aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNaKpHj23MT+oO9VDQd8lD8waEOb9yPfMLJ7kSPdYOLhBhSIPIoYWWfJwWVVAixPnIVWphSLuH80wbc0d97zHo9LDk5aIqW9KaDvGHWbcyaDXATGoRaj0jkzp+6fpnYUNAIfAPpvSGL411IpK835y73OHeH5uAaCwLI0yvzQuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md8K6/ql; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md8K6/ql"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442f9043f56so1810025e9.0;
        Wed, 04 Jun 2025 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749079322; x=1749684122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwwXcq9SvqSxAwcrttqQ535pq1SI2qaKboj674NPGys=;
        b=Md8K6/qlv7yH+KUkzCxAuz+yHf9AUCFvRG2QIAh24SzuHxcZqG2NzjLXGErui94SFW
         kS8eGf0IFrH8BnfY/wMmhHbI1LI+NW6nWEz1aupMn5O4WLDzhZeylXVX6C1W5sB36wGH
         hbYdECdP6QJjUVlUvS2R8XZw1kTTxo7FZmJyviXHtQ8nGPftdfaXxzANT++BHmzkI/WV
         E9R/BoFwXQIsGC0tmK6gFEnHr3e0UY13HEdYfxRmgoKoRfv3P2bSRbr4ZBH3nbv9411W
         tSzLVyXbdAhQdnQ1nRbvW90/kU3AxHPdtMGGkiOyJ64aKl7gdLq3vQD4qLFZWHrwpkIP
         mfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749079322; x=1749684122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwwXcq9SvqSxAwcrttqQ535pq1SI2qaKboj674NPGys=;
        b=CQhTVB83452YBRmf/89+6F9yxkDJ8Xy1riiSZK/Iw5LjA6D5VUEQzGBuMqo+Dd0zAO
         tVnvihzvaVF6wM+7AET4BYWMTeBY5nJ9Jdfd2idZIwrLsomiiUELvOxKd+Fx8G+IlZcK
         qXChsVrw9dKeah48hNxIpqQB75WrrzKeoilaiSVGGT6eZ+Q8x5927Zo8P6rxerE27ouu
         RtySklYXZiZtD97ml16+XCIZtOrDgpZHbuC34QLzmhyNES29AwJQzBmBbaEhgB3EOkFQ
         WM1I8drwh6rzrmXMKkRMJrpXtLQ8t0r47ME62ob4lzV+61ms0fRJM4JqvBU6FLQkzd02
         ClRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAmFbFW39gl8uh6yaLuHRR0jaXju6Ql6E14Ftcrh60HpXpTbjgUrHB6NzsaCGtYfC9kmcXCJEpcfp4ww8RBitz1w==@vger.kernel.org, AJvYcCWws7sDP7D7LHDU82XnBXlYSdyCQmjWb/TDLp1PH+1Us4hFHB5WSmlXCCWqkGIzA5obdDIbLVXmYFupR0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNuHtVnu+MN7gu/dMzSj0ty5EJvGz87LXN07VO5ZJyXOL1lDj
	4Q2iQDWyGDJ+p0OksvR4q6lDJIzW3nLcNuxSuJVx89JVWNnRsV/HnbPtgADM3K7JefmN2UEG3qM
	Gl6AaIUN9Hf8THAT93RSMp93XJjomb7g=
X-Gm-Gg: ASbGncukabOtACQUcZ2juI0vmMjuqi4JXyciPe/WK03sorVDdOwFhJmqr6sdhWbagzp
	PxHx0o6ua2TLWCzmCNe7N+PlIi5VCqlkkoRz0ylvsd7Dj/0LMgrR+c4j0fC217T7w6GuwoAbLaf
	UP73U3iFnzWW9DWbKDApvzk60TIk5puZko4mnRva6Afz+WU9FZ
X-Google-Smtp-Source: AGHT+IESbyuxQraVYPxC7wpdKWHwDK9pwgCCWfCOD7IoCQsTYj+Al+j0Kzzq3CvQmANW2Q3K2lnOCzTfeKnvHVH7vkE=
X-Received: by 2002:a05:600c:350b:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-451f0b209d8mr41552955e9.26.1749079322021; Wed, 04 Jun 2025
 16:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
In-Reply-To: <20250604171554.3909897-1-kan.liang@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Jun 2025 16:21:50 -0700
X-Gm-Features: AX0GCFvq1shVE6kWYl-CEbSodT79t9asLkPcyvM5S6YpTFccl-wiy-eQ6M8qwhk
Message-ID: <CAADnVQKjyzdNVR_+WCMzORPJAX00tD3HK0vaCz13ZprWaG72Tg@mail.gmail.com>
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:16=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
> below perf command.
>   perf record -a -e cpu-clock -- sleep 2
>
> The issue is introduced by the generic throttle patch set, which
> unconditionally invoke the event_stop() when throttle is triggered.
>
> The cpu-clock and task-clock are two special SW events, which rely on
> the hrtimer. The throttle is invoked in the hrtimer handler. The
> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
> be used to stop the timer.
>
> There may be two ways to fix it.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
>   perf_event_throttle() if the flag is detected.
>   It has been implemented in the
>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.i=
ntel.com/
>   The new flag was thought to be an overkill for the issue.
> - Add a check in the event_stop. Return immediately if the throttle is
>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>   method to stop the timer.
>
> The latter is implemented here.
>
> Move event->hw.interrupts =3D MAX_INTERRUPTS before the stop(). It makes
> the order the same as perf_event_unthrottle(). Except the patch, no one
> checks the hw.interrupts in the stop(). There is no impact from the
> order change.
>
> Reported-by: Leo Yan <leo.yan@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm=
.com/
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jcc=
djysza7tlc5fef@ktp4rffawgcw/
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293=
@linux.ibm.com/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

It seems the patch fixes one issue and introduces another ?

Looks like the throttle event is sticky.
Once it's reached the perf_event no longer works ?
Repro:
test_progs -t perf_branches/perf_branches_no_hw
#250/2   perf_branches/perf_branches_no_hw:OK

test_progs -t stacktrace_build_id_nmi
#393     stacktrace_build_id_nmi:OK

test_progs -t perf_branches/perf_branches_no_hw
perf_branches/perf_branches_no_hw:FAIL

Maybe it's an unrelated bug.
