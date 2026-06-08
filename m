Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270B3AFB0E
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955934; cv=pass; b=d6ArDxPix/6TioY6f71djAYRdSSytn6tucsCpG+15F2xvDYP57OUdgw9zDvt9j5HPojJNzbDdGUDbNXStojpl52ruO1b8zCgGTVb+U/Fd5hzt3ufMlfXHIvBqpRYq2Q0bnipkopBgdpXhT59kl5GO5CnJX9OEGaIyPf8X3stR7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955934; c=relaxed/simple;
	bh=clvsrzYw+OMCVRnSfezgySZkx2nrpE+Rw6+vH3Kod8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9vLacNBvW+4PdB9XRhaMYv1SObMwJfU/rTQ+OU3SrQntlR32O4yht41Bb7Q2IsOpOv7lJetKD8tKmVJqkUKzCEJmw4dEdJwcBjIohAM+GNtXfhXViv5nY8tYv9F9SY871Kva/+FIUqhYD+hkMDrxnrbkXxN1/7Zds5P5cJ7Boc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDU/TK3q; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDU/TK3q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0b1a48855so443605ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 14:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780955931; cv=none;
        d=google.com; s=arc-20240605;
        b=E9R6ebvVxgKVtiEjXq4qc4nsSevMuufnPjmfjq4fCiUBkKcKrvkc2Whmc8iBJLfilx
         +ZDR9SoiFqkujpHyfBqj/mxfKY3QnMvoeqh0t0ww+qKUNx5DZk3BsUEnzyK21dEwa8zT
         fCXVdBJzsaHnkKE8gecppOKFftfMNlfch1eNAqWGW0xTRpeGPlK4xWzrHoxuU91T4VXj
         yAg/wusnEtNEvGZ1dYluIbQ02J1/AbUic/5TR+388jw+gOO9oeK+bK51Jj8kieG3/GDS
         gMj44+vQZkcjtOa5mi2/vQMI0oP3/bllBf2tGeFzott3mks1wFsRvm/5d+p9Wvhf7m+V
         pQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbVbTB2iq8+zhVGEP+3MIH3KgEK/j1K2w3GzBt2eKW4=;
        fh=LBI/SYaMclgYPs0PPPQInLr2BwvS0LqhIxc1yzICyMU=;
        b=DMpHpnRmp3F/92uttJUUmnBM1bqB4u1POTawexQcFzsireCL5Ur1Naw1m5j3qv1IOQ
         K9++zj4C3EJyCY5ZM22sogfcebmNFFjXca6aXNqrqAEmj+oWCgZBq/q65OfiJXUyx6bE
         7zRHn9y65BHw701xxMddaVJTCA4rbkLxNSt6kfwaoakYy46sXZ5mfyReyA41EPhbHjVb
         BBjm07nKmduK6SqxzGyNgLpzX7/GnIl1twycqRNxbpdQr/N8JVW/c1awRxw/3WznvN4m
         CxbQaGCwbGynF1BLOo5oTZgB2s3T8oT3Mjbvcs/9ThTpmP3OYOuDK3yrDXETyUgbU7/4
         WYBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780955931; x=1781560731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbVbTB2iq8+zhVGEP+3MIH3KgEK/j1K2w3GzBt2eKW4=;
        b=dDU/TK3qPyi0tc1eG6BwHUHbMegduE9bwZzs3g4yOCXg0/yUJ3hIIBQVyBgHIps+5G
         +arpuCiONW0vZ18+7cT47ejuK1C9O7mb2stqaiKyHY1ZMl2NdzkFCXc7sYED5lnK2gi5
         Ma84NcB3YqzQ9vWlEogzKPcK3NGkAW9FGUAza27ujh+StnNvg3Q5aZCZNG8tNWSjQBrn
         qWgHFbgd/53Yug/Yv1fcvB+RvEoHzu4jmJOp6Dx8yAZC5zhMcb39eVskiWw3Lme3AXV/
         59mnOCP9Kk5IP86XYYlOA5Uof6Zr8nVJAjmK5LWldEb1cdQGRuL2cP3P651L2FzxjrVJ
         il4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955931; x=1781560731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbVbTB2iq8+zhVGEP+3MIH3KgEK/j1K2w3GzBt2eKW4=;
        b=M5Z+yNzWZlitf8/iVcmfnNcfl4uWX5sZY5ZsjtCytmRrwNu5DHfIwEfltCZ8uiFRq6
         Cvyszi2xDb9qvyxKs6JYzMcnyy109nuUpmrTilJD7DXiMiGXumQKO8GnJwMfRZccu4KD
         ST0K39bD2bnPYcF12+Xa/2++h/356XpccfmkWpFrhAKY9gauxkWVi2iE6G053rXUVXih
         lI3FDBgvpaZ9MbIGaC+RSyCyYYbmBkPsHisrkwfvmqRMdcK0xfEfuKs70lbwrl5FeLxH
         z/kScnKo84CPp+T/43ZaMFBh7tClvLXPfaenMXevTLdqqe74zdnrNdYYws81rcgSVm+U
         SGdA==
