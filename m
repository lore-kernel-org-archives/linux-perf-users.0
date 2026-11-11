Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424172;
	b=4zy7hgmKDzHgwGtzFR2PGlLNdFCyCKuxy9dXai2AkVJRalAW8DvQ/R0Y5rFmZs4kB76x
	 y5BoCxUUnUR4knzUFcJIedHTx3SXunO89Kk0YZmRLOJ6eiQCZKgMSGzgqBEOTkboxuym+
	 cwhPagttHUOq84Rqqjk9CqliOYmcF18kuwd8WbWHE7QCTMmukiJngb8BcECKgaXCLgiJS
	 Iyyd6SQDLS7lTucRw/Bzil8hgqqgA2s7WtY3HV0F4KYhlHw+sOfJjPqPYq/hKozxTCqmQ
	 ksmV24swNW5oK2hDHX9QDP72iJnsJi18IzTepDmVwxNeSpaDM+ryZmX9UnvaFMiqwqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424172;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=RNbJFmZkmePFtzHwV6zWkYa+pCLlN4u6+GmZ4jR2f7c=;
	b=JZoQDWs7uv5VJ5S53/quUvq2YnKv0hzWymHeGW+bqzEcX3jD0Gif5iekaHGBuMrQFJny
	 3ZxryoiVV77gyOZCkGZJr6x8Ko6pt3dm9lm/nj4Vayqv3Qsk97B9r+fDKz4XaVqbU0+cU
	 WzCNkYwo353Z0A1KyfSwcLcKX8oSK8UQp4O8CD2FKPOFotXXjtDI+FQgsddE6ucItICNV
	 aqqDQhxZt93pun4ZRh0XweAEV1qjvL7TzmYzpLLdu1o3XPTHIMwp6RipzndDZtmaszE1f
	 +Y0KRCNPNTHixF+L1+IBhSu4gcjmKyhru6KR6w3G++2HZhP3aTRjV9EeK4OZs5cjX2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXA0k7n0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98725606A33E;
	Wed, 11 Nov 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXA0k7n0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6451F00A0C;
	Wed, 11 Nov 2026 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424172;
	bh=RNbJFmZkmePFtzHwV6zWkYa+pCLlN4u6+GmZ4jR2f7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RXA0k7n0M5IN7QMkFeVeuLMiGZjXp57D7LIoGJUif6ewwxIEIxcbBJomSSPg11P0f
	 duVoArBe1Km+orfavhR9mC+UpoGorp7VwvfosAbGc5bIQuOUzAmcq8htDsqyAhsxjB
	 KUQRrrAHVa2PXJjeeheqN6nDyqlPag5OZCYhV+i/CzmTGxnBQ022eyZRAFs1b48dwg
	 3t9m1JNK+kO+OV7vzNr+3hRdq0wIgED9eKUIkO/OQzc7uq2fitqsGtW5VVmyMra5XP
	 r1F77k1VhKVsGdiVNCvO1CfMfKLoY5ARjc3d/xZ3LA+GsVsElorq4lROlCyFQzRre4
	 YW72rWMCqhfHw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>, 
 John Garry <john.garry@linux.dev>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261108184654.3811267-1-takano32@gmail.com>
References: <20261108184654.3811267-1-takano32@gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Fix typos in event
 descriptions
Message-Id: <179442417182.676192.13202396193475036791.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:31 -0800
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

On Sun, 08 Nov 2026 18:46:54 +0000, TAKANO Mitsuhiro wrote:
> Six entries in common-and-microarch.json spell Statistical as "Statisical"
> (the SAMPLE_FEED_* events), and one entry in the Fujitsu a64fx table, the
> L2HWPF_STREAM_PF event, spells prefetcher as "prefecher" in both its
> BriefDescription and its PublicDescription.
> 
> The SAMPLE_FEED_* events are inherited through ArchStdEvent by the
> neoverse-n3, neoverse-v3 and t410 tables, so the misspelling reaches those
> three generated tables.  The a64fx pair appears once, because the long
> description is dropped when it equals the brief one.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


