Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A780306B3D;
	Sat,  8 Aug 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210609; cv=none; b=obgoeCMWvm6vujnORN6PMR0MBYIJGgcyaVIs2X+OlopFzAo6s60bPSEa6tEqV7QAK4BZxsM1leo+ZcqFQaX/eb72Z8Q0i8uZ32dxlJMRw3ZW2j8tjEJlNGi9yu6XgoqGs/4nWIRiIb5mD/C8emPC6OwTlsUcZe1j3eY/22QTuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210609; c=relaxed/simple;
	bh=RFo3lMG8/QSJ9WqujOxlPuQHha0Qv5xEWcoLIw69NWg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c6LwDsudDslWXDD4t4GpfnGVv8pKTsd+5BfejkQgykc+IsqFcqOaHmRizZLuLYIe3Fo3lja0HbVOtUUxt09vMBCjLtQcRR+tzRzFIpmSOpr9z1T5yqVAxJzwWcJjirta729OzmVjkL+v/CjrzXuCpiB3gt4+c2kKw6m+mzuciVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTO45Tr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTO45Tr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D1F1F000E9;
	Sat,  8 Aug 2026 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786210607;
	bh=3Rp3p9+KzYQ9Znhhoh1ycYs7eQjez3sPulHcLx1j/3c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NTO45Tr40cyUy5n+37USC3LS8AwFa0hTN2h+XTtPQkMsuhtKbfVEGYxPrhY4t2qIH
	 ZrY+kewpmQdkZMqnSyVZ8B4ppKebGfFgUacecJiTJxGPxLuosOIBI6DJVynR7aiCic
	 +iROFZhlPFW0rttORDANMlbMbaq4qhwXJ+VYsEEtcCZ/ezXHfceCCxn2p7M803K9iB
	 dNesTABHyw0mE1/Ody4EvWtOeTFYgjD0Fhnfz8U7A80RQc1cnOcsglMq4Xi3x8MbrV
	 pAfFFewa7/Wvtv5SgCCqpjcTDO29tNcDqFoESv3mHFdHGoe3H/faI/97LqM4+Pmr1m
	 h1RH7peTuBXsA==
Date: Sat, 8 Aug 2026 11:36:46 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Ian Rogers <irogers@google.com>, 
    Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
    linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
    Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 00/20] Add Counter delegation ISA extension support
In-Reply-To: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
Message-ID: <42cea3ec-5f9d-7f47-bb8c-ab2789246918@kernel.org>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Aug 2026, Atish Patra wrote:

> This series adds the counter delegation extension support. It is based on
> very early PoC work done by Kevin Xue and mostly rewritten after that.
> The counter delegation ISA extension(Smcdeleg/Ssccfg) actually depends
> on multiple ISA extensions.

I'll put the first ten patches in riscv/for-next, replacing the ones I 
queued up earlier.  Let's take a look at the remaining patches in the v7.4 
time period, due to the other recent updates.


thanks

- Paul
