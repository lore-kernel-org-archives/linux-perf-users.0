Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913EC202F65;
	Tue,  3 Feb 2026 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161252; cv=none; b=bUsYX6qZchxIEnUeVRVTJfuF6Yq1tBX8st/gRYSKwflVY2+97J4/YOtne9oA+EgfEGltv2vGxtWm7UACo0+ONE2IXahFkHW7lW1Cp01Ddz7v2pmTR+fygnKz8kV0/AkZJktQ0QaEFEVtqHOtLXaif/Nt+4bIrglbK1s19B0bxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161252; c=relaxed/simple;
	bh=90B0t2PPGgFL3Q2BXDKmnDbfzBqFlV/fJhjJO/duzto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK0xjlKRHJ0EWOL8iaNedrggchK7qB96rFpWUehnwhLsTMd9ftS3ryvA/xAfsjeY8dJB2yE3PB5NAQenxlqCL4C9cg+pHY90fqXdXd/G/ID5J0w05u56JMDjIz4Q7+Ab4CMCipkblQJAqkh8gs0cTkGhedHd1AtvLCrwwns1SuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=Xa3TBk0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATqry2m5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="Xa3TBk0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATqry2m5"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0B677A018D;
	Tue,  3 Feb 2026 18:27:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 03 Feb 2026 18:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770161248; x=1770247648; bh=EMH2GJOBA+
	504LL6dgwDncR564HhGK8k0BELM9xTAQo=; b=Xa3TBk0Lk2tdVPIi7J4sTXhk7q
	M3jwdifmqINrPAa+LcgFXWEEsGgNyHBWokJf1UJK2N9O4zEDbfwYnNVRtV2EsCPy
	fX5YYATCq9+CxBzjC5YmjI1bAYWAUDwO6VKktkFgI4qHvL0vAXaobGAPyuMdcnBU
	KSasFsHZ88XA76Szr/fpN7SbZTm9AkzvuDCuwyWc2MQ0qA6fBSWDmYQ2qpExWZ8A
	u/sNFPwR22j/7a8l9WSGU1ySQ7+00yi8LzLG0/1B2b1Wr7iW91ONi85b6jPNym20
	FbGTZc2mxpC9WXkta5gFHm8LnL1N412sM2CNsOwR9MNQe/AARWYmt2+kxhZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770161248; x=1770247648; bh=EMH2GJOBA+504LL6dgwDncR564HhGK8k0BE
	LM9xTAQo=; b=ATqry2m5YApbzCgIEr5oZMhUQHMCYgLpsz4krEfrEPoFgrICzoP
	h7M5H39rWUINd9xY8i02+EE/ymc4jsS5PstBcyHCwhoO89DMmb8/eedpF8/orqRP
	cz81nyNf/TvlWPa1h035zfzSRgQ2K04BbLFPCBAqKeakYZHdNRxNf363WmfbfRnN
	NoYz0GdperHYFbZvgKqvAp4sYGbv86XjyHLP7jBCE7s/EfAv5bwusJgNQkBSlc8j
	YS7nE5JQoewkk8qYxqX8iWdeUXd3znBsc5V7gQ9vuVnTEbP0h/Vk8cLsAT8jgRHh
	1Hobgo8WUc3l90nWxUIGynlseQZnAGBtMoQ==
X-ME-Sender: <xms:XoSCaUz0LFzScdH0Rdnomw-1KVvu1coq6Zc_lR_VLMAl8S1Cg-4wZQ>
    <xme:XoSCaRDo2F26e2rgOh5SAHUllJZKbFxrAsS09PWaIavtaoXSA-E5i2St-iPEl_Dwp
    1CRSLdSBeSa2Iacc0cgNKO3ndlfYuPfr1BsQEzV6w-XKLjbw85GSg>
X-ME-Received: <xmr:XoSCaVBOOO8_u89SnOrYOq8PzOAcVUJZrUMf3mGatAQ5x9ZVlCuXTSg-g19CWmKCPcTUEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepheeiudduuedvleetjedujeffgeeiueevgeehjedtgeehueekledthfelhefh
    geelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdgu
    vgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hirhhoghgvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinh
    htvghlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhfrghltghonhesihhnthgvlhdr
    tghomhdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    holhhsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrmhhhhihunhhgsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrghmvghsrdgtlhgrrhhksehlihhnrghrohdroh
    hrghdprhgtphhtthhopeihrghnghdrlhgvvgeslhhinhhugidrrghlihgsrggsrgdrtgho
    mh
X-ME-Proxy: <xmx:XoSCaU7PL2WSXJ04DiqRioajPr5aheX4jFjzbcVI6aed_ipqaLsGSg>
    <xmx:XoSCaZ0XOmUOtp17tPIBx38zJMNvh_vBNILeCnu55ETByaVdPGyMIg>
    <xmx:XoSCaYDSpTk9sV52bCnRWzy57sTo0TNhJKnGM-Kt4JGiZV9eQyVqVA>
    <xmx:XoSCaRGqX6pHa843Q1RK-LoO0OTt-8FJFtBRcfhOq8eJO9Tk1D3scw>
    <xmx:YISCaRHK3bWK18NKPc8-HXCzvMOYIMEdDwgJcFyhb-_gOfqn9CLuXDNl>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:27:26 -0500 (EST)
Date: Tue, 3 Feb 2026 18:27:26 -0500
From: Andres Freund <andres@anarazel.de>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 07/10] perf tool_pmu: More accurately set the cpus for
 tool events
Message-ID: <thuc2tb6vdrm2fbvcezmm6xqsvyjsy7rdafrcbksk73om364xc@sr4yd37i63go>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-8-irogers@google.com>
 <cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6>
 <CAP-5=fVk+B815c3CX4BLSR++JQPX7AgVnO-3Ef+=rj2DLVRKQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVk+B815c3CX4BLSR++JQPX7AgVnO-3Ef+=rj2DLVRKQw@mail.gmail.com>

Hi,

On 2026-02-03 15:05:39 -0800, Ian Rogers wrote:
> Thanks for the bug report! There were changes in v6.19 to change how
> metrics were computed hence the fault in the metric computation. The
> bisected patch is at fault, it aims to compute the CPU maps for tool
> events in a way to avoid unnecessary sched setaffinity calls. By
> having a smaller CPU map it set up a situation with user CPUs where
> the tool events could have no CPUs, removed from the list of events
> and the later seg fault occurred.

Thanks for the quick reply!

> I sent out a new patch series:
> https://lore.kernel.org/linux-perf-users/20260203225129.4077140-1-irogers@google.com/
> that has a revert of this patch, a fix to correctly avoid the segfault in
> the prepare_metric function, and a new patch to properly reduce the CPU maps
> of the tool events. The remaining affinity reduction patches are still part
> of the series and I believe ready to land.

That sounds like it's targeted for 6.20?  I assume the revert on its own needs
to land in 6.19 (or stable if too late for 6.19) somehow?

Greetings,

Andres Freund
