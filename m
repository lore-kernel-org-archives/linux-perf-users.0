Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AED3859CF
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131245; cv=none; b=Dzwko9dzzivR9fxDsCbypg1J0oafa8mJNDHDhgDL4gBduE7XCKqFpdwRZUjZcvwcDmwLyXr5wMX6X06CD010SSjPP3rtuI6wVlra62gzcXQPbQKMa29Fbu8WBzb9vuGGEAB/2T2XYhioG30ATnqAeLsfTtnhKXwI8H/+jJc5X3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131245; c=relaxed/simple;
	bh=5ty71ZP/kn9UYFYi5Gf8attnjAgfMP8XR0y3mMnTX88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXB83sScKimDubpggPOm68r6KXGUx9l2mHflol37EeYhe/YWf2HhfRZv3dqO9gjU6uAWcx8l2TzaZUIxQ9hN4tR8BkAO/FeQ3i8f7osYq9bPGk94i7XUep466ZEsUjzv4Gs2Br7LAMlU5Ahr7J2Hfb4VYB8iDCHWMilcTgTdbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtEut1M1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtEut1M1"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65f8c8c3a4aso2503416a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 10:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772131243; x=1772736043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ty71ZP/kn9UYFYi5Gf8attnjAgfMP8XR0y3mMnTX88=;
        b=RtEut1M1Hf7ppzqlx6DFODu+jXyhzXeyJ4Fgkv9Kq0aWDsxSq491Bs0kaIapAgANAm
         aTceN1nrdYtBVzb9tnge7sDTs5tGLEhoIc5Dpgtq4y1rIUI5cULRGr5ahkz0wrI2S7Qz
         oCOkNmo68x/7Xv3jza925NTcvh67rk/IaHwDzLTrx+DAXVnZjTIdi1ESpqNxxAD83wID
         S6zul0ykh8Y/521rRsjfJjCEEARESf/4E2yZOJhIDBJvtZz7VUmyybVzkzlyCiQunUhG
         UpXuE93mRXJZLmJMcr6NmDHgDdKWOM024cHZuBmfIqYotDXfJ9uCh30Xn1521aQThXAh
         UBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131243; x=1772736043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ty71ZP/kn9UYFYi5Gf8attnjAgfMP8XR0y3mMnTX88=;
        b=OEygfcKp0zIZishPIMd9X4SJZXS8b0stjp3CnOTSRjkihMZAcVOKJVZaSjj/CuXMqA
         gYM0MQmJKKH+o6KojJwu6vZPqCdNTtctgUNTW8SJn/ZjVXbfWQh4shHYjY1b9y4Lbofx
         /OZ7dxq7TdPVj6R2J2qelvt+m6Q+nxb+S/rWSYLhydEQL+D/5NbONXuYKe+x/9HJf5uo
         c+gYJvl5s/qAxWJpsKSSXTdYfb0PFqALddwZ7yE/udKZpBnS+FvjqQsnK62zDF+s8+gA
         PeOcWQUnC+zl0aXO5mpGuLwtv3fK7VgTf7y7b7mQUE2/brbAgkWnAhH6mXYdkTaH9BsX
         lWSQ==
X-Gm-Message-State: AOJu0YzzkqXvG4RyuC5ba0LcJEfXkLM+rfdm5zVgpU1bPgTSUY6kuaha
	6WayJ5Rhznr/vhgBRxZ3lZlqY8bjjZy6K5o3aOvSX3LxFYxh2Z+VadsK
X-Gm-Gg: ATEYQzyOTmDWfQapuiCmDm0L2azfFhuENGl41VffUKW2VC+jtNsESXNgV38ApGIEIvA
	Q9n5rUSnL+UvWXG1C0kkZ8uYTxJvliH1BtaWb1amuzTLSe+XeW3T+U/c/J+FrijL0pW7lANdn88
	vMBHZIqZFfoe2LpChLCiyEtwUt8yeU+grFHj/98vezXI+Acxrih/Q+/Z0S3/SXscPXiLOIpBvqN
	ikzYWfS3QfuHB0UekSsIDijO01zk1N+kGstysh3USNeaVRxGzKlcbCImYQuC4+557eGvEKO+cMS
	vJ5dbdvHuR9WZbgfrKsR1eyCAfqE8NangJ/at+2dDS+6MJaiWpZ+L/hYNmlzZe4diP4jJ0gIhD1
	9lPpVWJur20WorW5rHpb31/+Mr0SuwyfQwhK3t1JksShzh6x7aOIIo12Ad7QhIY1p0RigFnWH8D
	F54V2kUCrXixDY3mTwRslxsdwlz14PaRGHa7hwV7/wO9QB14Lw1YmYJe6HYDPKzLBLKuZMn3Fkl
	2a4ChupA2rz+XJdiRAN1HQOe2+tifREloDZu88fZ54BmpI=
X-Received: by 2002:a05:6402:1467:b0:65f:9c21:e69b with SMTP id 4fb4d7f45d1cf-65fdd6e2ee8mr211415a12.10.1772131242711;
        Thu, 26 Feb 2026 10:40:42 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd36219sm669054a12.3.2026.02.26.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:40:41 -0800 (PST)
Date: Thu, 26 Feb 2026 19:40:38 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Levi Zim <i@kxxt.dev>, 
	Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v5] tools build: Fix rust cross compilation
Message-ID: <mnakvrusyjmuq2zwdjataxq5wc3m4bhyynbwdku2s3kdvtsi5f@2n7t65aqbupy>
References: <20260226170025.517743-1-9erthalion6@gmail.com>
 <CAP-5=fV7OuWN9K-wnsS7zza+s0FQRSR_JCcJi5tvpgQAbh=Nnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV7OuWN9K-wnsS7zza+s0FQRSR_JCcJi5tvpgQAbh=Nnw@mail.gmail.com>

> On Thu, Feb 26, 2026 at 09:10:24AM -0800, Ian Rogers wrote:
> Not a cross-compilation problem, but is there a way to pass-through
> extra flags to the rust compiler? For CFLAGS we have EXTRA_CFLAGS as a
> make variable, but I don't see an EXTRA_RUSTFLAGS. I was looking for
> this because I was trying to make a build passing "-m32" to CFLAGS to
> create a 32-bit perf binary. The link against the rust workload was
> failing due to the different object types.

Nope, not yet, currently one can only set global RUST_FLAGS or per build
target. But sure, I'll add this in a separate patch.
