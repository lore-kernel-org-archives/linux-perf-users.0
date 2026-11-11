Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413863;
	b=PtvwdkbqtU3SrY+cgXf7R102s4jnSFDU94fi0/vdEhv8K/rRfltLkjua3OuPcPpOyCso
	 9IsRT1uLKvIy0EFEWEG/5CiNJPMIhFdMA6FGQ6i5pxGwtD0boUZC9YvyzmwmUlHXetKar
	 h5QnqF0b/8dfBlKeuDOQ8FlyMDtx07/NmsC6HX/A3pkWcu2FvUEptzB8zS5X+yOhBpboU
	 yQE4xQ/g3Qpi7TpoBm6uWdVq4TLwUHTYLnQbGxZTlORmKQM9yxduCaWwtOcJOP2MOOE98
	 858DM+gbRY/sUzSnqXlI1Ueu7z0cqj48xouvUF5KJ8EQWy6S+nXavakKNnPQPAVqXow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WFKN42SU3nmSz9wkpobwVwDp37QceDU+rvEvel/56pw=;
	b=3PRFg6sZ1w2iv3zjSjTe7Sg4wGNrmh2cY+/ruck5QD4MTNBmcsIzirjsRHI3XlvMsRbK
	 Wi3P3bPspx3k+U9+Fmav13W35MzB9N97+fyvLjKQH0fztBiW4Qks+4dQo38DITCkh+uU4
	 flXLHXZpxZksoMLcToiaDmiRJL294s9u7lItQ4ip5GMFRvnmP1ATsmfgOKI3hjtkpxbme
	 csGV2Y0AtsgG2f1Y1Ef0/+gvfRHV2lYk/9g/IuBEgrbxF/LzOpnVe/tS3k2neClZh/3Vu
	 m47oFMbSYCqcXDI1KP5O90I9rQSZTVrTGAACidsloZhrf03ekOovA/svx40uCz3W8+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLlQYe+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E40606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLlQYe+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796041F00A05;
	Wed, 11 Nov 2026 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413862;
	bh=WFKN42SU3nmSz9wkpobwVwDp37QceDU+rvEvel/56pw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XLlQYe+4ifDKVcLybQfvLkgD7fjT7X7z32nej/92YH094+/kVl668v/b4ptwqwinm
	 rFZdO/V4fUwof/fgTgtzgQ5aVE+oPTmxRxetf/ZBqLZyGhJtMMQPPCu3Hg9Nw+Ts8x
	 1tJW3ymU4rHOOVEPKRT9BPrUXjZETjEahGDnrmMuL5tWoWr6LbZMRup30M8e6RypWj
	 aWE+/znW4JHbmUIRZcouYa3fGYvi16UXGul4odXXTW5TyD5/sveaNmi4em+qLyUm7g
	 aTsdPr/3650oHuUN9cmgKF6hA/RdRtwmK62gE2gV8T/DPI3VsGVsuaHgUFqxVFM6Mh
	 J/T9r2m64/qKQ==
Message-ID: <sashiko-outbox-209269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] perf jevents: Name the metric and the file when
 a MetricExpr is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111150920.2383157-2-takano32@gmail.com>
References: <20261111132622.2349165-1-takano32@gmail.com>
 <20261111150920.2383157-1-takano32@gmail.com>
 <20261111150920.2383157-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:17:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py reads each field it wants out of a JSON object by name, so a
> MetricExpr key that is missing or spelled another way leaves the object
> with a MetricName and no expression.  Two different failures followed,
> neither of which named the metric: the rewrite in _read_json_events_impl()
> raised AttributeError on the None, and a metric that got that far reached
> print_pending_metrics(), whose assert fired on it.
>=20
> Raise in the reader instead, naming the metric and the file it came from,
> before either of them can happen.  The file matters because the tables are
> read through a worker pool in main(), outside the directory walk, so an
> exception there loses the name of the table on its way out.  The check is
> not inside the '-' test that decides whether a metric takes part in the
> rewrite: a name with a dash in it can lose its expression the same way.
>=20
> Two smaller changes on the same path:
>=20
> - An architecture standard table that does not parse now carries the
>   reason in its message ("Failure processing '<file>' in '<dir>':
>   <cause>").  The traceback used to end with the file name alone, and the
>   reader already knows the cause.
>=20
> - The output files are opened after the tables have been read, so a tree
>   that fails to parse leaves no half-written table behind.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111150920.2383=
157-1-takano32@gmail.com?part=3D1

