Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778459;
	b=lOGBFwGbIR3J3n5cw+jiR+dHkZ9wPlCn2VYRLGUGQPplCoOTDeO8qk0IcQZ8mvI/VJG0
	 VoTkMnn1lMWyrXf2PZ+SStzjjttseZ5PsorToPVc4iziElDhMYhf6tFRu9AQltXeX0nXU
	 cP/4Sm06O1nT27yYkvy3yYUcZt3xCHNEGnH7ElMVaefDchcG3n+lTF0vN86y09RrNNp93
	 MePHpWsbLeBBxdj+IowWYWr+LlhHeALUWQ3H47wmg3gt3jl0+jD/gKmft6Xlj68jQlCTa
	 paOGfwlGTlQ79SRhlrJWKlgs8J4eqH3uBCSGZAitnM/LmEdi9oB6+pl/HB927ewN9lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778459;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WXWOJxe+Hc3m39EWdM8FiFJZvrHtKiYmRKOnSm87ldQ=;
	b=T2/8LcBcpnUTVPEPNHerugiA1LD8VAGaTt1he6kwqoQu+TOn9D7LqbKJBySJSfW56XW1
	 u2U4Ha6A2PUTvUq9I4oi4TPpW4albbqtgzYKHreAS/3IqmBe1U4xwiqGkLmVISyUIDiUp
	 PInq2DN65vJsG8yJyzzQaby+TqSuO0to9nvhSt5NFAT2ld+8eAyx1LI8PIN4GZ7v4kTqQ
	 f25K0LtDSVnIsQ7FZThjlAE+fVpHD0oI7hDuRBp2jYR9onh9NjVo4UtlKQMQYkV5ZftfR
	 2ubMuvqu8qlrjRXXM26uIeK4JqUUwE5f8Q8tD2ZoXnyeAToFJrMizt3WpUh4u9nevhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezWQVYXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3786606A31B;
	Wed,  4 Nov 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezWQVYXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECA01F000C1;
	Wed,  4 Nov 2026 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778458;
	bh=WXWOJxe+Hc3m39EWdM8FiFJZvrHtKiYmRKOnSm87ldQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ezWQVYXVjzos57rRUPoY8p/H6WIEsjOuHV64z5HXoAtl7RRdKHZH9QCQc1jX7DPbs
	 JWQ7S+UAORERDsOsTUomaeVeZ1W0lBI8ZprOlq2py0zPooFiK4lajM3CNiXj6DURMh
	 QFIoQ17WqIlYA2BlbkM7dVkpy42JcK8+BWszjEyhLJznaqVkru8Xr8Yuwvq8X6P+QE
	 E+w/ktm0C7bUit/aOxjPYOcDlu7BZ5aczM/im+7UU336MhaNfcwbhfVbLEUPTlfj1l
	 0UfK7/vrrWTY9e7qjz0H6c5y0/X8IgseaU6YHI1F0UdQ8su7nKunwAXkPEdIHp/4Kp
	 72PqCMLgOsPmw==
Date: Tue, 3 Nov 2026 23:47:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Yanbo Zhao <yzhao62@ncsu.edu>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] perf annotate: Data type profiling support for
 C++ classes and virtual calls
Message-ID: <aurjGFWKFUqwb6op@z2>
References: <20261005201010.36493-1-yzhao62@ncsu.edu>
 <aumOys6T9Kbd-dR3@z2>
 <CA+J8viYXEbmmKqAB1Dkppmrs2KYR1Fap8Kz2gWNgJqfGY0QR2w@mail.gmail.com>
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
In-Reply-To: <CA+J8viYXEbmmKqAB1Dkppmrs2KYR1Fap8Kz2gWNgJqfGY0QR2w@mail.gmail.com>

On Tue, Nov 03, 2026 at 01:22:29PM -0500, Yanbo Zhao wrote:
> HI Namhyung,
> 
> I have sent the V4 patches rebased to the current commit. Could you
> please review it?

Sure, thanks!

Namhyung

