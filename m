Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827368;
	b=sRLjKpHr0fzzsWElfUUQehude46//YHIgpnwN388JfnDx6wMz/95Abum7KxTxEwDw82B
	 oibIBTiDegL5157K4E+mfuzbVRAVGBoJS6zNKNOGovPK3a0z18LuDoSwHlmDxa6xfRDbJ
	 au7a1Pw+/z/EeLk0NdS2kE1cinL+C+ompI2RXlUjWggjsAocrcaIOy/8MborBDQPtTKST
	 +YIK/8KKPZzm1y4YMcAjoWdhzNVdL7PGImWHBt4gGJ62hzx576VHZR/15YdVZt2wUG4M5
	 DXL5SegYVIjeg8REnLTCyO81D3Iq+Y685gmT6J6kiSpA8Ycyuhw3cDlIAhUSee7k4XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1Og/bYOe5/UxKsOAVu/Lnfbq3O73EaIJ1Z8uEMDi3Rw=;
	b=fmsTYbC+tallC0zxRjO5823/BxYojrqx66/OLFkzvP430ayObUj59jitXJSkn5axV6SZ
	 mH32PDhoQaKfIzKIzPmqSb2Y5JoEjnHE7Xn9SZ/QtpltwD+FNeaxGkfyQ16Rn+yZb2DHb
	 Qq/bQ8rnbW38/lk36qraaR1aw/rJLm0uc2b+3ezW4T8En/M27+wC28UsLyECwJNbrG1j9
	 M0DSq9nZxRz/BJrhptb8yChymM8kNHxOGPH6Yx5loAwyeh/vI9Ddm4tLOapMZHj5cAtb4
	 8RiSRztGeo95dMmMw3u+DWM0dlRUXgGld/tShGFINTZGCbl+96c6oW/ITKzxxNu4/og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKDv0N7R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDC606A87B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKDv0N7R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D831F000C1;
	Wed,  4 Nov 2026 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827367;
	bh=1Og/bYOe5/UxKsOAVu/Lnfbq3O73EaIJ1Z8uEMDi3Rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKDv0N7RiwFXdsUVinqW+R1Mu8dmmLwPkFXsfR7oIcpQBSilVpTBEO7NEF3v47t/3
	 mRXm4rC0eTmpdvF8fo85QVQxmdZNJtKu3gvyZFa7vPXLQVyJAF8F+xjau41D5ENjrb
	 kjrVJj+tK8XNAHiyhvunohKqsGoIt/GTQMRR56+2Vuh1zE6hja3hHAn6nvHXSKyN08
	 IQP9R/R4KVyeWemqSkroeG4RaEUEA+C4JMekkgOkEToS4wG6ijS+HvVJvJ0ArlgKCE
	 +yxMmfV47BmcWFYGaTwoYMp/3EHke4DAolOzp3ZoU17En9gng+LWZD9Swx9rpTniCp
	 NgSt7HBEqoSoA==
Message-ID: <sashiko-outbox-198108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/19] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-14-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:22:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate dso__data_=
open and
> fd_limit in util/dso.c with __guarded_by(&dso__data_open_lock), and
> tighten __dsos__findnew_id() and __dsos__addnew_id() from shared to
> exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D13

