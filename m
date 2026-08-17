Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C853A7F78
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003141; cv=pass; b=bHbu4PuWwKU8k/n89HQbjvTongCiR27VAoW9MMH6sJcZklTy5lGNBaj7SQRJ210RxEv2cqF1FOL+vz/KXhUoBY1IQj/vojqq28IXKOhA3aChvzbWclLkECGliRwX6kJAMSS5MI9gE+oyAW2lVrQ4OiFDyOkXZAf10DX4EhSyIXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003141; c=relaxed/simple;
	bh=eGvWQvIgUEdfGOvfdB57ig30AbNFOhpFJjILJd6Gjqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0n/Rf9EU8LJmyw6AAlaND9ZQZCJS5oDhLGL87WiqYLfctHA3FYj7X3Wnj6ozglN/M+uyU31tyFn6CZPuSMacxy5I5UX7RTXVlwTHE2Dh96y/0NPBmECO0hiV6Iqxeb8twZG4LT/Sq5nDmTv1jA9bYmkGDeGiZzowf0sVgGygaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLQPJ4Dh; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLQPJ4Dh"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01c79467so98691cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787003139; cv=none;
        d=google.com; s=arc-20260327;
        b=awhjJF1ErMSCed9REX4TwcbwwZIXtOiQgC/rvbvrMdrT3VWSDURT6K1vXoL7LuKbBJ
         sMQiQscG6W8OhmHweUN77hPdNjUVk1/qQcy6qJeA3EQvb6JOlun2esDXlCOGoLXRwVuA
         stwA1iEOB2lGp7mk0Ko2ta4BJZ4xItQ3/MW+NN1xGl7HhoRnvsmt5YTzD0NCurWVd/LE
         GInxMgGmL6iiaTBiY0Yf/AmrN9Bn6zJg4/tKu5QHCI5yXCCs+cvNeiXw5+y+aUKlSLSG
         dK2sQUmK+RPnDtsbXsG8atOcNqYn9kvVrJmfRqaTrNW8+ZP2at7aBnh3M5L4duoHCE1m
         SA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lLvPVmmS5AUZicQmmT9i5+Fw68cifI2ckULJF2m+OdY=;
        fh=3gg3mPMN0tdHKsPccK+a2djldhB0OS+PeNvpFEkpdx4=;
        b=KAWwm/nzP7zZ5Y0Q/xdrIUHEpjWuS0Nqwsfw7r55CoSQZuOPpdvafEoLt2CJGCb2AR
         OJuL5wEnBoIMVhRcZi8fThapD0PBbEiXatsxAzKRleKHhWBU+R0jqF5PKHfEWgFLzK17
         IvfrT9FB9TlkJLpnu+NnB1sRio/C8l2N8qQ+Ibunn1MeRU3nRyrO200QOgNyvERL84c3
         pER1QypBMbhf170O/DxtvczNTKF53ITbSDmpW8FDV3/31+X46ODVQzivEFNr7Fwj2iwI
         T94G/EOomG+PZmWRu68HjdWeLrNuYSQglCxXtHBxSXs4pEhZEEE/ZE3mmYJqvZLRjruT
         rmwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787003139; x=1787607939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lLvPVmmS5AUZicQmmT9i5+Fw68cifI2ckULJF2m+OdY=;
        b=qLQPJ4DhJoPdam0NJxheWqL5KTUlXdcwPR53AsPQcWIjsN2tz4NJcvPztZ9H9prltF
         hLv4Qy+SbBcicKXeBk60z8ThTLpjBhxW58y8oH/yVDKYYAYA/eG5S+DaNG92G93yJ8YA
         jXbLijUZzJs8X69FuljPw7Ldw1pbJcZCP91+MM0SCUQirCWHCaeugTyJbEd5CBORcrEb
         znjtRvbhRVE7rxklLT6+YTcHA6NmuaZb+cbafpQ0sfa81cWe8GCwGLFuMshMTR4AGClC
         bW5V33sbfatdxN3ExmB9Oq+bEOhw9euiO1qnXt3L9MW4Gl+689s06O1c4inZtRIUu12k
         xCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003139; x=1787607939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lLvPVmmS5AUZicQmmT9i5+Fw68cifI2ckULJF2m+OdY=;
        b=X2jASFS8SEcM2/JwYSFfKjxqH8p/RWx8brL8oQFiMhgT2NEid9b9w7Z078fghxNJar
         iiqV+OWP4Rz1zkqHeNRsfw6PtG4ik7lHtOTaU8Gw9nPi3JzPSgNGjPaDmcp52XoGhrYl
         QOvDl681lzdXEQeYhr4bvNN/8Qjlg4WZ5PmpgTD2UdkSiJeejKDa1c4/656T9ByhtZiy
         wE3t21t0leQR8TJrnDZdtbU84+jNadrw4phmFWsGNd5znRuqJa+eC/+3xa32WRrmAh/x
         qTvjhRl0Nkf5UQiO+lOD/zHqZhHq+eMabEx6saYNermImfkFMeM3rY5uz6Q2iu3LWHRL
         neLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZKfzhYIBN++lrMmM+4/YCV3HB3sMxbFU8G+NzrOp10vmvz7kufjG0ND4oZ3v5P471CWmumiiXZhpMM+4uGelX@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUjuLxo0HcffM8u/ZvfoxUdIv3APsZwGuCGXXS0BBBsdn7zsu
	D5BJZUPOiSMTK643/YNuedA+8fXuRSU1gr+Apvb3DK+yZf53qr49yBbfEyjrkknDeKhyPZGaH5t
	TI0zkkC8CxOIY4A0xkCXxDfH19uPmosZ2ZNfjZQa3
