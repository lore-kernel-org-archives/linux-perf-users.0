Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52A23CB
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179449; cv=none; b=FSklRhntu/3WZasJuwJjc/2C8T9B1merOeJotR30dKsBaFXERSgTc7PlJ4fNjhWQgASSuScLRu4xDPlXE/0S55N/hz83pi1V88CG4+XaWF8jAJp0ekIGIlZrLIRRGcEQFluAmEj7wEtldG0t4tc84hpDw4Co2xVmgHsK6NRMOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179449; c=relaxed/simple;
	bh=oJcLs5zByI0udEoZcRHL3+6nu9mj4NCaoOC1Zr/eO94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZfPSdDQS0/rfV4vN3xJUhdnT4XZN6YkJoPIqF+r95qmy906XkVADAnPAUM2cj6xQBMJhB0MkT9KQMlm87Q7H9OMV1369pLt7yfcemVSs9De811f6ZGAt/4loCCD3lnCWAp61821wM6Uasfip+cWhvE5pj3G8gAWzMIgFMexwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGdShSYv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGdShSYv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so1035ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743179448; x=1743784248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xxcffi6++cWZ/jI/w1A+7iNPn0Zg4Z2BFqcjFQtfWZo=;
        b=fGdShSYvi291YBycY4fON7cBbrnHtbpuY6HajA+N7v4USAC2mowlagZxdMhqMwQvuP
         aVlzm2ffHimSQJ0H62O8QjYu0FsCfaOHpoYzVA9aKekAv/Etj/w1phcY1MS5bDDmB/UF
         HiKMFRmptT9cAZtkS+OH1voTDzcorynoBITyCBVNpkZBYlWdXFOqdUX0xkrzzrtITKLP
         RR3joHI6B+zqL2tJuckk6EOPL5MehUGNuv/sWvOT776sB5lBn98oGR+xzUCKn/rUE+it
         ooQsooQNJv7snPFOGWa4D3+PWGxrTYzwGd9bo45sBQaBEPu3+dASX/FDCyXnA4ZOj1le
         9JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743179448; x=1743784248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxcffi6++cWZ/jI/w1A+7iNPn0Zg4Z2BFqcjFQtfWZo=;
        b=BqvlsnfG/gIPLovUJ1EZ23QJBaUDB73gXrA2eE33iA4ohCxNFIPgjVyOG1Fm1oVpHE
         fCPEBXdEkKeISa0wA2GQBuIPxju31jrRFZEE974nz6NQVOIptvmPJIdDUDu610qJPbBr
         V2ifrAv1MN/4pVdo0b97qpnwD9saFcbbNTw17epaJmcOIJbhV3mZjT5SLGP9ABgacegj
         ZrQV+TI54SE74NEAEeNZsM8Ri7Atwe/hofvaCVOpYn+2BpBnUKQMd1Wec7muCkZlMtLH
         YKRB+nitR6fAAqTD4G/BJI51S2UCMmdgtntMk+FOXJ0M4xo09mSi4/vtiesWdtV6R1vW
         WJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVYEZ14dRAJj9l/4lUMg8/VEvpkhDKiNFVhcJg9n8BstAr+PKIhDAqkyvMDWcYiyhksmf0qMwPoX16rLf/+He3@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIWEPWfOrOBOpIisgPIe/sk/f05EsAPeTGTfDvRup9SN+ik5Y
	hnDBtZaNLGYw0x0FZDm8jOotbqW9eRXli7U8tCgnL636NLzKnGPdG9iXC/R+bFzQyE0uaPR5w/+
	HEzkTaTo+6hlI0xdR2C2d7xeoB9Djgx7LcDDC
X-Gm-Gg: ASbGnctKxct7IXnYiIbt07vZpFD6sz7Vza49q64NNCTEcCSNuQn9zZ2vcKJ1P6y1dtZ
	JxHIhWEdtreKTdSsOx2o1lCQRv9Y+MpGzY96TcvaT952v3NYHL1lVBqQqOVU7ZeIxIUap3GXcih
	IcTUcyZNgIqOirNVBaqBEsFCu2ouQ=
X-Google-Smtp-Source: AGHT+IFVc9QCBmsNW5wT7vAExXzBSbdS6cxvgPMW/AA+Fo3S+hXs2+i4rMY5GDFVkl7ZD3yijZkWg+RIYZI3aNkVAHE=
X-Received: by 2002:a17:903:2acc:b0:20c:f40e:6ec3 with SMTP id
 d9443c01a7336-22920e42c06mr3738365ad.22.1743179447424; Fri, 28 Mar 2025
 09:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328122644.2383698-1-leo.yan@arm.com> <20250328122644.2383698-2-leo.yan@arm.com>
In-Reply-To: <20250328122644.2383698-2-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Mar 2025 09:30:36 -0700
X-Gm-Features: AQ5f1JpdxwsldtqevQ6AZWCaFns9F9kJpYrqUrFZJHZAt64nXXlwzJE0cAJWVps
Message-ID: <CAP-5=fVOf+2MS6axbeh0cX10iepOvRnLDfr3xG2SAkwQ8R70PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Remove unused LIBPERF_CLFAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 5:27=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Since commit 91009a3a9913 ("perf build: Install libperf locally when
> building"), the LIBPERF_CFLAGS flag is never populated to libperf.
>
> As the flag is not used anymore, remove it.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the cleanup!
Ian

> ---
>  tools/perf/Makefile.config | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index eea95c6c0c71..94dfc18c2741 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -389,8 +389,6 @@ CORE_CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET=
_BITS=3D64 -D_GNU_SOURCE
>  CFLAGS   +=3D $(CORE_CFLAGS) $(INC_FLAGS)
>  CXXFLAGS +=3D $(INC_FLAGS)
>
> -LIBPERF_CFLAGS :=3D $(CORE_CFLAGS) $(EXTRA_CFLAGS)
> -
>  ifeq ($(feature-pthread-attr-setaffinity-np), 1)
>    CFLAGS +=3D -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
>  endif
> --
> 2.34.1
>
