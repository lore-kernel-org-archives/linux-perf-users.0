Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF322EEF;
	Wed,  9 Oct 2024 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457097; cv=none; b=Sy8iBWqoIGsN1O9NI/3va6C8ddynm8yu+h89JLD7YGwm8WYZMdL/Xa1FTikEf1GJ+sipQ3owoKIQKYXnCiKRsP20KJHdy3xvSNsksHxyVvLg3msrsc33GorJFwyL4/vtNyBO4kLsLtRotdJy9QSNrGnxtTW51zJIMLrVqH48En0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457097; c=relaxed/simple;
	bh=ql/fWeWI1jgC8wW0fy6T9DxyyWwRbdg6SAMaGKNQbns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTKWuzXFJFES6+UqJMFPLFo/Sc4IsrXm//TN/xteAeNhIT+t3JZde0n42BL3WJ9WrpBKTXvtUCBIT9n+qpAg87itlTYetjVX4jWfdYU3tlxlfrgkBF3MUBcOL529MNq7UqMyiUrTXtl9IFhKqdX5jphr3npwYwGn3iuAwiVtCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN8rcq1Y; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN8rcq1Y"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e25d405f255so5833609276.2;
        Tue, 08 Oct 2024 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728457095; x=1729061895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAA97Q8YAChfX+R7YbIHwoQSDhz78c5+kgJGyljOQFs=;
        b=XN8rcq1YZ0uAQgzlqE7dSt/CkFnjdEbntFGDpTwk2LRrcbVNXPgvhczzsB6ss11K2C
         80uhQz2F2LBzQBiXvgu3jSByjRnC2qrsoQqBPuiQwSbtLrC0ARhfDsRPQzOeLBJZKgK3
         MElmWu9Zrp6paAabgGXz/W27M/B8DaIBIL85m+KQoX5Zr6SoadUVQAF5u6Vm2sDcyejs
         g9zioA5cv4gibzYvdZSBb0+OjJXD12DZb0sSmqyv04vRxa4UwO1IUk8A3z4hYnTTCAi5
         is62/pMI6C+nHEhStNpck4Jw8SNTu6Vg6uG/wHKrMdc6vWj1QuIjOa46jeto2wNo9Qnf
         Pr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728457095; x=1729061895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAA97Q8YAChfX+R7YbIHwoQSDhz78c5+kgJGyljOQFs=;
        b=YEYBpTjwS2npoz2wi/+qdcukV9TFC2kH8BxffdGEK+GKrDHgs2jfGCorKaxQF8nAYk
         NXTN977oI4+qmTGl7iFyOthMGMzCAa0tLcEh2AmAmvJSU78a6KgTrNN4y1BD5vqoQU8t
         6qcf9HRsp/1IUM+ok+Ojvo30XsucktHUWhV/TMyc8d5RpK8QsWIuFFwD8M+Ls1IWA2UH
         giiT1dAv4PQ/TJPT5LxsgovVFMs/lLJPeH7t6Aj1aQp6ZXGTXoDs6eOwfzC9O2OSrI9P
         uMMeYOPqCy6gbA3YY5hCG2pSjo7hR+oGgvEWi/42bxuHPllkpx3VajI95fS01huvgQoM
         ycdA==
X-Forwarded-Encrypted: i=1; AJvYcCUglXEmXK2MnKIoZbTugrl92em570v+ih0VxFRmjWreQ5jBt1rO4VM8Dq0h+rL9aMMV8yxjoefUAixzTOQ=@vger.kernel.org, AJvYcCXZyq4oRIRHESQg7JE8gFBcztJQUMgfmqCDR+/UlgdN7kEv7e+VJA3+6ahHUvJh1W81+ZQIeoQG7+y0HE0DGUuRRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/MSZ6DkvQbcK88ruiGTvh27k/HQUQFslOKITbzO5ZBAQv/I5
	ytE8rhn7jLLLgCnLMFE/3yIThQzcCG2jJMCreHzUDkADTgz4Srj65uEFPtGbkm8pfsBoxshHv4x
	adv7XfP1g0584HIcXPN2YSUpVnhY=
X-Google-Smtp-Source: AGHT+IFBs8xuLyIyV2l2mW1UaxZgBx7jCZmFyYWRHm0k6JhiH0/KjlHtqTLCPow6z0EwCtpvXRo5johAEqJ/1DYtutI=
X-Received: by 2002:a05:6902:2d06:b0:e1d:c07b:a680 with SMTP id
 3f1490d57ef6-e28fe35481emr1090284276.22.1728457094201; Tue, 08 Oct 2024
 23:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com> <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
 <ZtJWEVn8-w07Wm0q@x1> <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1> <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org> <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
In-Reply-To: <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 8 Oct 2024 23:58:03 -0700
Message-ID: <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resending due to a mailing list error]

Hello Jiri,

If Namhyung's fix alone does not solve the problem please try this:

Thanks,
Howard

=3D=3D=3D=3D=3D=3D

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 7c15dec6900d..8dff317a3d79 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -46,6 +46,11 @@ static const char *const *syscalltbl_native =3D
syscalltbl_mips_n64;
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id =3D SYSCALLTBL_LOONGARCH_MAX_ID;
 static const char *const *syscalltbl_native =3D syscalltbl_loongarch;
