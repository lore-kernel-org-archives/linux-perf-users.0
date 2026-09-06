Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E0392829
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788727947; cv=pass; b=FPlny63fXqzoZSY/IP7y/qn+gqYbyT1SrNOqF06NnAKu13thS2O593U8RMcc+JeDupaWun6aAcMwqlWO4AjvoxC+P6xvUvks7dyaLwuvJsKrMhMN2MdtCR7TD9erDPzfYunX61OtJ1Rgh7wfVBmbALa2tGEMVpW0R6LXhS63VTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788727947; c=relaxed/simple;
	bh=SXkkL1leCpadgAIXFmuk9vFBMaL9VMcynsn8nNsQidE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHhuuUIWfvsj+2LSU2ERQFORNOxyDsmtj+G2ZI1x/Vc3IJrXrbTeDWQyk8TyML20ciylHxNwhaMbl1a0RxINe8a3G9kcyypYX2KmAcAy8sREOikp8RLiue+mJTFdHsorkPKKxQRB/l4dFVx5pi2p4wNfjOLNBVril+x1QysIXoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+7vSHu1; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+7vSHu1"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a2e9851ed7so26941511fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 13:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788727943; cv=none;
        d=google.com; s=arc-20260327;
        b=ZOHe+ZRhaivE9+g+L4xf9WolIHBInIFSPgB96jXG4NVaF5HcpJ181eLF/y1uVODCb/
         tqw1pC/abNfqVglXuitdGa5Pxx+nAKsn3keplIs4Bi4uJGQToRZwJ64IdcgByVlSkQ3d
         yIkvp0hM0iGUVZ/ro/Eu6RxsIZEw8UK584ZWsanj3eUgZl2BWhKiRQ2PzFob36JOW6UZ
         LRRKBwVwUEtezrnMgWoq/Mb6K8Fe5bDUuzFNghU56O9hGPLWbYK+IHHJBfKqtXup3gus
         ZiN/VJCY8joB2eZqmzZ/APQD9CUEzXr2otKhY1MMEq87VJyEuEBJyBCKFh3clzk8QwMA
         JUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tLEUcwxYVbj+5BS/ostM1lAmEHO6bgKhQj06vkhAg0Y=;
        fh=Vnb5a4SFr60cn3PM2k8F6p55kt1UOjllrSeb5yUaRUA=;
        b=eo0s3U03AUOzDEe1zVCSNqtK/JSa42x45hZhAJQIYEhoLxE7aJElILMZCY7uaaTEha
         BD3wSHr9SaPN43G98pg3XjJgJDEXEGISPzMxyXxlJt+KSTJff8g5X1K+ZwmIr/1lpR/N
         iKuiz8aQC1ZGELGePE3b4Etr2KqqqcBVgShRvtVvr8i4q4dyLTXzFgSqW0RxD6LWeusb
         qFZhT5nBdZO4wE44NVJI2BsmP6dGJ4k6L4mhTDZw4LnoJoxQAghHdWFB+06zCnIDDhDF
         kQSnfgfzMg+KvJXd9aCbeKvfNragpS8QGeVrFNcQhamBIFTQxNSzpnQeEP+ugFv1cA0L
         JL3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788727943; x=1789332743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tLEUcwxYVbj+5BS/ostM1lAmEHO6bgKhQj06vkhAg0Y=;
        b=B+7vSHu1bIGhx9RJykdun8jtLDsxEq/uWn3NppP9wxArDzS3z2FeswFvKsinL4NQIq
         y0At7RAkG3GK9quhw7v+qmasQ7UhxFFHwAdNGOpzH9o2zgLsgcqXSPZlEofMZ1ZRqwFh
         vKK0vAwjR7A8/+72jim7Isun6T3SFXDUhWwD8swv9nS+G7QQX59KCXfFAj9WvCCF1Vfx
         Fj7ifJRIIa8Eo9mSaB5QreJOuksbNZVTA5hK2ja7gsMJdkUAExIeR+vrSjGj0mXW4KF3
         G0tGdkER19ZJ5eY+MEJugim9UjfJUBq3LRwn3cfNVLalvvkYF3kUS3m1R+AlumSAbN2O
         kJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788727943; x=1789332743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLEUcwxYVbj+5BS/ostM1lAmEHO6bgKhQj06vkhAg0Y=;
        b=pSpwQM//0HnJvUDrJktCj6j3t1mJWchybIhBPgE59q939Y2lXIDe5tH6YpYx0n65VJ
         /3BBoi1goJdqt8Jw0rtqrkkHwKDGIPSUZW4In2Ou7G9mgI5EQPmHNctEiWaMYPN6fhXx
         tMq/6zuZL+Bxl1Cs5sr5IG5HcOvH5MNqiFE4zjIyf+QaWVyXjKgQrYgSUiXb9jvknoHU
         TGiVWLYmOq56eLU0VvtATpQZuTptGwP/K8sDY/yzIcTBUT6ZJ0p9jbqSLhi9CShpkmJi
         iSGC74ng2yu/THLHVbuSfGrX3cNNCq+MojiYucxj+4Nq5irtUwrLAkgKD8nLL/NHAZ3D
         G+4Q==
