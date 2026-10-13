Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCD3CFF65;
	Tue, 13 Oct 2026 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931642; cv=none; b=h+el4ILX/jAnz9vmHaiCPMY7pBwlOuIgB+h4hUGrfSxaylmnTbqJ10FDsAYdW1Jdrxki3UQdb06/s70wVpjypC4bKku0uJMBdjTNZ+b6CWM3YLIXavpgEtbwh2Po4IfBjJTu9dWIK/wcsjX7HbR7ZQISY55mb1LAfLF2p/x+ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931642; c=relaxed/simple;
	bh=fpsEFNZ49mXN0CjAFXjXFgsRopRkPoX/VEAdKemprKw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DOfYAAhRhsDSdCDfYzEkUCWhQJFmf9PJ0B5JCp0XCO+t5cRBr2UQtFje52Zxit1sUkUtVDn9/ZEjSU4BtYHoQyiZDtPAoPsN8gNkdjpWLrsovJhr7FYAjtmOzGkvOvXR9+le4LGPHZJwmkOiDe90Oagp/sYcfmmosC0QCcs0rck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gdIAKjB2; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gdIAKjB2"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4j48br6fClzlfvpK;
	Tue, 13 Oct 2026 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791931636; x=1794523637; bh=vPtfGY7U0qpQt88ePwY98PVP
	CBVm04Jc7HFMLoXvcy0=; b=gdIAKjB2jhIVY73eLnglFKkjlWqfvZT3EEfUT76I
	gye0aEDKRCNZkWojSSz6J33/xOaN8wX3tZvhMj6dGYPoqJRLDgHkjUqxBDwNu1fW
	dedC99RSfgckYh1NhhAK1ZBV062Lq9QaK8hEZbqAA5bxG0RMMIEeBsW1UiuySXJl
	52WnobLqYo73+Z7EqRUNaxIGAJyhBPSvqIPry3EcWAhE4GWofTfagOCde5zjHSku
	bQK5CVQtH0Ja/rrnbMRrkXiTPNItqHvYzABE5kKggU0cG0oR7AWmNEPphnt37ON/
	VoTVlu9nuui8Q6+35VhsfPMcEPeQO/Gz/XxXXXTdqYH4mQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bchtNWTaWQau; Tue, 13 Oct 2026 22:47:16 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4j48bk5rJ0zlfvpH;
	Tue, 13 Oct 2026 22:47:14 +0000 (UTC)
Message-ID: <fb2f83ea-cbe4-40a2-bbb3-bf2884ad8e05@acm.org>
Date: Tue, 13 Oct 2026 15:47:13 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
From: Bart Van Assche <bvanassche@acm.org>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-2-irogers@google.com>
 <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org>
Content-Language: en-US
In-Reply-To: <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 12:44 PM, Bart Van Assche wrote:
> On 10/13/26 11:24 AM, Ian Rogers wrote:
>> Assisted-by: Antigravity:gemini-3.1-pro
> 
> I think this should be changed into Gemini 3.1 Pro. I don't think that
> the "Antigravity" part should occur in the Assisted-by tag.

Has this feedback been noticed?

Bart.
