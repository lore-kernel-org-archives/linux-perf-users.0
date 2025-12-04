Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA221ABD7
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858775; cv=none; b=gy8tCWY+RaCESbhbNbNN+zt0f04s7G562ruzeu5H1X71Po0Brg/C1+QR3Ei/H1CG6RReLBhhFgh5yt++5tauhIiHc24L9HTrJzRcVJ4+RbiyDAB97Pz5vFraqPEGWUBB8K/fTD2ysmHNTQjJHIs5b95+NDBN1YGWlw54/gVlfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858775; c=relaxed/simple;
	bh=t9/qFMla3/ao3at5BcBq/CfTbrOmXor3GPtvLpg1sJQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f+92APx5gSajkyJ12x2vhjLA7Sq1+xsxUWrK56yIkoh0bjWyJwNAQy/WErJx4syXS/0QSGw8nfaib36oJhJCYrg2u9kgyRE1sahWzmRsREXwt+yM2480YNF7qO8O3/ybDHOBk7zb2zXUPKEg/tSVlTvGJQaIIBNt5dLTcbOXLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzRBdeW6; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzRBdeW6"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-656b4881f55so532843eaf.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764858773; x=1765463573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ApF+lq9vyl7sPIbcvI6XFTDweDtGUFRLdBndvRJKvZc=;
        b=BzRBdeW6sSYKRfZRF3eZGKKZ6NzYJzbGgw87rYjmyt5c4SECcF8jI8nlJHeZ6NGI5S
         ssEPi6p4P2iEaL+7FgMpJRuzRy5/wl533iyu8SvdH1Kc7FDGO4K5i1aCxsVwKSBMsJpY
         HkTHsdH3MJlYlgZakcVoY433DzxfRo69e10gpC5XyMGtN7Gwtf7uazUcUrszouyihhXf
         O9HkoXV60I97Mpk7fgBA46z6QFNioF7DD7j3VcnY8MqlarrU1feSMYkLbyKIObh6FC2m
         U4F9mVpsngrxTUewceAGDZFwdaJ3x+fytifv388yYxD9DSZfFGbku6REVjr3FM2FVq0b
         7emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764858773; x=1765463573;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApF+lq9vyl7sPIbcvI6XFTDweDtGUFRLdBndvRJKvZc=;
        b=uDcjz8807laE9NhxfFratChnQpN6CZ7jQ3D24B4+EJnmkwfbIT7VGnGds79v/gmFLT
         wpqw2VB5yOQx2n7OdbfybuR9BpWk4HhIIm4/GP3Ife9lp9AhJPOojm40StvSkCXoTEvP
         3/4a10c0dkQ6tGWPJhLyoxrlC6hkoQxoIZXmnzG/cia3LPFcheTb20H8uklnj7drmQ3+
         Uz8ulGGx4Yo9uEEsAS23x/xYObNJeOlaEv+0ipvWLw9bDL9llMeFrH8Yrn9JM0iEYXsp
         tipZaQ85XdDEkhxSF5XMBAoJVhvA0BgalW90Xn7sUK5jS+yPqccUgXLE2cLAKpU9GkyX
         eECw==
X-Forwarded-Encrypted: i=1; AJvYcCUXwVLvuinKxmqj3dkZ6Vx5kWGErTkDiMpWwxA/zYPJDb/zDDlkVUXzTDNkMz3CxSiBESqbW6q+j/VJfQEGWE/i@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDexIksNXz3yZZZcmzQaq38qqel0hrCf6q7jlu1wrY6O7aHAh
	bGCifp6YPeupTHhvZ2LjeLI9zWMBDs2EU42XhcKz3YHFgDCLAWX1yLjDT1644miw
X-Gm-Gg: ASbGncuWgXtuzAZn6BO138ApeK831pgdwGpcBP1M++exZGE9WFw5JTF+KJ2TTUYp7kE
	fyOsFAPOuHeL9LVc4jUCXHRIC9XgIZzJ7uVIm0qZy8ngKIBtfA5WibjsPBTpfTUPm27zmFsepy6
	Hq82QzFSta/15GacU6lnYMxhZCVfYBmfBLAMVDIgPg1fWv26syFLvVe7HVssnzWscGqEjmr2y/Y
	Y2mLDIuqOxyd7bmIZ68Z4p/jj+vDES+iN+xPsfbeCh7S4VTjdee/cexqC+dnkpD5NYSKmGUsyqe
	YQgUn2Mv8Wousa/72JjR0Sghy4T91lhuu1gOoFj5wASsoQWde3h9ta2iBg5+OB8M1716pxRgY3V
	BWb8CtQyNWTyqSXyo40GrGJApeTBUElXj+hCDVSdk3KonK5YyOIOY+q1L67BdiQIUZSET0/4JMU
	eR16AVQE9o5YXMhMbT40jj
X-Google-Smtp-Source: AGHT+IGS/5Gs1BpVIDOMYyZriEdNA1gGzMBGy/3VoAobZgq1D27uY86F05vFM9m+ujfVJF7mmtpo6g==
X-Received: by 2002:a05:6820:4dc9:b0:657:5723:76ce with SMTP id 006d021491bc7-6597bbc8b1dmr1336424eaf.5.1764858772960;
        Thu, 04 Dec 2025 06:32:52 -0800 (PST)
Received: from ehlo.thunderbird.net ([2804:389:8130:8976:1:0:a370:94f9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6597ec25ed1sm769870eaf.1.2025.12.04.06.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 06:32:52 -0800 (PST)
Date: Thu, 04 Dec 2025 11:32:47 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6=2E19-rc1_1/1=5D_libperf=3A_Compile_using_-?=
 =?US-ASCII?Q?std=3Dgnu17_to_deal_with_visibility_attribute_issues?=
User-Agent: Thunderbird for Android
In-Reply-To: <aTFJT8kQsxnxBaS8@google.com>
References: <aTCpiDG6WOzMv7ji@x1> <aTFJT8kQsxnxBaS8@google.com>
Message-ID: <D6618627-090D-4795-8EEB-72628537D39A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 4, 2025 5:41:51 AM GMT-03:00, Namhyung Kim <namhyung@kernel=2E=
org> wrote:
>On Wed, Dec 03, 2025 at 06:20:08PM -0300, Arnaldo Carvalho de Melo wrote:
>> We seem to need a more invasive patch using 'extern' on all LIBPERF_API
>> prefixed functions to be future proof, so use -std=3Dgnu17 which is the
>> one in gcc 14, present in the distro generation before ubuntu 25=2E10 (=
gcc
>> 15)=2E
>
>Something like this?

Yeah, I probably got carried away with libbpf's accidental way of "dealing=
" with it=2E

Will test build it, or have you already?

- Arnaldo

>
>Thanks,
>Namhyung
>
>
>diff --git a/tools/lib/perf/include/perf/core=2Eh b/tools/lib/perf/includ=
e/perf/core=2Eh
>index a3f6d68edad76240=2E=2E06cc132d88cf3436 100644
>--- a/tools/lib/perf/include/perf/core=2Eh
>+++ b/tools/lib/perf/include/perf/core=2Eh
>@@ -5,7 +5,7 @@
> #include <stdarg=2Eh>
>=20
> #ifndef LIBPERF_API
>-#define LIBPERF_API __attribute__((visibility("default")))
>+#define LIBPERF_API extern __attribute__((visibility("default")))
> #endif
>=20
> enum libperf_print_level {

- Arnaldo 
