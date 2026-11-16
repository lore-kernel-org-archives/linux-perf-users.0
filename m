Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808323;
	b=dLsrfEvq372iB60qY0A57qELvhHWZK+UBXZoo1aoBBDQLuZBHpybL39Xgxz7HjYTrp12
	 G9x37zAujyqVAddtYwkzfSeYG+96Ad18VgszXunT938D2Abjw2xAj6Z97KkaPUsn+Sv7F
	 gIt81gsb7z4mRCP4OkhKMzNpNkTMruGRutYSpkHE4G+wgZljaoz3rmI/S5qMN9ZZyjZgP
	 LQW7I60G0TCAxeALGNe4h14h6Up/AaeM39lhgfO5zbINvJR6G+smvUPH9R/s1twP/KtCU
	 97FhgzaWX+qLtRyRgMHANP4hXh+p3w3bnUhWU/9HbrHFMaWfnIYPP/dzSPGs/vrmPfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fB47L/rzvK7Mp+wSUtYc0EeAvCHVchWBF8Smw0SXhD0=;
	b=Z15L3ccr9J44RZG5Ghohg08Wcw3gHxbvvVaHvFVME1QFpCXaaTaPCL8nmCavZE40sBGf
	 0pZ+SM6S7+hSZ4xZue00+p5Q59U0xv4XM+zZURh2MSyVEKRdblEYVvHHrLhGyuOOB/r6h
	 ZLhB3YGgfX4QUzjGMczaNwrSe1wm5Jb7xq0gT5QPzEezV3F+L/ZDWkigrrZdFSsTxcknQ
	 nqYgkl9joZnTzozAEQM1KLH6npAzv27kwmbxtme3acbbmRZGrFtFhDILhUtjwTq7kMolN
	 hv18ChaonNUJiBfEC5UVTJ5j8iZI/5WYPKP30ny3tbM7QXZe3B6m9VrPPWvyWANfWqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2lwOvLJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA3606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2lwOvLJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626A71F000C5;
	Mon, 16 Nov 2026 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808322;
	bh=fB47L/rzvK7Mp+wSUtYc0EeAvCHVchWBF8Smw0SXhD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E2lwOvLJTDHQYzNYdkwTzxE76JiIOoZLVYYEvEO7O+zuVFNJwAyZ19wN4PKBq2jJU
	 qfW/mh23YXYU7XaHbVTFJnzwPdWPmJBu2HTNh5cO5IbyaLa1AZOFpXh3TJ6CXi//dI
	 SbCkLSa2HKUSgvtnT3eLACc+a3N0wmdvx+PCye9i7MIx7XdBvmKILXRVItVH58Q26w
	 2ziv94OmRT19/PrFJjbmrhtMsl0gkBUUyrHOwgRIpxzc4ZfwjvRub1RXMMJywSFqSW
	 WEGbnK6tsSRD5C7cJJtGk+bWeTld3hPe2lqiWkpn/tglgBi7xuyuXLYiPM8KyVHjos
	 XKCdOP3We0CzQ==
Message-ID: <sashiko-outbox-216231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 10/11] tracing/wprobe: Support BTF typecast in
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179480686808.38065.8907197983948637551.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480686808.38065.8907197983948637551.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:52:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Allow BTF typecast syntax (STRUCT)FETCHARG->MEMBER in wprobe event
> fetchargs. Previously, handle_typecast() rejected any probe context
> that was not a function entry/return or tracepoint event probe.
>=20
> Wprobe events use $addr (the accessed address) and $value (the value
> at that address). By enabling BTF typecast, users can now cast these
> to a concrete struct type and access its fields directly. For example:
>=20
>   echo 'w:watch rw@-1:8 dflag=3D(dentry)$addr->d_flags' >> dynamic_events
>=20
> With a set_wprobe trigger pointing the watchpoint at a dentry address,
> the resulting trace shows d_flags being accessed at that location.
>=20
> Note that $addr and $value are restricted to kernel-space memory,
> which is consistent with the existing TPARG_FL_KERNEL flag used when
> parsing wprobe fetchargs.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D10

