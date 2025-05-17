Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD0B665;
	Sat, 17 May 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747486953; cv=none; b=ZH7KHq4lQLeelHY2+rE63tdDrqLZiLAJU1awzv55ZqatRObi7gOm7FoDTn7rg9Z1wGK5iXUA+1boGI22VBQJcHYHIp6Caf1jAM5v0xDsuPzsrpYBJKOFGioSqqi+ssHqpMrIqu61l8wZ61CjR86VdngtJT/2kH111OObr3ZGhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747486953; c=relaxed/simple;
	bh=2AaCjBtkXEOIDgFVhyZEuiN1dgO8b8PReIiLMAVQqJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OglsvY92jNVE18OdaiMIJCOt7W5VD7C8iWhKrUu5uEPRKii11Xrv6yzijxaI9dQQpNDG5GgNY1fK/kqr6zduI95hqAP/kPN++Cf3ztOpJgXETc0dORvueYMKX36sdgTovv/TNTiUauZedyewDosp7QIpAtqfbT0G0hGj5EfJwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9XuBHin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9XuBHin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD8EC4CEE3;
	Sat, 17 May 2025 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747486950;
	bh=2AaCjBtkXEOIDgFVhyZEuiN1dgO8b8PReIiLMAVQqJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9XuBHint1ni3bXimqNa5kbtgiIr2PneAQsjzO6427yadhKDdqQQH3MkI33ztVsD7
	 krNeVp7mZeLy/qAURUQaaEwG/XhApVUdhtUimc8ca4fbD6Mhbcp328RFq6E1PKI1o9
	 j0RLTJgMoPLmJEjPAOrg/yp1CfdXdDNPNtr2FqpW7sbMSXEJPeBjVbg9VgoiZVAKCH
	 kRsKL/mm45hoPHLSI+HKPK41lYanmi/3pLFufdTMhYE9gCV9HFnfam0qIvU9mylV2U
	 N0YGZF8EOIryoEsgmV24r8r6zbrCO5f1G3hCeidNpwB/1B3xPpsE6o2IGHla2u5CyA
	 mqbPPbGaxRkCQ==
Date: Sat, 17 May 2025 15:02:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86/amd/core: Fix Family 17h+
 instruction cache events
Message-ID: <aCiI4lcWIe6GYW4_@gmail.com>
References: <174740303900.406.5499797802401271693.tip-bot2@tip-bot2>
 <c409c331-da7d-7424-e0db-a4c61ea423ca@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c409c331-da7d-7424-e0db-a4c61ea423ca@maine.edu>


* Vince Weaver <vincent.weaver@maine.edu> wrote:

> On Fri, 16 May 2025, tip-bot2 for Sandipan Das wrote:
> 
> > The following commit has been merged into the perf/urgent branch of tip:
> > 
> 
> > perf/x86/amd/core: Fix Family 17h+ instruction cache events
> > 
> > PMCx080 and PMCx081 report incorrect IC accesses and misses respectively
> > for all Family 17h and later processors. PMCx060 unit mask 0x10 replaces
> > PMCx081 for counting IC misses but there is no suitable replacement for
> > counting IC accesses.
> 
> can you link to the errata document that describes this problem as well as 
> maybe give a rundown of how and why this breaks?

I've delayed this patch until these details are cleared up.

Thanks,

	Ingo
