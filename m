Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B230F53E;
	Wed, 21 Jan 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020858; cv=none; b=Ep9pMRMFEWlQq4wK/sL5QAJts6qVMIKLK+DonRbvRvOPXaJ7eSnMtkVf0spdu8F34hyXfWAk5yHq5YGU+GcLFEwrQj893OPgAh13+2iEw2GlhU5xST9NZ/NLK7LaZ5fsQWvIMcRjDFskUA+pIlB7e3kOKT0xOYvwnUKcWr4I180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020858; c=relaxed/simple;
	bh=Y4syQBB2V8XVdmIw97wsZc6h05/WE+VSVSQhMDNWpGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJOXKF+QWABBVcHMP0ibEHz3wCx1EdT2Rdw53jFMDyID9abG52HggQaZ3UjyU6u44/ujVAWY1D0g5jFwdL0E8SbpPCtlA0hVo72nzaGwDvsGSu7rrUMs8br3u4VuXU2AMhM1zWtg0vwIss3a5Xzus2H+qTkkVCNKb+10H0hRXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1TrwEWA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1TrwEWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1B5C4CEF1;
	Wed, 21 Jan 2026 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769020857;
	bh=Y4syQBB2V8XVdmIw97wsZc6h05/WE+VSVSQhMDNWpGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1TrwEWAPmaX8N/5rehRihu+dEUWzEa0IoBjWqRaHbmlp9avnrI/a13VnuPVPutiW
	 aFmsGYban9veJMWzXhT2ZPkrVovhgcbTfcbiFi49fCoGGVR37ajf7xN6qbITMCscPJ
	 CskCkJ64XU7UTN0SjctII648CUeOV7xakEjf7TmExVvKbFbeNQt924Gkz9hbTXRmli
	 I1l8SB8JOSctlLBLbzBDCl51coV4nFjfYuRHj5kVpWHVB6c9e+4CBfqRhD825hJIa2
	 KfhSzZ61b3THetuQRstWIqc9Yrj6HLjY7wjbW9iYz2nmF7ZXQuZMVWaFTbcR01QPh/
	 xVaBvnkxNnTKg==
Date: Wed, 21 Jan 2026 15:40:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/4] perf list: Don't write to const memory
Message-ID: <aXEdti4OdFN1eeuT@x1>
References: <20260120220900.366451-1-acme@kernel.org>
 <20260120220900.366451-4-acme@kernel.org>
 <20260121112536.27fd5d11@pumpkin>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121112536.27fd5d11@pumpkin>

On Wed, Jan 21, 2026 at 11:25:36AM +0000, David Laight wrote:
> On Tue, 20 Jan 2026 19:08:59 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Something now detected on fedora 44, where strchr() returns const if it
> > is passed a const pointer:
> > 
> >   util/print-events.c: In function 'print_sdt_events':
> >   util/print-events.c:89:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> >      89 |                 char *bid = strchr(sdt_name->s, '@');
> >         |                             ^~~~~~
> > 
> > Fix it by using strnchr() if strchr finds the separator instead of
> > temporarily scrubbing it with '\0'.
> > 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/print-events.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> > index 8f3ed83853a9e468..898cf426509790cd 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -97,14 +97,11 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
> >  		} else {
> >  			next_sdt_name = strlist__next(sdt_name);
> >  			if (next_sdt_name) {
> > -				char *bid2 = strchr(next_sdt_name->s, '@');
> > -
> > -				if (bid2)
> > -					*bid2 = '\0';
> > -				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
> > -					show_detail = true;
> > -				if (bid2)
> > -					*bid2 = '@';
> > +				const char *bid2 = strchr(next_sdt_name->s, '@');
> > +
> > +				show_detail = bid2 ?
> > +						strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0 :
> > +						strcmp(sdt_name->s, next_sdt_name->s) == 0;
> 
> You could use:
> 	show_detail = strncmp(sdt_name->s, next_sdt_name->s, strcspn(sdt_name->s, "@"));
> strcspn() will be slower, but it is succinct.

That works.

> I'm sure there is a function like strchr() that returns a pointer to the '\0'
> when the character isn't found - but I can't remember what it is called :-(

strchrnull()

And this also works and I'll use it:

                                const char *bid2 = strchrnul(next_sdt_name->s, '@');

                                show_detail = strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0;

This way the patch ends up as below, thanks for the suggestion!

Ian, I think I can keep your Reviewed-by, ok?

Cheers,

- Arnaldo

From 02b160f200a2224e8ecf490cf2e316b1a994509a Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 20 Jan 2026 18:16:09 -0300
Subject: [PATCH 1/1] perf list: Don't write to const memory

Something now detected on fedora 44, where strchr() returns const if it
is passed a const pointer:

  util/print-events.c: In function 'print_sdt_events':
  util/print-events.c:89:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     89 |                 char *bid = strchr(sdt_name->s, '@');
        |                             ^~~~~~

Fix it by using strncnmp() + strchrnul() instead of temporarily
scrubbing it with '\0'.

Reviewed-by: Ian Rogers <irogers@google.com>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Link: https://lore.kernel.org/r/20260121112536.27fd5d11@pumpkin
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/print-events.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 4bbcdbf05b843302..cb27e2898aa0558f 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -97,14 +97,9 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 		} else {
 			next_sdt_name = strlist__next(sdt_name);
 			if (next_sdt_name) {
-				char *bid2 = strchr(next_sdt_name->s, '@');
-
-				if (bid2)
-					*bid2 = '\0';
-				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
-					show_detail = true;
-				if (bid2)
-					*bid2 = '@';
+				const char *bid2 = strchrnul(next_sdt_name->s, '@');
+
+				show_detail = strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0;
 			}
 		}
 		last_sdt_name = sdt_name->s;
-- 
2.52.0

