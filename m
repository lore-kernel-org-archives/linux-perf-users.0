Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821255C0A;
	Wed,  4 Sep 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725422241; cv=none; b=BBzEJxhake1zpfMf+jehRzt/HrdpPSN0lYDgi3dCvOnRoySGKgabLAeaPMYNsf33IXBluWrx3nGshSVjArOA7bxeeE3a58SGMXpeRsXMmZ8+7JuRKjsFLknV4BTvhl5r6nEnsoF693WuNgQgNWgJJdS2Q5uNnb4wWpWHBFthaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725422241; c=relaxed/simple;
	bh=ivqHfD7++rU9GRfQMe9anuXwU61tfPP8YPdfV7dcgxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kln/bl+BsS5WHEUyu2Ckl4Y/xbVODcJnt2GOS45D/tymI5hoXf/Y67N2qbEeiYFWOjoMiI3GRqcg6y8EXpZAOSGrOAKArI29bhFRt+MptvHGnePF6xk7nt2xtJTKJ/8hJcXKB3zUGK1qGNWg8rdfgLu/pdO8vAw3do/rfsgvkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=U9J8vsG8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="U9J8vsG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725422236;
	bh=bgCwdbOVFpaURv00hqL/lwUSISFJ/jzYxJlaNGAU2OU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U9J8vsG8Uwv1/84l2ookX17o1153/WflTXx/rbatcB7lhtIPmuCRHMrYQduxy8sct
	 pVfA7mdd1ZdSsNlV9S+RwvrFTe1ZwE8Yon0RjMsD+vnj7wI36uMucOCgR6BBEC/zgi
	 iZK0fUTnkmSuZ9Ccc8QVwLnPaoeDvMO9IDONDK0zcckZZRDi5uw6O2wHSQUKmdfr5I
	 dWdLKVexdDb5e0RhatBid4K2SaIn7WsfhusEW3ggxFSRdNk+UNioX+yKzoLnyldVe/
	 pT1Pfg6L4UctDia37ve7aVklQue5bWVDtiZxTaywsBpq6I+0m8550pLqCeuVpgK7WU
	 QaOkMGqL0YMAg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wz7wp3135z4x3J;
	Wed,  4 Sep 2024 13:57:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sven Schnelle <svens@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
In-Reply-To: <yt9dikvd9nye.fsf@linux.ibm.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
 <yt9dikvd9nye.fsf@linux.ibm.com>
Date: Wed, 04 Sep 2024 13:57:13 +1000
Message-ID: <87v7zc5aw6.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sven Schnelle <svens@linux.ibm.com> writes:
> Hi Michael,

Hi Sven,

> Sven Schnelle <svens@linux.ibm.com> writes:
>
>> The following KASAN splat was shown:
>>
>> [   44.505448] ==================================================================                                                                      20:37:27 [3421/145075]
>> [   44.505455] BUG: KASAN: slab-use-after-free in special_mapping_close+0x9c/0xc8
>> [   44.505471] Read of size 8 at addr 00000000868dac48 by task sh/1384
...
>> [..]
>
> As this has a dependency on your special mapping close series, do you
> want to carry that with your patches?

Andrew has my series in mm-stable, so I think this should go into mm as
well. I assume he will pick it up.

cheers
