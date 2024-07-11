Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF516EB56;
	Thu, 11 Jul 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734323; cv=none; b=hJTO9D5XA/GSwdePXpBUWxWt8Grh3DKc4uLNq95pyKKqJfpU1vuqETdpwetz4eB1pKMBQHMEYFI4pktemaX/uSUikDOIOWTiznwPHsou36qlujhSeJ35hC1dFkql+CNNp3va+WdB2eNZzg0/y6Uowg0wKgxc5lHdLz8rNoxnZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734323; c=relaxed/simple;
	bh=QVmj/Jbr30TXFGjMEZ9oiBF6UaF2jDj0AmtSMk7HJBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhehuT326sV/9x7ulmVomkQLSbqkZOkyhEfu2eVF69K0z63qwbJ3eFGqJTdYA44QYXSy+4ngcFMlnf5pc32Pc/4M+DgvrBQyYrLeTFrOBQUl2u4mnzoYCLxt/4zXWVYOHcU2oMUCHEbAVQskwhNtnbaD7X1p+jAtvwBvqw8NhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHNiSSJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHNiSSJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2C9C116B1;
	Thu, 11 Jul 2024 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720734323;
	bh=QVmj/Jbr30TXFGjMEZ9oiBF6UaF2jDj0AmtSMk7HJBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHNiSSJHuadX559D3gF/y0dVwskMq4a0uKW4LCf2RvIxv0aULq1J7jOgt5R1w35XR
	 Rg7qbvT0TqhSmMnpLDJe7VaqGngrUHhAv9GSkoy050dKIXWsu3y7vhG204D6wxJOaD
	 qvxcilkROIt+iwiGxPHk4pxmvQdi6gDDOgdsSdX8x1N4ZpfDI4IoE9BwVb9YW9v4zD
	 W6MahICQo1+kcc/vgOlR9fFx6XQWNDXef6ezaD8YP4d6n5HGuNJRz9/9veiWlFdxWr
	 9UmoeUtF9J9p0CeHkrG0ha6VDLq1oFYHWQh9AXtpit6HQags+qYr4V0FWq5gyDT4Jt
	 LXPBTf1y3tD5Q==
Date: Thu, 11 Jul 2024 14:45:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting
 mode
Message-ID: <ZpBSbjF3QP81_637@google.com>
References: <20240706232956.304944-1-weilin.wang@intel.com>
 <20240706232956.304944-9-weilin.wang@intel.com>
 <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
 <CO6PR11MB563567A7804F50AD5AA1F708EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cgrX=hL_Y16ZrPr6NOsd2ApOWdDP2bWDSNcK2yp4Skn3A@mail.gmail.com>
 <CO6PR11MB5635F6A59A405ED9CB63B8B0EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO6PR11MB5635F6A59A405ED9CB63B8B0EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>

Hello,