X-Gm-Gg: AR+sD10Yu0YGQeq6ZWVyNYfQam80Un609OIzDq9N9utlc/e1DeBU6JQJwsGg280UCG7
	t4hV90OsB/BhUM5TjMQ7hIiuYr/mcYSKQGVf56KtfHLOFvBsUHHoua0uf1xjkTHT9TY/6rsMUHR
	QK5ZVE4qspFAn2lsQfTVHlV9Vip+CPJBW63lebAU++mw0rNBS4DGbJBBkNvo9mT2qikJNvIWA9Y
	M5a0N1HE2vYP9vTSW98Od0PgcLTfui/QdLn4qQGB/XjJZSyzuMaHwvGL0hjvsn+VJOGX5nsZ67v
	iu/pHJVfSCxL/S+lzo4CJf8KS366DBkymddehNS6KC4IeWx7pf9LDUD8/0NMXUOANvWB8yidG69
	TVBRI21qlKQ==
X-Received: by 2002:a05:622a:4107:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-52dc4707fa9mr439191cf.1.1787003138107; Mon, 17 Aug 2026
 14:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806021038.2291417-1-irogers@google.com> <20260806041414.20327-1-irogers@google.com>
In-Reply-To: <20260806041414.20327-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:45:25 -0700
X-Gm-Features: AcwNN1VpPjZ30pLy7MS_7rQfwLS3RNo_hlRjhZQWrv1nNBycNGtVKYiCD60cgOI
Message-ID: <CAP-5=fWu7+8Qp8WkkZR+tkVocSYMEzsEdnJSOnOv4D20rxa99w@mail.gmail.com>
Subject: Re: [PATCH v2] perf evlist: Warn when 'sleep' workload is used
 without system-wide (-a) option
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tshah@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> A common mistake when trying to record system-wide profiles for a given
> duration is running commands like 'perf record sleep 1' or 'perf stat
> sleep 1' without passing '-a' / '--all-cpus'. When '-a' is omitted, perf
> defaults to per-process monitoring of the sleep process itself, which
> does not collect system-wide activity and records very few events.
>
> Add a warning in evlist__prepare_workload() when the workload executable
> is 'sleep' and system-wide mode is not enabled.
>
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/util/evlist.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index eb7c0d7be064..b3dd097fbb2c 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -11,6 +11,7 @@
>  #include <inttypes.h>
>  #include <signal.h>
>  #include <stdlib.h>
> +#include <string.h>
>
>  #include <fcntl.h>
>  #include <linux/bitops.h>
> @@ -1562,6 +1563,20 @@ int evlist__prepare_workload(struct evlist *evlist=
, struct target *target, const
>         int child_ready_pipe[2], go_pipe[2];
>         char bf;
>
> +       if (argv && argv[0] && target && target__none(target)) {
> +               const char *cmd =3D strrchr(argv[0], '/');
> +
> +               if (cmd)
> +                       cmd++;
> +               else
> +                       cmd =3D argv[0];
> +
> +               if (!strcmp(cmd, "sleep")) {
> +                       ui__warning("workload '%s' specified without the =
system-wide (-a) option\n",
> +                                   cmd);
> +               }
> +       }
> +
>         evlist__set_workload_cork_fd(evlist, -1);
>
>         if (pipe(child_ready_pipe) < 0) {
> --
> 2.55.0.629.g250fe7f194-goog
>
