Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660E1C57AF
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790486; cv=none; b=OXk19HUs60U7j1mFbnoN1A1MLiztJ/noxraiM5YRpEJqe3Zu9kn/vQ6ZG9vWrGADIFm5rzxvUaoo9sxIGv27knxD8H7cW97/O9xm6v0YGBVEgLLyFkaAuCYnlZUpD90MrFg4X1fIFeHRYaljCMGPPshKYDcrkw5QtgqW/PuOzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790486; c=relaxed/simple;
	bh=VBfR5RGCxYvDVnaZw3yZHjceCxtFgqrGl2sgt68H6a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuQ69LVuXHmojbTqkBcQHsMg4LybE+ipPhZt2KjP5qEleD87mLlRrVgiLdK+IjVDPlEm42NZdBme2HUw0xPiFFQ9Oj1YlJC5rOVTGuYKl8Rxh7F1okehrBuUZ7l6jxnVlk23Gb86zNm46liOU9aPu2sNE9qE5+hoXK/5Cd4kH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niuESLKc; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niuESLKc"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so187855ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727790483; x=1728395283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyYOwe+oIK+4XoImh5QZzALV7XjBetmQRKUG8lYnfSA=;
        b=niuESLKcFAVKg9q0GbSb9Fho8lR6TgXWkhAUN+PKYSyLB+WRLNNVehkfceGLo6oZvY
         7sRZ+dIP+8B0y2F2ngGT65mX8zSSn5KmrDdJXZvwZS1eGobfSOGo/+puFvUHYhiA09TA
         o1K9ZIbpo/yvnmzLzBm/OS7514sYzO60Ld5kdduJvh1qpf+UML2XVK697UsfZVVB94yd
         fuvEZmTOJE8XqkbC/exyoPKyOFiJNVYRe5vsYl5gQLZTTDPi2fP7qxicAUjCf3Sg3x5V
         ecoMbhJapyVEVzA/ZpOqCD0igjjG9Mwfznb4ejRWddD8V0ZaeSuM+LdhjfeGRDTq5dYE
         8+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790483; x=1728395283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyYOwe+oIK+4XoImh5QZzALV7XjBetmQRKUG8lYnfSA=;
        b=IEjjKhp5YlTFQirVR7GodKxyHUKerEeodNc1hVaQEUoutzhJIYPaJE/Z4TnA8llguo
         g3HMLhnZXQMCfWoxcCYSKYw0Ll/WQ8cfT5EYG7Hej6oRoqGv4aU6HWiZr/l18ddZqNQN
         YCC9jHiAIcNTphlYtq27Vkx4GlTWmL1g38F28Pgu/l0QfGSEwrJGYgBvwq3G6jAVPztX
         qRR3o5dCRp94hlblCzgVoyM7YiN+G1BTBVrkN0wDIbGYEnFh/EuXjzanKpRACT7YQu7n
         BKGtAs4otx3/SWe3AwbmJ26jXYNcv5/oH+oEPlToNVGbKhzkZ3WGcbuzcXxK3OjaorDW
         GC6g==
X-Forwarded-Encrypted: i=1; AJvYcCUFBy4jMduSWmPhaubLLzlWQ6EGP08F1wgkwE0PzqTL/sm21GeB4J/STc/h5LvKcN8BJQMbb0JVZYbXrj2bcUyX@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWhQOjxaT5G9aEX27LhBqbojUwzvy1dnh+b5ThFL91OjKgRQt
	xle5yQZs2BARAUx8cgXYBQVZgz87Nkx9YMiCwjtEvrChu0+/PgDlAObImwJWeyjfOaCOzGDyHwd
	iWMhSZ7dtV3Gxt8nrdKQmrGMw6M0Nbc/9lokfMEPxf7IJB3/mbTbtyj4=
X-Google-Smtp-Source: AGHT+IF1Iuzr+SztbvYX/Mp9ErppoEvUjl+A8DZuMAX46MBvZG0UgA9ExOTmzL3yvJiwHooxYb91wjIEONZ1vAVJViA=
X-Received: by 2002:a05:6e02:152a:b0:3a0:9cb6:cb with SMTP id
 e9e14a558f8ab-3a360833555mr3108005ab.7.1727790482650; Tue, 01 Oct 2024
 06:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918225418.166717-1-irogers@google.com> <20240918225418.166717-2-irogers@google.com>
 <Zut-iM3v9rJHehxJ@tassilo> <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>
 <ZvsXl2g6kYDi6F9o@google.com> <ZvvbiY1NjTZxWvG7@tassilo>
In-Reply-To: <ZvvbiY1NjTZxWvG7@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 06:47:47 -0700
Message-ID: <CAP-5=fV-_MkAjnB-2C7m=ENRknorJx4TZ6p4GWp56ySXoFO3-Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
To: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:22=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> On Mon, Sep 30, 2024 at 02:26:47PM -0700, Namhyung Kim wrote:
> > On Thu, Sep 19, 2024 at 06:45:23AM +0200, Ian Rogers wrote:
> > > On Thu, Sep 19, 2024 at 3:29=E2=80=AFAM Andi Kleen <ak@linux.intel.co=
m> wrote:
> > > >
> > > > On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
> > > > > Python2 was deprecated 4 years ago, remove support and workaround=
s.
> > > >
> > > > Nacked-by: Andi Kleen
> > > >
> > > > I don't see any advantages of breaking perfectly fine existing setu=
ps
> > > > for no benefits.
> >
> > Well, I think the benefit is in the maintenance.  The EOL of Python 2
> > was 2020/1/1 [1] and we are targeting this release (v6.13) in 2025.  So
>
> AFAIK it's still widely used, and supported by third parties. And even
> if not it's not that the python usage in perf needs any external support.
>
> In Linux deprecation is generally tied to nobody using something
> anymore, and that is clearly not the case here.
>
> > I think it's reasonable to consider removing Python 2 support now.
>
> That's code that practically never changes, so I don't see any
> maintenance benefit. I mean it needs to be compile tested / perf tested,
> but Arnaldo's container collection will do that practically
> for free.

So of the Linux distributions that supported Python 2, the versions
that did stopped being supported in June this year.
The hypothetical person who cares about python 2 support needs to be
building their own kernel tree, they've had to upgrade GCC, etc. but
GCC isn't particularly relevant here.
The hypothetical person wants to build on their unsupported
distribution the latest and greatest perf tool. Now the perf build has
required python 3.6 for json events for 2.5 years. So this
hypothetical person who wants the latest perf tool on their
unsupported system must not care about json events and metrics but
does care about python 2 integration for scripting.
I really don't see such a person existing and if they did they can:
1) install python3
2) use an older perf tool

There is a constant cost in the code base trying to know whether
python means 2 or 3. Keeping dead code around at the very least
creates poor code coverage numbers. We want to add to the python entry
points into the code with parse_events. We want to make python a
dlopen dependency (as done in uftrace) rather than something that's
linked against. In other words python development is somewhat active
and trying to carry around python 2 support when no one we can name
wants it is just burdening us down, costing us in time and code
coverage for no gain.

Thanks,
Ian
