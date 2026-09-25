Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B74C2259
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364399; cv=none; b=lMT9dO99pBW0B0k1y2RaqD4vcwbLIEIWwz0kuuMOIk1ZSJ+1lQj+88Y9PK+nE/0BZj08ovx5YX3VcFzAYuY+L8hEUOfeS73aP5H1dy4UUlFXOlVZVJjiHhd8BW6FKc5BJ+WZiPNHO+Yz0qqrt+s47fCgulrwf9u3iEb/AVpRWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364399; c=relaxed/simple;
	bh=ATN1uv3z3au9wPvgx8/y3VLT2KyDA/jci2upg78iKIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iwOL553mdY906d4OYtp0r07KO/SjF3jVDBeIkyQ0TZe3sIjFEjxxeqU8Y0U1Jw0Y+SxJi62Bt1B2E8XMFTJZCuh68zzmRKs3hK0THTMhMre2mLA02XzM/cpm/kCDg3oLMoWdo29CYPVp1E+9DUBFx23nuZSoNzyh0ir1Z3ZWXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2+UCN+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2+UCN+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA221F000FF;
	Fri, 25 Sep 2026 19:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364394;
	bh=ATN1uv3z3au9wPvgx8/y3VLT2KyDA/jci2upg78iKIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V2+UCN+whWVAT6uI+kKQLYTT7xjkgMgcQJlL00uPmpEvl1u1nHk39aoXPzTFXPTdW
	 +C3Sk75KLcNUHf9DXCTlVoE1r6U1zJ5gdMa+QuBr/0bQdgIglJS+kblX3yeGz+Pa7U
	 vFijRi4gcht80ouhnMnTmTPUVPUPbogaLi6dKa4Hehqf9u/3ah6RebeANz0621Lom+
	 Is7kskVqSiCEqcY9z+M/NmnkSWq3Pn8iFSaYQHDrAW7n+Q4WK1c+mQ8xUcEuoSGLAT
	 6NurT8/1bL1z1ii+WJQJpGRlamYkKpCw69hkd6jvQEbXg1xE7fT/hsrjz+yOEZpK0B
	 sW8srdpk4+5rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] perf dso: Allow reading DSO data from an
 explicit file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925-perf-symbol-memory-send-v3-2-3e4e234c363b@uber.com>
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-2-3e4e234c363b@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:26:34 +0000
Message-Id: <20260925192634.9DA221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> The DSO data cache derives the file to open from the DSO's binary type,
> which can resolve to the runtime image rather than the file a symbol
> table was read from. With split debuginfo, offsets taken from the
> debuginfo file (for example string-table offsets) are then applied to an
> unrelated file.
>=20
> Add dso__data_set_path() so a DSO can be configured to read from one
> exact file while keeping the data cache's descriptor eviction and
> reopening. Such DSOs may be owned privately rather than being part of a
> dsos collection, so drop the assertion that every opened data DSO is in
> one.
>=20
> Add a DSO data test that reads through an explicit path, closes the
> descriptor, and reads an uncached offset to exercise reopening.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-perf-symbo=
l-memory-send-v3-0-3e4e234c363b@uber.com?part=3D2

