Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C03396E8
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757660; cv=none; b=czgGx+nbld0ICDWR7hyxuDcABCCSUqSX+Nttl9sKRyLcAS7f1Ybrp7/kEyZy1BRIGuFwsiQI05R6c/ERWONEWUNeM8QwNI9dRqnjmP129/LoFwLC178JRHTeaHwg/0bbOOacfMBWZAfXmkQt4b6P9MrYCFktv8vdTFBA581FOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757660; c=relaxed/simple;
	bh=nicH+cz+qel+mG7mk4DNjJSkk/E7eb9IN/J/+6es7k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftg+RIkRdtvUxY13xrqgGgJUfdpRnq/BAwThXqhphDybPkpRujwgR2q5TazUoyqZi48KZYO3p5Yd1aq0+8TYHNFSzMMTNjXRU6V8/TXe2qCKv5nz4ZtuY7b1ZO5ubt096sS+HyD5fscdB2AxkRr3qkFFMr7JdNgIC7kqg8xER7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIsTWqbW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIsTWqbW"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65a11e565a9so1130270a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770757658; x=1771362458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G2HZ6llbVBtsrcPbZIVsd3zEmL4ig9UnGtxiwMh4BLQ=;
        b=NIsTWqbWkyzhj0krYwvBizIh0f3jOQ5fmdbMnPUPUXsvWtiMcDU9qzNswpKKhp4W8z
         me1k9gyngIX1GoRIut7JTUldXD8HRLcaxkRdrgngZu8PDrsvdcva4MF4RZNxO9J58FA4
         RDSxe7KCFiSWZOgYO38+wmYm1SdNAzp7rLIQqQNIv3Kdcu5qJgbiUQU6/Lf/hgEMoAbR
         fG/nRNjzVXu/kupY+pPPC6cTqytQhPOzXG4bx+lMe+bVazrctFLeVynABjfFoLDQyxLB
         hbtLqfa4l8LvWiuDDwiDePIec6y4C646foHCRXByxb/kpmq5RUvoZeGfiJCTO6bjjAvd
         u/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757658; x=1771362458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2HZ6llbVBtsrcPbZIVsd3zEmL4ig9UnGtxiwMh4BLQ=;
        b=BBkxMTNKgtuL3HkPgR6Sicy3tSqvgsD4mU8OF9SByjVjBFAocnppePF7HVsoJgnCIG
         ZkVnm2M5kK9FLZThYWzOuVU2zuFjwV75DnsRBH+1dE2HDzpmCTwH3WrsOw1bOHMhfYdl
         CVeYLRvWKhGNS4fY3/PtLfJuLJBn2QPo6Q3p0OJoC8WsXjIKhlxgm2scV6xg62ZbjBNL
         uWMFpku0+rt6fKj+98fUN9SnoObxBOiSCd4mdwSw0YEzRf9ECa0UxjBod3I0NySQtvU3
         LngrGpwZ+kl/TjtnPzYpCb8fn2bEG1vRiU1otxIGBQUTgXCfDTm4jckZqJ4IL7W3/2Wj
         8V7w==
X-Forwarded-Encrypted: i=1; AJvYcCVqBl5URv8G/EYyJuY0pKzMJ7FXJ2hGpTGtFLtG4R9JerFULcrq38/0BYlnhJpJRI6At/NoJ4bLKCaRCYfGEkmS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LTR0bBaQxmQhW94jv2lYPLJJmrmEG6GuTlBxGqCcRy0URv79
	yUZuX5O03qmhm2m22LfvhKPmGIcBG1OUe0SfMYEuSMZSIJSc9NTw/efr
X-Gm-Gg: AZuq6aJFI+FFbQGxG8F4eBLTQ3/8RUglcnXvqMns/znBmJe1YBHdVyOOPESndJ9fWcY
	I1ag5oedptUEuxmtPUCDllf4kwnluNuzbO0CUlmSAcpm0v2dyxFHGy8ng2V/8eqI/QahVnFiJzh
	sDw2znS7NOSjk/UqT3Iuj6hnKsH91pPqfM5gycn9mgMhrnHOUgg8UDNNyfgouK9VltP6jABCRim
	Ya67IEUHBx6EW3rg6Jy5rF623gxKZDfkWNRcR88hxF1/IT6LJI1T5NuPVR06Zf4ned+Ldhkblnd
	5/xJlBHjOmJshc4c/cat5WDhaNaPvG9bP1gxLd0L5vY1HTAMV5sZres78Z/TPkn5s4caeQH0ML/
	5QjqrBXBEKorlOpQInItgIBa0rEY03/nJpRPnYyum4kp6jKnxjwvwtWxJgoZZVek+c8joIww8Yy
	/ArslNTSV5RgSlXstQowgNxnV2yxGVpf18HTyIuHkhjIO58Dgm8xxTMYmDjoikORI+loYU3jVql
	D72jOTrRvkn20qwxuKukU8KHTbwspBnSDFbZ16u0s2JuWM=
X-Received: by 2002:a17:907:c23:b0:b88:5e4c:f842 with SMTP id a640c23a62f3a-b8edf39a1a2mr976832866b.47.1770757657524;
        Tue, 10 Feb 2026 13:07:37 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6e950070sm101766b.6.2026.02.10.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:07:35 -0800 (PST)
Date: Tue, 10 Feb 2026 22:07:33 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Fix rust feature detection
Message-ID: <r6fr6d2oqbj3km4nuvdgyjubzzae7gmqvh2u2igijxpc32mi5x@74p5kjnlygf2>
References: <aYoZD1onJLsnlrV3@x1>
 <sc2w3tcjcle4zhz72b2jdnyfnhzl6atiecium2dwcmrlvn6syb@n573cdtyldne>
 <aYsj7vV2Lh8wV-ZR@x1>
 <hox364wgs57bv7hvscvvtbkl5yerur55iz7un3gsu3ozpbnba5@haqvngx6jy4n>
 <aYubAAZ10CfYsmZx@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYubAAZ10CfYsmZx@x1>

> On Tue, Feb 10, 2026 at 05:54:24PM -0300, Arnaldo Carvalho de Melo wrote:
> >
> > To fix that I've tried to add an extra dependency on the rust binary on top of
> > that after the compilation is finished. While hacky, it worked just fine, and
> > perf catched it when rust was removed. Haven't faced any issues after few
> > rounds of installing/removing rust either. If this approach sound fine, I can
> > post the patch tomorrow.
> 
> Looks hacky, can't we just try to run:
> 
> ⬢ [acme@toolbx linux]$ HAVE_RUST=$(rustc --version > /dev/null ; echo $?)
> ⬢ [acme@toolbx linux]$ echo $HAVE_RUST
> 0
> ⬢ [acme@toolbx linux]$ HAVE_RUST=$(arustc --version > /dev/null ; echo $?)
> bash: arustc: command not found
> ⬢ [acme@toolbx linux]$ echo $HAVE_RUST
> 127
> ⬢ [acme@toolbx linux]$

Do you mean replacing the whole feature check with this, instead of
compiling a dummy code?

> How would your dep on the rust binary work? where would you expect it to
> be? It may be installed on some different path, etc.

It has to be in the PATH, so the actual binary could be picked up with
"which" (it seems to be used in one other place there as well).

> Perhaps there is precedent with some other component...

I haven't found anything similar among the other features, but I can
check out other components as well.