X-Forwarded-Encrypted: i=1; AFNElJ+5+6RRxO3HqzbmdbzeRgo1GqXaw91PtgiJTyyYXp29QQKBSlmVtegqWrLeiq8JXQHu0z/VTFW0xN9OFFutRAAS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd19L8ElcgFlEp3G3+eqCKjjugqI/IcatzVyxWz6+XtGtQfmSn
	SQladXQh3S9tF2VeNpdIlJdu9BNADm7fbvKg4kY6uh0vu0nkiGumwruKeDRxFdjtDH4BwaXJLwX
	odtiKomF/r9b3ljMe9PJ1wgw4BR6Wi/0/ga9DgvgY
X-Gm-Gg: Acq92OFB2GIFdB/YNizJ5n6QHDfhxGbjeq3kj8JDV2gGwFRgBJzu0OMEPl3F2RY7gp6
	H1e78oWMKNqxP6Qm58ULbOIoMm3Kxs1L37tEkp4YDUbXbPjArVNEItz3bbXPBevCcmwAjhJ0BBf
	qbgg+0eZVu4mBwvbq2OzCmEEI2WZ5LcJLi3Z7ZWe7Bd1CQCa5QLcZIC8SqFXtGmkJZiyrweox3u
	DebAqYzTgNp0AILSa9BHKlv/UwRqZjsWvsA8cbmaqvk/IYeP7YcA0v5WLO89O331ohAkcnQBuou
	Rx5XkcGmuFGio1qJRG24RqkfJltxzFBLw6ZUVJevVhSsPEDW
X-Received: by 2002:a17:902:c948:b0:2bd:6dad:7ccd with SMTP id
 d9443c01a7336-2c1ec3f1e9dmr5384585ad.25.1780955930465; Mon, 08 Jun 2026
 14:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-6-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-6-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 14:58:37 -0700
X-Gm-Features: AVVi8CfCdT1RuYcUVNy1uWSO2HquRahTMcKZQU1wxG0xjfmptQXuOg1uySRhqvw
Message-ID: <CAP-5=fVZ9tONcV-fUVYjTGz1iLFuk5m+SL530a2kPv8H1PW_+A@mail.gmail.com>
Subject: Re: [PATCH 05/11] perf sched: Bounds-check prio before test_bit() in timehist
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Yang Jihong <yangjihong@bytedance.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> timehist_skip_sample() reads prio from untrusted tracepoint data via
> perf_sample__intval(sample, "prev_prio") without bounds validation.
> A crafted perf.data with prev_prio >=3D MAX_PRIO (140) causes test_bit()
> to read past the end of the prio_bitmap, which is only MAX_PRIO bits.
>
> Add a prio >=3D 0 && prio < MAX_PRIO check before the test_bit() call.
> This also makes the !=3D -1 sentinel check explicit as >=3D 0.
>
> Fixes: 9b3a48bbe20d9692 ("perf sched timehist: Add --prio option")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Yang Jihong <yangjihong@bytedance.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 1ff01f03d2ad1ad3..ded511d8518803a0 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched =
*sched,
>                 else if (evsel__name_is(sample->evsel, "sched:sched_switc=
h"))
>                         prio =3D perf_sample__intval(sample, "prev_prio")=
;
>
> -               if (prio !=3D -1 && !test_bit(prio, sched->prio_bitmap)) =
{
> +               /* prio comes from untrusted tracepoint data =E2=80=94 bo=
unds-check before test_bit */
> +               if (prio >=3D 0 &&
> +                   (prio >=3D MAX_PRIO || !test_bit(prio, sched->prio_bi=
tmap))) {
>                         rc =3D true;
>                         sched->skipped_samples++;
>                 }
> --
> 2.54.0
>
