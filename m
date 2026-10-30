Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793332816;
	b=wc7SJiTDApE6sXuDAkoYudDwS3jdIBJVkkc5SN7FIIuExyZ7CxHpMVOIWx6XwFbee2UD
	 dhwNCoRJYxf7jjNDnP5Ny/ZUlGwy2NGzUxa/7hOaDw9KC5S0yIJakLQD/yeuBpCvNagqj
	 sn9Oat0Cccn6iiH/OG/WbmmUKKDbcT7yG1+pIx26MEU7SOG5cTJCXG5O8Hk3VQkk3gypG
	 Mm7u2yE427RvhRExJWsI0GSBG4aQCslTwvUPt+NaLeHcxCV7XFw9u4OBxKI6Po7rNScC8
	 yFWSMdU/3HrZOWmJ+QzOZmg7+Wx3Slt/sFRrWnsxzQ7wrJ/4ilA8+WhajKuFVMwdiZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w+nM/vAkuCP/V6D3oVU+Bkna7/XRYF0/nbbL7krfSm4=;
	b=GlkSYTKIjvcpN6aIzDtFRMFguwazEzQ6chSg5U8d+6xvqesH4V2I5h3+XkqbiGINqHmU
	 5OOTgQpnYDQ1zgQmt7SAaA+aYn6dIK5g2q8FlHhoFXH+8dRYXj8hsPSIweSOWnGWUaLsW
	 oKWKtnS8gAEpHfGVVn9WpnmR2jQqyma5s/9sD65Gi4IZ864TWo8V0/sx4UKkxPLXPepgc
	 /5aM5v7sPKmfMx0RL+GDoVAWcE80VtMHaA5gEFH5mP4/744vuyYkTSJzHr3FhicxudMHz
	 qVrpZYoLLapTxyq7oj3N1y20C/KcfiTB8npbYkbslC+xHqakNoQqYvSUn2UMHRkzYgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Epqzn++T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E95606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Epqzn++T
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab28f3e4dcso11680321fa.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793332814; cv=none;
        d=google.com; s=arc-20260327;
        b=Mhss9j+WavLVvLuBVGrqMKGqj/2xa0PiPn60C/kw/zEPAejy8e4TNta2WXqxiR4qvq
         RkXBnFVbbpy4r8aTW2XQUQ09Mi5pThtZRdtvJecYIqBzRNLY3/SHFH6J2p/v0cq13yq9
         o1uQ2C/DdqLTmXrnepBHiaQnVrsgjLA0N5aq+7zfPCrzPqXelHqH/HCfVafw/09xg75b
         lrlkSa03pwwXEarBMv5fmPbFtVypriRD2XqEUQ+Flm1T3AuknnoB8kDqwIIr3Fp36alW
         a4tfwaIxc10cnxQkQtjDPdHfAavt0Ca7lDg+cm0d6zdV2hGL1B2+/pwserQdJJQaboQ1
         7/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+nM/vAkuCP/V6D3oVU+Bkna7/XRYF0/nbbL7krfSm4=;
        fh=H5+y9FatH22cxevrn3RgVVgUC7FO05cwZvbvwXxmjKg=;
        b=Rt/msrYA1xeclDK2pnzOhq8kQr4p55E1Yrv2alxp/eiP7dknBnRqrH5nbOspej7A/J
         n2Bod9jVEfbVwwbb16wA0YQPhCL04GKckY/l09h+SXgSssR+5cifqVWPVEC1nU7H4TEu
         2mw6EzXZrxvNPJ1xohk+qLzqxWE4bLdpmL/H401oRg/leJ/BQ1oPaspMPoKQoFzjb1uw
         3MmnDv2cGMKGSVsJ+f0Fm4769TUZSneMOixkX+thVpZK5KHf7R50e8w1KyznurDIqr4H
         xkxGADHHlNQhBf3I8T4AlGODx4R5YrFIWghdGjQ6Siv5hbs8/yhEpi3+Nw20Tj4hDLd1
         RqzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793332814; x=1793937614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+nM/vAkuCP/V6D3oVU+Bkna7/XRYF0/nbbL7krfSm4=;
        b=Epqzn++T3ThHlw+p2SQJa62uo0Fu2kGBJpXoBicTYzqSdjSehXr1hZjLptWfjIiXJR
         pJUpUbU4BuEYZm38r0Rw2O4P/EvFduucyYU6TAsyUqtAEiZNP8FI6XujHB+4HA7Gva8J
         0ytOjdd2fQOkdFHaly+iuSq6qh7BnZ3LszMKs61zPfs1e//5PKcBH96VCAf9QKdMhSSL
         ZU9BkOHmvzEd9p2R3kyxcQtWW7Wk+34ySlELX+gmgKH+Ug7cj+hk4nUSd9/3xI00DsW7
         anYJqlX/RjNQdU2NrUFalbMYh2Pa+kT/+EAKIbcHfuQLyvbk4FaG7F9S04mUAUIaClta
         MOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793332814; x=1793937614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+nM/vAkuCP/V6D3oVU+Bkna7/XRYF0/nbbL7krfSm4=;
        b=1DgMwzKcy2xbTYEHQIq40kVfHk+r8W+PSbIdWvYH1z6SuhrBlxuxJnBMQu9XpRGjF4
         SB8LwBBJIfJHNuA4UVmnAENsNoprOr1Ih8rFtpLwHvSMyPJGTsfgPz5tH1m1aoqidrUN
         0u4/Abg5BGwNYQgylZISqGdHmB4WO80emSmKsCoVcCL1Kqz191byyelrFBSDpRj2xhuO
         4rSIc9tpIxbmStMAgSy3wyRpeiQhlNzFM18mmRiQBo8R0uejrtWPBdL/B+NXGYvCDX4u
         ABPMq3IDWUL5/YREJB961JjfGkDYuCk1OUlbkdLaL57zTVYSXYt+FW/ir7aKBqmLt+Tj
         m2vw==
