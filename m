From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Date: Wed, 8 Aug 2018 12:53:28 -0300
Message-ID: <20180808155328.GA9543@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Aug 08, 2018 at 08:39:58AM +0200, Thomas-Mich Richter escreveu:
> On 08/08/2018 05:37 AM, mpe@ellerman.id.au wrote:
> > Thomas Richter <tmricht@linux.ibm.com> writes:
> >> Add support for s390 auxiliary trace support.
> >> Use 'perf record -e rbd000' to create the perf.data file.
> >> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
> >> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
> > ...
> >>
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> >> ---
> >>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
> >>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
> >>  2 files changed, 314 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
> > 
> > 
> > I'm seeing a build break on ppc64le which seems to be caused by this
> > commit (I haven't bisected):
> > 
> >   util/s390-cpumsf.c: In function ‘trailer_timestamp’:
> >   util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
> >     return *((unsigned long long *) &te->timestamp[te->t]);
> >     ^
> > 
> > 
> > And on powerpc big endian:
> >   In file included from util/cpumap.h:10:0,
> >                    from util/s390-cpumsf.c:150:
> >   util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
> >   util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
> >      pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
> >             ^
> > 
> > cheers
> > 
> 
> Can you please try this patch. Thanks a lot

Ok, this was making the build fail as well on some containers here:

   1    37.95 alpine:3.4                    : gcc (Alpine 5.3.0) 5.3.0

  CC       /tmp/build/perf/util/s390-cpumsf.o
  LD       /tmp/build/perf/util/scripting-engines/libperf-in.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/dump-insn.o
util/s390-cpumsf.c: In function 'trailer_timestamp':
util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  return *((unsigned long long *) &te->timestamp[te->t]);
  ^

   2    48.46 alpine:3.5                    : gcc (Alpine 6.2.1) 6.2.1 20160822
  CC       /tmp/build/perf/util/parse-branch-options.o
util/s390-cpumsf.c: In function 'trailer_timestamp':
util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  return *((unsigned long long *) &te->timestamp[te->t]);
  ^~~~~~
  CC       /tmp/build/perf/util/dump-insn.o

---------

I stopped at this point when this report/patch resurfaced in my mind, so
I came back and folded this fix into the cset introducing the problem
since it hasn't gone Ingo's way, so that we can keep this bisectable
when upstream.

Thanks guys!

- Arnaldo
