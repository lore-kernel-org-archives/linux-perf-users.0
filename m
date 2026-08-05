Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64753426693;
	Wed,  5 Aug 2026 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947606; cv=none; b=vEZe/bVUNtOQ4KNzJZXHoCdwb3ZItGa+NAxT8LlqscbgRsuBIKCgvQJKFmqUYTLBEuMSS5zVSDTYeNUzbls14zfVkeQ0PZBJTri87uQGvCsYUxJ2P7dof4+7Xp8XnmGAhsgtD1tixVEf2xaFUVQx1AwKmZe+UpoA39AdSmznEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947606; c=relaxed/simple;
	bh=aUm/V7r7ZBF/Yz2h/twPI6RGVm9RwTXrSiPAz9dzZ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhVzbyOKsx+A/WLMrSndgn8pHjt7XugVHWhk12PAOgfuePTZg0mP0uL+07hUhah9qRpOthwzh4ZOMNkAiLGV69OHnj9EuqHs/hvuxUcehyWNM/c816FnSyCYgvpwqAmrohK4g+lDNuvAx1VGEHn4zKZMWu8X2B/MwYA8c2rQqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPtMm6Fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPtMm6Fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D02B1F000E9;
	Wed,  5 Aug 2026 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785947605;
	bh=7b0y2dvMJFhWNn+riW0V6UhReG+5DUISkFcGfhqbDaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPtMm6Frpm/A9s8OwQyNoCy0b9HbtLy4dduavCyjIegL96QI1rjHGQitHAFUR1K4X
	 xuZTNtxHml2zshKLgdQrMXr9Izz961I6h5LTBdKd7sEoM7vg4XiNh96ej1vLWltfJY
	 x30FW9lTkVLq9usaL9z2Uh82vvMmXL/kPC3WTpVOhyB8Zu+tpxsigw0Hg97gB+/fbn
	 eFjeYpfp2yU3/6FBgFmSq3FwlahhLybz4xY8veAStY77zv7u7y8oLB5Xtn7IxWUS4M
	 Tia6OCf4ZmfkW3sbzXTYm2k4UIfccF2wp59qkJDOgIMvVTkFY3DPU3sPfvDj3Outpo
	 8RXa4/JqpSBxQ==
Date: Wed, 5 Aug 2026 13:33:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES v8 0/2] perf c2c hardening
Message-ID: <anNl0O0EEwLP2baH@x1>
References: <20260805151043.237233-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805151043.237233-1-acme@kernel.org>

On Wed, Aug 05, 2026 at 12:10:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
 
> 	Please consider merging,
 
> Two hardening fixes for perf c2c found by the sashiko-bot AI reviewer.

This short series is finally completely Sashiko clean:

https://sashiko.dev/#/patchset/20260805151043.237233-1-acme%40kernel.org

- Arnaldo
