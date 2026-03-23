Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FE2DB787
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290922; cv=pass; b=VVXqDrhEMDXmtdcDaUDPNdahs5tp2ZedSuwPRml/2UBCw+xUfYzbiRsLPuYpRgzgqmU9SOCaQFFiGeEA2dOdF0fZZwKutVPPqDVSUR3qdl3L/Z55YRi8YkAeUQOtqoGIpS51c6HlVtQa5LbaQsQUwWEg1Xh+iSouy8iDYyDpMnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290922; c=relaxed/simple;
	bh=pQqi3NknTMqwkHp2i+Iye4oV32fBc+Sw0jH7oJmRAKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5/aD02wsEwIJWMOHMv/hCZrZdxf5tXgbfJx/J4ZJjGOFgQdZ9s+WoOBkL7vjtLfEqnO2IARk9/KTc7KwtjXQqXR3MCfwVxhF2q7WzYkuiRVESjatjsi1GNkwTlTIwkirmCwotJwuF3f9+TWEqbBLuBhXNxOqJIw+GAPf3oU3Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3FO3WJ2; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3FO3WJ2"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270f10a774so1841c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 11:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774290919; cv=none;
        d=google.com; s=arc-20240605;
        b=YbCFf5Qq2W7Wr9iAh+FUyrMnmjHcrZ2/RZb7qrBzccuSpG3vx0OF7UVECSbB0IzFm9
         NeWaHQprJQkUgX3I/VetIu+kAwk/W93qp9YK5pWyV25uNNuhEl7ZhvD4obvwP60uEK0i
         n12j/bJh5s/iNdNQNujsEvQdIy3DRfgyItY14f9cfnw77geyo8a0pCXWSHd7I4kWyCKi
         3bwPzLIb6XQZFfMmJSiaETv34z0UpqGfa2rVvp6u4zz8e/xsHj3SwkFPBrw5kNc/Siqb
         +9gzt5rsdha4lXYulj2KT68CepRsFUB1jgfhZ2jq+QCY6aR+QSiOwMMhqjZULGqfhLSb
         33FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUoMS08pIOgT+M2z4ergXAXS0a6rb1EDqrrDqMpBEvw=;
        fh=BO9pnvevMHTqUYtz+EXjQITHxkQDY6jyB0gu8sg4uCE=;
        b=js6DB4qxttk+LaOyIbXqyf++D8PhdVuW94qYj9hZQKzpwB0oUrTfrmpdyMjYclIWzu
         Z3MrGw6/RZ9zk5KHAk/zs5L5h8Fdx2xUDYht294iP+9awQ32yCgGpCdV33WZv5SHHuPZ
         DMTjKUip9JItFXbVZiJsmVwZxraSuZtYygelU4ZOQnNHAplTNQ3eqz9ewwPZTQVts6hl
         N2tmTwLHf/84unSoUju6oxhqkFJ7L+zTCr7Y2Eni+7ZZCa7em3eLxmbRmFzJhTHh5Sre
         a/ZVuMVQcePA5SKpJIf55A2eyjwGTy7Cbq1Gvo7Ck9c9yV2ge0D5zhVG87VroGJTk4cM
         ObGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774290919; x=1774895719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUoMS08pIOgT+M2z4ergXAXS0a6rb1EDqrrDqMpBEvw=;
        b=t3FO3WJ2ixDpyQqtteBUORkrVaKopMjweIH02CK6Wt7QgMT/IoXcOmnnU3Ztw4rFa6
         QnT89tCLVumJQtvoZoXzQJviedDmCjr1aq3moy1lABr+aOrEiT/08+viLHqs/RlTcy4A
         racKNIrZAmRwXO6N5xfqzk5cGoTmQ2ZWj2zYG4HlL7VivHca+0UnCa0w+t4Yci8VpJBo
         D9evrVZZhS49bXZ91UMPeLLpcKJ26npdQKRoZFxF03bnKTP1L2o5BIkoNh8mUbhWTtah
         BSWFz464PznoopQVrjahy0ksil4U+kuvDzPnAEEALS8nnvKkKxVAWq4q6INUwuFDoblY
         Yp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290919; x=1774895719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUoMS08pIOgT+M2z4ergXAXS0a6rb1EDqrrDqMpBEvw=;
        b=OYNkrikdGnugcq+V+w+jI/Vxf7JIP+qCbh7nDM6eJj+JcxALaAClt6StAWqIXjuE9/
         YEqXrwjryOjLX5tpL8MbZWeZkshhLjUmSRxByd2EpKt9x3zDxCKoQIB5Poo53NcJ5nLO
         1tVAF/fkqmMferm9fIc8+8QyaNdA/LBfu1milcMzVITOVd/lZ9/jcfHwYHwogkZU1qva
         f6IUPRR54JT3ukOngRBoWJp6lDdRNl+E87zADe0V5wX9AAteLb8AByWxw9kmrvJpO+qx
         rO0Tmd4iqlI8sgJWN3uRuB0N7ltwsSPvKdKR8x/MmBj7aqpJ8fomaLyAvfu4F79XOeyO
         1Uxg==
