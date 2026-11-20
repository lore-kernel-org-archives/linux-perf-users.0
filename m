Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179999;
	b=B5brIC/zLbKoBUQndbtQovzcYudqTZTDKVsnfNoX9DNIuaXKZUkh9HFJGpdFDT0CF2gU
	 7D3l9w2ApLib6WjpURcR26M/crY98+UkwMzGfIhyHpA3t0MaBTNqaH/uqtifZmMjqYXZQ
	 BGxW5zMVpTA+39o7uj73cwBal+Kmc4PXGJ+0DwZuAufong1/Q5284BjIm2+Yg5i5xiOGl
	 o6VLF74reCv4LKaH8/h5OfazHJ9Iz7zJWBRONBL4v6mhR7jJ60eV6R++uVqWXBlC6ISrz
	 aRxNqQsoc5w7SpNPk7OuOJ1ZKmUN5shlKF7agBxyti1PJ97i59dlQd5ctalGc6Y53PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aN9l8CDwOvjtRjMobYbC9T4AAnLVgaW+5jZeY6o9Xhs=;
	b=UMG6nJ4y7A+i9hwVxyZ3/gbQdpuYQpM7V94f6Hzhm0+0M2IzdwBCP1TFqgZmLH/mXUAd
	 4kuNZgqtbh0WYu056zat5dX+etNHHN86vAhUchW1Te1UlAg9v3R3MMJUAP03RwiOXezzz
	 O1yIsOzLTu14YIaIQ7CAHjdXR+Q93Mty02vpYVpEIq/yXCQEFj+iW/p+IFnIt+W/5URfO
	 ks3W3GEUO+jWK2EtXcDCRJFU3NMZXLE2XA4ZoTaXg25Orsbi+ctgJ3aB8vsWKq+cD7inn
	 B3LZroG/txxVRHi0Jb2wZUFIzosdXSvpNtvL5kDQQ0FQxtLzyIKCF4J7ansXZ3XrKhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvTC3UWm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD12606A326
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 13:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD12606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvTC3UWm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so7775655e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795179997; x=1795784797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aN9l8CDwOvjtRjMobYbC9T4AAnLVgaW+5jZeY6o9Xhs=;
        b=tvTC3UWmisWdUSymmpATqFWpFz0OJyrOUWNGm6TBa1nwW+7YrCpulfv3UsMXJUSMJR
         FeB7jMc6J+kTNoXVesQNAldCxnQi8kdK+ZaN5Mx5QWOevM9xrRb4hqkD/xjgcCCQoPvy
         OQby+O/fPsqDUrWqGaLaD1pwZi2J+tzxhFFhn6F1FHpJansAs9Ltyg9htJqpl1gpkoS3
         D+7f8lP4Kv3T4bkgIrdlvAsEXbYF0L0BBktabQ/c7R5Etqv5lPQ8bznCTbM05xww9bRU
         +9rjZPf4Nyffh9azDCNgN8C9/4ZVWysYDqolHHq7nOlV35Bq5qm/k3C91Gxo8pxoi87E
         tw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795179997; x=1795784797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aN9l8CDwOvjtRjMobYbC9T4AAnLVgaW+5jZeY6o9Xhs=;
        b=eZHdV0l+KHPTTBcEtF3nkoygYbjgXs0iOGDI4lpCaFD012+u/OlKTUaRCE8xiPmDZf
         QGtdxlz3FfXQ8mWwGcetbPZZeVVeFmvMsYXHpZ9kAE/uF5gstgveKFcDoHCN03XZbFuw
         xYQw9cL4hXDjiauEYQyNrf4KfF6GJDy9NqZBdKd9OK1LjtizP7NcC6YuvnwquDhailfJ
         X4onQ25DQA848yQdI0rCz+Hw0X7vuFIUK++Rd0TrKZbB8idkNdBSR93/lqc6/dRXeZtp
         WTxc7FyxGDmTJKd6bODWSOGK7fuAugVmHnowW52qzRsjDBe4jfvKQ65k+tbxiKUQTywG
         uvEA==
