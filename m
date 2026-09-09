Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FD345CAA
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923178; cv=none; b=DysG1RjcSAZBvwIn9YrGgyDntMRxAiy+Pvk8RfeeBaPpOcsTofxrWuNaKfUxICeUxCKCtdlObR0ZhJ7OaVxOynYJb3m+zQRRZWPmM37naalmeJnwUgFP94FuO4OY79TnSgsjfggV3YjfLKIL21fshYtb0xms53S7Hue6cepkW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923178; c=relaxed/simple;
	bh=+Jr/uklGNyeXYh4heIekx2QyLZKdeWCsIP5n2TeZd9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WLRlZkNjoGpKUMgTbOTFHEUE2Ox61pNLotrlhEA2Box5iGTBwGvPSA7WOcabZXg6tCsCGYmt8sHFylgLID6QLuzbTfJtTJPPb4fSGplBEbQ/zdRETLgTafSTGYSZyXC/+7VT3itcZQmXOaFNxHcCjuf6Xym0SCmvj+qp2I8KYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOcrsX80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOcrsX80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84551F00A3A;
	Wed,  9 Sep 2026 03:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788923175;
	bh=+Jr/uklGNyeXYh4heIekx2QyLZKdeWCsIP5n2TeZd9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOcrsX806U2i8Zzm8rQ1nZ4v45cQU7bSOhoXOBHuCNmaZ52kUiT3+cn5OoB68dFpp
	 11Hi4Ldc5/WLlNyDRw6URahaHJOt0iitJUg1/PyqMc6v4d00EL+VomFMMXE9/uW+kl
	 UtNldUxbYW4MJ0BuuR8KSwmQ0v/TM7Gk8vZoIASaN4J9iGjZHww7FRWoFLhfZW0OAF
	 j/Df/iFw9v1znk4qIfpC4OIiOaMOM6/1AYCm/JXMeriWrdBqngc0Bc6Kpq7TuepuxW
	 ZZtAabancXPzM9UCpjbbwJQnaoQQJDxXkkE8qP0mkatD+xYYXak+3hY0GY/gQ0TEl9
	 zUKqrkJCEbYig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908-perf-gtk2-v8-1-e90d5d155f0d@gmail.com>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <20260908-perf-gtk2-v8-1-e90d5d155f0d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:06:14 +0000
Message-Id: <20260909030614.E84551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port straight to GTK 4 rather than GTK 3, since GTK 4 is where new
> development happens and GTK 3 is old itself now.
>=20
> GTK 4 drops GtkContainer, GdkScreen, and the gtk_main()/
> gtk_dialog_run() family perf's GTK UI relied on. Containers get
> per-widget setters (gtk_box_append() and friends), monitor geometry
> comes from GdkMonitor instead of GdkScreen, and the main and
> error-dialog loops become explicit GMainLoops quit from the
> "close-request" and "response" signals. Widgets are visible by default
> now, so gtk_widget_show_all()/set_no_show_all() go away, and the
> remaining gtk_widget_show()/gtk_widget_hide() calls become
> gtk_widget_set_visible() (with a small wrapper where "response" needs
> to pass gtk_widget_hide() as a callback, since it no longer exists as
> a plain function).
>=20
> [ ... ]
> and the check treats deprecation warnings as errors.
> HAVE_GTK_INFO_BAR_SUPPORT and its statusbar-only fallback go away; the
> info bar is now built unconditionally.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-perf-gtk2-=
v8-0-e90d5d155f0d@gmail.com?part=3D1

