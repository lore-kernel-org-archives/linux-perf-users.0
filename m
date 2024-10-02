Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ADC9475
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881060; cv=none; b=JGmJUUte5gZgjdCjlCwL9b0z0Ld0t+zWF7oyfvxaYn6nA3xWq2qwjdJLwB35ZTwsW/kb6TAyFJ5h/hAz+0EmPW83pdc9PATUxJKoJSKs6wUHza23zdQfWrO9uQoTX+yj/xwEaVKHhnNt53nIvedQJTNW2ywDEvVwVQ2JlwU4mVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881060; c=relaxed/simple;
	bh=+/j64RBLEw6+Or8eEMouhwBjarsFfFHF9R1Cr4oJslY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVPgwYD2Qc1Qvl+31tKZlVtQzHUgG6H0swZbVXRy0xmATmS5KNqvRpIKLm8YWNzHOkABFogXEKMLaRKucxlIj2l79Q2X9gR9q4HQT3XW0YEadXpqi0NfLRvnJqCg1Zd0SP4IXdk2L9YxZWPzjdT58eyun0OTjU1OxANYNq+MQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8zBDn9o; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8zBDn9o"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso3555461f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Oct 2024 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727881057; x=1728485857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwkiQ4yapqQ9CqZDugC6AKZZOdPHtvbZvSqmBgmxNqA=;
        b=c8zBDn9oDmgyZDUTRA7IePCociM1pD22GVrANKhUn5gPqMNS2TPgM8OvXmKWEz2NDZ
         l8Z7bWc++3iToNuv4te/wV/7cHCeXj7kkjoEBCV8wGimpHDaxvo1Y+ReaXOe+Vy7QtwC
         hkH/zcXGN/ZSvSOxuKFZECh+8lIwUzj7NQ/eBd5v0peiytwpsaov4IJTeFG93vKzLXVy
         eyu+jbuG9jnubwRyq/+ecodhOcB8ZOPp42FXn/No+IPBBY5sfYHtghutms69J/oGZ8/L
         KZOej5NTf0Kvr2XATXKLkZR4TelbNE8f1RUJnqrun/zEkyL5Vq/q1qQpm60nmwvxsICW
         G55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881057; x=1728485857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwkiQ4yapqQ9CqZDugC6AKZZOdPHtvbZvSqmBgmxNqA=;
        b=bDLwc5kKQbZJw7hztVQEp173d++1iQswcaJALiCoivzySfnJgLkdxFPw6QBhrbV4Wq
         YMZaN7ARV3ITVkyNuywFX0WvuAYTLJ8DEFS1PInvCTnVFaNRBgndhV5WhsPlF64mbviN
         sSdW/nuZfqmM7UbDNLDLCTLiJcbRHkU1Q17JkiJ5FKTWO3jPwWw3RyWM9A1UX3kDSBqk
         GZuC6Ew7tjmwBP9gB8a0AKBJQC+wRf3mzEO8E2da00vAZhiB7wNj6is0z3+h9EA93jKS
         iWVOh8x9GlJXug44adzLExsrTNvpwxMtuorj328mPMykCXZqtitF09Z6ru2BIrVCh29k
         sFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxWJlr59svucuTGMYX1J/0RcBaaeyPd2VrSOXm7u0H4+avk5IJyo/14i+xE97K3TThmCqSvgdD07UbS7db6rJl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrj8/dcqV62Jh7k+esAYVl65DrlAg7DHacxVVprEs+bQ3N9KXo
	V5tU59sNUxUTIDQ1ypATEHvedTSyNa4AYN4YyUYl7SOY8TsoR3hwcplq0GfIRH0=
X-Google-Smtp-Source: AGHT+IHkinX9b1tbPuoVf75VzaWdAshBVSRiuaUZtpSynmrgIqSyujX3u8RSkqgDcjp9KfIzz7reUw==
X-Received: by 2002:adf:f34b:0:b0:374:bd93:9bd4 with SMTP id ffacd0b85a97d-37cfba12317mr1956137f8f.56.1727881057423;
        Wed, 02 Oct 2024 07:57:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742a23sm14110039f8f.105.2024.10.02.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:57:36 -0700 (PDT)
Date: Wed, 2 Oct 2024 17:57:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] perf: Fix event leak upon exec and file release
Message-ID: <2391f501-6d4d-44f8-ae81-c9bbef9a35ee@stanley.mountain>
References: <5cc313bc-c44d-4f6c-80ee-5a9fe9356f43@stanley.mountain>
 <ZtYyXG4fYbUdoBpk@pavilion.home>
 <20240930090439.3IgzQVzB@linutronix.de>
 <Zv1P7UzPWvFjOupc@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv1P7UzPWvFjOupc@localhost.localdomain>

On Wed, Oct 02, 2024 at 03:51:41PM +0200, Frederic Weisbecker wrote:
> So this should be fine (famous last words). There is a might_sleep() call in
> irq_work_sync() that should tell us about it.

Thanks for looking at this, Frederic.

I don't know that the might_sleep() helps us very much...  In my experience very
few people know about or enable CONFIG_DEBUG_ATOMIC_SLEEP.  It used to be much
more common to enable this back in the day.  Twenty years ago Linux kernels
would deadlock more often than they do now.  Lockdep and static checkers have
helped a lot.  People back then only had one processor so sleeping in atomic
would lead lead to deadlocks more often than it does now where the kernel can
reschedule the sleeping task on a different CPU.

With the realtime kernel, I kind of expect sleeping in atomic to become a common
bug for a while so probably people should start enabling it again.

regards,
dan carpenter
