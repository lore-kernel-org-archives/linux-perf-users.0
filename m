Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67B53C3C7
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172277; cv=none; b=I6B5AGVRdqDF1eBVGdqHk49FUEIGzgVKJf3gvsNClN2XKNflj7JpbfEqRJ7/TZ/4uO5tQk7C7wbCr/gLVIIfWw7ZljlD1ixB2ALjRK3s+U8Sb4YO48o7sXN58mMcDL76IO1VHRgpHXRcxv9+pWpgX8vVh3ZLxeDJgNx5PEKqGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172277; c=relaxed/simple;
	bh=RojEQvma5TtED0HtxGMqMyD4hjexE8H0wyIt1w7HghU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PwGzTv5tUa8aw8ih3MUElQWn2rj3ghIoGTSNiAinGabPxRcqs6FA8ueK51OU7aM7MFP3bz4drzaQOQrwNNphV4emt3205zKl5uJgUVttkvuJ4L9hRnxwbQdybLCY4tyKV6jBjXQyEIa9L3v3QX0+uZSOAqDw5mdcgJ3PUOxrL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCE4i18g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCE4i18g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438DA1F000C4;
	Fri, 16 Oct 2026 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172276;
	bh=RojEQvma5TtED0HtxGMqMyD4hjexE8H0wyIt1w7HghU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCE4i18gVX9RucYvzotWES8gKlAm9ItAWsGbkKWK7fs9B9GzOhsbYFB2xspk4zBZM
	 TjS7azZlskIWSkjkCTSsZcBXGXC68UOeeLZpLlzJ66eXPUoL/7nRuic6/g8O14K7kM
	 YhqPDieXtAeWbZovTntRFgPPpUeMev1fAsXJQBJ2gvNbBk+WFLo949ckrb2kjTO5yS
	 xG8kc6YPd6UgWX8HK5/YpSRfU4xb9B+kvFqNox+1NZ+hb0qDht1pgah0Y7k74HRjg7
	 vSwrp1MBp99h3Ive5gQkbXGfqoynlGdQOeQ/oUsnuYNd/mfmxIkWw8V6pRgll31S92
	 Cj+O9i+BGEVCg==
Message-ID: <sashiko-outbox-174728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/17] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-6-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:37:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D5

