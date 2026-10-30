Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367187;
	b=u/mkzV/NE+CHLpFZkaeTaR0HkrqTKTfuYP16mKj6V+1NyxYjE0nvpoOxm0dkydnK6zk/
	 HLxwbXInlq5S+z8cS2Z7PoJjuYyak31xJFM98KblnQq3a57KpnVD4GeeVAnEC1o2ZNLri
	 UjogWn70GT1ukeTIlWvgzqAlYk9PJb8QstO28RWzxD2xUe18NzbZ4npsfkZBTLhRJGkjN
	 jaNb896zceM7rI3owNLGN6oHEoQqIfQ8fAyC5vuA4zSau0jCYvgMukAqrQ0FdAQCfxk6Z
	 tTr9hnRcVDgaS2zm6M0eKQW5DQVxz+giYqjX1x/+dbxildBW8CTiovc5c82OQtU/StA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Ap8AI3OLMnsIvB+7PuWaSwO39DciT3p1bcrU5DUdTaA=;
	b=OW1s4afOT8u0t0czd0ySWkyAFcVnVCJovlhKMzOkkweip38vbGt/oTDssDrH8gohN11o
	 tZ4L3CqAD1CmjfU3Zp4uyxLsIZOy823MECB2QyvhwPUtxZvplVyQoUZXpWnbIpmS7rx7K
	 Jfj6DSzHPTenJpn64mJYScnVs4SidCNikIo5EnYPjt8DAMMMJoj8g7mgLnC1CvRx/S9hR
	 s/xRjgsSDcGynzjPIHh2VI+3F0bT1PaC36QoyfccxaV+etX962vMiGsaxQ3hT6R1SQiwR
	 lYU9DFNO7yKtTg9d5aJt7Li7Z8jTVEBEldVSHBC1ywlXBsoFLWbtxd1aDielkVX2zrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=h6tDS7Vd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E93606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 13:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E93606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=h6tDS7Vd
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6798af41644so459746d50.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793367186; cv=none;
        d=google.com; s=arc-20260327;
        b=rq0WxI19QFYPz9IANAFMLqUGDrJDMLREIvYPkQpX3lMBwD6ri3T+lwSkrVph0lOS8S
         vM96NtvDGjoOnW1ZSLQKL0p40kwKn1/Kr5EoX2zq4c+uB7eqCnXItjAWbBQenO9ivXBI
         pl4jRow0k6P9rsRj1Ftojk2Ns7jw4xrQC7qIFThO6iHIDX0p0fHaJyZ13K6WuRE/CjVk
         d7/4spLHEo57/HrgDjsLqlqC1vVaz8bCchzMWI+rEc551+vz3iyigq0ru6BmLF94Ldwm
         VDPBujN9f0XBkQNTpxb6dHP29XlAxP7tUDeD/sCDimgIQXiZZlgFRNlzsxbTa94n7i0p
         TzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ap8AI3OLMnsIvB+7PuWaSwO39DciT3p1bcrU5DUdTaA=;
        fh=xKDG6bWygAEH/lPorqQ+Y2Tdsmiow9vRq2j4t5MuLU0=;
        b=UOAPbiFXYrD/SUtaER5uM8tp5GJsIMopXgi1azlYRUlXUHi4uZfcDtTApjnpxBjHu5
         4cWsHvlJh77TkDxRf8o6krrzQRkkgdeLlczf8G493miqosVEdjxTVZyPM3NYS1cD4bHN
         wUZlau9Xs+Gn+Jcuk+Ryy3AyGUsxCpjMTIX+EaCkoTCR91cPq0DjLHTrppaUzN8iAKjP
         7rrWRH8g7CoZZtqNmDLtKvtrQt8nofQ9dZ6G7WHjyQ1fSGJqFxYvtopZLKK4eNEi3Aug
         /h/hxQ4szMgBgIGD9XhF1xGYMiepdsXxIdoalWIMadTGcUCjLlhHUXEsWZksm5g119q3
         th9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793367186; x=1793971986; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ap8AI3OLMnsIvB+7PuWaSwO39DciT3p1bcrU5DUdTaA=;
        b=h6tDS7VdCT76/QSDtQrX2psEF3ssu/eN98XkJvjqRHqMa8UHzK5jPQBgbQk10A34Ez
         XzCjINdCtMn1PaKRCo/c6G3XuNzWyBzh9QETypw15kSNp8ULjNR5luxrfdT8ef3YHmgM
         8I6DbaZm07fAbhphqDU1yE7ml+BcOWvnTwHsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367186; x=1793971986;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ap8AI3OLMnsIvB+7PuWaSwO39DciT3p1bcrU5DUdTaA=;
        b=fJS5IgfM3H5b7ylPbuYTp9IUM70K/m4EdG1XPPkHVYYTiWIAGa5gxMselCaIBeiyz6
         7TxyUS/+jtZNZFQw4I+WUE32Rt2XtrQFPffxdSnIYOdu3UXMI04cvlTH5miOlG/mO/Qi
         t6S6Uvs67tOx/Wz4UHV0fq0OYN+inQNJ2B11tiGlRzUiUhkOx1fPKFsBvEtiHBlldkZM
         swoIkSvqallqTUsoDEjsEImpBoMJCp+1OJabOhaEsXzsplq2jGm8ZApDbUiy0TBPZSfe
         LV/NbHNAZuogSH8GnRuGh4CmxK8is27vWLqCTstAhS7Yq5cj4amByuHvUgoqz8tLTWha
         9j9g==
