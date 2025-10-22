Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F472D1F7E
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151159; cv=none; b=KUT8neFWpFJfubDCuskScA5Ldfc+/zyyxnF3zYZFGGbgjsxAC0JfqtdspEUO9XO6b+D2pTCzT445eYEALUJ1nUyFdBc7gZwid5qTIhul36YQIb8/IGlLTlqr39GbLPJNm0ErHGlbROxPfKi7vDhJKwsAoCLAQzDVIu+YoLFNlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151159; c=relaxed/simple;
	bh=Mq30Q/ygl6vuWzwAY+4nh9b47GM7X3mCuqI5h6P3BLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/QQZA8mMQ22kdN70Pi4dnd/FuGnBkuZ2Q33FjFmdFNNMZcfJmU9L3nDtVlz3hiGi9Qcl6Ioz5Q5OhJJ2X02c4RJzlsnGLsefe4SawrIYaXRkFwVMX4ooIPvUiN+/X+R9zaUhQsajy9FWYCJ8eck0r7y3A8OpZgGlir/WnDn6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUEtFdCh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUEtFdCh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290da96b37fso248035ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761151157; x=1761755957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dyRsVRqc2L33WX8RRMU6pDd7nF1eS3Q2aDL0rKCUTQ=;
        b=MUEtFdChnip8PHnlA7zRBzbc5mcai6HoiJLPIH8UUkuFG15XHYvsRNOKao/ZlJikd9
         c7NMzn2K8pmh9qKvk3vg4Tg5b8bY76eFELpJool5T6n9jIssGnASxYJSqQXcFxkWNyY6
         hfqM278hUQsFY7FnRrAzjyQ7lRMw5o/yTR9naZ0WiriHFF38kgdybT4KGWpPND8b2f4q
         toDUYCddCfqBwOwdeWjEmWkyxajbRD/t7VUMQDZAFI8FvPnhO4C9Kur0subt2/u+DNEM
         LqZSUKdCya4fTOW/5tVH4UahuNB5OhnzfZ5A7tuS6FrjadrjgR7Ucts64NTPpDOPu7Qa
         oV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151157; x=1761755957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dyRsVRqc2L33WX8RRMU6pDd7nF1eS3Q2aDL0rKCUTQ=;
        b=F0vtCfeS6W/fdKciGTfp6Otu/4PIKNGCjHkhjgzZG2wIEFTquq23OukgKy6YSgp+AJ
         b6qk7/OBZocCi/TZfWVQc8WzFQunQvz4PvFgaJ36F1v1xIuHfINe4+FiRdenwQ3LFGJf
         Ir9NUu8vwiWKvjO7jjSd/psb6yuYEVifekBAgeYdxqkCfloLxTe4RsftZ23PqQRB5DN/
         Msj0f4mqv75FgNJxzvamBanIaR7j2gkaclkU//wV2q8UFdNuaAeh8ktk0Vp/EbfQ48t8
         j42+9sOKYY5ex9M9K8DhEvnTboIQpIgaKff6wcnY2Dzvb1enlmwF/cg+17HRzfZVrgYZ
         19OQ==
X-Gm-Message-State: AOJu0YzI6Te3aGyAjrTMfItVtr8oaCbwZf77mRB93O4m2bpG0NPmKUFt
	GAgYUEkRgHHUZeLiAA175LrWq0AAXaVNxFNcFzvbUhmADjkuhY0xZREUOsrGWtVNW7XtaQgNlJG
	geuv4b/IBkg4h3Ul6Ai/yi5+idAM/Em9/y4LpFaHh
X-Gm-Gg: ASbGncvJGzfm0BpjFXsId98avlOOn1bUevx4mufV35VCg19tm01xgtCsUQ90fqer+sZ
	gHAx0KPEqiWXM2U0p7X61rir9UDCfg2ECvILH8+RpPjyzsja0zH8zglzdn/6EkwEjywCdY21PIS
	oGunolps1Nuj/FI4AoYtjZZJ5vZxnA8F2Qz18zAmpi6QYoI8q41fDp2xPABZoB87Pyt6VH2VhM5
	SxYTMkhY7qNT78reQyg7kK7o8TSynyjppXnUPF0spqRZJs9+s3Gtro3wl9kpZM+zOrUB8k2c0Fv
	+V/RAIpLvC6zfddHopie+2TcwUrL458hzI0S
X-Google-Smtp-Source: AGHT+IHuo/tpCr5zMmwopYH1l3fZ57heRmdwQKT7jq6PWjrxm3n0qt9zvzIfVYp2QgVFiEGiNDaGFyUDFMxdAO+7wlg=
X-Received: by 2002:a17:903:124b:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-293009e6711mr2507235ad.4.1761151156642; Wed, 22 Oct 2025
 09:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022110241.1283519-1-james.clark@linaro.org>
In-Reply-To: <20251022110241.1283519-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Oct 2025 09:39:05 -0700
X-Gm-Features: AS18NWAil3nUEi8qILrmxdeia1X4sOClLr1HZR-99gBc_cScrIcebtFbWKMy2uw
Message-ID: <CAP-5=fWi-xCxuiszt538osE6KKWop7cYkN9Gjog65QgGQ-HhPQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix Clang build by adding block in switch case
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, acme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Tianyou Li <tianyou.li@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Wangyang Guo <wangyang.guo@intel.com>, Pan Deng <pan.deng@intel.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:03=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Clang and GCC disagree with what constitutes a "declaration after
> statement". GCC allows declarations in switch cases without an extra
> block, as long as it's immediately after the label. Clang does not.
> Unfortunately this is the case even in the latest versions of both
> compilers. The only option that makes them behave in the same way is
> -Wpedantic, which can't be enabled in Perf because of the number of
> warnings it generates.
>
> Add a block to fix the Clang build, which is the only thing we can do.
>
> Fixes the build error:
>
>   ui/browsers/annotate.c:999:4: error: expected expression
>   struct annotation_line *al =3D NULL;
>
>   ui/browsers/annotate.c:1008:4: error: use of undeclared identifier 'al'
>   al =3D annotated_source__get_line(notes->src, offset);
>
>   ui/browsers/annotate.c:1009:24: error: use of undeclared identifier 'al=
'
>   browser->curr_hot =3D al ? &al->rb_node : NULL;
>
>   ui/browsers/annotate.c:1009:30: error: use of undeclared identifier 'al=
'
>   browser->curr_hot =3D al ? &al->rb_node : NULL;
>
>   ui/browsers/annotate.c:1000:8: error: mixing declarations and code is i=
ncompatible with standards before C99 [-Werror,-Wdeclaration-after-statemen=
t]
>   s64 offset =3D annotate_browser__curr_hot_offset(browser);
>
> Fixes: ad83f3b7155d ("perf c2c annotate: Start from the contention line")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/ui/browsers/annotate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 3a81912279ad..36aca8d6d003 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -995,7 +995,7 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>                 case 'H':
>                         nd =3D browser->curr_hot;
>                         break;
> -               case 's':
> +               case 's': {
>                         struct annotation_line *al =3D NULL;
>                         s64 offset =3D annotate_browser__curr_hot_offset(=
browser);
>
> @@ -1012,6 +1012,7 @@ static int annotate_browser__run(struct annotate_br=
owser *browser,
>                         annotate__scnprintf_title(hists, title, sizeof(ti=
tle));
>                         annotate_browser__show(browser, title, help);
>                         continue;
> +               }
>                 case 'o':
>                         annotate_opts.use_offset =3D !annotate_opts.use_o=
ffset;
>                         annotation__update_column_widths(notes);
> --
> 2.34.1
>
