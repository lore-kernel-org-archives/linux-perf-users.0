Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF175233149;
	Tue, 27 Jan 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535816; cv=none; b=DGRTJjY4GfpUoHJ0a7wkRR6WmgR/P03TurVlYqphdRokBJSnT4dNnWDVmVOaMw6h74E95U6jwU8yFPZP1G5GFSXSC/B9fDtOmqLpCe5u5i6YnbpPLYOZNe1lZOq6RqP4rfvJq4TSGWgetCWoggkgFpMDzXCupuIwuKFP+ituQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535816; c=relaxed/simple;
	bh=rQ3uqbxArlD82rm1kTTeHgP3Ca521qNmsUHhaKMB6Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prgqlTdgPHN2CUnzI0kDAzER2MwbszUQdWxYKDefVsRhp5hZy6puCAx0qmd/KR2Ob9TYfGNm+aLVxMJhRXHxV5I88OBEJ+vLwLlG4Ah0Q/Z0wiixTLDt+A4MJu6CNP5cvovyKOqj87qWU2CHUHmLl4uTI9QRSL9d1hS3ywAW9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io; spf=pass smtp.mailfrom=serhei.io; dkim=pass (2048-bit key) header.d=serhei.io header.i=@serhei.io header.b=AJXBEeKk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRmdgELe; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serhei.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=serhei.io header.i=@serhei.io header.b="AJXBEeKk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRmdgELe"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id F20CC1300410;
	Tue, 27 Jan 2026 12:43:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 27 Jan 2026 12:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1769535812; x=
	1769543012; bh=rQ3uqbxArlD82rm1kTTeHgP3Ca521qNmsUHhaKMB6Tc=; b=A
	JXBEeKk/Q356D1zWF2OTHz9HlU6wIYBJXLVWiszNJrdrffvoz2MFbrAjMD50AsIq
	ifeZ7f4c0x19ijxJ5lTKu70aVkcIxknhtfMCp4aCEGHTwdoZaFdTWCmrKWH2+79U
	qjfIoYcazDvNxEmhhV4A9s6Uz0AW/GfgvEXEPUcp9zYaAYXoR/KY6OnVDbtNtSV6
	hAHmaGo29hiNPQAZw6Ae5DbCvpx/EfOOq38Wq9hHfGqj9zJ8FaLdz7e5MZ4draBq
	/T8Vmpz7m5uhajyphuld2dAVt2dgofiz/Txbm1SsJEoTGIJU5lY6xTZ3aO2LYb9O
	lDKr7GY2fObLnhDzYsYRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1769535812; x=1769543012; bh=r
	Q3uqbxArlD82rm1kTTeHgP3Ca521qNmsUHhaKMB6Tc=; b=FRmdgELeq3pT017oe
	MiHeYPYQPyIReVrGSQoxz7ZABXhXc5HxTv54fRcfUJ2oB3HKueFpcxb7qP17u4l2
	2TziSFwlFUQgVM7Jagzmwuujf6ND/Q92hQuUyidVhbBdGGCTRO8NTZkrvCtuOHAI
	trK8JfcBFNWHwojMcKpUNxRgRTKhaqU2zLPlEP9c4QcKmMB58yyNG++2vDIad+BE
	IBz1AqFF4b7ndwIfA2XDrurcuyJiltRedbeoLCubtwkP7gXNlzIVAxwhWtFqzsmr
	soiP5MxHBirjwFH+3QomuXsEUcsWywzRO63730c6ZegGLgdps6rwpgyC1DGxx9nE
	GI9lg==
X-ME-Sender: <xms:Qvl4aZhCUGOoG5kC5D-HHpOhXJ-WxhEPPARCh_n0vi1CcGUmO4gxiQ>
    <xme:Qvl4af5SD_wAmhJMCXRLhtBRfrLmB5K-wV2OPXqmJlDJ-JhWKgBWbysNbklnOaCkX
    l8JEx4R-HI3aknzOq8i551QEkk24_Gp1nAi0H9V48R8E_pRMIZ2cQ>