X-Forwarded-Encrypted: i=1; AKwUvBwbo4rUDzpeQIVe0sURz8mQVVM9ec9w20YrXAgFNP1D2nEYVYHNWgvQbbSVcnvxoeXWmHg3bvcRFUzlecm2DiId@vger.kernel.org
X-Gm-Message-State: AFq9FYIWl9tCKotvZXqdo72DM8juE++yMkySTXUPCJ/zUx5HwHF9b6u7
	4dUxQvpGqvau+iwXP9IYC3BQ8BsOnMkFL0cEnZo2GopAoJBElI7MN01KEFMJDO2tWqgvJWZESzq
	klIdCTiCM0g7YOyj0aMZD286rBTGuOOs0J2soVRsqfg==
X-Gm-Gg: AYBFou0alPszriIix2F7ImLB9hvWJXnOT40b3k+ub3jmU0UiAmP8bLEECp5uwTaPPvB
	nc7RcrA7M1f2yd53yJsAcBikVrTtfQ+nMYDILcD2NZc5+jPsIwou/xC6Vq8a4OCiIM1r9sIfANL
	RpYw8NZhjdJhZnxNMbhBBuDwd+CNzmr8KxgWQiZSpoFa7/tymO6vJX/XRR38MTFfh3vz/WPdMq4
	YFpA3cAHilCG8JUbcBnV9yxednl5usiCtE6cGVgoHRDSe2Y2OkeTwa6H5Y60fF1g1WWjM1b0JnP
	X6V7V1PdXkNlrR3K1XGw6EBGp1nchtKuXajpenvsycRO984B1DCF2CzeA7ZltZ2vse/k5p87+q3
	8L33iu1ManNdoVpm1351Vmohi9iqrhLDCtXEN7E0bgNNnziuwV7K175/9naBaHYTJwPxldG0=
X-Received: by 2002:a53:b449:0:b0:679:b87d:6f7b with SMTP id
 956f58d0204a3-67ba4ff3ceemr1245948d50.42.1793367185430; Fri, 30 Oct 2026
 06:33:05 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-12-irogers@google.com>
In-Reply-To: <20261027231513.816148-12-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 06:32:49 -0700
X-Gm-Features: AclHuK_wMQft7avMWp54-lWi0ChX2zhzv9PYbZe6NUCsPJGn_IUKnWG9vDQbSXY
Message-ID: <CA+w=M=TRN8SeNPQFpK5uJNMFidebSPtRRe7C0TrECUZKsRSTZw@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] perf symbol-elf: Cache ELF program/section
 headers and defer symbol name lookup
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> + /*
> + * For misannotated, zeroed, ASM function sizes.
> + */
> + if (nr > 0) {
> + struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
> + struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
> +
> + symbols__fixup_end(dso__symbols(dso), false);
> + symbols__fixup_duplicate(dso__symbols(dso));

Could the change to run these fixups once per load be split into its
own patch, with an explanation and a test? It changes symbol
resolution, not only the amount of work.

Before this change, a zero-size .symtab symbol ended at the next
.symtab symbol, so it could cover a function that only exists in
.dynsym. Running the fixups after both tables have loaded instead ends
it at the next symbol from either table.

I reproduced this with a small library where zfun has no .size. The
next function in address order is efun, which I removed from .symtab
with objcopy --strip-symbol=efun but left exported in .dynsym. The
same sample is then attributed differently:

before: 99.97% libz.so [.] zfun
after: 99.97% libz.so [.] efun

The new answer looks right to me. Minidebuginfo, where exports may
exist only in .dynsym, should hit the same pattern and would be useful
test coverage for the separate patch.

Thanks,
Alireza
