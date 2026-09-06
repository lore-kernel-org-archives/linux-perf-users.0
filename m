Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3743DA7D1
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704454; cv=none; b=NdBb97QgZMpW/Stj9QDXk008SMx2HKI9deJsqgZWf9x/84EBcrFhbdmWyXnvwZ0BD21c4OXm+h+t0rYELMrW1Q+DdzdQR+Bx6rP89WzUl4mRNWAG+gCSWvUhpeV3E4z0mI56Tndz9FsQvXdhVuB8/M3kLe8+4Mdcr5pWI7jj6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704454; c=relaxed/simple;
	bh=+/xZGjxc1kpQJEVVxWKyIr0YA1c3WZmKWzK1jbUe+dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=snSHB5S/bJCQ4HAfwU8nQL+yN8Gaiq3sCjUjDo+Bi6sGLJeJLc69cKvFUxVU8nTCIY11WXnNPvw5pZEWLbuV3zVPkMywvDlVAWOx5VDYn0g1FvO6LOyP/7lG5kkWEgMwDHgPBdgtVfRwilURbPPNVv425zVf5/UpxRkSYxkZ+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCPx3+r7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCPx3+r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E195B1F00A3A;
	Sun,  6 Sep 2026 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788704451;
	bh=5TAps9ju1fFuq3AbVXW1FSWBlI0Vshb3AIcIXm6ejFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCPx3+r7VRRDpZmV/f8DX1CeudiheqPKDMeWMxhPEJiUDCBuEv3X0gzkHDrPScwFe
	 Ca8/EIHrZPyIvTBx6v5gH77wVa2Z3s2Tp2M3BYBcnM6Wj24TiLPLAcqypICTpqvbQG
	 nFOr0tb3nESZgaKUvy2DKek0kuX69Hgu/aI/CTmke753uHB69raKo9P+jPrSN9Fu/G
	 CXSCMImDlKKAMzDsyvjf5aV5KjRSOBQFzR+qeH6juAfiDOI67b4zdYmuIvY+8KKpu9
	 zBbmpzUPRDPgeC65eB8cngstBITnWl/5VCwdhdpVDfiSUAMjlEoXn3+YJDX5tKEiSc
	 EjE+3xW/ba0yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v1-1-7564bf8523a9@gmail.com>
References: <20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com>
 <20260906-perf-gtk2-v1-1-7564bf8523a9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 14:20:50 +0000
Message-Id: <20260906142050.E195B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The custom nested GMainLoop in `perf_gtk__error()` will hang indef=
initely if the parent window is closed or a process signal is received whil=
e the error dialog is open.
- [Low] The code uses GTK APIs that have been removed in GTK4, causing buil=
d failures when GTK info bar support is enabled.

Pre-existing issues:
- [High] User-triggered Use-After-Free in the progress dialog if closed man=
ually.
- [High] Reusing an exhausted `va_list` after `vasprintf` fails leads to Un=
defined Behavior and arbitrary memory reads.
--

commit b3b8000cd456db5d6741b6a000f3706d6fd6d929
Author: Matt Turner <mattst88@gmail.com>

tools: port perf ui from GTK 2 to GTK 4

Port straight to GTK 4 rather than the intermediate GTK 3, since GTK 4
is where new development happens and GTK 3 is now old itself.

GTK 4 removes several APIs perf's GTK UI relied on, rather than just
renaming them, so this is a bigger change than a GTK 2 to GTK 3 port
would have been.

[ ... ]

> diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
> index d2dadf3873fbd..ee69e6a2bfbb0 100644
> --- a/tools/perf/ui/gtk/browser.c
> +++ b/tools/perf/ui/gtk/browser.c
[ ... ]
> @@ -50,15 +82,15 @@ GtkWidget *perf_gtk__setup_info_bar(void)
>  	GtkWidget *content_area;
> =20
>  	info_bar =3D gtk_info_bar_new();
> -	gtk_widget_set_no_show_all(info_bar, TRUE);
> +	gtk_widget_set_visible(info_bar, FALSE);
> =20
>  	label =3D gtk_label_new("");
>  	gtk_widget_show(label);
> =20
>  	content_area =3D gtk_info_bar_get_content_area(GTK_INFO_BAR(info_bar));

