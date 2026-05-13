Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D282D839C
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689098; cv=pass; b=J3F7btNFR1IFI58b7RyeknGaU3yGRb3ZYzj9xaTiH7/kd4M2DMylVLKVDO/y9m6zzUlG4HVYTYD6cOnoRJjCPfjNTJIf6nb/ugPEXPF7/6AgEp1870pYrgw7OgBiN6WjclsbYRu2EbnL4NEICDnf2VPQBETQvcltnzPsHlO2Cik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689098; c=relaxed/simple;
	bh=QSzzEPmpjFVQpKqKpQYgpO9FdTrU2EzqKqr44ihCpT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFHWnHNYqYtFZ1uuBoZ8PoN+HtjLphf8nmeIX58tQreIkhHPdbmg8Zou6eg1Vr3U6SliLh/jN6i6KbYhOB1ygC/1DIxT7ylF4rwFxHzkuV7VVDxpSnpOT32IJ+O4XqUgx69DYPDe17WnHv1Zvmue0tnLBvSy0bMw0ZZTfm3d1B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abjiki/e; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abjiki/e"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba180a022dso365ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 09:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689096; cv=none;
        d=google.com; s=arc-20240605;
        b=Nlko10HXQMWQKS7ZmLiWVrRC+C/GTujmADJ6ND+uzLbVjWu2Io2Sy1xeOQwKtjmaAj
         RsURWo8Kzrpt1NrLqeZnpw4AWdD0Yso9/wZ4d2EqeKFqP9pKuJhrIM66NRwbWPv6GsC3
         MRkT3I+pBs/2pTquv+c+XgYChJ/IJCzp1xXIWOUv+wXiPPO9qkk0W76BU8F7mv58zKY3
         zr5oA3aZExfsK7q4tcra9uDo2pf8aJu+PlwGZWkbggVN/laWkH2CxIac1C8ItSjcpHwa
         Yhvnj4QjTW6jA0Vm40QWp8CxMXRIizbsQ27TBLAWqrkhfGOrVFjfJ/F+973yqVYGjXwo
         NeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ACdm50WIzOX3SBrHU64SF6l/5iKLA4zTspnqD3YT0zY=;
        fh=K0RfmD3/mMTzGOSgEpj25p4+LmVYNTi/CJt3lhweTUg=;
        b=exAmg8+GeaH/P8Fl+60Amfz8Nzokb7yTPWGlX5hl2CXscH/+axf2VWQYOyhsJjI/3D
         6mbRADmZh52f7I4aqoz1KTMP9NtoR9ps4Ub5W95r7UgCxwYAhxT6TgsO1fRqUu84fj29
         anhzbdHnB79MgGGpJyaVgGYqoINH6OJUd4ibg1vQDy/g3/CkW1rrvcSt2oYB+NIcqlsd
         8W7QDOWEYout3lOy/9SDVwVnZ89gzJvm2bwfDOhFVDsLrWy/RgeqGZCW0vdu/s0UjDP/
         +0/xEtLIJGelS2O2Pyjou6OjMFAB9oQVEzO7TcnZ5wG86XUCmy5YN72OFY1sERMs5dOx
         gFVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778689096; x=1779293896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACdm50WIzOX3SBrHU64SF6l/5iKLA4zTspnqD3YT0zY=;
        b=abjiki/e8N4X9y7ws7U2rok8rkIUBxuNqUMxybFTX1mqqJY1mPrKs2DrTm7lwiaveH
         YhUzUkDAvmLcmbyRVQIlGu9m9m1AJ0em6G+cndnEO0tWHv46CYyPaEf2m/J9AD+MaKa/
         UzffU9S1eGB/4H2MGZjGRLxWkniLWolQuruP+rRXCGnt5Nbhl7m3kRr3khnyD6neDzJV
         LKRjyFGHQo3l2IOjeH3HWG4SojDrTf3e3NnLuwJEk+ULZfKjDsRtKieEoFoQKEYQ8WJf
         BMV9ZYJkcbXJQpFfeRnrHRs3tPxxc5+JbnslTtZOHuVDOPTm137iX0HiI8eT0+k+u/Yp
         c+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689096; x=1779293896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACdm50WIzOX3SBrHU64SF6l/5iKLA4zTspnqD3YT0zY=;
        b=RizHC0uRwj+FPs+POuAjHqseyQJNbqFa+ViKSMF9H6wCp3d/yZV8n1Hy6uLk/bX7g5
         h6NxTNC71J+t9HrYfE3sspiTmSm0IbojFbtwNyJpLztIiY56hXmMOogBb7d8gEzVeDic
         NjQuGHE8aX2Ul9qVoZy+Py5bhnSvHb0CZOkFILNUgwagZOX0zbDM36sPRkm/4JtqDWiu
         1Ijxbx5xOM5dOOusrD+1r+FJLrdeSGZvoAVwOJGjIOSwLKw2th1gTgzKDGSdteksb+q8
         uOUo6kUmlVcC0ZbGKYroPkgq6VHWaSFIuUObFlEx0str1B98sxBF/xUljcozzaXhNOaq
         gQTg==
