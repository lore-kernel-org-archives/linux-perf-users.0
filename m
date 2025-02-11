Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352B261566
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295164; cv=none; b=K0A3M3O2vgEF0dwHa9wCTFM1EOaJ7d0cIBxaDjDMiSa6/B74xwuZ963RzG1okbpLLFjI9VzsCE0D73Gxw1S3Oox3/1mkITOF9ZfASNosjWUFNxWi0/v1x/jOoYI3X+QBlF1AdrB5cQib9DMpVs2jRjoDfYZZ23ABkhLuCQQSkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295164; c=relaxed/simple;
	bh=9VqB6kDe0g1j1EVbwpnZoUYoSv7oUR+TG+IB45BlCtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7nUe0RRRlyoeQfVaboKCUBKq61LVREKUyKU6ZZd2SLXyYmY4DNK6veeL0H+NQQOgT+MuY/RyJyPt9KKnydBTJcJjIZUpnKlAGoRwR4ApLbFGBqtuRrxcL5cEDziWLJYoHPUsZxz9viWqAr4LCBvT4dbNSbdxPNAhh9tJPVGXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQ5ESFzW; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQ5ESFzW"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d05815e89dso179945ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739295162; x=1739899962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wQ94efDGzeP+hPazDVZ0s87mMmIX0OkL74nPRKdj5c=;
        b=vQ5ESFzWQCcv9rLjyZII8Mr5BFQQo1aJWFXvDtGYivKE4O1bJWCDt2vDkUGPg88r1C
         TnRfmNfhjuJFWYKQmrt2nyrvcGEvofx4BtIkT5kTg3pr5L35D/TgAjuDEO0mzH4FJQ7/
         jHA9bBurxhCx4CUK/MlHPdK1TcOo5otUqreYAOyhZ/WJZPO4n/CXH/9ouSlImTgHj3ez
         KfiNRG04JxI8A0qCpcF8o3Q8wXsBOQabOHbppH94M9nrsqi8u+4pPTQbi5hNBymhx30U
         1asM/XLEwrUN1Er9tQbe2WmZ4wBoEogJcKHru8SuEQu6Lhebx2vFFMgAXVEIuLNxMLLs
         yJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295162; x=1739899962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wQ94efDGzeP+hPazDVZ0s87mMmIX0OkL74nPRKdj5c=;
        b=gtisQMfGGZyzdA7lArrZoV+kRyUAC62CimRHx08YqL5Xd9JjhHC4ut4RPrsy4tIhwo
         QGgsgxVKxRvzTSkBa3lrrzP+wrjYN+ChZhKSIrQCi/WrqzZib6s3OfXTwlOSSAK764e6
         lngAT8Qf1xxEU2nvaO86MStx5UVHtQhtIUL7SrCXwCOx9U9fnaHlfLL/O/hqX4JSze8i
         4L1sdKdC49xjDBBQ3AgNSQzpyOrVtNOTYr6pIAUPQZZdlZQ9vDyjFXPjrKLPOPeBFmx1
         5K7yORFVQq7BUWj3ojUYEBOy1C3ainWsdQwF8xVVzIUQPpPaRqMAD9UOAH0p8jAUWhBR
         j8Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU3PBUT8TperXNVM40XP4DmGAtSDKUu9lpHXvG9WAX8qfbWZppGa3BklMUvorToT8UztI5QLfBc8U3EpObUX6i1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RbND/iItiIWI3tnEbDK8K+dJbXRMt3TkvcaHculhAERM2FDA
	CN5ZY3GIDbAirMLqiOpM/cMX6Pmno5bX/aq/D8yMH2uSg3BE1G5u/d6upkU6ngzNd+srlUauGuN
	bCCptPNecvS0hQrQaKxjHrrE2he7jvynA6fDn
X-Gm-Gg: ASbGncs4jgK8VMbU0XyJ7+ONQqVafpwYncJxJ54zOLCF2JcGy7PMrAiT21Rsi3rCdhl
	bn/y7+OJ0TAIweA912Z7fSkQ0k0QqyFkMpGiLiDBfN80Z7VCdyNCQNxocg//GiJ0PQjJGB45iq0
	UKGKzQ5SPE5IcLVhd/3tSYHTw5
X-Google-Smtp-Source: AGHT+IFx7gQLpljuW0IlQHJkC2sPOgwjKNSe/p6Gvj27OoKy/WP45l1TbYOsmf4dkw4zbjr78o/5BoHNMYA6pqf60WY=
X-Received: by 2002:a92:c848:0:b0:3d1:7959:1793 with SMTP id
 e9e14a558f8ab-3d179591827mr1211895ab.25.1739295161966; Tue, 11 Feb 2025
 09:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210165108.95894-1-irogers@google.com> <20250210165108.95894-4-irogers@google.com>
 <07c5c3ad-5a6d-4eda-95f2-ed16e7504d4c@app.fastmail.com> <CAP-5=fV0AVEp1uEtKjAqOmwqKSRuUzTwrXnBiqc=Lopfj4hBSA@mail.gmail.com>
 <8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com>
In-Reply-To: <8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 09:32:30 -0800
X-Gm-Features: AWEUYZkcknJc_ecEWZmGNLleCOMX5hjRpYX4QmTXwPuP9BwndmjrpXk_kZmIMOQ
Message-ID: <CAP-5=fWjJbg_q3xN0iytcqdBzSuRX+PD7CKp9+rHvFxB1VYxhw@mail.gmail.com>
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

On Tue, Feb 11, 2025 at 8:34=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Feb 11, 2025, at 17:18, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 11:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>
> >> The syscall numbers on mips (and previously on ia64) are offset by
> >> a large number depending on the ABI (o32/n32/n64). I assume what
> >> we want here is to have the small numbers without the offset in
> >> syscall_num_to_name[], but that requires adding the offset during
> >> the lookup. Can you check if this is handled correctly?
> >
> > Thanks Arnd! I agree the tables are large and can be sparse, they'll
> > also be full of relocations. MIPS doesn't look like an outlier to me
> > here:
>
> Sorry, I should have been clearer what I meant, see
> arch/mips/include/uapi/asm/unistd.h:
>
> #if _MIPS_SIM =3D=3D _MIPS_SIM_NABI32
> #define __NR_Linux      6000
> #include <asm/unistd_n32.h>
> #endif
>
> and
> arch/mips/include/generated/uapi/asm/unistd_n32.h
>
> #define __NR_read (__NR_Linux + 0)
> #define __NR_write (__NR_Linux + 1)
> #define __NR_open (__NR_Linux + 2)
>
> These offsets are 4000/5000/6000 respectively.
>
> > ```
> > #if defined(ALL_SYSCALLTBL) || defined(__mips__)
> > static const char *const syscall_num_to_name_EM_MIPS[] =3D {
> >        [0] =3D "read",
> >        [1] =3D "write",
> >        [2] =3D "open",
> > ...
> >         [465] =3D "listxattrat",
> >         [466] =3D "removexattrat",
> > };
>
> This means the array is not sparse, but the numbers
> here do not match the syscall number argument register.
>
> The question is whether tracing on mips adds the same
> per-ABI offset again, or if it tries and fails to look
> up index 6002 for 'open'.

Thanks for clarifying. I believe it will use 6002 and be broken. I
believe that'd be true without these changes too. I'm not testing on
MIPS so it'd be nice to have a fix targeted at making it work. Ideally
we wouldn't use __NR_Linux and instead fudge the id/system call number
based on e_machine/e_flags. I think it is follow on work, especially
because I don't find MIPS a very motivating use-case.

Thanks,
Ian
