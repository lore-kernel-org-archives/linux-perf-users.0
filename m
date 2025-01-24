Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63282D98;
	Fri, 24 Jan 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741782; cv=none; b=trQ7tQsXk7uWNt2HWj2sCqFGP6Of79XDiQEYAHB3UFtEeDYLmFBSuwAlyfElse6jJtFJj3cB3RlLs2QRR2aI8smvCgT5lF9WbAgJBwaqgZlMIQ9Xp9HI+nDES9rSQkHT1hsbEq9z27DIaYIAjRhWljqoltISu8aGcXkxJugfg7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741782; c=relaxed/simple;
	bh=RbcxI1RiocZRRuJVdopdD0HyeL4/GO1s0GeyeW12rlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4nzmHi81H8mBlgba10sBMH/ycaa7tn6RBRdHwQa0uGKp41aEy2SYYVUkrYo2B023li4nCb6F37jvn7DsVuh/JLiPQF7RkBiYo1tzCytw9pQSDi3WnShCnenD6zYaZUKcPtCaGgUhp1wLzQ2KD9ds7FZMagdYXXSnd/i65vHrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu9PC3+W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu9PC3+W"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644aca3a0so55509255ad.3;
        Fri, 24 Jan 2025 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737741780; x=1738346580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A807PKNoTpB3SusbOx+3kKr3GnBsFX9UcVPmosQuaYM=;
        b=lu9PC3+Wwmdu95TFHWBhIK/CNVWY/NE/l6WmdEg5DUQIEWlhIbcKSnoz2cG1lIpj2I
         PJGYDrx1k6kJ8CldDZvxjbbv3+pHgW4oD3gk9SUP5G4uNZUOsYqCR0dkZSpQpsYrD/u0
         lQRp5tXPkTOw3VKvO3SJXvU3zn8hF0etBMxVt4fODk3fXKhQr50EK+IMYQ6K8rm9Spas
         Ka3adxaauUYnodzjxKAGq7cqBBMeoWFtU0Wm6koOj3NjLaauXWo7FaS+vClqESM4YagZ
         Mv6d4QvixBnuFrHKfcf3CKCTr3hDC3CrwrbNTs+qin/+sctvEAAm1Leresz92hgVTqVH
         sk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737741780; x=1738346580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A807PKNoTpB3SusbOx+3kKr3GnBsFX9UcVPmosQuaYM=;
        b=IdIOWbhEEUr8AGfceNAb/fXO0euHnp5n+dhiPkFWwQ4SzdlTjiOOxm/CPV2CB2Gwfv
         O5+kfD2u8HdOlxB2rATwrVl/ZHcCqwmul4qTASlkYad3ws9alQfWg1Uoa7OSvbSR35fv
         ZneXH+PKa/F9Ro7DCw/C1nBvKM6XhQHNaXWKkR3dYycXooSB2KLM8DOjdFMaBkVtx0+9
         ssxpiAhJS6kMJ/v3MMH2HIrNkVWhuIuXEm352/s1+H6Y/tsyBZ7OClAb3sbdHRhUrpyB
         RsQx1Df7lLyRZdQQXUOhLNxnKGBFaDj+zjbPeEGSQZbh0JM02e6ZQU8Ohb62ok84kgop
         qb9A==
X-Forwarded-Encrypted: i=1; AJvYcCU9ndZzNn5IyoIccbvm56XUBY6UfMZMJ8JiZJWULCFdLznDtpd9LyZmZTj8pVSqceXKd+0Iy/wSb1vlYwk=@vger.kernel.org, AJvYcCUEFLy2XP463PZG5D81CQ06gRdGQFhhWNlD+gCwAosfiMQJ0GxzS3LP6kvjr8ESgMKt8pylWHs9p6Vc64BbbE67uI6b@vger.kernel.org, AJvYcCUuaOWlnwwv5ura6byQAnKgcCABhrbfM19+Ng+YOHGPOr2/KRu/JOXvx24dXeC8aO0IE7/+58ddAYqTeg5EKgthvQ==@vger.kernel.org, AJvYcCVoqhS2qfba1LhibQR+bLGBac+DURe84vssodImOCbu9VKZVMxXdPjXCOcTjbLnWjkwq5JvwdhgK41DWOo4JOR5Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx874Hx+LUMMGf/v9ma1+onrc+/GHQTYyfx74sPz15bly41iDJb
	34h+7LmbzOJDc7WQ08SQZX8/Sz+JUtALLreiwWt32g/Gkpsamlq3EzkiMPxlBpTREBfd8zRx+wS
	KcdUBhi5xKj4ZLIjThTedjV2l5cD2qA==
