Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00633AC00;
	Wed,  5 Aug 2026 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890791; cv=none; b=kgnOCHpX8cpbQU0jHFM9vSn3ra10VaTsj9DA26/r5C9B5LISl1q9g8PIlylkn28lLQLRxYRc1pN318+Xl9m+YE8F+tMBL7gw7NgeYkFLElcCwNdgWHNdauxQHN/wBdDNWgaP/hk5UEfQRadN2hXX8YRw5dmIsfucQXzEv+ppsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890791; c=relaxed/simple;
	bh=qUw+8EF3vvavNmrCySdiJlLcm3+x8Z54l34/xpIBasM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gxvpzd3sDrMlblM8AHsBmu5lyCfwVlE5/0Di6epDmonL5humeJjGtFgxvmEj8Ge9JK42ahM2A8/AzgDBUlDSALEnjOOs53GRVSIuTnWiS4gc1k/E4hXgdbkYZBYz8/iEs403Gu8gmSrg0QWmV4hCHkB0Vc+no8p/feD5bfDk9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSIrpGwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSIrpGwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A021F000E9;
	Wed,  5 Aug 2026 00:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890790;
	bh=Dlhi0OIvG0DzAmOHlpvJY0BTYkHJaLUzOYnoAusTIMY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=XSIrpGwDO6P/rsSqg7qHue/roYgmoqB2ziS6+kgRfFK73ME6zNKl6703uHTbtAG89
	 dgZxvL6X0JyqJRan0Y9QZbksFI7Q1bPSl+xkcDgm//bWeXHuJgfWpMHz4/Y3Qllhxg
	 Wg5wF0fSB1IJx/sPZnLSjpN0V6Yasbhq6izC+zG3Tk45IAFp1C62+qGErYaK/BecaA
	 2kF4UDWEcNT4EF9lElsQRtTOEgOXPrEsid3dW4ce3XCTl7Rt18/slMhZDZNZP1ic4e
	 DTWs9DjKES9Ibe6u+w9kHNOm5lB/G9tug9PiXVozdbiqKl0GiXwj/VgRZ7qiR1epwW
	 nLZmSXBPctXkw==
Date: Tue, 4 Aug 2026 18:46:29 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 09/22] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
In-Reply-To: <20260701-counter_delegation-v8-9-7909f863a645@meta.com>
Message-ID: <38d6a081-e05e-f5ea-6e71-540bd1c22761@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-9-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1958216248-1785890790=:1383527"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1958216248-1785890790=:1383527
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> Smcdeleg extension allows the M-mode to delegate selected counters
> to S-mode so that it can access those counters and correpsonding
> hpmevent CSRs without M-mode.
> 
> Ssccfg (‘Ss’ for Privileged architecture and Supervisor-level
> extension, ‘ccfg’ for Counter Configuration) provides access to
> delegated counters and new supervisor-level state.
> 
> This patch just enables these definitions and enable parsing.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks, queued for v7.3.


- Paul
--8323329-1958216248-1785890790=:1383527--
