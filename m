Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BF3E8688
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167448; cv=pass; b=mtuLrqqB/+fJ6rvmL2bMSibP4k4/Jdl6/rwQlWdiqFz0TYRTVCl2zzNONhgI3PWqH9DHX4xkORaaTrQjeJPJPqFQC9ORFjEPOC7jbUYo1WrX2K8VhALF8afxUIcfyIWzrulvufZNRiQXh9yzFbEp8LblOjQpy7QJcmKzl4E8AdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167448; c=relaxed/simple;
	bh=58vPxYyjWPMZ8bJoAkm3P6Hd7NG7RdKdlJzAYFrheCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heSeKp55FNXCoeRqI2/9Ba2p7hjUYRmXBSVJ0LRg/cuIdmEQ2WuGaAQd6GSm6T/d+smHJYFgSmrB1w0ei68+j9N61WgDmydo2hsZln2EkkMkiTMJiu4AbFsCOJ9ZrToVU8TtNsc6Wc6lD0HLHsbh+5PVMH9TLMgI5LqN3X4iCsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaF9M7Qr; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaF9M7Qr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba180a022dso97245ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 08:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167447; cv=none;
        d=google.com; s=arc-20240605;
        b=XZpWJjnQtcBbuD3g4qcB1BKFvnYeFSfcVij/uS4eH6VzSF+kHhFN2rLAC+XnQGLQPz
         Z6IZ48klCksJLWrsp5vtgHzR7BAIlmhz1L4ybHfvsWc1J+JAWYl7flyW4oWiPpK7ErG3
         1d+YoNHL2A0E8FKabltnb5RYtKtFmRMMIByGztWRzjv/9NoKEIj1bIj4v1gAIyDT91fc
         9gL3xgl+bcqoYFSTWO59jHBVeqM50RiNzFbkNnDRPWRBE4Hq3LTViZEGv++WVJIAT5ph
         Z1iU6hSlN1ZS3SOIslX/tpMcYb9g6upEcLQdUTON7zgSkyV9pKdLyfOz0cN/9S0hcjyB
         dBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=487MgLVCOIdDWtSwIc0mi+AVxJKUWh5HF5BYi3zarm0=;
        fh=Ts89fJTM3zjTBKWisvVCVTW4t4OqzBffybPKU1OKLp8=;
        b=b8/pfMmi0CuS3wA3IyOZefJUPWSGY+pwhZuPdOLl1BgXkAwjoWtUBwBhYEfbQ72Ixq
         quhNNJ+jOL/W+hKoEGQm42LgS0OGbLDB7eaxyLRXi2rRGVH6ms3FF9d8Sj7LqHGNTH2A
         zDHQPM4D3C2rpFNHGJhij2DVvmU0ta3gztQoMotdyzg3+5H3DFZ93UXGSR0Dvuyqxi30
         GAqEAXx8rR7Ra+XnyBhXkd+9PP+YupqU8kLvANFaBF5Lf+G/9w5nAtv2LCRhMQDOPLTS
         wATIDflpfL91Sh3xUMW2Hk3ZB+b15EEaZ24YwzZWaTvPf0KWkXDdafQnzI/Z6NCuTPWH
         UbPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778167447; x=1778772247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=487MgLVCOIdDWtSwIc0mi+AVxJKUWh5HF5BYi3zarm0=;
        b=RaF9M7Qrj+2T38o0+/t1ZO/JKVooxvq5hDxhoPBqsdqDzc6NVK8vYoNg9DQWLbXQtW
         gkK566SxotNpoXGW9I6FaIQaHJKddD1tLGc8Drn1pHGJNCo9VLbcZfOHTTzdTMH1Got9
         qdWsuRoMuqr5DFNPcPyOea53QDt3wSzl5a6lC+Q1K+0hmzT1SrpeyNcrP0XWi9sPEwsf
         513IHM9Ls4xtZwfOHBHwFZfTzWp7Lddqn+bj+U16cVHVE0+MkKo06m0MzCro7G8fp9J+
         Crgf3M7eW8Fw1TBncawrTEQXBY+WhXzlrpUClrlhe/xCBH+pAdo8RTiid7nHuFJfrlKp
         lCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167447; x=1778772247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=487MgLVCOIdDWtSwIc0mi+AVxJKUWh5HF5BYi3zarm0=;
        b=DzmKGJ5kA0aSThtyq09mzLxNIwsdzIfk6FmRCGUEAnfsgoiCfSQS4zpUjlOuudljLi
         w5SKuskKiuaGO4VJlK6QjMkDeDCX652gxVc9+S6Gd5wdTEzH8Z9NFQZBkU0EX8A0yah3
         OV8OVB4nLpB26lnRT1j1MD6q8zXcUb0R2T9SGMV0WE/rRxsKGbtI/eGw7N/voH+jlrLc
         W51sZI7fPMfA9J0vHMdYQ2C2POZyru8aR7NgyNtss6oV8JnJj9QVDFJso2v68yxvzLX4
         CgJW69bIOcWABsf5Tf1mPPLfcGXYDwyzU9yYNy6I1zTZgVK51iNTKaeQ1ErGFV7SNYh5
         WrsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6xjVgUz0Oa7xcH+/zb1aLq7DHXjh26wuCvjaluADx/S6vB1QnDIqNRIksLZXKc9U8tBVGCe7FyUaptKUar368@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtMxHkecyr+T/X3LwCO3YLM6ksk8WHIENam0PPet8w5liD488
	ndoqD1QWu2ee05IOOAYkXdTE8Ue9QRxDhdd2EANOa5BfC80UQ1QlDHtLDmXTCci+ylZ7zeSofUa
	ORzNO9OYZepyvYoOva5BrQmvxoJ1WkpslDD3P4B8Q
