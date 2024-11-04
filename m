Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B71D5CC2
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757822; cv=none; b=llcHEvQ4MStTigxq0PYpa9mCY0sXVfUpDjMZPr5wOkwrdzEY/E4p3RGtlXdMts5o2RHytLFjWv26kbQLWLvm5hqjxxfXJRjKQCUcYKkUZwOjRjFbCLYQv3B0a+QBr046qEXxBASso666B+u0Qr21w32z6b6NUznFunHivq1JEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757822; c=relaxed/simple;
	bh=FwdJ/tZnq5Q1ZNjaalXxz9pm9mHtJsnsrILgdEWNMTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtapH9VJOyYMQtTUh+H/66v20H7n14bcYWaNabXuZtjhUYMizcOBQiS4U6LD2riQGXL0fIciJMhiCKIxVwsN68HuFcM4x6z0pa1sJEmwHAcX9vFCmMWuyOVmrIb1FJCORAxvW20+bMy0Jtq4vkW0TWZmdmB989CoR1blgDtM5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dXWibLQp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXWibLQp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c87b0332cso27265ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 14:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730757820; x=1731362620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwdJ/tZnq5Q1ZNjaalXxz9pm9mHtJsnsrILgdEWNMTI=;
        b=dXWibLQpNrIWrk0HRxsj0Sj29SkxNk7/doQpfI212XJNwtsrHMzl61g/geVopl2R1x
         flj1ceS6uTShJF9f/mdhwjzmuyk35lb08eLtTfkHbElqOyIF0KKiKMp/gRFAPoyA0BUX
         hyxrEvsPMHmAZTs5jIZ9Jehwy43mt1xnV83TjkZZq125rdhjFR/07hpJQmrlzIn1CR2C
         aw5ASygB8cHqXPC3udkXaRpqvMwSFA+VYnL52Fq5ZDyYSRqiwi2CcafJW2dL1DPbp5Uw
         fPOGY03xMMuRsQRrL5LsVu8efP8xkJnCYjJeYej05xGFa0HBoBgSFZcETtfz9XxlIuiu
         1mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757820; x=1731362620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwdJ/tZnq5Q1ZNjaalXxz9pm9mHtJsnsrILgdEWNMTI=;
        b=FwBHV/L01NZ2a3k+r7RfV+zy4y0NW1MGYi2Siu5/ljyT8dRfR78G57QiPZWleRCsOE
         P1GxTD591MdlSNhw09qmqVsAA8mHV8xJJuGcNiWuY9R4sDXP+2uDk4GrBiw/jRjsjmi7
         5X3vm/zH/XQzlHTlPoxU2Mu+p4mBt+jSEUnZYC6d+VNGSaWMZm/TCo7AM0ZvWkgHfKby
         Dye+Kg89yaWtP2BPDdCd/UtvroKFAzakAJud3/c2k3WwUkxMTaSlJwcnOWy8PwH0o/65
         Cgl8ENVcjI55oVTisaU/U8WIcM3kMX+ik+/YjDh2RnNoOhxemaK0GyjeeX2maORmq++x
         EQqA==
X-Forwarded-Encrypted: i=1; AJvYcCVp7iIbI1MuYQEvXjHbwiM2toWiIdof/S1MoHefGhaqyukKiJUpjFb1s4Bnz8bam1PFx8xELB9EfiarV4TPNQLU@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzhfxqJmaOyyMGcaHAekWxp6cQfKK9R0PRH+mfSP9lY0TNpSa
	Vy1Ah/ms6cuLki53cMucgsIMVduIOD46aAYDfwLXMU6lTeOvs0F7rmTJWHPnYdHaEG2hhA9G7Vr
	IJGU0CR1FPg62TfJNbjGLLSRtO6dkuNj9C8CU
X-Gm-Gg: ASbGnctOr9fOBhYa76S5nrWqoybKcisEPBFx6HCHUSMvK+ZYalgFirB2za8GeKw+oV0
	I0KB2OlNyWMpE7og/81VAJmL+Suvivec0wg+0GBZnwfZ7teZ3cItS7pGtzMQjopY=
X-Google-Smtp-Source: AGHT+IEti60SDL7RHxI+cAhb1vGKCJSZIYIvkK03gIl3UEiSV24cOOJW04C/9MY0z0qdxUSpneeeMi3ERfOoxdjdYyo=
X-Received: by 2002:a17:902:c401:b0:206:b7b2:4876 with SMTP id
 d9443c01a7336-2115e2cb7c5mr1245345ad.20.1730757819913; Mon, 04 Nov 2024
 14:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
 <3b56fc50-4c6c-4520-adba-461797a3b5ec@app.fastmail.com> <Zyk9hX8CB_2rbWsi@ghost>
In-Reply-To: <Zyk9hX8CB_2rbWsi@ghost>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 14:03:28 -0800
Message-ID: <CAP-5=fUdZRbCp+2ghEUdp+qJ1BuMDuTtw9R+dFAaom+3oqQV_g@mail.gmail.com>
Subject: Re: [PATCH RFT 00/16] perf tools: Use generic syscall scripts for all archs
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, guoren <guoren@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:32=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Mon, Nov 04, 2024 at 10:13:18PM +0100, Arnd Bergmann wrote:
> > On Mon, Nov 4, 2024, at 22:06, Charlie Jenkins wrote:
> > > Standardize the generation of syscall headers around syscall tables.
> > > Previously each architecture independently selected how syscall heade=
rs
> > > would be generated, or would not define a way and fallback onto
> > > libaudit. Convert all architectures to use a standard syscall header
> > > generation script and allow each architecture to override the syscall
> > > table to use if they do not use the generic table.
> > >
> > > As a result of these changes, no architecture will require libaudit, =
and
> > > so the fallback case of using libaudit is removed by this series.
> > >
> > > Testing:
> > >
> > > I have tested that the syscall mappings of id to name generation work=
s
> > > as expected for every architecture, but I have only validated that pe=
rf
> > > trace compiles and runs as expected on riscv, arm64, and x86_64.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >
> > Thanks for doing this, I had plans to do this myself, but hadn't
> > completed that bit so far. I'm travelling at the moment, so I'm
> > not sure I have time to look at it in enough detail this week.
> >
> > One problem I ran into doing this previously was the incompatible
> > format of the tables for x86 and s390, which have conflicting
> > interpretations of what the '-' character means. It's possible
> > that this is only really relevant for the in-kernel table,
> > not the version in tools.
> >
>
> I don't think that is an issue for this usecase because the only
> information that is taken from the syscall table is the number and the
> name of the syscall. '-' doesn't appear in either of these columns!

This is cool stuff. An area that may not be immediately apparent for
improvement is that the x86-64 build only has access to the 64-bit
syscall table. Perhaps all the syscall tables should always be built
and then at runtime the architecture of the perf.data file, etc. used
to choose the appropriate one. The cleanup to add an ELF host #define
could help with this:
https://lore.kernel.org/linux-perf-users/20241017002520.59124-1-irogers@goo=
gle.com/

Ultimately I'd like to see less arch code as it inherently makes cross
platform worker harder. That doesn't impact this work which I'm happy
to review.

Thanks,
Ian
