Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B319E7E2;
	Thu,  6 Feb 2025 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878318; cv=none; b=VSC/u1RzcEp0vPMjOMOWjfK8Vj48WSRFx6F06c87o5GN5zJduaAzSfa/mHTaFiFhHX9bhrEaYAmzD+uUO3tSwogJUSrkXkn0nqjqzgXphUCFiWIcH6VVxnb2DigcAi2FUAidCTZNyJV5NW3fNxoRsj1CIiuAjqLzdpR3oLkcltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878318; c=relaxed/simple;
	bh=vX1h7Y+mQLvT7+n3+LXKhW+DHYLbwB1DROYEtaVwbSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFL/RybjwrHxT4O0bdlpxXZwi+mIOJ6pS1tpMgVEyksuCFDgJ22oinKnO3legd28861kiPGQe6PSZAoXgEjrE6RqS06Oj1E1cTkQHPpRs75w5zvj/Dnj7xbGcqwgKyew9/2GtK+wZMue47usd/0/TemytQtvUB22dVVtfLpRxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn9MI+kY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn9MI+kY"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dcc38c7c6bso2791151a12.1;
        Thu, 06 Feb 2025 13:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738878314; x=1739483114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vX1h7Y+mQLvT7+n3+LXKhW+DHYLbwB1DROYEtaVwbSU=;
        b=fn9MI+kYyDtkYCiwVBkXMotlVWleTWg9jh9hid/ER+gImYZ/1ZOKgw7DgQlCB7HmsJ
         epi3dpCnLdeozsxefLWmtvq4H2b92O7R2R/+AQlnqSHzTujauwnr00wn1m6uyWGzkiWT
         +PQcfSMJFmh4SwcPmne76mDqA1FfjqVUY1MmPCnGEAtS4OO3j6F2iMjyy5ah6NQsYCHu
         0PACmXCe5iA8m4TCI7vQsNV+ib6GjHtCWxpRQ4bl8ItkED8CCjmisoMXqgjnHAz9vamr
         48tCh+4bNIoDl9lEOfBfUDB4H8wjbGH3cBlQH2c6v2OBj6b0/VhGU5qCNfYtNw8SdwQA
         6Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738878314; x=1739483114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX1h7Y+mQLvT7+n3+LXKhW+DHYLbwB1DROYEtaVwbSU=;
        b=HQg1XCnM0EcwIlR9uOml3K72XKP/XJKDjrtj1gy+BkmnpM5Zu3IWox5lxBi/aW43PX
         3jc4G/T60+UIjinfm9o+rw9pDq6yAHNJs4wbiRfsmULx1vO9thsa1D8dp+SIpPFgDx2S
         NhnqUCj8o5PTcBPZMtTkBiehgiLCt1xR/1dETQ/RO1sdFucWjZgExQDaI3mLKVOmSR2C
         xDWh1+UQCL7XU4fnViDbaB8m12K5HJAPndvvGUFJdCx2ipbYHHm+YuFPRZw+83fyiHEs
         i+Er+ZZoFyqf07ujkJeyGNObBfoqw5qzmsxHlEHuD+x2mNJBHw24ZnPs7gPSh82udAGv
         aWSA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1dmCYmRURjawU6bYby5EyxFvB3KDyN/gV1qa/4/dkGbriJAldIdv7tTnW8A5/sfsY0gnxCrdySt55jA8AgD8CA==@vger.kernel.org, AJvYcCX5plQegFQ6xlKO3nJyeJLpdexR5PhOvemVKAplL6QlecmZSf4M5NOUoO1rMWL3thOWnIhcF0gRD6ePjF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DRJPQpqTp42kowyH2Yq5/L36STt9f9CVmGSQ8cLGkyCNHGLV
	vuqYZbGT7+uZH8TtDAUO6g8QQP0qf6Lo2BoFkY1s0vu7U+M2t6GcdFbcNuhruCVG0hiSJ+gkxT8
	Gi/+y04iEJtcjjAsvKvc/Qyl61ZI=
X-Gm-Gg: ASbGncu175RG8zw7yXvAQH7XGsEsDYe74MYUvqCSE8nyMn/poiyrXyBPVZ6SW732ilE
	s1RuGebdLgk58lSO8BuNXse1/CgMajqD0lau6kJ310OHe5wU0m0mfTL02f/ojhNCAL1oqgmm7Ew
	==
X-Google-Smtp-Source: AGHT+IHLLhgmRm8MJ+Fo9/TF/JvBsAliCwDZAK2UkFFsTNUNICLPj39Kro+k8SiA6Bc7/r/NLcQvQhZXrMc3cAHPgWE=
X-Received: by 2002:a05:6402:26cf:b0:5dc:7f96:6244 with SMTP id
 4fb4d7f45d1cf-5de45089cddmr929875a12.23.1738878314049; Thu, 06 Feb 2025
 13:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com> <CAP-5=fXV6b2g9QxPe1EsSTcHZpSPq+EAR71jvpBGW7ehydN+Uw@mail.gmail.com>
In-Reply-To: <CAP-5=fXV6b2g9QxPe1EsSTcHZpSPq+EAR71jvpBGW7ehydN+Uw@mail.gmail.com>
From: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Date: Thu, 6 Feb 2025 22:45:02 +0100
X-Gm-Features: AWEUYZnTSSKe8kl3b6Y9y-9gjXy39Rhfv9CXEcZlMaO8WesZOliobsVqRWaUExo
Message-ID: <CAOQCU64Fhoek2YEJjhtAsTqPa1Jt1X9z3_C4+pL+R-6hs-EdDg@mail.gmail.com>
Subject: Re: [PATCH] perf: Improve startup time by reducing unnecessary stat() calls
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ian,
Thank you for taking the time to look into this.

> I did a series and a new io_dir set of primitives.
> The last version of which is:
> https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
> I mention this as I think that series may be a better route than this
> change as it solves a little bit more of the performance issue.

I'd much prefer to have your solution merged, as it covers more instances
of the same directory exploration pattern and provides an explicit
approach to memory allocation.

> I stopped pursuing the series as the maintainers were complaining
> about unpopular libcs/platforms missing system call definitions
> (getdents) and the series breaking on those platforms.

Yeah, I agree. I also don't think doing an #undef because of muslc is a
good approach. Would you and Namhyung be open to bypassing libc and
calling SYS_getdents64 directly instead?

Best,
Krzysztof