X-Forwarded-Encrypted: i=1; AJvYcCUbaWXmCPTkk1I9SjDJEPTgaKJ0TBo1A/iO6hOr6jE3XElfXokj/0g/l7XzNXtUn5e5zrDHJrDLWqR/sDk2dwTg@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlX61wrNjcbtol1vONxIoyHuRN2UAU3EzAo5vgMCerywogSAT
	GFiVnMbUIUvRcyjAuBS6bknQXMkUtGadZYN1Ll7tiUXWvtvp6fNwecoXeVaZMhIB2PL4reFoImN
	z4ZvYBqWLbxTFEd+52rkDxYS2FvqLa0X4EEZy4F/l
X-Gm-Gg: ATEYQzxk45yFOwiJ1Skaockx3/4mdzPmSH+MqoiOno7Z7SNE6bKELSDm+Ign2ucUnWQ
	dIw4+NmC1HddqaDji7ItOv8LrGuEpHHgaoc1y9COHwP9sB/Mi980R2t2+qQ+TRzqROiiZ/CeuDg
	eiED72ih9cTA1S2aw2bgLNqCepv14VlRlSM3JXtTPvAoEUc1gEC9NUmvlP64DLwSvE4MEaMk7P2
	wFF8odLo/V/s95XRNzkps0C4HGlqKfxVQZDp8I+YuDNwXGo8FFrDrNqA/ZBe83HxuNSZhB9Vg4e
	qRh/AEG5gPF/KuBYPj4XlZE0U3RXK0xgot84NpFVn372sxvC
X-Received: by 2002:a05:7022:618f:b0:128:d790:dd38 with SMTP id
 a92af1059eb24-12a8e72abdfmr24507c88.12.1774290918852; Mon, 23 Mar 2026
 11:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323085255.98173-1-jameshongleiwang@126.com>
In-Reply-To: <20260323085255.98173-1-jameshongleiwang@126.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 11:35:05 -0700
X-Gm-Features: AQROBzA3Num95hk1RnB95qL8OivWrUNj2QetQlOax9Jc-nO55Ofd48-3pPcx6NA
Message-ID: <CAP-5=fVdxJxSAYyAoS_UVxQqOtS1GrhHphEag=Ksb2Oc+NuCGQ@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Add 'intel_idle_irq' to the list of idle symbols
To: Honglei Wang <jameshongleiwang@126.com>, namhyung@kernel.org, acme@kernel.org, 
	Thomas Richter <tmricht@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, ojeda@kernel.org, gary@garyguo.net, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:53=E2=80=AFAM Honglei Wang <jameshongleiwang@126.=
com> wrote:
>
> Commit 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
> introduced intel_idle_irq as entry of those with
> CPUIDLE_FLAG_IRQ_ENABLE, say, skx and icx so far. Let's add a new
> one to the list of idle symbols to avoid noise.
>
> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
> ---
>  tools/perf/util/symbol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 8662001e1e25..7cff66e7ce06 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -730,6 +730,7 @@ static bool symbol__is_idle(const char *name)
>                 "cpu_startup_entry",
>                 "idle_cpu",
>                 "intel_idle",
> +               "intel_idle_irq",

It would be nice to make this an Intel specific idle symbol. I sent
out a patch set to do this:
https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/
but there are no reviews. Perhaps we can follow up that patch by
adding this symbol. Arnaldo, Namhyung, wdyt? I believe Arnaldo was
supportive in:
https://lore.kernel.org/lkml/aahC-zp56irr5e2k@x1/

Thanks,
Ian

>                 "intel_idle_ibrs",
>                 "default_idle",
>                 "native_safe_halt",
> --
> 2.45.2
>
