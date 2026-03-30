Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E9126C03
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904423; cv=pass; b=NXqt6GfTntyf2veSvoxJbGH5+if2VvJ9SyelweAuJRIwHpK3wuyoahW1rEKZlVAsUEZ7xRNDRawm504ZzRoL8Fl2UciStuTAzOoJrwLnBdxOXEmJ9K3wVvKossW+wQyQVPnx2HmaSBNFrZ/Fzaz6XK8O53u5y1OtUebW0NXMwQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904423; c=relaxed/simple;
	bh=P1rAO4ZGTPGIG3e7w3/kupzNSsV9k7TNxFJ08mPh5FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7vjr+oNrV7OmGpoKiQ6dhQBs7DasGlqmaOk3w/SfbVVpfgZ/dAl6S/sowRxOpysEZD7cMakP2kkJJ5/G8R2TEqhHwU2kAFLI2neo7PgahQcjT7MomGr2mMHBW4NNw1mfaC/x1kuZcJwZOadXDUTodRkKlA2+PxBpwd9nGKa8mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSmlie0G; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSmlie0G"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b243198058so9035ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 14:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774904421; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+iJKTZoCfKQBeKzpfYPYxtDX/GvrFu5M4UVly2zD3v1PPfkY2VNS/OTcc/kNxdbTJ
         09JJh5pbLhzifuaQ83EmL9IaFZSbPO6Vz1dS53x562R78QA7H07uDFMHed6aUAaQ9FLq
         0gca8TA1t5QEdg4CRMVmJ5fLM95FH+sWDXzQy1MvmSq7RRR5UnJqStX84sKs8KinNUGh
         4S5BAkgjH8Kxhj0cImD7AkbeCTincMXsQUOHak3VYSHJJ5pjNH8bo/CBkl1QzrEZD93+
         qX3+lNWLEZYFeFXdzmlITzK8cWq8Lo7qZq4VUzKz9f5YYKbR3XcXKrPjyindn+5n+xPZ
         xF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDA9xJ9lRzMR9DvxmOsOLqIBAGmyJ+xOA+Bb7hJkHL8=;
        fh=2vChYF76DaeYjD82dOkL5SsQs6ObupejQi4ZaqQKnWM=;
        b=OGtUNPwnFHSeUieuXKtgX19qdkmN9XRqygjkgwZ9fZD1a0zq+p6iebt1ID2t2o+KN9
         BTgAzijW4PJHEBPAjbccLeRHgmWUVtsayl8n2UCNsBzX9HkHxz1KbjaZXAKkWQJjpHDY
         aWc06ZjDQ5IFHfWxi2l6iBRNd++ptt06sgX7SPFvEBmCiCpsX3XSw38luLOUgzLpNE36
         +m8HIrLeQpGSIqSN7fJNdZu808LnyK8GZaBcliX17heT0h8BGJXjdroJ83UMPFaXx/+B
         7SuY1dBVXrYfcxjCCxM3QWh9keOYn5FhLsLjF/v3CjmdStNutDf+9sBp7iM8svGembn6
         0QnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774904421; x=1775509221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDA9xJ9lRzMR9DvxmOsOLqIBAGmyJ+xOA+Bb7hJkHL8=;
        b=vSmlie0G1grSbp5CvsnXKUN1XQLuJrp7EB7XJhOPE//Quyl9ELYZSI5HkvOuTyka9R
         dvU7TBJlGF8lLpQQfxLPZq301CuWBTxTM6u5Jn/DttkeSs2RmgSkK3J07P1rNLQwmb0X
         O+OZiWJjHiyvrITmdGjo4O4blE2N4QNl5x7RkTR6rb06QMDjN8w3B/u3h0RSBQuuq+t7
         IlL3J+TP0S0tSbShyqY7bMUubNHQmtJ7O4fzVTb3IIVhPpDJydwPVr5pAa9zMeX50UiT
         5UYQ9zEPN98ij6KWEWOypUTxhkQKZ2k3uyLNrIziyJEGtfTLp1Y7vdbRVSXH2cwTc1NL
         8fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774904421; x=1775509221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDA9xJ9lRzMR9DvxmOsOLqIBAGmyJ+xOA+Bb7hJkHL8=;
        b=QMshEioICjucdkgsFGX62PwutIX8F4JUfIF1lv7Kl6sqN7priizQVTgxrkLFbw13Lf
         ucfPhWhK25jwmZ2tpOXMU5HSvQU5V/LeDThgKAlwo8fgJdFauVagjdkyGHebQjs5yrbX
         4zg6lPD29FlwIXRarGSgK0SAF/THtN111lPd3T/z4+vpVYzu6BfAbRaWUZc5Hfq4leXv
         caASyui4DdX+WOGmm1c1qdPxmQx8+T2xmOIKEZfhMFPqY5hXuWzfCcA8WzDFlw4g+H+r
         0LngEdA91+X/rV7qRaEhfU8hbtwayDCn7S3ON6QgpAsy+HvHYk7ZqOW5RR1LqW9IWur6
         27vw==
