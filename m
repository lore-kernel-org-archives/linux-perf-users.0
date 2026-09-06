Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E43A7198;
	Sun,  6 Sep 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788726344; cv=none; b=O39+wjQKlhi/qzJcvFe9mVGiYpTHuYIgdF4iY+HDiGqrQBoyouhOvhH0nYBBlsE2WaR44ul8UYojME/uaZHUypLojYXuk9jXhTWotSa2Xmu/H3JsyYVdPK/7UKcLafBJh/463Sx7YYLZ2PtAKDMLkFgcUUjGBMIwyG4wtYKiKYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788726344; c=relaxed/simple;
	bh=i+VEFGydjRmWtovSRcPCo8NPPuSfbfIlJtHcJgBtaFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E01Q9R88zAaWbq7r4po3l70SS4nA/v/wkdangE9m5J34HVkJht6D9dVry6mtuohik8Sa/5Dc1u0InuUOH9UfGAUxNrBbbwjJ8JladEnW3i5uzToNNd9Rgnbs066FGj66on5Z8LFbo5Nf8D4onffIaRv1gvX5e3z5dxKl49eQsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX/0x+vI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX/0x+vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E548D1F00A3A;
	Sun,  6 Sep 2026 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788726343;
	bh=T9+te7uz+mnvfAO46KAXRpNVSZePg/F54ygoeem8aM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mX/0x+vIRYkvUOHrVsaxrSGm2plGVsAKd9vAVl2QwFubrMjmRBYH4x6hy8HJltnlT
	 Iaug6+llTL9s99JVa6Mk9U/Ni/mQOhbSVyN1TmfG0AbgzuOyFJhkFL8Za8SBFRbAf0
	 fVpI3k4eX9k1+UZTYOtG6R6A1+rpsJZApgSv84o4qe9Al8dODodzIH01fFCoaqpZ/Z
	 MdWnSudDiuT8jVgRY8+8i/HqgwcfylxflfWrD6UzKO4gtZat7AmEj8LNDS3erFi07j
	 suZWAZnNPCqPXONLnALVhAI/h2wjA9i4RM8XZqRe5GjFIc9fAu4uvrxdYMZXcvLmD1
	 5yRfOconnSxeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v7-1-1ece839fbca0@gmail.com>
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
 <20260906-perf-gtk2-v7-1-1ece839fbca0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 20:25:42 +0000
Message-Id: <20260906202542.E548D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Connecting to the removed 'destroy' signal in GTK4 causes main l=
oop hangs and use-after-free/double-free bugs.
--

commit fc78f437c6f22aa072d608cee2f291c6178f6853
Author: Matt Turner <mattst88@gmail.com>

    tools: port perf ui from GTK 2 to GTK 4
   =20
    Port straight to GTK 4 rather than GTK 3, since GTK 4 is where new
    development happens and GTK 3 is old itself now.

> diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.c
> index eea6fcde518a8..770f9251b54b7 100644
> --- a/tools/perf/ui/gtk/progress.c
> +++ b/tools/perf/ui/gtk/progress.c
> @@ -1,49 +1,65 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <inttypes.h>
> +#include <stdio.h>

[ ... ]

> +static void gtk_ui_progress__destroyed(GtkWidget *widget __maybe_unused,
> +					gpointer data __maybe_unused)
> +{
> +	dialog =3D NULL;
> +	progress =3D NULL;
> +}
> +
>  static void gtk_ui_progress__update(struct ui_progress *p)
>  {
>  	double fraction =3D p->total ? 1.0 * p->curr / p->total : 0.0;
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
> +
> +		gtk_window_set_child(GTK_WINDOW(dialog), vbox);
> =20
> -		gtk_container_add(GTK_CONTAINER(dialog), vbox);
> +		g_signal_connect(dialog, "destroy",
> +				 G_CALLBACK(gtk_ui_progress__destroyed), NULL);

[Severity: Medium]
In gtk_ui_progress__update(), will this signal connection fail at runtime?
The destroy signal was removed from GtkWidget in GTK 4. If it fails silentl=
y,
gtk_ui_progress__destroyed() would not be called to nullify the pointer when
the user manually closes the progress window. This could result in a
use-after-free or double-free crash when gtk_ui_progress__finish() is
subsequently called on the already-freed pointer.

[ ... ]

> diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
> index c47f5c387838c..5823ff0d7c2a7 100644
> --- a/tools/perf/ui/gtk/util.c
> +++ b/tools/perf/ui/gtk/util.c
> @@ -28,86 +30,103 @@ int perf_gtk__deactivate_context(struct perf_gtk_con=
text **ctx)

[ ... ]

> +	/*
> +	 * "response" only fires when a button is clicked; DESTROY_WITH_PARENT
> +	 * destroys the dialog directly without it. Quit from "destroy"
> +	 * instead, which fires either way, so the nested loop below can't
> +	 * outlive the dialog and hang.
> +	 */
> +	loop =3D g_main_loop_new(NULL, FALSE);
> +	perf_gtk__error_loops =3D g_slist_prepend(perf_gtk__error_loops, loop);
> +	g_signal_connect(dialog, "response",
> +			 G_CALLBACK(perf_gtk__dialog_response), NULL);
> +	g_signal_connect_swapped(dialog, "destroy",
> +				 G_CALLBACK(g_main_loop_quit), loop);

[Severity: Medium]
In perf_gtk__error(), since the destroy signal no longer exists in GTK 4,
could this leave the nested main loop running indefinitely and hanging the
application? Because the destroy signal is not emitted when the dialog is
closed (even via the confirmation button), g_main_loop_quit() will never be
called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v7-0-1ece839fbca0@gmail.com?part=3D1
