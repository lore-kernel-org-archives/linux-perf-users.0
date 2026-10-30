Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793332702;
	b=m+YDsc/pMjS+5B8uqaLNH0hzHaPx/7s/k3YlqA4nI4F9dAsXEnkKeRIWp1KyFYTZ59nb
	 cmIojzObPtKUFwdJEX8qpy+3E6aewfKrvFFUdNTYFvhKd0hWylKndCjKPJAigWzwqW9Ih
	 1gPvE0u6GsLd8DEhIBNsjZHd4AsdH4h8mRrd97g2OvYTzQZu6HbDWHjIiJqMQ/gQd0kan
	 H9muBMMJW5SmMB8dtaiE+7sZoA79FtUC9TniT9X0TJSJ75Aj9MCwSvaKRsD4Otop3hrbV
	 /byblNC+0uddA/Jyea0k8as8UKgge7b/8fvk3whcb0WEdaeLRsVscSomXDliSKyyFiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IZmNuI/wND30J0nkI7O6RvOq46XxnSgW4W30rCGXnNg=;
	b=ElJMHa7+1CiDytyAVHzjXt5miIUIDFQN7JkyJ0BCAtx+SYJCfyNBTKbjuVjgHUDq4AqC
	 KtqTqf0SYHl+n9BDyMIG3c1Dt2ujAh9AwaXHMsYvhOn2DImjXrAFBKZzXTmdN0Bjjw+Sb
	 SHKsxpoS0du5+oeAhO7w4AYmAphTY/gNuOlTdKLKAAGlDgmnWYROtifkd6/RLPD1c/1H9
	 +dWF6JzvHFfyMOUVHSg+tcCj3sDuE2d62uWQZqxDtwdy0nYV+tvoCKdAP3px+XxqIDPXs
	 oXQ07tKszu3opRF4bx871F25PdeGC3CQ309/r2C+x/QX0JUxE4o+wBvqXl3B+Svs0Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sUpdStRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF63606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 03:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sUpdStRz
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso255830e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 20:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793332700; cv=none;
        d=google.com; s=arc-20260327;
        b=Su6JCrFeMVA2sW11Y+g0MntrELqfa5dPRSnuzgQXwSn1npVXsJwIgqS21aPpzwc2LF
         eueFETOsjcjj27wXLOIrGdfKeGG7lAw13aZ2RfRDYhBysOmTjOeMcNki05lSJrMjhUnl
         43NPt7HLeVGTUpNGHCHJ1+t9Hzm1y/N6WTdiMt/fu9KdFN4jy2SuCAjSemYAWWf+Dmbx
         NrLZ9RUaNaF4OHTT1sBrAtRYdUAk7MhVGcdfiHWbe5+oUOpJpt44A8+5EnUlCe+4VTR5
         QzqiB0A7NBG+GLdJJtryQRJNBG9nVQcOeV5NeXjjaWNXvrzC5DISP+w/xkZ88Wp2J5aM
         0TRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZmNuI/wND30J0nkI7O6RvOq46XxnSgW4W30rCGXnNg=;
        fh=q4qERIRkFDVW2FycmDNUIgfKmZU2Q9WgC9lqkSFrSbg=;
        b=UqH/6TzPPT23ZBWnh14DQ349pzGolnXlTgCpU3ZWwSF4+oVx0xSDVlp4dTee7M+mJo
         KlEndNE1nRkJxxW+/tm7e1cymlI1H06VUVL38rnS9nQsiNBw7TtZKY06ugf2dGdt1kkk
         QVzB9T+DVrfaCb3D+JnOv9qlDJWFF/BlMH35/8jCQrVTwwS7Gl+yBdAeBB42+Alw08eP
         8O8BcToLfiGYkhdFw2BJlihC0gH2QBnQm80oRRsKKzLBsDXbP/SlIRvGSXRydv2bzr1e
         z+D1mKJWs1m9hYlhp1iRclP4fG1F9+yp3SzUHinU+AjANDhslIvMm+LjfH0OrX1BEiGf
         FJpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793332700; x=1793937500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZmNuI/wND30J0nkI7O6RvOq46XxnSgW4W30rCGXnNg=;
        b=sUpdStRzH778SDNGZYJe1CEBwNtIRtYO39O6dHFQd9TZwGmLMl9XMQQDhD5mRr3mnd
         LRCTb4d9WdJYvOH8b13wGWKoRGtT6WG3kUtGUuO2eEhio5XuhgyyAIcHSEZKDtZ/8ZiP
         SJwdec05E3w2G00BIGQv1yRWbguaYFEvCQQNyuTtdWIaH+Kjd1Z65NBeI1R+kzAK+ZAD
         cl/kfVFXdq1IopfR9d2GVNwH8Qa9mfI+YRqFYn/xHeHxEAG2yeFhZNkWRVRYO07GLRWW
         fDfxplSL5x2646zj2cU3XNygzYw2ZCJpXHfySsoF0q1bHbChZPOJIUUm2DIggEZvP+cR
         VNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793332700; x=1793937500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZmNuI/wND30J0nkI7O6RvOq46XxnSgW4W30rCGXnNg=;
        b=X9bKym+OpORub78+28uwCgM//eTMw6ivzt4tQxT+FohB1Lzr5H3zWLtDcdX45QYR+j
         DZMV7vNod2A2uNgs5rZ/a/wbuN4WcUn/m0YMqPyLvAzBbUkk4wBmzQ6IHrO3hcaaA3ea
         0hXdRLxCRGLrhjVY5xnHWaGCqwOmKpkKZCm2qGm7xOg2RN54NlGJRWUQ5AFIL7n8nU8F
         8UmMbzl+JTUbeVGa5MKPQ2ETLr4o8Rmg4sWIH4rraLSGppJ3/f2KbJzkscHMR4h4KL8u
         RDlLw7ZoIivGarltV+HCQyBEDRZIpesbcyOZVOdzpQMci5b+uiXKNTwW9JOgLIAccp04
         TMRA==
