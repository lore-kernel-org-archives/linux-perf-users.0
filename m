Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829661;
	b=QGOgRdgbkfAhcDP82oSBrLSgNbNFQrBn7PLyNqTDBtmzuukBs9UW48E5NCJ7xTHTjA+m
	 vyzQXoVbzTtCLc8M7SbP/A8VCAJe2i3ETkW4dDayxFprNz9BxryzA1XF1vkbMNXQSsrt6
	 fymI8NTTiunWjYhnoRxbFTXjVKS8QE/AEuZWxbz4NV5MPaDJ9VwyPUCLX9m1eLQKZO5aw
	 1yCoxEtpmwZIE7jQROKJdgKqb+BucXLYrM0AubTLDoOZ01GeKfZeOEsT5D8HMkvUdvkgK
	 DFQ8KqR6j6HtJvw0kDX6rhWH+vFbO0avuJIKYslLG//OPpJkIATS7a3ZgLUd3qCXhZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829661;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fawrS/3ssONFT5J61BoyKpRzvTv/DunyIOYxlv8HJm0=;
	b=4vvpu4egNaHA2Sgl7VQEyGec3w2s07+17BXIWF6+JIn0Dga0SvIABv0QnclyEAzXmU3M
	 RwPtxAqFzWwzvfcyQJtqKNmlMcbRbcXT8Bv0lvNu3wtDuQdbbOI83b7PINO+fvLv5EF9/
	 iB5bCkg4zaiLvXrjQSyo7xwYYQT9AJNmF2qYcnUM3JXwQ9KyoU70wG0r/BC9TGc6EHLAl
	 D84KnkosqTIWe+Q4lAxUAMDbAofPp2huEIDdQvxZdwKuYAQnmO5gRhRzfsysa8v/rlC9N
	 rMO9rRZaX+3gihi7nTJ7wtYvF61OL9NjJ4RoxCP3n+nreY8XQ/QDiLbMKy86D2gN6yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rsw5+En3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FB606A31C;
	Mon, 16 Nov 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rsw5+En3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481051F000C4;
	Mon, 16 Nov 2026 11:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794829661;
	bh=fawrS/3ssONFT5J61BoyKpRzvTv/DunyIOYxlv8HJm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rsw5+En3+9wrQKzmbmtFGi8MVW112ImjuZZC4tc3VB0P6R4WR2aAo9XonN9s3vSG1
	 z+Mv61pulx2NsWwq879gwfSqoZjziMhEbwuoBO2py/jmxqCKJeY3JZ8Audt/3rP2ik
	 rK0R1RCSx/qUTBqZKJe2joy7y4L1rhXCcBE2g7o8Ql3SHNnb18NnIKL3hKcY96xexB
	 ne7KMyzfCTP9YWC4mOhtgvymbapz9NWR/Ea0/NP1FSgkGp8f+0+yCnNUfVYgWaGh3+
	 IBndu8EV0BA+sxc+KLKzA0xiIlzQdQZnO/bEKmEm9AGnBpAgvtVvRfECgM3P87xeZq
	 ukv0T+kV6tXHw==
Date: Mon, 16 Nov 2026 12:47:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, 
	Fu Chao-Ying <chao-ying.fu@globalfoundries.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: mips: mti,mips-cm: add performance
 counter interrupt
Message-ID: <20261116-inescapable-dangerous-hummingbird-0faed6@quoll>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-4-cd2569571819@mobileye.com>
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
In-Reply-To: <20261112-i6500-cm3-pmu-v2-4-cd2569571819@mobileye.com>

On Thu, Nov 12, 2026 at 02:29:01PM +0200, Vladimir Kondratiev wrote:
> The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
> overflows. Whether that output is connected to an interrupt controller
> input is up to the SoC integrator, so describe it as an optional
> 'interrupts' property of the coherency-manager node. When absent, the
> counters have to be polled by software.
> 
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
>  Documentation/devicetree/bindings/mips/mti,mips-cm.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

