Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE65335BC
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176464; cv=pass; b=c1wVz42h55blLLGRrlWTEVxwCsO/aObJ7OCbae5lp9tP5KR3TQNDz8dTMqjtw8PL2MD5/bImFC0Mcx37pvoA9QRv3L/oRAqKvXsi4uBZvRxd4OdPTT/Oms3Taa8XfvLAx0BBC6V5aciy3XyDaafKpUzGu0lzw4aw1d3i/4umeIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176464; c=relaxed/simple;
	bh=jrtCe9nu5l+rlKR/V9eYvI92IDWfuKwXPfbk+EpZIPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIpd1zjInhd4BtUjkgQt7dpk4LaoQz1X9pxLR26w7HtTV1QMx204N0lBcTirI/rSMuU9BBns0rEwwpaUnLgW6qoO5cA4PAsw5c0cZhQR+0votGvIhR17HDM9hBFqkf/j3JsynObI2QAGLTuDa4+DJHb04eweeTxXaleqVseH8ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucVFZrWM; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucVFZrWM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so62535ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 08:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790176463; cv=none;
        d=google.com; s=arc-20260327;
        b=dnhSje64VlrDBFjV5MmI5ijJe2a11rqf6FKDOw1aEXww3Fi7iSeRzXv/aJV8P2iGcu
         aADDxKuN4NVQSUpArr9H93f4K4C9nXZv8nB/Q1+7drCUxPXtCkbpLxzOa51Bwg/fnKt/
         2+FPoAYB0NnEOhVmLyvjvESVDph9fT0wQOTimAM9KKpR9DD0zzi7+KGSLIwZLPBo6thx
         IMcTWMcllobbxk4VRcx/8PD2307DHaAQFAcAoJzH0wmHBdrjhg1WZgoitnmhXS3J0uoS
         JXG2fNAI1iGDkx/7OWzrJYS3K/Lp1JaR2o2MjX5bElq+JHjhmjslAPIf5qdzBxVdTPzs
         uzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bMRQEia033X6Of2B2M7NQD4y537TtEPziJ29t2lyTP8=;
        fh=bmGe2SFGDNPS19WiQpQ9NXbB3cmFDKZU2WGeWCsOSMk=;
        b=SCS0eBvN/PpYzyP4iqmkQAjsVcafubebIK1XDSzFsbe4xjQhrRJyi3iCg2/rGi6LUw
         sZ1N/v/EgDtaZU0JHsKBgVOM+rNkhovDX3qUYR+5ty4InpP2VukbwkGPcQREYtJ/Nvfo
         WsXO6fLWzDlB0MX+zc7N4oLsZ4026jnlG2e69tFOQWjhshoyNZw9AzgDrR2cZ26OTKeI
         a4kU3fZPS4kYdmeIa+wy53kMF/PtOejoaZu9o5YBRvw9qdzg0902kmJX3sMeTcu+r+DO
         6bF3lb3Yb1ZYmdTlHMn6eDmuKdqnCls5j89UlDYVdsMvpDTvJu7lHIF8/oq/7z/e5sKc
         /iWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790176463; x=1790781263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bMRQEia033X6Of2B2M7NQD4y537TtEPziJ29t2lyTP8=;
        b=ucVFZrWMOTcVfuDNVJSOnjS1r7jw2Lb9laSYz17xfHks5wLA67TlslBuYYTUluJPGu
         JmrOptZnwY6uaCHcv0GybtkSf+YjTXJbzIaN9iKGMsNXX7zAT6iJ+EtRrXsjo4jgN8LE
         t4LB8FTyAXsbtYTptroLWRerGnU8QpyNYeiwILO18Kg5tEezhHybr/k/TLV8RVVCpfv4
         y4GKz72wue9zvL89B4h+kBKKmXItM31rUFPf2lDof8v33asY9FfRqB0fdgb1MXX01bUT
         R5hC6lNdosBftbHdPQ5PQ6ClBjec3dIjSEmeZYhQXijQx4ScX4BaJi5xWKMQiKU4dMnx
         5Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176463; x=1790781263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMRQEia033X6Of2B2M7NQD4y537TtEPziJ29t2lyTP8=;
        b=It4pQ2MyMdwAlZqTTcHGW1Tfcv7BCH3ni1jZcweOAkXTouKA2hQLc8Ic7WcPZnY4lQ
         rB2/66M8FpCgRvyg64FCZJhl0vGR95CyqDab4YP29QDlEOA+KxQbbwOwAJ3c9NY5fs9h
         k55KmVfjxWT8++Wse9nPnCXPJcQE6tbpaNPz1F1+PQsNPYK56RtMWSINIyYtYSY10vZd
         I6j5EsWhqAbC35IUy1ZRvl4b0NHbc+Eu0lcSPCOdUfaLgSqkxQ0CwXm8K1yM3PSwQn0P
         97H4w094WS8pWjV3i1NVfH7HdAiEGosCnAOLK5d5CO86Beh/nHgi0pDBwVZ3WQc+VCRq
         LorQ==
