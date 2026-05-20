Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AC3537F8
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316353; cv=pass; b=Venw/78VSsJusCzTcXjcYbV91azi63ySQEfxVQDBkQTkCMnXcP5gcvKME9rYN153v7ehxSWfNJAppm+rb8KwUphzC0bfYpkIXs4IJINQLtB0ICFWoYgllxRRk6AmaZM7T6AZrH2v3/IUXBq/ijWtFyGG6gkLaOmAiZeOko2kUBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316353; c=relaxed/simple;
	bh=t9q3iq5Wxyj3l5+6j/IbHZK/YVDS5O0SjWVjNkWNP34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgI2vYF7azuyW/AmSu3D8XY/zP/nxoc7a0VPpC0LR1t6SbyHiWSCZSS8DKEh/YkluC6ucy/wj8I7CkEpKh/3RyzdzR8H5dAztXbnr3Qo8wX0ZVDUOMYyeBe9H7eFji/5YUGEZL8w+DyVVZjLnngj70qaXOigt6DWgKY9Ha766BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqJxrJd6; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqJxrJd6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso1055ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 15:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779316351; cv=none;
        d=google.com; s=arc-20240605;
        b=ag4kB6ZAscIFLhYCGfZ8Y6JroESLcM0YSJjofn6LKtL2aiDuZUltKarNLWNBVKjcaR
         +VDEDjd19V15S1qL8KRymGhD7tlcrdrTvave8UfVZFMh/lAlf+msNkoHbzaLtsZuLxyO
         WFVf0L3udmAhFieq96nmNTBqb5Hy5uKClsiWp67HHKhyKOmnqDCnCtIZ+TrCDdrxhAn+
         lFAgxooewHQq0IhkxxINcAC90sHJVkOWoGGjjXqxZdnKdJfv9jiBcQxcf2DW0h+B8Le7
         8Amsl+aqwb5nUtWlmJzC1EN/tLM6xIJiYPzi8Uhe3PNc2Nnfv8iQCumRjYtgfZi0P1Sl
         B0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t9q3iq5Wxyj3l5+6j/IbHZK/YVDS5O0SjWVjNkWNP34=;
        fh=ITlDNM6YqpxOUWXvSVUTC8TPDMDmJfnshuZ0gBTfOEQ=;
        b=P5rJeerjrqNQiBnPJjlJaFXpkYif87w0gdpzg82HxRnLGOdcXiAAL2EfYe8i8+pBN/
         ApcuhAWr5Z3C1HOpZ6Tdw5/NfyqUNKGqcEjyNUqRUpCSN+mThzJ1/dlR1tjeBRjI1NhG
         Dwk1evuxoLVa7g2VEmPYGcnUkjZV/aMlvM9Nj5R0R0naApITcvz9oDURGaagsJiyXPvT
         ILvxaciMJzA74Bi/Ei4Syt5e55WOsb1OQOqBZHOkpS6t/XgDzsPcKHxpg6Ub6xvncsdx
         abdXLiTnfuIpihpU3YpAwSvdiyluW1F4q1UT0ruKv4AflBENM7Mz4UHXv1uU4hBtbcl0
         0Sqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779316351; x=1779921151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9q3iq5Wxyj3l5+6j/IbHZK/YVDS5O0SjWVjNkWNP34=;
        b=NqJxrJd6MviQpBHFAdMU8dBowm0fvUBRYoX/w5wgZFuQqQXd+TRft+MaZifNefDma+
         TqSMhCbE6btXY7eSnmG9EL2B3y7ziS2z1pMB1vld06EdX1cCjergvLUI6F0oDSAGZlX3
         rTor7z5R5cs1683mRMV8Q0NpZ2q5sAtvJTfzcjumWTdc+YHPR+fMBUCxmllxPww/EUP9
         h20cQi7wjdeBEkCrSiUFEZsNy9gUhL7vRs8JfOkB8fewavRMi0FPq+y2wIwvILTC4Tuf
         xD0kFGrFWSM4TZaRGXhNSVTv7shCZaXKpj0saKB3eZP19dMiMIcGUC723UgMng4S+Spe
         xajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316351; x=1779921151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9q3iq5Wxyj3l5+6j/IbHZK/YVDS5O0SjWVjNkWNP34=;
        b=aE6eyIASwz45V57JSDxdHkGNd7q+dQ+2J58kz+zzhgap9SpUPxSgI+AlN1slmS9INO
         J3uvcsFdc/IzyCkAZe+c8SsbA/Mz8Cwnm3ijlUb1flIITE0UyxLld0Ud+0qzgoGnxno+
         u17tXZDhsWh2qJq8H3+9AZMTA2cstCOija4rToN+gHeOdnHpE+qNOPSqPijutC+h9HM0
         TyycN5jIbaq+j+aLBvpWs23BJfN8Ue8JSg6uLrQpbhsNcY0fp6NZ+PtoIWMbAc+mjAW8
         U8o7xHqj308+bwaQI0TXQs1L8VXvd6f8JeyyCAa/YopHkTCVGwV5eghMVVrh6p4Vr0rA
         fbSg==
