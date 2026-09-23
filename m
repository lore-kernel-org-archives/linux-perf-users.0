Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A046EF92
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195645; cv=pass; b=S9l5+q4C8sgwGWtCNkNw8AxgHLLO6XXaJaFHtic90q8a7pLNT9NziyMvxkK6U9GUqybW7wAGKuETxl93l4VlNwte42D1RhUj3xNuWlufiZu7C0iHAhrXV+aXeEBJOmROfcoY2jj/rXSw+k+ZK0e3nQPYV7cLaYOlZqByIiDXRBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195645; c=relaxed/simple;
	bh=x2KsbWxNcXzDGrxUjPtXA6JMUYxlGrwEtnlKXN9TOj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+n7kY94lcI7PBYJ8qUMLJdJPM65NzH1b+04GX2drGCGC7SjT0mXdqFw6EqN0HTzmEmOM3D0zKvs2Y/UQ4iN8HAHsTAch6Zv/KqPtJ2Rx/a/idAKcyy/C1P8JZFNQ9tCYAhyDJnZaE8kx6aeNdti6VkiIZcRF8zohy7shzqaF0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSzf5flg; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSzf5flg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so5045ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 13:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790195642; cv=none;
        d=google.com; s=arc-20260327;
        b=qsGQub813a2LixiKcZ3+p4339EzUNM9lxSr0tonBaFF6IZSgoaRXNjJHbgZHy+CsZN
         0jtL73GE12DTqEzuKImMSpreB2qMDnpEi6NvRyQxDzzjtZB5PUlV0cuyT1GaXABgYGzd
         LyJ81ZauFkon9yss0zdCKYb0bMKNfk5DoeeJVJyoiIIz0pZPNR4nh9xk7o68dagJTu5u
         TopkpjeLCXm9M56wVbr7lv/uhW6CQDSwi9V75dwdYz9NQQg6UnbtqQiuw0bw2vSZtU6n
         YWvb5d7uBTwEUa/4d45rhQ4zeTyMWfSLPEXB5n6qfv6m/N5WA1aCkaj6GBTtNLpEGhlr
         j3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iRjbWXUWKdI5T5j70ZPijMzoSc0FwXFiL+Py7PH7F4=;
        fh=MzkK/c+i54Z4FK5etc3JqVFqJXNLaIpv0GaEpapexI8=;
        b=Zx7P1EUS/k/x3SHS0IYowL72Smzp+IgpBpYhReYdEJ2U7/55vgOjvhRLXPYvaXyQNO
         SBTLGiwNOIUkXnasceGBEAY0uqqCRPi9FvBdlRkvfKMV+5dVJ1Vsk9hN2lLncrhfOc13
         3LzntSBUfYD0f0He8zlMM68T8kGkdVDBAZbFtLPSdnb3ez9oSedoFvcjULD4gUppkSQx
         PPju8mgHkH91lXmqBM57mlBcLkJMFgPxbrRI7asYNiFV1afQ8zJCwVx1jo/iXZfVaF9B
         aF/1nA9brU4i1jvWlVzoJuQrM6CCL5iJgLyNJrIxHBZ1rKfOF+H8CKVOhbMXP7fNYoB9
         fR4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790195642; x=1790800442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iRjbWXUWKdI5T5j70ZPijMzoSc0FwXFiL+Py7PH7F4=;
        b=MSzf5flgQ4zcxUOOnu+OwR/YRC6E51dPDWsedFPaYZOIZ6+ZD+BPxm6ghQskoHsS7V
         +WhBoa5GMSF4LYMPBI+KytXB7ORnu/bv9DCM0i7TLxEaQTFdXh/L54pQrVinMtTw4uxc
         tBjS39jspT6+vRG6ts7g6gmp/S4Ea0E0Ea2FX7FA0Au/XA/2BwxI8n1REMZISPWem501
         HLuujeOAKEXlfahxMq4O4x38CfM9tLv8roRG5eYaOutFLwxG9lIIVtwbr1drN8WAn3OP
         tItAl9W34ejYNVFOa2Ui3oCbbF12XR9xOWY0IlidTGHKlpsdQ9qbVq21MFPCfX/+/UXc
         7zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195642; x=1790800442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iRjbWXUWKdI5T5j70ZPijMzoSc0FwXFiL+Py7PH7F4=;
        b=CqhyGLiOR6WVCDD0hkbOXuFrh3kXdmgY2ZcYjVItqhkZ0ZrslXVKR2NAFjnP6I/vL3
         2rM9uLx9VxUVveQxCOUs8yrxL+haxkuESwmPyFBf2qbai7tB8RQ0QnuoH+IHMyrBkalt
         2FB1AuCGgA8UjVt5cvYX55t5vBw8X0RoYx3EdRnVB3FQ3KuAU57dP4sIP9cFaJ+Yk4Uv
         SJqIuAbelGg3o0vAIcB6zQILSvGRugez78hXxNjSQ1bpqQHD7isjNPD2bEh4qHxXbNrD
         LbxX3TpgB73giT+Oz81e9gPH+BtaoxANJ6HTAVLdpjjkWNdtMG7wx6W+FM4SEpk1as/n
         vyyA==
