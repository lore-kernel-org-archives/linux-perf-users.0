Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BF4E3259
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172445; cv=none; b=L9B8Xn/wz73fR4G9HwtgnA6lYbF71iO5qcY/+UBU/+SQv2jceuUhSDumCmdcXKM0MTtRC9PVZT/8x4o0NmPMJXcVTVJzmDFG1LV034Q1PCJw6ZOCMX1OOckgcNkGQ40KEe3YunSjqLb9pocNCusHsr479xsyfLj4UefpGhVP8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172445; c=relaxed/simple;
	bh=XhE3aGKlEBdHvlmDu3iR3wGw1L4mldcmHv32wxw4AyM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oGn2FhXcZUv6ROs3eQwudy2F+CMVGRo8UD0aboiTYaV3rx0xPCfKr+n0KJwpkwCui93abLxWHqrYk4++qVHMyfUb3S727K+N0jXyMbGR8Vl0InOchaK2FuUq8gUmoneg5oqDuVjwHOWR4VT7+3Q/POJVsV86DI605clRzjLXeBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4xatqVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4xatqVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7F51F000C4;
	Fri, 16 Oct 2026 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172444;
	bh=XhE3aGKlEBdHvlmDu3iR3wGw1L4mldcmHv32wxw4AyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4xatqVnSG6ai5DGjiIH/SCSY/GLT2xs1ycTLzIJX12HUIYhPIwsURsto8UBBZtPL
	 9f3+AFn6ehRkE9VB8tZAPcV65rmpnGxxZAiAVmqZiHfF8AIThkVHftdC3CtS/SewEV
	 rxG6Yc3bYxtrdtZ5waZrM1TCNcYJ6uvP2pVblXzQ61oOmJGJSItf8fWuOOuHvPF2p5
	 tD13YSqWscaREMvyLzYZbtYPYbRH1U4qD26LdxygPOBWK5dMyeF+6PJ5DPSfO14sTH
	 C/8A+3hu0ZerfmDiFtS7IFARpKi3z2GKK7M+ZBQTD0gTDN5FjxT4eB8ZxKTbi+/7n9
	 fne5c2qlAfzwg==
Message-ID: <sashiko-outbox-174731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/17] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-10-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:40:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D9

