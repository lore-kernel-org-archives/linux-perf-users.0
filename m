Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717061F94A;
	Wed, 22 Jan 2025 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506703; cv=none; b=IIH20WE/NwHR7QVHOOamfmMDUZop8kDNJLjnKENoqh3SyN65s0+6O1OQNe0DXbcVSbNQSPKa4esdLb60Ta3iMyzV+tYK5GsI4x0cfRXFLvVCsvzhNukggCNJO8i//2x+L7bPXwdwn7iz9uV1H0G3qOQEaefVhJRtEEod2Oa6I/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506703; c=relaxed/simple;
	bh=qknoMfqwZA4Hzv0OtiGDj8KA+4pH21PDeqe79WaPKAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Smi+h9iGIwm7K7CJ/HMHels/Rq5GVqMKTXeJkHsJWW/Chh7SSvlXhnM8ReDkbA1s1eSCfXcUKMbC0djq5egqg1FHJb6xUsgGhD/ffKqVE2KiEnVfxlX+9NTbyCvxoC5TaC4+10ajEvVLXJXWo2QvT9OjpvYuhER2DFRlyjcuwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrv/5Ip6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrv/5Ip6"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so8723401276.2;
        Tue, 21 Jan 2025 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737506700; x=1738111500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u6lDJpGKaqKJ90PtSYF8Ihi8DcFqCnZIbdfqyDuHlU=;
        b=hrv/5Ip6Yae8/jQVrfoqq1ozVSbzuVKW4DtMpZlvNScHgCdzrMayPXla8hT1qwkC/J
         WVxeU95K67sMgnUGqKAopW7XHieQagylxp0v16P7dg4Yu9Rd3DNtc2ajUKb2FgXDfWtk
         OeyAdgfPKwBOOkBnEQ6HV3NBiXkhva4NFuLoYbihAjbrA7NOvzQy3m+RQY9S3mCGBo/r
         gg5/iV2WnSXsItGmM8tDQe+tai5UP/Ne0p3MqrtXBJDBnnQWmO2PxbqXwgqS3/fh9wb6
         B/DSkQbYiZ3iGTbFZTQN3qUk5RylFYPMrExY//99JMc46x3w2krD25vh9JHz3qEMDKJp
         x40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737506700; x=1738111500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3u6lDJpGKaqKJ90PtSYF8Ihi8DcFqCnZIbdfqyDuHlU=;
        b=O0mAuOD2ReTaJlEJlUGv6p+ikJM5tJMcIakV/FfZ62pzq0yrjXZL5XsuEbmt69hD+s
         trU4He8cPohWlwAd5EpNIO+i0WgvDClpHFxhFQDiQnd/hxmL8+bWwn2dR+uQqgNJ61p5
         nhSkyfcIVaxfFtb1Hz1U0u5fF5CO9g8EAr1gLVAbyadqjnIM0q18Fhy8NFVOipGYbz1N
         lejTHS3OfO7F3mR7BCpXlo15cZMVVCh2aZI/XWMY6sOTXLODhpHIrnazWG+cWqZGAYMh
         7r4wZDao17wh+tvxTsR8wW/lOsrkEsleKUpFf0I9zNKBYEbPAFrWgHuQ5YssqSeUcAJl
         ul4g==
X-Forwarded-Encrypted: i=1; AJvYcCUXFtFUILKdC78KWXVAqi9lpJ7/sw6Vr6erqw3RftMTceHxvtdqxKaK9oWjD0ceLM/AFpKd+wwEsrmHgd1+DZFSPg==@vger.kernel.org, AJvYcCVSZ7kmHa+9N6KtrIijOO73JmV6DAxD002fBSG1tKuG3LlRE8+gd9vG01E9p8CVtEoZI9rGE4ft6QEn5+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/JXXxFFpDWXuQiLrKH1vd3Pji075AQi9HdFXpCEgwisZY5hR
	Nq62XWuxVQNa5h5DErmsF674Vg7QpodixrT6dQPhfGx4Z3lducS6HXVbgW0SBpAY5AiVa2hSmcg
	QAvCOf6rB73efmPp+Nk8MScL4uD0=
X-Gm-Gg: ASbGncvozU3Gw1PPBQljJ7VdU7s3G4JsdXzcAVj0NSiMtSm/lRK5+8R2e/4SJF+uM9u
	o2uLDpBi/ORRwzUhtjnQZU1RIo2u6+2Aocj/Rr8Kyvk4TcZC/Kg==
X-Google-Smtp-Source: AGHT+IGUgLg4mKG/vjln481jS7WwdlX9z5e7oI/8Ud48GILfqkzR8lrqK6CBk4XSd0YZSBj39CZHmsVThT62SZBhtsE=
X-Received: by 2002:a05:690c:a91:b0:6ef:7fc0:a378 with SMTP id
 00721157ae682-6f6eb67728amr146056527b3.9.1737506700232; Tue, 21 Jan 2025
 16:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122001741.714400-1-namhyung@kernel.org>
In-Reply-To: <20250122001741.714400-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 21 Jan 2025 16:44:49 -0800
X-Gm-Features: AbW1kvYAXe_II-NjRS6mwBK76hHAeuxtJgbnQ55_vcxvsZUkRr7UC3pZ54kYC6Y
Message-ID: <CAH0uvojiJjwPH5na-RBZi9O=TKtLcdFCXQDjYfd9T9bnoycX=w@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip syscall enum test if no landlock syscall
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Tue, Jan 21, 2025 at 4:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The perf trace enum augmentation test specifically targets landlock_
> add_rule syscall but IIUC it's an optional and can be opt-out by a
> kernel config.
>
> Currently trace_landlock() runs `perf test -w landlock` before the
> actual testing to check the availability but it's not enough since the
> workload always returns 0.  Instead it could check if perf trace output
> has 'landlock' string.

I remember doing the landlock syscall nr ifdef checking and returning
-1... Somehow it's not there... Sorry.

>
> Fixes: d66763fed30f0bd8c ("perf test trace_btf_enum: Add regression test =
for the BTF augmentation of enums in 'perf trace'")
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/trace_btf_enum.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/=
shell/trace_btf_enum.sh
> index 5a3b8a5a9b5cf296..e57ad6913f3e9316 100755
> --- a/tools/perf/tests/shell/trace_btf_enum.sh
> +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> @@ -27,7 +27,11 @@ trace_landlock() {
>    echo "Tracing syscall ${syscall}"
>
>    # test flight just to see if landlock_add_rule and libbpf are availabl=
e

Wonder why I put 'libbpf' here, can you please change this comment to
'# test flight just to see if landlock_add_rule is available'
If you find this change appropriate?

> -  $TESTPROG
> +  if ! perf trace $TESTPROG 2>&1 | grep -q landlock
> +  then
> +    echo "No landlock system call found. Fallback to non-syscall tracing=
."

I wouldn't say it's a fallback, because the non-syscall test gets run
even if the landlock_add_rule syscall can be invoked. Why not say: 'No
landlock system call found, skipping to non-syscall tracing'?

> +    return
> +  fi
>
>    if perf trace -e $syscall $TESTPROG 2>&1 | \
>       grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLO=
CK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags=
: 45\) =3D -1.*"
> --
> 2.48.0.rc2.279.g1de40edade-goog
>

Other things LGTM.

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
