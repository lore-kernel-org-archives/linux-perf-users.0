Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020047;
	b=G6sRh7LmGH8mIpvvvqPLkSxQANC/5Mw5sZxIHMxC84iykMszaPsSSrW7OfG1cn7BFVUE
	 s03oVOKUAl/xZJRV/X0Kz0R5myXggJPqY5+E4iedyA6dKT8gK+WO06oGFDsQbu+V44Le+
	 W8U/6KNjwVjSLQ6KcOHUzFoC7Y9datf7cv8Hfd+ysEDY7JLuj6ikO8WurMk7mVG62BG0g
	 xlKVti871o5/yhT3TSYcDpdMnHfTAIT9PkM7UqBf/FRuLmhAJm61wkE39PN0JPOnKtEg7
	 wTetK19l1wZZKrXL1K1ox/i1qOMKa/96ODY6xXy4G0Ids4+eQBjSFYqlznY6/EMjYWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fjFwz2k/9z7X+npL5cIIuVFQjhA0gV/71LTvOT4OmiQ=;
	b=pFzVX2vPNJXb1WGbLqVYljqiWEX8DPuWYxIuB/7JOqxKfuXAAB5CqCGExwj91d0Jsxl0
	 9UqskxYmP4ZEOEb1Yzgj1Yr8T2l+MS9BNL8MnNP9BV5nIrEZkqWp8UtWrj9gD7JSebWX0
	 vSxzS8H+1D50IeGC7shihQHwKTokF/o+oKkKof1U+svS9OY/OAJPVoYkxvzPbBOfnU/A2
	 viwfutPhxp2nNTSgvlzS321Jw7bV1S+m4kTEBboLjh96E0P11IRs+ldcVV2u7GqNVa56u
	 ZTmTH9YlErfyOt+YPtYK23wQIF/yuH3hNjM4nSHOzpRoMWPlH/LOjN5/0+xnyN4Gfkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFTWogW1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775E60A2604
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFTWogW1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6EF1F000C5;
	Wed, 18 Nov 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020047;
	bh=fjFwz2k/9z7X+npL5cIIuVFQjhA0gV/71LTvOT4OmiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFTWogW1kpIQSAqAl5ZPQsqsUCZzX/g7FhP0cql1kqn41G+j/0cCHoXjQW0P+0DsK
	 +BSlB6lxT17JqY6N8mgQqJcaKEXwLX0mFaYZfgePTJI+X/udvDllgw0RDWJ5Gbg5bk
	 v2ZwbzzliLy2uD9oT6ndI0eJO7YGbi9LYLBpeWLYf2dEyDFASxJSOwqp1vj8YFRq9C
	 oH52T80NYwu675nRY46o76N+GzMYcnOo56w67R2Wv/Y0pUunin4ARBi3KIxTq94qk/
	 cHodRir1xIl1Csh3r0V+jLb9snc7P2dOO6iYt7jpYKYMt3Hxwnr9nDuNWqG99yh/Na
	 tpM2Z+U9RXWoA==
Message-ID: <sashiko-outbox-221527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/34] perf jit: Support JITDUMP_USE_ARCH_TIMESTAMP on
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-1-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-1-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:40:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> CLOCK_MONOTONIC can't be correlated with timestamps in trace, so to
> allow the JVMTI agent to be used with SPE and Coresight, use CNTVCT_EL0
> when JITDUMP_USE_ARCH_TIMESTAMP is set.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D1

