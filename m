Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988720;
	b=2HmI/BQ58pxeayTiwYvT8Iz0wWi2M2xoDCpzYCgzfIkFc1wD8qRog+IZu7jN54PF9bbj
	 zBWNc2my5Y2+WZlCh9WOU/1npsijt51X955NH8oTeKi+1y9bfgxQQx8AiFxdnPRpMYUo+
	 fStRflm0CIAwtkTUenvsYvD2RaO7EZevHNxtFaonRF/F/jL9Zr+EISlv2ajIsS8OYfTuj
	 b2T0c34GRci94eQ65IhMNRo2D8LveCGGjv7W2elrn47WXX6NoQk1OrOzpbvi7zbDjGrKL
	 xhZOIwZtVbO2Qgbe0nde0V2A8dtYtMd7EkLF+zqPmpW/9rslnuvz0JTMAW34J5P3+vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HGhgY3LA/xbbI+AqZDEHwXEpQefGr8DgywNLcfv8wTc=;
	b=WAju66r/bCFRqV3b8OwZfTA40BArzO71GjrQoQcn9iltUhbynlFT9IfnO7shXgK/3mI7
	 2Y5VuaLI5KkT5GlPXehCPikmwVJEwkbvOpBQkEaGu0ilxMjDAPX55gkic7BNqywbtSrMn
	 932LoXCWmp6WkF9NEQlvXBS1g7CmfdW7Qk2FqDY9ewEhjrH6pLTUxavkb0xQ2E5gF6NAa
	 GUCj0L6xPGEYamOboZkBgOM7P7z2QwTTpjT21oq4lDAvKforRWcfTTIucDCIimnL4kOqX
	 R5xElmnpkdOe8nWFIJ7Gv4I0npPGMoIwHdaf7j7Gz/EfD1Me7l8Gy+bjlO+8iCQSJOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZZ+3IBI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6F606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZZ+3IBI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ADD1F000C4;
	Wed, 18 Nov 2026 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988720;
	bh=HGhgY3LA/xbbI+AqZDEHwXEpQefGr8DgywNLcfv8wTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZZ+3IBI3qnp8drcqDfDfDKxdI+jlXvZlh8FJm41ivEgQ2jkajJ659PTwVK3/t5aO
	 /xBXGIihkonCylhHYd/zu9v7lJV8hOGlNI9ZG6Tjkpq6LpQOKzcOIzTKkh46kFpi7b
	 SVjveEnDficZdXci3IzO465lthqo5bt9/b2gSTsj2QQ/LoXd55aMOFFTi3Tz8HpIGX
	 6g5q4Rp1jF/YdJgT7ylEI5Cwxz9o3Uck9k/Ps/axxGppzEG5zlf9ArKri7q9de4yQP
	 krWtMxzomQeLtOTToEekUqv9QxE6cE0aKTIQbcZg9jQaz1wDHAVfdnwhZrm64Crl49
	 JXgAc4Djakg4Q==
Message-ID: <sashiko-outbox-220393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] perf metricgroup: Fix realloc() leaks in
 resolve_metric() and __add_metric()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118075516.1278903-4-irogers@google.com>
References: <20261118075516.1278903-1-irogers@google.com>
 <20261118075516.1278903-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:58:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In resolve_metric(), growing the pending array assigns the result of
> realloc() directly back to pending; if realloc() fails after earlier
> iterations succeeded, the existing pending allocation is overwritten
> with NULL and leaked.
>=20
> Similarly, in __add_metric(), assigning realloc() directly to
> root_metric->metric_refs overwrites the existing pointer with NULL on
> failure, preventing metric__free(root_metric) in the root caller from
> freeing the prior metric_refs array.
>=20
> Use temporary pointers for both realloc() calls, freeing pending before
> returning -ENOMEM in resolve_metric() and preserving
> root_metric->metric_refs for metric__free() in __add_metric().
>=20
> Fixes: 80be6434c36f ("perf metric: Modify resolution and recursion check")
> Fixes: 46bdc0bf8d21 ("perf metric: Simplify metric_refs calculation")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118075516.1278=
903-1-irogers@google.com?part=3D3