X-Forwarded-Encrypted: i=1; AL+hErE54qgAGdH8ka2foRasuZwDuL/13bRZ110gzIidSgGSwK9A3EcTQEwdzLojcE79SHXTRuh77lELj/QZTNKg9bO1@vger.kernel.org
X-Gm-Message-State: APuU4Z8qzCjYznQ91JH8YPkDdxreJatFQtPY7gpfnil/spQq1OKhKyaA
	XC3CeVZbsGRTmMNC/oLg4ElQAdNI/xo6zZQ2TEOPrrVWsrrOxtELmqUW
X-Gm-Gg: AYBFou3EjFALetibcouePEOtjCWHnxndFgt3QNOLhxrJzrV2aiuf+6VaJjZ2ef+56ka
	YuYRBpLESNkoldmooxgpyavbOSkVyzQ2RIpSz/HpjVY3acEHSwDY0PiQ+1UZ8MnIMgAMfJtpsI0
	vlBIEqVe1IYJx6bYoiwOnsFn9tVc79foaIjo/BpxsnAoazDinc77DpyA0CQiVABDdibreQl8neX
	OnhMT8dToBacWPBa+TVxo5aMtj4Ka77XHyMxsQfOvGcPMEfn6rGQbOWnEysBCHmfpIlKXbpFgne
	+STukBOwFi/NnMGB9IskEuJopbdDSuAZ9Scik9ma8Gj8GlJYBa4RD7oXinrmeaxlAUT+6RHzuyP
	6fm4bleh2aVNcpTRwc0JmjnFSaz6Hj0JiYg+GiULzyTnXtAa5vX72KCwi5Jju0XaFpB6ukIk7WR
	DjCxgRGexWBUx7w/9ZlSsA9vlW09dy5Gq0ML3Ds981gNGF1Yy1d15oVMjXOjtfLGmsYbJ0DbzeC
	iWTc7aSWijq9pWm0icnCPM4fZzEdGN8JQTtwKhDIzLQn1wt02qlhyG8ikg1YdeNQY23epeAS7N1
	s5cVFe1o0CfCcwIXlzLlXhnAd9I32k65zM5HtgTgceGajeXOk8cGauJHglhRvbCGOo33OG+vQjF
	7
X-Received: by 2002:a05:600c:4e0e:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4bb88938dc9mr73795085e9.31.1795179996992;
        Fri, 20 Nov 2026 05:06:36 -0800 (PST)
Received: from ubuntu-nuremberg ([2a01:4f8:1c1b:70eb::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm133317135e9.11.2026.11.20.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:06:36 -0800 (PST)
From: Reza Ghanbari <ghanbari.reza94@gmail.com>
To: Keenan Dong <keenanat2000@gmail.com>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	andrii@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ming.jvle@gmail.com
Subject: Re: [PATCH] uprobes: clear extra_consumers before pooling return instances
Date: Fri, 20 Nov 2026 13:06:19 +0000
Message-ID: <20261120130619.738336-1-ghanbari.reza94@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408100247.2065245-1-keenanat2000@gmail.com>
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Keenan, all,

I ran into this crash on my own and can confirm your patch fixes it, so
here is a Tested-by.

I was seeing it on an unpatched 6.18.63 (kernel.org source, built with a
Debian 13 config). With libfakechroot in /etc/ld.so.preload and a couple
of "setarch -R ls" loops running, I attach entry and return uprobes with
bpftrace to libfakechroot and to the same functions in libc, detaching
and reattaching every few seconds. The kernel oopses in handler_chain()
under krealloc() within a minute or so, which is the extra_consumers
path your patch is about. I haven't pinned down exactly which probes end
up sharing an address in this setup.

With only your patch on top of 6.18.63, the same probes ran 20
attach/detach cycles with no oops, and a fork-heavy variant ran 40 more,
also clean. 6.12.117 doesn't crash, which fits the Fixes: tag.

One more thing: Keke Ming's v2 for dup_return_instance() has a hunk that
clears extra_consumers when cons_cnt <= 1. With only your patch applied
the fork-heavy runs were clean, so I haven't seen a need for that hunk
for this crash.

I can send the reproducer and a full splat if that would help.

Tested-by: Reza Ghanbari <ghanbari.reza94@gmail.com>

Thanks,
Reza
