Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511122;
	b=RYTmXr3tm7eMf4bExNdH0P9nczqVlU4nEqoTmTz9bd4F5OZ/0H9pl9W/KZSsVj3q9IeY
	 AWvbz0ocIndk8XMPQXi0iUCwEKhK3tM3Xwcng7bd2+cZV1mQxFvoTzmgRLYIpltWDgIZ/
	 rXkszN1X5aF9nSx7dL4HbgxZWnKcf5LU7EsXpMFgE9GwyCbsp8M0x3PeorFundh6S0RXT
	 sldJnWRPAliIOW2UZ8hJfSyQgUe4dyobOHXHXNzkt6WweDamPKK6YiFHXr3pNFwUjwlsA
	 4+7/g3jcewIK/rju4nhPslE54vnwL4uZ4ZfShZyF0exWE6g+UkJgeiE4hhUmzZwd0iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511122;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IXexg50WmPwtfGt6g4HQnuTR66f0QjGX0HYreFyKgk8=;
	b=xuQT2WH5A9pkEbUS9Eivj8yIQNDPthuoKzpJJFhcwEkppquFx6Gx1aUk2Zqw/UtH8QvZ
	 wHhhtdpQVi+/VesCA3uskeDjRkl3yzSQScc19YI/lOMgwE7AdzRxfHsIvSBh9qUDwtVPu
	 zsUWM6wouK5xb90Fe4tGzIZTmg/O/u74R9ArSUdvjLrNCxKJET45pz97NY6CVJl4Aw5/x
	 J/NH5Hp65IQ2QjUyTvrp+xqcTuc1E01MivzAMoH5sVuOfJCHApKsrWJWy0Ybp2EVlLIwc
	 gqwgskunUOFA2mVYsLpi1Y5VjHSoRvVDJ+GnGjgrHTaXkFoyC+6uh7qEPFvi1qprUAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mBerxBeQ;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFB606A31C;
	Thu, 12 Nov 2026 19:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mBerxBeQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IXexg50WmPwtfGt6g4HQnuTR66f0QjGX0HYreFyKgk8=; b=mBerxBeQJnkwjlzlTDbN+kj3WM
	jVZ3tair82aWMzz3qk4bpNKHWO94V1zNOy0+Dhq3LSdZhRfUGH7uD/iclRys16i9W2yOER3toc2s+
	rU5TYF530d7Xw3Lvpya35OspbW+W7YUg6X406AIXh7V4+LHx5JZ4ZYZQp+egcfiSNiIz4MYr0LPET
	DBOkUxvx8c37785YnZ05KRWu9ibuw7WY8NGsnmi9R/fkAvNXoFsqWu2tK1DwRP59O+XKYUu2ZS6kR
	BIscE1U2DwqAD3rzlLjNDLcQRRFnREAtEVvDsjoMOhsBrxF0KQQWxPwBIFCzu4VED8+H6fz/jJ14F
	4Hu+9oag==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRaJj-0000000AwDP-3EYQ;
	Thu, 12 Nov 2026 19:18:39 +0000
Message-ID: <85567abf-bf15-4cd8-a04d-d1238cb5fbd3@infradead.org>
Date: Thu, 12 Nov 2026 11:18:38 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MIPS: perf: Add SB1 and SB1A performance counter
 support
To: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20261112190916.3725141-1-f.fainelli@gmail.com>
 <20261112190916.3725141-4-f.fainelli@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261112190916.3725141-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
This has one 'make htmldocs' warning (see below).

On 11/12/26 11:09 AM, Florian Fainelli wrote:

> ---
>  Documentation/arch/mips/index.rst    |   1 +
>  Documentation/arch/mips/sb1-pmu.rst  | 162 ++++++++++++
>  arch/mips/kernel/perf_event_mipsxx.c | 373 ++++++++++++++++++++++++++-
>  include/linux/cpuhotplug.h           |   1 +
>  4 files changed, 526 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/arch/mips/sb1-pmu.rst
> 

> diff --git a/Documentation/arch/mips/sb1-pmu.rst b/Documentation/arch/mips/sb1-pmu.rst
> new file mode 100644
> index 000000000000..d589a6262c65
> --- /dev/null
> +++ b/Documentation/arch/mips/sb1-pmu.rst
> @@ -0,0 +1,162 @@

> +Counter selection and mode filtering
> +-----------------------------------

Documentation/arch/mips/sb1-pmu.rst:57: WARNING: Title underline too short.

Counter selection and mode filtering
----------------------------------- [docutils]

> +
> +The ``counter`` format field selects a physical counter: 0 means automatic,
> +and values 1 through 4 select physical counters 0 through 3.  A non-cycle
> +event requesting physical counter 0 is rejected.  Automatic events may move
> +to another eligible counter when a fixed-counter event is added, preserving
> +their accumulated counts and sample periods.


-- 
~Randy

