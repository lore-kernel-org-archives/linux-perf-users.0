Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BFF33FE01
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109622; cv=pass; b=LrSHyWcjhfszId5tM2t6eECXW95bqOVaBVlt7v53pvHXOSGDqEYsL8peFb9YBYFParn3TMZDiDtBNf7obcmzTto0trZGtIBB4aKZpazMQfYYo2rJQY4uc4xyo2B/7ieNLwz5063yOYto7BwIJP5qEyJFmokgrFLoZfWSmw9415s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109622; c=relaxed/simple;
	bh=1eNNdvV/v7o4gjRqdxeJuqukuVyV5+H/ySQzg9oM2cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZDwst1pRYn4zLlnPDMyBVmzz/WJOdPVYSJ9k4vYjWL/ASlWgrBkJuNMNd8c8+/705FgYV9bHG1Bh9ls3h0VUuXn12lqBw8mPT2ekeQUyKlJol8WYtywK+7YnWgD/wn/p1dts9AnDDcRV3Xp95xFYFKVUh8ObRkz2u3cPkFwVBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfxHq1FC; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfxHq1FC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a35ae38bdfso10355ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 11:20:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769109616; cv=none;
        d=google.com; s=arc-20240605;
        b=U1VrtKWq4FAAqgFRmz6LFyB8iuO2NqFctmCF8dBOnYbm07w2FAgeKNPKhG1WmkAkHW
         Sy8n+P9M+2+c3dlmVcZhmRIvZNdlpBWQcKsxRI6dXEUC1BdVYoXwWoduZMtZ/qjyqXRQ
         LaDR8qzDwtXak+oXxtkwfGbM0prfKLMqaeAfZusQeL0xfBgGIaIcpvCwQtjMgfr64zti
         afjRVj0bBRVKu3UOW8J6Uq4An13OFO5sqHAyI5pkrUm5vjmVw/8KjWkdiA51m7jKj6md
         K9NqZEREZuWGsXXg6phFOG5jd4i7/qTHjec0/J5S1jno3ThQ2g7GBeAsDjwwwCOaiMUY
         qXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Od+DPMtD5to2A0BufNITjmJhKQ0ptW5p2YHxn8s3B8=;
        fh=0Ci1iUMViAACRGenSzMzksvH3xxSn48AHwJDOXRY8W0=;
        b=DKwHITDvNu8JrghJu4MVWNpEyXazBgPh21OdYwLP5yQAtYRb5AU+gWN8+2Vn0lSNMu
         fHTqEv+oMZ/663IE12ogxtkKCYg3bcdbDfvmQLU258/wad2FNnYWkqKBL2JDPtVYJa5i
         NCO1MiUhgBQaDEejQyGHcKQLzgaWjcN8jUgeUkOzwlE8Vp6i856P5dTOkG5hpnQ/PhJI
         CKIJIOh/R4Vnk96koh8ohXaYggQUbPvLxEWRQkWFQFsoFQvXL3EDPqVXR9CaHnZ8xLpT
         3Iz92I9r2z+tsJ0tftXNhGI9NWLMJ0s8mtWDMFxaBczxmPOyZYZwQWa7DqwBSGpQGYH0
         MeQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769109616; x=1769714416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Od+DPMtD5to2A0BufNITjmJhKQ0ptW5p2YHxn8s3B8=;
        b=yfxHq1FCVmyMWocs+pJccnVpPFlLSlPNNQOdbdh3WRNUJRCEP2vKlpRJjbTth8WIHu
         e5JJWpS2Dbansd3iJw97sPtSU9dYPRBpzeIU7WuZjJZznFSaaSMTNgDlzACbIW+OxsYw
         CYgIqsRyjO8LjAmIjM2gelNZiNnhC8QxqB6hPhWF/1DNf+0umdudeTDEwnHvLyUH0v1E
         8gswQEOOrVjF8J1HWeYbu/9v3k/CNgmH0rbLBrf65/r/oH2KPViB1OO86B7fEo8Fb3kf
         aLJeJ3zVqRn23TpSCr7lmD7vy3dYw0P3cFCTDD8pn25TI5iVkqSSJsgk8vjKvCZeQVEc
         kXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109616; x=1769714416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Od+DPMtD5to2A0BufNITjmJhKQ0ptW5p2YHxn8s3B8=;
        b=YBGoUsYaU57o+W2q6Gwx2sKsbFwuUetIH4eVoyCOFfXiyRVuBu4BxKrEH2SoVz4t2i
         DxGpvVz13bhT2VQfNsFojtljC0g6pipRF1fHOBYVVnSIO1mBvrkZP5jZKxCRm9rrFPLV
         i3aIDOcq5rKqIpLosqJSLPSmm1wJ9ZruIZ9dIJ3lkWhQCTMJ+E0oGwNvIQLOgoDVlAqF
         /HyCgy2ptdzBg1kSRBAr1x5iUQbkejht+YVrnoDx7zUS8bUj/cO9+nxjL2qGFQC+xTBp
         K1qp2sqyXvAbDs+eusAM3T9q5YcXHojeVXshyluCcHAzBoaqyqVwuV2b+/mkjpe03k0V
         HiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmxAM3MB7P7i4tONKUpSYW2aN37H3bOqzfqNunKFp1J9pdaatCJR+B8vA0nNkwfpnYOhsKsPMvfsx/7SKoouif@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mCT/Gp+EKdX4WfT0qBxww/uAYMOVvgeFAdbGrn2lCEa3gf/s
	8nCLZWY4aoQqJWBUHQ0jyOYxw/Mgq9JRVLR/kT53k1+urVS36Sg/A17rYHH2A2Z+vc4H7oqmIIr
	PefzwMJE5E5Ebs4N23o6aFzdt9b4utCKT1YAVo5sH
