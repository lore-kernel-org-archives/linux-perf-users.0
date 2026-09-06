Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D63B28D;
	Sun,  6 Sep 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711553; cv=none; b=tClJCNxhVmRyVIgP3q2k28LXTO02sGijXVVR+Pt6J56UrpDSyUnsvwEFH1pyQfksMQEE31TkVTGpinix4jlP2wxKDhl2ni9y/H3Q5nuDBIp+XAY3tF7rfnDvyeFoSFuSxMdf994E00qxQgP3uIzm9UqYU3lJeE10FHGY4F/kmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711553; c=relaxed/simple;
	bh=hcHXjohoRkBJMydlTLNLrhy7esbxTNiPxsOf54E5VOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CBoROaP6uCbmC5UB4/14pi6qnyMyBQVgfvUh64VpaAx0lVsItPHnlGyM53rBc7qFpf6I6/+yBsuRAhMFlL1y7VSsmuG8iQ77bVMhqyG4moyRI6TT1nfjyfOykitiH8mkkDhbjdnz9IG8SWoHcZc3SV8aLqvBSEBSfzDELLvc+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsRYOUMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsRYOUMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058571F00A3A;
	Sun,  6 Sep 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711552;
	bh=RWe9BS3C5oRWwzmuoBIATuBOQkzPFNNebZRFeOGcctY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IsRYOUMiaujgsKdERaW8Ivt89T4MblZrrzhf79GWjLe0OmI6R5ASWGMOVeKITissS
	 MsikBUjiliDlwRymXg5zMqzgWxyT5ewRiumhkyLWyUuomQ1V0iyqFxeJMJdApXBP4M
	 7LEwjNp1/81cgyjMwhuf9Cv+TeXqCW/aJNngcYoPq0/XBPPTPTZqcFp5c2Kc9DUpbu
	 WMGC7EsA2B/9lQSkAs194e5aCSyF7eHEwoSKfB6t0OPX9dRVmFru0N7u+PIESTYQfg
	 E4bqj+EgMUcaNIHBXcHl+OJO/QLGrTSlp1948eHgeXncJef3Q2OkDW5t5fsi2yako0
	 E8NDHXgagNZpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v3-1-e1f2086214a0@gmail.com>
References: <20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com>
 <20260906-perf-gtk2-v3-1-e1f2086214a0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:19:11 +0000
Message-Id: <20260906161912.058571F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Non-atomic GSList updates race with traversal in signal handler,=
 risking list corruption and crashes.
- [Low] The GTK 4 port incorrectly uses `gtk_widget_show` and `gtk_widget_h=
ide`, which were completely removed in GTK 4, leading to build and linkage =
failures.
--

commit 42bf24edb84bb238d5385cd7669415baed4ad796
Author: Matt Turner <mattst88@gmail.com>

tools: port perf ui from GTK 2 to GTK 4

This patch ports the perf GTK UI directly to GTK 4, migrating widget APIs,
monitor geometry access, and event loops. It also removes GTK 2 compatibili=
ty
and converts manual loops to signal-driven GMainLoops.

> diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
> index d2dadf3873fbd..e1d2869458329 100644
> --- a/tools/perf/ui/gtk/browser.c
> +++ b/tools/perf/ui/gtk/browser.c
[ ... ]
>  GtkWidget *perf_gtk__setup_info_bar(void)
>  {
>  	GtkWidget *info_bar;
>  	GtkWidget *label;
> =20
>  	info_bar =3D gtk_info_bar_new();
> -	gtk_widget_set_no_show_all(info_bar, TRUE);
> +	gtk_widget_set_visible(info_bar, FALSE);
> =20
>  	label =3D gtk_label_new("");
>  	gtk_widget_show(label);

[Severity: Low]
Does this successfully compile against GTK 4? It appears gtk_widget_show()
was removed in GTK 4, but this line remains unchanged. Should this be
migrated to gtk_widget_set_visible() instead?

> =20
> -	content_area =3D gtk_info_bar_get_content_area(GTK_INFO_BAR(info_bar));
> -	gtk_container_add(GTK_CONTAINER(content_area), label);
> +	gtk_info_bar_add_child(GTK_INFO_BAR(info_bar), label);
> =20
> -	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), GTK_STOCK_OK,
> +	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
>  				GTK_RESPONSE_OK);
>  	g_signal_connect(info_bar, "response",
>  			 G_CALLBACK(gtk_widget_hide), NULL);

[Severity: Low]
Similarly, gtk_widget_hide() is passed as a signal callback here, but it
was also removed in GTK 4. Could this cause linkage or build failures?

[ ... ]
> diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
> index c47f5c387838c..8a922851257e7 100644
> --- a/tools/perf/ui/gtk/util.c
> +++ b/tools/perf/ui/gtk/util.c
[ ... ]
> +static GSList *perf_gtk__error_loops;
> +
> +static void perf_gtk__quit_loop(gpointer data, gpointer user_data __mayb=
e_unused)
> +{
> +	g_main_loop_quit(data);
> +}
> +
> +void perf_gtk__quit_error_dialog(void)
> +{
> +	g_slist_foreach(perf_gtk__error_loops, perf_gtk__quit_loop, NULL);
> +}
[ ... ]
>  static int perf_gtk__error(const char *format, va_list args)
>  {
[ ... ]
> +	loop =3D g_main_loop_new(NULL, FALSE);
> +	perf_gtk__error_loops =3D g_slist_prepend(perf_gtk__error_loops, loop);
> +	g_signal_connect(dialog, "response",
> +			 G_CALLBACK(perf_gtk__dialog_response), NULL);
> +	g_signal_connect_swapped(dialog, "destroy",
> +				 G_CALLBACK(g_main_loop_quit), loop);
> +
> +	gtk_widget_set_visible(dialog, TRUE);
> +	g_main_loop_run(loop);
> +	perf_gtk__error_loops =3D g_slist_remove(perf_gtk__error_loops, loop);
> +	g_main_loop_unref(loop);
> +
>  	free(msg);
>  	return 0;
>  }

[Severity: Medium]
Can these non-atomic list updates to perf_gtk__error_loops race with the
signal handler?

If a user presses Ctrl+C (sending SIGINT) at the exact moment the
application is inside perf_gtk__error() modifying the list via
g_slist_prepend() or g_slist_remove(), the async signal handler path
is triggered:

perf_gtk__signal() ->
  perf_gtk__exit() ->
    perf_gtk__quit_error_dialog() ->
      g_slist_foreach(perf_gtk__error_loops, ...)
     =20
Could this traversal crash or enter an infinite loop due to the interrupted
list modifications?

[ ... ]
>  static int perf_gtk__warning_info_bar(const char *format, va_list args)
>  {
[ ... ]
>  	gtk_label_set_text(GTK_LABEL(pgctx->message_label), msg);
>  	gtk_info_bar_set_message_type(GTK_INFO_BAR(pgctx->info_bar),
>  				      GTK_MESSAGE_WARNING);
>  	gtk_widget_show(pgctx->info_bar);
> =20
>  	free(msg);
>  	return 0;
>  }

[Severity: Low]
Does this call to gtk_widget_show() also need to be replaced with
gtk_widget_set_visible() for the GTK 4 build to succeed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v3-0-e1f2086214a0@gmail.com?part=3D1
