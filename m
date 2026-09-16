Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B03F926D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542506; cv=none; b=nR+xlvDzq9m2gSUe7bpVZEKdTzhG4VwuYdUtxJSMpEsnHwzNkMpjT/OTwfMszvfdP1Bv52uHrst3Ieg8Llxnm5Ul0UjpfI8ZdWjhJtJO0LBkYvBDeiU8dWkWQnj4j30cY6178+vaDgBSVcp36M35Tx3U31bx2YIGVLCy0nAemas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542506; c=relaxed/simple;
	bh=Bf1XIMTKn80hnzaR9Y2wH9LCJ0a/o35/gS9MIF+ueyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qRhLRGLLH21HmrzoFA6k7kGDxhJueXniSa2cYx3ERRcqiWCr7rRV2GjuPlV8hy2NHiMAvuRZ27wgfdbXEHs+oG6Qp4CEcnNo8djN9SVRkxgrtz++Ws9qGeQ2PT0BjEzh+NOrzfNWWl4WDvsxdjPYyjUpWvTeYl/OUJCi+pFJ2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFVRj/Le; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFVRj/Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2131F000FF;
	Wed, 16 Sep 2026 07:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542490;
	bh=Bf1XIMTKn80hnzaR9Y2wH9LCJ0a/o35/gS9MIF+ueyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFVRj/LegnWozo1PYnRLE89cOIFUwHxHGBFbZidafzyrvyuXCve1iSdsdrEs3tef2
	 bHMYRFLpCDkA+cBbVM4fs+7RwzFWfQm0qiHbmah9Ponb5aylAs9Ppp4gzrHJacB9us
	 AWERMZMilekpytKQp74HLaCXRQCZdeY7PzUVG3XSLmanZYAJCZ0S5pqWeKvjdSnt8g
	 aD/yyXE5UAn0fbFXOQLDEd3M1IXPGZk6ieNZtB0/xtiirScslhR6+nzsB86KyjTCxR
	 w33REbha182l7SXC2zxyDk32E5aekzQfeCiHuUogmXVjtwM+QH+3hj7IO/D+o74vOy
	 QbR0YrnduOIRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] perf test: Isolate test suite from user
 .perfconfig natively
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-10-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:08:09 +0000
Message-Id: <20260916070810.0B2131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Running 'perf test' should not inherit the user's ~/.perfconfig
> environment as customizing core properties (like core.hybrid-merge)
> will trivially break stdout matching checks across the shell suite.
>=20
> Explicitly set PERF_CONFIG to /dev/null inside cmd_test to globally
> sandbox the environment for the entire test workflow. Test specific
> config, like annotate.objdump, is read before the sandboxing so that
> 'perf test' still honors it.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D9

