Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCA27E061
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385841; cv=none; b=JlsQJt995gdP3G3XRH+Cs8MgSmOhq0XwK16+l2u5CJr/B+srMY94Oy6/L8cYBs+PesvHUWEQC/DsFNGNvcQ4DFfMsxwb1REYYpqN8HbTvaYSacuSlTjf2NxNeEQXPNlAR0JHoK/9pxyHM8f3K8TqnTX9rXDOuLMDDlpOUCh0rWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385841; c=relaxed/simple;
	bh=WRhvlRstgimRJH/V/lHUEiuKmwZMzsQ2k2rmu/AGceo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XESArW7t2L65NoNevU+AkIbawhS7o00UQKuc4D2dX+OuLe42IZ7yXRblc9bnFjUrlSiNHlvrAPVh37RQsZ2+sq9yTcLna8mgArWwcLl03Y0d2rJgpJYD7Pj9xWIA+PfiY/CJ7UA3hA8VAKlEsPBU1gshJU7YPybjadQ1ui+cOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xag56M+4; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xag56M+4"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3de210e6076so136165ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jul 2025 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751385839; x=1751990639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baDjOCm/nT6gOahf8avhA5A45L9PnVfcldowdK0zHtM=;
        b=Xag56M+4sYzVV5gFWSWzDoI8GqbnBJrBMN6zRUW6pBeXhyhwN81kVBEGyIFU52clyf
         xh8b38M7TuEBWidsXwkR2bqTzpmk3U9hM6VJ+8YMYD6CdsDpDeWaRtR31XoS4N8PyKA+
         LwjkWObJNOiOb+zdCiTZI17ttQ2jHCW9b0VTAADugvZpqHhHyScP3dwQeN5lf0FCltit
         iE5qIA2HZeN5432CPCQ6l0IRRzUq8l580+O6rGtTpuUFH6GvutUdKkjlxpyNj3ITHDKI
         hfpc1rchCJQ2qbeArXsmRcOFJ0tJbcbPBQleWEoKqFW3RCdYzCCh8D6td72zA7PDarRa
         bQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385839; x=1751990639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baDjOCm/nT6gOahf8avhA5A45L9PnVfcldowdK0zHtM=;
        b=dx+fchIDUhQ3j2JslAOGBYMTH0JoW2aRT9eIGlXkW84y62fKOd8Esa5mLPb5KC2FvK
         eO+Qgk8DWFXSuU2NXKWQh1mQ48fc4s6uXOU0PGYq25dVVUcEI0Dh3+vaxyZBaM7J/gbj
         0OCJs1rbaNQ45itXWUemIhMVDhaw8lYx1cuIqX6UuuCEKY/SeiUo9/W+KJSlA4mdm5iY
         zOpqFh1nkwoOJpZ/OgOwbu6pzAJKtHdoVWBAXcNCwEIa9uvo+CUoE2WYIM03XaU9W9VD
         ++xOlfB1uvXI5JQdOFPgjwIqiTdMXMy1brM7tnleXggLhsmbTcDtea6HDi1t93/sdogb
         ITwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWteElA+6X7Mea7+U+PDuUft+nCRNJ5T7SAJPgDd5OwmamPaOKErPLSdx5oPeq9t/6op/zBfaYu1nXr3CriyPLW@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1VmUTnzJKZ/rKsRtAG1eHXroHPt1NPgMQPzv25Ib38r3mmRM
	jcSrjHRWGkzk8VPnG2jxLM52MKFxxQT0x+JZfDn93fZ5VLgoCNC1fJng5mISzDWQ0jDn3xPBcyy
	hGB9O8rMg08W22fD97txwNEOT44ptpSBioJSL9J6I
X-Gm-Gg: ASbGncsC9lO5e0mnIARP5iAW/OrYhhpinasmIcuQ39EvLZISHLFrtBVQoqOGkU3rdXM
	1VakoaNCUHpIEeLCkYAceUz4oNfFHNNwl+/SiMtKH1GYgzLZJHlsCXY7QUsF4xFjNj1UdRwvGn7
	78mMGn3vMekZSnEJUouZzz+ZCcnGhAni25R0RAqwdhftyt9uUyq1/KYMGYdGcxHHiWQcLFvyU=
