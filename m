Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BB35E1AD
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012920; cv=pass; b=a+c2CjAyJZDZVFm0StU2v1eCfRRK2/K6zkU3ek3kQuIjqGixYLpZli8Y7dNjZrKtjhYyGsBILXdLu9rxeeRejzUBYW0EogrhbUJr0ap9qZvEbVUAJ5iYUcaN6/81tGNDDV1VpvtT+H/wDfjKepEiXsJdtakPrYyVqRFXsrBJdvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012920; c=relaxed/simple;
	bh=zw51gC5xIPlAb+ehmicqnY9g7AruYRjvzVknaMunE54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSTi01A1gSdn/ndu0YxGSzWbzU9aSJMcvOwBryadGnDJOpn8RoZODpaitotyhixBDYIeJfHEqO81hUNGzz2+TTPRAp7211axAQkKmRHLJuHkrliOr94+cIhyNZ9otAVm7gRK5eu/0w29tdU04oYuhH1IDwDDmLc4/ScQyzmhVWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCfA16sJ; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCfA16sJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so1520267b3a.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 13:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785012917; cv=none;
        d=google.com; s=arc-20260327;
        b=seuBX1hT1pctBVeaDJMhLvmKO2M/M+csjvbWD/20IYdOY/swl8PR7M3kygMHim89T0
         LuG5BcU7uTecuJQW0lCNX5M/A3Z9sTIsU1iQmoEUunIxrCaCkB76CJ2H3OPL7tqohWqm
         eM1SxOx7gWltUCJc3gAETnRdPo3w5hwrHkKNgs394Zqz05y+q4kvjhDqcBJQy6NKSOlq
         WAmiS88cm4drrBnB0DkF+x9xcjaPR8oOS+qzD7IuYkEG6DCR3oj1H6tyQ6Gkm6L26Jft
         IjRlvV02HMD6zpWlnVrjaEF56jzrEum9eDX8x4EdPjXgyZqqJmZhVWVqHjonbPcBNAJa
         mOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        fh=rX/mUCQsc2ggL1ArShyrtvjEg6HR/Bkf2ri5Ieo4+Ag=;
        b=DmDbWsh12tG/l3uBK5JZteAAkqzxhSbI6JlyfHh+yNeD7QrA/Ift18oUnxmNWSvEqr
         eTaliuuhgpCT36vdTMCXwDZPBknlghChgifo+SBVpvVdfmYTyUMaIJ9rHFflYMheGiIj
         JNMGEEdBHTlgXA43QZqUC/EaQsYvZlhxP7U2d/etfGx3W6MGSgDpTuXA3hnECKbWHMgn
         OF940Moj153Eq4wkZwCObXbnSUpRV8TfZ6fh7uyA9bpUpNTRLsOc1YL8dHIcReTGa2cG
         eW37Z0de82kGTFd8BMAwrjw5x4TypZL2sJspunIcUfhiC5XPE39hZwphdCJQWl4Re0R3
         DPTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785012917; x=1785617717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        b=CCfA16sJBtgz8hldzWHYxUcyEjDqG0Y36DO6tVDS/ExmfNKDZzPZL53IiAy2HXqw2O
         KGAlALuZKD65GL9IxDdiAKuHMignZ6WXOsZx1samvNlbskdHpyC7TijOlka7b7Ab7JlX
         9DOirbvc9OUcRek2FGlvwCYNbjCSoGUKFnIS+mB249msG4ov5+/MS9llmMgoi6gXo4wR
         SQnOgz2SA+68IAreR4Ru1Uk0nfis315U2LA9sR0U72Iezp+sgkabMYRYXpfdgB4JiNMS
         jEuo3pZ0GvvmCxcqlnHbjxszgy/btfDRvWGt+aeO2Q/am25HTFd9D96Xz6Fy0N7YIeZO
         Yw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785012917; x=1785617717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        b=qljbMqFHyjyzyjgvYvKpjN71B+7UigRdEcGXhJ1bOYGGelrUQV/fHtaV3cl4sEPuBq
         kW9lVhwFqdAaUAwa6ycBqCYYgwEjKKQfpHzJK9p6qK/ATw38qySOUR7qELi3dsHSspnS
         oUpZUl5TweRGcE43TZqhrrmZiPWmvPUNrpBOmpwNGCxNfeDWoi3mvrVDnMOrBHDDhTdf
         WMWwQM3IiA7W71fX+Q4q/8jdVnLxtid/sOKj6tHlNwWOe23zjOojsvf6Wt4jRQCC2WsL
         SEwZeibbtSBaxFFz+6E/T1IChblwV1aaSaJNmlHJ0vuNI2HkwUkI7kim56HFLXk8AvEA
         VQUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rri8c2q50175I5hM5WJGI5jB3y3o1arST6udNKc17fMIM2OAnbZEN4FC1sm17xdV5kTVBaHYJQ7u/Xp3TVEdpAb@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJupsbiqNkR8tYBpLjNgFEkZSCztlBDZLBFyg3NMZTD+MgoVc
	kTh6G4pEXbLmwuZcNERGoLzuh0QqXktU4t5jz4lwyJct7JbXTD2VE4mI7FNSCp8y07RKFFJitgE
	jfvI5yUAx6jgkDrWQFGJiIqnOaigczmE=
