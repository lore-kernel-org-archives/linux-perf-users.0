Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D013630B1
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292566; cv=pass; b=lBkGlQPPdULc4daQwsJVCVnNqm7CPcbbPEAlRn6zcYT+5HpIslUtDwR1kr749jicxuYiEZL4TyL+urS2g78BO+SBtxlgrBIAg7GHGomfhJjnDwVGupXaUcYuCLv9xmgWhmIW/JbA9PU+GOkithBZ920o06TLBAyG7QvatHW6JMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292566; c=relaxed/simple;
	bh=z/sOpi60TkILzn3ZyA3sVSlICBw6vn7DsJ5sYGET6L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYHpOyEFOICCJxLRVIaAG8gBxVT1GOBGHoFSLUBm8Wekl7EG4r3Glx5qjQVORsrSigy2+3W+Doix/86RtrSQa4KJqsxkrr4RpbtdpQOls4J+avwQ6+LxJZEdco9HaesxdiEFh6bkxXbNxJR0Ir+chX7JZRL6EWaC7C564rW44I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dak1JnLJ; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dak1JnLJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso1825ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 08:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779292564; cv=none;
        d=google.com; s=arc-20240605;
        b=YO8H3l6tw9T4FlPp2invSdpUaQBG45FUcGhww/ihdcipSwrjFhLElJ9MsD59b8TZCG
         b/X9ZcqGDQGpDnXLz/zNaHTQQtp/Rcdm2atZq5VwfpKEPmPwJBkjnlqliSVMAj3b0wBX
         pAFLQYPdf69BObEKvOkq38tjVHlBcPIDLgpAk+Vrr5Sl9B+G/oTr46ANl1QYEZajTIkw
         STHZ3ZgLpcuPtP4e7J05gzOfQBXcwODDX2uKeJamtkz8yLAcBj8YQ+5nu3enpxZo+C83
         WcufNCWccjqN3DkA9rmmonGfW35W6AQAv5Pgv/YaZaiWciQQKUHpqUt53XjmwoU7k0vO
         JdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xpd4UvxZlmiIthYIcaEwP98OeZQvP7kzOJ0fAuKqwb0=;
        fh=UXw+9wGIh6k8Uu2Z2XLGC+XUBR7kN805iAF0f9TgoGU=;
        b=aoLoQHV89rYngJlm9HSL2xIjzwoYF4cXrVttSO8QdNUSnAUxms4mP2UKEB6qPnBInK
         T8krFH8mxtYwSBitXnd0zSY7W5JYZG7HO08a5HdbsPr5FvcBr23H7pyl7RiT9DfvUHx+
         e1/9XBWCQMSbhbf+rgRcJMKV5KqG0Ptvr2PPi17ra9pAi2orBi8N5GA5LQImhRdOe2tE
         ghfYNiq3kSl+plJXSkzkVkBNlC6cEItUhUvVcL57cn9xWGqbuBAjgeAFAY8lXIWHOEW9
         jw+zThUxGcYLdCJcyWnK13+Bmhmz5pHBlKQ6d//wQe18IH2yQA++1IlQV6gEwfX1tAc3
         Z/HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779292564; x=1779897364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpd4UvxZlmiIthYIcaEwP98OeZQvP7kzOJ0fAuKqwb0=;
        b=dak1JnLJQ3P/N+Q8BMLygapMv3P/wy4IyxtfDnX1wiARKism15dmPZPMoOp+dItU5F
         TkTntu9Fzh/UA5aSEUIOvIausKX/ICtak6bsX22+iD2tVoV39bWveyr/JXvwyRsbTnvy
         YTVtbpT4kdBThKW+jQO420oxLprPc5prP7oGViJ1xT+oMvX3xyi07eHdXA77LRlMtC3A
         J2nk3HR3COhAdwoprmG8jQ9tzgSEzkfedXKcuVhqGngVxIbMI1bcI63qMfeouYFdMoGL
         QFZlPHgYnOPhFs8drI3GHNOaUc7ELEH407JB8ljiNAN2XJRMxWtBYNVlWuB06XlJsI0Z
         gXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292564; x=1779897364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpd4UvxZlmiIthYIcaEwP98OeZQvP7kzOJ0fAuKqwb0=;
        b=gZRK6pTJjS46ao5BpQbmlHJ31BGvEDREmFZ+lUJTlCuqBr06g/DVuKpQA7/7MMRyuP
         GjPoLrhQYpACuEILBxbh103V2U/lx5zvqNZckQeIrCWE2NUCyc2cXrGOdUGUGkIsw9ZD
         c09+eUuUfd4lHIpDL+GKNBP772ewsgnFdRA8rb/Zq94ocMRxzdoQAi6CLu1g6uSOLJbp
         qy9Omg0heV39CIz4uRMrcOOZQaux3/AcgA1/f7nkkhHW1FfYzdyo/jpIfMy7i/KU9p1F
         v55sHNcNrUhyMEtZdM2b6zSMZELWAFoTSsnhJd9amVuv8htJzdlYq64/ZueXoZt1ZkWE
         WRDA==
