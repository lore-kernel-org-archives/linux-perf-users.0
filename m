Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC22063D0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jan 2025 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782431; cv=none; b=rn8NUlRBbBLgdqW2PcDrWsCBX/KYNwidgrbRdfa61l4/TkxVGgZN8G+TBoU3JVA7/6MI+ULMQskI6ADuz5F9p9gbobunA7UjvbkoK7neu24xql1jxWd1n8h2KCrA66125eAEIeK3oXM7mzAALTNvcTF0NZIFVvyeFQ2aT+nMLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782431; c=relaxed/simple;
	bh=O1T75UsFALNUbzpJblBAoQmy/QjVDjUDQQaSNFCCp1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJAYesCvtWymEWI5LSY9u+zGmt9doreCPZ4E9UaRL9wqnkbyYMMMsQSNmZS16Dbvypyn3yKBkG+X0o2tD0Trj29smod1ER1V1YCYaVgeaW4w3Q437/TlLslNiH41ZY0bJj/Ut1II5Bgr7dmYMAlsY1+hZXEkMP7uu3z/bPsegO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oztaDXVZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oztaDXVZ"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so81575ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 21:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737782428; x=1738387228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI0l6geyBvTNYUfVyhSQBTU8bwzp+pWMDrseI++M4u0=;
        b=oztaDXVZ933lLsx5KRyGN0h5LAJ0sLdBl7m6M7ICs85u5SiIF68i/B48UiWWxskEFW
         Wtcy/O74gkHbkmtAqOoV/9eDUzihik+2BgKTvxcS74nNoauZ2N/VuD7NEGcapbZrnazc
         ezwWE0HtzV+B4mSnM1tbFN4MnP+ZuA3pJ2V0/0jcy1yZeZL9OOi340ZW9aSxp01vItPO
         +LEEtxP0V/oNaM0nOOFBUJGDXy37hAbhX4iVobKN33XdfsNyBxtFFJd3OcH+u019omHQ
         PPZpalHVUq6Qf3TN17YxhddndRuPAoQZaWmBAvVktXErccPwB38NPhnKDs4Hao0ZvYs2
         Z2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782428; x=1738387228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI0l6geyBvTNYUfVyhSQBTU8bwzp+pWMDrseI++M4u0=;
        b=qY0l1nkfLX+Efed7jNE/Q2TL3KQUUAy8cvKJ8xgWxyarRiXknyYEtD+j/+g57hO5V2
         SmbcLcjVi1AgQbLlth4YaNvX6guckqrdQjd+NGuFhHlUEUTmu04dHp7j3RoLBR7CgCII
         ructywof6Y+CYwkQLavNZOCZl7Tt4u1vrQzmh5Q+gVmpj7c0ZgHCYhAAdttyEgY/s8cZ
         G8tCLMIf2fpCeUcGWyW9YGd/fW2IzaBGgT1jdRtw2tkWWP3NlGOHWU/HSLVmcS9Vft0k
         65ExTGNItoRWjawanR65ph10EU2uUhWRZTmTW7lPk6ydcfwuGv/SXFFr8avG7CFFAkM3
         ZgDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhhgy+49OUBrSa1mqj0fidSA/K4UKyABzJ7uZYq21XYlja+N1n7bfjk7G77D9WT7eTOgMzGnOr9QDujBTk0jDM@vger.kernel.org
X-Gm-Message-State: AOJu0YyisCG7TzM730Tdmt7LRTfNPFm/ktQr0B0IMSu6IEbWnLAQhodL
	R1h5CNeDdX0uI46IGsQ7s1v0EyIwHoKq7LFqCdBGdfwmbDer8etrKUNSOVR9RQ3OqYeu8hLzwI0
	16YWAUfxl2AfQvRaYBCGs5TE887S3OOrW/CVd
