Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926932E13B;
	Sun,  6 Sep 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707629; cv=none; b=josZZE0VU1NmvCX6TVbOZXpBadEHYS4OZcWxKlBCVnXH/sTyDbKWyQiCn9ZcNGAYk0kHeowGCn09FzCLL1B/yq2CiVA7UE7PXUW1seSO8qlrzjL+9eUh7MEc6oH284Zd+GrPUBEi3RLNS4aUHJfD0T+ne+3+p2govvqMk97Krbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707629; c=relaxed/simple;
	bh=puCKxwpeLUHyFE7gs0Tbc1xCrRriYn9kYAt8bjnvRQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lv+K5zxkIz9yLrbFobIsrGOLm9V9HNqfYrlH+VBjMftB2GWcFAWbTAC1v6tnTT/KotGSljQdP1Yjuld1wW7FC3WA5aviizrrBRlsa7Lw1+KbmxILdZFFxSvKyqMwxkwZyUTFPUUc2WrCcoqkOqe00B6uR20QTgBGjTIdaxNAk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh1KmQ5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh1KmQ5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A751F00A3D;
	Sun,  6 Sep 2026 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788707628;
	bh=/SOUL+XIQQ80aZUzZcyZQeQ672q51tdkOCG3P4qlbwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kh1KmQ5OJgUu/WxMwilIQMFlKsM/AkxX5pgmR8yO3nX9Pu2zhXGTy5rbhJW/AYHhn
	 aqV5CmwLJXklMuil1s/HYiAdGMpY+lLYRgSjvDF1CO2fJhl7DKwL5jy1PflpY5W20M
	 v62//4SQLMSoZ0+mQcOwT4zZou5uP85l6YIzyvVQC+LW/Gd4aTyMxRD8NNrAJ/L36Y
	 VYyMShcUeO4RfuQlZCzae8j0I8yFm4ChhkavqPAnCnuMfPEhTT+ldNQU5P2Wq2kPCd
	 9GDut5N5iTg/8UqYZGu+WxKNeJs1FH/n2rTTOy9H28hbe9bEBLy1PmoHfjKHTrARz3
	 nxPHuSb3DMJzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v2-1-3eccff053cd1@gmail.com>
References: <20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com>
 <20260906-perf-gtk2-v2-1-3eccff053cd1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 15:13:47 +0000
Message-Id: <20260906151348.14A751F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] GMainLoop object leaks when `perf_gtk__error` is called re-entra=
ntly due to overwriting the global loop pointer.
- [Low] Missing explicit POSIX libc header inclusions (<stdio.h>, <stdarg.h=
>) causes musl compilation failures.
--

commit 8571088e70ee1febaf2f0ceafacdfc25aeb4ea31
Author: Matt Turner <mattst88@gmail.com>

tools: port perf ui from GTK 2 to GTK 4

This commit ports the perf GTK UI from GTK 2 to GTK 4. It updates widget
creation, packing, and event loop logic to account for GTK 4 API changes,
such as removing GtkContainer and gtk_main_quit().

> diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.c
> index eea6fcde518a8..28a4b486360de 100644
> --- a/tools/perf/ui/gtk/progress.c
> +++ b/tools/perf/ui/gtk/progress.c
> @@ -3,47 +3,62 @@
> =20
>  #include "gtk.h"
>  #include "../progress.h"
> +#include <linux/compiler.h>

[Severity: Low]
This is a pre-existing issue, but can we explicitly include <stdio.h> here?
The snprintf function is used further down in gtk_ui_progress__update(),
and relying on implicit inclusion can cause build failures on systems using
the musl C library.

[ ... ]
> diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
> index c47f5c387838c..5096888b7c160 100644
> --- a/tools/perf/ui/gtk/util.c
> +++ b/tools/perf/ui/gtk/util.c
> @@ -4,6 +4,7 @@
> =20
>  #include <stdlib.h>
>  #include <string.h>
> +#include <linux/compiler.h>
>  #include <linux/zalloc.h>

[Severity: Low]
Could we also explicitly include <stdarg.h> and <stdio.h> in this file?
The patch introduces the use of va_copy and va_end below, which requires
<stdarg.h>. Using vasprintf, fprintf, and vfprintf without explicitly
including <stdio.h> can cause musl compilation failures.

[ ... ]
> @@ -28,27 +29,60 @@ int perf_gtk__deactivate_context(struct perf_gtk_cont=
ext **ctx)
[ ... ]
>  static int perf_gtk__error(const char *format, va_list args)
>  {
>  	char *msg;
>  	GtkWidget *dialog;
> +	va_list args_copy;
> =20
> +	va_copy(args_copy, args);
>  	if (!perf_gtk__is_active_context(pgctx) ||
> -	    vasprintf(&msg, format, args) < 0) {
> +	    vasprintf(&msg, format, args_copy) < 0) {
> +		va_end(args_copy);
>  		fprintf(stderr, "Error:\n");
>  		vfprintf(stderr, format, args);
>  		fprintf(stderr, "\n");
>  		return -1;
>  	}
> +	va_end(args_copy);
> =20
>  	dialog =3D gtk_message_dialog_new_with_markup(GTK_WINDOW(pgctx->main_wi=
ndow),
>  					GTK_DIALOG_DESTROY_WITH_PARENT,
>  					GTK_MESSAGE_ERROR,
>  					GTK_BUTTONS_CLOSE,
>  					"<b>Error</b>\n\n%s", msg);
> -	gtk_dialog_run(GTK_DIALOG(dialog));
> =20
> -	gtk_widget_destroy(dialog);
> +	/*
> +	 * "response" only fires when a button is clicked; DESTROY_WITH_PARENT
> +	 * destroys the dialog directly without it. Quit from "destroy"
> +	 * instead, which fires either way, so the nested loop below can't
> +	 * outlive the dialog and hang.
> +	 */
> +	perf_gtk__error_loop =3D g_main_loop_new(NULL, FALSE);

[Severity: Medium]
What happens if perf_gtk__error() is called re-entrantly while another error
dialog is already open?

If a signal or callback triggers another error while the first dialog's eve=
nt
loop is running, the global perf_gtk__error_loop pointer will be overwritten
by this new loop.

> +	g_signal_connect(dialog, "response",
> +			 G_CALLBACK(perf_gtk__dialog_response), NULL);
> +	g_signal_connect_swapped(dialog, "destroy",
> +				 G_CALLBACK(g_main_loop_quit), perf_gtk__error_loop);
> +
> +	gtk_widget_set_visible(dialog, TRUE);
> +	g_main_loop_run(perf_gtk__error_loop);
> +	g_clear_pointer(&perf_gtk__error_loop, g_main_loop_unref);

[Severity: Medium]
When the inner dialog closes, it unrefs its loop and sets the global pointe=
r to
NULL. When the outer dialog subsequently closes, g_clear_pointer() will see=
 a
NULL pointer and fail to unref the outer loop, resulting in a memory leak of
the GMainLoop object. Is there a way to store the loop pointer locally or t=
rack
nested loops to prevent this?

> +
>  	free(msg);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v2-0-3eccff053cd1@gmail.com?part=3D1