+#else
+const int syscalltbl_native_max_id =3D 1;
+static const char *const syscalltbl_native[] =3D {
+       [0] =3D "unknown",
+};
 #endif

 struct syscall {
@@ -182,6 +187,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const
char *name)
         return audit_name_to_syscall(name, tbl->audit_machine);
 }

+int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
+{
+        return idx;
+}
+
 int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
                                   const char *syscall_glob
__maybe_unused, int *idx __maybe_unused)
 {

On Tue, Oct 8, 2024 at 11:54=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Jiri,
>
> If Namhyung's fix alone does not solve the problem please try this:
>
> Thanks,
> Howard
>
> =3D=3D=3D=3D=3D=3D
>
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 7c15dec6900d..8dff317a3d79 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native =3D syscal=
ltbl_mips_n64;
>  #include <asm/syscalls.c>
>  const int syscalltbl_native_max_id =3D SYSCALLTBL_LOONGARCH_MAX_ID;
>  static const char *const *syscalltbl_native =3D syscalltbl_loongarch;
> +#else
> +const int syscalltbl_native_max_id =3D 1;
> +static const char *const syscalltbl_native[] =3D {
> +       [0] =3D "unknown",
> +};
>  #endif
>
>  struct syscall {
> @@ -182,6 +187,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const cha=
r *name)
>          return audit_name_to_syscall(name, tbl->audit_machine);
>  }
>
> +int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx=
)
> +{
> +        return idx;
> +}
> +
>  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
>                                    const char *syscall_glob __maybe_unuse=
d, int *idx __maybe_unused)
>  {
>
> On Tue, Oct 8, 2024 at 10:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
>>
>> Hello,
>>
>> On Tue, Oct 08, 2024 at 11:09:31AM +0200, Jiri Slaby wrote:
>> > On 27. 09. 24, 7:09, Jiri Slaby wrote:
>> > > On 02. 09. 24, 20:54, Arnaldo Carvalho de Melo wrote:
>> > > > On Mon, Sep 02, 2024 at 07:25:17AM +0200, Jiri Slaby wrote:
>> > > > > On 31. 08. 24, 1:30, Arnaldo Carvalho de Melo wrote:
>> > > > > >   From 174899051e54ecdab06c07652a3d04ad000ab301 Mon Sep 17
>> > > > > > 00:00:00 2001
>> > > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> > > > > > Date: Fri, 30 Aug 2024 19:53:47 -0300
>> > > > > > Subject: [PATCH 1/1] perf tools: Build x86 32-bit syscall tabl=
e from
>> > > > > >    arch/x86/entry/syscalls/syscall_32.tbl
>> > > > > >
>> > > > > > To remove one more use of the audit libs and address a problem=
 reported
>> > > > > > with a recent change where a function isn't available when usi=
ng the
>> > > > > > audit libs method, that should really go away, this being one =
step in
>> > > > > > that direction.
>> > > > > >
>> > > > > > The script used to generate the 64-bit syscall table was alrea=
dy
>> > > > > > parametrized to generate for both 64-bit and 32-bit, so just u=
se it and
>> > > > > > wire the generated table to the syscalltbl.c routines.
>> > > > > >
>> > > > > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
>> > > > > > Suggested-by: Ian Rogers <irogers@google.com>
>> > > > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
>> > > > > > Cc: Howard Chu <howardchu95@gmail.com>
>> > > > > > Cc: Jiri Olsa <jolsa@kernel.org>
>> > > > > > Cc: Kan Liang <kan.liang@linux.intel.com>
>> > > > > > Cc: Namhyung Kim <namhyung@kernel.org>
>> > > > > > Link: https://lore.kernel.org/lkml/6fe63fa3-6c63-4b75-ac09-884=
d26f6fb95@kernel.org
>> > > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> > > > >
>> > > > > Tested-by: Jiri Slaby <jirislaby@kernel.org>
>> > > >
>> > > > Thanks a lot! Added to the cset.
>> > >
>> > > Oh, 32bit arm still affected:
>> > > /usr/lib/gcc/armv7hl-suse-linux-gnueabi/14/../../../../armv7hl-suse-=
linux-gnueabi/bin/ld: perf-in.o: in function `trace__init_syscalls_bpf_prog=
_array_maps':
>> > > tools/perf/builtin-trace.c:3461:(.text+0x899a0): undefined reference=
 to
>> > > `syscalltbl__id_at_idx'
>> >
>> > Ping -- any input/fix for this?
>>
>> As a quick fix, we may add a dummy syscall table for other archs like
>> below.  Can you please test this?
>>
>> Thanks,
>> Namhyung
>>
>> ---8<---
>> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
>> index 7c15dec6900d8aaa..b7465a879d8bf416 100644
>> --- a/tools/perf/util/syscalltbl.c
>> +++ b/tools/perf/util/syscalltbl.c
>> @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native =3D sysca=
lltbl_mips_n64;
>>  #include <asm/syscalls.c>
>>  const int syscalltbl_native_max_id =3D SYSCALLTBL_LOONGARCH_MAX_ID;
>>  static const char *const *syscalltbl_native =3D syscalltbl_loongarch;
>> +#else
>> +const int syscalltbl_native_max_id =3D 1;
>> +static const char *const syscalltbl_native[] =3D {
>> +       [0] =3D "unknown",
>> +};
>>  #endif
>>
>>  struct syscall {
>>