X-Gm-Gg: ASbGncvks3/zXGs45Q5GQNRsaI5SoSPracPETOygF/3IWLgCa3p/2bMhyqerncm+UQY
	J0NxMDJIfGMXPORKAhzPYaBFRNUXbfuZsMEVmb8EPWGvQ+rkh54QmXOtZB/6sdHBvSb6WFjVWeQ
	==
X-Google-Smtp-Source: AGHT+IFUtNMh9Z0W8Yw1lY2LJ5LvNNJDokBmjw9PDDQzB7H9sTQAesT/p5rL6z55wxyts2HnMe4Rd/e5IOCIHo9xAs8=
X-Received: by 2002:a05:6e02:218b:b0:3cd:d110:20dd with SMTP id
 e9e14a558f8ab-3cfd20f391amr966595ab.27.1737782427506; Fri, 24 Jan 2025
 21:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-7-irogers@google.com>
 <Z5QSm-w0efS9xh47@google.com>
In-Reply-To: <Z5QSm-w0efS9xh47@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Jan 2025 21:20:15 -0800
X-Gm-Features: AWEUYZn1lYG_s_9UtV1AZf9F5dR3PIeFgOCadQ-EqV9fiTjdjaYQwOER_v3rUyQ
Message-ID: <CAP-5=fWNy8CM8nKOAH=aXyNKg5h4U4vWfB92io_T5KpCsSgv9Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 22, 2025 at 09:42:56AM -0800, Ian Rogers wrote:
> > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
> > support dlopen-ing libcapstone.so and then calling the necessary
> > functions by looking them up using dlsym. Reverse engineer the types
> > in the API using pahole, adding only what's used in the perf code or
> > necessary for the sake of struct size and alignment.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/capstone.c | 287 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 248 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > index c9845e4d8781..8d65c7a55a8b 100644
> > --- a/tools/perf/util/capstone.c
> > +++ b/tools/perf/util/capstone.c
> > @@ -11,19 +11,249 @@
> >  #include "print_insn.h"
> >  #include "symbol.h"
> >  #include "thread.h"
> > +#include <dlfcn.h>
> >  #include <fcntl.h>
> > +#include <inttypes.h>
>
> These two can go under #else (!HAVE_LIBCAPSTONE_SUPPORT).

Ack.

