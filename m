Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EF28314C;
	Wed,  5 Aug 2026 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896083; cv=none; b=O5ypUGQTBfZXyEkKOFu8FnvwSaEetL+DEZgRwru+iY1WdRsVinvsMPQc2ykyUEfezSGv2g1bBTNmqT/K9lPgEOy4SaYI9Apwjz14zTBaXjTvWtjQ3RFF1K8UYqPXKY9d9RsQNgcfpAYV3VUTwKMrXPQvW6IP9e4g+GKaNpbe63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896083; c=relaxed/simple;
	bh=44BPNVLKeZCOZDn4P9L3CZ9nbAK5/b26NaO7gK82kE4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UCpPv7ENJ62NNEiEyFOXUTyXvBgtPW9M387zf+m3IATqme5tnBdsa98NaKXCUeaEowf7xoqwoZMRCKH8p2FrP+eUXa5QX7YmRQmxoHH+qkCEiPppnYWi8HKDv0j4PO2fL6ooC0RqgoXrO0S8iiUq+CNuzn6gEpMTC1ENK+J06oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkCDbivQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkCDbivQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A3C1F000E9;
	Wed,  5 Aug 2026 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896082;
	bh=+4me6HB/Ie1xpzJpoqjIi4/tsiZ2xqlMSo5EH8f0pa4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=bkCDbivQZAn4erV38EslX808WXOkN+F6hiOGZwrcTOSZ3FGEkM8VxlKzLjwwnRTSn
	 IOKeaMYBl8jiJss7NrJcnTsmgJZvtk+L/xPUNND5N3k3Mvg+LarvaJMniM4UFqxP5C
	 4PDYp9TcasmF1uXzGDDslkmWwo9NM+IBE2ZaBRdsRdA1gjqORMNFWb8Lk0uKgZ6xdw
	 YNS39TRhvb+la1WaOmNtHe340JzwB79vI50FBGsefvguy6EPdCa+W8q+apNpyazl5A
	 1o+gyKrEh8h7H+BDWgDjUO91vfVDVbnKdJjWdHxTKQ0I2t6/DHKdNRpdJVkIyzbAj7
	 YfFPdgMStoSGw==
Date: Tue, 4 Aug 2026 20:14:40 -0600 (MDT)
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
Subject: Re: [PATCH v8 00/22] Add Counter delegation ISA extension support
In-Reply-To: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
Message-ID: <09a2dde3-788b-555e-22ba-2f2582a89524@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Atish,

On Wed, 1 Jul 2026, Atish Patra wrote:

> This series adds the counter delegation extension support. It is based on
> very early PoC work done by Kevin Xue and mostly rewritten after that.
> The counter delegation ISA extension(Smcdeleg/Ssccfg) actually depends
> on multiple ISA extensions.

So as you've probably seen, I've started adding some of the prerequisite 
ISA support patches from your series to the RISC-V for-next branch.  
Looks like you're planning to repost the series at least one more time; 
you can either include those patches again, or base it on RISC-V for-next 
as you wish, but if you include those patches again, please note in your 
cover letter if you've changed anything.


thanks,

- Paul
