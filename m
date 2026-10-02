Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066D4CEE45
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961249; cv=pass; b=YbwZPI5sseL+VEa3Cn6S0wewjec577EoGU9ElFumDyWPGGMDYoPrRH6TnNaZRLBukAINfAraq9g4rE13GDWOVIffALqEoQ6Z4CcF43jDbeEOwlVJH7UqVIDyxbjpnTOTaa5G2Sj8QFLWhjkvTTf9i5k78zaN30M7jjj+QTciZUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961249; c=relaxed/simple;
	bh=V1geDr4Q9jb3CHPs03vi1oxUrTZqJBIQgowXVd1lGE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxASd6a88et3kFHB7nr27luJ/SNAyfEw2uHBTpjc+gDlVeaK14WbV7PebvKPKFAF97X7wufPMFAFEvYH3CPdd6B8+Bxr00ChkXe8HGR5JaME1rqyBaLXotjBRBD13ZWcc6awBHLXBeYsNDDU5su5T688Uy5Jzm7C3AJ7liDhtms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOJU3Jyt; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOJU3Jyt"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so4862033eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790961247; cv=none;
        d=google.com; s=arc-20260327;
        b=OKC7veH8ONEN1nZFsGwhnvrb26WE1jo1ltVXCfaLqZbcoRn6FrSblSHqz1qfg2g2n6
         /N+8KaIop1gJSkYcqU4gsPCkJU+nTIFwk1KsueV8838QvI/qUfoWmLsjRSTak0EtoCJZ
         jUlfIMLrYGPPuT/ODqTaYNT06gIY9pRa4jkX5yUl6kTFbkRjdy1V/nG+K+lgjkcJA+zf
         IfbrYHuGzaKq0ikw2eQBzXtTt6JUhUJP1gxXdlEG0vu+wPbbrK0yOF6o0Co26ShTufeb
         sjJ16tzjvjc8SgyRjbjkcF2AuHR6JbIOunGtWjoC98SpYEcmd+B+huixViraOANm7Xfo
         H6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6PocmUxgWMjbbvGJ9B7t0eFYaL42gWwJOSSvEAluiu4=;
        fh=jG6LBcXqTFI3CTTx4CgBOiimk05xFsYDrXFT7Y2WBhc=;
        b=otYtmXiL5347OwDv3tSTTe7jZsMobwEUSmeD+3G8uMqe7g2taho2XEFF3gMnCltyrj
         1LDEPWTkp28hl3jZFbk7ErSBBIJc3agIs02bh74P3bciVt/W/+rBv4SOWYw8QWPUX9Ci
         aglbA0nunUBfIGgN4PEGXkrhUk62vkS+0t/+bOeTX/BjvoG9FCMhO9bIn+FGfBAGpiOk
         jnt1ZdGjszg13cRmggmCuj83bhTfzief6R19AIvZdPEZnEGCPDRaFKk4ihBRcooV1aRV
         wb4Aq5ui+QAa5dZ0jvGjY1bdcs9pgrh2Y9Lkrma8wJF9F+U6XI6sXV1r8p7PIyHzNf8U
         7gfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790961247; x=1791566047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6PocmUxgWMjbbvGJ9B7t0eFYaL42gWwJOSSvEAluiu4=;
        b=eOJU3Jyte5d8ySoZ0xhWAIqIjGNtmgbt3M9ra3cQsUG8NdPttcDlJFCmWGx1Cjexy8
         GOYxwgTmAiOIRjZgFzRHJQJMN4EmKtiS3MFG5aenIIne3t1BaPKQBURMB5t4THWqd1qj
         lECPlCihVGjkBPYRlsYSyF5kOKlDxFmxOn2ry84U4SxpX8BzSWGcYJJa19dG7NQbhdtE
         T0bz/Z11GVO1NYwzYoDINLVYkBHBxbqARfnl68ypkDt0Kmz8VfzjtWedTrQ4R/OGNlNn
         kKx8ZaOVR5Z07+8f5Qvb+uMK/2tffSvRBUtJPlz0eSiLDKU/YhxvOJMqRYYU9TwG2HV8
         Z4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961247; x=1791566047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6PocmUxgWMjbbvGJ9B7t0eFYaL42gWwJOSSvEAluiu4=;
        b=XQtSzNN8sYt8SvW1JyuX8MOaXDvVaFu7psmkakjMMX7TpfByMDsHzF2YJPI3K2PVN6
         9jBw6riuDuSzwj9DvHNErGY++m3Jf9WcsJxMq8h92mnOYeV8bE/B64Lko7Hv0CmscOhW
         nyVqpOZ6AcX1spYaeackiGM4XMWgohV6rrhM+T+08D4tRo3eR2a1/uzUnVxRhMvB2wWA
         g3rdyYoxQ/g4JFg7aYilS+D72OLlw1Ls6qHSipoaGvbVMaRkwdeiVz1K1eEqbF46s3ze
         snK1DfLKcQKrmlRqOaIxuZDXvucepuhsOKZlSydD8ChtO21hnmiNGOskUQSZBmkCBGzk
         VslQ==
