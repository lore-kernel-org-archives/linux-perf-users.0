Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1665FEED
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980705; cv=none; b=K2biSO+wp33oG02ZrxJkMOGhckcB+IO+a7+zY/QzGTzzGZUqv7Z3niKoXZnRHvE3WZqz1KphNgrfD+4Z91Fs56bfNQFsyJyz2K4K92sk6Cb1/mk7sKprUY2ZIBkIaclaRx+yYZeAn29ey6fNtsopt4T5FNuNBRDIfY8BLl8aGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980705; c=relaxed/simple;
	bh=8VdMgVQNgRvTZnucNBOBAewo64rcQIjXEpqdBB8CK0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvYxgpFpwPf8scwMeyTHvfoGiM0HI8gu+kvuJ98BFGFtepkD+L/9VrGlefN7tWgZI8HlPxaEYQ7Qz9xzsPsS+ZyhwMzYN3nCkk0h07FoT8PlhkcOoiLJAY/qJdf9Btax2zdq+d16U5ouGEtQQkwU/OuXyWB2zmWhF1yZYM8nzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpohvmnE; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpohvmnE"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so69355ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jul 2024 21:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719980703; x=1720585503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qolYKceaQM3wxra3wJYAlWpnZhkqkPu7RyFCFJoiofo=;
        b=SpohvmnEYlUyaqcCBwWGi6vHlPnvwRyYVrC1OPIlko69D0VvBsIOpWDSsASoSryCue
         NP9i2/BC3Ip8TokQKrUOWkOoWdbtA2j+f1W2pzYRYcg6cmhVtSNNS6aGUphUFxU+Ye1V
         5IMtJRQLo5diFH5zWMQ2fNHVf6wXyGngcf2o15iKzrpl3Wwhrtu37AugFjYTn8rn/lIl
         berkrDgBALNTOq1l4aXWmflVXMKXVR3HmB2YRtkd6rc/+bBBKkvVp2A2TLOAss0rbPyE
         x2Gh9zXe4n9BAe+CPiEjkdwKdDYc6EwGQVY5XrlzKkqGydpEGnJCh/OHsOwU9OZyWrue
         pKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719980703; x=1720585503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qolYKceaQM3wxra3wJYAlWpnZhkqkPu7RyFCFJoiofo=;
        b=J3QdSQbtKwvksSCOkLHfgQc9/hcIU9MSB6rE2P53cyMWpnru1KfLlph1531a8n/S1+
         sRk2MuAadDCIhrZ+7i0MJ6bQL1r0FQymy1RFtP4ketb1aYdsq9J176h4mIH+g9swY6+6
         K4s1sMKqqXCTfi7fdphAnmCv5k/x3TCbroaTxdzp+cQw2zTEN3JlVvGBkzNYuL9uNqcH
         UxPCEPt0Lb999I1nUS1OhNIqtOSm/GbJ5r0E2E4dNlahrDSaPGcwv6ZlkwSB0Od6+L8J
         lmW6ZGPE28KXiHdthYeUaWvxnxumrg0JWK/lqI/vyE80f5HjM2BUywKlSve0ogN67eSE
         LTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKzvFs8wbDOzb5VFb53h0p1CQ/97Y7NIbBIOTATMPstZi4ZVVC2I/Vfx+JSTOe1hUtaCsgKQUnMH9lPbUBChEXDVssd4H4ilSclnCTyYGwZA==
X-Gm-Message-State: AOJu0Yz9vgAZLa0GAvPReRFgoL3f1V5dBBWDdDEvOzl8YdyTeLKHBot/
	n1NlkAe1SKgbHqIW97z8aZC9nHy6jVRAsg32/cLBXboLvwMpVhxjZMxCMyIhiH2fEvqkXjttKqZ
	rijCqGDwnOLnOh4pMcBgE9TlVy09oKAwISomN
X-Google-Smtp-Source: AGHT+IEd4H0LXcO28ppdVYo7jm3V/vwaPWfhMWiyR4uZ05zuc8mm4R3swqQOD9B4CdTXT+7eJ4ir+/pgWJdPiiEvTOc=
X-Received: by 2002:a05:6e02:1d1e:b0:376:3998:9629 with SMTP id
 e9e14a558f8ab-3820cbf3e39mr1499795ab.13.1719980702601; Tue, 02 Jul 2024
 21:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com> <20240701044236.475098-2-irogers@google.com>
 <ZoTETvgcPdl9EUJV@google.com>
In-Reply-To: <ZoTETvgcPdl9EUJV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jul 2024 21:24:50 -0700
Message-ID: <CAP-5=fV4oPEjX2fh3aeBbmBGgYJGCdBnVjTZ2XnCCgnTSa0LTw@mail.gmail.com>
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

On Tue, Jul 2, 2024 at 8:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Sun, Jun 30, 2024 at 09:42:35PM -0700, Ian Rogers wrote:
> > Using waitpid can cause stdout/stderr of the child process to be
> > lost. Use Linux's /prod/<pid>/status file to determine if the process
> > has reached the zombie state. Use the 'status' file rather than 'stat'
> > to avoid issues around skipping the process name.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comm=
and.c
> > index 4e3a557a2f37..ec06683e77a0 100644
> > --- a/tools/lib/subcmd/run-command.c
> > +++ b/tools/lib/subcmd/run-command.c
> > @@ -2,6 +2,7 @@
> >  #include <unistd.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > +#include <ctype.h>
> >  #include <fcntl.h>
> >  #include <string.h>
> >  #include <linux/string.h>
> > @@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd=
, bool block)
> >
> >  int check_if_command_finished(struct child_process *cmd)
> >  {
> > +#ifdef __linux__
>
> Is this really necessary?  I don't think we plan to support other OS..

I don't think it'd be unreasonable to say run "perf report" on
Windows, or using wasm inside a web browser. Part of the reason for
doing things this way was to keep the WNOHANG logic although this
change no longer uses it for __linux__.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +     char filename[FILENAME_MAX + 12];
> > +     char status_line[256];
> > +     FILE *status_file;
> > +
> > +     /*
> > +      * Check by reading /proc/<pid>/status as calling waitpid causes
> > +      * stdout/stderr to be closed and data lost.
> > +      */
> > +     sprintf(filename, "/proc/%d/status", cmd->pid);
> > +     status_file =3D fopen(filename, "r");
> > +     if (status_file =3D=3D NULL) {
> > +             /* Open failed assume finish_command was called. */
> > +             return true;
> > +     }
> > +     while (fgets(status_line, sizeof(status_line), status_file) !=3D =
NULL) {
> > +             char *p;
> > +
> > +             if (strncmp(status_line, "State:", 6))
> > +                     continue;
> > +
> > +             fclose(status_file);
> > +             p =3D status_line + 6;
> > +             while (isspace(*p))
> > +                     p++;
> > +             return *p =3D=3D 'Z';
> > +     }
> > +     /* Read failed assume finish_command was called. */
> > +     fclose(status_file);
> > +     return true;
> > +#else
> >       wait_or_whine(cmd, /*block=3D*/false);
> >       return cmd->finished;
> > +#endif
> >  }
> >
> >  int finish_command(struct child_process *cmd)
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >
