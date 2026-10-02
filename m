Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8047C0F2
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936960; cv=none; b=VijcxKDgL4t3aV2/99PLeBBj1wkutXfRmnHDkpZDLUhzWcgJHevQjIFky6OpGf5UZxGj56lNUbdudegR5bYb/K60LRPdaZ9gR/oR55XvhESVoAMF1K6+EtUEDnXOHqpT955vVfealpP+Qrn9hsN660CkS5usmJuF7bpFjYS8D7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936960; c=relaxed/simple;
	bh=2OWYwVOo4z4/Apnlv34WwOg1MLp1Ab1JePLA+BtfYW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h7BwNiHtw06P7+GAxChnscio5wkl7jbPUnT3OWHkEbEDfYY2m/aBpdW3IEdViULWwekvHjoSWcjmS8rK+C0FJzyUbIKkAJI8t4WRP456Ofe+3cR3b/y1tUefnlaFL3G/7AbcGF2W4oDGs5Ks/PbD+VNBsk7V87J4NlJZGZZmPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGpoA7Rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGpoA7Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF001F000FF;
	Fri,  2 Oct 2026 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936958;
	bh=6nw2gaaScHVD76ds21zbs55Pv82jna1L7RQGuC8zcGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGpoA7Rkj+dx++4F7yLZ1thhA7OnRUjnhoW63TATN0zwxWuhlbn4xLYTprgMYfMt1
	 ff6ZWSKpb08Scs8OvNC+ciEimpTXH+IceIy/DB/i5ON0TcmD/8CojmeflYUhDMSKS0
	 hWTAqNxHUKSfHiXWzrxbAme2nr6qlF7E/ymd/x/4vniQUFx+ZRqmD7Pbuwiudqydu0
	 RGi3qgG2kDh+7C4u7PVusDIp+ZFaRWZAJnSrBkePUi5UuXvhyYMYmKBR45qiigbmXZ
	 tVEefIo4doxPFrZUBy2qv+Fs5rsE1E+CjyJDGzb4ol/KspY6SSCXXllMM0v6y2yR+r
	 mzeVsSOiOpYxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-7-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:29:17 +0000
Message-Id: <20261002102918.7DF001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D6

