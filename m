Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFF3090F5;
	Sat, 13 Jun 2026 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375400; cv=none; b=ahi6LDxfgRPiKLRqCNFS5NqGO+/XckWWNUvl+brDK7Kj1YQaSSQxs4qtXIedhgzjXTibQg0DdK0Dk4R4slKEs7FyZUZwVKpn5TnptevyCOCnmd3ZY/wCPiGTUbTnNvV+szI5geWmsQwjVVKfXu88Y1C8lvws2SiA29ss71cBjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375400; c=relaxed/simple;
	bh=AN0ZpA9iHlqEDGOP2hVl8hG9GkDDp1wZTgjgrMNqxxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwR86+5z72cQCWedeYual/Wb8lTR8CKXdTvhjm90S9RfV6QG91KnDfCDprzys8w4tdT2bqY/zPjJRnA5EzDAdbw4FFtzIPpAC2kNem/y7eemuwTbSKvdlXkFaBqNys0hkuCd4SiA+l7geMyjHAAmv4XeE9xBMSJ2o5tn4RU2kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxYmAgzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxYmAgzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD001F000E9;
	Sat, 13 Jun 2026 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781375399;
	bh=33Syhvsm5sZiiNLVJUS2RBNw63oGJetk1j5qZL/2MiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SxYmAgzIh9DscHcdrhGxGBo/5V60YWApEi+m/R6/XKqhQpada+bVWx36Cwy/hJ8zT
	 /t/sQdvOfQgAimhpLXCT+QrCsS+eieMQFvUXLEb/FqV8NpomYYexoW3aY0dwFRu87N
	 +LvVH1DXQB1WndVI5u9koNvgX/rYNNf8BiAQ3gTTEhpW1MEYktH1hiXyjBkLhhW8bT
	 kOk1G4c2yLfO7kftEP+lZJYJ0vUkNW24mNlj6z31pHfvVFYAc5a4l8lQwV/ycLXEEp
	 eE0qhrLquf8LArl+ukokd52mSH2yeQ7mYmLvNPRH6el5EV5EO54gpNZAk0RGfFqqwa
	 wr0vLKKk2rZEg==
Date: Sat, 13 Jun 2026 20:29:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, 
	will@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: perf: marvell: add CN20K TAD PMU
 support
Message-ID: <20260613-crystal-chihuahua-of-opportunity-deed7e@quoll>
References: <20260612095746.19679-1-gakula@marvell.com>
 <20260612095746.19679-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612095746.19679-4-gakula@marvell.com>

On Fri, Jun 12, 2026 at 03:27:46PM +0530, Geetha sowjanya wrote:
> Marvell CN20K SoCs integrate a Performance Monitoring Unit (PMU)
> associated with the LLC Tag-and-Data (TAD) blocks. The PMU provides
> hardware counters to monitor cache traffic and performance events
> via a dedicated MMIO region.
> 
> The CN20K LLC-TAD PMU is largely similar to CN10K, but differs in the
> layout of PFC/PRF register offsets relative to each TAD base. These
> offsets are derived from the compatible string in the driver and are
> not described through Devicetree properties.
> 
> Because of this, using "marvell,cn10k-tad-pmu" as a fallback for CN20K
> would result in incorrect register programming. Therefore, add a
> separate compatible string:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

