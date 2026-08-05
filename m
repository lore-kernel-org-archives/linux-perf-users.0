Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F522110E;
	Wed,  5 Aug 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890603; cv=none; b=JIx36c8cwVp8tOW4JrvUR4VvNrgqgSTBvM4bghlYs5M63HbT0BNxG+qfnmOgrsa7noMpsdUkKmjjCdyLr0cw3Dm8W6noW5PxNShyhMBFV0XJRdzdXTYQa0Id16Ilggcs4dhFrbyDwXFwAfmD2cgNRFiLTbch2aKVZQTr1g6W+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890603; c=relaxed/simple;
	bh=afdSXEK2unHzqpYF5oPZcayDvSwH2tzQMjO1jk4HONM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Iu+d75U1SMkSD18y2gjLSCso1tOzmCl2Bm459fJhHJOjq5U7JIwiSP7G9fVRfdrz4Dg04euet/76PQOoccY9IlXeBK+3YAbX5MGAJGdSR/ABuljLcYVYbxdwyAE8xydVLpA2EsDxbL72bzEQ00i/Skznay3JmwjUfi3jVtmfTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZu88WOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZu88WOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325731F000E9;
	Wed,  5 Aug 2026 00:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890601;
	bh=uj8TaDSojykJzia/9fgCjXBaQcA4KgvarKyhlliDZWk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=eZu88WOuoLZh8JmFXqwBHAwW3qol0PQnQh3Y4uDRoggiJjBExINnfXui6o2OYK2sJ
	 uEnhUKrz5zEbdCbPZgiMCCTypOaUS33nOuJFxw4+nEgraPYhLgcmHnXxvc5+4vbwtg
	 DG89qWxeat3UDSiKYOd0jyfgp0PjWNTe7aNLFvXO1/xPz8M4C55ATB/Cne1O7G8Lka
	 SiYiNjfpNB3GIDKu4JJz6CAgjFBNAcJOMhpPhPM3bHyEmMVKl9JBL54HHZ6QHqrFP3
	 Vi6vn49P2EG9dkw+wmPNpzqG3ZxPvsK458AEZan6VEtNv/6ozkhZ605KDrjMM3ITTX
	 83wF8i/uPKp8w==
Date: Tue, 4 Aug 2026 18:43:17 -0600 (MDT)
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
Subject: Re: [PATCH v8 08/22] RISC-V: Add Sscfg extension CSR definition
In-Reply-To: <20260701-counter_delegation-v8-8-7909f863a645@meta.com>
Message-ID: <13bd0f22-cc17-ea60-5081-89d42e80dd5f@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-8-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-941318970-1785890601=:1383527"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-941318970-1785890601=:1383527
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds the scountinhibit CSR definition and S-mode accessible hpmevent
> bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
> counters directly from S-mode without invoking SBI calls to M-mode. It is
> also used to figure out the counters delegated to S-mode by the M-mode as
> well.
> 
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks, queued for v7.3 with the typo fixed in the subject line.


- Paul
--8323329-941318970-1785890601=:1383527--