X-Forwarded-Encrypted: i=1; AKwUvBxC+87oG7yNfDSAkGENcS5tln3ZCQZNfT4fD2Vv3AhER8okU6pd1oozfD5dzAHlbALjLotB688jqbiFWx5BFe1h@vger.kernel.org
X-Gm-Message-State: AFq9FYID1alNaT0aamItZ7SqE2s2nz0qNUcyqP22zPZSJGn+Jd4X5q9C
	6Wc79CUTZPLy7cGUNNZFZ0619GTFwz8R3umxvHLITn+zgYt9aPD27qTmTQZ5ZSsnqBS/iRf2j4Q
	8Bdg75Z5wDnEFKyR6GOymexqGev9V5WPiJZd57ttEIA==
X-Gm-Gg: AYBFou01B2chj2pXWFJlEJwzZGthYyw1ta/LjMAfNNgkdeUlCx8gMvMUWypcQJJoP98
	Sbc7ncBZ6H9KEelxN8iSNHQpEQ7zIZxvFfI19CiwrQ7yiAg5jkqXVDRXi+i7QUhQD5RvtZW3MPv
	Lvl5IM1Ui+A3nU7uc/u5XNY5coo0GcjRnElv9pAl6bOxIdVMFvYfgqu0hSAWEKknCzjSaL/Cd0b
	aJf7/xBeta56CC/Ri/B4qfYrNoFoMVVX8Owt34FpzCOwFDQtOUvQefjMyZoRyap7YXr0AEoiHno
	l2tkpeeMpH6mw+U+Ek6cbJCMdbQbnrgmNVk5iDswv7cRAnMOH37xZIDnlKCK2NwpzUHiyFKqCH1
	/EhWK+Ex0Xzfx1VJgf1xvZsjWduTo7aif0EYlyfE7PTnyg1Gr/blTeh2Jvjagfa7/u1JJmS/3Gu
	sYmLqoA2lKM1Y5OO1eYn0iVMApAOmFQx5buSaeV6LQurYwJ2o2UG8a
X-Received: by 2002:a05:6512:1289:b0:5b6:95e:87ee with SMTP id
 2adb3069b0e04-5bfd9562acfmr282919e87.13.1793332699938; Thu, 29 Oct 2026
 20:58:19 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261028-alpha-profileme-v1-1-d44b52bf2500@gmail.com> <CA+=Fv5TsDjMcd8+ZPPAXWzw-ox5yhvYJqiCBUfj-6Jm0Lxf9aA@mail.gmail.com>
In-Reply-To: <CA+=Fv5TsDjMcd8+ZPPAXWzw-ox5yhvYJqiCBUfj-6Jm0Lxf9aA@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 29 Oct 2026 23:58:07 -0400
X-Gm-Features: AclHuK8V7EpB7wC06FUDBXo_x3T-573CFsU0sqVCv9AcRDNtqPDSxvn5PcuIGgc
Message-ID: <CAEdQ38G9id1CnZGzkgw8vHLKZM+bvJEDx7ze+6zpULGTwG=9JQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 1:38=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
> The Alpha Architecture Reference Manual, Table E-18 (page E-24),
> describes bit 0 as:
>
>   "set =3D log all processes"
>   "clear =3D log only selected processes"
>
> That appears opposite to the changelog's description of zero as
> "count all processes". Is the manual incorrect for the PALcode
> implementation we use?

Yes, the manual has it backwards. I disassembled the wrperfmon handler
in the UNIX PALcode from the ES47 firmware (V7.3) and from the latest
ES40 firmware, and the code is the same in both. Function 3 clears
I_CTL[SPCE] and sets it again unless bit 0 of a1 is set:

    hw_mfpr  t3, I_CTL
    mov      1, t4            # SPCE is I_CTL bit 0
    andnot   t3, t4, t3
    cmovlbs  a1, zero, t4
    or       t3, t4, t3
    hw_mtpr  t3, I_CTL

The 21264 HRM calls SPCE "System Performance Counting Enable", so 0
counts all processes. The per-process enable is PCTX[PPCE], which
PALcode loads from the PME bit in the PCB. Linux never sets that bit,
so if 0 meant "selected processes only" we would never have counted
anything.

I'll add a paragraph about this to the commit message in v2.
