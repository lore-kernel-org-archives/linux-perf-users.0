Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB852204587
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399148; cv=none; b=SRlyKJnN3vb2wPAPOiOC9wZz8Nj96QzCfs6RSasUtuZIM8GljLutOn+kZML6L8zFnVOnSTRrgSAu81FzoNTBf/lsnsRGusZXwiviZIBwO8umZOlxH9hs6+TJwBbQn1uz0ozXacG1TwQ/65K42sHP0d5gZ//5mj2T8r4qpnFRRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399148; c=relaxed/simple;
	bh=cRsst9VUZPQ4xjX0JjGxH/HZKO6ga8iI/0by98CXMI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIqkIKdXMUoXpVmXun4W2BGUTv94drtRyrtQXfGkwIQD9kOU/lPojUMfKH4Zv6o3y1S62xoCCSqNjoKmKTQYSobM93eCbLOZQITuUUASgWx5M9QVzIBorgLx49hdSQN8QoEdkxiUFBMA9AiwaJf2M1J0JSa55647SSSBLdP50zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGQ57XXI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGQ57XXI"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so7625ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 14:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399146; x=1740003946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb8NB3DXPVSxp8ymRsumf/Gc3u9+Crn5k7jX9QVoT18=;
        b=qGQ57XXICBWt4v7pTUUjcg6HduSc4W8c5CDVU+YQVMmLAPquEmLBkBZH60DYSbJV26
         Fb6ievsf6+gqpMx6bkuJElY46OK+o9q8w3hNUzSFgOsc88Ym5DK5Y5m2uhOmIgMVDTsD
         f0g442zLMpu+H1aflzNFVXuwCwozaVMfzOO9md7KRH9cHiBaUMJcdtrEarWd6I1Qh6xp
         uvXPZIHPYfuKkm/+EBgbrHNE5CGa1rPkXcJDajYSRciOArkRVcD9qhU0GyKNG+bPGowd
         WVqNRGFW2fY3kqYMh4RO//bP6A4Elq03qvGxaTsuw80le+3Pc+SbU1fFio84JGDllNLW
         d2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399146; x=1740003946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb8NB3DXPVSxp8ymRsumf/Gc3u9+Crn5k7jX9QVoT18=;
        b=Rz4zOK6mmWPDBPbJpvHOhjE7GXeGhlDDWTtVJ09VHUVjPwLFC2c7q1DQV9xRvv/aBJ
         cdxqDllIWU3N+D63uLAnSia7paAn6Gi/Lsu0q5dKPYEqdXVQtmf/KWMDQq/6iOcmW8nO
         ojq17PA4WIO70jlFHK7NqLoLvd7oHlTnpmBpab5JmW6b0KSRcmvK9m2Vb2XZiUfDQEGS
         TmkIeTV/vd6WA3SL94wR8M39WFgHSKQyvFP2oKfW6H/5pqyDbbiaOjGCfxkoN6VPvNn+
         nu53Ll/btfqi6VGtxSVs29kEcmyWN9AyC8LWk82Tz6CAskOK8TWqGesakJ+4J7jA5dwI
         XTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRqPtz666o/lzSoMiq3gyg0d0XY2woopYTzhJvwEEDwS6PWdz4IkRufB+d/hdicF+wYjQB8Bet4wYA5d37Lifh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RgeLGeKs2P5ez6lRfKxgG2DsFx0Usxeex2wj6JFfyhFvVf/F
	6ZT0/gyUiwCHd8QLtizxgSNljE7pmWUq2ft6jYtEXS+wzLLRg9aFFacBQADyGbwrlpibRG2f9Er
	43aJftg0BtpX1w9sPMF9M5r7U1sLktO4kwXz5
X-Gm-Gg: ASbGnctIwluSY6Pbfkd5qB/KUmDTzACoB100waHvtACdjRMtmebTLNgrI3HCZfD0ocm
	zfQQusP4SXAKYmMA2F0Xz/r5vvEgA+Qszyte8uaMp9OlKyrV1SToahdnB+12dBj7gbBUFpdg7jo
	beeR7XQ+RV/v6WR3xkv+bEICnr
X-Google-Smtp-Source: AGHT+IEPi18vHfc6677zYsQWxRRWLmfPS/2RcM6gJqq5aFJEzAn2ciymxv8IrOUJUOw3+je2EcPOc6fxm7v4RthHM4k=
X-Received: by 2002:a05:6e02:2405:b0:3d0:5ac6:f493 with SMTP id
 e9e14a558f8ab-3d18e1e33d2mr339635ab.5.1739399145693; Wed, 12 Feb 2025
 14:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212221445.437481-1-namhyung@kernel.org>
In-Reply-To: <20250212221445.437481-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 14:25:34 -0800
X-Gm-Features: AWEUYZkOKMbZzWVbJGyBP-A50OG1S_X-IxmfIoNOeRJjPef2U-p22t0pd2K8YnM
Message-ID: <CAP-5=fV4w=y5-mFdwa8_UAxPYJeqnFhdXjyVic88CKwP_XdmSg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Use symfs when opening debuginfo by path
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I found that it failed to load a binary using --symfs option.  Say I
> have a binary in /home/user/prog/xxx and a perf data file with it.  If I
> move them to a different machine and use --symfs, it tries to find the
> binary in some locations under symfs using dso__read_binary_type_filename=
(),
> but not the last one.
>
>   ${symfs}/usr/lib/debug/home/user/prog/xxx.debug
>   ${symfs}/usr/lib/debug/home/user/prog/xxx
>   ${symfs}/home/user/prog/.debug/xxx
>   /home/user/prog/xxx
>
> It should check ${symfs}/home/usr/prog/xxx.  Let's fix it.
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/debuginfo.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 19acf4775d3587a4..b5deea7cbdf24620 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -125,8 +125,12 @@ struct debuginfo *debuginfo__new(const char *path)
>         dso__put(dso);
>
>  out:
> +       if (dinfo)
> +               return dinfo;
> +
>         /* if failed to open all distro debuginfo, open given binary */
> -       return dinfo ? : __debuginfo__new(path);
> +       symbol__join_symfs(buf, path);
> +       return __debuginfo__new(buf);
>  }
>
>  void debuginfo__delete(struct debuginfo *dbg)
> --
> 2.48.1.502.g6dc24dfdaf-goog
>
