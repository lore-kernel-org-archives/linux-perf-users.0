Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E96224ED
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwdQ5Nh8"
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55528123
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 16:45:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50931d0bb04so1799e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698968742; x=1699573542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzVKlaiod0CngpLisgCRPf+f2Cpx/+xdbOa7NmPeDT0=;
        b=vwdQ5Nh8LQNmRryImuVdi64KmuYJvuTlrJPsdqUn5OvwP8XgsO6sKJVMrUbx65P8ca
         VSZgC++sPEq7R2G/QCjSFGtT+qjHp4nwyD+SGFo04LVxlhsOcwF8LiJ442fx+wd8SEdB
         yG9dydLp4AzCmvmkcBHGfwfY2UrwrjBtg9KIvGaZMSlYwtyRVWfJFuQgR+kuhXt9UiZp
         ARfv7M0+0rn6jcgVi0C7S4UHSa0mP1JD4NkyRdKy3QLGcNHWWXxC19h5nJqyZwPiDCPa
         i8vS/Nd5wIDn0as3rOFicAJjztg/5aHkwvB2K9Qf0AfXryV78E9Kgz0z6jjW2aE1HotR
         V1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698968742; x=1699573542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzVKlaiod0CngpLisgCRPf+f2Cpx/+xdbOa7NmPeDT0=;
        b=q2J5ctyxIunWcPaf1J1z/+MsutuMcRgumFBGrngeeiuKzeEYhyK5o2aEe+2ecn+Df0
         wmJBaYzfuPspVWTm5ZB1q+DsIRHUiULRnr22NJl7pS6yE6HdGtCxjpa4mGFEyVCOU6bb
         v+GDH+w6iK+QdzuF+43LrGU3sBsb3kRv4xhTbByqgI50CMzDUchhbc8ER+smM7naCr3P
         9nPuy3+yKsGlsNAFipxuHmjzvC+BgunsarMiWrQjDfAZDYmOEV/3UvQRtn+okbVNhSiY
         gRguyFM+RSlcKY2HVWtRdQypp19PaEyf7O5AViAa++8G42PwCM08LIV6WwSjridaK64x
         00HA==
X-Gm-Message-State: AOJu0Yyfy/CC3M9W+9PmOfs15A+BOSBGpoFbJ4B1LW/V+bNb2vHekJs6
	w/5G9xqZb/gSMoxhj7iEOjW8XDTQM+Kk9PJZLLOu7w==
X-Google-Smtp-Source: AGHT+IExGe73wgTrfJdzRkVPgDFGBpgEqEMn1dV8j06kzT4rwg9Y3S46q7dgumgQyjs44vbdPYccDR/eeVAiQIAPDvs=
X-Received: by 2002:a05:6512:70a:b0:509:47b9:d9dd with SMTP id
 b10-20020a056512070a00b0050947b9d9ddmr78141lfs.0.1698968742391; Thu, 02 Nov
 2023 16:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102161117.49533-1-nick.forrington@arm.com>
In-Reply-To: <20231102161117.49533-1-nick.forrington@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Nov 2023 16:45:30 -0700
Message-ID: <CAP-5=fUDMe+UCdL4ZFtQat+xLOEJ96PJAD1E18wG6NuLRpygRw@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix man page formatting for perf lock
To: Nick Forrington <nick.forrington@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:12=E2=80=AFAM Nick Forrington <nick.forrington@arm=
.com> wrote:
>
> This makes "CONTENTION" a top level section (rather than a subsection of
> "INFO").
>
> Fixes: 79079f21f50a ("perf lock: Add -k and -F options to 'contention' su=
bcommand")
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-lock.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index 503abcba1438..f5938d616d75 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -119,7 +119,7 @@ INFO OPTIONS
>
>
>  CONTENTION OPTIONS
> ---------------
> +------------------
>
>  -k::
>  --key=3D<value>::
> --
> 2.42.0
>
