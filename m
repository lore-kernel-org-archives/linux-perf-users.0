Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFC1D54E2;
	Fri, 24 Jan 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741666; cv=none; b=Fiuk0YwRWWcZBekxtnzdqQT29uEVW+qw5UFrXF9NPM2DtGDM/6AofbYxsdaV4alOe8eWYBDjwsJm2h8ctx4pyPnqNSLAKHL4Cys0vKyUXmEK+1EQ8Dyz/KdgeSiMCSDTYTiZSYFoYA+9yCGrwDFhbLPraVRqzyrDyuLm1rX8sFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741666; c=relaxed/simple;
	bh=TI4F67zi6rUV5RYhkmjrrXyLvi2fk4yFYyznbxyxBag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1GjnCE4qaCqHwFQyY4k0VUQGG/VQpPOCHrHH8YAGy9eiOdQ/dMgwn+wIyzphbtnJXuLw+QgrkDfQhcHOl3NG+iR10VevDNmsc/QZSkebFQRc7bvY1k54iDPv12tFqJcVUs7+Jfc8KbSFWLLjho/Jc/bKtX/utGNitV7yvb0fAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U94JFe0w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U94JFe0w"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21644aca3a0so55460435ad.3;
        Fri, 24 Jan 2025 10:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737741664; x=1738346464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUj9uimqquz5ySfs3mIanKshTWXH0Exh2p9XGjFNUoM=;
        b=U94JFe0wbXeA+AlVOZHH0GGJ9Vif1Y9pRyHI1QiZ77r0yI1HahNjyV3q9H5ZKMizTe
         A7mPf8VuVo5sByw+r1VNAeMvS6nWacAz82+0MZ261WDHLO2Sf+X4JpQ+3vzu6yUmpCz7
         Kp0juUqIFpXqDyxksmcCwIgJKojyC7P45YurPUULe30t/5gPTx3eWQlQhLgY/MeZVGZ1
         jtFk+V2aJgyBgoivNk6K1XKPz8LBFZ8UlY9HDRtEX0ECOXdxsrBGsH/tvi15aDqspIYX
         xxmbfmYfna2xBLA7HkgT3CLaLOHMclDglWIeFOcwWFWAgBe/6VEZs6Y+2EVF8MVgLHzO
         gwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737741664; x=1738346464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUj9uimqquz5ySfs3mIanKshTWXH0Exh2p9XGjFNUoM=;
        b=v+ouBwEmTaHNkXh52XMuJpJeSlVY5kzGUTOMZw4itoEBxl/nXaMZ+Mknfj/M9ZA08J
         sUdkH/kPSK8nqZupjBhV9jKyiHj4OM7/dfYXVP8WjPF0uSTufma+jwznSBxCDLjkPJnE
         cPX6dhe/YHVZNeUj4fzV1ytgFni0ZjZKWNyXggZ1QfzIqLLNBpdWYaINjCDR6U+9kqWb
         uXJNASc54+snZIvZt0gOtAmHeFCIquHP0XCiUOsoiRRPZTnNDoGr18BI5+sAZXwqOcyR
         VaY8q/fmttgL41KjzhorVJMzMrieEWKuGCpGqxaRvuDVHjaHReVUR0HG5cOAVFuS028T
         Rlyw==
X-Forwarded-Encrypted: i=1; AJvYcCUuu1Ds+wGfGkac0ZTbEKFcS1yeoo4q/dxMgjh2jc70vmxk9MwBj0YBG18L8bLOyhf0HHuCqzN6Ga43lyTcjXt/VA==@vger.kernel.org, AJvYcCVdWXlQj1o1NWzE/yNGObUKg2pqjMezJytYuZpO+z4qwk/BpgamDfiNMtZSaSNXVlw1fdmcyvc1OinFuBQ=@vger.kernel.org, AJvYcCWXJLkDL4NTJc/vdcjao7wK5mnDubsUiKClJyDnPN6s8em+CsGuyKtVNC+KssQNiFWc6SE2S+VyDwU+bHexxmeS0Q==@vger.kernel.org, AJvYcCXYWUZFLRvpLtJzsFZMW7LL1/Xh1vvYEwrReeX7hqIBhgbvzqJgTJ5v739pA3UjtbamuaQ934Hy5Cf8RWCyKOLUtDy0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BlqjvBHR5pl13cbO6nZ1iE1wbH/MGZkETz+WekocJu/+/eHx
	7nVpxFUsKSFIRWvFIIgQwSFpSb7Atw/QtWPNAOBojWzgNXVqJiGa+wmTIXWaFzZuBk/Ykw7jDAO
	ABwOojZAPGDsNZOX3SRfW8N1XG9s=
