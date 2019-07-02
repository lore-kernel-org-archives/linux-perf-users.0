From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel
 sources
Date: Tue, 2 Jul 2019 15:54:32 +0200
Message-ID: <20190702135432.GC12694@krava>
References: <20190702022616.1259-1-acme@kernel.org>
 <20190702022616.1259-24-acme@kernel.org>
 <20190702121240.GB12694@krava>
 <20190702134603.GA15462@kernel.org>
 <20190702134815.GB15462@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190702134815.GB15462@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jul 02, 2019 at 10:48:15AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 02, 2019 at 10:46:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Jul 02, 2019 at 02:12:40PM +0200, Jiri Olsa escreveu:
> > > On Mon, Jul 01, 2019 at 11:25:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > 
> > > > Same implementation, will be used to replace ad-hoc equivalent code in
> > > > tools/.
> > > > 
> > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > Cc: André Goddard Rosa <andre.goddard@gmail.com>
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Link: https://lkml.kernel.org/n/tip-dig691cg9ripvoiprpidthw7@git.kernel.org
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > ---
> > > >  tools/include/linux/string.h |  4 +++-
> > > >  tools/lib/string.c           | 14 ++++++++++++++
> > > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> > > > index 6c3e2cc274c5..cee239350a6b 100644
> > > > --- a/tools/include/linux/string.h
> > > > +++ b/tools/include/linux/string.h
> > > > @@ -29,4 +29,6 @@ static inline bool strstarts(const char *str, const char *prefix)
> > > >  	return strncmp(str, prefix, strlen(prefix)) == 0;
> > > >  }
> > > >  
> > > > -#endif /* _LINUX_STRING_H_ */
> > > > +extern char * __must_check skip_spaces(const char *);
> > > > +
> > > > +#endif /* _TOOLS_LINUX_STRING_H_ */
> > > > diff --git a/tools/lib/string.c b/tools/lib/string.c
> > > > index 93b3d4b6feac..50d400822bb3 100644
> > > > --- a/tools/lib/string.c
> > > > +++ b/tools/lib/string.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <string.h>
> > > >  #include <errno.h>
> > > >  #include <linux/string.h>
> > > > +#include <linux/ctype.h>
> > > >  #include <linux/compiler.h>
> > > >  
> > > >  /**
> > > > @@ -106,3 +107,16 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
> > > >  	}
> > > >  	return ret;
> > > >  }
> > > > +
> > > > +/**
> > > > + * skip_spaces - Removes leading whitespace from @str.
> > > > + * @str: The string to be stripped.
> > > > + *
> > > > + * Returns a pointer to the first non-whitespace character in @str.
> > > > + */
> > > > +char *skip_spaces(const char *str)
> > > > +{
> > > > +	while (isspace(*str))
> > > > +		++str;
> > > > +	return (char *)str;
> > > > +}
> > > > -- 
> > > > 2.20.1
> > > > 
> > > 
> > > this breaks objtool build, because it adds _ctype dependency via isspace call
> > > patch below fixes it for me
> > 
> > Thanks for  spotting this, I'll have it in my next pull request.
> 
> I'm adding a Signed-off-by: you, ok?

sure, I did not post full patch, because I thought you might thought
of some other solution

thanks,
jirka
