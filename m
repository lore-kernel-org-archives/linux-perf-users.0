Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766774;
	b=Mm05Uceu5Qy3AKYoDxr8TJDqvWNGbjJ9Wvn8KCBtKY5bJKkQUhBElwBbOMWbakApPiTN
	 5eAlSVwS9koIG2ib8M6iPgnKJJksqgK/D3AHv/0HfU0xlCiNdPQXn80AjbIEUX85szy7I
	 0wdgoESeFaQN2ODYrxu5eB/gcyExMhcyDfO8dejbf++u/idrmbRELnbY0br8pJxMIHex+
	 AiMBX5upCQMqkjW4uJfhVfkG96JEYZWrZol/UPEKTWcaZ5AtXmsT5GppSs8pMJ/fFoOUm
	 lz4PznsfrAQQelUV7kzcirojuV6CIDwhAS04GLA6GH5XHxAG5Y+vBQ54RDL/NhTlr0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766774;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nYdTU4S5V6pp2RQUhpf1AAfGuKns82ZODXVVfu4ScG8=;
	b=zZEs2TIAqIJonHbmSG4NojzZJfR3WDU3LV5EcXzmeMXtDjUIHzPij8IqP57v68Jyh5O/
	 8Xq43flXi3JW7K7O60pmQfeh9QQT0uqI//DjfONu2pZvA0OYT1RyI03/pEgcP3QO2io+a
	 OlMTQJPuVFgAgLa2SSd+jvV8NcFZWgZvQkiPetloU4+YMj0ym/9mWgMIhQku2X1fLZMr4
	 /Nw915yokHhQZd554cnokFAjogqJHSwHjRIYeZ2FhJWMtSXLg5B5UJq1yfJ96uNxkkSwy
	 t/SeC4+uwwV7r8bcpo0qrxHHOitk7sJMRcdptQRRgb/YI4TY+Jprjh6V4S4Hcyos3fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpuPLo7J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789B606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpuPLo7J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95D31F000C1;
	Wed,  4 Nov 2026 04:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793766774;
	bh=nYdTU4S5V6pp2RQUhpf1AAfGuKns82ZODXVVfu4ScG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpuPLo7JXMLBWCAV70VfMzvY+Bcc/3GPpiaYPK1DaCIYz7w/5N2pruJB1uVdMdVzG
	 JURlKQmJ1dkUex0APg0HsWC9i5rrnA6oauB3RzY/iPA+PUMKYyb9wuYLZjuN1OhONK
	 5rjD85buER5mnJlLUI+HnIHaAMoIlij4QkW6bZqV+xQlL+1cGutplq1XPJtf0Y1WMz
	 Sq+jbrhRW9Dg3c7Y+YU+1ld5i7tXKhTYIOj98SRjOAZ9SZq9KWZzHbyA06W1LFWTyZ
	 c9UpJeCFz6/CE8ClgbeXt4YUOmw8+DtZm7hHyBwHKUZhG8N7JNWJB2V8hh6VTv2yJl
	 2zcBFfB5C2DgA==
Message-ID: <sashiko-outbox-196654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] objtool: Add explicitly sequenced -lzstd to
 libopcodes fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104043006.1199857-5-irogers@google.com>
References: <20261104043006.1199857-1-irogers@google.com>
 <20261104043006.1199857-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:32:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Distributions like Fedora ship a statically compiled binutils libbfd (an
> intrinsic dependency of libopcodes) that uses zstd to decompress
> sections.
>=20
> Because objtool resolves host dependencies sequentially via a manual
> HOSTCC shell loop, linking against static binutils fails with undefined
> references to 'ZSTD_decompress' unless the loop probes for -lzstd.
>=20
> Add the '-lopcodes -lbfd -liberty -lz -lzstd' combination to the
> LIBOPCODES_LIBS fallback chain.
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104043006.1199=
857-1-irogers@google.com?part=3D4