X-Forwarded-Encrypted: i=1; AKwUvBznx4GAvS/XrvQb4xe5qHbBCng2Sp7QFA22Ygj5i5Q7/JGgT/Bjujs2bCfEXrT5FznrGg9E0/MarIBtwoUeRgm4@vger.kernel.org
X-Gm-Message-State: AFuF++k5zPVShILT+JdtmAKBKDxUFL1Sra1Mu68LdNqMk3X/6u3PL8pD
	+yJtwNkhmD4n/Obaal6aVMmUJlVj6CIuMCnumq4JOpr0wg2yVzpXlKcsCIP2nDuhUFkqwmVRBH6
	5wFW2qfnYMMbriNNLbbKsnqJc0N2dm1/8PU19zyNJ7hzYb5vLR+c51nXk
X-Gm-Gg: AYBFou3A8JmGUH6RvgcdtS//W6s9vO2EEKSmxcX15XiuHGLETpxZOA3lJf2p1vwNPjI
	81iBt06c4MbTXm0JvD8ckUsGsAo99qLu/k2Itg2jqcXYPiaNnV3SdHIckGRPGcBekYZO9KkvdwM
	9tOclalJMDrKHeDwoVriBEp2t85/ASsXAIYCzBn9GZ+MdG/lxcNvq39IHzBcv/HhcqIm3LQ6qSO
	d5HSNkM+8ujCsYBYTYrFEomM5eeu3fr2j0iRvns2bPgdNr6OPKXxnGGWuW8cFtqZSohR9zr/Q/N
	Elh04VtF4KKlpyGTC3COZpbMmH5zpjX1CFkxYFz4xsiMB7a6OGAhhkAHxgQ/X5RgTzcNxo8xDs6
	h6+RRqSqbcw==
X-Received: by 2002:a17:902:e948:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2df7b5a3a82mr85785ad.1.1790176462207; Wed, 23 Sep 2026 08:14:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
 <20260923135140.386033-1-chrismelnu@gmail.com>
In-Reply-To: <20260923135140.386033-1-chrismelnu@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 08:14:09 -0700
X-Gm-Features: AcwNN1UACUSZ5SzoKX-d7CesDfr-SFGPV2oIBCagdKQTWtmBKBnYtM8bHC8ULfQ
Message-ID: <CAP-5=fV2O4bV99bOicODQxXc8frtUu23=3o7JBhoOtf4VzuyKA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: document task-clock/cpu-clock in TIMINGS
To: Christian Melendez <chrismelnu@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	peterz@infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 6:52=E2=80=AFAM Christian Melendez <chrismelnu@gmai=
l.com> wrote:
>
> task-clock/cpu-clock appear in perf stat's own example output but
> were never explained in perf-stat.txt, unlike time elapsed/user/sys.
> This came up unanswered on the list in 2013 and 2015 without docs
> ever being added.
>
> Link: https://patch.msgid.link/CAP-5=3DfV0-yvc68BUSKoSajHjHY_A6COgbEJYiFx=
Rg+G-8LeJhQ@mail.gmail.com
> Signed-off-by: Christian Melendez <chrismelnu@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-stat.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Document=
ation/perf-stat.txt
> index f334aabdc809..c0d6c344f9eb 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -621,6 +621,16 @@ user/system lands:
>
>  Those times are the very same as displayed by the 'time' tool.
>
> +We also display a clock-based timing metric that depends on the
> +target being monitored:
> +
> +        83723.452481      task-clock:u (msec)       #    1.004 CPUs util=
ized
> +
> +For a single task, task-clock reports a clock count specific to that
> +task. When the target is a CPU or the whole system (-a or -C),
> +cpu-clock is reported instead. cpu-clock is a high-resolution per-CPU
> +timer. See perf_event_open(2) for more details.
> +
>  CSV FORMAT
>  ----------
>
> @@ -671,4 +681,4 @@ that can be used for parsing.
>
>  SEE ALSO
>  --------
> -linkperf:perf-top[1], linkperf:perf-list[1]
> +linkperf:perf-top[1], linkperf:perf-list[1], perf_event_open(2)
> --
> 2.34.1
>
