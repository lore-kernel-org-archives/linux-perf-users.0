Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD9425CF0
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011987; cv=pass; b=iKt+3MdbrZBhPZtRY7f6Xii/V2IDKY3lh5yFfow6neQOJHstQP1SiiI8bn0SS+MFUrIQflwzbTr1X0/VuCUblVgh8OO5TkU5KdpWWliFIxFpQ6TFQQ+KynwP4yFgRG0FmPVqG6Mvn3s2WskXrxVE548oJJNRy6afO5RaWa9oGzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011987; c=relaxed/simple;
	bh=GV9TZFSrvqyVTP37cI0aA55YUYBhUFh+tlCJtu91pOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhjijWtOepXI4+Ga6rHFVbMfoCFKnWJbDI1VpZOrnTvkzBkXIJlMSFMWlfCBj3Nf7bnj9SYzAmM21lUT3Jout99be5y/ZaZoAzH2Co+T84SxZ9BZRJhKheaZtsgN66w3ZOdaNjQb80frjAOx76IcBKjQ/609J8myOaoD1YKCwd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zi6hhnBr; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zi6hhnBr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a76b39587aso102245ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 08:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769011985; cv=none;
        d=google.com; s=arc-20240605;
        b=G6Z/1AXnez2i0EqzC20c6e3mMERlV2WFFQJzV+xQdpVzSZguzT49L86TM+oPOWrWqW
         YdSLNisQNF3tMd5E3plJdJTGMs85Ef8nSVaMYPNp60+SbKR6aJntdjiS7M83oodztDBs
         MbcrR3QyBiRx7EgNL16eAYeF9/NS80mxHB+9WGpKyh6mzPm2eaiNw20ZCBsqXXsfXaUr
         IWLPBnPT2E7CZTxOMR0LMSXHuVTJYC471licdnkOrDzNNIEVXx4UBnA9KusRJmXKRsON
         jJnEcdkUFMNUsqeWy28YpZXM2W1Vfu7hZXqivoT6OtUafjQa74APXWwVY5vaEw4HVFJy
         Yq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yElKEp6HllPVYRZhYa+WUZyaAciN+qJK6S2h+ke7cxE=;
        fh=cwlCyoySXzvDx0wnuAGuhLpO3cwnBsD7jp+f3pEsv0w=;
        b=kkBG1mHWZV6uqENBSMW6dtZz+hWNuIO1HFHzJ5KuscxecIkvcDUjYqBtcC4+XTT6xU
         SbGVmLle49CHFkl3BYmpVGz3vRyEfQ/7PDxsOUSAjLiedVKV5SIC2gTZPx1zT8BgU7MK
         KZT38kUoo++XaMW4Da6mp31LCWw3OLYHufjZdottsu0go/MIAdaFmvP4qNo+Tnk8gOnk
         d2dIFcfyopyzBxqwsPidJnKhd7df5ikvtmAWCtnB628rFuoZhFQdSdiNjuiLzon+D+J+
         U2vNIRbr06TIIkJte1fGyAmH8ofdQ/VPTMugMM1Zd79dV22XB3LmxGyj60XDnDtJfl66
         DjCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769011985; x=1769616785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yElKEp6HllPVYRZhYa+WUZyaAciN+qJK6S2h+ke7cxE=;
        b=zi6hhnBrLASPpjydmWTQ3B4Vof3CN9nFRH+2vw7Naifl3eWN/r97xmwHzmS3iGgLeg
         ZD/LCjs7Xtv9peYCMyOrT6VrONP2S64oKHCmlUdy5L2Qkg0My4bPq2ppDAnnAAI3/w+3
         fpGDmmYEO7HHzYSm5M0446tidpwgL2corQ15nClxPJTm+eD2v45zW6qYONQ2sS2z6HNE
         ZLhSVQDt+aHeqCXVKcm0ZCJdydKnBRwZyVKtnhtqfmbEPo07U/4a5GiIibNsUW/pbeKQ
         Hs+FlOq+J51g0nxgrOdeZwsKCKFcD3CSJ5b1bkCNUnWKRSJ2s81rZzG0QPyb4SY7Usdk
         0nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011985; x=1769616785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yElKEp6HllPVYRZhYa+WUZyaAciN+qJK6S2h+ke7cxE=;
        b=je2AYkdR5xBWG2RyTL8C5c2tJtHVxjhy9S1WC1EC1tb3mleuaPjYv+x1yMmkORxSCC
         KpjzjSi2sNtWt7p8wdvX5Ls9yfHwiQ4hBURD3aja2G7rwh+54EDJLDYRFzM9J6qOnJVD
         24ptmWXfEAkHWIRFwe34GHh0n5UrLc4/EyEeg3WARQiJ1X8H/lw3s/I4Ldvo306min/k
         T1+VaZZbPtHUsvab9bESWrGPmg33gPXOEARwYJ1WhkVEErDZi0SJYVfxsgNmQ6eadxDY
         l6vMkgNGhlOBGFVV06sdSG/07Qwdh8PSxP3LRSYHkkkntbH8iITvVsuGGIn5MLZNFdZ4
         cFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6HIfGw12F2BHcZso+czJfaTDV7CJvBBm9ASVe6jsoHzClAzmySMaSi4XLFOzD41zawOMfVCc1fpvBTSDry4CQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/n+iVlFj+Spkq/EZr19tyPeg2lx7MfywAkyhep6IV7TnujdKt
	Tp29ecfeOZzGRPR54wjOpqFu5B304lfblk/RKSqZHljIUhVh+fkC3xKVZ4nmQlZ6R2/I6gR/dng
	/oOPwf2rzJKl+OPf1Y79UOj+HMoZ3b3kvz2oerrrA