X-ME-Received: <xmr:Qvl4advG_ufoq8l9X0G8LZcO3fgGk8cRmu58Q5YPuXB0Fpy-95ptiJMFTa9D_GFWle3dhwY4J4It4GjLVkBCBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvghrhhgvihcuofgrkhgrrhhovhcuoehsvghrhhgvihesshgv
    rhhhvghirdhioheqnecuggftrfgrthhtvghrnheptdeuudfftdehgfetheehlefghefffe
    egieekheefgfdufefgudeifefhvefgudeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshgvrhhhvghisehsvghrhhgvihdrihhopdhnsggprh
    gtphhtthhopeefhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhrohhgvghr
    shesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrughithihrgdrsgdusehlihhnuhigrdhisghmrdgtohhmpdhrtghp
    thhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhope
    grkheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrlhgvgiesghhhihht
    ihdrfhhrpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprh
    gtphhtthhopegrthhrrghjvggvvheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthho
    pegtthhshhgrohesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Qvl4acy1cH04rHlU2cxdH9PyrcA8QjQb6liH6SeoYVyYqnWq_4b3TA>
    <xmx:Qvl4aWwl7x1gkczU8HsCUUNImOpruQNSyJGhziDOeN8hbN-ZI_oM0g>
    <xmx:Qvl4aRiY_iDr_TdIhSOrPJYj22bjq7aLMxxWKNibpaTBYmjPK0FbvA>
    <xmx:Qvl4aUjnjA1bBPCMy2wC_-H2p8DKVLkjg2eqtE6ZnAJtc1DLZctBXw>
    <xmx:RPl4aeUujcDdEW4kYQe7ll4i21W8Nm0g3J1N_mS0buHiLGfO4labLlBv>
Feedback-ID: i572946fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 12:43:29 -0500 (EST)
From: Serhei Makarov <serhei@serhei.io>
To: irogers@google.com
Cc: acme@kernel.org,
	aditya.b1@linux.ibm.com,
	adrian.hunter@intel.com,
	ak@linux.intel.com,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	atrajeev@linux.ibm.com,
	ctshao@google.com,
	dvyukov@google.com,
	guoren@kernel.org,
	haibo1.xu@intel.com,
	howardchu95@gmail.com,
	james.clark@linaro.org,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com,
	leo.yan@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux@treblig.org,
	mark@klomp.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	palmer@dabbelt.com,
	peterz@infradead.org,
	pjw@kernel.org,
	shimin.guo@skydio.com,
	slyich@gmail.com,
	stephen.s.brennan@oracle.com,
	thomas.falcon@intel.com,
	will@kernel.org
Subject: Re: [PATCH v1 22/23] perf unwind-libdw: Don't discard loaded ELF/Dwarf  after every unwind
Date: Tue, 27 Jan 2026 12:42:53 -0500
Message-ID: <20260127174253.396766-1-serhei@serhei.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117052849.2205545-23-irogers@google.com>
References: <20260117052849.2205545-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As removing the dwfl didn't prove possible, an alternative is to just not discard the dwfl when the unwind ends. The dwfl is valid for a process unless a dso is loaded at the same address as a previous one. So keep the dwfl with the maps, invalidate it if a map is removed (in case a new map replaces it) and recycle the dwfl in the unwinding code.

Relevant note:

I'm looking at whether elfutils libdwfl_stacktrace might further help with these issues. The libdwfl_stacktrace library is currently shipped as an experimental addon to libdwfl in elfutils 0.194, but I'm intending to stabilize the API this year. There's code for some analogous functions: translating perf->dwarf register files, and caching Dwfl and Elf data to speed up unwinding across multiple processes. (Thus, if unwinding a collection of perf_events from 16 processes that use libc, we don't need to load the CFI for libc.so 16 times.)

I think once I've stabilized the libdwfl_stacktrace API and expanded the register support to a larger set of perf-supported architectures, it makes sense for me to author a corresponding set of patches for perf. I'll see if it's worth adding more libdwflst functionality to elfutils 0.195 in anticipation of this.

-- Serhei Makarov