> >  #include <string.h>
> >
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  #include <capstone/capstone.h>
> > +#else
> > +typedef size_t csh;
> > +enum cs_arch {
> > +     CS_ARCH_ARM =3D 0,
> > +     CS_ARCH_ARM64 =3D 1,
> > +     CS_ARCH_X86 =3D 3,
> > +     CS_ARCH_SYSZ =3D 6,
> > +};
> > +enum cs_mode {
> > +     CS_MODE_ARM =3D 0,
> > +     CS_MODE_32 =3D 1 << 2,
> > +     CS_MODE_64 =3D 1 << 3,
> > +     CS_MODE_V8 =3D 1 << 6,
> > +     CS_MODE_BIG_ENDIAN =3D 1 << 31,
> > +};
> > +enum cs_opt_type {
> > +     CS_OPT_SYNTAX =3D 1,
> > +     CS_OPT_DETAIL =3D 2,
> > +};
> > +enum cs_opt_value {
> > +     CS_OPT_SYNTAX_ATT =3D 2,
> > +     CS_OPT_ON =3D 3,
> > +};
> > +enum cs_err {
> > +     CS_ERR_OK =3D 0,
> > +     CS_ERR_HANDLE =3D 3,
> > +};
> > +enum x86_op_type {
> > +     X86_OP_IMM =3D 2,
> > +     X86_OP_MEM =3D 3,
> > +};
> > +enum x86_reg {
> > +     X86_REG_RIP =3D 41,
> > +};
> > +typedef int32_t x86_avx_bcast;
> > +struct x86_op_mem {
> > +     enum x86_reg segment;
> > +     enum x86_reg base;
> > +     enum x86_reg index;
> > +     int scale;
> > +     int64_t disp;
> > +};
> > +
> > +struct cs_x86_op {
> > +     enum x86_op_type type;
> > +     union {
> > +             enum x86_reg  reg;
> > +             int64_t imm;
> > +             struct x86_op_mem mem;
> > +     };
> > +     uint8_t size;
> > +     uint8_t access;
> > +     x86_avx_bcast avx_bcast;
> > +     bool avx_zero_opmask;
> > +};
> > +struct cs_x86_encoding {
> > +     uint8_t modrm_offset;
> > +     uint8_t disp_offset;
> > +     uint8_t disp_size;
> > +     uint8_t imm_offset;
> > +     uint8_t imm_size;
> > +};
> > +typedef int32_t  x86_xop_cc;
> > +typedef int32_t  x86_sse_cc;
> > +typedef int32_t  x86_avx_cc;
> > +typedef int32_t  x86_avx_rm;
> > +struct cs_x86 {
> > +     uint8_t prefix[4];
> > +     uint8_t opcode[4];
> > +     uint8_t rex;
> > +     uint8_t addr_size;
> > +     uint8_t modrm;
> > +     uint8_t sib;
> > +     int64_t disp;
> > +     enum x86_reg sib_index;
> > +     int8_t sib_scale;
> > +     enum x86_reg sib_base;
> > +     x86_xop_cc xop_cc;
> > +     x86_sse_cc sse_cc;
> > +     x86_avx_cc avx_cc;
> > +     bool avx_sae;
> > +     x86_avx_rm avx_rm;
> > +     union {
> > +             uint64_t eflags;
> > +             uint64_t fpu_flags;
> > +     };
> > +     uint8_t op_count;
> > +     struct cs_x86_op operands[8];
> > +     struct cs_x86_encoding encoding;
> > +};
> > +struct cs_detail {
> > +     uint16_t regs_read[12];
> > +     uint8_t regs_read_count;
> > +     uint16_t regs_write[20];
> > +     uint8_t regs_write_count;
> > +     uint8_t groups[8];
> > +     uint8_t groups_count;
> > +
> > +     union {
> > +             struct cs_x86 x86;
> > +     };
> > +};
>
> As discussed, let's remove the detail part.

I kind of feel there should be a #warning in that case. I'd rather
leave it as is and not have a build warning.

> > +struct cs_insn {
> > +     unsigned int id;
> > +     uint64_t address;
> > +     uint16_t size;
> > +     uint8_t bytes[16];
> > +     char mnemonic[32];
> > +     char op_str[160];
> > +     struct cs_detail *detail;
> > +};
> > +#endif
> > +
> > +#ifndef HAVE_LIBCAPSTONE_SUPPORT
> > +static void *perf_cs_dll_handle(void)
> > +{
> > +     static bool dll_handle_init;
> > +     static void *dll_handle;
> > +
> > +     if (!dll_handle_init) {
> > +             dll_handle_init =3D true;
> > +             dll_handle =3D dlopen("libcapstone.so", RTLD_LAZY);
> > +             if (!dll_handle)
> > +                     pr_debug("dlopen failed for libcapstone.so\n");
> > +     }
> > +     return dll_handle;
> > +}
> > +#endif
> > +
> > +static enum cs_err perf_cs_open(enum cs_arch arch, enum cs_mode mode, =
csh *handle)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_open(arch, mode, handle);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(enum cs_arch arch, enum cs_mode mode, cs=
h *handle);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_open");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_open\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(arch, mode, handle);
> > +#endif
> > +}
>
> I think it's better to organize the code with less #ifdef's.

I think this reduces readability - 100s of lines where it isn't clear
there is something conditional going on, or losing the fact a function
is a shim. More details in:
https://lore.kernel.org/lkml/CAP-5=3DfV0w9tLFr7xYHFUH=3DUUq+tr+o5EYUik0d74r=
MWa9=3DQi+A@mail.gmail.com/

Thanks,
Ian
