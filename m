Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0072E7196
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352111; cv=none; b=mA7XgXa1mhwW82lii0fIyZip9rbbSbgmx7YI1UeqoBatRY7uz2aB4wRsYBM4ryfoGLQn7GKoKx/wR0V5SDnJGr4QhjLiPIZe6qsMeM2i2bUybqJA+48jH3sTvmGJSxKjvOjdukvkKzAByiG0F+2SYAB7MI8ZqIG7EITDemWAQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352111; c=relaxed/simple;
	bh=YyN4Fy7cFjCuAQN9iofBCwnSheogXY7fB4MzJJ2Y+vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFDq0ebhHFnDyiq6CzrFoEjZlgzNGEC7/ihlMZHrTdwVfrKlsJitI2V3S2MCgO/OwH+pMvvzjctiKy8+KT7R5sC1dPVwQcwGaK5FPFc2rnJl5snojHU62N8G8t9A6R0jbpe6areyj1THhFpRcWZrjaUVSq4fWq+gIBsCvK0wV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMLNeca8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMLNeca8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso670671266b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760352108; x=1760956908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEjrZ5KI8ghZWNu9poLLDUVtxDcPQM62kH1Mxu75i/I=;
        b=QMLNeca8qXj5XnmMR6N2GSLrQR9t5EqTCmtjLvxR3nZxlPn5fk0JwVgcRgszQ5yY7n
         gHiXW4HJX40JRqfkhkwP1B/Z2irJm+V+pPztWm3b3kPWTbTiFLV8fSVTYI66lp0UvB9Z
         +zvvpn9K3uRcstJh0KNnJSFtx1pqi8fYwRmupGkcMoSjQNlCoolW2Wf21Qzrijga3NZO
         P3ymg3cfoAZIkOublcG02iUEitroFtzhPyk5GCgI7A7zTUH3pEDhSzSTVi2YZrHOwY0z
         UaIPXXkX57IBKVVE8X2Vu48gAiocEF75unQzF4s0SNfR0GnnZpQeau+xdHNf1/2cCpZc
         lRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352108; x=1760956908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEjrZ5KI8ghZWNu9poLLDUVtxDcPQM62kH1Mxu75i/I=;
        b=klLHGIcwsyAyaGldlCL1UZEyz2vNcMH53MdOlqA0tD77ApCvBn6XP4MdNB3TrFOfLa
         div39xbkkhRiJkO3qmpyTEg7KlWw/8MxYwFBI+qt/QiP4VEzx0b+XSz6wXvWfNP+n6GP
         D+gJOrIMZsq7onXJ8bLbpn9fTrg0I1KmjC5yfMS2WXOeKWG+jixIBWNlwt5RdRECVyad
         ackFlrwyhxD4ELgVY3+zavl+c8vn2IcFshWXpBt/McByQVtE4iobcJfZq1Jf5qk3l0nz
         70LEusNrvbO5ax+FYIDnQNrxswVuh5xMtW1XWOpjCLEp5KZsiV5wG6Vw0EgLXF9iizA4
         8l5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsw/m3HBw/eRpjNvsrpk1lpVq6i6cuTjzjCOkElCNNCC7J71GB/MNjiuHZPmjwEJ2y11fVMTrMafQDHxKTMiwM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5JMHk3nU4Ho5VbQEX33+zLbZsHovtwn1+T6lETTMX7tLPxh6
	Fbpgw2848Taal4Aot0f0j/nDXldHtnXm6qN04Rov/Whl/KPRtpRlmU9QYYdHGA7+R4Fn0gf/ngi
	oge7WHA5BcTBrDlS8g3gi5qb48pP1gpg=
X-Gm-Gg: ASbGncuQW7FsXr9akCpgDzo8kzTLOBcP2q/caRo8WJU4NxNgpjagnSH01bx8vTU/5kJ
	O0CxlMpVE9rC4dXNSKhVCNTa0sJShhnqwTnpV1PbYEpj85tduLZ4yYtulu3P3wqkMVI+f6vKsfy
	gttrorJyyMR1XgyRYpHM6Jt5WatrimTmh5ZyFxEET4rPnazsCD1CFri81bjIRGsb8XOH1TONyeV
	YpSAhAndcUuVGZLlKiyA2LPokEKzOICU/pbf77Jl/MMN1yOWKDVFHXYIyETlXiEm39YWg==
