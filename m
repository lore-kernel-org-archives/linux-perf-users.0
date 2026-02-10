Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E652848AD
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702905; cv=pass; b=NUZ7Wx7LiazUsImoQsoYOBIZGhfnPtbSKd6aMxc305ssZKkPreRGGvCDYm4yVhQbgzWXsKPUdrL1Qhmc0jxTDoGwx8p/v8ETgNchj56lvNPTee69uW6qaXRu2Oxi6POQc3g2iXIOoK5jOMwnID0bLJGr9MIHgkuXEpA67fppYag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702905; c=relaxed/simple;
	bh=MdV0x/eJTWzdX3ow0XOAbt4C2upZXdS42Vyfx2mWZvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwQXhZEGa5KDs0urq8Xio1TfL1hMQiATJTQ75zOSAWeiQNuURPcCLfCNvm7o179FPuoXDPo3lpU1hlS4EIlEAl6hlc9SfvOY3Rtr1SIEIUosSTgoxUd0FJ94+RVYpmSlEWBxCK40gUngEPt94bYOo21xgp5VmFDhfAlEkbexVE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCjxaBlQ; arc=pass smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCjxaBlQ"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-59e4993dff5so3049511e87.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 21:55:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770702901; cv=none;
        d=google.com; s=arc-20240605;
        b=No00OsU47uyXno0hnniaNAASukGqTBaCIR9cX3d1Kg9mmByfXwqAwjvy2kUm5QrLkr
         c16xoFxYpyKYdxAI3VcxQEdH/7oa1jepVXkRMBi0yoP5zzLaDY8dvnqyoW/sVE8dVXgO
         23KhiEhn+0WcABaPDPOIfrBkwdzFYrrPOKuktTxrvIc22oEK8laU2yDNveKeL+swOIa4
         d1rx2pX/G0I10UjYEmA+Hge3ASyOoE57jG3n66/mUcqm0p/U9iRzJDAduhXHnP+N+q/i
         bupf4Z9bDsRGfa6VjQXjjqFesy2ti7iZLfdTzaof10N+yZ8XuL12Y/kFAkJWs5OrHXc6
         lJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l6qnAPvCXNqWlSbf+oOQ9VYTRnILyLNuodKY/j+4HmE=;
        fh=x2HPG3Ti2OSC34wJyDU1xrb3S2o6aBhCa9FlQ5I2FzM=;
        b=FZ28szvxQi6tvsVLW0dXyyAcTerBfWXTEBwN4feRgOnwhjpoLA5p7kHtE+r1ddJN7c
         JCCrJIsGsvoIEHKzoFQ5ZNnCT5vAB9oI5PGdUG5No82gd3Xiu6rBAmd87q2rcZrecUfp
         giu8OHXN1Ws7kDPsHMmJrGMvJhweehIz+2/BKWzv79gpEXdyqoRa472VvZRj+yDo3bTT
         UqHUATqCX8kUhDN7i7oqUsP8FjvKA+K1REJApx03ylEviHm90ZgjDwSxZ1wLMvYSxjJq
         cu8nya7EMCJpFVZ6i7i0pjdafcbeGRYWR2dBqo25ib6+IFCS7e0XWbya+uIsnkYeoz0p
         lwgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770702901; x=1771307701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6qnAPvCXNqWlSbf+oOQ9VYTRnILyLNuodKY/j+4HmE=;
        b=UCjxaBlQlz76VQUhWNYjG3FpaVByapPcTXqM6VdZ9OcCTiK+LTR3cOsD2wK/kijPmA
         oxZWanADqSikyUamJg8X4QODBd0jQXZdNdzZsNcpLZ0AYy9wdUGo57V5QlcwKic1NcEE
         hf2GKeVFC6enMnBbHHj+Ky9VdMW3dE6mJApkKqaso06qgrzoEdHFC/rfL21FQZV8YnyE
         5Z1dHK8zeV9gAIOWLE3PVOOIV9cWVs5Sba1AgD0Nb8JqNFXFlwsZJlmVgq9zMSgAN0VC
         1bJDiD9/GlRjDEmeEMmDHFqIgm7av8mEJllssiiAT68FEG4sBpbvkXOYdZaVd1BAlNWg
         23Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770702901; x=1771307701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6qnAPvCXNqWlSbf+oOQ9VYTRnILyLNuodKY/j+4HmE=;
        b=UXH2OMujVrh19480xcAYERTr9+iZb0DCcTfONBMWJCK5/0g3ggghfleQ1L8MmlTI6H
         ATfZ/S3xCe4jf9mEcGgs/YYukYg6jHWCx4Bh5hVHHlJ2e1aqLV7CcCAjmlbPNZnztGdg
         dZ71VuEjdgv6YZqFOAj09Q4gcH32x+6NvzCpv2K/9UJRHbD0QCEDlaLJX8V0QekS8RjB
         45mZ+ddorLULFfqDelSNCPAKNRbjphesny7C+Baal//a9Vdwgb1sX+Ah/GywYz7C3X05
         gvRSIlXqYPNBA+fAIb7jjy2fa548CCyLPLUvcMZrYno9P9atzqMajgcS1jFFRM6G1FGN
         xL0w==
