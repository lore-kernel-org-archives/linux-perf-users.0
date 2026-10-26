Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020461;
	b=Qxz93/5rRd0rrsoGjun+9uevzbrEKrx+TLLLwgiPKKYUoUrTSMlUvEQ95Y6H7roRe3hg
	 A62/R6oGbsMH2LFpbCyCcfOdCF+lppApS3o30WHh8xCVFDevSuknv0MjCkIbQY/vaFe4J
	 WYg9cPf9z7UocN8hQzZEGxdunqoZuR9d1JZHEErI4uGyRlKeFmdXy4L9T9DYDhGaVrrP1
	 QGZWGAslhNZIJG8P7Qgc/+o+myOFHBysIll8eerPz2ALPHbOT+fer3/G54GTzyNvgkMW8
	 u5K63JHUsLUcqKJ6HjyI9142YLxYoiH3rlNUkBMK6ThzcdgY4TduQb7pJmFDG2f3Y+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=958NUJRg5fKdWWf1W2B1DO8joKhBzRmMKQAi+3VjLIM=;
	b=UZCpAFdJkwTwyL0o2eyOBsxv5hbKhaHmwefGbyCsobe3Q7LlOfC9eR1H8Wk3xTacKRNF
	 SmsRvd0glC2maYZyrWfczUyzA0e+K/tFDHTAadviqlOB7MmAgzM7M/VpOerXRQUj7SJa2
	 tgbqPqwhl3TVdrxmGY9HUnM6Mbv7ywTLwYKG0S/9b3WVd90tW8PA/PfHl888eqb9tiJjt
	 qrY6zr66/reaF81l7IFTnbaFp3fnotkasfTzZfw0G5sYZxXV0k4GNWaNXO+s++m0rweuk
	 0eiNSQTjBd14MDMOu+xeBh0TIL82LQ5Ar5j9E+OoK1Efc7+2uriCcm41CnGffaVUkwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crJcZDfO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26A606A325
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crJcZDfO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C991F01825;
	Mon, 26 Oct 2026 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020461;
	bh=958NUJRg5fKdWWf1W2B1DO8joKhBzRmMKQAi+3VjLIM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=crJcZDfOPNKQM7Z4xuBEMM+uIa9kxJ4QPpBEGqmj8XxEWYMfxXFbj3MJW0th1HSgO
	 JidoEaFPZC/8lsw5HkoPrcuC184F9Sk6tE3DtMtOWO7BcraH2nM6VHDK9rplGjggoI
	 UH17FLwkd41afToiMLMkW8Jh2brVEQdZQa9jjA8gENFQI+TiDAzfpF1sTH3XaL5/Qc
	 f9pwXr0dZPufwzSe2SiFsyQpF5G2oFazSWfH9hnyE3Ky4g6jCJKeew7ltI7EjAIcqy
	 MOE5gflFlshrgbvmVm5KRVuWdnsqNmxiSp3msu7JwrHdYRni7XY3EvXPycG7qsHwPR
	 RiEKhiCNvr+aw==
Message-ID: <sashiko-outbox-185293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/12] x86/msr: Simplify some rdmsrq() use cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261026130223.773129-13-jgross@suse.com>
References: <20261026130223.773129-1-jgross@suse.com>
 <20261026130223.773129-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:14:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> After the conversion of rdmsrq() to an inline function some use cases
> can be simplified by dropping an intermediate variable or by
> eliminating the inline function completely.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026130223.7731=
29-1-jgross@suse.com?part=3D12

