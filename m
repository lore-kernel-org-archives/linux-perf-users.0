From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 32/43] tools lib: Adopt strim() from the kernel
Date: Tue, 2 Jul 2019 13:00:32 -0300
Message-ID: <20190702160032.GH15462@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
 <20190702022616.1259-33-acme@kernel.org>
 <CAGje9yTfFrUxj-vSX=Au856Fe_307aQqD=YrbGeWfHESQ6Rw8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGje9yTfFrUxj-vSX=Au856Fe_307aQqD=YrbGeWfHESQ6Rw8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Clark Williams <williams@redhat.com>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Jul 01, 2019 at 11:33:20PM -0400, André Goddard Rosa escreveu:
> On Mon, Jul 1, 2019 at 22:28 Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Since we're working on moving stuff out of tools/perf/util/ to
> > tools/lib/, take the opportunity to adopt routines from the kernel that
> > are equivalent, so that tools/ code look more like the kernel.

<SNIP>

> > +char *strim(char *s)
> > +{
> > +       size_t size;
> > +       char *end;
> > +
> > +       size = strlen(s);
> > +       if (!size)
> > +               return s;
> > +
> > +       end = s + size - 1;
> > +       while (end >= s && isspace(*end))
> > +               end--;
> > +       *(end + 1) = '\0';
> > +
> > +       return skip_spaces(s);
> > +}
> > --
> > 2.20.1
> 
> 
> Small nit: could call skip_spaces() firstly and save its pointer to return
> later and then remove the trailing spaces. That’ll make strlen() iterate
> over a smaller string.

Hey, this is just  a copy of what is in the kernel sources, so as soon
as this gets improved there we'll grab a copy again can you do that for
the kernel first? :-)

- Arnaldo
