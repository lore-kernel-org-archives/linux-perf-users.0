Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B191A316E
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167999; cv=pass; b=l3C0Du4lGIVOBrlYtx4Dp2zKW5bj/RFCYXsMiIG48v76KdQ+1VTrRFZD+T82Xk37NEisZ4IPXP041Aqee8LnZ56SGkzLgjpF1So2G5fvbZ4SIykfGVvIo5gnbP+o5MaBNxROGLyez9W+MUr2KBzPqTBXSNgffWclf+PRoJyGnBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167999; c=relaxed/simple;
	bh=pshTnlDrmcYE7qADh159gUFIAi/AtDvz28IECp4HnS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYJ5OYpcNfHdScGfRRXsuwx4h/yvSfSTZu35xbQ/oxRRFjnaSQQW9I0G3GCX5LnpnZzi89c6YOoo3U6YHL5x9NVUSxD4EXUAFr1cMNAopJRiHKElKD/+BzpTbT+aahXdeygP1rqeLn4CDkt/NUv3OBl/d+ijLI1ci4Y4UnqG8eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxU3ULZp; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxU3ULZp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba180a022dso98695ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 08:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167998; cv=none;
        d=google.com; s=arc-20240605;
        b=ccwlZxw7WyeKHemzkrGmvy14WvGKMJgzXQdMa+ztI2eiwoSneEnQuDATAnFueeNLU3
         dlTshbeoPDvP3CXuyCZpZjtUk5W32snI0OLfAvyj4j67aZUR3+TQnXHL6cHHMxiq+bUc
         WDObVeGgVi/RNIN+7wJlQQUQ/XEv9sKjfjh5Zo5lKwB8ktbPiYL8/6M7yxuu6q70OCEX
         8l6B6+KNKnzDeFR88MK1GF6ggnZIcn6AEP6xRrb2ZNxqSPRrFta49mZoxI04TvC0OFVy
         9nXNwZZV1nkFZRVF6hbkU1DLt/yW1vZ54w06hEOpkidejvtx0JLuDJJ1Z6w9ZTftQbDe
         YFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7VqyUqV5RyIPeVejA62ttbxcIeN0YeIM9mFOL0GF+tM=;
        fh=uBTe8rcySMF2dvYyijTzbI/yUVBtDX/p14wFoqewQPs=;
        b=VuzRDG+fzNBnB7XAoZLkz63oNmX8Ij9d8YsILg1LS/xqB7UCrK2TIfXwIxTnEEqHa0
         Q2xL3J078uJvKe/du84vtR735nK1TA2pE/mjS2a6Ft2MpWAHghrEtJ9Fv+ktpaH5fyXu
         eaYzjsj/3RLa2jU/KBbgkOQYS1njqaT+9Ak0/SU/dVl3balG5ShExze4W4EzhbM+aRJW
         Ft4bITSeoczkV3UOfcqjsb7FUkMQcuSPQzP4hFg3sUp9zwv1llK8AUsVJvCBPCBt3o+S
         JJrY/rSSZoytl9fAqNQ6ET4I2qNGk2G/7r3UII/Qb1soGeNYFApdjSrVXjLZ8cJm1Lin
         Rmcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778167998; x=1778772798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VqyUqV5RyIPeVejA62ttbxcIeN0YeIM9mFOL0GF+tM=;
        b=SxU3ULZpRemw1xSvnzDTx8j8isfbI9KKCMfYV4B+R0qAkTSXvYaxBUdzFLJMtBw0aV
         Lnrmm7gcAF/xLE4eWY9MhJoZOlJhwaCkafkPQ/NrUFmci4rp8ZDXI/97FbBMZA6x2bKf
         3eRU3cNyAQmGVtpiyOkutQ1CHpCsgzVzKPJ0ga0z8U0HEX4kgjG4JsAzw+pPhpzrTMZe
         gHqCUehPmzY163L7NGgMm4UAZzU/EPwSCmrnrpv32NRiIplP/nWd48stfMnhdg4knqYL
         gjau8S6lIeZe6hLKQQ/mbcX6Pis7jMiNwSCSKjEmgpS3TdKWsc0KYfQaANF3r6KJRroh
         IOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167998; x=1778772798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7VqyUqV5RyIPeVejA62ttbxcIeN0YeIM9mFOL0GF+tM=;
        b=FkJHu4Yulz2cZxqkadpildQnNdTkt4bA/fwHCHIpVRDPfVB3buLqCpfn/pK6046+u7
         WjST1LkmE++Cu0tV1DmeawUDpMnIoFEdMio5nb+cAhqkyjLeKhgyL5hgHcdhr2izEwTV
         OlEHB+gpAt7Yrmpg1BWJ6pyaS8/Qr1LvxJc4fuaFC7dU+aRj0FEy5QHAqLFeSvyHHHU1
         9zGUibwDyr4RMhDgslhyD/mYN6dU+aBsABGCZqRgm7zjqrAD50k62NiQgTevOigPhCjP
         XHsCI9NnCHXFxT+kkE+r/oPCq4fpWHs7hYhEsUcsaVIEBRqWzachW+Ykf2beISFk1qPK
         bVRA==