X-Forwarded-Encrypted: i=1; AKwUvByqJLdoTXMAIzbD76z7iJzfnIrV8zgVnyfm4g6wY+iYG4+ZxbX2BFyH1FYJLdvgBwTvlvi8Xk94kRK5sV0kt41O@vger.kernel.org
X-Gm-Message-State: AFuF++klPbDL5rUSJBUuNmXMDsAAye8SkE7omK6FJ6YZ1v007JYEzW9R
	LseLGAidW9yLBiTzaxlvzqLiVSQBNCZBuRrmaoYOZynGhyYlzbRJ4YNeUi80scNeojE3+AOmNS4
	t3oTnQ13PCVs/czPIfyeLbmCQlia5Jvk1lMMK/rFA
X-Gm-Gg: AYBFou2EIySVD/cmsauMM3ShbCHTaYyOCO05GxhNrdZaAI1oEb8Fq3ktUwMEfWvXi9s
	Zfwgdgyd9ANGXzDTmwijz/E94WNhSpcxIs2/EZC5AqqF5bs15ySiP79evYt8PFwfO+WwgMJtBZp
	xQR1OMMt/op9db4k9nmKEPosx2fqaxszpeJ/Q2Z5pY40dj0ECTE++Y4KAycCPr/pX24ZYgNTVA3
	K6wd4cH7EkUTjdU8Bxey1AQsB+3HauNsQR/Jg+rNkpAoMM/2q4mHUqVtb09EsYSoMQ5DZpYJ707
	EF6UvA0XkoEehaSwUDzb9yXEuw/rujA3kvNMspEhE4nMgJV5OrOdEZPSAnHHvMDoyy/MqGBjR7h
	mENc1A+NZoQ==
X-Received: by 2002:a05:701b:240b:b0:14e:ef2:87a9 with SMTP id
 a92af1059eb24-14f5c7e226dmr3813823c88.37.1790961246440; Fri, 02 Oct 2026
 10:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002054832.64980-1-namhyung@kernel.org>
In-Reply-To: <20261002054832.64980-1-namhyung@kernel.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 2 Oct 2026 10:13:29 -0700
X-Gm-Features: AclHuK9VhxPkDkfZkrrejoavaGoHEbztoCol2C-Wir0VJ8hdF5f0ZEuZfD3egGA
Message-ID: <CAJpZYjXK2qhkCn_ixge_1vEKjXzn_4tzPT=i9NqYg6HbYdWG6Q@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix aggregation of cgroup events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I got a report that perf stat with BPF and cgroup is broken with
> aggregation like per-socket or node.  On my machine, running the
> following command shows the problem.
>
>   $ sudo perf stat -a --bpf-counters --per-socket -e cycles \
>     --for-each-cgroup /user.slice,/system.slice  sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0       12      <not counted>      cpu_atom/cycles/                 us=
er.slice
>   S0       16      <not counted>      cpu_core/cycles/                 us=
er.slice
>   S0       12      <not counted>      cpu_atom/cycles/                 sy=
stem.slice
>   S0       16      <not counted>      cpu_core/cycles/                 sy=
stem.slice
>
>          1.002798147 seconds time elapsed
>
> That's because there's a logic to make the whole event failed if result
> from any CPU looks bad when aggregation is enabled.  Normally it
> considers bad when an event has no enabled and running time.  But it's
> possible for a cgroup event to have no chance to run on some CPU during
> the window and then it will have 0 enabled and running time.  Let's not
> treat them as errors.
>
> After the fix, the same command produces:
>
>    Performance counter stats for 'system wide':
>
>   S0       12          5,094,112      cpu_atom/cycles/                 us=
er.slice
>   S0       16         28,075,944      cpu_core/cycles/                 us=
er.slice
>   S0       12          1,516,568      cpu_atom/cycles/                 sy=
stem.slice
>   S0       16          5,569,575      cpu_core/cycles/                 sy=
stem.slice
>
>          1.003231856 seconds time elapsed
>
> Reported-by: Chun-Tse Shao <ctshao@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Chun-Tse Shao <ctshao@google.com>

Thanks for the fix!


-CT

> ---
>  tools/perf/util/stat.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 25f31a17436828aa..6da3dbbde0e2ad8d 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -381,6 +381,10 @@ static bool evsel__count_has_error(struct evsel *evs=
el,
>         if (config->aggr_mode =3D=3D AGGR_GLOBAL)
>                 return false;
>
> +       /* cgroup events may not be scheduled on some CPUs */
> +       if (evsel->cgrp)
> +               return false;
> +
>         /* it's considered ok when it actually ran */
>         if (count->ena !=3D 0 && count->run !=3D 0)
>                 return false;
> --
> 2.55.0
>
