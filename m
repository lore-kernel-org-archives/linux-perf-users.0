Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AB1990CF
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136828; cv=none; b=iSw5zNPhrEcQpbp9SFHU2N+o4jZvOReKXRjltbD3cz6N8M65iR23kD9yucGkLEUusqfb2NQBrYxVtBRxRZGyYEWLBEmbuyqCdEW9+WpqLB964In8fnrHqhKuw8ZIdP45Oq5ibWStrMN6YRlJ2AvgxFXmdgGDiue9EqvT6lEccIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136828; c=relaxed/simple;
	bh=F58GozdUKArNO0YBXAKBv4/LUo2VIkWG9yLAJkk+NUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcAz4xGJYyP3NGCxodgNXp4/Yn9stgBno3ukg5tloe1qbGX/ids+lF9zG6xkm7vqafCUFyLfx74aZNDUV+xS5d7UauFELKrQuWz2mnv7h21XOjnspr/yU16BCCmtqOiKQWJi78iiYCu8cz6b3Yt4F+C4xM90ALcQUawMSMYACX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QePZ5VZn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QePZ5VZn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc312a36f9so205075ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721136827; x=1721741627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiEVpCnl1fW9Re114XQTxpk9OjUT0iHxZmwQLd+uqbU=;
        b=QePZ5VZn2ZbszAXOCPC8NQbCfQt2vzZJvY5j3jC1072DSeN8SAb99tohEk18tMZaXS
         tV1fuC+P956s2Jp50Wzrb0pZ8aknIDZu+zxzqhZtc8TlKs+RtOqN22bg1VL4perkW1Gv
         ZtUE6i6l2764wcAhpI09V4TlJyryw8zWwwDVlum7qJg2X0oRWSGy4qonAdIxM/XxX+rf
         gYvu6VcgrzwzQbaf5NateQW7L7QnoM0tedCXQRihcF0kvXxgH0U12onexBZAC8WV0GXl
         aRFzt4k6y59tG/XHOY3G89VpAKFErqgVZivWPaaQyBe3qshGob1JWvib/eXNqoNJtlyJ
         /R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136827; x=1721741627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiEVpCnl1fW9Re114XQTxpk9OjUT0iHxZmwQLd+uqbU=;
        b=mawNkTh978LKbiq/1/ijWFyId+PTBN8cdzaNWL3eZHkN+KpUX4/+S8tEvk/99vzFVc
         rmYlSCfOiZELGBJ3fEVZBqvHpyIQu4M9I8SgUaUuLw2bboIQWZiFUiihwAouRwg84wWI
         LdAv6iaizGx/9QlLIKXTNEb0U/+rqG3Wru4SJSf9o00pqb4ajrrWLZq0MdoXgGeHb9qy
         EOPQohGaUMs1G4Ie2WV1wY34v7qIEwL1JjPQ8GKAdh7/Da+eYhrqb1q3rRmimK43gKGi
         DmEtdA6jzkbku3IOmatjFddfloWjKDb/B+VqzhrG2Eq0vDFJEuIT7oPAPTGgQYuz76NR
         KaOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+F10wtsdMUm4liA20HnMXPk711fyUi/pperYMxyaBwQ9+K+02Fm8UcCnnloX+zA86bnGuaqVGZUmqHyKMsTPAPl4am6P2qKsYdBDSZanohg==
X-Gm-Message-State: AOJu0Yx+1Uik37lwyc9UUzuJ0fL3EO4BWuCJgjItwZvsVHRoBqyoN9qf
	LUiLa8mp8iFTKDcAvJjOdb15eeCknm1qtX50uYTIlBt21ajL/M/WrK38JWjdmZVE4VxDzu+ymPa
	1C+tKcqBBLJqXVTONA0BrOmAagGt0ZRRVHBqM
X-Google-Smtp-Source: AGHT+IEP+u5GtQoC6Lj8z1CEEquWLTp8ZGZ24FO5mM285ePjpp8DQWKKcurPu/Vr94TE1b+70Is/54GL50akMx85sGs=
X-Received: by 2002:a17:902:d48d:b0:1fb:d79:fe1f with SMTP id
 d9443c01a7336-1fc3c7dafadmr3136135ad.24.1721136826554; Tue, 16 Jul 2024
 06:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716074340.968909-1-nichen@iscas.ac.cn>
In-Reply-To: <20240716074340.968909-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 06:33:34 -0700
Message-ID: <CAP-5=fXn_0oudWiVgJ7pgi7GW65HrNOVaAg71c+JjfDnkK1cAw@mail.gmail.com>
Subject: Re: [PATCH] perf daemon: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:46=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: 2d6914cd59ff ("perf daemon: Add 'signal' command")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index de76bbc50bfb..18f7f417ba11 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -1433,7 +1433,7 @@ static int __cmd_signal(struct daemon *daemon, stru=
ct option parent_options[],
>         }
>
>         memset(&cmd, 0, sizeof(cmd));
> -       cmd.signal.cmd =3D CMD_SIGNAL,
> +       cmd.signal.cmd =3D CMD_SIGNAL;
>         cmd.signal.sig =3D SIGUSR2;
>         strncpy(cmd.signal.name, name, sizeof(cmd.signal.name) - 1);
>
> --
> 2.25.1
>