X-Gm-Gg: ASbGncvNnofe+t7tCZk618q78r4hQIkB+LYn1D4fvBlR0QwitIeNZnHoyQQENewVa48
	dE0u6qGRIpzSTpDLNQjPuNvzO6qBKt49lKiXibKHI+XEa2ktAmoYUjoBp5XVexfRdB4w5c5VwW6
	9npQ==
X-Google-Smtp-Source: AGHT+IGACLCVwrOPM1y3P6CQ2R97xwxrIoOlkkswQZndh1XCYVz5IY/WoTj0s5dA/jX/BQGdvD5M1/8x25MFyohKYDU=
X-Received: by 2002:a05:6a21:7891:b0:1e0:ae58:2945 with SMTP id
 adf61e73a8af0-1eb215ea56amr55829921637.31.1737741778646; Fri, 24 Jan 2025
 10:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
In-Reply-To: <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:02:46 -0800
X-Gm-Features: AWEUYZlH3QtBm0_0ajmfaV3kfguDSaJTVcUXz6VQ_eKQ6ZWxI-0fI61k9UEOcqc
Message-ID: <CAEf4Bzb=YFhsLFuK2Zowb1dsXnQPA1uyQUuQ0yXXQbEpeeyDaw@mail.gmail.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
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
> In preparation for using sframe to unwind user space stacks, add an
> sframe_find() interface for finding the sframe information associated
> with a given text address.
>
> For performance, use user_read_access_begin() and the corresponding
> unsafe_*() accessors.  Note that use of pr_debug() in uaccess-enabled
> regions would break noinstr validation, so there aren't any debug
> messages yet.  That will be added in a subsequent commit.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/sframe.h       |   5 +
>  kernel/unwind/sframe.c       | 295 ++++++++++++++++++++++++++++++++++-
>  kernel/unwind/sframe_debug.h |  35 +++++
>  3 files changed, 331 insertions(+), 4 deletions(-)
>  create mode 100644 kernel/unwind/sframe_debug.h
>

[...]

> +
> +static __always_inline int __read_fde(struct sframe_section *sec,
> +                                     unsigned int fde_num,
> +                                     struct sframe_fde *fde)
> +{
> +       unsigned long fde_addr, ip;
> +
> +       fde_addr =3D sec->fdes_start + (fde_num * sizeof(struct sframe_fd=
e));
> +       unsafe_copy_from_user(fde, (void __user *)fde_addr,
> +                             sizeof(struct sframe_fde), Efault);
> +
> +       ip =3D sec->sframe_start + fde->start_addr;
> +       if (ip < sec->text_start || ip > sec->text_end)

ip >=3D sec->test_end ? ip =3D=3D sec->test_end doesn't make sense, no?

> +               return -EINVAL;
> +
> +       return 0;
> +
> +Efault:
> +       return -EFAULT;
> +}
> +

[...]

> +static __always_inline int __read_fre(struct sframe_section *sec,
> +                                     struct sframe_fde *fde,
> +                                     unsigned long fre_addr,
> +                                     struct sframe_fre *fre)
> +{
> +       unsigned char fde_type =3D SFRAME_FUNC_FDE_TYPE(fde->info);
> +       unsigned char fre_type =3D SFRAME_FUNC_FRE_TYPE(fde->info);
> +       unsigned char offset_count, offset_size;
> +       s32 ip_off, cfa_off, ra_off, fp_off;
> +       unsigned long cur =3D fre_addr;
> +       unsigned char addr_size;
> +       u8 info;
> +
> +       addr_size =3D fre_type_to_size(fre_type);
> +       if (!addr_size)
> +               return -EFAULT;
> +
> +       if (fre_addr + addr_size + 1 > sec->fres_end)

nit: isn't this the same as `fre_addr + addr_size >=3D sec->fres_end` ?

> +               return -EFAULT;
> +
> +       UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
> +       if (fde_type =3D=3D SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_s=
ize)

is ip_off =3D=3D fde->func_size allowable?

> +               return -EFAULT;
> +
> +       UNSAFE_GET_USER_INC(info, cur, 1, Efault);
> +       offset_count =3D SFRAME_FRE_OFFSET_COUNT(info);
> +       offset_size  =3D offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(=
info));
> +       if (!offset_count || !offset_size)
> +               return -EFAULT;
> +
> +       if (cur + (offset_count * offset_size) > sec->fres_end)

