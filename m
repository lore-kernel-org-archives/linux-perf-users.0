Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626410;
	b=vex4qarORtXnvkoq/R3fbcWvF0pllcqbiFyvBSeNUBu0YdPO7FsW0/xQF6RkmoC2n+ej
	 Uw3bCKX2MwxITf5qADchFOYmZkYMFVJ/l+lIpX+OqGSVrO5t3MnBW/PdQ5P/N1cHik6c1
	 /uWWUzFGLXHpuEBiSEafQIU2yN2uxDp2ZYExB2PkKblYJH4BeYQVYFgkNh9um5JegnuMM
	 bCTvqJEUj3BqauPEim16knReeFdkksbzcArpG2qnhFmGtMixTLiXC20qXdjVBqqnD/Rzu
	 rt8S2vQ5RNFOmt0KM2fdPnhWJFuo41HhldtekbTb6CVzFgHK/gZFxCGqKyWySPVHjxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626410;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5hX1MqYn88/+pnlEkFAqtJFLd0d2cAMcWs6EkV8ygAQ=;
	b=BqOGLbVU1NsNHkHz+pH4pAhobbj3roNwsmd557oOCsD0T8TdA8Z3dP/Trztm7UDXjMtL
	 C0pCXZJummtTttv23sVgoRovXIDRyRu19Dyiwgt3aTkf4tFzW/hYq4kcjB3W1niWpUka9
	 rG4cdSEEF7ZEdVUGXGOb+o5E/39m2lqhqjx7Wbwx0f+2S28hVTrg7ZOtFcV3he0Rvzo3j
	 DOfpFCj8nfcZfIBAzNTS1ovzSXjsqY77ewb27H/qj3BVfuxaWJTARTfgKwJbaql904vPc
	 7IYlg+CVDwltsps529UCGIgc+Xhr5KSwXNmN6m7Mu2HeXWcQ5WYDBSoOTKJJUqMJB2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK3pq3BW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D8606A319;
	Wed, 21 Oct 2026 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK3pq3BW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C421F000C1;
	Wed, 21 Oct 2026 23:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792626410;
	bh=5hX1MqYn88/+pnlEkFAqtJFLd0d2cAMcWs6EkV8ygAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PK3pq3BWJHKW+Z9wE9MZmhih4YMhE9tccyBw0OSgOUjFdbtD3k8/9hXYW3J7vfTHE
	 jSiJ07Gxk3hoP7J8bdui6BWvxDG7HhI4XMVjoDmTMhuKDPJ0z+Xg4+toqGEHkeAL2h
	 ll0N0fmkY/L8174f9uT2EQqztldHeVj317WFU9xQwO0z87070ugx/L3WPpO2lUR2Bi
	 VQ960d8m4CPvv7kX2ziViViDvIiuKwpanJsvuyNcd2BiyqRM0Rk8IZbC7mreEGXyZM
	 ArkjYb0O2Eyq/ftwsaNWyuMFm6oWIRdeNVzBERIVsnf7WbIQpuyTRR95YACPZqeW4d
	 OVBNqdRiNdT0A==
Date: Wed, 21 Oct 2026 16:46:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev, Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 00/15] perf annotate arm64: Support instruction
 tracking for data type profiling
Message-ID: <atlO6EJswVvj76rN@google.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <atFdpZG-b2JPS1St@google.com>
 <8fdf2566-bbac-4854-8faf-0276af5f936e@huaweicloud.com>
 <atkzKm_TPnhyzgx3@x2>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atkzKm_TPnhyzgx3@x2>

On Wed, Oct 21, 2026 at 06:48:26PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Oct 16, 2026 at 09:18:38AM +0800, Tengda Wu wrote:
> > On 2026/10/16 7:11, Namhyung Kim wrote:
> > >> Please let me know if you have any feedback.
> > > 
> > > Thanks a lot for your work!  Assuming you'll fix the issues from Sashiko
> > > in the next version, you can add my:
> > > 
> > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > > 
> > 
> > Yes, I'll address the issues reported by Sashiko and send a v8.
> > Most of them are minor, and I'll fix them accordingly (or explain
> > in the v8 thread if I think any of them is a false positive).
> > I'll carry your Reviewed-by in the next version as agreed.
> 
> I applied the first 5 patches that are sashiko-clean, will push soon to
> tmp.perf-tools-next and then to perf-tools next after test building on
> my containers.

There is v8 already which should have addressed the concerns.

https://lore.kernel.org/r/cover.1792411435.git.wutengda@huaweicloud.com

Thanks,
Namhyung