X-Gm-Gg: AZuq6aJo9aSN8cyqnX9sI1wf1pDwolE4c/PdNdQC47ej7WEMJYQ/E9Hydik9d/bTyHx
	toeTDCZckRveZuVmVMtTkt84m5pHX2rRfi2Dz42ekF2Q5j5Q3zavw3ldLAHTdk6tfp51N5pYtNt
	40Gsc1JTxq8Yp7wb6EcsYxiIhJLERcExqzqV++UfTcfqclOjQTDSp4mvnf8YqN2yJkdzJk+6rRB
	N1elGxyJ0COZa9ZKVo1lkgNKiRCr/ngejDB0c49aL8PuhNEYrJ2q8EVoKhViDE8tqkz6TXZmNHz
	dfKUn5Dh1JinnFwcTn80phsBIA==
X-Received: by 2002:a17:903:28c:b0:298:45b1:6ef4 with SMTP id
 d9443c01a7336-2a8024db5cdmr326815ad.12.1769109615868; Thu, 22 Jan 2026
 11:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122165407.561888-1-irogers@google.com> <20260122165407.561888-12-irogers@google.com>
 <CAO9wTFjA8_YH+_VW4YHze3dUu-HisA-m_GzfpeS_L=ya7FC9uA@mail.gmail.com>