X-Forwarded-Encrypted: i=1; AKwUvBwNr4E6oHVQqIX+v6ynzHgR4e+coYtPCcpZw5I2nocsKdYMUoefj/yfks1hEiG47rYujFEMokG2BRZUvu+02ooP@vger.kernel.org
X-Gm-Message-State: AFq9FYKiYcNi1lFcUUCMHufhE7j2lnQbBQzEitw6glbyQ0pHkh2yZmXn
	EhYIxaviBPVinP6rCR5hbpsbaKJsQ4CBG/k3Rb+Wf/DhwvEGVgWC8bXOijsPoEYjfCiDnlU3Tqa
	0ljOdAktzr3JTia4NGrFWj9qQrMXsV18=
X-Gm-Gg: AYBFou2qSyWlzyZO7lsn6Vl0htsiTrIXa8jyeiSPZnTGd8IcFjrc8GEk6hWM6ODqE8V
	aj7Ddf1nHk+gz+28pX+eYkULNgGyP6IoWT32iw2sLydTTlKDFmpnX9srCjFlqmQO2C1CR1t3zRe
	wOpL7/LhlPppWxPbeiHctKJlY+vSpjOyDeJGKZhMu/6Wtk5ciZF5w5HhQJ6NnLxUu997P5ZkFrC
	92FGzLA6xNXsR9nM3oKnNbl9xKIk/d49F/wnY9vcrMbcM8thSACaElmtvzIgmVN6aWq0/WzgxY+
	tAanRwxKERXGhuD5byoUol7rNSfBS0XDn1nXkhXP3moSSrGoIz6dC9at0e/cGveisAM12mOjT5Y
	qK7Xk6ju0qrlxMJunn4wUDPGskCU6p71VlavsnVgUcGQ14CxJBNpFLckO8Vqpt1xYw31pGIjMFA
	Sh9fjogvFuyK2Pr50LOiQJtdSo0VCOTdHeBkd+oHY6ipjNaBWMKiZU
X-Received: by 2002:a2e:bc26:0:b0:3ab:13e6:c351 with SMTP id
 38308e7fff4ca-3acb7966d6fmr1569531fa.2.1793332814462; Thu, 29 Oct 2026
 21:00:14 -0700 (PDT)
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
 <20261028-alpha-profileme-v1-5-d44b52bf2500@gmail.com> <CA+=Fv5S5S3o1=2LetFuLQNqjtuw0DTgxVWAYAiAVvsdUNgNEyQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5S5S3o1=2LetFuLQNqjtuw0DTgxVWAYAiAVvsdUNgNEyQ@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 00:00:02 -0400
X-Gm-Features: AclHuK_oJ3s5RUCirMOkhYNov1PNLqWTliY-wAZYDiCbHMWHZpexW4vczKNrsL0
Message-ID: <CAEdQ38EwMT2a09rZMcJDmots55b6bcX0-ARWfb1sC7w7n3VkRg@mail.gmail.com>
Subject: Re: [PATCH 5/5] alpha/perf: optionally randomize the ProfileMe
 sampling interval
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

On Thu, Oct 29, 2026 at 11:02=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com=
> wrote:
> One minor corner case? This  multiplication can overflow for very
> large  sample periods. I guess normal sampling periods are not
> affected, is it worth using overflow-safe multiply/shift to avoid this
> limitation?

Yes, it overflows once the period reaches 2^35. Unlikely, but perf
allows it. v2 uses mul_u64_u32_shr(), and saturates the sum with
check_add_overflow() as well.
