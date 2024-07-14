Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054713AD16
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Jul 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720980845; cv=none; b=Cuk/nftWgUnx1/zzqZ2L+7uVsO7KlbWoQY2EWPeF1Er2baAJBi1SY/ijRPQL62bB5vCur6tE5KVFkoIFcGEMq/hyVVW7RXftU9KbpHh8Hwb3KBn6CNTn2MbTUb1RagNbyxffmHZfJHB/0N7L4zbIkYxNvXczpnp9jAswERJinlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720980845; c=relaxed/simple;
	bh=dfK/hzKcaxrrTO77sPT1l/DUOBwHoNdWg996wb9Hc70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzhM+5JJ351DlpyY84ZFg6JgDE8CaaqctetYwC0qurQeAJ3HjVr1pU4Fwp247ub0c0ZGzozDWdmt24Bd8ASWulLDIlcELX00g13CWdoI6sPrPAIyyBo856008bniE4aJoSih6K9dfgp1f5xnzoTwyf3aFfZun5FgQjRn804CgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iE3Misj7; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iE3Misj7"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so188535ab.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jul 2024 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720980843; x=1721585643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1f1qal/kMBnOtnqRMW7oCx8DByn/5i1u7lFfzKpy18=;
        b=iE3Misj7nCauSuUBEMVCKoI5zJOtpJp2t5OOueKt85BNi/CWWQDd1MXqR0QZppunly
         X23VlY43NOKb/xpr7ntBkAD8Y5GuQgDkrk+ZcCqAMwFlQRTZ8xDA4bBdcyuBqDyz+zrN
         0gJC+eZX2Zck9hDJVfUdiqWOlCsFoIueqP/trrJ+e3wlzZU8xsX+7MSz3BCclRY5S4OY
         klrbwxMCYCNi+BgSnnHTj76MVF5SoduTq3AuBuLPCYOmiwN8QY+OiiMxvvQrwzv4UGUm
         sEQo1jFtANkmhCYkESECUZCYdHI98KcvMR2DRTIj0mbN3ePbhis75kGTYdgx3tnlV19c
         6MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720980843; x=1721585643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1f1qal/kMBnOtnqRMW7oCx8DByn/5i1u7lFfzKpy18=;
        b=YpViYTJlzQX94Zx3I2045+Z8Mh9XOkkiMLew/jFLDw88difbq/dqN5IayNelRKZ+7K
         y08AKYMo8aEIdOHqfFfJL344FJxjzfo4Tc5k0A/v0Tav3ti+afyJ0LINTzKTPh5tZMzZ
         kUTKxf8TpeQGYhcTdWzon61EN44nOqOE6Mja70M2bBQnkKRiADdjL5hr9V2ana1VFiVz
         rlyi/MQ4ecWdXbS37FJH8zEsMF7cYjgpyyWGrMVnjdnVIrIY9MlV2RKdxFdzOYR4bHJD
         SHphNJL/hTIU9j6zOL09YJ1IGdIrlHTyX94tmLBPsHAkKBa/XFxXr6uKPm3Li/Q54XOV
         U0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWTdbEyJPj39PbsouaNomGGdCUpOBQbKuKVPwmYmh8zt0PfFDF2uDALPoSmgQJSRIaoBN9y8f70ca+RoyFm6mbE7WcoqLjT672RVZwkvEsC6g==
X-Gm-Message-State: AOJu0YyhQeVcwqAbDyun7xsvULImP5eD1wF3jHjIMbdN1IcJYziNH2x6
	w0ftEkb7cYg2UE1H4PJ+KdKOYXbyUvTDTObM/fQkjLWwq2ZfWQAcU4Kg5rjkhjzQSEG44IK/N+e
	j1E2HUa1Q/C6e/of7CiXgAi+Q+Ln/B43WNMli
X-Google-Smtp-Source: AGHT+IHSqNixZdIxdcHVsTBP6IdQge2e4Z2HbUwnuotevIQTz2Wdyg1CggxxpJwDZVpNg6CxI/UPKorrchram36CsHM=
X-Received: by 2002:a05:6e02:1a4f:b0:375:eda1:d2ca with SMTP id
 e9e14a558f8ab-38fcafb0472mr3401005ab.22.1720980842951; Sun, 14 Jul 2024
 11:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com> <20240701044236.475098-2-irogers@google.com>
 <ZoTETvgcPdl9EUJV@google.com> <CAP-5=fV4oPEjX2fh3aeBbmBGgYJGCdBnVjTZ2XnCCgnTSa0LTw@mail.gmail.com>
 <ZpGTHzfIeREt5VUO@google.com> <CAP-5=fXZGTbXZkyW7QLTYU6vZkiiTSvJrBigcN=QYiaP3C9n5A@mail.gmail.com>
 <ZpKWbtXQTXwzGLw-@google.com>
In-Reply-To: <ZpKWbtXQTXwzGLw-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 14 Jul 2024 11:13:51 -0700
Message-ID: <CAP-5=fUg5hoZF8TLK+ivAVzVLKW0FsGaDWS+TN55m72eHLNUHw@mail.gmail.com>
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

