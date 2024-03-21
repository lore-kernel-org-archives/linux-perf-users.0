Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839210E9
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Mar 2024 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985815; cv=none; b=QwOzFrFTX6lTFCcMvcTvbVucAGizTXDGRqlB72nA/G3TdhBEIaXoUh5o1WuGQrLRFoQsnla7M7ADPmUk1YdcPys2xWtABaKmRVGK4TikrXjwgHJ6UYpb6SSFHtej3+9xIrXtdmDyyWtRUiuqAXVB6tmJnqhKuLqYiWomWvDnP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985815; c=relaxed/simple;
	bh=dFeaB+r0vbLsU2+EG3R/0nxZko3Fmr0cPhFzpdmhuag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aooAr2u2dck0qtDg1TsTDfe3sV0pXMNIzaZdKwKRLKHwQ+cqDH5sCYKikk2AaIVl0YRRPF+3DzffN7ApneiN1pIqY3vxGEECV6Hn0kRr12Z6YO2ZnH2PewGkufwpDDp4CoO52yhlGoDKdio2sQBaGWssBJgEZyK7lyjv72lPXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zqqwm7Hd; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zqqwm7Hd"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-366a04fb186so84995ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710985812; x=1711590612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PFIZjS6IER8CpqkW4TdLpVgzOwvLIGX3nJMn6PTM30=;
        b=Zqqwm7HdTlYMChSuuGDCH2h4FrdYrpujUvTUDP9dShCTlnDf1WVriu3f0mAMtpAYBn
         7ZNXYZc51R1B7cTycFY/7dM7PIyFOpGPWAq9DIKm36sZ2J/0unhV7hwCqdXvWOhHA9hn
         TczLT5xr5E1w6PUKYPwYhhu04VWQ4u3OHIT/8oiEiz1sTGSqAqvr+GdpptH/MpPGJmRj
         4GEIIyirzbwjyreCS8X16l7pu4UYVhUnwWwnnhHnu/e3Ur6vpLt5a29sD8bY7BcpeJJE
         79STWDvOwqcJiZDSRTRlqjC6RedoaDcItNdMun0rwTTpaC6skhw7oTSohOGEuJYCvYgP
         mInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985812; x=1711590612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PFIZjS6IER8CpqkW4TdLpVgzOwvLIGX3nJMn6PTM30=;
        b=DRkDubH4RSLkhl6QEXc9uXhjhSHp0xHOWq/+JatUvYKkG/7fzPhmgl/l/xLE1GR//W
         ybb43YH5AFHTSnFxcISP5+osrkdKr2TKj2BtQ/yRyVgC4+6uOr+wo2RkL3ZP/+iiV7nh
         tyHoyJuG/G0/B64I6h25tCp09B6EP7P11ojc+8Ff6l3jb3V3lsgR2oDSVxsG+gRCCj8f
         oNmiJDEyKi9zA6PQeG9tx5zTshnFidpTv/dWHFLzfVoGJvimL0sP39UDMDC1KMHKGH+h
         DA8aW+hTg3tlWVOTHRdRTpF7HU0Cj/wpsLroeNoHC/BvLeb5jZh+2p4dRxZzyWjmus6M
         V+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMXD7nZhMpHNVhoIUeF5DTCIw1AMs+MaopNPRqq898XD0mVJ+FFWE5QF/Xag0yc4FwNoKVrZ9fHDoouDpBDSHwJdwhxr9UobRr6+DqBAkvoQ==
X-Gm-Message-State: AOJu0YwdMiW8Y1aBK/XPtkVWQg8MFvOeXiNfbnbpyeda1b2YdwugqfVL
	qYxy4PHCml45dIpna7Gh4znccdj6QMa3xuV+I4KtdK1Jy8Ax8czL72EExoqR6aaW0IXEC7S9ySq
	PMTmkSg/6sBK1EN8gQHGsWcJg+PF+MGK2y1nH
X-Google-Smtp-Source: AGHT+IHrAEJPyYKYdkRV1E43qJTJK0+eTr67tJawKja6UsAthpTCUSaEfF8MACadxrvECk/zgWZcmuqPeKoSYjRtiHk=
X-Received: by 2002:a05:6e02:148b:b0:366:3c86:a38e with SMTP id
 n11-20020a056e02148b00b003663c86a38emr84468ilk.5.1710985812035; Wed, 20 Mar
 2024 18:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320193115.811899-1-acme@kernel.org> <20240320193115.811899-4-acme@kernel.org>
