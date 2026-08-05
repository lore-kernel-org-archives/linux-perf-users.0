Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75A1E9B3D;
	Wed,  5 Aug 2026 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890915; cv=none; b=hExp0dcEGjQXSvM8Vv1q1ujLY24IQSifwF1MneSYfO1HSxGsLTWRiuS9Tm8PN9IB2sOt3XECCSbrW6puRlqWLlYsMdmQheDK1D4BioY8ZlAON4sZkrnR8h7xpF5YZ4u1G8WDYLlp4lO6z8GCGZywBgsG5o8jdywCYBzgJc87QHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890915; c=relaxed/simple;
	bh=AIEHp1aXO3ao/rdJK2FmTBERZ2shF4JhFbge8bhMiwY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MwH5L6h/AB8jepbY2q0aZuV3v5IIAsyyQ7886V/rB8wuGbhk5bZNf2rH+IQLGfdwXoOGg4LM3arjleVcohW+sgD/5DvQ+jUB7fDgRBpUwjli+bwilQjJslkMlr/QedZKU3rOpyVXwxv5m8VEcj1KdsIXFkgO5h5lQnXD1S7X8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVTfEnvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVTfEnvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F681F00A3A;
	Wed,  5 Aug 2026 00:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890914;
	bh=w9bnOh6M3Bsb/zcqLOAeb7ppFeVGT3UsgRFnzDOfzZc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oVTfEnvwkErL5oBz3FZvF2Z41vznZz+0orAyMZGepRhjG8wcuzjvsWQnkFaFeaNt4
	 pRf4y4IQld7se5c4omTHlD0RRtGtzDQDu843g+xqembIm5r386ocpmLYshlXHMEplI
	 jFa6f+hHDwkUr40qMRe71l7UCoBsakZkXPPzU4CPpnrPRv4rFah1ApAAgoDjTS3E+U
	 fhRrreSgmbWVQcOnrShe9Ikz8a5D+BQrIQK+vsJ9R9+pGOvWzNa6EdiUhvCLCyobTF
	 cY/XHZviG4b4r+wdQ9JxurzqF/6pDuM2zwGBeeg7l1Qzjviih/+328KD+Zjn94ApJq
	 MzYt7kSKUD4LQ==
Date: Tue, 4 Aug 2026 18:48:31 -0600 (MDT)
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
Subject: Re: [PATCH v8 10/22] dt-bindings: riscv: add Counter delegation ISA
 extensions description
In-Reply-To: <20260701-counter_delegation-v8-10-7909f863a645@meta.com>
Message-ID: <b5e736ec-1a61-95a0-970f-e9f4eb6b62a8@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-10-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> Add description for the Smcdeleg/Ssccfg extension.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks, queued for v7.3.


- Paul
