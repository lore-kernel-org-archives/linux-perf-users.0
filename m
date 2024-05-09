Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5410A0D;
	Thu,  9 May 2024 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294022; cv=none; b=kdVmsHXF9huohJ1M2IKz5TiHVMDRc6CoCBWsY3JYgl9zLXGKCHEdNlsPiiGrxGiWwNQzqjzER4720xENqEZUDpTM2PEPasJ+EcZwIQk30bmElfW9t/GtyaNPduZDNfG7/vj3/2R0GRpEk62BH9P/gbshwOzNluNImggYv3tfTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294022; c=relaxed/simple;
	bh=uiPN+A9TYk8sL9k0FkSt+zGzCf+75RAq93wpeE8+KT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awtsOXWHxhQ/LDztlynYMU7Xffy9ZQaC7gj8PoURYRXQhSaqZaqwbAZn3uaEn4/ZyZpi8wPUFFegZOH4NGdiDS2mq4HMxTGNfK6xvteCWw8hdk/3xc+v7qrMrlVetDAkVWe2lDioPIYvdbZyQY73EMTW7J16cQGocX0wp7k+2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1015409a12.0;
        Thu, 09 May 2024 15:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294020; x=1715898820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQMYI/Us6+hzUkBBoGt7mILopno4K42cldFrLm7Ole8=;
        b=pFYOLDmd1ricNiWNo26/joyBO2LUzQtY2GCyXUBsxRCfnUzUuYZJYZ0HcnJEeUAA9f
         7JeL4kyjwobXVChsKojX8x6HIXFJsZ06S7ALj5LGzzOQ/6nTxtOXtBmVkM/kNgfQ0ljK
         X9sbL8ZdYeQOPAfL48sRwKO1pnWSibwj3QnlabyoRnj5qhCaMgGC5ShzStBLb4nDzR43
         Z9Jh9i/wjxG/Nuci6RVeXyOoYhLqhigGaOy/CBmBmom6xydtbqIb/GAm50FbpIUdu4n2
         HQY19BXBK+4+CaOuRCIupVg2Z2dvnTXGpHhOjZIFCVuCmjmCusNbJzAibWjI5+hZ1MwI
         k/tg==
X-Forwarded-Encrypted: i=1; AJvYcCUULjslJO9VeG8btMwmxUBG30yKFa7VWhc6D/8QkqO8KzaF6piDOuAUtNSgSad/vzYG0+zerU0gJKQZcvD4hff3u3dAbwRfafqPi6dnCsIeE5Cf58L/6ap0ruvLofG4+ShLTu2A+ZOV+p/t9zXp8w==
X-Gm-Message-State: AOJu0YzpFQywWa4uQ6HzOdDtF3IpSW1ryfwUSs26zUEv31ipnMFH1EvV
	u2HmdCye1+Jrm26EgbFuQTTO+WKG9776imf52ZD0L6mlBHMwXAmNYsMFuYf+2jORj4xddTn12fb
	dFF1jsFbokqr/5a/sInmM4tiDgng=
X-Google-Smtp-Source: AGHT+IHvuueVji99pdughyRAG0wPNZRSaQ/8w4ql0gHBMtQoXDbm87RfF2DzS5fvDaaVufAa5hV1PEmxdoE5d0QzlE8=
X-Received: by 2002:a17:90b:11d4:b0:2b4:3659:8709 with SMTP id
 98e67ed59e1d1-2b6ccc72f69mr976802a91.34.1715294020419; Thu, 09 May 2024
 15:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508060427.417-1-ravi.bangoria@amd.com> <CAM9d7cgFKcHXeTXxax7GRCK__0U3HUnG3Ls09GpnD8FipyJk1A@mail.gmail.com>
 <0689aa59-426e-2f37-dcc4-d79b1e89403c@amd.com>
In-Reply-To: <0689aa59-426e-2f37-dcc4-d79b1e89403c@amd.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 9 May 2024 15:33:29 -0700
Message-ID: <CAM9d7chvDczhMoOJFLz=MW0ojGm=Ex90CgHhfOsZuLre3vSE3g@mail.gmail.com>
Subject: Re: [RFC 0/4] perf sched: Introduce schedstat tool
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	irogers@google.com, swapnil.sapkal@amd.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com, 
	james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 11:02=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> >> USAGE
> >> -----
> >>
> >>   # perf sched schedstat record
> >>   # perf sched schedstat report
> >
> > Hmm. I think we can remove the duplication in 'sched'. :)
>
> You mean `perf sched stat record/report` ?
>
> > Given you are thinking of taskstat, how about making it
> > 'cpustat' instead?
>
> Sure. How about:
>
>   # perf sched stat --cpu --task record

If you plan to support both cpu and task at the same time,
then I'm ok with this.  But if they're mutually exclusive, then
probably you want to have them as sub-commands.

Thanks,
Namhyung


>   # perf sched stat report
>
> > Also I think it'd be easier if you also provide 'live' mode so that
> > users can skip record + report steps and run the workload
> > directly like uftrace does. :)
> >
> > Something like this
> >
> >   # perf sched cpustat  myworkload
> >   (result here ...)
>
> Sure.
>
> Thanks for the feedback,
> Ravi