In-Reply-To: <20240320193115.811899-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 18:50:01 -0700
Message-ID: <CAP-5=fU4vj-QHc1SbYOO7XFYfOLC2vpFn_X83LMjvts6_CNn5A@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf beauty: Introduce faccessat2 flags scnprintf routine
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The fsaccessat and fsaccessat2 now have beautifiers for its arguments.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c            |  9 +++++++++
>  tools/perf/trace/beauty/beauty.h      |  3 +++
>  tools/perf/trace/beauty/fs_at_flags.c | 24 ++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 8417387aafa8295d..58546e8af9fcf481 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -947,6 +947,15 @@ static const struct syscall_fmt syscall_fmts[] =3D {
>           .arg =3D { [1] =3D STRARRAY(op, epoll_ctl_ops), }, },
>         { .name     =3D "eventfd2",
>           .arg =3D { [1] =3D { .scnprintf =3D SCA_EFD_FLAGS, /* flags */ =
}, }, },
> +       { .name     =3D "faccessat",
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,         /* dirfd =
*/ },
> +                  [1] =3D { .scnprintf =3D SCA_FILENAME,     /* pathname=
 */ },
> +                  [2] =3D { .scnprintf =3D SCA_ACCMODE,      /* mode */ =
}, }, },
> +       { .name     =3D "faccessat2",
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,         /* dirfd =
*/ },
> +                  [1] =3D { .scnprintf =3D SCA_FILENAME,     /* pathname=
 */ },
> +                  [2] =3D { .scnprintf =3D SCA_ACCMODE,      /* mode */ =
},
> +                  [3] =3D { .scnprintf =3D SCA_FACCESSAT2_FLAGS, /* flag=
s */ }, }, },
>         { .name     =3D "fchmodat",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* fd */ }, }, },
>         { .name     =3D "fchownat",
> diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/b=
eauty.h
> index c94ae8701bc65a2f..78d10d92d351f8e2 100644
> --- a/tools/perf/trace/beauty/beauty.h
> +++ b/tools/perf/trace/beauty/beauty.h
> @@ -237,6 +237,9 @@ size_t syscall_arg__scnprintf_socket_level(char *bf, =
size_t size, struct syscall
>  size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct =
syscall_arg *arg);
>  #define SCA_FS_AT_FLAGS syscall_arg__scnprintf_fs_at_flags
>
> +size_t syscall_arg__scnprintf_faccessat2_flags(char *bf, size_t size, st=
ruct syscall_arg *arg);
> +#define SCA_FACCESSAT2_FLAGS syscall_arg__scnprintf_faccessat2_flags
> +
>  size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct s=
yscall_arg *arg);
>  #define SCA_STATX_MASK syscall_arg__scnprintf_statx_mask
>
> diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/bea=
uty/fs_at_flags.c
> index 2a099953d9935782..c1365e8f0b96ef43 100644
> --- a/tools/perf/trace/beauty/fs_at_flags.c
> +++ b/tools/perf/trace/beauty/fs_at_flags.c
> @@ -7,6 +7,7 @@
>
>  #include "trace/beauty/beauty.h"
>  #include <sys/types.h>
> +#include <linux/fcntl.h>
>  #include <linux/log2.h>
>
>  #include "trace/beauty/generated/fs_at_flags_array.c"
> @@ -24,3 +25,26 @@ size_t syscall_arg__scnprintf_fs_at_flags(char *bf, si=
ze_t size, struct syscall_
>
>         return fs_at__scnprintf_flags(flags, bf, size, show_prefix);
>  }
> +
> +static size_t faccessat2__scnprintf_flags(unsigned long flags, char *bf,=
 size_t size, bool show_prefix)
> +{
> +       int printed =3D 0;
> +
> +       // AT_EACCESS is the same as AT_REMOVEDIR, that is in fs_at_flags=
_array,
> +       // special case it here.
> +       if (flags & AT_EACCESS) {
> +               flags &=3D ~AT_EACCESS;
> +               printed +=3D scnprintf(bf + printed, size - printed, "%sE=
ACCESS%s",
> +                                    show_prefix ? strarray__fs_at_flags.=
prefix : "", flags ? "|" : "");
> +       }
> +
> +       return strarray__scnprintf_flags(&strarray__fs_at_flags, bf + pri=
nted, size - printed, show_prefix, flags);
> +}
> +
> +size_t syscall_arg__scnprintf_faccessat2_flags(char *bf, size_t size, st=
ruct syscall_arg *arg)
> +{
> +       bool show_prefix =3D arg->show_string_prefix;
> +       int flags =3D arg->val;
> +
> +       return faccessat2__scnprintf_flags(flags, bf, size, show_prefix);
> +}
> --
> 2.44.0
>
