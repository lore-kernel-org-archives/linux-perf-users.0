From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel
 sources
Date: Tue, 02 Jul 2019 06:49:26 -0700
Message-ID: <5bb30e0ddefe71cdb845b83b43ac6d5f0bd92ad0.camel@perches.com>
References: <20190702022616.1259-1-acme@kernel.org>
         <20190702022616.1259-24-acme@kernel.org> <20190702121240.GB12694@krava>
         <20190702134603.GA15462@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702134603.GA15462@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, 2019-07-02 at 10:46 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 02, 2019 at 02:12:40PM +0200, Jiri Olsa escreveu:
> > On Mon, Jul 01, 2019 at 11:25:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > Same implementation, will be used to replace ad-hoc equivalent code in
> > > tools/.
[]
> > > diff --git a/tools/lib/string.c b/tools/lib/string.c
[]
> > > @@ -106,3 +107,16 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
> > >  	}
> > >  	return ret;
> > >  }
> > > +
> > > +/**
> > > + * skip_spaces - Removes leading whitespace from @str.
> > > + * @str: The string to be stripped.
> > > + *
> > > + * Returns a pointer to the first non-whitespace character in @str.
> > > + */
> > > +char *skip_spaces(const char *str)
> > > +{
> > > +	while (isspace(*str))
> > > +		++str;
> > > +	return (char *)str;
> > > +}

pity about duplicating losing the const