X-Forwarded-Encrypted: i=1; AFNElJ/jxWFO2eDUz/jaHye/GWHG1fRioxqyA63zrDwDc4kyqAtPZpap0abnbcDZ/D+5lHwcpPXOx9DFUcFb25WqoeNj@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4v+gs+qflnVTYE6xyS8K2FJscOpgUxpYk2ndio2+esWLg7l0
	B4gt/yKMsb/oGhRRoCCF0xNULQhehKq+6nF2ukwC6Jo/XC5BEzs0NTw+rZbMKjhCadMMeM9Hl+H
	a1jBYR4mvegKAqxedvFQ+l0xOEHEZeSQ2R0jQutrX
X-Gm-Gg: Acq92OGiTSz/1xKmoJaeXZWIN2WroqFVoruJ+pfZ/hCz6Zh1QtvM0P3yv1iUvZzg0+S
	sX7+pW9W8pZFhJnjMxiKtuBo0ySQGJ6jhnTA5zxCDUFktGoQFVe0tOQlmC+HzA2K2I05Oaaqr26
	HM9oNypCq7ioEXue5kc1vA6Th6LuT7Mfe7dzYdowwisEar6BL3RKng7ahtEMoKNPWxAoeqNoW08
	ViZJrrm1FhFgEEF/4FGi8tfaVG1i+DNVrUTH32Kqu/ToW2jTqnH/5Xr/eLBNttD/CziGeu67j6P
	sLINN4W1+l7Ep5vsfsMD0c1WOlqe8jjTOSQfE4Z/Ouywqwwq
X-Received: by 2002:a17:903:3c2d:b0:2bd:907:2ce5 with SMTP id
 d9443c01a7336-2bea2047244mr355055ad.7.1779316350099; Wed, 20 May 2026
 15:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag4PpWl-wV7SDpd5@x1> <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
 <ag4ecqF1PZg_u4Op@x1> <ag4e1BNQlZWVWISE@x1> <ag4f1iYyHdkpToXu@x1>
 <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
 <ag4j-dzzaa2xMr4y@x1> <ag4kauWBogiPBhRh@x1> <CAP-5=fW5DbyqPJwxO87YQ4DC4bRnhXxCe93Fkdbr3RMjT8-AQw@mail.gmail.com>
 <ag4l42A5UJOR3tQz@x1> <ag4szmCZdWwqHR_R@x1>
In-Reply-To: <ag4szmCZdWwqHR_R@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 15:32:18 -0700
X-Gm-Features: AVHnY4IyUd_0iU95TnYcgfpUMD8wTQQdqdNNKBqdhrDeywO9mzO-tTEexCxlzlQ
Message-ID: <CAP-5=fWoN5UR4xvO9MAE3c0kNR-6sURsHtdzAN3kkHUHQrqUcQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 2:51=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>
> Everything is at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git =
tmp.perf-tools-next
>
> I also rebased my perf.data validation (that has some extra fixes, becaus=
e... Sashiko):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git =
perf-data-validation
>
> I think I addressed some of your review comments, if bored, take a look,
> I'll submit as soon as I get what is in tmp.perf-tools-next moved to
> perf-tools-next which I plan/hope to do later today, after the container
> build tests finish.

I'll look at the perf-data-validation branch. Would it be okay to post
the patches to LKML so that we can get the Sashiko review on them?

Thanks,
Ian

> - Arnaldo
