Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04873BED57
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775085688; cv=pass; b=cmWjljdPo+GG2H9Y6c9E13AnrAeiPMuJbZ2HCswDTe3/1LM8i28fYoj8TC0vkXIXUyMLx+UbNw1C6aIH/3n3VSZsreY6HO775cL6/zXLzBfGBqtIO9Wmbwt9Tr2MgCbsgs3IZl0WIvgtvoHUphd5J3K/95gUWFqAoQoFXlllOvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775085688; c=relaxed/simple;
	bh=IB+U+GY+KxbiL36uKyB4RSNNY40VufFZcmTdlVCx/tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJdRV2WJdSzaIDuaGdhALRDq+BwJYRfFofrBmNXwhkDmv1zafsT6F6dKNvRRmKdeTQQOBy/vT4QxfVelkLV95Y9KCgyxXqZPl6kGtKVke0JhcLmmeepTSJ2/yRGojOjtdTOLdvfJaUXon8H8ZbkZeLYLD40b73C6V8raoy4VOpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHhH0NGk; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHhH0NGk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0b260d309so16905ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 16:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775085685; cv=none;
        d=google.com; s=arc-20240605;
        b=b2pBsUeYBNJP8TR9jfWwE5knGKI0Os1odvBbCxAQbL+iK1feVzquTVN5caVhBvHUvl
         VkZE//viChn/GdLcFRS090Y3XVf/M5DfWqg2FAVOkyge6srWlYJjTdF5N1koqNQnfTfW
         fEhIxsCRSgr/7qrnw3i0BxFK2YNEZyXd40RCx+swzIoMwz2RjjuWBT9hy4G+MVzNfxQa
         mb95qKopmM99gcxH3k2+yX3JO+E/Pijwm4EYowckvj9crQbojlAHbtUywfnaWpyMy2lJ
         gYo7r5oV0RsqXAJEFLTr1EcujLzrEoeFP5nGWDApz9OtuhS9RHXAgLT9S/s8M2NB2fIO
         bhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YjNgheL057Wk9CMYLQwXkpkqoKTy4FUlzslENy82TQA=;
        fh=mI26eF9FVm/XfboKHa4oWFtCg8nh9TAkrAmubniNJ2c=;
        b=jKlfZu041CMx3OFOFlIRjkqYexO1hCf2zbofbrqbctXAXsLqySf+daRxZblq1Pjh0o
         8fJIpN8+x40aDF8m3IM8eeY5cbIV2v4MHC9yZYh4hRwLfmIfPZa1Ru2o6IBmDLPny4i0
         gv9ipDPTdVLDtla9y+3WhciHoFBvd0c+GxXpXZg5lWhz4tGbtRUIX4DH4sYFqPkSOkQT
         WcwEbxZpfircakiNnX8wkhnU132wx1AXzla8BTBmmZSJUgclZud66mPZcDawOxMGtmjq
         GnzROoxj1LvE5pwLFftf71rn5DTwSVoJENo2zjAGh1n0kUK6ZS187Tm4UmttA0j4nd+b
         EPeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775085685; x=1775690485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjNgheL057Wk9CMYLQwXkpkqoKTy4FUlzslENy82TQA=;
        b=UHhH0NGkCvcGfAnkk5HOp1Hfx+zJS3kksSQwV5EOhDO6RvK29epYLhl7bCGupV3QSA
         ZCpmAP3MtT7TK7QsVbybA18d0X1iSQId1vOVtqQmMkSS3Q4akq9wF+cl03wmUxmKppTz
         XWE1375RqWt0NO3Fsl5wd9HYn9fuq5lLd5UMKekhfcE2au5KD+nEOlRWXMOvsjrV+otb
         iBAKU45RpxHBHyDBCFuEvpUz7JCvyxCRbOFHYrdPRVtyY7G3LQsUIzp6gW831mjZ35V+
         Fc1wqhQT9Sm+aOIPACZ38fNg/GVscFbejrRiYAHX/dT48XG1bjwxpOTStHY9v/tHnUzq
         kl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775085685; x=1775690485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YjNgheL057Wk9CMYLQwXkpkqoKTy4FUlzslENy82TQA=;
        b=f9jcMEs4lzWntcEdn7O5RqqfXsQfxccXEuuUnA2MV/JQfqk8EsyIAZh6028WCUCxKT
         BQ24vJR1lQnAzdo3pISLew7vmFSVn9dE2NV++IzPrGPb+vzzeunj1VBpXVee5Wsm6M31
         r2NfqvPzVSKYcggdHkhw9VGEw2hPiCatFEg0RVQEfXfmE4sGXDWX/mcLGaOnIe9RaqR7
         O7rBG95tnkW4snot7jgrs+UbTqguVu5Ohw2iwjL4BmDmZo4KzqFWcQimrs9Cs2ZqLgpF
         zVzYqviuU/TmVkl2dzn5dTmTmDrChdNN/n+Ni+6kXFd7nS2be1I7c99uQ5duoKDF0QZ7
         nOVg==
