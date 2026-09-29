Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEE4315A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644863; cv=none; b=TJt0WiPPHheH0wQHU3nyE7ZlaejGcmvIZbDy6znEepnGHENEZ933WCk8tHm0cUMmbX6oKeay81C8HNeuvy2efJ5k6WfIslqcXaXKTFx6fLd77e9O28YZC1iEGtN28MwrMyM0FL5FT7JtIPoME09B25ImttOSqYhHWvRy2Q2E0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644863; c=relaxed/simple;
	bh=tTUW7m2A9mmjOaliS4PXSzkpwBb4/UmLjW/ynWqsYlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FTZTuiu9Exm8jWp7Cqya676JvVLmVr3JVMJ99cJB4/AvnMHAdPQsvhcqemwE9p5FfIDqAHvRHthiZoVBru8fLqqIcY+d7Ygk+UYZf4d55PmNWD514gx0Njsij76anWoCKX1ZghUZAmdembmfXfLPEUqPQk2gMnPipOvkK0LaSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP72bIFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP72bIFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C7F1F000FF;
	Tue, 29 Sep 2026 01:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644862;
	bh=BdrhteuW+CbRzgXvUUATlWT4mDQxQg5BPCSX6ZkyiD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gP72bIFikq+86k0UcarGpS93n5QFoilpzf56mKBNoRJOFghpfxrltJxtoLdutYS8X
	 je8XuLRZZ8WgL44UUtxSs+4TJEjTaDOd9WLv7uiBA6Mi1ZgJLpuKDzdMdkCzkGlf0G
	 ynD5YQrJC+sMt8QNkkgrfavrZLglE1eP9N2C6rxR9K9un+xdHoEY7ZHqmhbY66TGqJ
	 +XKl8lPwwYzRRrljAi0odZGwoAq9oqcNCp+faER/sioQhbjAsY8dU1J8pqGoZa0gQC
	 SLiTuLvfBJvRTiyHA8K8e1so1iOwTIlb/tWicsih0xIc//QUU5JzdyNklOPGLCadLW
	 ydTIyBqpizRaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] perf tools: Export dso__get_filename() with type
 argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-5-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:21:01 +0000
Message-Id: <20260929012101.C0C7F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The dso__get_filename() returns a new string of filepath for the given
> binary type.  It handles chroot and decompressed kernel modules so that
> callers can read the file contents.  Thus it'd be better to use it to
> check available binary types.
>=20
> Add a type argument to handle a different path for symbol or debug info.
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D4

