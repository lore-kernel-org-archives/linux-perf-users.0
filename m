Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE245007;
	Fri, 12 Jul 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720816420; cv=none; b=o6vFFh9fz2JdYo7kdBkqzRP3bUxFSS7Iqm6U95rNw5b5gDyo8dlIKHcNlfpBUFKTG6MB5tLwxMlb/Rze+bqwAsPcXziGc2T86lkKbQefhX1naaQTOeTJSoQznHWjkHhTak2pdfMHaUkDfwiHdhZKqgX5N2RO3uq9P0iOGBfCn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720816420; c=relaxed/simple;
	bh=IZrFY7jhRqA3akF0qdHbJ7oItv4LQGRvS4/YFZ/3I70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVomGZtUCo4q8f+8Bv04KNoSLLNpffkN5y4RnA/FNzA8jwYUvzdaabjU0AaJMCobpqBylJcexn3aTw2YpVfKQ7bJD04sagJY003+sPygGpEuO9rfnOoa9nvnxNL2Fx+XjHoPD4bPtqoBiy8GvpbHj466yrHNe59pWhW8fVjDzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d73hPJsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d73hPJsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9019C32782;
	Fri, 12 Jul 2024 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720816420;
	bh=IZrFY7jhRqA3akF0qdHbJ7oItv4LQGRvS4/YFZ/3I70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d73hPJsLKNEeECtBzy3M+/XKX2g6xymNy79MJUmnLJ9+C44v0LB48RPy/+/PnRjqn
	 6u5bU1s0bgJK5lKZ+YzGiO/F4DRMx9qzq0MPaXsP0i1XPGEKJPiFgUAfPTn1AJP6rI
	 xHf+sqOM0vFYM4s3mqEz/L2IoP1QnTMleIcEw7ItzG7ao3UhP2galLiFf29aJ0MmkJ
	 S6MJdLSANvyDcGuSpQV9w+6VX92R6TVfxBHPr+CwgJyH4THXL4Eqdhkefk22pgolfx
	 DIYIOlMaoJ2THXFsovr2bjQ6oDNqxIqTO237W6bXMZ+IOjmX1+MEj0b2fZG0bJmTsc
	 MfFyEA10n51kQ==
Date: Fri, 12 Jul 2024 15:33:35 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools subcmd: Add non-waitpid
 check_if_command_finished()
Message-ID: <ZpGTHzfIeREt5VUO@google.com>
References: <20240701044236.475098-1-irogers@google.com>
 <20240701044236.475098-2-irogers@google.com>
 <ZoTETvgcPdl9EUJV@google.com>
 <CAP-5=fV4oPEjX2fh3aeBbmBGgYJGCdBnVjTZ2XnCCgnTSa0LTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV4oPEjX2fh3aeBbmBGgYJGCdBnVjTZ2XnCCgnTSa0LTw@mail.gmail.com>

Hi Ian,

On Tue, Jul 02, 2024 at 09:24:50PM -0700, Ian Rogers wrote:
> On Tue, Jul 2, 2024 at 8:24 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Sun, Jun 30, 2024 at 09:42:35PM -0700, Ian Rogers wrote:
> > > Using waitpid can cause stdout/stderr of the child process to be
> > > lost. Use Linux's /prod/<pid>/status file to determine if the process
> > > has reached the zombie state. Use the 'status' file rather than 'stat'
> > > to avoid issues around skipping the process name.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
> > > index 4e3a557a2f37..ec06683e77a0 100644
> > > --- a/tools/lib/subcmd/run-command.c
> > > +++ b/tools/lib/subcmd/run-command.c
> > > @@ -2,6 +2,7 @@
> > >  #include <unistd.h>
> > >  #include <sys/types.h>
> > >  #include <sys/stat.h>
> > > +#include <ctype.h>
> > >  #include <fcntl.h>
> > >  #include <string.h>
> > >  #include <linux/string.h>
> > > @@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd, bool block)
> > >
> > >  int check_if_command_finished(struct child_process *cmd)
> > >  {
> > > +#ifdef __linux__
> >
> > Is this really necessary?  I don't think we plan to support other OS..
> 
> I don't think it'd be unreasonable to say run "perf report" on
> Windows, or using wasm inside a web browser. Part of the reason for
> doing things this way was to keep the WNOHANG logic although this
> change no longer uses it for __linux__.

I'm not sure we are ready to run it on other platforms.  So I think
it's better simply remove it for now.

Thanks,
Namhyung


> > > +     char filename[FILENAME_MAX + 12];
> > > +     char status_line[256];
> > > +     FILE *status_file;
> > > +
> > > +     /*
> > > +      * Check by reading /proc/<pid>/status as calling waitpid causes
> > > +      * stdout/stderr to be closed and data lost.
> > > +      */
> > > +     sprintf(filename, "/proc/%d/status", cmd->pid);
> > > +     status_file = fopen(filename, "r");
> > > +     if (status_file == NULL) {
> > > +             /* Open failed assume finish_command was called. */
> > > +             return true;
> > > +     }
> > > +     while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
> > > +             char *p;
> > > +
> > > +             if (strncmp(status_line, "State:", 6))
> > > +                     continue;
> > > +
> > > +             fclose(status_file);
> > > +             p = status_line + 6;
> > > +             while (isspace(*p))
> > > +                     p++;
> > > +             return *p == 'Z';
> > > +     }
> > > +     /* Read failed assume finish_command was called. */
> > > +     fclose(status_file);
> > > +     return true;
> > > +#else
> > >       wait_or_whine(cmd, /*block=*/false);
> > >       return cmd->finished;
> > > +#endif
> > >  }
> > >
> > >  int finish_command(struct child_process *cmd)
> > > --
> > > 2.45.2.803.g4e1b14247a-goog
> > >
