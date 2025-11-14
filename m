Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D042F12C8
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148233; cv=none; b=q091v6KFZyI6nRNWJ/4SFPCDvYdKMcwmzPYNkW84erGOpPfqeHkybIXG6eCtx/0ye3EfgSLzy/9OkK5vA60xtRiWeVDxjHe2SpZxN5LRq7sc3UnHZLhDkDMcKtxDlTjY/7Wxat2CUFizc/fkW+Uym9mj6P6KauqxkvpKKngxp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148233; c=relaxed/simple;
	bh=1C+BR2cTa7yQPByIGZFp7ybfSKZb0aXcix8TMSqvQZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9QnOJiIMdX1WGDkA6RAclHuXe4mF/uESJid+P4Gy/ZpLQ/rHOBLbrfHED1cFAkMicoBUQ5nTEaXDF65dBN3rZ1iwjCyTbke0+hxOBsdB6iaWlVgwzdklUwnK8FUye0w9pXbel9FS96ZQTUIgbKtiRJXbtLtY77r5pnIoDNvAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mliK+Eze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mliK+Eze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60220C4CEF8;
	Fri, 14 Nov 2025 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148232;
	bh=1C+BR2cTa7yQPByIGZFp7ybfSKZb0aXcix8TMSqvQZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mliK+EzeaSoj/oRsU9j0X2z5sBLuVkgP0OLJHTNuZJuIS0wnkIzpMd/B3Ixdac3Cu
	 SAFpkU8q0+3pteZMT4kwhnh9TCN2Qm70K9l8roh2IErli9N8v+hgMjvrXEaI+0umGp
	 hwshlPVeLew4at8hgxZLZQNkx1vVvcsKLSM1BB1tPLG6XTg8DNcTXL8MAcVYwMMRO/
	 nvgv22G1NP4GyMuwyKCabfGTYMissALM0er5xC0BfRcaH7PNh6h1cY6ZuWLkC/97oB
	 LBfgqzV5IGs5gH7gsLMVSmAb0QEBd8einA1nVN58HYuybp/CtgxY0JwDy/HFTVlO8h
	 XLsEgFZFAcxxw==
Date: Fri, 14 Nov 2025 11:23:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Add python JIT dump test
Message-ID: <aReBx2jFezxbhWt0@google.com>
References: <20251114092914.217533-1-namhyung@kernel.org>
 <20251114092914.217533-2-namhyung@kernel.org>
 <CAFjbc8FK_qs9XqMEf5k81VRNCNXSyda=VUSuJwp8LALOq8fGvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFjbc8FK_qs9XqMEf5k81VRNCNXSyda=VUSuJwp8LALOq8fGvg@mail.gmail.com>

Hi Pablo,

On Fri, Nov 14, 2025 at 07:12:42PM +0000, Pablo Galindo Salgado wrote:
> One important aspect to have in mind here is that Python 3.13 was the
> first version to add Perf JIT support. In older versions -Xperf_jit is
> a noop. You may want to check for the version in your test and skip if
> the running version of Python is lower or alternatively ensure you
> always run with 3.13+.

Good point.  Is there a better way to check if -Xperf_jit is available
or not other than reading the version number?

Thanks,
Namhyung