[Severity: Low]
Does compiling with GTK4 enabled fail here? While test-gtk4-infobar.c still
finds gtk_info_bar_new(), APIs like gtk_widget_show(),
gtk_info_bar_get_content_area(), and gtk_widget_hide() were removed in GTK4
and replaced, which might cause build failures.

> -	gtk_container_add(GTK_CONTAINER(content_area), label);
> +	gtk_box_append(GTK_BOX(content_area), label);
> =20
> -	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), GTK_STOCK_OK,
> +	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
>  				GTK_RESPONSE_OK);
>  	g_signal_connect(info_bar, "response",
>  			 G_CALLBACK(gtk_widget_hide), NULL);

> diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.c
> index eea6fcde518a8..1a73a6ba259f0 100644
> --- a/tools/perf/ui/gtk/progress.c
> +++ b/tools/perf/ui/gtk/progress.c
> @@ -13,37 +13,41 @@ static void gtk_ui_progress__update(struct ui_progres=
s *p)
>  	char buf[1024];
> =20
>  	if (dialog =3D=3D NULL) {
> -		GtkWidget *vbox =3D gtk_vbox_new(TRUE, 5);
> +		GtkWidget *vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
>  		GtkWidget *label =3D gtk_label_new(p->title);
> =20
> -		dialog =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
> +		dialog =3D gtk_window_new();
>  		progress =3D gtk_progress_bar_new();
> =20
> -		gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, FALSE, 3);
> -		gtk_box_pack_start(GTK_BOX(vbox), progress, TRUE, TRUE, 3);
> +		gtk_widget_set_vexpand(label, TRUE);
> +		gtk_box_append(GTK_BOX(vbox), label);
> +		gtk_widget_set_vexpand(progress, TRUE);
> +		gtk_box_append(GTK_BOX(vbox), progress);
> =20
> -		gtk_container_add(GTK_CONTAINER(dialog), vbox);
> +		gtk_window_set_child(GTK_WINDOW(dialog), vbox);
> =20
>  		gtk_window_set_title(GTK_WINDOW(dialog), "perf");
> -		gtk_window_resize(GTK_WINDOW(dialog), 300, 80);
> -		gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
> +		gtk_window_set_default_size(GTK_WINDOW(dialog), 300, 80);
> =20
> -		gtk_widget_show_all(dialog);
> +		gtk_widget_set_visible(dialog, TRUE);
>  	}
> =20
>  	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), fraction);

[Severity: High]
This isn't a bug introduced by this patch, but can this cause a
use-after-free if the user manually closes the progress dialog?

If the window manager destroys the dialog, the dialog and progress widget
pointers aren't set to NULL. The next call to gtk_progress_bar_set_fraction=
()
might dereference a freed widget pointer.

> diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
> index c47f5c387838c..7df80cf6b2b5a 100644
> --- a/tools/perf/ui/gtk/util.c
> +++ b/tools/perf/ui/gtk/util.c
[ ... ]
> @@ -46,9 +58,15 @@ static int perf_gtk__error(const char *format, va_list=
 args)

[Severity: High]
This is a pre-existing issue, but could this lead to undefined behavior and
out-of-bounds stack reads?

In the early fallback paths of perf_gtk__error() and similar functions, if
vasprintf() fails it returns a negative value after potentially exhausting
args. The fallback error path immediately calls vfprintf(stderr, format, ar=
gs)
without resetting the va_list via va_copy(), which could cause vfprintf() to
read past the end of the provided arguments.

>  					GTK_MESSAGE_ERROR,
>  					GTK_BUTTONS_CLOSE,
>  					"<b>Error</b>\n\n%s", msg);
> -	gtk_dialog_run(GTK_DIALOG(dialog));
> =20
> -	gtk_widget_destroy(dialog);
> +	loop =3D g_main_loop_new(NULL, FALSE);
> +	g_signal_connect(dialog, "response",
> +			 G_CALLBACK(perf_gtk__dialog_response), loop);
> +
> +	gtk_widget_set_visible(dialog, TRUE);
> +	g_main_loop_run(loop);

[Severity: High]
If the parent window is closed or a signal is received while the error dial=
og
is open, will this nested main loop hang indefinitely?

Since the dialog is created with GTK_DIALOG_DESTROY_WITH_PARENT, destroying
the parent will programmatically destroy the dialog without emitting the
'response' signal, leaving the loop blocked forever.

> +	g_main_loop_unref(loop);
> +
>  	free(msg);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v1-0-7564bf8523a9@gmail.com?part=3D1
