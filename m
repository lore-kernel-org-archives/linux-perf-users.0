From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Date: Wed, 30 Oct 2019 12:13:36 -0300
Message-ID: <20191030151336.GD27327@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
 <20191029140052.GB4922@kernel.org>
 <20191029141852.GC4922@kernel.org>
 <20191029142647.GD4922@kernel.org>
 <578c3a3a-2972-2b95-b98c-aee78950f5bb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <578c3a3a-2972-2b95-b98c-aee78950f5bb@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd <nd@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Oct 30, 2019 at 11:03:43AM +0000, James Clark escreveu:
> Hi Arnaldo,
> 
> Thanks for that, yes separating them looks better.
> I will try to break down commits in the future.
> 
> > The patch came mangled, so I'm applying by hand, and separating it into
> > two patches, the first for the first paragraph and the other for the
> > second, ok?
> 
> By mangled do you mean the quoted printables "=3D" and "=20"?
> 
> It seems like git send-email falls back to this behavior by default:
> 
>          
>      --transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)
> 
>        Specify the transfer encoding to be used to send the message over SMTP.
>        7bit will fail upon encountering a non-ASCII message. quoted-printable can be
>        useful when the repository contains files that contain carriage returns, but
>        makes the raw patch email file (as saved from a MUA) much harder to inspect
>        manually. base64 is even more fool proof, but also even more opaque. auto will
>        use 8bit when possible, and quoted-printable otherwise.
> 
> 
> I copied my raw patch and was able to successfully apply it with git am, even with this escaping. Although I
> did upgrade to a newer version of git (2.23.0).
> 
> If I view the patch that you created, then it doesn't have quoted printable escaping. So there does
> seem to be a difference somewhere.
> Do you think I should use "git send-email --transfer-encoding=7bit"?

Well, I'm using mutt defaults, I'd say take a look at:

~/git/linux/Documentation/process/email-clients.rst

There is a sesion for your mail agent, maybe it helps.

- Arnaldo
 
> 
> Thanks
> James
> 
> On 29/10/2019 14:26, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 29, 2019 at 11:18:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> And here is the first patch out of your larger one, I changed the
> >> subject line to reflect that this is not tools/perf specific, as
> >> tools/objtool/ also uses libsubcmd, added Josh, objtool's maintainer so
> >> that he is made aware.
> > 
> > And the second patch:
> > 
> > 
> > commit d0381449fd9ab733ec2daf527263da9f73f1e94e
> > Author: James Clark <James.Clark@arm.com>
> > Date:   Mon Oct 28 11:34:01 2019 +0000
> > 
> >     libsubcmd: Use -O0 with DEBUG=1
> >     
> >     When a 'make DEBUG=1' build is done, the command parser is still built
> >     with -O6 and is hard to step through, fix it making it use -O0 in that
> >     case.
> >     
> >     Signed-off-by: James Clark <james.clark@arm.com>
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: nd <nd@arm.com>
> >     Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
> >     [ split from a larger patch ]
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> > index 352c6062deba..1c777a72bb39 100644
> > --- a/tools/lib/subcmd/Makefile
> > +++ b/tools/lib/subcmd/Makefile
> > @@ -27,7 +27,9 @@ ifeq ($(DEBUG),0)
> >    endif
> >  endif
> >  
> > -ifeq ($(CC_NO_CLANG), 0)
> > +ifeq ($(DEBUG),1)
> > +  CFLAGS += -O0
> > +else ifeq ($(CC_NO_CLANG), 0)
> >    CFLAGS += -O3
> >  else
> >    CFLAGS += -O6
> > 

-- 

- Arnaldo