X-Gm-Message-State: AOJu0Yxd4y8Ulc/S+Iv2giX70/fpuXGxWjFH7Lpc2u6uj2HGrUY2C5Aj
	/2innZwj7hFcT+8VJSFHJIbba82CzBlCFQKeVvRcogYQsbVMVtcYESJ9lVDUub3JfOSvVklsq95
	B4A8lAND7wwg3qAJ0g9p2cdIwLocTE+3ng+s28D2a
X-Gm-Gg: Acq92OF1K/HKjhntaNOvQcJen8OftLs6dkJ/AKHX8cSmzUUHXEIlFIPZdXzseZzs4Kn
	l/sniFavllYOwcz0yimw3Z6bdj3QPdmviPW0g95Lk7GDUp0p6j/KSdEazQPQWlzculJOMOAmbfy
	4UOdPwUrjjsCZ5CxrBQ8XIoWfsLMDknOk/nWu45tBQhxJbh5iSdYhgP9U1eyhxIRjzdjFMo4abN
	uHR3QuHdfXVBRdPrELj9vbVVngjg/Vd2ZG6n1tlinMOfsD+PARwm0w9C314yNT3ytTHrw72Ghra
	xXLdHAFrgGgoz0MMrzG2aeVUjd/4cSC1XtrXUDFN2E5ZfaWK
X-Received: by 2002:a17:902:ebc9:b0:2bd:6dad:7cce with SMTP id
 d9443c01a7336-2bdb04168abmr9902095ad.26.1779292563459; Wed, 20 May 2026
 08:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519223855.191637-1-mpetlan@redhat.com>
In-Reply-To: <20260519223855.191637-1-mpetlan@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 08:55:51 -0700
X-Gm-Features: AVHnY4JCYkEWuXdmORjRrIe3Q7Ryqu9AlEOMgdVf6-MLjM5-BJyxKWlbWcMmOdo
Message-ID: <CAP-5=fV=ouJST+4Aww9gHBLSyag0mZsXM+HWYGLQNd1T3oH0Rg@mail.gmail.com>
Subject: Re: [PATCH] perf build-id: Fix off-by-one bug when printing
 kernel/module build-id
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:39=E2=80=AFPM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> When changing sprintf functions to snprintf, one byte got lost. Since
> snprintf ones do not handle the '\0' terminating character, the number
> of printed characters is 40, while sizeof(sbuild_id) is 41, including
> the terminating '\0' character. This makes the later check fail so that
> nothing is printed.
>
> Fix that.
>
> Before:
>     [Michael@Carbon ~]$ perf buildid-list -k
>     [Michael@Carbon ~]$
>
> After:
>     [Michael@Carbon ~]$ perf buildid-list -k
>     a527806324d543c4bc3ff2f9c9519d494fed5f68
>     [Michael@Carbon ~]$
>
> Fixes: fccaaf6fbbc5 ("perf build-id: Change sprintf functions to snprintf=
")
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Tested-by: Ian Rogers <irogers@google.com>
also Sashiko is green for this patch:
https://sashiko.dev/#/patchset/20260519223855.191637-1-mpetlan%40redhat.com

Thanks!
Ian

> ---
>  tools/perf/builtin-buildid-list.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-build=
id-list.c
> index a91bbb34ac94..e0881b0ac38f 100644
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -61,7 +61,7 @@ static int sysfs__fprintf_build_id(FILE *fp)
>         int ret;
>
>         ret =3D sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id=
));
> -       if (ret !=3D sizeof(sbuild_id))
> +       if (ret + 1 !=3D sizeof(sbuild_id))
>                 return ret < 0 ? ret : -EINVAL;
>
>         return fprintf(fp, "%s\n", sbuild_id);
> @@ -73,7 +73,7 @@ static int filename__fprintf_build_id(const char *name,=
 FILE *fp)
>         int ret;
>
>         ret =3D filename__snprintf_build_id(name, sbuild_id, sizeof(sbuil=
d_id));
> -       if (ret !=3D sizeof(sbuild_id))
> +       if (ret + 1 !=3D sizeof(sbuild_id))
>                 return ret < 0 ? ret : -EINVAL;
>
>         return fprintf(fp, "%s\n", sbuild_id);
> --
> 2.47.3
>
