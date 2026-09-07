Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A322A4E1
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746845; cv=none; b=qvLqnclx2ZmGjJmrYJ3Y9lLjU71IT+CbnkYlU37PdmbUmcu2YmAf+KG72B8kQ7TwBixWc67796Ts5CrSB6MU1ZHbA1HtTvDVS4Wor6wMgwumkMKBLFqZku4w7ZS8tN8b+2M7RbwgSs16cmCVnDtio1ltYNgWB0L9Id54qtNaRkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746845; c=relaxed/simple;
	bh=wVjN6SpQRyI5vhf3pP+alCjb0RQbfn45wwdRLf9aiaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O2CeANWOK4wxfxNENSjmWiPGv6/d7lQkG55I8vtoq63Rpk+0qMigbYBnzw2/PaEMxqOsglJiDNNnFnk9A74ksBSXdiwHLhbnX3q4b/SpjJ76SJ9Ls3bQydNzPio7JNnkAot1oN1vf6EOMcH4jTtGgN/yyUH6Lqq754SmMiGAo5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J32bfGrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J32bfGrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9251F00A3A;
	Mon,  7 Sep 2026 02:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746844;
	bh=zNa+OKvF7qdR3jQB1ykWv6VS4V7M+a80eOA9CLACous=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J32bfGrjdvL1iZlL0GKMJndiyPkjnntE2neHcuvGfMX3N7xkBAeb2H66KXr9xh7CZ
	 7gZmlUD45Xn8n/V8BPaI540xr18Pqhpya1/ipj6QiqfrBJcb85o76P3D6efSYsYIRm
	 +X6JlFx1NpMr9mvFQny7kkCxPprx1CXtzS1/B8X6RivxLNMvoKbmJBsIgPrOjfszMs
	 rOzz3I7rHVxTxp1V9gftDhD7htu1cLi/UyAQnpPWI8c8hUgseYk3uL2nvqoKDcDPgr
	 I4sxPzDRuWzbF3Ikk3pZB+9xbnCjp+nSfbB9PymA9n8+6QYhVTZH3B/UgitZryRxFZ
	 eESfheDFypEZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 perf-tools-next 3/6] perf trace: Validate payload
 bounds in augmented buffer beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907015140.363076-4-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
 <20260907015140.363076-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 02:07:23 +0000
Message-Id: <20260907020724.2C9251F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pretty-printing non-string augmented buffers via
> syscall_arg__scnprintf_buf(), augmented_arg->size is not validated
> against the remaining buffer size (arg->augmented.size).
>=20
> If a malformed or truncated perf.data record provides an invalid or
> excessively large augmented_arg->size:
>     1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
>         dereferencing augmented_arg->size reads past the available
>         buffer.
>=20
>     2.  The loop reads up to augmented_arg->size bytes from
>         augmented_arg->value without verifying that they exist within
>         the buffer, leading to buffer over-reads.
>=20
>     3.  Calculating consumed =3D sizeof(*augmented_arg) +
>         augmented_arg->size can overflow signed integer bounds or cause
>         arg->augmented.size to underflow, advancing arg->augmented.args
>         out of bounds and corrupting the parsing state for subsequent
>         arguments in multi-argument syscalls.
>=20
> Validate that arg->augmented.size is large enough to hold
> sizeof(*augmented_arg) and that augmented_arg->size is within the bounds
> of the remaining buffer before iterating or calculating consumed bytes.
> If validation fails, fall back to printing the raw pointer value.
>=20
> Fixes: b257fac12f38 ("perf trace: Pretty print buffer data")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907015140.3630=
76-1-atomlin@atomlin.com?part=3D3

