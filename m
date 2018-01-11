From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf-probe: Ensure debuginfo's build-id is correct
Date: Thu, 11 Jan 2018 11:59:32 -0300
Message-ID: <20180111145932.GB3025@kernel.org>
References: <151358211494.25261.16134489192749792799.stgit@devbox>
 <151358214328.25261.6660021248431426149.stgit@devbox>
 <20180104161728.GC14721@kernel.org>
 <20180111213119.b5e03409d6beb27e3f34fc5a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeAKO7f (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Jan 2018 09:59:35 -0500
Content-Disposition: inline
In-Reply-To: <20180111213119.b5e03409d6beb27e3f34fc5a@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Em Thu, Jan 11, 2018 at 09:31:19PM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> On Thu, 4 Jan 2018 13:17:28 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Mon, Dec 18, 2017 at 04:29:03PM +0900, Masami Hiramatsu escreveu:
> > > Ensure that the build-id of debuginfo is correctly
> > > matched to target build-id, if not, it warns user
> > > to check the system debuginfo package is correctly
> > > installed.
> > 
> > So we look at a variety of files looking for one that has a matching
> > build-id, I think the warning message should state that the file with
> > the unmatched build-id is simply being skipped, no?
> 
> Actually, this patch series came from your request that you faced
> buildid mismatch between running binary and debuginfo binary, and
> you asked me to show the message to tell user what he needs to
> check.
> 
> > 
> > And why do this at 'perf probe -l' time? I.e. at that point whatever
> > probes that are in place already have all the needed debug info?
> 
> As I pointed, this is not only for perf-probe -l but also perf-probe -a

yeah, I recently noticed this while doind a gdb session, where it warned
about buildid mismatches.

I'll apply your patch, thanks for working on it!

- Arnaldo

> (or any other operation which uses debuginfo, like -V, -L). If user
> see this message at "perf probe -l", he might install debuginfo after
> he setup probes. Otherwise, he should see this message when he tries
> to setup probes.
> 
> BTW, this message is actually shown only if the binary has build-id.
> If either file doesn't have build-id, it is just ignored.
> 
> Thank you,
> 
> > 
> > I.e. the warning should be done at probe creation time only?
> > 
> > - Arnaldo
> >  
> > > E.g. on such environment, you will see below warning.
> > >   ======
> > >   # perf probe -l
> > >   WARN: There is a build-id mismatch between
> > >    /usr/lib/debug/usr/lib64/libc-2.25.so.debug
> > >    and
> > >    /usr/lib64/libc-2.25.so
> > >   Please check your system's debuginfo files for mismatches, e.g. check
> > >   the versions for the target package and debuginfo package.
> > >     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /us
> > >   r/lib64/libc-2.25.so)
> > >   ======
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  tools/perf/util/probe-finder.c |   18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > > index a5731de0e5eb..5bb71e056b21 100644
> > > --- a/tools/perf/util/probe-finder.c
> > > +++ b/tools/perf/util/probe-finder.c
> > > @@ -119,9 +119,11 @@ enum dso_binary_type distro_dwarf_types[] = {
> > >  
> > >  struct debuginfo *debuginfo__new(const char *path)
> > >  {
> > > +	u8 bid[BUILD_ID_SIZE], bid2[BUILD_ID_SIZE];
> > >  	enum dso_binary_type *type;
> > >  	char buf[PATH_MAX], nil = '\0';
> > >  	struct dso *dso;
> > > +	bool have_build_id = false;
> > >  	struct debuginfo *dinfo = NULL;
> > >  
> > >  	/* Try to open distro debuginfo files */
> > > @@ -129,12 +131,28 @@ struct debuginfo *debuginfo__new(const char *path)
> > >  	if (!dso)
> > >  		goto out;
> > >  
> > > +	if (filename__read_build_id(path, bid, BUILD_ID_SIZE) > 0)
> > > +		have_build_id = true;
> > > +
> > >  	for (type = distro_dwarf_types;
> > >  	     !dinfo && *type != DSO_BINARY_TYPE__NOT_FOUND;
> > >  	     type++) {
> > >  		if (dso__read_binary_type_filename(dso, *type, &nil,
> > >  						   buf, PATH_MAX) < 0)
> > >  			continue;
> > > +
> > > +		if (have_build_id) {
> > > +			/* This can be fail because the file doesn't exist */
> > > +			if (filename__read_build_id(buf, bid2,
> > > +						    BUILD_ID_SIZE) < 0)
> > > +				continue;
> > > +			if (memcmp(bid, bid2, BUILD_ID_SIZE)) {
> > > +				pr_warning("WARN: There is a build-id mismatch between\n %s\n and\n %s\n"
> > > +					"Please check your system's debuginfo files for mismatches, e.g. check the "
> > > +					"versions for the target package and debuginfo package.\n", buf, path);
> > > +				continue;
> > > +			}
> > > +		}
> > >  		dinfo = __debuginfo__new(buf);
> > >  	}
> > >  	dso__put(dso);
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