X-Gm-Gg: AZuq6aLBxFvN/VksVD/e7qngU1T+Xh//4qlIpHZCdXcZSGwTITJhU5hNgyPU+yQSqHM
	fGRSyObxCikYdo7cxj4Vid2tuD+bl+3r/IF5OzJPuNHInn+WxKGL3jThoW95vrQ9J4WB0xJqfUN
	Yk8HraDGp5bnQ0j6jtiPzHwL2czaGpGTYbKYFBc8RkY193tc+EbLFneg9IpnqT+esRcI6uIwD8w
	ohNUEZedL+hX513zY4gZ5XQXcvZ5JB3VH1imH08+rZR6tn7p8f0BAOIBftwWyCE+nZBP+Uf3hOp
	HdzTX8QKCuSUOC7TL6xl7lAFSA==
X-Received: by 2002:a17:902:dac8:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2a7a245b58cmr2877145ad.15.1769011984791; Wed, 21 Jan 2026
 08:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121082402.2311962-1-tmricht@linux.ibm.com>
In-Reply-To: <20260121082402.2311962-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 08:12:52 -0800
X-Gm-Features: AZwV_Qi1G_PUJnyGBIsZiS-ZFyw3lObm5Oj0C6T-z7wyXtWXO_Whb1A8QlzpJjk
Message-ID: <CAP-5=fXwPrR-gwPbD7CcY6_fKg=s0yfNWSasFyYVQxCDhKKm=A@mail.gmail.com>
Subject: Re: [PATCH V2 linux-next] perf test: Subtest Exclude disjoint subcmd
 names fails
To: Thomas Richter <tmricht@linux.ibm.com>, jayaram@akamai.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:24=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> V1 --> V2: Add linux next repository
>            s/needed/unneeded/ in commit message
>
> The perf test case 'libsubcmd help tests', subtest
> 'Exclude disjoint subcmd names' fails all the time.
>
> Root case is a special case of sorted input which the exclude_cmds()
> in libsubcmd can not handle. Assume the following inputs:
> cmds =3D { X, Y, Z } and excludes =3D { A, B }.
>
> This leads to
>  ci  cj  ei   cmds-name  excludes
>  ----------|--------------------
>  0   0   0 |     X         A       :    cmp > 0, ei++
>  0   0   1 |     X         B       :    cmp > 0, ei++
>
> At this point, the loop is terminated due to ei =3D=3D excludes->cnt.
> The for-loop now checks for trailing names which had to be deleted.
> But the first entry points to a name: cmds->names[0].name =3D=3D "X"
> and this is a valid entry.
>
> This is the case when all commands listed in excludes are less than
> all commands listed in cmds.
> Only check for existing names when cmds list was changed, that is ci !=3D=
 cj.
>
> Also remove an unneeded if (cmp > 0).
>
> -
> Output before:
>  # ./perf test -F 68
>  68.1: Load subcmd names                           : Ok
>  68.2: Uniquify subcmd names                       : Ok
>  68.3: Exclude duplicate subcmd names              : Ok
>  perf: help.c:112: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' =
\
>         failed.
>  Aborted                    ./perf test -F 68
>
> Output after:
>  # ./perf test -F 68
>  68.1: Load subcmd names                           : Ok
>  68.2: Uniquify subcmd names                       : Ok
>  68.3: Exclude duplicate subcmd names              : Ok
>  68.4: Exclude disjoint subcmd names               : Ok
>
> Fixes: 1fdf938168c4 ("perf tools: Fix use-after-free in help_unknown_cmd(=
)")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas!

I tried to apply this on a perf-tools-next tree but it fails. Looking
into the git logs I see on linux-next:
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log=
/tools/lib/subcmd/help.c
the last patch is:
2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empty
In perf-tools-next:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/tools/lib/subcmd/help.c?h=3Dtmp.perf-tools-next
I see:
8 days libsubcmd: Fix null intersection case in exclude_cmds()
2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empty

The test I wrote was to give coverage for  Sri Jayaramappa's fix:
https://lore.kernel.org/r/20251202213632.2873731-1-sjayaram@akamai.com

I wonder if we've put the test into linux-next but not Sri's fix, well
that's what it looks like to me.

Now that we have both your fix and Sri's fix, and they differ :-) I'm
wondering how to resolve the differences.

Thanks,
Ian

> ---
>  tools/lib/subcmd/help.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index ddaeb4eb3e24..1ce5fe507687 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -93,19 +93,19 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdna=
mes *excludes)
>                         zfree(&cmds->names[ci]);
>                         ci++;
>                         ei++;
> -               } else if (cmp > 0) {
> +               } else {
>                         ei++;
>                 }
>         }
> -       if (ci !=3D cj) {
> +       if (ci !=3D cj) {         /* Verify cmds list only if it changed =
*/
>                 while (ci < cmds->cnt) {
>                         cmds->names[cj++] =3D cmds->names[ci];
>                         cmds->names[ci++] =3D NULL;
>                 }
> +               for (ci =3D cj; ci < cmds->cnt; ci++)
> +                       assert(!cmds->names[ci]);
> +               cmds->cnt =3D cj;
>         }
> -       for (ci =3D cj; ci < cmds->cnt; ci++)
> -               assert(cmds->names[ci] =3D=3D NULL);
> -       cmds->cnt =3D cj;
>  }
>
>  static void get_term_dimensions(struct winsize *ws)
> --
> 2.52.0
>
