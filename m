Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF51D63D2
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290750; cv=none; b=TwMuQaaIKRxttuD9bndWsKKQOcYCmiI4NoYWN4e3PDxrvFcx6dT0dL2BmNe4ZcoZQwVhCzaJw3OYZZg/ZnUnNmNz5Mx6/UCsGrVetHkCuH91rsYPSrriXD2tloFHaB3HNSEFp2Zl52UXrdaYLJQYrr0l2ekvr8ApVXTEZIjWsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290750; c=relaxed/simple;
	bh=ClIVXb1x+2dZfzmgI0PvHc3Nl/BWDi3XQGQRYx+Me5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBYbDnuyEg31a9kcLyedl5zjTMDm8lmlaoGlYIo14fpFQeVv0H7J+OWbmqyCgYx9NiSmML/i1ujhCEMpZi9r6C9P/iSVMXQPCmcl8b6CeZoGALhEXdlwU9u92nJXiX/hx7jiYGmwQmZtJSZnOfXw/Ohrem7KvzbMtV6jWjXCf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nu7MCfNz; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu7MCfNz"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so177405ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739290747; x=1739895547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPuoFgyUqShqiHXq7m4WJY26nDOJr72a7sYiaqDAkZ8=;
        b=Nu7MCfNza5gHONz9k5muMcFxcI09J+wweV2B3XUUFmLFX6J2XqJsuw/tRhkOczDw4A
         KwM2Rgg6ZT+U4S5shFHuk8eFfc0wYMEVHf8hcK5isY0teIBz9Ru8z6pp5YVj2iiFSqqj
         wjqi4EBC/yyPqpl0v00gYT1oYO1PTn0sLIUhpLMKD2YwbJzHkdAKZaCKULe68ZNdIAur
         2lcUfv65b5Kk1TWKdZj0OHwv0kK2N4N8zJviqN2YvliveGNjydkRUlap/Y5SZVU6GInh
         /dL5RNBzlbYEzgXhIbZYdy97YIeyL1Hyd8k0c8QWaNqyi43xWUQNpc2AMLcXNa7NArKY
         931g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290747; x=1739895547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPuoFgyUqShqiHXq7m4WJY26nDOJr72a7sYiaqDAkZ8=;
        b=GPFlGsF9BSvsQrWoAT2kv7qCRxWT1qCm6jB/39Gzm+d1VkguRHahcMmK3HmT2ZK4L8
         weWefY9iu/OcIJuRxqhjgOaAeoKX9/50zXkNDzdMy3pFC8zFtyJIJ98nmelGtOpN395P
         1P4jDvviH9/GTUxJxDhK9ta2ZI8SyX7fneLBKwqNhLtR69LH+EvgvejgDMj+FxcDaZM9
         lb7De+n1W1sPUOkPu5LokvTZ34irbWvkXgTJnHM1x9dQOokiM6B+4MpAUmkl+D1eDFjJ
         MV/JaDTISfj/C3/96FGfcTjmlx/qST3qNoCA4Mzb6jmILZkCiwKyqKYWdfVcz5wOpHa0
         X37g==
X-Forwarded-Encrypted: i=1; AJvYcCVjZfJVklqD6dVKK1ZN/qS5uL5TMqxsGGNM9PPHV6a2I9kVTBM//6D11mBg+c9IDY03csRvcvtJ7TwHZ4Ei9yNl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzei+6PF/2Urr2JdS95TwtycmAjKxLjy8gGgWtFf+ZkUy7qyFyJ
	n+k/2wgyqOAEHJvJyF6dAQwVeuRvDS9poAbUQXtKXXAk4HB474U2zCVK7MQ6dASImvG42wkbVL4
	8bEvsxzNQWvH9DZNoqkuxEpxC9wkwtvqJF4Sl
X-Gm-Gg: ASbGncuK/60qhYIcfjf7tc4vWJtxgvkjRBsyT6KCyenwZ5UIfUATz6PmLHDkRrjJlt5
	yeUWG/m0jJKvbJoV6AaNJEUyrixOQJb7YRjnLxe7QCy0LGa94sFS9wLANDddb0rWZe72XJ4Z1FT
	xpbvJl/8coKnC18qTMj68aWSRr