X-Google-Smtp-Source: AGHT+IGdX2Lmjq2vQReUB2kT8IaRnj16P+CcAtfKHBSjM2HMi4V24+oShE9JaPZIwZMXM1Oru5v0Q6uyMskHMTJtJVA=
X-Received: by 2002:a05:6e02:1909:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3e04a04a53bmr2485065ab.17.1751385838021; Tue, 01 Jul 2025
 09:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630233246.1063977-1-namhyung@kernel.org> <20250630233246.1063977-3-namhyung@kernel.org>
In-Reply-To: <20250630233246.1063977-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Jul 2025 09:03:46 -0700
X-Gm-Features: Ac12FXxKve0mTKaIaR8Fz9fcmOOeE41kLlfOheQzmk_DY4euDiu032KUdGHySiA
Message-ID: <CAP-5=fXdzL1ZQQCFFU0crNpT7wiW4gtfbN1=p89BnmzWBU4mHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tools: Fix use-after-free in help_unknown_cmd()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 4:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Currently perf aborts when it finds an invalid command.  I guess it
> depends on the environment as I have some custom commands in the path.
>
>   $ perf bad-command
>   perf: 'bad-command' is not a perf-command. See 'perf --help'.
>   Aborted (core dumped)
>
> It's because the exclude_cmds() in libsubcmd has a use-after-free when
> it removes some entries.  After copying one to another entry, it keeps
> the pointer in the both position.  And the next copy operation will free
> the later one but it's the same entry in the previous one.
>
> For example, let's say cmds =3D { A, B, C, D, E } and excludes =3D { B, E=
 }.
>
>   ci  cj  ei   cmds-name  excludes
>   -----------+--------------------
>    0   0   0 |     A         B       :    cmp < 0, ci =3D=3D cj
>    1   1   0 |     B         B       :    cmp =3D=3D 0
>    2   1   1 |     C         E       :    cmp < 0, ci !=3D cj
>
> At this point, it frees cmds->names[1] and cmds->names[1] is assigned to
> cmds->names[2].
>
>    3   2   1 |     D         E       :    cmp < 0, ci !=3D cj
>
> Now it frees cmds->names[2] but it's the same as cmds->names[1].  So
> accessing cmds->names[1] will be invalid.
>
> This makes the subcmd tests succeed.
>
>   $ perf test subcmd
>    69: libsubcmd help tests                                            :
>    69.1: Load subcmd names                                             : =
Ok
>    69.2: Uniquify subcmd names                                         : =
Ok
>    69.3: Exclude duplicate subcmd names                                : =
Ok
>
> Fixes: 657a3efee43a ("libsubcmd: Avoid SEGV/use-after-free when commands =
aren't excluded")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Fwiw, it seems a shame we're doing this and the code in git is drifting apa=
rt:

https://github.com/git/git/blob/83014dc05f6fc9275c0a02886cb428805abaf9e5/he=
lp.c#L204

Thanks,
Ian




> ---
>  tools/lib/subcmd/help.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index 8561b0f01a247690..9ef569492560efd7 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -9,6 +9,7 @@
>  #include <sys/stat.h>
>  #include <unistd.h>
>  #include <dirent.h>
> +#include <assert.h>
>  #include "subcmd-util.h"
>  #include "help.h"
>  #include "exec-cmd.h"
> @@ -82,10 +83,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdna=
mes *excludes)
>                                 ci++;
>                                 cj++;
>                         } else {
> -                               zfree(&cmds->names[cj]);
> -                               cmds->names[cj++] =3D cmds->names[ci++];
> +                               cmds->names[cj++] =3D cmds->names[ci];
> +                               cmds->names[ci++] =3D NULL;
>                         }
>                 } else if (cmp =3D=3D 0) {
> +                       zfree(&cmds->names[ci]);
>                         ci++;
>                         ei++;
>                 } else if (cmp > 0) {
> @@ -94,12 +96,12 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdna=
mes *excludes)
>         }
>         if (ci !=3D cj) {
>                 while (ci < cmds->cnt) {
> -                       zfree(&cmds->names[cj]);
> -                       cmds->names[cj++] =3D cmds->names[ci++];
> +                       cmds->names[cj++] =3D cmds->names[ci];
> +                       cmds->names[ci++] =3D NULL;
>                 }
>         }
>         for (ci =3D cj; ci < cmds->cnt; ci++)
> -               zfree(&cmds->names[ci]);
> +               assert(cmds->names[ci] =3D=3D NULL);
>         cmds->cnt =3D cj;
>  }
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