On Tue, Jul 09, 2024 at 06:23:51AM +0000, Wang, Weilin wrote:
> > On Mon, Jul 8, 2024 at 9:58 PM Wang, Weilin <weilin.wang@intel.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Namhyung Kim <namhyung@kernel.org>
> > > > Sent: Monday, July 8, 2024 9:44 PM
> > > > To: Wang, Weilin <weilin.wang@intel.com>
> > > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > > > <mingo@redhat.com>; Alexander Shishkin
> > > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hunter,
> > > > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>;
> > > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,
> > Perry
> > > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>;
> > Biggers,
> > > > Caleb <caleb.biggers@intel.com>
> > > > Subject: Re: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS
> > counting
> > > > mode
> > > >
> > > > Hello Weilin,
> > > >
> > > > On Sat, Jul 6, 2024 at 4:30 PM <weilin.wang@intel.com> wrote:
> > > > >
> > > > > From: Weilin Wang <weilin.wang@intel.com>
> > > > >
> > > > > Intel TPEBS sampling mode is supported through perf record. The
> > counting
> > > > mode
> > > > > code uses perf record to capture retire_latency value and use it in metric
> > > > > calculation. This test checks the counting mode code.
> > > > >
> > > > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > > > ---
> > > > >  .../perf/tests/shell/test_stat_intel_tpebs.sh  | 18
> > ++++++++++++++++++
> > > > >  1 file changed, 18 insertions(+)
> > > > >  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > >
> > > > > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > > new file mode 100755
> > > > > index 000000000000..fea8cb1b8367
> > > > > --- /dev/null
> > > > > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > > @@ -0,0 +1,18 @@
> > > > > +#!/bin/bash
> > > > > +# test Intel TPEBS counting mode
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +set -e
> > > > > +
> > > > > +# Use this event for testing because it should exist in all platforms
> > > > > +event=cache-misses:R
> > > > > +
> > > > > +# Without this cmd option, default value or zero is returned
> > > > > +echo "Testing without --record-tpebs"
> > > > > +result=$(perf stat -e "$event" true 2>&1)
> > > > > +[[ "$result" =~ $event ]] || exit 1
> > > > > +
> > > > > +# In platforms that do not support TPEBS, it should execute without
> > error.
> > > > > +echo "Testing with --record-tpebs"
> > > > > +result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
> > > >
> > > > It never finishes on my AMD machine.
> > > >
> > > Hi Namhyung,
> > >
> > > Do you see any message while it executes? Is the perf record forked
> > successfully
> > > but failed to return?
> > 
> > I don't know.. all I can get is like below:
> > 
> > $ sudo ./perf test tpebs -vv
> > 121: test Intel TPEBS counting mode:
> > --- start ---
> > test child forked, pid 583475
> > Testing without --record-tpebs
> > Testing with --record-tpebs
> > ^C
> 
> I think the problem is that the forked "perf record" encountered error, which 
> caused the control fifo failed to send a "ACK" back and the PIPE hanged.
> 
> Could you please try out the diff below and see if the test would finish?
> 
> As for the "perf record" error, I think it might because of the fake 
> event(cache-misses:R) cannot be supported in AMD. Could you please test run
> a "perf stat -e cache-misses:R --record-tpebs true" and see if it complains about
> the event?

So I tried the below patch and it worked.

  $ ./perf test -v tpebs
  121: test Intel TPEBS counting mode:
  --- start ---
  test child forked, pid 2190174
  Testing without --record-tpebs
  Testing with --record-tpebs
  ---- end(-1) ----
  121: test Intel TPEBS counting mode                                  : FAILED!

It would be better if it can skip rather than fail on
non-supported machines.

Also I saw this message when I run the command manually.

  $ ./perf stat -e cache-misses:R --record-tpebs -v true
  Control descriptor is not initialized
  Retire_latency of event cache-misses:R is required
  Prepare perf record for retire_latency
  Error:
  The cache-misses:pu event is not supported.
  incompatible file format
  incompatible file format (rerun with -v to learn more)
  failed: did not received an ack
  cache-misses:R: 0 1 1
  
   Performance counter stats for 'true':
  
                   0      cache-misses:R                                                        
  
         0.000004939 seconds time elapsed
  
         0.000000000 seconds user
         0.000000000 seconds sys

I'm not sure why it showed the incompatible file format message.

> 
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index a0585a6571b5..5b8e104f36f1 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -263,6 +263,7 @@ int tpebs_start(struct evlist *evsel_list)
>         }
>  
>         if (tpebs_event_size > 0) {
> +               struct pollfd pollfd = { .events = POLLIN, };
>                 int control_fd[2], ack_fd[2], len;
>                 char ack_buf[8];
>  
> @@ -297,6 +298,19 @@ int tpebs_start(struct evlist *evsel_list)
>                         goto out;
>                 }
>  
> +               /* wait for an ack */
> +               pollfd.fd = ack_fd[0];
> +
> +               if (!poll(&pollfd, 1, 2000)) {

Is it 2 seconds?  Any specific reason for the value?
At least we need a comment to explain the value (or just saying it's a
random one).

Thanks,
Namhyung


> +                       pr_err("failed: perf record ack timeout\n");
> +                       goto out;
> +               }
> +
> +               if (!(pollfd.revents & POLLIN)) {
> +                       pr_err("failed: did not received an ack\n");
> +                       goto out;
> +               }
> +
>                 ret = read(ack_fd[0], ack_buf, sizeof(ack_buf));
>                 if (ret > 0)
>                         ret = strcmp(ack_buf, "ack\n");
> 
> Thanks,
> Weilin
