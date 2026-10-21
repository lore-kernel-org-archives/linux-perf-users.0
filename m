Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603305;
	b=iOlt9+hMT1SszprSNFV9YIP44WhQ3kH9yb1ui1IYriWCp09M+QdKJGdrJnx7Bgx53TPM
	 1HqEAybxC1MkHRp4EO0b/x6lGlqjyZrmFHNWBVZHXEhFQXMKcRamZ3MAcmb+MjJ2kUvdV
	 9m0lAL1NaN/wh0OmjzwauJD13OhAKyFJLm2EczSKX9N1Tk37X8WDs9+vQc7ERKHocUwzQ
	 zLF7R+EQmk4J54yt8C58Gjq4IXy9bhSaE16gnyIDGyBXEfJP3wLqIX5ofHgwFJ5wLjgdb
	 7fwamgBN48btIt2IfqNgvx/PJjLVYKJBfAbinpOwaDF481egC4IA5FyN9Oh80OO544g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603305;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sVH8cqc2dNG2VyDnpvOEKlIokXsJo0+VzcDR7KoHOSo=;
	b=wIwiYhfZz82TNKOkL1ajjyuMJBHPf1EowNoR9lEtM5PJinbgA8WwLvahvmwKifo8cpwK
	 5QRcjo491RaSIgGA22CblJvhJhvKrBRCbQ5lgdKkVBSw0+dUKRi2oocoOLh/ta/z2hazt
	 h0TuKzNQlNw+OPX+vBeZr5zIri7p6BrS7PQIjbHZrPIV/8VMpzDM3erao/uhW0sGzn19S
	 feKXJvSxcJIc7KxxCD9qLNC51/7vB0sAzZTFQjDG11NDpSQcYOeOUjg8R8t1eIM5VEg6g
	 EeSDSSRKMByiF4/HT1eIZ78zoP4lpQj1KS6XVSY1HKk473jvQdb/YrEOThkjYuMUYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWuWaU3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3D606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWuWaU3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D111F000C1;
	Wed, 21 Oct 2026 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603304;
	bh=sVH8cqc2dNG2VyDnpvOEKlIokXsJo0+VzcDR7KoHOSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWuWaU3voV4Z15wtIZCaN92MD8SZYE9YVH1SL2/WsOwh/qx1zah8Kb/7p+xhQS3Uw
	 xEvI7iBfGWSfWCTmLyREpKpsXAzh1kTwZD5RfpvNpRYZqEJKJooKXD0FGt+UGG3gS1
	 3ivk+lZmaIk4BTNbVzX/2lCztOS3cfIkKuZ0Yaxaz5e7JCJp6z6oAheuqFBFfL0sqZ
	 gERW+G0lyptVyzTmq9LpnMsKhkuIb/rC0T9n4571eSslKsSX13uPZDAf0fsT+YNYDa
	 Oxh3hv0uZC2OO2Zr2Qnl64XG5AzldWxPu+D0aIRbGBRWzFnFnnI5WBX/tJ6lvWPB0F
	 iD8zM3A1T882A==
Message-ID: <sashiko-outbox-180515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/17] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-3-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:21:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D2

