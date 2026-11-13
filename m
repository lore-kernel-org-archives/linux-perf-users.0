Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553629;
	b=mF5PI8kiSuRmam8LyOg+bv6kCpRngCzcHs0XpIx47GCrLaM0oGILVPbHZHkZMpuWs9PR
	 9xdiFO2+TkerpVLqjz/C/iX2iaueUDa8BpytUbS0Q7KWE2yo9fEGNDQ5oKj6EPPlpLano
	 YeT6ujsdWC/4Gn/CmfFtzuj25xRRf87UGTYG64IYzIgN4pl2nxCkMlivoZsJ/W7sNLQ5M
	 +5kWWJEekGR3JG4ZgwfmvHQjGjUweP5e4zCLC6zrMKV0WSiUFMz0iI62DEAUqZ8qcTjNc
	 8RBxJMSduWf/X2xVZDb2ZjgaWXdzIQl3c6BZNRCXom9VsaNBlj333TVGA+rJADhkfGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=KtWOCYyh2TPXWP1dO10x3eEpnjDATMuftJMR0lhwHS8=;
	b=sj0/OlOwdZLYgOw9ybqP8xDGNuUnRjFLP+Aaj3B5JZu5tS/kcbAaBugXcrJbC1/2mfIA
	 TyiStpUNwkN1RdDqc/q7bHIbuFdluK6RVqDpvTINXwJWDndoraBxLO807UjxakJTXFMzy
	 MsvbRg2TnufPRyGvxy6NYAUf5UMj6dD8rVycIKO8fpkkqQU1qP034RdUJTEFAlFAA3CN8
	 29xwCghXhX04Idybc/EAmNtuJ+DG+CdodS5n6+CUVv4ptc/fvu88vp8G6QfImbhVjetNv
	 ucot/jyvEOnEDhPFjZIYd8KP5cvbpc/+16GSBJRPUHbqSa/0BlPRiusrGVC1TUKLZLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abzYkAEw;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27308606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 07:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27308606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abzYkAEw
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2af4c8d00so698607c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794553628; x=1795158428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KtWOCYyh2TPXWP1dO10x3eEpnjDATMuftJMR0lhwHS8=;
        b=abzYkAEwvgC6ZXtXNzr7i4fL+5Gb4CcnViAmMS+Atb81ri100k2CbkkH0+wtgWfyqm
         75useU67XgwousOBpvs5ati1yxHMgI9MaTqprAN7+LJvBeS/CKTMizvtTJLhd/LB5jfr
         jzV6OTi3HH1aGiAjCITTbHP/S1eGPL9+4hl72Buh2vC0xXul5uZ1F1uIeyq/UbZ7mgv1
         bkcZ4pnIAL9U/7tVWAhpr900/G/XrVspRlb00zaSSaEvmJ1Trjtv/mmDvbWZFJWtrOsp
         ESAzJBmY4Rtz+rTP/rJWamnXxl3jOJlAkQ+MDVIraw4ibZdFPqAUIVZ9RKMp+JEAkJj6
         O5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794553628; x=1795158428;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KtWOCYyh2TPXWP1dO10x3eEpnjDATMuftJMR0lhwHS8=;
        b=H5EfwLxBjpTIv2ZObPhYoCbT2VhMit/8+1UG8FVOMCFE1JVefE9WU7KTZoweVneMlJ
         KT/iuPYNBZnXbxAJ9gR7Q/K626WxwNVC+KveVJsO+qUN6QBkN45yL4zKdxaWYLheDaaF
         lnyjR81pf67g2UI1AmwvqiYlL5tAbFjMwvpaZXvSMDAC5ZfO7FpbEvfpcSQUK1o/iMMQ
         so/fg6ma+qCcy2LMqiQRlKUrVgpUHzRQwiqJnj+UEjeRDn+9pJKMEyENww5P5O0YJgzt
         DzSJ/liRlG9TxTL9BGRR3CxgGBTWLpzjZItDY7XBKaXzgH3a9pId4OULnT1c0BVCp2ms
         hjRA==
X-Gm-Message-State: APuU4Z8hWVDFGP/L8/eKAG4Uzi/aYjhhbCppdjAjrkxQDBLa1Bd9Ay63
	TJh0CyA7clPRbtwHnpCJ1IWfOOMSzDmbu41nDFxHkHISgQm2VWW0Nivz078SlQ==
X-Gm-Gg: AYBFou1fLr+qVPc4KhKtrTIsKzaMb6Qyv8+GHuO4qVox9BXoWBkrq/J9P9uROpqtgyQ
	6qEjuks/ny2BGJUdXc6xvz0e4Djm4Jwj8iONq31GEVNTs5ll7k3FOZBv0dTyppvuYRrBp9MEVS9
	ckL7X9824/D1eewSW0i/AiOGY7XOtdPV4c31oTkSxRGSxV7JGtrl6W8JD8w/8pOVZQRKNXPt6RO
	9UnuOeikpoLj4WWvrOGlDnoYALf7VBuoDxA0mC5Ury+C4GQ1645P4jflqMpxdvzy2pPWplYFShE
	7T44hknq9WMEE/RjiVp3QrDSq7/y66x2ttYSmkztmPHeFMoqRsbfiGlIeORtPW0w5bjFGunBxol
	M95AjRhTfKqM3tLBPR6HbTqRA8Jz0HtoTqATpJ2bKF9Ss1T4S/rfU+zV924tMUa+MkB6Hw1NeLx
	C+A+HLmqMf/E2PUCQeThEkO4+f1MGyJ6uVL4L1I5sYnep9RMH2kS3L/fqCr4dpR9pHTs8fK098b
	XUf/prs10ufbFDb6DmPKWJwAILREoDhg3nrqq5MrjtM7dY91RCcEsXzXjWIQ6ScxGZ0w9kpzmdl
	QWq14pIX0e1BF2Dw0iLjqI92XqI=
X-Received: by 2002:a05:7022:5f19:b0:1af:d88f:fc51 with SMTP id a92af1059eb24-1b50311d424mr1673381c88.30.1794553628027;
        Thu, 12 Nov 2026 23:07:08 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm4311416c88.13.2026.11.12.23.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:07:07 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH v3] perf stat: Start tool events when enable_on_exec is used
Date: Fri, 13 Nov 2026 07:07:05 +0000
Message-ID: <179455362572.754258.3537940037051974310@gmail.com>
In-Reply-To: <20261023101256.1752713-1-takano32@gmail.com>
References: <20261022024919.263876-1-takano32@gmail.com> <20261023085554.1694434-1-takano32@gmail.com> <20261023101256.1752713-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

A ping on this one: three weeks since v3, and the only reply is the
automated review.

Nothing has changed on my side, and v3 is still the version I would
stand behind.  Both rounds of that review are addressed in it: the tool
event is started through evsel__tool_pmu_enable() rather than
evsel__enable(), so the members of a mixed group are left to the kernel,
and an event that failed to open is skipped instead of being started and
then read through a NULL core.fd.

The limitation stands: this machine does not allow perf_event_open for
the events involved, so the wrong output was read from the code - a
zeroed duration_time turning CPUs_utilized into a division by zero - and
not produced here.  A reviewer with the hardware can see it in one run.

If it is not wanted, say so and I will drop it.  If it wants a different
shape - a selftest, a smaller change, a different call site - tell me
which and I will send a v4.

Written with Hermes Agent, an LLM assistant; the author reviewed it.