X-Gm-Gg: ASbGncsRu4pIIHz9rmF4gokeWrtpI+bw7e+bYAxzeHmOfNZTZADs7yYa671XZdN2+Hi
	dVEmwyAmXAXnkB7gIUo3QVNrgS848+MI995L33UPfRsaljoBgDrKD4o7ehs3xtOJceQm24HP7Ko
	FiQQ==
X-Google-Smtp-Source: AGHT+IHRzsRcOfmQhe9gElE5XOLqcyV94nxyUmtjOyYJ5mfZ1QFeb2Uh6QclwASPkys3VqqMmSmfD333eDCdNg5vv3E=
X-Received: by 2002:a05:6a21:33a0:b0:1e0:b5ae:8fc1 with SMTP id
 adf61e73a8af0-1eb214a0800mr50799062637.13.1737741664200; Fri, 24 Jan 2025
 10:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
In-Reply-To: <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:00:52 -0800
X-Gm-Features: AWEUYZlNizaP1gGPEnIroRehbrwqqHTUpRLaFN5MYdDqBP9RMQQAcQJlEr7Qrdk
Message-ID: <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> In preparation for unwinding user space stacks with sframe, add basic
> sframe compile infrastructure and support for reading the .sframe
> section header.
>
> sframe_add_section() reads the header and unconditionally returns an
> error, so it's not very useful yet.  A subsequent patch will improve
> that.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/Kconfig           |   3 +
>  include/linux/sframe.h |  36 +++++++++++
>  kernel/unwind/Makefile |   3 +-
>  kernel/unwind/sframe.c | 136 +++++++++++++++++++++++++++++++++++++++++
>  kernel/unwind/sframe.h |  71 +++++++++++++++++++++
>  5 files changed, 248 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/sframe.h
>  create mode 100644 kernel/unwind/sframe.c
>  create mode 100644 kernel/unwind/sframe.h
>

[...]

> +
> +extern int sframe_add_section(unsigned long sframe_start, unsigned long =
sframe_end,
> +                             unsigned long text_start, unsigned long tex=
t_end);
> +extern int sframe_remove_section(unsigned long sframe_addr);
> +
> +#else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
> +
> +static inline int sframe_add_section(unsigned long sframe_start, unsigne=
d long sframe_end, unsigned long text_start, unsigned long text_end) { retu=
rn -ENOSYS; }

nit: very-very long, wrap it?

> +static inline int sframe_remove_section(unsigned long sframe_addr) { ret=
urn -ENOSYS; }
> +
> +#endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
> +
> +#endif /* _LINUX_SFRAME_H */

[...]

> +static int sframe_read_header(struct sframe_section *sec)
> +{
> +       unsigned long header_end, fdes_start, fdes_end, fres_start, fres_=
end;
> +       struct sframe_header shdr;
> +       unsigned int num_fdes;
> +
> +       if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeo=
f(shdr))) {
> +               dbg("header usercopy failed\n");
> +               return -EFAULT;
> +       }
> +
> +       if (shdr.preamble.magic !=3D SFRAME_MAGIC ||
> +           shdr.preamble.version !=3D SFRAME_VERSION_2 ||
> +           !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||

probably more a question to Indu, but why is this sorting not
mandatory and part of SFrame "standard"? How realistically non-sorted
FDEs would work in practice? Ain't nobody got time to sort them just
to unwind the stack...

> +           shdr.auxhdr_len) {
> +               dbg("bad/unsupported sframe header\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!shdr.num_fdes || !shdr.num_fres) {

given SFRAME_F_FRAME_POINTER in the header, is it really that
nonsensical and illegal to have zero FDEs/FREs? Maybe we should allow
that?

> +               dbg("no fde/fre entries\n");
> +               return -EINVAL;
> +       }
> +
> +       header_end =3D sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> +       if (header_end >=3D sec->sframe_end) {

if we allow zero FDEs/FREs, header_end =3D=3D sec->sframe_end is legal, rig=
ht?

> +               dbg("header doesn't fit in section\n");
> +               return -EINVAL;
> +       }
> +
> +       num_fdes   =3D shdr.num_fdes;
> +       fdes_start =3D header_end + shdr.fdes_off;
> +       fdes_end   =3D fdes_start + (num_fdes * sizeof(struct sframe_fde)=
);
> +
> +       fres_start =3D header_end + shdr.fres_off;
> +       fres_end   =3D fres_start + shdr.fre_len;
> +

maybe use check_add_overflow() in all the above calculation, at least
on 32-bit arches this all can overflow and it's not clear if below
sanity check detects all possible overflows

> +       if (fres_start < fdes_end || fres_end > sec->sframe_end) {
> +               dbg("inconsistent fde/fre offsets\n");
> +               return -EINVAL;
> +       }
> +
> +       sec->num_fdes           =3D num_fdes;
> +       sec->fdes_start         =3D fdes_start;
> +       sec->fres_start         =3D fres_start;
> +       sec->fres_end           =3D fres_end;
> +
> +       sec->ra_off             =3D shdr.cfa_fixed_ra_offset;
> +       sec->fp_off             =3D shdr.cfa_fixed_fp_offset;
> +
> +       return 0;
> +}
> +