X-Google-Smtp-Source: AGHT+IGBRJUYM7eB7GRcv7zbcCLNqRmCzTZKJzAh5FAel3+2vWVb9N+g6mOuPoRoTCDTrgVk0gX8MyeGCqZ63HpU/Co=
X-Received: by 2002:a05:6e02:1848:b0:3a7:df79:71b3 with SMTP id
 e9e14a558f8ab-3d171e30ba1mr3350285ab.19.1739290746485; Tue, 11 Feb 2025
 08:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210165108.95894-1-irogers@google.com> <20250210165108.95894-4-irogers@google.com>
 <07c5c3ad-5a6d-4eda-95f2-ed16e7504d4c@app.fastmail.com>
In-Reply-To: <07c5c3ad-5a6d-4eda-95f2-ed16e7504d4c@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 08:18:54 -0800
X-Gm-Features: AWEUYZnsI21FqO05tMc19ZFoLQwRQjxl2-W2xUAqGcaU1HeGa3Km7KpVudfKIf8
Message-ID: <CAP-5=fV0AVEp1uEtKjAqOmwqKSRuUzTwrXnBiqc=Lopfj4hBSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] perf syscalltbl: Remove struct syscalltbl
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Mon, Feb 10, 2025, at 17:51, Ian Rogers wrote:
> > The syscalltbl held entries of system call name and number pairs,
> > generated from a native syscalltbl at start up. As there are gaps in
> > the system call number there is a notion of index into the
> > table. Going forward we want the system call table to be identifiable
> > by a machine type, for example, i386 vs x86-64. Change the interface
> > to the syscalltbl so (1) a (currently unused machine type of EM_HOST)
> > is passed (2) the index to syscall number and system call name mapping
> > is computed at build time.
> >
> > Two tables are used for this, an array of system call number to name,
> > an array of system call numbers sorted by the system call name. The
> > sorted array doesn't store strings in part to save memory and
> > relocations. The index notion is carried forward and is an index into
> > the sorted array of system call numbers, the data structures are
> > opaque (held only in syscalltbl.c), and so the number of indices for a
> > machine type is exposed as a new API.
> >
> > The arrays are computed in the syscalltbl.sh script and so no start-up
> > time computation and storage is necessary.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
>
> Your changes look fine to me, but I noticed one part that may
> be wrong before and after your patch:
>
> >
> > -const int syscalltbl_native_max_id =3D SYSCALLTBL_MAX_ID;
> > -static const char *const *syscalltbl_native =3D syscalltbl;
> > +const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> > +{
> > +     if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
> > +             return syscall_num_to_name[id];
> > +     return NULL;
> > +}
>
> The syscall numbers on mips (and previously on ia64) are offset by
> a large number depending on the ABI (o32/n32/n64). I assume what
> we want here is to have the small numbers without the offset in
> syscall_num_to_name[], but that requires adding the offset during
> the lookup. Can you check if this is handled correctly?

Thanks Arnd! I agree the tables are large and can be sparse, they'll
also be full of relocations. MIPS doesn't look like an outlier to me
here:
```
#if defined(ALL_SYSCALLTBL) || defined(__mips__)
static const char *const syscall_num_to_name_EM_MIPS[] =3D {
       [0] =3D "read",
       [1] =3D "write",
       [2] =3D "open",
...
        [465] =3D "listxattrat",
        [466] =3D "removexattrat",
};
```
For contrast x86:
```
#if defined(ALL_SYSCALLTBL) || defined(__i386__) || defined(__x86_64__)
static const char *const syscall_num_to_name_EM_386[] =3D {
        [0] =3D "restart_syscall",
        [1] =3D "exit",
        [2] =3D "fork",
...
        [464] =3D "getxattrat",
        [465] =3D "listxattrat",
        [466] =3D "removexattrat",
};
```
Looking through the tables I see alpha having the highest number
syscall with 572 being mseal.

I don't think this is great but in the current code (on x86-64) we
have in arch/x86/include/generated/asm/syscalls_64.h:
```
static const char *const syscalltbl[] =3D {
       [0] =3D "read",
       [1] =3D "write",
       [2] =3D "open",
...
        [465] =3D "listxattrat",
        [466] =3D "removexattrat",
};
#define SYSCALLTBL_MAX_ID 466
```
So the change is carrying forward a bad behavior, the table is still
only around 4kb. We could be more aggressive in compressing the
strings and pointers, for example how we compress the perf events and
metrics. I think it is getting out-of-scope here as that logic is
written in python, with the aid of lots of dictionaries, whilst this
code is currently a shell script. It becomes more of an issue if we
enable all of the tables in the build at once.

Thanks,
Ian