X-Gm-Gg: AeBDietK8Qm9mUIQslJxd1mkQz1TiGRuhh5WDjIvXaUcEQb1m7rsiHrWsjnWyjEVZgy
	23HnByw0zgCoT2GTtL72IwNsO6loEGhwhXJ8VYmDrNbEgzle8b7gIp6QjIC6mRaSwW374KdsheH
	1cpTGOtFsw8jc6JWkuxk1+r0U1WeTt2z+FxucG32PfhYky7T/k3YwPPa746NTg5dREDMsH901jT
	iExnchRZWgfd5XVLmn8WFbHYYugCuECXpd5uv9hV7A4G0j3PueNrGUZIv+ngoPpxfVMPrtPHLoH
	vOjqviRt4QTpDGJzYGZKLg/tgHVX1KJiEqR3RFxn3bBom5MMrq/12bpXe+o=
X-Received: by 2002:a17:903:1b63:b0:2a7:6c4e:5914 with SMTP id
 d9443c01a7336-2bab602610emr4091145ad.6.1778167445826; Thu, 07 May 2026
 08:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506073820.2419087-1-qirui.001@bytedance.com> <20260507071103.2772577-1-qirui.001@bytedance.com>
In-Reply-To: <20260507071103.2772577-1-qirui.001@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 08:23:52 -0700
X-Gm-Features: AVHnY4K3tC-rEBta7eS_earBfKMxuaWW1IAAIlwBFtNFO-GOmQNetxBt4Q5Og44
Message-ID: <CAP-5=fVsEVn6AkMEuL8oGW-1uqKL-8TtjgF0_aniwjVCxymv4g@mail.gmail.com>
Subject: Re: [PATCH v3] perf: Add is_mapping_symbol() helper for kernel
 mapping symbol filtering
