Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBD1957E2
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325427; cv=none; b=R2eovrLEt9FOh+TmJ0KenhtB9VhEvVF2n5M79LxZATU28LTCXVTfPGv6gT3IfqWIRZS1FpBjez3097gofLJQLMqA4U9YzFxRWm0WpTCxGw/V775lMWAe33i1R6Ap0m6+A9zNcjnx5XbgzaA5qijDgnfT13bnQuWm4DrT+aNpnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325427; c=relaxed/simple;
	bh=FTQZUdfUptCa2bLgf3C1tX5NAj4o8RrqNfikG0Y/BmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCU+Z0KcXwmASzo3m43JuK7OEG4MYJi0hxbqL5ITP8XWLkE3UPTvmlR9mlEc/GAteqEUiIQgJ4hTU7yw5i3IR4FLyRdKJw0nDi1BVXSK/UiasecEnJGOn4YydJrM/oIeNYSu1W1WEy8bjdD2Yiv544zSle3Vvb3lyiNorIsDOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aS1r452c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aS1r452c"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so107075ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 21:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741325425; x=1741930225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdDEJTsHKwvjyl+F7qkE/MVBBT69xP0JtpsTNjb5e+Q=;
        b=aS1r452c/rW2K/CaWV7lAQ/OcTUf1157keb7CTdojRCHrnRqr+qkFb7MIU71Emeco8
         63SDP7mv1vIun9Jr2W3yLDYsyywlVfxKrihnvhn8BAH7+WVk+ytPrr21AuYgwQd/gOmG
         rKpcXNW1C0zlwg3hhuLATW3ED2VGj1AybEqejQ2kP9UK28FMsKHTqAsGuD6BTnJSNRXG
         a18coJARO4671xDwixiPK3+J5UUFpXo7/rVr3FVbAR/4islVrUCLzJGtH1PscmgKsLz2
         WmvytLUuuhK4uW/cZlZdT9Tm8Tsslq8L9Wtu/BoEjrGZkfLLCY8mCYcBg2v0ZC7qLJQ6
         m3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741325425; x=1741930225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdDEJTsHKwvjyl+F7qkE/MVBBT69xP0JtpsTNjb5e+Q=;
        b=vgS6SKP9I4Qmb36yf9H3yTWeRZXA+FdvaxR2OdUk4UCJmend+xFGIvg4ZhylVhqlu5
         cgnNtRNLxR7X+py3ZXRf9Qe5kwX56AuNfrIjXTBLkIfumNw4fwgCLROS7sj6L/ydgQ/b
         q6wQTwtqzd4LO5PWej7ueFUZEnnWDhl1MFAFSX/+S+rJVK+Tjo6zV0P/Uj08gvSD8/cy
         jTDStoVjXAOLTdAAiVB9RDT4j3ji3Qqq97vKopi9d8HVw0CaeSFUb/TxYq7mLDZ3psb0
         1rdOqSmESYwgciPNN0zSu9W56Yw/dSM/uq3WCKljn77ZOKIDREfNYQROUOXFTM233kRP
         wgUw==
X-Forwarded-Encrypted: i=1; AJvYcCVdDYzaeEbLafB0JTRoffX5Kk180W71N4Nuru50EhceNrJNgUImQ8Xdca0N+mCz9KsICipj9rgmDuPuP3mvdwGz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8iYIbd29JtNRh1/XN/MnoJxI7vsBGDwp3r1/SeRz2ygG4GZff
	xKXMI8wcR3suheKRa9XLMOU01PoEoE5kA8tQXaiOV6BLz01EjtcJrP33L8+Vj78qGYMTeNZX8TC
	fLpLjwJ3T8PI3x/exiQMCfc4tBN9eZEUHYrZ6
X-Gm-Gg: ASbGncvCuZ6Qn8Bf9gRlKGBewqHlnWUZFTOOqFc/XAa35AIpfqS7VqSZ/OYdeXAbbQO
	wDhnwF8skDhswXrvdnFezWuZ+PQO1isIRI8HXPPIo2+fZ8Szsbj4Eneba/XeEAwC2sHJGTSwByp
	Ez+1h8XbmUteFWchIv7Ozi0ulyqzA=
X-Google-Smtp-Source: AGHT+IEcodZzFnpZf8m9GKxcrOIuoYtTe9WlblycwKpr+zFPLDPbCwJqYAatYqYzvaFLYn5WJRIGjZXLMcuz4Nbng4s=
X-Received: by 2002:a17:902:d504:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-2242a6004b6mr1115105ad.9.1741325424567; Thu, 06 Mar 2025
 21:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com> <20250304050305.901167-7-irogers@google.com>
 <Z8pKTE7tOqdqNUdA@google.com>
