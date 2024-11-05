Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10B3BB21
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819771; cv=none; b=BuK+5M0N5iR1g+P77LzuKYCQoJA0kwuX1qKU7XsB83om/WDhFFdbP6OLLgkE23hzHApon6RiJTmpd23mR57pqZLWODwQ6FZZ+k1aUgep9umIlBm5lFp+VGbq3JkaUASp323XyNsHxo1yBLtEG/8C4XMqwn1j52ExjDv2/13Rx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819771; c=relaxed/simple;
	bh=1Dt5hWQ7GU/7KWHFg3LvSPS91sfOalR75iy3I5MrfiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePctUo0KDpoe/fbJh69tgZgELsQcBYyP/r53bwrSoQKqm1svnuKEvLIULAhe+RCtLFcEz1JPdGFkzyRymLHpoUFS0oX/dmoEbJTOewG7gCw39IiaqHgi+0D9gCaUnUKICHhA/LUPCp/9anvAhVgBFT1xHfuHEV8LntI4ZO8/ArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcVvTAA7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcVvTAA7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca4877690so187345ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730819769; x=1731424569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oDcNBRJoF3ugJNaCQ1ePXTBFE41nZYUKBeotgqI//c=;
        b=FcVvTAA7wWwmjynApdjdp0w+U/oLegexP+HopqcuncBLamK/iU/Pp6datSCBlx4pKE
         0y3ugeC6NbgbM/hyJ0hYCXTVicwu1q5cVqTf1V2mwUiNcEr0NWAr+A+fw54JoCGRrZDZ
         uYXmz5LZV59SaxgJrljnt8HBb1Fyw69V1uS1WbMV+wsT0n0YErDg2daRjqNA6SUipIY8
         raQskZXpZR2Bl9dDBKunthqnXeXmVQKUA3CfFW7uIzCBI1xMCGNXutNNrp+JqR67+aZp
         TY/d5eQG6PiwiT80aPUpjvSCqs9wUpXTJl8j6NpjgCl2U/bkbBorkPEUUJAD48yrn9Gn
         q7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819769; x=1731424569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oDcNBRJoF3ugJNaCQ1ePXTBFE41nZYUKBeotgqI//c=;
        b=h5Dub83fHY4D1u4MLhC64bSUMJ3eUP1rXFTGRVbvQw9pgyO+jIYzSicLdKH21zRZuL
         +cZ5RaTitWt5ziqCsDUl3hQpZf9LoOoe57rbrn7Meu5wa776bJdlnxtEnR1cf3zCu5Ba
         6qkO0h8aoLlnWKNzqIrkeVvdKbVwU5Zw78YPhJF1d43jiyPjjo4UuhXfFGkiJKH6R//Q
         MOBHWngowGOM0Xgga2BOj1ODR0dtjXqLhjNM3ung2w43wXkdO5btoGMWQApcpCV2OoPA
         hCGflRSI61r2yx43CcwJrcQLPWd38XHrK3ydm3XRP0MGN6SkO5wfT9qZxKsSe299SeE5
         mCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWssFzuoS19mKfChcenbCzas4wn56XXwYXaByPNmvZW6Dd4ZExeeLDnFh7jbyYmKXgs7+4A9gFFNG3xLIcGvY9N@vger.kernel.org
X-Gm-Message-State: AOJu0YzcAzFR25qYqoIpeiRy6Vuwz72OWER6VBDJgLIer2mvC0XYOv3b
	Al4pU5HfGwsJKCj+FSgNlk3+uWKg68rqVt8sfoP1lWoo/zzSHo06sM8ALp8XpS2W6jU7v8QP6Ot
	N7aIMNLLPM+ImJ6f0zBwFz42FBTsx9+z0wp9E
X-Gm-Gg: ASbGncsY2PCFTKWi423lbs24gaS/k5BcPCD7DrTCkXgOAO5rHAr4j/2MQXM6ijIGkCQ
	ztBwFSxMZt/Y/DTFHFWd5uZju1aLoDeAZ
X-Google-Smtp-Source: AGHT+IFsWHd8VJEr3yLTzOH0IktdtyiMppn2MXA6qRraCO2x0crqW6EqIf9lj8ztOwkuN7YOToyYAUyvfifTkom4QbI=
X-Received: by 2002:a17:902:ea08:b0:20c:a55b:aef1 with SMTP id
 d9443c01a7336-2115e1e82f7mr2553575ad.6.1730819768663; Tue, 05 Nov 2024
 07:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com> <20241031223948.4179222-2-ctshao@google.com>
 <20241105122423.GJ24862@noisy.programming.kicks-ass.net>
In-Reply-To: <20241105122423.GJ24862@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Nov 2024 07:15:56 -0800
Message-ID: <CAP-5=fVMb_hqhT7RW9o5p7qREM1QVHSsnb1dXG7Oh+v4XdN-rA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: Reveal PMU type in fdinfo
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, Kan <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Oct 31, 2024 at 10:39:44PM +0000, Chun-Tse Shao wrote:
> > It gives useful info on knowing which PMUs are reserved by this process=
.
> > Also add extra attributes which would be useful.
> >
> > ```
> > Testing cycles
> > $ ./perf stat -e cycles &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    3081
> > perf_event-orig_type:   0
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> >
> > Testing L1-dcache-load-misses//
> > $ ./perf stat -e L1-dcache-load-misses &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    1072
> > perf_event-attr.type:   3
> > perf_event-attr.config: 65536
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> > ```
>
> First time I hear about fdinfo.. How much of an ABI is this, and why
> this random selection of the perf_event_attr structure? What if someone
> else wants something and then we change it. Will this then break ABI?

Hi Peter,

There is a man page describing normal use of fdinfo:
https://man7.org/linux/man-pages/man5/proc_pid_fdinfo.5.html
I came across it wanting to implement a DRM PMU similar to the
(unmerged) hwmon PMU:
https://lore.kernel.org/all/20241022180623.463131-1-irogers@google.com/
The DRM extension to fdinfo isn't described in the man page so I
propose it in these patches:
https://lore.kernel.org/all/20241101211830.1298073-4-irogers@google.com/
Where DRM describes its fdinfo ABI here:
https://docs.kernel.org/gpu/drm-usage-stats.html
An example implementation is:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/gp=
u/drm/amd/amdgpu/amdgpu_fdinfo.c

> How much of an ABI is it?
I suspect that it is similar in this regard to anything in /proc, such
as /proc/pid/maps. /proc/pid/maps has been changed by things like
disabling the showing of "[stack:tid]" information, but generally it
stays the same. Adding information is obviously intended.

> Why this selection of perf_event_attr?
For the EBUSY warning perf_event-attr.type would suffice. I'd been
nagging for additional information for the sake of debugging. It gets
a little harder to print some values as they are in unions. These
values at least make a start.

> What if someone else wants something and then we change it. Will this the=
n break ABI?
I don't think so. I can imagine lots of other information to be gained
through the API, like the hw_perf_event state.

Thanks,
Ian
