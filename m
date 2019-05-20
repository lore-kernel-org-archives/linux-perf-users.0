From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 20/73] perf machine: Null-terminate version char array
 upon fgets(/proc/version) error
Date: Mon, 20 May 2019 11:46:48 -0300
Message-ID: <20190520144648.GM8945@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
 <20190517193611.4974-21-acme@kernel.org>
 <2D532F76-A57F-4CC4-BAA5-B466AFC0305D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2D532F76-A57F-4CC4-BAA5-B466AFC0305D@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donald Yandt <donald.yandt@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Avi Kivity <avi@scylladb.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, May 17, 2019 at 08:05:39PM -0400, Donald Yandt escreveu:
> Thank you Arnaldo for signing my patch.
> 
>      I think we should use version 4 of my patch and return NULL instead of null-terminating for efficiency.

Please resubmit then, v3 is already upstream.

- Arnaldo
 
> Thanks,
> 
> Donald
> 
> > On May 17, 2019, at 3:35 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > From: Donald Yandt <donald.yandt@gmail.com>
> > 
> > If fgets() fails due to any other error besides end-of-file, the version
> > char array may not even be null-terminated.
> > 
> > Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Avi Kivity <avi@scylladb.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> > Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
> > Link: http://lkml.kernel.org/r/20190514110100.22019-1-donald.yandt@gmail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> > tools/perf/util/machine.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 3c520baa198c..28a9541c4835 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir)
> >    if (!file)
> >        return NULL;
> > 
> > -    version[0] = '\0';
> >    tmp = fgets(version, sizeof(version), file);
> > +    if (!tmp)
> > +        *version = '\0';
> >    fclose(file);
> > 
> >    name = strstr(version, prefix);
> > -- 
> > 2.20.1
> > 

-- 

- Arnaldo