X-Google-Smtp-Source: AGHT+IFYPmh1c36RwRLOo2uUUMUFucqAcao9E57aFUP92xiXGcbG+Q+UI4IibOC2MF1OpeyGkZNJn/CsiB4Jy+Wk1Ss=
X-Received: by 2002:a17:907:2d0d:b0:b4e:f7cc:72f1 with SMTP id
 a640c23a62f3a-b50aaba1161mr2094538666b.22.1760352107918; Mon, 13 Oct 2025
 03:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013072244.82591-1-adrian.hunter@intel.com> <20251013072244.82591-2-adrian.hunter@intel.com>
In-Reply-To: <20251013072244.82591-2-adrian.hunter@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Oct 2025 12:41:37 +0200
X-Gm-Features: AS18NWCRzdhF5PXYFFrI1cBupLRzeVMrGtQlFrsQVhAfncRQxbPI-PhmAr5Ayyc
Message-ID: <CAOQ4uxjvMRXWeQx+mAugwGLftCPRQKxUfx8dZj+Jqk-Y_YJDcQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/3] perf/core: Fix address filter match with
 backing files
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Edd Barrett <edd@theunixzoo.co.uk>, Laurence Tratt <laurie@tratt.net>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:23=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> It was reported that Intel PT address filters do not work in Docker
> containers.  That relates to the use of overlayfs.
>
> overlayfs records the backing file in struct vm_area_struct vm_file,
> instead of the user file that the user mmapped.  In order for an address
> filter to match, it must compare to the user file inode.  There is an
> existing helper file_user_inode() for that situation.
>
> Use file_user_inode() instead of file_inode() to get the inode for addres=
s
> filter matching.
>
> Example:
>
>   Setup:
>
>     # cd /root
>     # mkdir test ; cd test ; mkdir lower upper work merged
>     # cp `which cat` lower
>     # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdi=
r=3Dwork merged
>     # perf record --buildid-mmap -e intel_pt//u --filter 'filter * @ /roo=
t/test/merged/cat' -- /root/test/merged/cat /proc/self/maps
>     ...
>     55d61d246000-55d61d2e1000 r-xp 00018000 00:1a 3418                   =
    /root/test/merged/cat
>     ...
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.015 MB perf.data ]
>     # perf buildid-cache --add /root/test/merged/cat
>
>   Before:
>
>     Address filter does not match so there are no control flow packets
>
>     # perf script --itrace=3De
>     # perf script --itrace=3Db | wc -l
>     0
>     # perf script -D | grep 'TIP.PGE' | wc -l
>     0
>     #
>
>   After:
>
>     Address filter does match so there are control flow packets
>
>     # perf script --itrace=3De
>     # perf script --itrace=3Db | wc -l
>     235
>     # perf script -D | grep 'TIP.PGE' | wc -l
>     57
>     #
>
> With respect to stable kernels, overlayfs mmap function ovl_mmap() was
> added in v4.19 but file_user_inode() was not added until v6.8 and never
> back-ported to stable kernels.  FMODE_BACKING that it depends on was adde=
d
> in v6.5.  This issue has gone largely unnoticed, so back-porting before
> v6.8 is probably not worth it, so put 6.8 as the stable kernel prerequisi=
te
> version, although in practice the next long term kernel is 6.12.
>
> Reported-by: Edd Barrett <edd@theunixzoo.co.uk>
> Closes: https://lore.kernel.org/linux-perf-users/aBCwoq7w8ohBRQCh@fremen.=
lan
> Cc: stable@vger.kernel.org # 6.8
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7541f6f85fcb..cd63ec84e386 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9492,7 +9492,7 @@ static bool perf_addr_filter_match(struct perf_addr=
_filter *filter,
>         if (!filter->path.dentry)
>                 return false;
>
> -       if (d_inode(filter->path.dentry) !=3D file_inode(file))
> +       if (d_inode(filter->path.dentry) !=3D file_user_inode(file))
>                 return false;
>
>         if (filter->offset > offset + size)
> --
> 2.48.1
>
