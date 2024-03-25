Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E445026
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382511; cv=none; b=o+rqp4/Vh0L8yd/6kVZRwSamMMWfr9MfZVRiFaPDlMHfJIgaYJFijOiaUENbpy3A3Vgc+Jo/dHar57WaJeqrP4aFBFw6IAS4Zk0EDICFwtmY/160BzEoIScSEIUOl+x6ngjN32gNVCdgP6JPRU+Bs9DFXo/DiaTl1jF1alFP41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382511; c=relaxed/simple;
	bh=59UbE9m4dLNU/UctnLIacfNEWVQyMyg4nrGCFaybjgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9cNPFPEwLE6tnMNcvLW9IOB846ZDVcrbf9f7Kitw9GbaJ7/IqoRZWtnU41at/tMA6f9b3+WDl99f4cAg+bnLMQmyMl01j+1NuC7K+vRZ2CfG6ocrIxg5uEWJLYBqT+9YQBbYNFTtS+d/deZbobmYwegJjo+NjdlVd4Hd0IM+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlgBwyrV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlgBwyrV"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430d3fcc511so459571cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711382508; x=1711987308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPRJuOE8OwASDffe8vbBcREJyVnhJmE0vJXfy1nelnE=;
        b=VlgBwyrVKpYos7z4YtAxg/SZkVfWQjq7P/ccKASb8+rAUY8yfX9QCY1L2CSlhqc6Bd
         I/3IR4iWTe7jXcaeTrNbSWwXbLMTSKZcbaAb4M/2IP5X/AQGoyWrlS6mDrllMgId7IWj
         i6LRIZatXBEunh8ZGAuYfRsN2LX446iEc+uaDn4BUrKj0Brw6tCl/Hk3IgwGHfBrrnFq
         Keg5s8SRYc0yrPrdA/5fcm6vtO7LANnWkvIIBW1stDYVF3MoLKJ7k2fyAep0ZB3zJr5D
         KXoU89tKAJow6YK/TwW/vNUYcCxMzB7GOyz1DIpyoQmzuIiYUc6Cgh4dfoePcjLGVskw
         z0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382508; x=1711987308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPRJuOE8OwASDffe8vbBcREJyVnhJmE0vJXfy1nelnE=;
        b=ASZ7sVnZjD+Q2NdtsEfSlWyA7go9rt18h+sz07wJL1W4b9CJMB9UjLMXssal4mFiTe
         EE65PqtTiq39QjpnEvfWHoFG1iZpQPLkUuomm4CsG8Qu5/WiwvxOPSunmTX9KKkY+iCK
         VVy90Hxxw5g0EFh2+XPo+tbu0NBD1CSp9spzcrjHR+Tgc0uDZFQrr2I32rPtGwQK7bI/
         YY91A39052JoTe/MxsLpkeHz8Ka2CUbda8mrFgTAMUUKtnhDZJrYMc8rxpEw6mdCzc4j
         Twn9gH8X0Q5mG9Bn3iHMvRoYMnbMZkntLIcqXfNPKR8+FD+4M/YD+Bz/F6uoRWnsq5aA
         a4yA==
X-Forwarded-Encrypted: i=1; AJvYcCVLrPBlBZUXxL+dFRvuijthYcIW8LIExyr+wlTQ6qdm5IhtBynm+2VLcPZ8kC+zGr2R4XFWBL9VTbv/Dp7BSl0PssBR3jWBheBeOAFKLN6uJw==
X-Gm-Message-State: AOJu0YxZx1eLpEjxyEBvainZi9KYAnXpJfiMlDMRn3urwzCULdqpxRV6
	r/9u/BLaGNvLaGxM+j6S8I3qpgcT/BVj0rz6X65Oepgr7xgl83oo6uWTVehNrqGrcgFvs6uluwg
	JWTrBg2RvhLesVTwXopx0XM02hG69Qi8MI8Y/
X-Google-Smtp-Source: AGHT+IHIrmG9yy6eJ8Q/zdFwGJDQtXTQy2MgXxKHSYvK+VOGsArCqswKFxdn5ogEGlicgLKBGkG/vVvus9AgpXw9RAA=
X-Received: by 2002:a05:622a:2298:b0:431:5e0c:f0e1 with SMTP id
 ay24-20020a05622a229800b004315e0cf0e1mr160429qtb.20.1711382508184; Mon, 25
 Mar 2024 09:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321071512.2916952-1-tmricht@linux.ibm.com>
In-Reply-To: <20240321071512.2916952-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Mar 2024 09:01:36 -0700
Message-ID: <CAP-5=fWMdgWe8FqeMcjf6ZCq5fdKWmrROCqnAsKYD9iXQxYEKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] perf report: Fix PAI counter names for s390
 virtual machines
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:15=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> s390 introduced Processor Activity Instrumentation (PAI) counter
> facility on LPAR and virtual machines z/VM for models 3931 and 3932.
> These counters are stored as raw data in the perf.data file and are
> displayed with command
>
>  # ./perf report -i /tmp//perfout-635468 -D | grep Counter
>         Counter:007 <unknown> Value:0x00000000000186a0
>         Counter:032 <unknown> Value:0x0000000000000001
>         Counter:032 <unknown> Value:0x0000000000000001
>         Counter:032 <unknown> Value:0x0000000000000001
>  #
>
> However on z/VM virtual machines, the counter names are not retrieved
> from the PMU and are shown as '<unknown>'.
> This is caused by the CPU string saved in the mapfile.csv for this
> machine:
>
>    ^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core
>
> This string contains the CPU Measurement facility first and second
> version number and authorization level (3\.7.[[:xdigit:]]+).
> These numbers do not apply to the PAI counter facility.
> In fact they can be omitted.
> Shorten the CPU identification string for this machine to manufacturer
> and model. This is sufficient for all PMU devices.
>
> Output after:
>  # ./perf report -i /tmp//perfout-635468 -D | grep Counter
>         Counter:007 km_aes_128 Value:0x00000000000186a0
>         Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
>         Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
>         Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
>  #
>
> Fixes: b539deafbadb ("perf report: Add s390 raw data interpretation for P=
AI counters")
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/s390/mapfile.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu=
-events/arch/s390/mapfile.csv
> index a918e1af77a5..b22648d12751 100644
> --- a/tools/perf/pmu-events/arch/s390/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
> @@ -5,4 +5,4 @@ Family-model,Version,Filename,EventType
>  ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
>  ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
>  ^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
> -^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core
> +^IBM.393[12].*$,3,cf_z16,core
> --
> 2.44.0
>