X-Forwarded-Encrypted: i=1; AKwUvBw8PVaMwmWC/mZItEUKoc/pIkLMD+Gj67bXAga5heF3L3AfKTIq6dAabGV2TCbXcAi2SQlpyMbi2ZW/nhLXAR7F@vger.kernel.org
X-Gm-Message-State: AFuF++l7zZNahRKfnaWITV675xFwJIW4C49qpa7PdhyV2xbjWtKRX011
	wb3qYVKPjD3QGP6HukWMimhXjnDy2h6TJyl1BZkjcwT6NO9uV1lFt64U5psa3OUa77+6LxI9GN6
	fhlnNwjE8LZFsC1272gQ2JowTxLLNoUW+X87Aee0=
X-Gm-Gg: AYBFou279UgdF5A7iwz7DNpjaLlU0KNdoKwNYdeKIV51LYQX2SJqyjCvnifSqgMlnHm
	yUwv28/gY81u2MiILw5vlJE0YVzZts4D0KMoLfHZ9TULaBoARuXjaoyUWruRd5Em94a/XVPbNsH
	AVPoVKyWUG5TlSMvwTY0cP+iTn0qjN1uV06Dpd3nq0Qi4rOO/7cygLYox10BZlzdE13tHFXolKz
	J/FamuksMvPwkG+XWt4nP1SGKcux6Zxo/nudOf1gvc0jUvOCau4mEtZkbf4u6vvHYtdX0mTXLqP
	33UQYq4CG3K09vbvFyYTye6pFqW19oBp222WLGYzvWB1fHwvrzHrtoryNrEhwupsE1tggm2Gb/7
	o5gXpUkAzn2edNY8=
X-Received: by 2002:a05:651c:a38f:10b0:3a3:7681:6d5d with SMTP id
 38308e7fff4ca-3a37681748cmr11742711fa.21.1788727942625; Sun, 06 Sep 2026
 13:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
 <20260906-perf-gtk2-v7-1-1ece839fbca0@gmail.com> <20260906202542.E548D1F00A3A@smtp.kernel.org>
In-Reply-To: <20260906202542.E548D1F00A3A@smtp.kernel.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 6 Sep 2026 16:52:10 -0400
X-Gm-Features: AcwNN1UluC9sCF1AfaoB_QDn5rUqNCsIttJ4OM-0bXZJ5LOVybQjVpfERdAc7tU
Message-ID: <CAEdQ38EqhLXyZiR5P-gXtQrrEjceamN8FEVXcYvrbVvqJmduZA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] tools: port perf ui from GTK 2 to GTK 4
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 4:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Connecting to the removed 'destroy' signal in GTK4 causes main=
 loop hangs and use-after-free/double-free bugs.
