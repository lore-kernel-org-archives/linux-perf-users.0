Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675D13957E;
	Thu,  1 May 2025 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746082787; cv=none; b=n74cSOjCilUL5McAXdCHUPOEh6bVyHYBJdSySrT0K2hd8tu3X+0IWP/LphcYynCyNr5pAaCpsxkK9/tlpPRV/nCV2lMxGc6IeSCsAezIwzzL1hDOicfF9+TMHdC9b/jd4H8C5v/kzvkEUO9I0n9tIeGcyebb3F2vsy7OvyzNLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746082787; c=relaxed/simple;
	bh=guuiHkTI6FXS36IV4JnPL6JTcS+Xo3HRpweIUmNPo2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYadg4yjtyX04+AXFGUjxwfxgfrol1ExkPGOM9T1dtnpl981B83DMEtPLa+JoOzRnLj2cwrxMqwM8Pf4LS1S0kuKqlArTjk0Gwjye7pjA/7OWRt5pWa78TCG4PtOeNlepqYMrs62qfSDxJuz96xZMzib6X+4FSWMmhJmFauCpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UlhVKNOI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UlhVKNOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1746082780;
	bh=guuiHkTI6FXS36IV4JnPL6JTcS+Xo3HRpweIUmNPo2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlhVKNOI/CbThC7W1HQmhEOj54zCzPDdwQRRCKObutcepCEJto0SDA0T9FmAQfaba
	 BWWiTAySqZ8tH1GqWRNsFdSriZJOQb4JS3YTJQHdKA6ljUDzLF72mYy1k9U8PLfax1
	 tZ0sm2bKZWiWByYwtpeAIyeBXDB5hNvvNhavOGSo=
Date: Thu, 1 May 2025 08:59:39 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: DW_AT_comp_dir and O= usage not working with objdump -dS, perf
 probe, etc
Message-ID: <8046e5bb-06d4-47dd-ad08-deef63a7e734@t-8ch.de>
References: <aBKziq9dr_EsWLuZ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBKziq9dr_EsWLuZ@x1>

Hi Arnaldo,

On 2025-04-30 20:34:34-0300, Arnaldo Carvalho de Melo wrote:
> 	I noticed recently while testing some other patches that
> disassembling with objdump -dS didn't work when building the kernel with
> O= as it sets it to the build dir, not to where the sources are, for
> instance:

<snip>

> I haven't checked, ran out of time today, but I think this may be
> involved:
> 
> commit 97282e6d380db8a07120fe1b794ac969ee4a3b5c
> Author: Thomas Weißschuh <linux@weissschuh.net>
> Date:   Sat Mar 22 10:03:16 2025 +0100
> 
>     x86: drop unnecessary prefix map configuration

It should be caused by this one:

commit cacd22ce69585a91c386243cd662ada962431e63
Author: Thomas Weißschuh <linux@weissschuh.net>
Date:   Sat Mar 15 14:20:14 2025 +0100

    kbuild: make all file references relative to source root


There is already another report about objdump here:
https://lore.kernel.org/lkml/aBEttQH4kimHFScx@intel.com/

Let's continue the discussion there.


Thomas
