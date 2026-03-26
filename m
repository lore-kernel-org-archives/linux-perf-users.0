Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63832372B2C;
	Thu, 26 Mar 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522913; cv=none; b=B6gOr0MOLAVQ2gP0bPqyJZZFwsOuFCkTuNAwBGFB60t08l1bdfSImiybwzn3WaI9B7IpkTSWidaJIAEjIfw9LSh9CgnGVRvnnLHPz0VlCnn9ko9Zd4pvytxOKIIrsdNS81EQDQ1ZynRGMmuwjreGfE+JAu6AzcHw1hRS1DRZGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522913; c=relaxed/simple;
	bh=cBYIciqF4XISq/WTZKspw6Udl0Wcav49Oqx5YmJNA9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EklqkCXvLO9pbs1woHU8uzTs3xbV46Wyd+pUv8h49uqUTADe6OEmn0zaf38FTfR7sk9nQB7By+Z8yrreq47NlY+w3DcKXQvWWnQzGPIHLmvmb6jEwzOtZHcJs3EYbTAU/T7HiZlcbOWOoXIEgNHhS6tA4QSdWIz47LKudb6yESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXBsn1Hc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXBsn1Hc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA73CC116C6;
	Thu, 26 Mar 2026 11:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774522913;
	bh=cBYIciqF4XISq/WTZKspw6Udl0Wcav49Oqx5YmJNA9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXBsn1Hc4q8uWGw+iRgZ7S//+jHoBIhR7v9OotYZboduheWkRk4OZnOlVK1CEplGk
	 UVf37Ycvmr6g+6vL8o+qK3TZ3XzbvJqb6rUj4EnhltaZec+MVlqFzC//tajJD2D110
	 RUkqHnWNxgwxrsR+xpBZfVozTDWClCeDXsSicwPa2pqZ/wBQpqHgsHxZqJ+eho91wG
	 IJaVeuNmreyOIImMBQR98Nxrb7lAYWpUmPM/KtCnSyO6YbYNuZyuUIXktTYyQAb81Q
	 FhGzjlGjO2xWPwVqnH4ju5WDfAcEcO3FLBJ3x7Gt66A2HC58t+0/MyBpDofAm8/tRQ
	 9m3aTgJsk98RQ==
Date: Thu, 26 Mar 2026 11:01:46 +0000
From: Will Deacon <will@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com,
	anshuman.khandual@arm.com
Subject: Re: [PATCH v2 0/4] arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Message-ID: <acUSGgfXfX_GUEh0@willie-the-truck>
References: <20260318171706.2840512-1-puranjay@kernel.org>
 <CANk7y0jnY-V7Hv912gwc45jSx2UqLw5PBcdOdoFfS175bNuDmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0jnY-V7Hv912gwc45jSx2UqLw5PBcdOdoFfS175bNuDmg@mail.gmail.com>

On Thu, Mar 26, 2026 at 08:57:14AM +0000, Puranjay Mohan wrote:
> Hi Catalin, Mark, and Will,
> 
> Would you mind taking a look at this patchset when you have a chance?

Adding Rob and Anshuman, as they wrote the perf driver for BRBE and are
the best people to review this stuff.

Will