X-Forwarded-Encrypted: i=1; AJvYcCWC0d8yc4satAJD71BRK3k8gsgwU5THCuHK9xOPdw4FgRpyFGJ/jbDR14qKIexd4Rf5RKqeSlvDm2lUG39pFbzf@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8tpCxrIsXTQbzeMqjVZ1+oJllGXLIaHjiO2vbYHQ8bZ1qj3/
	d3OgGoJ+q7mMKXUFYML0Ri+BpPEPwjcF3kR8VeyoHvfXMzKG8Zv0SDhmz0mRJ1jDprF/Mcpn0UL
	n3SlpIYoCIMGldegIs8A2ldqUgZjOhFc=
X-Gm-Gg: AZuq6aIqOBVc7v26OysM0WfB/nwDYUX0xDsE3pmjJru028HjsYmbP7+0iR/YBsbA5I+
	Q9c4qpZpHXmbWFNdmUWC0eo7ZyhSuc/LJlWCT9R83Zi7SKfHzQDHjcP7lWiEBfFi2mHhv+bE4Xm
	6XB5PloUtvLUCeopXmTwi2fD5pv7GuwF4iD+wW0R1IiL0H4XjBkbfrfzrcD1z+y0SaZiPE0q/Qr
	0seYjoCF+t91ZXajJbiunkKVIQmpTzaQ0COOfmPfYJ5pHeB6s9a/dArmN3EAQEwKy7iCl9zbgNv
	9GTxa/k+
X-Received: by 2002:a05:6512:1326:b0:59d:f69e:16c2 with SMTP id
 2adb3069b0e04-59e55b8abbfmr263238e87.12.1770702901183; Mon, 09 Feb 2026
 21:55:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223084337.3789-1-hupu.gm@gmail.com> <20251223084337.3789-2-hupu.gm@gmail.com>
 <aUrdUjqVEjJW9VBl@google.com>
In-Reply-To: <aUrdUjqVEjJW9VBl@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 10 Feb 2026 13:54:49 +0800
X-Gm-Features: AZwV_QgvqbPoQHPhDibGtKcqXz19kRj7bz78kM8jjqTHIlCRKHK4Rf3x_mpslFg
Message-ID: <CADHxFxRprUvRzorxe00HmwG0o73VQJNf=yzM40fkiWjjqu7PZQ@mail.gmail.com>
Subject: Re: [RFC 1/2] perf build: Allow passing extra Clang flags via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 2:20=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Dec 23, 2025 at 04:43:34PM +0800, hupu wrote:
> > Add support for EXTRA_BPF_FLAGS in the eBPF skeleton build, allowing
> > users to pass additional Clang options such as --sysroot or custom
> > include paths when cross-compiling perf.
> >
> > This is primarily intended for cross-build scenarios where the default
> > host include paths do not match the target kernel version.
> >
> > Example usage:
> >     make perf ARCH=3D"arm64" EXTRA_BPF_FLAGS=3D"--sysroot=3D..."
> >
> > Change history:
> >   v5:
> >     - Update commit message
> >   v4:
> >     - Apply EXTRA_BPF_FLAGS directly to BPF skeleton build command
> >       instead of modifying CLANG_OPTIONS
> >   v3:
> >     - Move the variable description comment to the top of Makefile.perf
> >     - Update commit message
> >   v2:
> >     - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
> >     - Update commit message
> >   v1:
> >     - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options
> >
> > Signed-off-by: hupu <hupu.gm@gmail.com>
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>

Hi Namhyung,

Sorry to bother you.

I noticed that the patch adding support for EXTRA_BPF_FLAGS, which was
previously reviewed by you, does not seem to be included in the latest
released version. I just wanted to follow up and check on the current
status of this patch, in case it was missed or delayed for some
reason.

Thanks a lot for your time and review.

Thanks
hupu
