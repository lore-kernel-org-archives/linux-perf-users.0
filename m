Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2487288C81
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850735; cv=none; b=spLPrkBgmkNvvQ+TB3bA4AiYnLnI10fdoKCmm6VhmyHljS2XFsxMmv21v5BE+O2omEnC5HDz2fQ2i0aFxsf3BYdobH6LgLXPJ3GlWiERY/eKFjtSj6YvOjk1hpcWaRPLyA+8PwqS1zNCbZiBdm3aY+tOUceF3NE+BpxJpDpz/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850735; c=relaxed/simple;
	bh=dsVpHXsYga4Pld87zVpdB9DAD4EdHhCD0URZjuCOsSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E4t0FU8v7IF45IEpMlHIrOWainafwX3b9mYzQ+ToMre7QW5ENL6afgQ7/Vp1zOOTxi4LMBXMHafsinl7T/paXaff87FK4IlrKm8/Ec2O+VZz5k7Abk4atiuS++X9Xw29UtBXJW7CVZ1mw9y0cM+hnCnRZMc6Ga9uOm9SRBz7cKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmnWT246; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmnWT246"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085641F000FF;
	Sat, 19 Sep 2026 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850734;
	bh=6nCr2ShFK1gdtwKXwhWCgRtAyanpVyXl0Lwwa3SGz/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmnWT246PnP9u02xYEUg+VXLIf6O91Y3EfcAZ5ySosK15vYhktyptOdV+Bcd3Tg7n
	 TTL8GaGHTsQ9f1z4qDexpxGoyahyiRVAMcqUklFEhoNeHmNzTOJmz5Aq19Ksocb4pN
	 +owDMyf8165mGIqMVaFrXqHnF3IFELp1OhONViY6XfEEnrn3kn8BgjZfxQLHgf8gZN
	 IjK4b6Pg4RU7s9J4z+J09T6pzofJgVcEUUSyczUUKVR6BOyHRO0D5G15V4lpdZ2GmC
	 FyTV7dPx83xX3weQBRg55l5Ic85fYuKVrWbtwtjhwHy9W2WimpWKBbTLjcCGXX/q2q
	 bGqgw4IsoRf3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919204027.8504-6-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:45:33 +0000
Message-Id: <20260919204534.085641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The samples view (-n, annotate.show_nr_samples) prints a local
> nr_samples variable that is initialized to zero and never updated, so
> every member is listed as having no samples while the period and percent
> columns for the same entry are filled in.  Print the histogram entry's
> own count instead.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204027.8504=
-1-acme@kernel.org?part=3D5

