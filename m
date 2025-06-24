Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C2126C05;
	Tue, 24 Jun 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787767; cv=none; b=i1Quum4CWS3/NwuKbSMg86Aue/G0dHy/yAb/QkeeLHle7yvsnQMjUmtBs37hU981KBZJp5KJoLE84Dsmqa9AbXQ0aE6i+FhLya6u2MYA0f1n9aWTgSnW3+YfNVu1yEFCIXSnvn7PkR7re++4R0L+afQ4tPivWDVUICCRMGjmtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787767; c=relaxed/simple;
	bh=guF7Vvhho0jqz/1Z71mXNiQ+L7CCP+rSBGsLZ9Yc3Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7ni6nasyscxxAzUuKet1NyUFI4J/aT2qsckQ7W2Ve1NyvU2T0G9H6OxQpNaPRs+H/d4VvI6fxDFMaME/Pk/s5y08NjZlXg299pgAkpLCP5HMUVAX4PoJHvKfoK83OOR9Q3IV3kqexOQI5r57KMlY4qaQ9loaiQpTyY8qt3uT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTuIU7wS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTuIU7wS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFDEC4CEE3;
	Tue, 24 Jun 2025 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750787767;
	bh=guF7Vvhho0jqz/1Z71mXNiQ+L7CCP+rSBGsLZ9Yc3Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTuIU7wSrz9WyrTzTPcvHw4r8ekW15ezCVFdTeMkTz1agG4aIAYYhmmYn9A/rLlWa
	 Ma9qGHuHFU9MyIXbAhN1nhUnzH9OQflEvD10agU1R6SMlIkvLJoJIOhvoRMVUe3T7S
	 uUbr70yQFkv0MXePnqAe0ofU5kLQx2U55M/1iB1nlqb2V6Z58MFxYI+Vnhf3uWul3q
	 rqSuLii29MtTxuNkb8wYHfDI1S1TYf5JVT6cxV1uvMAZkmx2+2izrBHsuYA1HHasP6
	 VYwxQDjtP3onzGnM9e/1AXDwLVQpSH0INz+SWO+brX9+Gcn0Q8lH+ifsjjMGWUmpc6
	 K+soGrofb6s4A==
Date: Tue, 24 Jun 2025 10:56:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Chun-Tse Shao <ctshao@google.com>, wy.shih90@gmail.com,
	Ian Rogers <irogers@google.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	tmricht@linux.ibm.com, leo.yan@arm.com, atrajeev@linux.vnet.ibm.com,
	linux-perf-users@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf test: Replace grep perl regexp with awk
Message-ID: <aFrmtGhq2Di0OrD_@google.com>
References: <20250620174034.819894-1-ctshao@google.com>
 <e8c28a7e-bc08-4c50-96ca-afe62cfcf9fd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8c28a7e-bc08-4c50-96ca-afe62cfcf9fd@linaro.org>

Hello,

On Mon, Jun 23, 2025 at 03:12:00PM +0100, James Clark wrote:
> 
> 
> On 20/06/2025 6:40 pm, Chun-Tse Shao wrote:
> > perl is not universal on all machines and should be replaced with awk,
> > which is much more common.
> > 
> > Before:
> >    $ perf test "probe libc's inet_pton & backtrace it with ping" -v
> >    --- start ---
> >    test child forked, pid 145431
> >    grep: Perl matching not supported in a --disable-perl-regexp build
> > 
> >    FAIL: could not add event
> >    ---- end(-1) ----
> >    121: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> > After:
> >    $ perf test "probe libc's inet_pton & backtrace it with ping" -v
> >    121: probe libc's inet_pton & backtrace it with ping                 : Ok
> > 
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >   tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > index c4bab5b5cc59..aaa5ee06ae18 100755
> > --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > @@ -23,7 +23,8 @@ event_pattern='probe_libc:inet_pton(\_[[:digit:]]+)?'
> >   add_libc_inet_pton_event() {
> > 
> >   	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | head -n -5 | \
> > -			grep -P -o "$event_pattern(?=[[:space:]]\(on inet_pton in $libc\))")
> > +			awk -v ep="$event_pattern" -v l="$libc" '$0 ~ ep && $0 ~ \
> > +			("\\(on inet_pton in " l "\\)") {print $1}')
> > 
> >   	if [ $? -ne 0 ] || [ -z "$event_name" ] ; then
> >   		printf "FAIL: could not add event\n"
> > --
> > 2.50.0.rc2.701.gf1e915cc24-goog
> > 
> 
> Minor nit: the underscore in event_pattern (not shown in the diff) never
> needed to be escaped.
> 
> But now we're using awk it gives a warning so we should remove it in case
> anyone is searching through the output:
> 
>   awk: warning: escape sequence `\_' treated as plain `_'
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
 
Thanks for your review.  I'll fold the below change.

---8<---
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index aaa5ee06ae1833de..9bdf47aabe9d738b 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -18,7 +18,7 @@
 libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
 nm -Dg $libc 2>/dev/null | grep -F -q inet_pton || exit 254
 
-event_pattern='probe_libc:inet_pton(\_[[:digit:]]+)?'
+event_pattern='probe_libc:inet_pton(_[[:digit:]]+)?'
 
 add_libc_inet_pton_event() {
 

