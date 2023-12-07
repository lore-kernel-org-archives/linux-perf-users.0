Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C24EB42
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnBBcxt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75ECC433C7;
	Thu,  7 Dec 2023 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701978741;
	bh=mbc/iuLtD8dfCRev1lXPOrNzkAar0/fIcJRnERdFfIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnBBcxt+T/FbexCwnL4xPBnb0UqNrwMD4tRzSXMLvI6QfnQIBLxcBs5fve8nuy1+S
	 OSuYEMGauWPmMwDATH/cgCAvLwic5xCUt/JHsOwOt9aBwxdt5vsqyQujV2bBCbcaeO
	 9uOjCguEiKxDhXbrMx/LbnBp57cXNyOW2KZB26u296oYUqBtq7+AwGPWiGmqzUPtwI
	 Gj91ncJ/UYtA2RYmJILWnI7EMb+dreTIvuWgBpq99zLsOXDlCZVOgcTTxNIkwKGBSN
	 HduANwSSITKLUAcERcaOjKcUkBNn9HExtVHSkVFAM1hmDeeihBSRXahQnu1xcLbkLx
	 b48wXRlNd+6Og==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 13641403EF; Thu,  7 Dec 2023 16:52:18 -0300 (-03)
Date: Thu, 7 Dec 2023 16:52:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
Message-ID: <ZXIicbe9K5KYGSV4@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
 <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
 <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
 <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
 <ZXIiBp-rvdvSI-ZY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXIiBp-rvdvSI-ZY@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 07, 2023 at 04:50:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 05, 2023 at 09:59:02AM -0800, Ian Rogers escreveu:
> > On Mon, Dec 4, 2023 at 2:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Thu, Nov 30, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> > > > Sgtm. My point wasn't to criticize, I think this is a good change, I
> > > > was just trying to imagine doing things in a way that could overall
> > > > reduce complexity
> 
> > > Yep, thanks for your review.  Can I get your ACKs? :)
> 
> > For the series:
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied to perf-tools-next.


Now trying to fix this:

  CC      bench/numa.o
  CC      tests/hists_cumulate.o
ui/gtk/annotate.c: In function ‘symbol__gtk_annotate’:
ui/gtk/annotate.c:179:43: error: passing argument 3 of ‘symbol__annotate’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  179 |         err = symbol__annotate(ms, evsel, options, NULL);
      |                                           ^~~~~~~
      |                                           |
      |                                           struct annotation_options *
In file included from ui/gtk/annotate.c:5:
/home/acme/git/perf-tools-next/tools/perf/util/annotate.h:376:36: note: expected ‘struct arch **’ but argument is of type ‘struct annotation_options *’
  376 |                      struct arch **parch);
      |                      ~~~~~~~~~~~~~~^~~~~
ui/gtk/annotate.c:179:15: error: too many arguments to function ‘symbol__annotate’
  179 |         err = symbol__annotate(ms, evsel, options, NULL);
      |               ^~~~~~~~~~~~~~~~
/home/acme/git/perf-tools-next/tools/perf/util/annotate.h:374:5: note: declared here
  374 | int symbol__annotate(struct map_symbol *ms,
      |     ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
  CC      tests/python-use.o
  CC      trace/beauty/sockaddr.o
  CC      arch/x86/util/topdown.o
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: ui/gtk/annotate.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      arch/x86/util/machine.o