X-Forwarded-Encrypted: i=1; AKwUvBxSst6upngYguRE8HFu7u13cMfPeRpO4MuBqCmYd6/l4oX2wY9G0bV1nInMSK7SBEP4KVivVkrQTvPzqXFOXpUw@vger.kernel.org
X-Gm-Message-State: AFuF++m04kweea4Zzd94LOInCx6Tml0S4Yn9agAzxs7UBZLQeMVspj9u
	N6+DYKjhFXAaBIcYTA+4g9148pHcSWXcsOA4H8rMVzrH6mH2+BtNrx3vtVwtXGAOEM0IISdiqPS
	Uv8Srz1QtjKgKx5xPPBK/ZkfIy3zHuaZblr9f28fr
X-Gm-Gg: AYBFou2nmeE7kL4zR3WKH/IKmCdvRsDKU8EBYD6lN0367wsHmvndWIlOlfsaModUT4q
	rFMoRNRh+SjR15cF0t6buy2MPa+jxZZTFgxoCPXbu7QbGTMmOF0e/ZEZrPuOUtUiqCL6ep09b3M
	aYCYm2mWbL6b9ljk8JBiuRBxaHSOAvXFjFwLGrlFYTVYjuhZCkrx+GlBTgn8abVfcZ3JPRAX/pK
	d3AYM+Tc1k5iUh9TRy9ipOYRXUsKMd9pVdjNy9xU/bFex9g/DPMqMSsSekcLVZB1AhXwRt1sPtU
	I01vqrZ5Ohe2/q1GBWw01AZsqgnTr5RTY6WZz53uUFiW1S7MmIyRFgGdGx0nsJ/+p9pn0hC84Pi
	cyg1EoXJWa2RrqZJXcybR
X-Received: by 2002:a17:902:f543:b0:2d5:db38:800f with SMTP id
 d9443c01a7336-2df7b3e1e8emr1773735ad.14.1790195640940; Wed, 23 Sep 2026
 13:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923193432.2489729-1-stian@itx.no>
