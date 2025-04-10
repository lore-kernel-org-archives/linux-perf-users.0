Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE101F8721;
	Thu, 10 Apr 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318718; cv=none; b=Ehs4JzSeo59HrdS0HKnTpXjPhM62r5YEYZken69AKpuh9ZS0hluS4wz+K8qTLptzjxYnYFypOLPS+dv1jpGg+fOPdq6qRae4WPBdIv8y+jjX13lZW4ZM2QcYha1BnG6jjvUHrl2U10PWFCk7mY/MYuKTvZI3Dn0bCDXvBuz5KfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318718; c=relaxed/simple;
	bh=3AaCUynHyZgUbfT/x+PuBXtQ33kvzMSvNXxqvkzyius=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLTS5TO1ueDz1ktb7sTZA0Jf3flzCTnOY8gWHXj4BWEKvPqbJAtsmlkyLi5Td0+7JIcRH6B44ug3/TdjOHE1UN6d12Ji9pSbTLzEdbkSxTX85KcGzQswkciLhlVh+EuMmS0veY4br+MPTAPuOaXqtJ3nScikJ992qFaEQ843IsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjgiK6Cr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjgiK6Cr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05784C4CEDD;
	Thu, 10 Apr 2025 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744318717;
	bh=3AaCUynHyZgUbfT/x+PuBXtQ33kvzMSvNXxqvkzyius=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjgiK6CrrhYXMZZj8KYq9ZLldhgcmqyoNxyb7lubC+dM6sihEsMXpulEf83f+MzKi
	 JEWlE+k2ggvcJq5lx+df49VZ1rbJDE5XuJDXde7hhhMFOv48Iio37q0jztRlziqDCG
	 T8ejJblh3SJjr3eL6TXktCbk7VY2qFPTV9GQtWmclQ9vGsFT1gWPkj+yCjBAqyagk7
	 XWvE0pmv75fDIufAzptXZDhmEC8Kz1eAZKcSmwOjX1pHO6kwzL7Ff4b7ctSpN9cVpW
	 vrEj9YFE3pJn+hQrrmUTl3ghBNYv6ExqkMqmLqsaBevHioZ0DPfuVG43PEy68QE4Yz
	 Qhcp1BJj8L/HQ==
Date: Thu, 10 Apr 2025 13:58:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	mpetlan@redhat.com, tglozar@redhat.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3] perf test probe_vfs_getname: Skip if no suitable line
 detected
Message-ID: <Z_gw-xw97c_IWdXw@google.com>
References: <20250324144523.597557-1-jbrnak@redhat.com>
 <Z_fWa093x33Wcwrw@jbrnak-thinkpadx1carbongen9.tpbc.csb>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_fWa093x33Wcwrw@jbrnak-thinkpadx1carbongen9.tpbc.csb>

Hello,

On Thu, Apr 10, 2025 at 04:32:11PM +0200, Jakub Brnak wrote:
> On Mon, Mar 24, 2025 at 03:45:23PM +0100, Jakub Brnak wrote:
> > In some cases when calling function add_probe_vfs_getname, line number
> > can't be detected by perf probe -L getname_flags:
> > 
> >   78         atomic_set(&result->refcnt, 1);
> > 
> > 	     // one of the following lines should have line number
> > 	     // but sometimes it does not because of optimization
> > 	     result->uptr = filename;
> >              result->aname = NULL;
> > 
> >   81         audit_getname(result);
> > 
> > To prevent false failures, skip the affected tests
> > if no suitable line numbers can be detected.
> > 
> > Signed-off-by: Jakub Brnak <jbrnak@redhat.com>

Sorry for the long delay.  It looks ok to me.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> > ---
> > v3:
> > - ensure POSIX compliance
> > 
> > v2: 
> > https://lore.kernel.org/linux-perf-users/Z9tKat6vvC1XUj0U@google.com/
> > - check if return from add_vfs_getname equals to 1
> > sice it is only option in case of fail 
> > 
> > v1:
> >  https://lore.kernel.org/linux-perf-users/Z8pAep0GJsMFTyEi@google.com/T/#t
> > ---
> >  tools/perf/tests/shell/lib/probe_vfs_getname.sh          | 8 +++++++-
> >  tools/perf/tests/shell/probe_vfs_getname.sh              | 8 +++++++-
> >  .../perf/tests/shell/record+script_probe_vfs_getname.sh  | 8 +++++++-
> >  tools/perf/tests/shell/trace+probe_vfs_getname.sh        | 9 +++++++--
> >  4 files changed, 28 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > index 5c33ec7a5a63..89f72a4c818c 100644
> > --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > @@ -19,8 +19,14 @@ add_probe_vfs_getname() {
> >  			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
> >  			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
> >  		fi
> > +
> > +		if [ -z "$line" ] ; then
> > +			echo "Could not find probeable line"
> > +			return 2
> > +		fi
> > +
> >  		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> > -		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
> > +		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
> >  	fi
> >  }
> >  
> > diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
> > index c51a32931af6..0f52654c914a 100755
> > --- a/tools/perf/tests/shell/probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/probe_vfs_getname.sh
> > @@ -13,7 +13,13 @@ skip_if_no_perf_probe || exit 2
> >  # shellcheck source=lib/probe_vfs_getname.sh
> >  . "$(dirname $0)"/lib/probe_vfs_getname.sh
> >  
> > -add_probe_vfs_getname || skip_if_no_debuginfo
> > +add_probe_vfs_getname
> >  err=$?
> > +
> > +if [ $err -eq 1 ] ; then
> > +	skip_if_no_debuginfo
> > +	err=$?
> > +fi
> > +
> >  cleanup_probe_vfs_getname
> >  exit $err
> > diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> > index fd5b10d46915..1ad252f0d36e 100755
> > --- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> > @@ -35,8 +35,14 @@ perf_script_filenames() {
> >  	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
> >  }
> >  
> > -add_probe_vfs_getname || skip_if_no_debuginfo
> > +add_probe_vfs_getname
> >  err=$?
> > +
> > +if [ $err -eq 1 ] ; then
> > +        skip_if_no_debuginfo
> > +        err=$?
> > +fi
> > +
> >  if [ $err -ne 0 ] ; then
> >  	exit $err
> >  fi
> > diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > index 60fccb62c540..5d5019988d61 100755
> > --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > @@ -25,9 +25,14 @@ trace_open_vfs_getname() {
> >  	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
> >  }
> >  
> > -
> > -add_probe_vfs_getname || skip_if_no_debuginfo
> > +add_probe_vfs_getname
> >  err=$?
> > +
> > +if [ $err -eq 1 ] ; then
> > +        skip_if_no_debuginfo
> > +        err=$?
> > +fi
> > +
> >  if [ $err -ne 0 ] ; then
> >  	exit $err
> >  fi
> > -- 
> > 2.48.1
> > 
> 
> Hi, anyone interested in this patch?
> 
> Thanks,
> Jakub
> 
