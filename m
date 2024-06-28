Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B71CD5C3
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599745; cv=none; b=mAGNEvJL1j5OxhBtyC9oLlCn4kswC0iIuJf7IzSrS0PjJvCkCLiDuGG+0HksOafFWLFXISYd8VFTnfR7lnvThg61b3wOyu/yxlvsDfW5LxX1mMrWCKrZ10u2F7aYufyFZ5wK4Q+kjJQO7YllLe9ZJFTdtrZLBUDRmEAN3iRn/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599745; c=relaxed/simple;
	bh=I2+vN1YtxeoCW1ZzBL6DjYHFnVPt3IlmCYIIwne0LuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUxl2wM38f3prXwQZ2/CPvt5E4hnk02NV1xJ6nK+Mhli++rj6xLIDhKmZCtlRYO6UvSJ1LaQaKuzj5zhhzo37wWzknnp8DG6Z6SWbpn5TgHC985vMfXi1ACwppZ36Vz5NpN6ut0DiGZlFvNsRtiQMwPyCzrjCFLdW3LaOiB9Rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJNYv2JB; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJNYv2JB"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3762775e9ebso21695ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719599743; x=1720204543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RErrAs0DK8wPplxpianYaV5QcD/2TCRDQ9qb3zaOQoo=;
        b=iJNYv2JBTf+A5JAIIDso1eauUx5zJN4FU0KCNgiuvEFfIPvbRJBzNAq7MG1uvuEZaU
         F/r/St/PGmFfl+uNvARkm17Gpj56s11hWWgklNWDwI/QCz6I5aKPF2ofw+jnDR9zG/X1
         BDgnPD69dw5zTozkg0wAd10+RlwR9i+MtkBuq6SUFT3/tfsn2XdbLE9p9sttdqm8pcGZ
         nB+mml5ZCuDqsfwUASOqZ3VH90eyUZtQ1kLHbMxg3fuWTSINjoM/7r5zvqzCfvP/zB67
         GS0R0MTT75Yq75sUDoj6GDBfqUiG9LN5CPn8Vr80+TbHDozKRZwMSUdYXkith4tSzBIt
         ht4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599743; x=1720204543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RErrAs0DK8wPplxpianYaV5QcD/2TCRDQ9qb3zaOQoo=;
        b=mwyDwqg3tr5Jb3VulZ/3RDaUWZXw6Q/wK+DFpwQJe/T8+PQ7+3c21vcroLfqawzlhK
         2S6JNtIcy2mxBvXZoXqAcutxLXyPwUstA+3sM1Hs8rqHTiFQBdWrfMvQDLU0dDRs1j00
         6U+fR+Ocrhiu+utJfIKI3+INdbzBsqd0CAmD3CIaPA4yq3SyxNldUBWRIZJLcZ6o2hKz
         nSNHTno0aPvszf7dZIEwVTkF4L/owCC/Kv0B094rVdgHLQlKc4GNeQCcZ7dJgx1Y14y7
         tLDsES597vUEvaKL48VS+qlAU/JGRqb3kSbZtdWXbpqfBECMIWEyUVKuVRgszf6HEawL
         snbA==
X-Forwarded-Encrypted: i=1; AJvYcCVf5Kait4edh6zpsMhpUJlJzW379cVW50syvF0E3G9WdQJ5e5qBf+G4RvI0Jwqba+pX0kkhZCLUtZZpTkY20p5CNVS8DyTc6EaUfwy/Ev+yuw==
X-Gm-Message-State: AOJu0YzeN8aS77eu4u5xh6nfWVYHdB3EN1dBzQ8RHXfwPtPdLw8BHOcq
	rzdI7tgBkMDPCffiLyS6RdSJ7fVuFIgxsmHJ/ouHSfb3HCdK6uRsL9MjIx61ZK4eiq1efhDKE2K
	uUtocBtVeWXCr2KFE/OxsMkvmhQnQp/Coh93r
X-Google-Smtp-Source: AGHT+IEIdTlPMI5QX/9NDYi/RpkgzP+Z+ZzXVhld5+h7yexSsH86cZjoenbpLMSq/Lli4Dab5ND8vBPfg/LmAoRXHrM=
X-Received: by 2002:a05:6e02:156b:b0:375:eeb4:78fd with SMTP id
 e9e14a558f8ab-37c42e1f27emr210045ab.25.1719599743167; Fri, 28 Jun 2024
 11:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628183224.452055-1-adubey@linux.ibm.com>
In-Reply-To: <20240628183224.452055-1-adubey@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jun 2024 11:35:32 -0700
Message-ID: <CAP-5=fWT81saq2m+zaXrCsa_V-aqyZvNXDbQ28_wNSBo=-nByw@mail.gmail.com>
Subject: Re: [PATCH] perf report: Calling available function for stats printing
To: Abhishek Dubey <adubey@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:32=E2=80=AFAM Abhishek Dubey <adubey@linux.ibm.c=
om> wrote:
>
> For printing dump_trace, just use existing stats_print()
> function.
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-report.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 9718770facb5..6edc0d4ce6fb 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1089,8 +1089,7 @@ static int __cmd_report(struct report *rep)
>                         perf_session__fprintf_dsos(session, stdout);
>
>                 if (dump_trace) {
> -                       perf_session__fprintf_nr_events(session, stdout);
> -                       evlist__fprintf_nr_events(session->evlist, stdout=
);
> +                       stats_print(rep);
>                         return 0;
>                 }
>         }
> --
> 2.44.0
>
