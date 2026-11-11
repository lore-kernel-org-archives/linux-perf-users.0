Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424291;
	b=BfAhHABSEF3ac+6FGaSb+PFGsqq+w+K2H3oK0vvSNT67ErJJeH60prdqHpbWvNgB+WGI
	 UFEahtNhxThK0j91phLS/ejwfvOIRg0lsZY3JuV0ReOx3nve2G9uLwMyXEpRRw0gZcIpk
	 k/GeEhHM8zrG53n6Cr/2y3cDWREVa/XLuDoqKLtE+EFFt+17XXEipf2jCgCE0Yn5Vz3bK
	 HWO0Ar+VAIRbhmY9SN/rr9PlLJtrhg6KjYI9TrmbPixrT0coDqSzoAoZ6OvZann6UBmpv
	 2pn74jb70tiV3MT2WljlmMhWMHf0tgBmdZUgNIlfouQZUNCZ7ylsvD9UZg/Murjad3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VM6arIkzcKqjwV2N/vZ45pdwKW3OU5oCRKlRQgxCvak=;
	b=HlwxxWWxV9pXoPYmG5EStQpvKSg0ZNW6F3hRrXHomxaCUILwQZymzp/dGEZIpTuFfQff
	 EUoeYb9qTh2IceoqhtUXZ7U3SU0id/tYAFfV8vL0c3zbwySk2oPY/L/Apu6TJhLTwY+RH
	 sNbGRZUCAh35+trhF5XtAYB2b8iZk5AKTexa9hLuwlvQ9rnCyDI7r/CsdFoy+qhf/n8G9
	 8yT+fnfKvAbZiP4g1832vaKdsTV6rGxPNdjj0OmzF9ZbcqGZa3YI8q5c95Wn2rmxheZV+
	 OH2SbjXNXLC0HgvBGMT7oKXEbH+ZwKb56x49yRxfllpy2fIJsk4I5AF+uxXrZHZhS/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRI8VegV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E90606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRI8VegV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B83A1F00A05;
	Wed, 11 Nov 2026 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424291;
	bh=VM6arIkzcKqjwV2N/vZ45pdwKW3OU5oCRKlRQgxCvak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRI8VegVbTr3ByWd19YIzje/p4K3efUK5g48ZlSNRlKGRbmQjWzsqJMRqnNLyiOQk
	 CTFhi4gWoey9khUfh8PppmiQaS9bfT7kTHOoZlHuNQErazLrzLV442anJoNp540oKS
	 jb56vTHABsoSG/OrxDGVCHT/pDXqXwS+GfslP0t3IYRhnvDk6/PMm7cqCw0n8evmP9
	 H74iirxBis1C0K6oU4/tlrmzLFlBFJ9EAJR8l/LE3Csl0WmjyilAN2/2ge4S+m7761
	 WiHdZ1ud29sdHNHWOsasRRu5q+fdAndgbnuS4YXexWSbvR3O9pZzaQMOGQoN/B5zP2
	 dAv2kdmFdMfLA==
Message-ID: <sashiko-outbox-209537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/20] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-4-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:11:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D3