In-Reply-To: <20260923193432.2489729-1-stian@itx.no>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 13:33:48 -0700
X-Gm-Features: AcwNN1UT7NrgvcNDp1sJnOfbIhVSfmmWr9VKa8r6V-od56OMd3RrgE8WhcMyDkE
Message-ID: <CAP-5=fX2M6ndLGh5GKjiP2eK=tCp_LpE1iVjDH+Nkz5jJVpxqw@mail.gmail.com>
Subject: Re: [PATCH] perf unwind-libdw: Fix reading the stack of a 32-bit task
To: Stian Halseth <stian@itx.no>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:34=E2=80=AFPM Stian Halseth <stian@itx.no> wrote=
:
>
> memory_read() hands libdw 8 bytes whatever the sampled task's ABI. For a
> 32-bit task libdw keeps the low 32 bits (__libdwfl_frame_reg_set()), so
> on a big-endian machine each word read from the stack or a DSO is the
> one at addr + 4, and unwinding stops at the first frame restored from
> the stack. On sparc the 8-byte load from a stack address that is only
> 4-byte aligned even traps, and perf dies with SIGBUS. Read 4 bytes for a
> PERF_SAMPLE_REGS_ABI_32 sample.
>
> A recording of the other byte order has each sample swapped in 8-byte
> units when it is read (perf_event__all64_swap()), which leaves the
> 4-byte words of a 32-bit stack dump reversed and paired up wrongly.
> Undo the swap of the unit holding the word and swap the word itself, as
> __evsel__parse_sample() does for PERF_SAMPLE_CPU.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Stian Halseth <stian@itx.no>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> Ian raised the cross-endian case in review of the sparc64 perf_regs
> series:
> https://lore.kernel.org/all/CAP-5=3DfUuRm3dWra4a-6eNF3F=3DtafcHvvDipqmDEX=
N5+ti-sW0A@mail.gmail.com/
>
> Tested with 32-bit sparc programs (static, dynamic and multithreaded) on
> top of that series, with a local change so perf recognises sparc32plus
> binaries: natively on sparc64 perf died with SIGBUS before and unwinds
> complete chains after; cross-endian on x86 no call chain was complete
> before and all are after. 64-bit unwinding is unchanged in both.
>
> Words read from a DSO rather than the stack dump are still not swapped
> for a recording of the other byte order, whatever the word size, as
> before this change.
>
>  tools/perf/util/unwind-libdw.c | 46 ++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 4ccfcc7c2dfc..d49901b1571e 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -4,6 +4,7 @@
>  #include <elfutils/libdw.h>
>  #include <elfutils/libdwfl.h>
>  #include <inttypes.h>
> +#include <byteswap.h>
>  #include <errno.h>
>  #include "debug.h"
>  #include "dso.h"
> @@ -17,6 +18,8 @@
>  #include <linux/types.h>
>  #include <linux/zalloc.h>
>  #include "event.h"
> +#include "evsel.h"
> +#include "memswap.h"
>  #include "perf_regs.h"
>  #include "callchain.h"
>  #include "util/env.h"
> @@ -203,9 +206,10 @@ static bool get_thread(Dwfl *dwfl __maybe_unused, pi=
d_t tid, void *arg,
>  }
>
>  static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
> -                         Dwarf_Word *data)
> +                         Dwarf_Word *data, size_t len)
>  {
>         struct addr_location al;
> +       union u64_swap u;
>         ssize_t size;
>         struct dso *dso;
>
> @@ -218,15 +222,38 @@ static int access_dso_mem(struct unwind_info *ui, D=
warf_Addr addr,
>         if (!dso)
>                 goto out_fail;
>
> -       size =3D dso__data_read_addr(dso, al.map, ui->machine, addr, (u8 =
*) data, sizeof(*data));
> +       size =3D dso__data_read_addr(dso, al.map, ui->machine, addr, (u8 =
*)&u, len);
>
>         addr_location__exit(&al);
> -       return !(size =3D=3D sizeof(*data));
> +       if (size !=3D (ssize_t)len)
> +               return 1;
> +       *data =3D len =3D=3D sizeof(u32) ? u.val32[0] : u.val64;
> +       return 0;
>  out_fail:
>         addr_location__exit(&al);
>         return -1;
>  }
>
> +/*
> + * libdw expects a 32-bit task's words zero-extended.  A recording of th=
e
> + * other byte order was swapped in 8-byte units when it was read (see
> + * perf_event__all64_swap()), so a 4-byte word is picked out of its unit=
 with
> + * that swap undone, as for PERF_SAMPLE_CPU in __evsel__parse_sample().
> + */
> +static Dwarf_Word stack_word(struct stack_dump *stack, int offset, size_=
t len,
> +                            bool swapped)
> +{
> +       union u64_swap u;
> +
> +       if (len =3D=3D sizeof(u64))
> +               return *(Dwarf_Word *)&stack->data[offset];
> +       if (!swapped)
> +               return *(u32 *)&stack->data[offset];
> +
> +       u.val64 =3D bswap_64(*(u64 *)&stack->data[offset & ~7]);
> +       return bswap_32(u.val32[(offset & 4) / 4]);
> +}
> +
>  static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwar=
f_Word *result,
>                         void *arg)
>  {
> @@ -234,11 +261,16 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, =
Dwarf_Addr addr, Dwarf_Word *
>         struct unwind_info *ui =3D dwfl_ui_ti->ui;
>         struct stack_dump *stack =3D &ui->sample->user_stack;
>         u64 start, end;
> +       bool swapped;
> +       size_t len;
>         int offset;
>         int ret;
>
>         if (!ui->sample->user_regs)
>                 return false;
> +       len =3D ui->sample->user_regs->abi =3D=3D PERF_SAMPLE_REGS_ABI_32=
 ?
> +             sizeof(u32) : sizeof(u64);
> +       swapped =3D ui->sample->evsel && ui->sample->evsel->needs_swap;
>
>         ret =3D perf_reg_value(&start, ui->sample->user_regs,
>                              perf_arch_reg_sp(ui->e_machine));
> @@ -248,11 +280,11 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, =
Dwarf_Addr addr, Dwarf_Word *
>         end =3D start + stack->size;
>
>         /* Check overflow. */
> -       if (addr + sizeof(Dwarf_Word) < addr)
> +       if (addr + len < addr)
>                 return false;
>
> -       if (addr < start || addr + sizeof(Dwarf_Word) > end) {
> -               ret =3D access_dso_mem(ui, addr, result);
> +       if (addr < start || addr + len > end) {
> +               ret =3D access_dso_mem(ui, addr, result, len);
>                 if (ret) {
>                         pr_debug("unwind: access_mem 0x%" PRIx64 " not in=
side range"
>                                  " 0x%" PRIx64 "-0x%" PRIx64 "\n",
> @@ -263,7 +295,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dw=
arf_Addr addr, Dwarf_Word *
>         }
>
>         offset  =3D addr - start;
> -       *result =3D *(Dwarf_Word *)&stack->data[offset];
> +       *result =3D stack_word(stack, offset, len, swapped);
>         pr_debug("unwind: access_mem addr 0x%" PRIx64 ", val %lx, offset =
%d\n",
>                  addr, (unsigned long)*result, offset);
>         return true;
>
> base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
> --
> 2.55.0
>
