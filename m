Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF6150997;
	Fri, 21 Nov 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715756; cv=none; b=BLQKygWjcTqRFnRIfj1IJrHUpHbS2mZzC1e9Wrv2xr+dLyLoFz7CqaF+KQL3B1Gjq53Ssmab3s2zu5Ibi2Ao/mP+eBTDXR3AHJezsPpxLJBHDdGtUBzWhuPR30oiA3RMJ6h1/5SlzFBV2S/6380CQMKt05FNSq+LguHdJCwtOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715756; c=relaxed/simple;
	bh=IXP4XPZRsObPrl0yKG5Kw2GKPTvWVm8sTwBxaHRfRlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rorcPv9CelubnvHuPvFn1I79ZnemjhHWT9SWZsxeM+Xtdx/srdiiL9/xAfZUPR8SfBLyinAk4wvNYLt9wm5mFubOBv/6CXUXTPpttn9Yq/JSSYystOhsSs0z40vrpXoc0ryFa8VzIKXG2XLNWcgSpVKR/tKOm5KGrTqJe1BpCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSs9yj0D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSs9yj0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB723C4CEF1;
	Fri, 21 Nov 2025 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763715756;
	bh=IXP4XPZRsObPrl0yKG5Kw2GKPTvWVm8sTwBxaHRfRlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSs9yj0DWwmoHYi4NgWzdQZOqTmwZGy3JFvwOv627sWRLK71siMd+1ZbpdKK7Avll
	 Ui/fe9CHM/LrbtYrQxPcFdgz1vuEkmoSbbEupw20zwdbmWmoLFubQks1U8SnGyBegX
	 Lx9mGAl29lcUmLoXVZEBsPtw+b7++agvO8ZwtCYupXIIKCttNUvBYfoZZUycQ6vNrB
	 blSCqlcSfFbhrA2310cQeSdz3zzLSsw9xYVm7cqrKR+j+cycu8aulU0hpF/hRJWpGj
	 JBrDEC0Dxm9qjxoWowHRE2CBZv/LnaU1wJesra9ewKk/qRWF5/Z2YmiFpkCuV/7QTU
	 k6Sy7YZHjGmCg==
Date: Fri, 21 Nov 2025 10:02:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: cp0613@linux.alibaba.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, guoren@kernel.org, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf vendor events riscv: Add XuanTie C930 metrics
Message-ID: <20251121-bullmastiff-of-spectacular-inquire-2988b9@kuoka>
References: <20251121063439.2545-1-cp0613@linux.alibaba.com>
 <20251121063439.2545-5-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121063439.2545-5-cp0613@linux.alibaba.com>

On Fri, Nov 21, 2025 at 02:34:39PM +0800, cp0613@linux.alibaba.com wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
> 
> This patch adds XuanTie C930 metrics, including topdown and some

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94

Best regards,
Krzysztof

