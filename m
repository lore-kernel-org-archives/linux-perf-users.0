Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949033;
	b=E3Fgd4Tzjp38AXSghFMnAiv2/R3BW4t8XhBNKtjO5KIaoHkUVyho1jdcsEbJ8lDSEt2L
	 Ctqdh0ovNiwruX10a59VAX9X2ksO0Y6SF1G6LcARYeIwtzmXRA3X6SgGGIsZ4SGJLSFl2
	 r5TUDQKzGbqV/J0PngIKLQj89jF1req/ymNJrC/YqiPC1QMh6RYUBcpqMei7d4ubHmaiY
	 gcrFMBQdiL1KG1L6Jz9Jzs6PtrF/Cjq3JHnesVnfbtk3gl2LSAUU8gJ0EA6J5lk7EiqIq
	 xKX6V3mk+H2kYtVCCg+3zEjxlGMSkiLfOc524D8/rxj7f4ogEUmkrroh6JUXEKg2iSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949033;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B+npZvmNS1suqfofNm5ANgGZ8ptVdTtCKQ91BElOAeU=;
	b=1h0SWrBrhUgf9NYshJnENB4OkfSZosV/BElMIhpQ2cMvKk/dXjoGXq23bGQo5ttmMskA
	 vph+mXH1b0TgEDavRJ12+s6oTGP8GvjoaUjLr92kGRs/9Z0e01wwrDAqkxX2XHEhWPpAW
	 +wvzMiNeqQDDzRKoLFlHmZEOf6dvswq0bP+h0A/5rzsTOKvmCM4yJqyi6+YIuPD++4V6q
	 Qns65tae19TYcF4qz2EVSMhyYzAA2D1wkL13aTKgHb/ZlEqM+0ezdSAgWH7R+KSjbGwY/
	 /62aSXalRkJvn9Mg/23LHiBPGnOeeOTkBb+NZMQhvJRVcvxqxnuDq65fbVpyHG1UvNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToSNfQ6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC1606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToSNfQ6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3661F0089F;
	Fri,  6 Nov 2026 07:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949032;
	bh=B+npZvmNS1suqfofNm5ANgGZ8ptVdTtCKQ91BElOAeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToSNfQ6nNqGpDD3EVQT6ikZoIjwRyDZsquv/qE3W3h7ABRob4JII8Id1YAfy9vq5g
	 oxtymsRtUFunfkDJ6WIoNkvvJUns5ZxEEMhBy8oPNuIB4lvuFuHqi13SoZUZ3AcYu0
	 wKNOc/EXZuQqiw6el0ntNSL5JOsw1ivSMGD0PFM3DACMO3j5XVDzIsX0NP2FFlgDRC
	 0UlXqBQoLXxcXJgD0ip8LMh64sMVEyLx9flRQAQP2LOqrwWuxZ9T9UTOCpOlL2oK8q
	 ciqcWrZwwpiqgXIV3ynFmuXaSWPyTvAMPsuD3ysUfUS7WfXESW9eSbZAImKnATs5Zd
	 /SATpZc5Yfdxg==
Message-ID: <sashiko-outbox-200965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/20] perf dso: Pass dso_data to close_data_fd()
 and dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-11-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:10:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D10

