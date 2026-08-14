Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFFE555
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666058; cv=none; b=O4nFQn+Yv6CbFqmsHmItwZy+YpUZVLDIBkLjtfBZlTjyUO7/x2kj9/GnFobRF9tqZFewZ/BAHZdtPPy9WKGbRsDZkvmZ4fdx934oJ9XnVBp7I4sDOyB6fUaoAGTukD51dvBnprVUUS8D3yZeyIulcQl87zGiBsyZhbDe1hEAnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666058; c=relaxed/simple;
	bh=3Ql3MaOsrDN/W6t3fUs7xSceh27h6ZJT0wAa/4llQ9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZdmHaFwXYOJdawRLsXeeBUB7n0GA7bd93wxO6jfPkIqn4NOJW5OlK20pffpiwYazzLTkLQepxRDec/UVGWtOLDBpqsOj8VyBuzD3liascqBzgY3BdxHybmx7z5gSGw8OPT2WNexUCLd2r5wH1wflXJCUiPLZKoHBHzQ1827Y+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUul/P2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUul/P2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438A41F000E9;
	Fri, 14 Aug 2026 00:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666057;
	bh=3Ql3MaOsrDN/W6t3fUs7xSceh27h6ZJT0wAa/4llQ9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUul/P2mwym6s2JQNGNc8lc4TTJDNuLAg3/3ky1O9fcdrLaBlisUtCp4U1ynVBN7/
	 TLCVjuosq2yvNBLBbuAATdQIxfSjOebQ1EGchAOSyD/6ONqSiMyiXKNFPW+1dTT/7w
	 mC+yN1Or5okPAgHhCAV6y3Ru7nXlFkc4+IoTPSpFRXHbVU88M4NzIa8YIwLb997z29
	 gPdZrRi6AmWXKtx44oy6ESXHaKELEHLSt/3WRmfLnq2i+EUWbJUmYbkCECi4dD8qUr
	 uOH6HAE+1KZUo9Q4MIn0L8mE3I3VyJ5fuaU6314bf1g0F9ap3Yvli8JZweGSykKS2s
	 hoKAWgilbGJjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/29] perf lock: Only pass sample to handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-8-irogers@google.com>
References: <20260411065718.372240-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:07:32 +0000
Message-Id: <20260814000737.438A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The evsel is within the sample and so only the sample needs to be
> passed. Remove the parameter and fix call site.
>=20
> Add an additional NULL check in get_callstack, as prompted by Sashiko
> during review.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D7

