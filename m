Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587473;
	b=mXQu8OwhIJYkYZBbNRTeuTY6Df1Ac1DDdIjIhrNyDw4FnbdXDwdGffk0qytyKCiv6BD5
	 7sfxOScCXtfkftcNIKTlGTy60TST4HVJlAMeP4B/0S7TnfmEDRJMgBHr7uooMQq9m7n51
	 pQhkOX/7v3u7Y//ELWRr145rf5uXpGKLXOHaFsKxIyQXt9xvrc+FB0YJJV6VpWYyCh+H6
	 kzNHmIdExu1AC8+O3eajjF4N77WRlR2WquFQbuIKgW/e0u44Uqw0EktoWpZRqJ5SoYJ5U
	 vjHBqD9AskeAod0Gz8pMzh/rhM42b2XG39jJSr6AOgaOZeEv+wEOZgZaetG7UqduIaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Bb6MtTt8fw3gLO1EuXLXH1MyB9ZeehUQm7NFHSQwlcs=;
	b=g54mxlHNjBWxnM0g9WyZ+ZpH0x7k8BZ4gUlobzKvO90J41viKNSQ8AtSELCs1OrE8nM9
	 mBZqLO6pmZroU/U1xmYrkfcv63BpLWWspquJeFybvXqbWUaczppGbXzGEb8jNhys2qyCU
	 XjLkO53JQDe8onPTZHCh4aFczcw96hEf24x7qogyBXRCSkTPGUZck4PlMJn15nKndj0hA
	 /QGpSCazh2SDZDGw9b6B/YM7zPBaokzTVAqqx6mElL0/eYZhbhObsLULbzyYkzOkRq0MP
	 UulXQd5Zb/ZnsR1CZRqqNMGIPBcWBJzUvnK0y60MHZtu1R7hYIPFB0zVMIgsz9J+pFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T6hlqWCV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2C606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B2C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T6hlqWCV
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55be673e029so151951cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587471; cv=none;
        d=google.com; s=arc-20260327;
        b=NCvGHK6UJnW/sKKE7r0Lnfjyd/eLfFslBpXz4ODbX8aKwpwR1u2Lh2ofqw1TfogBla
         6s6wY+5+jO+GgG6Vgm1Ty420/xT7tmFxAdSwXslilreFoe+bBY93L5yktl7/IMvjSBnT
         X2X23jhkDa3V+gPwEh/aK0XQLnE6N8sUS9r5GdjMLj66So+wV27XQCckacZS2PW4yARp
         HKU5bLyOFqLR2VL81YRYcSH5YaPKQq84atefBWobI+ODq0QeRvTi2K5UNIPrOo+oMUwD
         7NixeFwzxLHHfSC55/e0kbBPr20PvyvcsNs2qi+CMoCxtjZBBzZ5fBid/6lDSytOBV/A
         ttFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bb6MtTt8fw3gLO1EuXLXH1MyB9ZeehUQm7NFHSQwlcs=;
        fh=1F3fj1mKqrY1GMsX+J2j3O2sISgHBgrOH6vz+SB+Kj0=;
        b=VsqnFh26+GeoiWDH1vVwlMufquDy04QcBLJsphei64HKLg0HsjV9WXMpU/4be5SyTZ
         VYnSUECz0lpJWqCVF0uqWcQFGEu6QPwInoKTA6A80cFOcRexmnoNfJwkPKaiBSj0a5z7
         Inzo5ST8W2YQD6HaUyfjeswhOX3bMv6EStHvvt1KJQYr/Uti2F+u6hh9nX2bXfAxwais
         ouEcFCKVJCqcb/X2B+ClZzfRjYVX+WOcVgrYln/qTT4oQidZquL1JkqTsok2/mcBYcsz
         weg986tBToRVxAGR2h5pYxd3v37+qb6xigGeHJ/U1zl600LD4owXAzGSCzpOvrwwr0mx
         0lyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794587471; x=1795192271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bb6MtTt8fw3gLO1EuXLXH1MyB9ZeehUQm7NFHSQwlcs=;
        b=T6hlqWCV3VyFOMGKBmHIYN98OQtnTELSxnavd4gXHg91iQK9idpaZnRFtSIXh8TRtr
         BU8HZO/DUx9V0+2kMy+IgGG9jCpmitwZrkwRe0AEtXcpWaoEqP9BkaadcaXfA0kzD2JW
         UvMVMlHi4Op6QCoURG9v17bbdHPyqZnRSE10hBaALnN4qHVnF1iYmxsuy35wrigR14Kp
         PIhPGA8cETjvoTekXJr7t8bXW9iSegL1qjpPZwRewtuuYeRKurWLK6KVIT0umH4wLYiE
         y2u0l093KdARl7IjNhPwlIhl4axT3QRv2UY3P0oa+Xsmw+N50uLcUblfEJ1rGTyHm5gF
         LN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587471; x=1795192271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bb6MtTt8fw3gLO1EuXLXH1MyB9ZeehUQm7NFHSQwlcs=;
        b=Vekm0WOLXozAJmNUxwwc3mbG1f3xHoawmFS+W4KMcQv0hFC368KDZZO56LmazGTENk
         Rfl8zEUE9LCwnIkbCNkAKZ9nmDu9rxVq89b20jwHS7mbp3HogDHIkt2Azl5+OcS5xDMP
         WKDXxqkFZI2iHiCpyKP32N4hvKMsO81ctXv3iGbb4w9WAB9mQtOpmgab8f4+7myn1kP+
         0QbB8B6wyhjouqPmmUqTHNJKf1XABpnz/XlL9MmyGNww++tAAXj/9tiicUEuEZ/Zy0VX
         wE4B4Q4YHFYN6d5jZuIA7gNzO5u2ye8RpqOgYalwQz/xTIZIwtMqS9U1+Eo8RFGP9AnB
         BLnw==