To: Rui Qi <qirui.001@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 12:11=E2=80=AFAM Rui Qi <qirui.001@bytedance.com> wr=
ote:
>
> The perf tool currently has ad-hoc logic to filter out ELF mapping
> symbols scattered across multiple files. ARM, AArch64 and RISC-V each
> have their own inline checks in dso__load_sym_internal(), and kallsym
> processing has yet another check for ARM module symbols.
>
> This is fragile: adding support for a new architecture or adjusting
> which prefixes are considered mapping symbols requires touching
> multiple places, and it is easy for the checks to diverge. It also
> does not match the kernel's own is_mapping_symbol() logic, which
> additionally covers x86 local symbols (".L*" and "L0*").
>
> Introduce a single is_mapping_symbol() inline helper in symbol.h and
> convert all kernel symbol handling to use it. The helper covers the
> existing "$" prefix used by ARM, AArch64 and RISC-V, and also adds
> the x86 local symbol prefixes so that perf stays consistent with
> the kernel.
>
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
> Changes in v3:
>   - Add is_mapping_symbol() check for kernel modules in dso__load_sym_int=
ernal()
>   - Add is_mapping_symbol() check in machine__process_ksymbol_unregister(=
)
>
> Link (v2): https://lore.kernel.org/all/20260506073820.2419087-1-qirui.001=
@bytedance.com/
>
> Changes in v2:
>   - Only apply is_mapping_symbol() filtering to kernel symbols (kallsyms
>     and ksymbol events), not to user-space symbols from ELF files,
>     BFD libraries, or perf map files.  This avoids incorrectly
>     discarding valid user-space function names that start with '$',
>     which is a legal character in identifiers for many languages
>     (e.g., Java, Scala) and compilers (GCC).
>   - Move the mapping symbol check in machine__process_ksymbol_register()
>     to the beginning of the function, before any map/dso allocation
>     or insertion, to avoid leaving empty maps in the kernel map tree.
>
> Link (v1): https://lore.kernel.org/all/20260504090609.1801880-1-qirui.001=
@bytedance.com/
> ---
>  tools/perf/util/machine.c    | 12 +++++++++++-
>  tools/perf/util/symbol-elf.c |  8 ++++++++
>  tools/perf/util/symbol.c     |  4 ++--
>  tools/perf/util/symbol.h     | 15 +++++++++++++++
>  4 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e76f8c86e62a..4e33ba06111d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -729,9 +729,15 @@ static int machine__process_ksymbol_register(struct =
machine *machine,
>  {
>         struct symbol *sym;
>         struct dso *dso =3D NULL;
> -       struct map *map =3D maps__find(machine__kernel_maps(machine), eve=
nt->ksymbol.addr);
> +       struct map *map;
>         int err =3D 0;
>
> +       /* Ignore mapping symbols in ksymbol events - check early before =
any state mutation */
> +       if (is_mapping_symbol(event->ksymbol.name))
> +               return 0;
> +
> +       map =3D maps__find(machine__kernel_maps(machine), event->ksymbol.=
addr);
> +
>         if (!map) {
>                 dso =3D dso__new(event->ksymbol.name);
>
> @@ -790,6 +796,10 @@ static int machine__process_ksymbol_unregister(struc=
t machine *machine,
>         struct symbol *sym;
>         struct map *map;
>
> +       /* Ignore mapping symbols in ksymbol events */
> +       if (is_mapping_symbol(event->ksymbol.name))
> +               return 0;
> +
>         map =3D maps__find(machine__kernel_maps(machine), event->ksymbol.=
addr);
>         if (!map)
>                 return 0;
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 7afa8a117139..6b12508ea58d 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1607,6 +1607,14 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>                                 continue;
>                 }
>
> +               /*
> +                * For kernel modules, also reject x86 local symbols (.L*=
 and L0*)
> +                * to match the kernel's is_mapping_symbol() logic and ka=
llsyms
> +                * parsing behavior.
> +                */
> +               if (kmodule && is_mapping_symbol(elf_name))
> +                       continue;
> +
>                 if (runtime_ss->opdsec && sym.st_shndx =3D=3D runtime_ss-=
>opdidx) {
>                         u32 offset =3D sym.st_value - syms_ss->opdshdr.sh=
_addr;
>                         u64 *opd =3D opddata->d_buf + offset;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b..af03b16c17c6 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -770,8 +770,8 @@ static int map__process_kallsym_symbol(void *arg, con=
st char *name,
>         if (!symbol_type__filter(type))
>                 return 0;
>
> -       /* Ignore local symbols for ARM modules */
> -       if (name[0] =3D=3D '$')
> +       /* Ignore mapping symbols in kallsyms */
> +       if (is_mapping_symbol(name))
>                 return 0;
>
>         /*
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index bd6eb90c8668..27fa1b43e6f1 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -28,6 +28,21 @@ struct maps;
>  struct option;
>  struct build_id;
>
> +/*
> + * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() lo=
gic.
> + * This checks for '$' prefix (used by ARM, AArch64, RISC-V) and
> + * x86 local symbol prefixes (.L* and L0*).
> + * Only use this for kernel symbols (kallsyms, ksymbol events).
> + */
> +static inline bool is_mapping_symbol(const char *str)

Is there a good reference for what is meant by "mapping symbol" ?
Would "local symbol" be more appropriate for x86? On ARM it seems the
term is well defined:
https://developer.arm.com/documentation/dui0803/a/Accessing-and-managing-sy=
mbols-with-armlink/About-mapping-symbols
I'm wondering if we can make this more intention-revealing. I'm
wondering also if we should make the check dependent on the e_machine,
so perhaps:
```
static inline is_ignored_kernel_symbol(const char *name, uint16_t e_machine=
)
{
  if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
    /* Local symbols on x86 may start .L or L0. */
   return(str[0] =3D=3D '.' && str[1] =3D=3D 'L')  || (str[0] =3D=3D 'L' &&=
 str[1] =3D=3D '0';
  }
  /* All other machine types. Assume symbols starting $ are mapping
symbols used to denote transitions between different sections of data
and code. */
  return str[0] =3D=3D '$';
}
```
I think you can use something like `dso__e_machine` at all call sites
to get the ELF machine type for the binary or kernel, but maybe this
is overkill.

Thanks,
Ian

> +{
> +       if (str[0] =3D=3D '.' && str[1] =3D=3D 'L')
> +               return true;
> +       if (str[0] =3D=3D 'L' && str[1] =3D=3D '0')
> +               return true;
> +       return str[0] =3D=3D '$';
> +}
> +
>  /*
>   * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
>   * for newer versions we can use mmap to reduce memory usage:
> --
> 2.20.1
