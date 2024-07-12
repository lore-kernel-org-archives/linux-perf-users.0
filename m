Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9D4965B
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819214; cv=none; b=gnT4QqpTdV8V5BApGqKVNUFXan0xwxvdL85jeNItvI7dqCGaj8tOea/XYM1rNd7JwEWrrThfA3NvJ86Y4Pnrxa2KgVC+KnyL0Gd+DhbMDMjQcMu7B+4q5R6qcY6ScdfEyG8BB2EEIDHFC4h5dsoR/VujVn+n0xjpNJkiCnLJvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819214; c=relaxed/simple;
	bh=ieKkCfABzSmVpeaGxlvYCQ+TsKxuO/5Szv0cGhXWULA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZ5PLJ72UYLFjsf8MDrm3T9aLdDdK2qSv9j8U0TKyXleySNGGIYXD1nnVoTaoPXt9+fWLlx8K77KgAGUAd055t9PI1RvKyrEp7gC14d7GmGb8MeJ71h2CrXDDhDpfu0/1dD/Wwozu90Djz/3baBFVnGkMyk4orP4zrIxMminY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMmOY2H0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMmOY2H0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447df43324fso27791cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720819210; x=1721424010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTThe4McXMiwH5OOudIyzmGIb6Rw2NrtRU7kH3ILb2k=;
        b=JMmOY2H0swyYeThpsbYdUEJCijhgqiIS1tveTxiWnCivcQD+ESIQdoORDq6oOjgbw8
         B0Ahkkm/XZ41GDwWHYav/0TI6AiTtseksQiFi8BfIurfn1iqCXCc+N/B0r2cpHrQKxZR
         2wea8sZYkltJFHC0x0MBW744vvCOw07w94mrU0hwr2d17rhZB+KFD9w74rUP2wxfCljp
         iZQSh5QaMpmhZj3ZUDJ6yrYyDI+iJUssDNRmMCw1i6Pj4dl/6No9bn2TDiEvZ/OChUMT
         daCLH9quFNYY+lknki2lmxsoyMYF53QztENaVJMCtMnmGLgaDG+qyVpZIgp6Yc9m8d7n
         uUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720819210; x=1721424010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTThe4McXMiwH5OOudIyzmGIb6Rw2NrtRU7kH3ILb2k=;
        b=HGzsgXi58DQ1VI504XAK3WCf5EAwQSJ3HRu+46UppMwckgmwdtxdfvOPQqfV9l160O
         Sq0G+G3/Tz5k8BKi20Nr+mrCsuFh2iAhFBxmzTZ8LI5zRriXg5Yz21819aSM8Sle6Y78
         s4Y2Dt2ag1bvFDlkpDGkDZPR/22OaJOR13BA99T81ry1MThtds7TIguQsNd32LlH4foo
         f0HTAXL74DyPPWitg77EaWWg6pPRuPxfYDIxdabI2tKCf/WKBqBtFLGAORak1aMm5DIh
         H2Rs+N7wrfgQcYyM3nXIrHarL5XhwCPtiZPiQHwZAZMB10VrfGzyF8LuihgBm2GAZhM9
         XDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0uGATk7F8kNrujUe5fdtssroIfx6AKeKnTyhTA4Gv6i6cxEIyh5YrjsKT9H48NIPvN+OTNMoKS5Z9alswo4Hno/IuDB1TfqLxckzzWRrJig==
X-Gm-Message-State: AOJu0Yyafuzv4IA9evzZhiO4jR5J1aRUOJ37z6nSf2ITuzt3+mN3qSl8
	h26XSGhZnlPXtI1OG8j9yYL4aanKTrqTD1iAoWtxr+ClD1R3ar1dTKzIcSxzn0iRad6suVsiYNL
	7okSZIQ5chRLqak29MsXeZtLw6u7O5xEzecAb
X-Google-Smtp-Source: AGHT+IGgdzFjYuXvqO7N7p76ZBla1i0WOa+AlzlygZUDin7E+bNSQp1jf02ZvQzzQ+L0tswiRpCLX5jdOh/CbKR9A6o=
X-Received: by 2002:a05:622a:4d4a:b0:447:ec33:f488 with SMTP id
 d75a77b69052e-44f5a2abe18mr724761cf.4.1720819210219; Fri, 12 Jul 2024
 14:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com> <20240701044236.475098-2-irogers@google.com>
 <ZoTETvgcPdl9EUJV@google.com> <CAP-5=fV4oPEjX2fh3aeBbmBGgYJGCdBnVjTZ2XnCCgnTSa0LTw@mail.gmail.com>
 <ZpGTHzfIeREt5VUO@google.com>