offset_count * offset_size done in u8 can overflow, no? maybe upcast
to unsigned long or use check_add_overflow?

> +               return -EFAULT;
> +
> +       fre->size =3D addr_size + 1 + (offset_count * offset_size);
> +
> +       UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
> +       offset_count--;
> +
> +       ra_off =3D sec->ra_off;
> +       if (!ra_off) {
> +               if (!offset_count--)
> +                       return -EFAULT;
> +
> +               UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
> +       }
> +
> +       fp_off =3D sec->fp_off;
> +       if (!fp_off && offset_count) {
> +               offset_count--;
> +               UNSAFE_GET_USER_INC(fp_off, cur, offset_size, Efault);
> +       }
> +
> +       if (offset_count)
> +               return -EFAULT;
> +
> +       fre->ip_off             =3D ip_off;
> +       fre->cfa_off            =3D cfa_off;
> +       fre->ra_off             =3D ra_off;
> +       fre->fp_off             =3D fp_off;
> +       fre->info               =3D info;
> +
> +       return 0;
> +
> +Efault:
> +       return -EFAULT;
> +}
> +
> +static __always_inline int __find_fre(struct sframe_section *sec,
> +                                     struct sframe_fde *fde, unsigned lo=
ng ip,
> +                                     struct unwind_user_frame *frame)
> +{
> +       unsigned char fde_type =3D SFRAME_FUNC_FDE_TYPE(fde->info);
> +       struct sframe_fre *fre, *prev_fre =3D NULL;
> +       struct sframe_fre fres[2];

you only need prev_fre->ip_off, so why all this `which` and `fres[2]`
business if all you need is prev_fre_off and a bool whether you have
prev_fre at all?

> +       unsigned long fre_addr;
> +       bool which =3D false;
> +       unsigned int i;
> +       s32 ip_off;
> +
> +       ip_off =3D (s32)(ip - sec->sframe_start) - fde->start_addr;
> +
> +       if (fde_type =3D=3D SFRAME_FDE_TYPE_PCMASK)
> +               ip_off %=3D fde->rep_size;

did you check that fde->rep_size is not zero?

> +
> +       fre_addr =3D sec->fres_start + fde->fres_off;
> +
> +       for (i =3D 0; i < fde->fres_num; i++) {

why not binary search? seem more logical to guard against cases with
lots of FREs and be pretty fast in common case anyways.


> +               int ret;
> +
> +               /*
> +                * Alternate between the two fre_addr[] entries for 'fre'=
 and
> +                * 'prev_fre'.
> +                */
> +               fre =3D which ? fres : fres + 1;
> +               which =3D !which;
> +
> +               ret =3D __read_fre(sec, fde, fre_addr, fre);
> +               if (ret)
> +                       return ret;
> +
> +               fre_addr +=3D fre->size;
> +
> +               if (prev_fre && fre->ip_off <=3D prev_fre->ip_off)
> +                       return -EFAULT;
> +
> +               if (fre->ip_off > ip_off)
> +                       break;
> +
> +               prev_fre =3D fre;
> +       }
> +
> +       if (!prev_fre)
> +               return -EINVAL;
> +       fre =3D prev_fre;
> +
> +       frame->cfa_off =3D fre->cfa_off;
> +       frame->ra_off  =3D fre->ra_off;
> +       frame->fp_off  =3D fre->fp_off;
> +       frame->use_fp  =3D SFRAME_FRE_CFA_BASE_REG_ID(fre->info) =3D=3D S=
FRAME_BASE_REG_FP;
> +
> +       return 0;
> +}
> +

[...]