> --
>
> commit fc78f437c6f22aa072d608cee2f291c6178f6853
> Author: Matt Turner <mattst88@gmail.com>
>
>     tools: port perf ui from GTK 2 to GTK 4
>
>     Port straight to GTK 4 rather than GTK 3, since GTK 4 is where new
>     development happens and GTK 3 is old itself now.
>
> > diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.=
c
> > index eea6fcde518a8..770f9251b54b7 100644
> > --- a/tools/perf/ui/gtk/progress.c
> > +++ b/tools/perf/ui/gtk/progress.c
> > @@ -1,49 +1,65 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <inttypes.h>
> > +#include <stdio.h>
>
> [ ... ]
>
> > +static void gtk_ui_progress__destroyed(GtkWidget *widget __maybe_unuse=
d,
> > +                                     gpointer data __maybe_unused)
> > +{
> > +     dialog =3D NULL;
> > +     progress =3D NULL;
> > +}
> > +
> >  static void gtk_ui_progress__update(struct ui_progress *p)
> >  {
> >       double fraction =3D p->total ? 1.0 * p->curr / p->total : 0.0;
> >       char buf[1024];
> >
> >       if (dialog =3D=3D NULL) {
> > -             GtkWidget *vbox =3D gtk_vbox_new(TRUE, 5);
> > +             GtkWidget *vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL,=
 5);
> >               GtkWidget *label =3D gtk_label_new(p->title);
> >
> > -             dialog =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
> > +             dialog =3D gtk_window_new();
> >               progress =3D gtk_progress_bar_new();
> >
> > -             gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, FALSE, 3);
> > -             gtk_box_pack_start(GTK_BOX(vbox), progress, TRUE, TRUE, 3=
);
> > +             gtk_widget_set_vexpand(label, TRUE);
> > +             gtk_box_append(GTK_BOX(vbox), label);
> > +             gtk_widget_set_vexpand(progress, TRUE);
> > +             gtk_box_append(GTK_BOX(vbox), progress);
> > +
> > +             gtk_window_set_child(GTK_WINDOW(dialog), vbox);
> >
> > -             gtk_container_add(GTK_CONTAINER(dialog), vbox);
> > +             g_signal_connect(dialog, "destroy",
> > +                              G_CALLBACK(gtk_ui_progress__destroyed), =
NULL);
>
> [Severity: Medium]
> In gtk_ui_progress__update(), will this signal connection fail at runtime=
?
> The destroy signal was removed from GtkWidget in GTK 4. If it fails silen=
tly,
> gtk_ui_progress__destroyed() would not be called to nullify the pointer w=
hen
> the user manually closes the progress window. This could result in a
> use-after-free or double-free crash when gtk_ui_progress__finish() is
> subsequently called on the already-freed pointer.

Incorrect. GTK4 did not remove the destroy signal from GtkWidget, only
the gtk_widget_destroy() function was removed. The signal is still
registered in gtk/gtkwidget.c (g_signal_new(I_("destroy"), ...)) and
emitted from gtk_widget_dispose(). Verified against upstream GTK
source, and confirmed live via GObject.signal_list_names(Gtk.Widget)
on GTK 4.20.4: destroy is present. g_signal_connect(dialog, "destroy",
...) connects fine and fires. No change needed.

> [ ... ]
>
> > diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
> > index c47f5c387838c..5823ff0d7c2a7 100644
> > --- a/tools/perf/ui/gtk/util.c
> > +++ b/tools/perf/ui/gtk/util.c
> > @@ -28,86 +30,103 @@ int perf_gtk__deactivate_context(struct perf_gtk_c=
ontext **ctx)
>
> [ ... ]
>
> > +     /*
> > +      * "response" only fires when a button is clicked; DESTROY_WITH_P=
ARENT
> > +      * destroys the dialog directly without it. Quit from "destroy"
> > +      * instead, which fires either way, so the nested loop below can'=
t
> > +      * outlive the dialog and hang.
> > +      */
> > +     loop =3D g_main_loop_new(NULL, FALSE);
> > +     perf_gtk__error_loops =3D g_slist_prepend(perf_gtk__error_loops, =
loop);
> > +     g_signal_connect(dialog, "response",
> > +                      G_CALLBACK(perf_gtk__dialog_response), NULL);
> > +     g_signal_connect_swapped(dialog, "destroy",
> > +                              G_CALLBACK(g_main_loop_quit), loop);
>
> [Severity: Medium]
> In perf_gtk__error(), since the destroy signal no longer exists in GTK 4,
> could this leave the nested main loop running indefinitely and hanging th=
e
> application? Because the destroy signal is not emitted when the dialog is
> closed (even via the confirmation button), g_main_loop_quit() will never =
be
> called.

Also incorrect, same misunderstanding of the destroy signal. When the
user closes the dialog via the window controls, gtk_window_close()
calls gtk_window_emit_close_request(). The default close_request
handler returns FALSE (no hide_on_close set), so control falls through
to gtk_window_destroy(), which drops GTK's internal toplevel ref and
finalizes the widget, emitting destroy. That is exactly the signal
perf_gtk__error() connects to stop the nested loop. Confirmed by
reading gtk_window_close() and gtk_window_destroy() in gtkwindow.c,
and gtk_widget_dispose() in gtkwidget.c, in current GTK upstream. No
hang. No change needed.