In-Reply-To: <Z8pKTE7tOqdqNUdA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Mar 2025 21:30:13 -0800
X-Gm-Features: AQ5f1JqqAJ5MO97ObltKzRcURCg1d-Uko29NllBm3N5v0f7KDyGvXHVOjRAnU58
Message-ID: <CAP-5=fXdZZX=wa8EkN-dcpnDjA7J-cQ09BERufAQzoBeoNCT1g@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] perf dso: Add support for reading the e_machine
 type for a dso
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 5:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Mar 03, 2025 at 09:03:00PM -0800, Ian Rogers wrote:
> > For ELF file dsos read the e_machine from the ELF header. For kernel
> > types assume the e_machine matches the perf tool. In other cases
> > return EM_NONE.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/dso.c | 54 +++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/dso.h |  1 +
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 5c6e85fdae0d..7f2f1af4f73b 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -1170,6 +1170,60 @@ ssize_t dso__data_read_offset(struct dso *dso, s=
truct machine *machine,
> >       return data_read_write_offset(dso, machine, offset, data, size, t=
rue);
> >  }
> >
> > +uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
> > +{
> > +     uint16_t e_machine =3D EM_NONE;
> > +     int fd;
> > +
> > +     switch (dso__binary_type(dso)) {
> > +     case DSO_BINARY_TYPE__KALLSYMS:
> > +     case DSO_BINARY_TYPE__GUEST_KALLSYMS:
> > +     case DSO_BINARY_TYPE__VMLINUX:
> > +     case DSO_BINARY_TYPE__GUEST_VMLINUX:
> > +     case DSO_BINARY_TYPE__GUEST_KMODULE:
> > +     case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
> > +     case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
> > +     case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
> > +     case DSO_BINARY_TYPE__KCORE:
> > +     case DSO_BINARY_TYPE__GUEST_KCORE:
> > +     case DSO_BINARY_TYPE__BPF_PROG_INFO:
> > +     case DSO_BINARY_TYPE__BPF_IMAGE:
> > +     case DSO_BINARY_TYPE__OOL:
> > +     case DSO_BINARY_TYPE__JAVA_JIT:
>
> I think some of them can be possible in recorded data.  But let's go
> simple with EM_HOST as we haven't supported cross-arch trace.

I think you are agreeing with the code, which I think is right :-) I
don't know a way to go from say /proc/kallsyms text file to an
e_machine number and inventing a way is getting beyond the scope of
this series.

> > +             return EM_HOST;
> > +     case DSO_BINARY_TYPE__DEBUGLINK:
> > +     case DSO_BINARY_TYPE__BUILD_ID_CACHE:
> > +     case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
> > +     case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
> > +     case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
> > +     case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
> > +     case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
> > +     case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
> > +     case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
> > +             break;
> > +     case DSO_BINARY_TYPE__NOT_FOUND:
> > +     default:
> > +             return EM_NONE;
> > +     }
> > +
> > +     pthread_mutex_lock(&dso__data_open_lock);
>
> Hmm.. I'm afraid it'd slow down perf trace a bit more.  It sees
> occasional LOST events.  But it may be ok as it's cached in thread later.

Agreed, I think the caching will handle this. The lock is pre-existing
and is used to guard use of the dso_data->fd. The lock could be made
reader-writer, it could be placed within the dso_data it could also be
sharded. I've not done any of that here as I believe the processing is
all handled on a single thread anyway.

> > +
> > +     /*
> > +      * dso__data(dso)->fd might be closed if other thread opened anot=
her
> > +      * file (dso) due to open file limit (RLIMIT_NOFILE).
> > +      */
> > +     try_to_open_dso(dso, machine);
> > +     fd =3D dso__data(dso)->fd;
> > +     if (fd >=3D 0) {
> > +             _Static_assert(offsetof(Elf32_Ehdr, e_machine) =3D=3D 18,=
 "Unexpected offset");
> > +             _Static_assert(offsetof(Elf64_Ehdr, e_machine) =3D=3D 18,=
 "Unexpected offset");
> > +             if (pread(fd, &e_machine, sizeof(e_machine), 18) !=3D siz=
eof(e_machine))
>
> I think it needs to check the endianess and swap the data.

Agreed. Will send a fix in v5.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                     e_machine =3D EM_NONE;
> > +     }
> > +     pthread_mutex_unlock(&dso__data_open_lock);
> > +     return e_machine;
> > +}
> > +
> >  /**
> >   * dso__data_read_addr - Read data from dso address
> >   * @dso: dso object
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index f3ca2a5e7670..ba9b83db061a 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -818,6 +818,7 @@ int dso__data_file_size(struct dso *dso, struct mac=
hine *machine);
> >  off_t dso__data_size(struct dso *dso, struct machine *machine);
> >  ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine=
,
> >                             u64 offset, u8 *data, ssize_t size);
> > +uint16_t dso__e_machine(struct dso *dso, struct machine *machine);
> >  ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
> >                           struct machine *machine, u64 addr,
> >                           u8 *data, ssize_t size);
> > --
> > 2.48.1.711.g2feabab25a-goog
> >
