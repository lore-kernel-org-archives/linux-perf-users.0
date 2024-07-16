Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A517C9FC
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136810; cv=none; b=s1iIk8Dw8SpRQ6YAWdfLWw0Y874+Yi9ty62YzK0xb3jQr1khCMIyu3VnCfX85Ouht5P888T2WFXtPoX+8+DWL4eMl/wqthC4ldZxBej+HOgNjowJNNxF0acsxUprAuz/vedkxjS1bfB/g2WnMJohpRvaO9aB8UXzHH4xWf03I24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136810; c=relaxed/simple;
	bh=3ifhAK+wKZjxrm5xHO7gEG47OLYw9Ar/XOiTcjWJ/H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABiXguBrBkCqj7i60nB1Ib9t687I2Wzy5WYnokXuLS6RvNp4iJ2pdN+B5qJA/rGgn6pVfFwIlhhJzFDbo1HOwCNv2uvAF18L+2FEsdpJKF02DR1CeFB0yFMkqOvBHdo0NW58Lcy/Vc6S9ifJSam8VPhSJ91PJXHQLLyy90M9OB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3yIrbZD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3yIrbZD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447f8aa87bfso415591cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721136808; x=1721741608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob7sez5ZcWf6Ala9z45pcOnpMuUA/8tRQrl/dXQmJ7M=;
        b=b3yIrbZDBB2hp673qFL+JAtsb11TE7TMoDkT/wjuHp79dht51Mv7Qx2f00ZOu6twGN
         jvIlvJor6OmQJn2JrXggHcEJGu9+0EOimdzAByvVgRL4Iyg2agYd/VpflFzzZT+ERibo
         XdCIYJrQoHbkWSEL4yQN+TmjwPN6t23yQVGHFeZv3FzmvMKO8yV2dlN8WXyd7J8FYqlk
         +Ak55Usd0eY/HA2dkwOfy+BAIpbwJiZ0f/Gg0kQ+FUb9Wbb02yyd91cAFaJFFu/jua0C
         zPDi3dbiw2VnELFwCICbHp0MzS6btkOrsxNYJbBEvfM9HkFLBkppj1VvwgLaWkEIiF4B
         0cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136808; x=1721741608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob7sez5ZcWf6Ala9z45pcOnpMuUA/8tRQrl/dXQmJ7M=;
        b=KY8CZTcdUDxaAx3z4RY/c3XHaMckjso5UyJceIycLxLY1KMC06Ag0PJEcuvLVzs0rK
         mD2YVIc9A1hVMvFNeSksayXNzz8RHamgJsBLtFYnjWM261TxtPO94BwVs39/aSxr3/ia
         lTbYI0Dfxo3WJ1WpFkd+0tmJvCUa5wJLfow+PWz+8KFxZRuJSapYGxhc1txKKqnI0d7U
         d6QDbyw8ZeOTS9usu2/gGNZ3CBHTaN56i9NLHDJYQUSHWkAtlBP4kVCIF4NTZTI5WEiI
         geDbJDFSVSmiqimw3C8nS53YoD3PO/w5Hw67MLZuiDxtsIMvKOV1qwTzuIvg6gKQqAxa
         Qqrg==
X-Forwarded-Encrypted: i=1; AJvYcCXbgJLXI1RRZDOAX/BjthbB5S3/ikXDfaY0S2HLveZSf3hxxZsrvpPOmTbPzoUie7qL8LE+Jh4KpBEmWywzrCvuYhj/kVz8kqpKFKXm+aS1bA==
X-Gm-Message-State: AOJu0YyzAFmz6bMKkjR3CB9ufrlTmIHqAITorYUn7yGmbDmWvauz6nQl
	9i5NccWDvl/5bXIvcBdVpxQOBEpt2kuVTtHHZlUZDFmMY+RoghsOU3diK9Ec3Gw7Nk/HdjqpOxY
	g5y7dWrzkA9EksIP4xwiYMAKNt8qtVvgrUUrgHFV8jF0JpMelFXiS
X-Google-Smtp-Source: AGHT+IFgY5uavdYYYKUEfwZ4LIzbj73bPrEesxfgb4pXqt9X3Nas5f4MQWGo/Qie0NUJyabxWv7e6TyyIfeeqrasJ0o=
X-Received: by 2002:a05:622a:4890:b0:43f:ff89:dfb9 with SMTP id
 d75a77b69052e-44f7a64d4dcmr3223261cf.6.1721136807556; Tue, 16 Jul 2024
 06:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716073405.968801-1-nichen@iscas.ac.cn>
In-Reply-To: <20240716073405.968801-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 06:33:15 -0700
Message-ID: <CAP-5=fW8pVzHD+AN73Y1WLBSqf9LLHtnwBkuuZ2OLK9sCmv1ww@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	nabijaczleweli@nabijaczleweli.xyz, penberg@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:35=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: aca7a94d6a59 ("perf tools: Move UI bits to tools/perf/ui directory=
")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/ui/browsers/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index ea986430241e..fe991a81256b 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -985,7 +985,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struc=
t evsel *evsel,
>
>         browser.b.width =3D notes->src->widths.max_line_len;
>         browser.b.nr_entries =3D notes->src->nr_entries;
> -       browser.b.entries =3D &notes->src->source,
> +       browser.b.entries =3D &notes->src->source;
>         browser.b.width +=3D 18; /* Percentage */
>
>         if (annotate_opts.hide_src_code)
> --
> 2.25.1
>
