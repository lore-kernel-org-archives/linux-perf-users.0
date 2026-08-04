Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363993F3293;
	Tue,  4 Aug 2026 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886966; cv=none; b=ZfMPpUKJnb5d3YdLE5wnYqLu3ueQ9ZAHF1xKrxv3XpSrJI96hptIYGnw2fRo1Bubb8hOP8KrbckR8v/0aWT0hcNdsICqBbqxSKO/K1G+zHmBfukq3lhvl+km+xCFCr4ibVOgp+dAk7df+83bTNgPyvmGBnutgtMdUNxuRXFYtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886966; c=relaxed/simple;
	bh=Zo63MpIvoig8IPDGYgdv933Q/brZvW0u6cG9SIBFN/A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lPWW9Y2LpjCYiSJmlqBzdjRc2F5ibsi2qoyNQs92NBOUF3O7IzeE34WfwLd1r6fSKJ4+8pkkmyjaBHmIGjpVzVOktaDSevEet2l0RY0MtDnPigdm3hSG5XZxd/zEWSmN/kBrUToXZPmUx8wlCR/T7xfxmNs4IjEAh3aDjqNceik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuFb2EhU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuFb2EhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3871F000E9;
	Tue,  4 Aug 2026 23:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785886964;
	bh=u5BnPeKvczl/zISKgX37K17ckkiwNLgaO+M8ruB7c7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MuFb2EhUMGKv9T3C+Jhu0VcsE44lgi3XhzC5eAfYnv/Cs3K1trwEXDT2bK1YWU4MX
	 dsr97o7JyThLFSC3zRJYlH7B2vx5Hb7OUO324gfctsQLYEKjxKxc060D0vuSS5ZpUV
	 KQezz+f10Cz5mMaUdfPIvQYWIHwqJwwxgz2sXdkcZMTF1vwDXfFeN2NdtY4R3bpRyk
	 sU00diBykYGnZDDIQmBdXQ7KNG6v+U2Z9OGHmDhxSjOKp12rJEceytJ6CkFAdCGpgH
	 1NuP86rxRkGikyyLRNdxirdaKvEfl6dMXt3+Zd6bZ4qwP5wVJAX+oOY+LekIrY/dGf
	 VOfnRTDmDZSQw==
Date: Tue, 4 Aug 2026 17:42:43 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
cc: Atish Patra <atish.patra@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 02/22] RISC-V: Add Sxcsrind ISA extension CSR
 definitions
In-Reply-To: <3d1f698c-6b76-5252-4e8f-b61671e309c7@kernel.org>
Message-ID: <a890951f-e3e7-6d72-9e83-e4818cab552c@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-2-7909f863a645@meta.com> <3d1f698c-6b76-5252-4e8f-b61671e309c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Aug 2026, Paul Walmsley wrote:

> Thanks.  It's easier for folks to grep and cross-reference if the official 
> RISC-V extension names are used whenever possible, rather than something 
> like Sxcsrind.  Queued the following patch for v7.3.

...

> 
> RISC-V: Add Smcsrind and Sscrind ISA extension CSR definitions
> 
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds definitions of new CSRs and bits defined in the Smcsrind and
> Sscrinq ISA extensions.

This was a slightly earlier version of the patch here; what was actually 
queued reads:

> RISC-V: Add Smcsrind and Sscsrind ISA extension CSR definitions
> 
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds definitions of new CSRs and bits defined in the Smcsrind and
> Sscsrind ISA extensions.


- Paul