X-Forwarded-Encrypted: i=1; AJvYcCURTj4T57DFh6QD542kJojKfrPwBH6NXlxU08PGUOQ6XeMI8OV8r6J9+Ci8B1jxqzj37/ASUGvu2FIEFElYUUbi@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6lyRB7nLfNacKUTmIlfQE31vnn4Ypr++LXvKnG+K5MNvj1aI
	9vMloLiBHLwRPUJb4hK8Tz6P8T8WKU9YFY+D0DWHMp5lQZskvqDQK8o7UkeML3cXx14W06aJdY8
	QXnfb9FytFbazdz+vqJuF9WhQ+HC2eWSgg7HCdMtD
X-Gm-Gg: ATEYQzwD9eZtbWbhnIsQq+vBHGnJYznZeExXNX5l8adm4w6TurCCom5usgC6yjzrUzZ
	qoT6rD2Kbt0v4ZsU+JGbGXdz4E4yE1EoHAJU0D88bW+Ux9k/2eL9+p2V99MQ1oSLF9UYvVfp3xA
	5DpuWL4sjSGKHh+yJAP09qVFUK3AH+Gu8LIBVDakP3FmjrpLiP4c8oHELkVBHmNRT4cfO911sGQ
	OnqzLAmUq1wXpBr9HAcwDVCwOR/Sw/NAlzaSrwaCy2jPFWyEOOV8cDz3Wau0NWhKucIaqXMCXux
	BSRKqSh+DOzZj44y43Y8YetGlZSw8y/Pk80T
X-Received: by 2002:a17:903:40c6:b0:2b0:aee4:afe7 with SMTP id
 d9443c01a7336-2b278558ademr119825ad.10.1775085684264; Wed, 01 Apr 2026
 16:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401230509.1013742-1-namhyung@kernel.org>
In-Reply-To: <20260401230509.1013742-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 16:21:12 -0700
X-Gm-Features: AQROBzCAuf8ej4LqiEmOD4yv-oaYyePgEcpf0Ujl_3lOk7c-KM0tJ1Zk_pjMSoo
Message-ID: <CAP-5=fUYd1+S6SS7qOaPZ=xFurFsv_S6cMXkyogy+CCxpbxAVg@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Skip unnecessary synthesis for
 summary-only mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> It needs to synthesize task info for the comm name.  The mmap
> information is only needed for callchain symbolization which is not used
> by the summary mode.  Also total or cgroup summary mode don't require
> the task info.  Let's skip the processing if possible.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2) minimize the diff  (Ian)
>
>  tools/perf/builtin-trace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f487fbaa0ad60028..d121640ace6e1456 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2004,9 +2004,13 @@ static int trace__symbols_init(struct trace *trace=
, int argc, const char **argv,
>         if (err < 0)
>                 goto out;
>
> +       if (trace->summary_only && trace->summary_mode !=3D SUMMARY__BY_T=
HREAD)
> +               goto out;
> +
>         err =3D __machine__synthesize_threads(trace->host, &trace->tool, =
&trace->opts.target,
>                                             evlist->core.threads, trace__=
tool_process,
> -                                           /*needs_mmap=3D*/callchain_pa=
ram.enabled,
> +                                           /*needs_mmap=3D*/callchain_pa=
ram.enabled &&
> +                                                          !trace->summar=
y_only,
>                                             /*mmap_data=3D*/false,
>                                             /*nr_threads_synthesize=3D*/1=
);
>  out:
> --
> 2.53.0.1213.gd9a14994de-goog
>
