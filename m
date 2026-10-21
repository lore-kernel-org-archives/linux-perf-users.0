Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618915;
	b=rg3AY6KRy+BxczKYH3tZyWxFgKTZPb9215fUSRX5b809l6B8Dr6gz1Hm34k1OoRWtHKe
	 PknhbzhRCHwiTOJp3gqvgBOhVax+zaVIz7EZZG8sikl8WRwEnGAgOkcjKcymma6u7cSQc
	 Svv1CKtD7K9qKbg4TzUakSsBiZlb6KwTyO1XWYjbcLRtTZDQdFIiScMReJzzK17VhrG3I
	 GsVBBKjCxaH4sorEcQfX7J/7VfrX5EsbNKTgtei1W3ZV1xFf061MjJNCSN4pp5Sh9EZAn
	 0f5KItdwDe4H/bUjyCTYeBn5L/qclJv8qxFVQGWbm2xO2HDvl7QE5KZnRX0WwReo9MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618915;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lJKpAg3Jx+VSfeGPzGWbNcVAYEvlGehXqvLLOb3zoX8=;
	b=unG3Gn9MfFePCgUjmlUoMDfCzXNiUne7Atfa7e9UlQTqbfR19ycvAX+kNL5R1XWwaUwZ
	 XOz3q4UKQRCQhSzc1hB1n0m4zvyMx8DSCpTEPYgDYA77Og5o9Z5EWZu50SH9kqQc5LYJO
	 aCNFp0XpLuSLoBxpiDLAS8FWWsArVVEVgV46RUEdfJMyvCez1AdI5NmfzcyJSCofwudWQ
	 ztDrIJOhA87T0MiTDQVP5JBnllVVKmWFb5P1Eo2IBg0IkEc1u2gtwDwwYkI0/aWEaRry5
	 0dczVdUrkUa2kL1lhSx9KoQL+7wsCykP1ElgSLwfqshXSveDxo64OVyFWC3VNyMQGZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2j5CC4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6A606A320;
	Wed, 21 Oct 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2j5CC4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4A21F000C3;
	Wed, 21 Oct 2026 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618914;
	bh=lJKpAg3Jx+VSfeGPzGWbNcVAYEvlGehXqvLLOb3zoX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h2j5CC4hBrFWJVq4wawJpT4/gzD4AZs5Saj8Spkp7LQn9oJtXtKp5RaDwYynBh6WP
	 25EJDTBqeH8sKWce3wngObIIBGC4HCf/mXstfTJOFRyAvKiCGk32OzIdlx9SO/UsYf
	 nq6eb+KsFVdg+30BcRDWqDYjKMA75v98Spk23kgfTCyttt1DEQsyrK6hV55yJjf9c8
	 4g5vnD3uiH30YY+gA8IlTSpewHoLPVr5a85maUzHMHvPUaw/9hwQQ32tR2HpEwIZha
	 q7VbWg8Dtys/KVyfnsIf1IZTOPlbZRYzTEEemBht6XMo2ADs2aWWz3ju+Cc2VYYADe
	 YvT1tup8ceFYw==
Date: Wed, 21 Oct 2026 18:41:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Changbin Du <changbin.du@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v5] perf bench: Add atomic operations benchmark
Message-ID: <atkxn8Ohvw3bTVEM@x2>
References: <20261016075552.1759260-1-changbin.du@gmail.com>
 <atb_6wO-BN_cklar@z2>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atb_6wO-BN_cklar@z2>

On Mon, Oct 19, 2026 at 10:45:15PM -0700, Namhyung Kim wrote:
> On Fri, Oct 16, 2026 at 03:55:52PM +0800, Changbin Du wrote:
> > Assisted-by: opencode:DeepSeek-V4-Pro

Just a nit, the recommendation is for:

Assisted-by: LLM

And even that will be removed, i.e. no need for an Assisted-by: LLM tag
as per what was discussed in Prague recently.

> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
