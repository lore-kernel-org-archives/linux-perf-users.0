Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715972;
	b=ayVvnkaiofmq5L/m3WlysGwt4agNcVQCp6V9kEkthdjshP4vy6wv7k97ZwJUcPxlU+9F
	 0nY7LNGzjwnEZiSObK8I97PLyWwwsKdWX6fd03t3eXqQy1Ic2WB8hyqalaxryATgpiIcC
	 dJ2/qpnXM/Vf+EFoeBowb+dth3WTcGVlIu28v2y1O+5OEWH71E/Vq6WKRma8tYhD+L/rC
	 ixonUC8cG30JcWDtuoMH3KTNpguHLitB7FqsZl/bxdNDmIR1diOyQ/DUR30zBgCGV2uki
	 +TZ/wv6XizQPwrYhKCCdVBbM2NPLdCpkE3C1AJB4k4CaQ90lCTEoYzyTbi9Zvff7Jqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715972;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=8NzzDHq0v8fLTEA7pH4bKwmA0BS+yC+Ws2gUNb3zWRs=;
	b=cO9DF+MMeJ7GBU06Gn1MWHtZOJbwxLFuU81aPM7cGn2w5EZBrUT+bQLDzK+Na9VG4lbn
	 7XUf/fxR1vrTNS/2YHmxNWv+zbT/vPTrHfru6xX0SJuNuaWn4o9dWiWkMJIVY7tXpoHuV
	 7iMyE4CpeFluSCiGbszm5/OU+iriTNOjwZOoco7vSBRVDFJLrOR79TewOhtzENg/MWy9f
	 YNroVFlFo8UhI384mDMO1mIlib5M10XPJjxWEP3I5/oo27tryCpuGnrvC7s3B9zMjBfMl
	 xCygHfE/z92oXcbvcOsKakE8MhvigJ7OuzIolD5qmxCbkskN1VnwM88Mz6h7h2V7Dpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/joS4we";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7978606A338;
	Sun, 15 Nov 2026 04:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/joS4we
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAD51F000CB;
	Sun, 15 Nov 2026 04:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715971;
	bh=8NzzDHq0v8fLTEA7pH4bKwmA0BS+yC+Ws2gUNb3zWRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q/joS4we+woua4v4UJHhvwqzYXlJdGiyQvWOTVQXzvalBqkzupUCvo6J8ZSj7KBbX
	 X/ILS5u8UzyV0YYmIrKJarKAzzhthKQ7msOhJGemOCpPslsXWkF4l8C5ilB6uswBCi
	 JZGx8ugJKbt7JKtXLbAmNgybCGUqcfX0WjHfgJJu5RXeFdHyGWkm7mm0plb3BUaJw2
	 huTGmCTgEeNxnvJnB4rhBz6ySxyG+n65lzBwxPzNclvEYo2P9D4YrS3hhMgGRBw5kz
	 /KXp2oQKM/j1PSvzOd7Jx6pkH5F9g0hPDGbKRZqrVZhHFVDCpIa9vV3l2FvbVYl8Px
	 oyTTF35vkEvaQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sandipan Das <sandipan.das@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
 Ananth Narayan <ananth.narayan@amd.com>
In-Reply-To: <cover.1791791463.git.sandipan.das@amd.com>
References: <cover.1791791463.git.sandipan.das@amd.com>
Subject: Re: [PATCH 0/3] perf vendor events amd: Add Zen 6 data fabric
 events and metrics
Message-Id: <179471596938.616307.7290987992294705558.b4-ty@b4>
Date: Sat, 14 Nov 2026 20:12:49 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 12 Oct 2026 13:23:29 +0530, Sandipan Das wrote:
> Add data fabric events and metrics sourced from Volume 3 of the
> Processor Programming Reference (PPR) for AMD Family 1Ah Model 51h
> Revision B0 processors, available at the link below.
> https://bugzilla.kernel.org/attachment.cgi?id=311021
> 
> While at it, also clean up redundant attributes for other metrics.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