X-Forwarded-Encrypted: i=1; AFNElJ9MCf4J4KNDTXv/bmMq+6cQOkiSroN5ByKLs4SP2EOH1czOQJKfdObxXdtbgfPqbMfPV7L+20S73vKUoVaZ/zKj@vger.kernel.org
X-Gm-Message-State: AOJu0YwoYEO51fNPVcVD5NbmGHFBpciUnttX3Mm/pymZFKzifzqVbqt7
	Zl3YjVI4r9VPNjqcidHeQXWbtBahErzO1OztAoC8TQJ9BX0SKp2bUfC9X2GuGkM+JMv/3O4Z/Jw
	/jPs5ebTyQt/ggsY6YB0crw5MaH4GNOSjhyWOgjwo
X-Gm-Gg: AeBDies5cmO8sFFdMAPmMr4ixBM1dExiH+ELUzndcWafmPH+/4kjgxvxxxXvoK2JOc7
	pCUbhsuFKPi4jW8/sOfbd9OpsliGXUwZqKE9RriCD2FEbBe0A+txD/UbBLgpDg81rxTQWCpEngY
	qfrRkfIqtOU7R6rHHXnjYEr2UGmynFApKKrKKM22qA03jlSAGlez4fQGZPffJvJuaHutD/5NZko
	aWSeVNoAVQnJe5A4ZlpBCS9hGTPb3tdjKySF7TeadOXiI/4BfLpz4HEc1xgIghcWMYWRr+AKwrN
	KNXv090F+LHhWik2WT6oKgu8usV7N/aHmyqKkRiOGU5/dQiTkOje4F2ds4o=
X-Received: by 2002:a17:902:ea12:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2bab6022d34mr4546695ad.4.1778167997540; Thu, 07 May 2026
 08:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507063737.3542950-1-wangyushan12@huawei.com> <20260507063737.3542950-2-wangyushan12@huawei.com>
In-Reply-To: <20260507063737.3542950-2-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 08:33:06 -0700
X-Gm-Features: AVHnY4LPRYfAZmmxOjJIPz65xmkiiY5Sw9xtkiO-Uu115ZZfiJQbu-TOgh7Te5I
Message-ID: <CAP-5=fXb6-Q2EJmoLyCmp2kmRG5x-pSt8-YAHNToZjn6jid33g@mail.gmail.com>
Subject: Re: [RFT PATCH v2 1/7] perf stat: Check color's length instead of the pointer
To: Yushan Wang <wangyushan12@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@arm.com, 
	john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org, leo.yan@linux.dev, 
	robin.murphy@arm.com, linuxarm@huawei.com, hejunhao3@huawei.com, 
	prime.zeng@hisilicon.com, fanghao11@huawei.com, wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:37=E2=80=AFPM Yushan Wang <wangyushan12@huawei.co=
m> wrote:
>
> Color string returned by metric_threshold_classify__color() is never
> NULL, check the presence of *color will always return true.
>
> Fix this by change the checks against length of *color.
>
> Fixes: 37b77ae95416 ("perf stat: Change color to threshold in print_metri=
c")
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c    | 2 +-
>  tools/perf/util/stat-display.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c8ac9f01a36b..58cd5cd377a6 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2111,7 +2111,7 @@ static void script_print_metric(struct perf_stat_co=
nfig *config __maybe_unused,
>         perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx=
->evsel,
>                                    PERF_RECORD_SAMPLE, mctx->fp);
>         fputs("\tmetric: ", mctx->fp);
> -       if (color)
> +       if (strlen(color))
>                 color_fprintf(mctx->fp, color, fmt, val);
>         else
>                 printf(fmt, val);
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 993f4c4b8f44..74cba80c24b0 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -474,7 +474,7 @@ static void print_metric_std(struct perf_stat_config =
*config,
>                 do_new_line_std(config, os);
>
>         n =3D fprintf(out, " # ");
> -       if (color)
> +       if (strlen(color))
>                 n +=3D color_fprintf(out, color, fmt, val);
>         else
>                 n +=3D fprintf(out, fmt, val);
> @@ -607,7 +607,7 @@ static void print_metric_only(struct perf_stat_config=
 *config,
>         if (mlen < strlen(unit))
>                 mlen =3D strlen(unit) + 1;
>
> -       if (color)
> +       if (strlen(color))
>                 mlen +=3D strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
>
>         color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
> --
> 2.33.0
>