In-Reply-To: <ZpGTHzfIeREt5VUO@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Jul 2024 14:19:58 -0700
Message-ID: <CAP-5=fXZGTbXZkyW7QLTYU6vZkiiTSvJrBigcN=QYiaP3C9n5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools subcmd: Add non-waitpid check_if_command_finished()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 1:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Jul 02, 2024 at 09:24:50PM -0700, Ian Rogers wrote:
> > On Tue, Jul 2, 2024 at 8:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Sun, Jun 30, 2024 at 09:42:35PM -0700, Ian Rogers wrote:
> > > > Using waitpid can cause stdout/stderr of the child process to be
> > > > lost. Use Linux's /prod/<pid>/status file to determine if the proce=
ss
> > > > has reached the zombie state. Use the 'status' file rather than 'st=
at'
> > > > to avoid issues around skipping the process name.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/lib/subcmd/run-command.c | 33 ++++++++++++++++++++++++++++++=
+++
> > > >  1 file changed, 33 insertions(+)
> > > >
> > > > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-=
command.c
> > > > index 4e3a557a2f37..ec06683e77a0 100644
> > > > --- a/tools/lib/subcmd/run-command.c
> > > > +++ b/tools/lib/subcmd/run-command.c
> > > > @@ -2,6 +2,7 @@
> > > >  #include <unistd.h>
> > > >  #include <sys/types.h>
> > > >  #include <sys/stat.h>
> > > > +#include <ctype.h>
> > > >  #include <fcntl.h>
> > > >  #include <string.h>
> > > >  #include <linux/string.h>
> > > > @@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process =
*cmd, bool block)
> > > >
> > > >  int check_if_command_finished(struct child_process *cmd)
> > > >  {
> > > > +#ifdef __linux__
> > >
> > > Is this really necessary?  I don't think we plan to support other OS.=
.
> >
> > I don't think it'd be unreasonable to say run "perf report" on
> > Windows, or using wasm inside a web browser. Part of the reason for
> > doing things this way was to keep the WNOHANG logic although this
> > change no longer uses it for __linux__.
>
> I'm not sure we are ready to run it on other platforms.  So I think
> it's better simply remove it for now.

So in the office hours there was some discussion with a potential new
contributor whose development platform is OS/X. It's fairly obvious
this code can't work on anything but Linux and using #error feels
annoying. The waitpid code is tested and has a known issue, but I
think it is better than just breaking anyone not on Linux.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > > +     char filename[FILENAME_MAX + 12];
> > > > +     char status_line[256];
> > > > +     FILE *status_file;
> > > > +
> > > > +     /*
> > > > +      * Check by reading /proc/<pid>/status as calling waitpid cau=
ses
> > > > +      * stdout/stderr to be closed and data lost.
> > > > +      */
> > > > +     sprintf(filename, "/proc/%d/status", cmd->pid);
> > > > +     status_file =3D fopen(filename, "r");
> > > > +     if (status_file =3D=3D NULL) {
> > > > +             /* Open failed assume finish_command was called. */
> > > > +             return true;
> > > > +     }
> > > > +     while (fgets(status_line, sizeof(status_line), status_file) !=
=3D NULL) {
> > > > +             char *p;
> > > > +
> > > > +             if (strncmp(status_line, "State:", 6))
> > > > +                     continue;
> > > > +
> > > > +             fclose(status_file);
> > > > +             p =3D status_line + 6;
> > > > +             while (isspace(*p))
> > > > +                     p++;
> > > > +             return *p =3D=3D 'Z';
> > > > +     }
> > > > +     /* Read failed assume finish_command was called. */
> > > > +     fclose(status_file);
> > > > +     return true;
> > > > +#else
> > > >       wait_or_whine(cmd, /*block=3D*/false);
> > > >       return cmd->finished;
> > > > +#endif
> > > >  }
> > > >
> > > >  int finish_command(struct child_process *cmd)
> > > > --
> > > > 2.45.2.803.g4e1b14247a-goog
> > > >