In-Reply-To: <CAO9wTFjA8_YH+_VW4YHze3dUu-HisA-m_GzfpeS_L=ya7FC9uA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Jan 2026 11:20:04 -0800
X-Gm-Features: AZwV_QhOWCsKoUPsWSGYxkhbT75uIENmhM4kJsBNx_hb2S0JYW2XYOxu90HvPh0
Message-ID: <CAP-5=fVS90cUNXbs2BD-_cEBb9c=1+UN1BvGF1kvtDKy-=O0ZA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] perf disasm: Refactor arch__find and
 initialization of arch structs
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Zecheng Li <zecheng@google.com>, Tianyou Li <tianyou.li@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:45=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
> On Thu, 22 Jan 2026 at 22:24, Ian Rogers <irogers@google.com> wrote:
[snip]
> > --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> > +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> > @@ -8,9 +8,10 @@
> >  #include "../annotate.h"
> >  #include "../disasm.h"
> >
> > -struct arm64_annotate {
> > -       regex_t call_insn,
> > -               jump_insn;
> > +struct arch_arm64 {
> > +       struct arch arch;
> > +       regex_t call_insn;
> > +       regex_t jump_insn;
> >  };
> >
> >  static int arm64_mov__parse(const struct arch *arch __maybe_unused,
> > @@ -70,7 +71,7 @@ static const struct ins_ops arm64_mov_ops =3D {
> >
> >  static const struct ins_ops *arm64__associate_instruction_ops(struct a=
rch *arch, const char *name)
> >  {
> > -       struct arm64_annotate *arm =3D arch->priv;
> > +       struct arch_arm64 *arm =3D container_of(arch, struct arch_arm64=
, arch);
> >         const struct ins_ops *ops;
> >         regmatch_t match[2];
> >
> > @@ -87,38 +88,44 @@ static const struct ins_ops *arm64__associate_instr=
uction_ops(struct arch *arch,
> >         return ops;
> >  }
> >
> > -int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused=
)
> > +const struct arch *arch__new_arm64(const struct e_machine_and_e_flags =
*id,
> > +                                  const char *cpuid __maybe_unused)
> >  {
> > -       struct arm64_annotate *arm;
> >         int err;
> > +       struct arch_arm64 *arm =3D zalloc(sizeof(*arm));
> > +       struct arch *arch;
> >
> > -       if (arch->initialized)
> > -               return 0;
> > +       if (!arm)
> > +               return NULL;
> > +
> > +       arch =3D &arm->arch;
> > +       arch->name =3D "arm64";
> > +       arch->id =3D *id;
> > +       arch->objdump.comment_char        =3D '/';
> > +       arch->objdump.skip_functions_char =3D '+';
> > +       arch->associate_instruction_ops   =3D arm64__associate_instruct=
ion_ops;
> >
> >         arm =3D zalloc(sizeof(*arm));
> >         if (!arm)
> > -               return ENOMEM;
> > +               return NULL;
>
> Please correct me if I'm wrong, but I think there's double allocation
> here for the variable arm since we've already allocated memory for at
> the start of the function.

Yes, I will fix it in v3. Clearly I was working too late :-)

> >
> >         /* bl, blr */
> >         err =3D regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
> >         if (err)
> >                 goto out_free_arm;
> > +
> >         /* b, b.cond, br, cbz/cbnz, tbz/tbnz */
> >         err =3D regcomp(&arm->jump_insn, "^[ct]?br?\\.?(cc|cs|eq|ge|gt|=
hi|hs|le|lo|ls|lt|mi|ne|pl|vc|vs)?n?z?$",
> >                       REG_EXTENDED);
> >         if (err)
> >                 goto out_free_call;
> >
> > -       arch->initialized =3D true;
> > -       arch->priv        =3D arm;
> > -       arch->associate_instruction_ops   =3D arm64__associate_instruct=
ion_ops;
> > -       arch->objdump.comment_char        =3D '/';
> > -       arch->objdump.skip_functions_char =3D '+';
> > -       return 0;
> > +       return arch;
> >
> >  out_free_call:
> >         regfree(&arm->call_insn);
> >  out_free_arm:
> >         free(arm);
> > -       return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
> > +       errno =3D SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
> > +       return NULL;
> >  }
[snip]
> > diff --git a/tools/perf/util/annotate-arch/annotate-powerpc.c b/tools/p=
erf/util/annotate-arch/annotate-powerpc.c
> > index 593c138c8104..004e6137aa03 100644
> > --- a/tools/perf/util/annotate-arch/annotate-powerpc.c
> > +++ b/tools/perf/util/annotate-arch/annotate-powerpc.c
> > @@ -390,17 +390,21 @@ static void update_insn_state_powerpc(struct type=
_state *state,
> >  }
> >  #endif /* HAVE_LIBDW_SUPPORT */
> >
> > -int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unus=
ed)
> > +const struct arch *arch__new_powerpc(const struct e_machine_and_e_flag=
s *id,
> > +                                    const char *cpuid __maybe_unused)
> >  {
> > -       if (!arch->initialized) {
> > -               arch->initialized =3D true;
> > -               arch->associate_instruction_ops =3D powerpc__associate_=
instruction_ops;
> > -               arch->objdump.comment_char      =3D '#';
> > -               annotate_opts.show_asm_raw =3D true;
> > +       struct arch *arch =3D zalloc(sizeof(*arch));
> > +
> > +       if (!arch)
> > +               return NULL;
> > +
> > +       arch->name =3D "powerpc";
> > +       arch->id =3D *id;
> > +       arch->objdump.comment_char =3D '#';
> > +       annotate_opts.show_asm_raw =3D true;
> > +       arch->associate_instruction_ops =3D powerpc__associate_instruct=
ion_ops;
> >  #ifdef HAVE_LIBDW_SUPPORT
> > -               arch->update_insn_state =3D update_insn_state_powerpc;
> > +       arch->update_insn_state =3D update_insn_state_powerpc;
> >  #endif
> > -       }
> > -
> >         return 0;
>
> Shouldn't we return arch here?

Agreed.

> >  }
[snip]
> > diff --git a/tools/perf/util/annotate-arch/annotate-sparc.c b/tools/per=
f/util/annotate-arch/annotate-sparc.c
> > index 66a0174376dd..fe7a37966261 100644
> > --- a/tools/perf/util/annotate-arch/annotate-sparc.c
> > +++ b/tools/perf/util/annotate-arch/annotate-sparc.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <string.h>
> >  #include <linux/compiler.h>
> > +#include <linux/zalloc.h>
> >  #include "../../util/disasm.h"
> >
> >  static int is_branch_cond(const char *cond)
> > @@ -160,13 +161,17 @@ static const struct ins_ops *sparc__associate_ins=
truction_ops(struct arch *arch,
> >         return ops;
> >  }
> >
> > -int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused=
)
> > +const struct arch *arch__new_sparc(const struct e_machine_and_e_flags =
*id,
> > +                                  const char *cpuid __maybe_unused)
> >  {
> > -       if (!arch->initialized) {
> > -               arch->initialized =3D true;
> > -               arch->associate_instruction_ops =3D sparc__associate_in=
struction_ops;
> > -               arch->objdump.comment_char =3D '#';
> > -       }
> > +       struct arch *arch =3D zalloc(sizeof(*arch));
> > +
> > +       if (!arch)
> > +               return NULL;
> >
> > +       arch->name =3D "sparc";
> > +       arch->id =3D *id;
> > +       arch->associate_instruction_ops =3D sparc__associate_instructio=
n_ops;
> > +       arch->objdump.comment_char =3D '#';
> >         return 0;
>
> Same here as well, 0 is returned instead of the arch pointer.

Agreed.

Thanks,
Ian