X-Forwarded-Encrypted: i=1; AL+hErFCDGJA7uivxPftgHVDM/zPWSNrNGlQWz9/BVArlcRYfWHFGiQYaYww7ELxyYf6pKIFv8f1R3z1dVVxatQ01mgp@vger.kernel.org
X-Gm-Message-State: APuU4Z/nG2JEWzIIQ4KLPQopUZNIKC1aQLfH4EMq+f5RcIlq8ALhTgcm
	QXIW1/5bUK5JE9TnR3KLfhFWkRa2QQk1sNyQLkPELF6UKDP36x9lqMP0rXXE/PlX7caXopAQllZ
	y2p384JiOHZoJR2GhAGVHI95qpp74/9jOWpHpyDZs
X-Gm-Gg: AYBFou0Jb36AqBtRG8wa6OV1/Bd5O4fpibwmj60+5Cn6l3cEdcHyTAOLy/b3l9wVhh6
	gypws56bIBe+/w2kfEVQY1t8fxOz6VKOjJ3Jw89hkFg8fN+2TjnBsabwj9PwYcS/a2ByKJUUxE4
	iFXtrsfNeW+NQxJQonpUWLm5MR8rMrSZs6xMeXJPbupuCnpArvj2/ceOJ1d+ExBreXLegPMBD0b
	pRCqHGHSbz3nUb25fKtGwoqx3lrLdBO0Ce1spHY236pYZrdENdfPKzZ82UTjUCPnhF4Sjc+94kV
	QKVPh8IC/Hy5skXoAoXY28wZJR53Cin8deXGelxK+VOzC+TQ1dtr8r0yaJ50A4jJ4bJcS4SeGEp
	aF6XrqCNDlCfhmi9CHQjwzWnUshxwv9PH3XwXEAt4gQq1cpZqHfi1Id9IiY+f2fIQOQA=
X-Received: by 2002:a05:622a:2598:b0:546:92f2:7830 with SMTP id
 d75a77b69052e-55add216af2mr14131991cf.6.1794587470995; Fri, 13 Nov 2026
 08:31:10 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com> <20261113-perf_fix_gcc15_failure-v1-1-eae592c5ff64@arm.com>
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-1-eae592c5ff64@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Nov 2026 08:30:59 -0800
X-Gm-Features: AclHuK81Umb631_b6CHlhoOVg9PPlSLmHdlP3oRotsMVgTGCQSYiylEnl9LWtQE
Message-ID: <CAP-5=fXrP+FSmv35KgvwDkNED921X60W3BWiMYHmLV-AzSG4BA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf cs-etm: Initialize the Thumb instruction buffer
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Robert Walker <robert.walker@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:55=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> cs_etm__frontend_mem_access() can return zero or a short read without
> fully initializing instrBytes. cs_etm__t32_instr_size() nevertheless
> inspects its second byte. With CORESIGHT=3D1 and -O3, GCC 15.2.0 reports:
>
>   error: 'instrBytes' may be used uninitialized
>
> Zero-initialize the buffer to avoid reading uninitialized stack data
> when instruction memory is unavailable and fix the build failure.
>
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix=
_non_taken-v3-0-7629b52ab047@arm.com/T/#m64fb81c665214b79883d9be815b40ac5f6=
669628
> Fixes: a7ee4d625ede ("perf cs-etm: Support for ARM A32/T32 instruction se=
ts in CoreSight trace")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 3e01b401ca6f3a08f44bb69204317efaf2fa18d0..25f12bd110934a204d79244f4=
5317085b7a81666 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1369,7 +1369,7 @@ static inline int cs_etm__t32_instr_size(struct cs_=
etm_queue *etmq,
>                                          struct cs_etm_traceid_queue *tid=
q,
>                                          struct cs_etm_packet *packet, u6=
4 addr)
>  {
> -       u8 instrBytes[2];
> +       u8 instrBytes[2] =3D { 0 };
>
>         cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
>                                     ARRAY_SIZE(instrBytes), instrBytes);
>
> --
> 2.34.1
>