X-Gm-Gg: AR+sD120fWqNIFCH3JR7KBjcxprFs/+Y7HoBqyf8rJG047jIANbAEUIj0PhCk/OjWqi
	aZqycPxTPpPj+v0rXFqlNJCxE5aLK8TDMcdcIwQ2D/mWscxdKiUADF7XGHPprsKjEv44L5kl+7q
	4g1yYSLplDOqmLI7fv5CRxOQEp2ibSVvH0r+rXnzlmjlANBNnjXZVISoYjkdEnxrujYdtZTi/OQ
	R3xfn0FfDtsVwcgrKnGZJ08CyfsumdjHQsMlMoN44N+4qphksB9Bz+RMDiVOA==
X-Received: by 2002:a05:6a21:4784:b0:3c3:990b:2292 with SMTP id
 adf61e73a8af0-3c67dfe6723mr2903792637.57.1785012916705; Sat, 25 Jul 2026
 13:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
In-Reply-To: <amOTjPW__CNZui3_@codewreck.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 25 Jul 2026 22:55:03 +0200
X-Gm-Features: AUfX_myV9AV5bwxaPxDCds8CpJSSwUUfrEfnR7d5D_zQ_thbtzqC3K-k805u5U8
Message-ID: <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Biggers <ebiggers@kernel.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:41=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
> > There's no "tk(cbc(aes))" algorithm in the upstream kernel.  So, it's
> > not possible that this ever worked with upstream.  Given that, there's
> > no regression in upstream for this program, and it wouldn't be
> > appropriate to consider a sysctl knob in upstream at this time.
>
> Bleh, you are correct, it's an NXP patch in
> drivers/crypto/caam/caamalg.c that they've been carrying in their
> tree(s) since 2018[1] and has apparently never been upstreamed...
> [1] https://github.com/nxp-imx/linux-imx/commit/6868c9e49c1854028fb46022d=
aac3b1b10ca2c70
>
> Sorry for not having checked, I was hoping for better.
> (I should be used to it by now...)

Sorry for joining the party so late, you're killing AF_ALG faster than
I can follow all the mails.
Speaking of CAAM, there is a legit usecase which exists mainline. No
vendor patches needed.

You can create a CAAM BLOB (a generated and sealed key) using the
trusted keys subsystem and use this BLOB
later in AF_ALG to perform AES with a key invisible to userspace.

e.g.
kid=3D$(keyctl add trusted mykey "new 32 pk" @s)
keyctl print $kid | xxd -r -p > blob.bin
Then just create a caam_pkey_info in userspace and feed it into AF_ALG
and perform AES with it.

So, pretty please,  if you kill AF_ALG and all this, offer some way to
achieve the same in userspace.

-
Thanks,
//richard
