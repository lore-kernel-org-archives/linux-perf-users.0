Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725524;
	b=KMvxpYAf+Ye9A9aSrxi0AR/URQj0WfU+LGVVVmb7cnIBRXNN3pfT8gtbDO+Ek/oruwOu
	 GxaEvh263jDR/Q6fa9qSFsmO26LrmNBLtnuQQ5OKGZSkJ08b4dJ4L2y8tuSfDMX5elT3C
	 tLkWMX5jqip3ag8oHLxxoJJ7woCmYcp2aIz7TkeoGYMmXW785iN5N0RUg8VusP039miMz
	 nJzQtzc6K5q1VezvH9WBVNiAkDyReMOCkW88UFBP07/cfOHKrFUU9Z8SPCbmOAtxtsIIH
	 OVGlPaMfmBpv7aMlFFpvD9QtzerzrdWk3J0n2bA5pwsFwnvB8veY7n2j4KdmYjWp8qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725524;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LtptDsS8wz46GQUZDLaSX6QydPFi4qzHm9vxKSHvWgk=;
	b=IEwW9VCbSbE6OKIKzdK9xJjzN8oGXt/UQnncC8tCK0L6E1wlqd7dad4tZs13hyi3an/V
	 wyxwBJ6GnBaewWodixYEvkDVlTcEiFAcRHBfoj3f+h/wNaTRhAt8rx99MDHzlBYhB7F3f
	 yZnL3QTF/8j9MHHhQ03Wpk5B6psXeYSU0uxGqONDEyjuzPzSPYpDXx4RLnBf3P6noLweA
	 gBRNwFiMR1NrYU3NGvITDBmbA3gdz2IMmS67vjRaza2IN//fjuKTfFJ+rgyoXFK4Ku7b5
	 AUDONBe80La0jXU6o7vQFoZgBPdIuzNmOV9L0FDdS2HVicXpmo6RRp/hEB0G8u6ObDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5xpoUII;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB187606A324;
	Tue,  3 Nov 2026 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5xpoUII
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E191F000C1;
	Tue,  3 Nov 2026 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725523;
	bh=LtptDsS8wz46GQUZDLaSX6QydPFi4qzHm9vxKSHvWgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B5xpoUIIH4zlODh4O1e7y4efllDd4STtICq9faVR73h880kxi6nZh9mswEYxy+P40
	 IBYdNIms2+vQWmOXy4HzfTKQk3VmzY2EQj1gQEjYdolfJXX8plaJF2kRNq9NQ/P2KB
	 onbwIyGoDDt8e9bT7Vk1Oto7cxITAJY4kUMvp3GJJPdKtXYSKpKhW+tUhREkDj4k4J
	 WD7UFJSnv1Kj5lvE5ARDRlbSd/4+I3+Ej7lKmOc7GcWQSiT9EQFKZzXrI/ujpQw5So
	 9Xi/WKqL0EEtdK5o+GPpJsFpKqqsIwhBmYEusnm9xzwBrTH0t+TwJA1yhLmdsSReRQ
	 QrD8v5O+aKdyA==
Date: Tue, 3 Nov 2026 09:05:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/5] perf tools: Random fixes for the symbol code
Message-ID: <auoUUXyBp8TRHWSE@z2>
References: <20261019055207.39325-1-namhyung@kernel.org>
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
In-Reply-To: <20261019055207.39325-1-namhyung@kernel.org>

On Sun, Oct 18, 2026 at 10:52:02PM -0700, Namhyung Kim wrote:
> Hello,
> 
> These are assorted random fixes found by Sashiko review during the last
> perf dso/symbol code rework.
> 
> v2 changes)
> 
>  * add perf_env for completeness in the maps tests
>  * convert to bfd_arch_bits_per_address for PE files

Applied to perf-tools-next, thanks!

Best regards
Namhyung

