Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A93043DB;
	Sun,  6 Sep 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715675; cv=none; b=o6SzxftN+YP/8TdHLvvwJRYy/ynXXlj81FtlaDFD/40QkbK4KEgf2CsXoS4u73/sElp55mMfNgxfBdYfAoBjuddR4vt9yYCsInwhwjaiamVa2JX8pDn0kemjBNG/tqEuc8zdsLaK9SxPahFuMWDoJ8DWwOD/oxHCg+qCkjgC1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715675; c=relaxed/simple;
	bh=8qyHwS2czSV92FCVas4GmCKsnkQGItGpUkfu9cZJwmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BJFmsKPWmx1HEDIOuoJcZyanSsRznWKcL/ycA96MGYgk4fFtyMNTgkp5D5+6ChsnLX6ih5MJBDriy+B3TqglXR4poJdNXbV1Y1yWqbAYraA32hAZ6YDq325utfxFMvERyjOubFM8o535c4ihT1onoO8UmNP+8AaWmpELNDqfrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDB+WNOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDB+WNOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0794F1F00A3A;
	Sun,  6 Sep 2026 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715674;
	bh=8qyHwS2czSV92FCVas4GmCKsnkQGItGpUkfu9cZJwmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDB+WNOEAs+n1qkNdD53sElY+HAYiPoogX9bR5xqB3PQo9XV4D9c0hxX0DfCNrYhn
	 qF1si3T08iqv741Qznc3A3wDMcbRZWxpTzobhYjjVP7FhGxmD6QpXVGWHQE/8ijkkU
	 w4BZ+7ExpNd7At0cSBNw6K8Ul0EYcx8WXkpg7JwZcqWAschTSlYameC065U/Ee8wQn
	 Ep9L6TBVxF6Y6byqi2kMRiuvpNlyMnWLb1Eiq6vJJ0emvsIHwKWWS07GMR1bAQkV+U
	 nPnCUVe5PvuTNL3r+EMwXl7hi5NM5c1W4keiK/wNa5HAgVa9SuIUff8YTajOa3wRNm
	 T6+9t/Xn+VazA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v4-1-97e92ee07214@gmail.com>
References: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
 <20260906-perf-gtk2-v4-1-97e92ee07214@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:27:53 +0000
Message-Id: <20260906172754.0794F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port straight to GTK 4 rather than the intermediate GTK 3, since GTK 4
> is where new development happens and GTK 3 is now old itself.
>=20
> GTK 4 removes GtkContainer, GdkScreen, and the gtk_main()/
> gtk_dialog_run() family perf's GTK UI relied on, so this is more than a
> mechanical rename: containers get per-widget setters (gtk_box_append()
> and friends), monitor geometry comes from GdkMonitor instead of
> GdkScreen, and the main and error-dialog loops become explicit
> GMainLoops, quit from the "close-request" and "response" signals since
> gtk_main_quit() and gtk_dialog_run() no longer exist. Widgets are
> visible by default now too, so gtk_widget_show_all()/set_no_show_all()
> go away.
>=20
> gtk_ui_progress__finish() also skips destroying a progress dialog that
> was never created, since gtk_window_destroy() asserts on NULL/non-window
> [ ... ]
> since gtk_info_bar_new() is deprecated and the check treats deprecation
> warnings as errors. HAVE_GTK_INFO_BAR_SUPPORT and its statusbar-only
> fallback go away; the info bar is now built unconditionally.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v4-0-97e92ee07214@gmail.com?part=3D1