X-Forwarded-Encrypted: i=1; AJvYcCVSBIaclzdKVDpSec//2hSkbD09n2PNque1ntEbyRIOYj/wPWXlDcoKptzw1RWrRD4XtPbgKS3G5aQO1zHXe7aO@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXI16NmggdzpULGdotgjNYgeQy5SS7giBtRK3IDWZA38KBza6
	BB//jy7h5rQRWzxC0ud1+98n2FYtWrR5YErDFhxMiWsUvHrxVAVHqGMx5k4PSj38P3yIAK0P+Y0
	Jj4LzLI3NmhZL4G6gcoP/5EO+s8Il9k2EKML8+1xV
X-Gm-Gg: ATEYQzz0ad4MtQdLpEeu800qRM8LCoSyawPyzDJBgWOK7L07yXDOLgnFBSAlVP0I6tx
	1+v+7Aw3AQlNWNRwwobqOkfMW94DkORr//oq/CwA31NY3/9KB0O38f+O68yo2j7yDEBdQuUvxtF
	ocgF3ja1Z7ZsqDjjIyUzjFDwYy40Tzfl4Wj9HHkQ2FatQ+YCX8JUl1aZv/x85vIb0L1XCIzmj3T
	qPU5tl+tXLX55Ze/zKDPw+F3j5jOwDtSNzMgCsxXo+TZh0NBJcnEnnMTDzFJErTR6J3N5RnXbw2
	R9zIAa5NtYUOVv4tUp6RvlxRJgZZODifMpxtcA==
X-Received: by 2002:a17:903:22c3:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b2604d195fmr202385ad.9.1774904420712; Mon, 30 Mar 2026
 14:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330201439.689899-1-namhyung@kernel.org>
In-Reply-To: <20260330201439.689899-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Mar 2026 14:00:08 -0700
X-Gm-Features: AQROBzCreX1Q56mcXnrbRxp7e0OxMzeLjq3Uns2OCNcnEs6parp7CuUceCvPtIw
Message-ID: <CAP-5=fV0SKCOtYoJGUuui116wnbowZFcDu18tvrBQTiCF_5g3w@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Skip unnecessary synthesis for summary-only mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It needs to synthesize task info for the comm name.  The mmap
> information is only needed for callchain symbolization which is not used
> by the summary mode.  Also total or cgroup summary mode don't require
> the task info.  Let's skip the processing if possible.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f487fbaa0ad60028..d09d78b3222717d1 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2004,11 +2004,23 @@ static int trace__symbols_init(struct trace *trac=
e, int argc, const char **argv,
>         if (err < 0)
>                 goto out;
>
> -       err =3D __machine__synthesize_threads(trace->host, &trace->tool, =
&trace->opts.target,
> -                                           evlist->core.threads, trace__=
tool_process,
> -                                           /*needs_mmap=3D*/callchain_pa=
ram.enabled,
> -                                           /*mmap_data=3D*/false,
> -                                           /*nr_threads_synthesize=3D*/1=
);
> +       if (trace->summary_only) {
> +               if (trace->summary_mode =3D=3D SUMMARY__BY_THREAD) {
> +                       err =3D __machine__synthesize_threads(trace->host=
, &trace->tool,
> +                                                           &trace->opts.=
target,
> +                                                           evlist->core.=
threads,
> +                                                           trace__tool_p=
rocess,
> +                                                           /*needs_mmap=
=3D*/false,
> +                                                           /*mmap_data=
=3D*/false,
> +                                                           /*nr_threads_=
synthesize=3D*/1);
> +               }
> +       } else {
> +               err =3D __machine__synthesize_threads(trace->host, &trace=
->tool, &trace->opts.target,
> +                                                   evlist->core.threads,=
 trace__tool_process,
> +                                                   /*needs_mmap=3D*/call=
chain_param.enabled,
> +                                                   /*mmap_data=3D*/false=
,
> +                                                   /*nr_threads_synthesi=
ze=3D*/1);
> +       }

Could this be simplified to something like:
```
if (!trace->summary_only || trace->summary_mode =3D=3D SUMMARY__BY_THREAD) =
{
       err =3D __machine__synthesize_threads(trace->host, &trace->tool,
&trace->opts.target,
                                           evlist->core.threads,
trace__tool_process,

/*needs_mmap=3D*/callchain_param.enabled && !trace->summary_only,
                                           /*mmap_data=3D*/false,
                                           /*nr_threads_synthesize=3D*/1);
}
```

Thanks,
Ian

>  out:
>         if (err) {
>                 perf_env__exit(&trace->host_env);
> --
> 2.53.0.1185.g05d4b7b318-goog
>
