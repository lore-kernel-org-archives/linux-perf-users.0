Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90650240232
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780610; cv=none; b=BoJyPF2LLtbf5VbSDZ/nYf0ztvUA0T0I9bAqwLmemQfiLelfLHIc2nTGt/LJlwMWAfDBSSeehOxP25MPUVK62TwXHoQvPwIrC+sBMAKQ6ANdM51M5qz9QqCQgaMq9GqngKE5oVhc/4/piuKuK65UT/1G4XGVjOx3sqwiw754BOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780610; c=relaxed/simple;
	bh=HQscuRWyiRiA8Yzl8LSP1VJEaQIiJRqJg9rgA4Wnzjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX2RQxluwdfN0gq4YLDwHEIov9ZBS109xgTIcaI6JQ6+GYtiR/lOfF3FDEc+0qT7vViVqRfCG9F70TXVQilVhGTHbQzyKmzrRPHlHPfYIXgu+cUn7WimXgmQOOFKomr0xsyGuje6zyVqlKqQmk9Nx6ruQ8ujypZ5ajGFqRX5aBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfFgLqaU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfFgLqaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA19C4CEE2;
	Mon, 13 Jan 2025 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780610;
	bh=HQscuRWyiRiA8Yzl8LSP1VJEaQIiJRqJg9rgA4Wnzjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfFgLqaUHFEQrlu+F2MpI+Sy4zqRDYJsaHt/S1CVMbRn64Vfx4lrrpjHOY3pLlNyj
	 Df5cFa9PdelA0OnfhlKlkd3gxCNCX9Z9aSbhOMbLSKKLl9TbdX2OUMpdY++dRPGTUm
	 k9Bb2CdP7nXudSkOttw7AzQim09+mXiCbW7CUTGguE0e6d5/0ttubrVWEi3X0iNuIS
	 6oUZBu3YOwoVHTvIdzNef7xGKqqckPR5/lhIyKUXjKomdRUHzJO/R+HFikIjaTSRk1
	 1eMgyOLJJEPCoBq5hwk6nKXV1WHmEUP3QB/NRVd8sGmnmYcUThcfQvGb3th3a14yHD
	 QVbVJb6S7Gbsg==
Date: Mon, 13 Jan 2025 12:03:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michel Lind <michel@michel-slm.name>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1 perf-tools] perf MANIFEST: add license files
Message-ID: <Z4UrP7ii88jf18Nz@x1>
References: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
 <2fe55e73d3ef64ec3bfc683446e3f1f8b9e8c9e8.camel@michel-slm.name>
 <Z4BFcA0L3IfsmtbZ@x1>
 <2a25433033c3b31f5c61b84ffb4efd51267ce3e5.camel@michel-slm.name>
 <CA+JHD904E19iDzZ8HqcTwe61Wzp57_mkPuWz5miEztdd8jbVhA@mail.gmail.com>
 <6c81d671fc8e9f72ec1823eb0dd091a17cc7eefb.camel@michel-slm.name>
 <CA+JHD93YcNEaLgasSsjAmo7fWe4gy-5d90NCdxYUwPdgRuPL2A@mail.gmail.com>
 <8b6e4382cad6a98461863454a8405fa78ed3b591.camel@michel-slm.name>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b6e4382cad6a98461863454a8405fa78ed3b591.camel@michel-slm.name>

On Fri, Jan 10, 2025 at 04:37:23PM -0600, Michel Lind wrote:
> On Fri, 2025-01-10 at 18:06 -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jan 10, 2025, 5:22 PM Michel Lind <michel@michel-slm.name>
> > > Ah, no, I do see that one. I meant the "perf MANIFEST: add license
> > > files" patch that from the timeline should have gone in before the
> > > bpf_perf_event.h one.

> > Indeed, I though it was there as well, will make sure it gets there,
> > thanks for pointing it out. 

> Thanks again! If it no longer applies cleanly, I'm happy to redo it.

Ok, now really applied. Will push after a batch of tests.

- Arnaldo