X-Forwarded-Encrypted: i=1; AFNElJ/Pt5/uSILcVtItW6PwfBbU0D5KFqr/izZHjC6DKuHMW6OXmh2mjMuMkawcQ8TjBcTpypr9/sB281G985OVuIcy@vger.kernel.org
X-Gm-Message-State: AOJu0YxKH4mi9SfUPqFtjNLtLIoAF18eTb6jQd7YH3vEFJmXOGv/SuiN
	UQvaBLJN5XYERh5xEcThh7XPBZEKemJyY2I78ZGU+jeMng/KkMroy0xcwTleBBuP6KVJsW5z7GS
	fH50ennZFHrzkBqqWTH/vDLMXcKLPUSkj5YNfmdH+
X-Gm-Gg: Acq92OHgWwLaoV+PucgotNKySc8AVhis+XMyJPA9771kS4W1pVC0tTpLhbBjy4OgcSh
	KplnE+wxcc/mkX9HPpTsStublrMS3eipq8/61YVoGyGSRdRCRSmUSAccH+K0ALSn68H4kLM4PeY
	qXV7vQyypjYfVCPe0RYOgviMM6na20kA8wtYS6Vjy1IFcP9R0XXCUigd+G7i3mi1knrhjap65B9
	Z5g3WRLdjoJew+WiM9Ng8jCeVs4DxhEyOy6h0d0T29bdpbv2VIAAd0aWZm59Rx5V87JIp25ZRl1
	AhS6re2IAXN9Yj7LD6B45l+m6edtpzmbpRIVfTAlL4ptAPd+mdvR49xg2NM=
X-Received: by 2002:a17:903:1a8b:b0:2bd:3c1b:3073 with SMTP id
 d9443c01a7336-2bd3c1b31c2mr1613155ad.16.1778689095469; Wed, 13 May 2026
 09:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn> <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
In-Reply-To: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 09:18:03 -0700
X-Gm-Features: AVHnY4I-TB_PRfRIGQslk_C8gLi_FdvZ00UFoQKUCxhZfyS3cjZomVtponH35XQ
Message-ID: <CAP-5=fUigMZD-W2ZisRtb=WAzgx9078XJs7P39Vq0oKS6BYxYw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf riscv: Fix discarded const qualifier error in _get_field()
To: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	palmer@dabbelt.com, pjw@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:50=E2=80=AFAM Li Guan <guanli.oerv@isrc.iscas.ac.=
cn> wrote:
>
> When building perf for the RISC-V architecture (e.g., with GCC 14), the
> build fails due to strict type checking on pointer assignments. The
> compiler flags the return value of strrchr() being assigned to a
> non-const pointer while processing a const string, triggering
> -Werror=3Ddiscarded-qualifiers:
>
>     arch/riscv/util/header.c:24:15: error: assignment discards =E2=80=98c=
onst=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-quali=
fiers]
>        24 |          line2 =3D strrchr(line, ' ');
>           |                ^
>     arch/riscv/util/header.c:29:12: error: assignment discards =E2=80=98c=
onst=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-quali=
fiers]
>        29 |          nl =3D strrchr(line, '\n');
>           |             ^
>
> Resolve this by adding an explicit (char *) cast to the strrchr()
> return values, which satisfies the compiler's qualifier checks
> without altering the runtime behavior.

Why not add the const? There have been a few rounds of this clean up, like:
https://lore.kernel.org/linux-perf-users/20251211221756.96294-3-acme@kernel=
.org/
Did you check it wasn't already fixed in perf-tools-next?

Thanks,
Ian

> Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
> ---
>  tools/perf/arch/riscv/util/header.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/=
util/header.c
> index 4b839203d4..d01ba64aec 100644
> --- a/tools/perf/arch/riscv/util/header.c
> +++ b/tools/perf/arch/riscv/util/header.c
> @@ -21,12 +21,12 @@ static char *_get_field(const char *line)
>  {
>         char *line2, *nl;
>
> -       line2 =3D strrchr(line, ' ');
> +       line2 =3D (char *)strrchr(line, ' ');
>         if (!line2)
>                 return NULL;
>
>         line2++;
> -       nl =3D strrchr(line, '\n');
> +       nl =3D (char *)strrchr(line, '\n');
>         if (!nl)
>                 return NULL;
>
> --
> 2.54.0
>