[...]

> diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
> new file mode 100644
> index 000000000000..e9bfccfaf5b4
> --- /dev/null
> +++ b/kernel/unwind/sframe.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * From https://www.sourceware.org/binutils/docs/sframe-spec.html
> + */
> +#ifndef _SFRAME_H
> +#define _SFRAME_H
> +
> +#include <linux/types.h>
> +
> +#define SFRAME_VERSION_1                       1
> +#define SFRAME_VERSION_2                       2
> +#define SFRAME_MAGIC                           0xdee2
> +
> +#define SFRAME_F_FDE_SORTED                    0x1
> +#define SFRAME_F_FRAME_POINTER                 0x2
> +
> +#define SFRAME_ABI_AARCH64_ENDIAN_BIG          1
> +#define SFRAME_ABI_AARCH64_ENDIAN_LITTLE       2
> +#define SFRAME_ABI_AMD64_ENDIAN_LITTLE         3
> +
> +#define SFRAME_FDE_TYPE_PCINC                  0
> +#define SFRAME_FDE_TYPE_PCMASK                 1
> +
> +struct sframe_preamble {
> +       u16     magic;
> +       u8      version;
> +       u8      flags;
> +} __packed;
> +
> +struct sframe_header {
> +       struct sframe_preamble preamble;
> +       u8      abi_arch;
> +       s8      cfa_fixed_fp_offset;
> +       s8      cfa_fixed_ra_offset;
> +       u8      auxhdr_len;
> +       u32     num_fdes;
> +       u32     num_fres;
> +       u32     fre_len;
> +       u32     fdes_off;
> +       u32     fres_off;
> +} __packed;
> +
> +#define SFRAME_HEADER_SIZE(header) \
> +       ((sizeof(struct sframe_header) + header.auxhdr_len))
> +
> +#define SFRAME_AARCH64_PAUTH_KEY_A             0
> +#define SFRAME_AARCH64_PAUTH_KEY_B             1
> +
> +struct sframe_fde {
> +       s32     start_addr;
> +       u32     func_size;
> +       u32     fres_off;
> +       u32     fres_num;
> +       u8      info;
> +       u8      rep_size;
> +       u16 padding;
> +} __packed;

I couldn't understand from SFrame itself, but why do sframe_header,
sframe_preamble, and sframe_fde have to be marked __packed, if it's
all naturally aligned (intentionally and by design)?..


> +
> +#define SFRAME_FUNC_FRE_TYPE(data)             (data & 0xf)
> +#define SFRAME_FUNC_FDE_TYPE(data)             ((data >> 4) & 0x1)
> +#define SFRAME_FUNC_PAUTH_KEY(data)            ((data >> 5) & 0x1)
> +
> +#define SFRAME_BASE_REG_FP                     0
> +#define SFRAME_BASE_REG_SP                     1
> +
> +#define SFRAME_FRE_CFA_BASE_REG_ID(data)       (data & 0x1)
> +#define SFRAME_FRE_OFFSET_COUNT(data)          ((data >> 1) & 0xf)
> +#define SFRAME_FRE_OFFSET_SIZE(data)           ((data >> 5) & 0x3)
> +#define SFRAME_FRE_MANGLED_RA_P(data)          ((data >> 7) & 0x1)
> +
> +#endif /* _SFRAME_H */
> --
> 2.48.1
>