On Sat, Jul 13, 2024 at 8:00=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Jul 12, 2024 at 02:19:58PM -0700, Ian Rogers wrote:
> > On Fri, Jul 12, 2024 at 1:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Jul 02, 2024 at 09:24:50PM -0700, Ian Rogers wrote:
> > > > On Tue, Jul 2, 2024 at 8:24=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Sun, Jun 30, 2024 at 09:42:35PM -0700, Ian Rogers wrote:
> > > > > > Using waitpid can cause stdout/stderr of the child process to b=
e
> > > > > > lost. Use Linux's /prod/<pid>/status file to determine if the p=
rocess
> > > > > > has reached the zombie state. Use the 'status' file rather than=
 'stat'
> > > > > > to avoid issues around skipping the process name.
> > > > > >
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > ---
> > > > > >  tools/lib/subcmd/run-command.c | 33 ++++++++++++++++++++++++++=
+++++++
> > > > > >  1 file changed, 33 insertions(+)
> > > > > >
> > > > > > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/=
run-command.c
> > > > > > index 4e3a557a2f37..ec06683e77a0 100644
> > > > > > --- a/tools/lib/subcmd/run-command.c
> > > > > > +++ b/tools/lib/subcmd/run-command.c
> > > > > > @@ -2,6 +2,7 @@
> > > > > >  #include <unistd.h>
> > > > > >  #include <sys/types.h>
> > > > > >  #include <sys/stat.h>
> > > > > > +#include <ctype.h>
> > > > > >  #include <fcntl.h>
> > > > > >  #include <string.h>
> > > > > >  #include <linux/string.h>
> > > > > > @@ -217,8 +218,40 @@ static int wait_or_whine(struct child_proc=
ess *cmd, bool block)
> > > > > >
> > > > > >  int check_if_command_finished(struct child_process *cmd)
> > > > > >  {
> > > > > > +#ifdef __linux__
> > > > >
> > > > > Is this really necessary?  I don't think we plan to support other=
 OS..
> > > >
> > > > I don't think it'd be unreasonable to say run "perf report" on
> > > > Windows, or using wasm inside a web browser. Part of the reason for
> > > > doing things this way was to keep the WNOHANG logic although this
> > > > change no longer uses it for __linux__.
> > >
> > > I'm not sure we are ready to run it on other platforms.  So I think
> > > it's better simply remove it for now.
> >
> > So in the office hours there was some discussion with a potential new
> > contributor whose development platform is OS/X. It's fairly obvious
> > this code can't work on anything but Linux and using #error feels
> > annoying. The waitpid code is tested and has a known issue, but I
> > think it is better than just breaking anyone not on Linux.
>
> I feel like it's a potential issue and should be handled by the
> potentiall contributor.  Until that happens, we can assume Linux
> and keep the code minimal.

I'm not clear what the issue is. Arnaldo took the WNOHANG waitpid
contribution but I asked him to drop it due to losing stdout/stderr in
parallel mode due to the waitpid closing these file descriptors early
- we're not running in parallel mode by default any more. Reading
procfs to determine zombie state is clearly a Linux only thing, hence
the ifdef. I'm keen to keep to any extent possible the perf tool
running on non-Linux platforms, for example, gathering a data file on
a server or embedded system then wanting to do perf report on a
different machine which may not be running Linux. libsubcmd is used
throughout the tool and we have many subprocesses for pagers, objdump,
addr2line, etc. I don't agree with making such a core library Linux
only and there's no obligation for the maintainers to take these
patches. I disagree with a minimal patch.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > >
> > > > > > +     char filename[FILENAME_MAX + 12];
> > > > > > +     char status_line[256];
> > > > > > +     FILE *status_file;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * Check by reading /proc/<pid>/status as calling waitpid=
 causes
> > > > > > +      * stdout/stderr to be closed and data lost.
> > > > > > +      */
> > > > > > +     sprintf(filename, "/proc/%d/status", cmd->pid);
> > > > > > +     status_file =3D fopen(filename, "r");
> > > > > > +     if (status_file =3D=3D NULL) {
> > > > > > +             /* Open failed assume finish_command was called. =
*/
> > > > > > +             return true;
> > > > > > +     }
> > > > > > +     while (fgets(status_line, sizeof(status_line), status_fil=
e) !=3D NULL) {
> > > > > > +             char *p;
> > > > > > +
> > > > > > +             if (strncmp(status_line, "State:", 6))
> > > > > > +                     continue;
> > > > > > +
> > > > > > +             fclose(status_file);
> > > > > > +             p =3D status_line + 6;
> > > > > > +             while (isspace(*p))
> > > > > > +                     p++;
> > > > > > +             return *p =3D=3D 'Z';
> > > > > > +     }
> > > > > > +     /* Read failed assume finish_command was called. */
> > > > > > +     fclose(status_file);
> > > > > > +     return true;
> > > > > > +#else
> > > > > >       wait_or_whine(cmd, /*block=3D*/false);
> > > > > >       return cmd->finished;
> > > > > > +#endif
> > > > > >  }
> > > > > >
> > > > > >  int finish_command(struct child_process *cmd)
> > > > > > --
> > > > > > 2.45.2.803.g4e1b14247a-goog
> > > > > >
