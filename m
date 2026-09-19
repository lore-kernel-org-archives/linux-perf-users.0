Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E03ADBAC
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780178; cv=none; b=JGd1aeQHsmA0GPWMjryIhYLLolyimauR/cTLRZzborSDx3oVIyIPeLt9mAulD365gg1OEYHGJJsFcxQLm8prF+1uXqIh4h7KhtJZOQ/Z3ojVGPQJ4hDXI4FryFmk94dKkUpvhOzzstEPmllS/MxnHJgUl0fuI1BT9PXKJckopHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780178; c=relaxed/simple;
	bh=BMuWCY4yXAauCym+7uQL2lOmHUrEE68Ys1NhyQyy6d8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZcPlJLDdepkeYYyd1FIS60Qwm1RFl/mRuObU3wc0B2G1De1a8qLLtxI5YKJxSvOLdhfzZ+8NgCEJM7d45BrZOgUFR2fMG6u0CIT4vRDXdCrwGLw0PxUd1BnGcZiGn1FoqtWa+PIRNrTVld7EcbR6hReWHBGoT+TD6Q9Pwkzyojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P75Le+yX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P75Le+yX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292ED1F000FF;
	Sat, 19 Sep 2026 01:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780172;
	bh=c6/eY/NPKNRIWRmF1qpdIqPdlmmqHRUjZ0yAbutIQbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P75Le+yXarlgabohDjVoRqwtUeGLIOBm/Z67bVzBGFNYZKnssZBSxI3uUgS8BdNoQ
	 4Hr5xToXNIU9k3B8aw7pzqxEdu1KTg6Nl/DDY9vNXkl/yhfNRE9XyVV/3JFM82So7p
	 BAhILuHYX4GJIVMY/LphDMrkMMbHueA/7KYA4hs9EAcGfq63c8ilCIaOLefBOcAdNl
	 KGN5jy+OyCF65C2yPnrawLMmx/JI+Ot9KAZ9RU1hbo6w5lFsv2ujqtZt5JjEAIJrfL
	 eoRf5FUiHGe7aFPXWl5nFna5PfW71RGfwnXnGqHbH/DIp+yAA3telm/SkCzVlVPq9I
	 tGZpu8Ae5VGDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 4/7] perf trace: Validate payload
 bounds in augmented buffer beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919005530.728615-5-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
 <20260919005530.728615-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:09:31 +0000
Message-Id: <20260919010932.292ED1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919005530.7286=
15-1-atomlin@atomlin.com?part=3D4

