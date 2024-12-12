Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60A2153D2;
	Thu, 12 Dec 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014175; cv=none; b=TxCvFEgHcweY9APjITMbDGEUzwE4ETlp7RBSB5qkzl+0fQK3VeYZZhzBSmv7UiEc2z04RD3/TLrJFgpXE3IGiD01efuWxMzdThVwP3AtYZfgIZRKJWKFbbWvGyqDISFyKRvUlt0OIO+HDioBmuJXp8HLOxnk1Hc1kEqi9PoEA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014175; c=relaxed/simple;
	bh=nUZxJTWypj8JfSnkBiydA2f4lpYBw/GKwXIKh2nFhe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e15CWcXd1PESVv90lk3Rk6xrdfdfpyA2RitR19y/Cpcih1FseDeFRLgbOOrVDNImkVPQDcCay9Yb2b/IsAtAsm5xqTIUjDcBHWCg/U7IWSAz1H7RXI3aT7ijsgeaCNQBlJvK2PWlsz5xmYAgWqAWnureaFsF7/YLDxACtVgKwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=kchngzSj; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="kchngzSj"
Received: from fpc (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4968640755ED;
	Thu, 12 Dec 2024 14:36:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4968640755ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1734014163;
	bh=p2WyKkU+cEtAYkFhULkAi799mTRf4lFMSMN41qLYyGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kchngzSj9SbvgCT4iMIeQ9QlDyd994/fiX4HyxQApzmO0GglbTbUVRfOZocLdLSm8
	 YBk5BFwPd7eupzbg7u8MdvBvXHYtCxQi3aEtVUtNdrcb6EvVA55u3BbpVhnAd5tX5I
	 U2XZ4Nha5iGAIvZz4IhqH1y5ZHLQ3CCjMCyA1Enk=
Date: Thu, 12 Dec 2024 17:35:59 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] perf/x86/uncore: avoid null-ptr-deref on error in
 pmu_alloc_topology
Message-ID: <20241212-b509bf429d38f4c579b5a2a2-pchelkin@ispras.ru>
References: <20240204134841.80003-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204134841.80003-1-pchelkin@ispras.ru>

On Sun, 04. Feb 16:48, Fedor Pchelkin wrote:
> If topology[die] array allocation fails then topology[die][idx] elements
> can't be accessed on error path.
> 
> Checking this on the error path probably looks more readable than
> decrementing the counter in the allocation loop.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 4d13be8ab5d4 ("perf/x86/intel/uncore: Generalize IIO topology support")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Hi,

ping as the patch seems to have been missed. FWIW, it's still applicable to
the mainline.

--
Thanks,
Fedor
