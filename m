Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933974;
	b=l0vbuDLtZwOuyqnhptxnIxF6A0VtcHLf0IfMhBG53stIccN1G0v0cpBq++yB5zTVDq5X
	 PKh6veMy6S/X493W1BbvxnV4Sq8wBNArMdwRzx8q/dvOWb+UxEH371Jf7jTKuwF+AGJRt
	 aRH68iTpcKbn7AR7b98EPfVZm1CsRQVLm1qlnU+TXYQmn7e4A9NcqvVz+KBg11ObLp2ip
	 Vc+T5HIFMTvsaZQbptHmDSTEaxbMkRCRPSEhAPagrG8mqNYaNQ0rh/RgFFy721AU8IR4O
	 cBr4Vo9T/WPeAga8W+1UyC9zT2UVByzToW+ChUbC3NzaLwpFu49gGihN45p579/DryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933974;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7Oh2e3u6KS6ULuWUXpjmzaKdyn+WALhzDQQ6dIp7NJA=;
	b=4PlVeHM+/XsarvAUaB5EMqgFTWxYFvzCsC4OI5Ul840593Ct3WojLBdcjuMENn+03Ah+
	 tWpw4VldzGR+s7mW6IDCZlO6WxcsBo2koHBYywk/ltdbi1z43Dv/W1Kfqm3OwlwkLIBc/
	 /N+bMDBZKQ7URrYFEkN8Bzu8R9FmUjFDU5alNl99juZxEMOVJoPjok3hSwnQIoe0B0Efo
	 1s9VHraaI5B318n487GS19HZR6q6pVfbTFtSoNGlDUYN5ZrlgV3pKLGVNlN4qi4m+eM1l
	 H9MOP5cLGQ4tiz2RcKbYs7wVD4Hq62XM/eTEgvubdT5HL8X2ESaG4wUOIbcI6fXYMJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzQTCYcy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF40606A31B;
	Fri,  6 Nov 2026 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzQTCYcy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5151F008A1;
	Fri,  6 Nov 2026 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793933974;
	bh=7Oh2e3u6KS6ULuWUXpjmzaKdyn+WALhzDQQ6dIp7NJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZzQTCYcy/PQbb/t3uEL68eJO0sRkJqL8iSDwwUk3XwGRqM9hNvhsbrcbcoz7sDA0L
	 Ehivnji6LT2gl5IIsGx4dtV06rMxzLNBzapL4AR4lDzAopL2eHX0aE6X+BjIXdr/WH
	 BcW8hzb4zh6WpDjuanZTKrdzSb2kB9lV3EO3ppX3PLjKq+egHqqiXtX4bnJBj4bzzS
	 vemfoAs4ZHSIhUY0NBTjSMmkwTzLfKFHsuxXv1Uk3pid/RQfqGTdJOwwTGK+NhdYFT
	 ZbrSqEP4CMhB/kFvop5UN0cO9bc397oAQ+amrX7AI2VjV+94Woc+j7eEgT64c+ZcwU
	 VrdoH+HnVCasA==
Date: Thu, 5 Nov 2026 18:59:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Jakub Brnak <jbrnak@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf test: Fix perf probe testsuite
Message-ID: <au1ClCsTbbOdc69U@z2>
References: <20261105071711.31086-1-namhyung@kernel.org>
 <ea9091fc-c129-4840-80f7-ab5edc8d56a7@linaro.org>
 <7fb3e764-e71d-4cd1-b481-963ea518dfd3@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fb3e764-e71d-4cd1-b481-963ea518dfd3@linaro.org>

Hello James,

On Thu, Nov 05, 2026 at 03:56:03PM +0000, James Clark wrote:
> 
> 
> On 05/11/2026 15:08, James Clark wrote:
> > 
> > 
> > On 05/11/2026 07:17, Namhyung Kim wrote:
> > > The perf probe test suite fails on my machine.  It seems it's because
> > > the kernel debug info is not available.  Actually NO_DEBUGINFO is to
> > > check the condition and skip affected tests.
> > > 
> > > But it didn't work well as the skip_if_no_debuginfo function misses a
> > > new error string for v7.0+ kernels.  Internally it uses the
> > > add_probe_vfs_getname() to check if perf probe handles debuginfo and
> > > check the error string.  But it didn't add the new error string.
> > > 
> > >    "Could not find probeable line"
> > > 
> > > With that added, it now passes like below:
> > > 
> > >    $ sudo perf test -vv 189
> > >    Not taking turns using the perf mlock budget: nothing can exhaust it
> > >    189: perftool-testsuite_probe:
> > >    ---- start ----
> > >    test child forked, pid 26135
> > >    Probing warn_thunk_thunk
> > >    -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: adding
> > > blacklisted function warn_thunk_thunk
> > >    -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing
> > > blacklisted probe (should NOT be listed)
> > >    ## [ PASS ] ## perf_probe :: test_adding_blacklisted SUMMARY
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe
> > > inode_permission ::
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe
> > > inode_permission :: -a
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe
> > > inode_permission :: --add
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added
> > > probe :: perf list
> > >    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped
> > > due to missing debuginfo :: testcase skipped
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added
> > > probe
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing
> > > removed probe (should NOT be listed)
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run ::
> > > adding probe
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding
> > > probes :: first probe adding
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding
> > > probes :: second probe adding (without force)
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding
> > > probes :: second probe adding (with force)
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing
> > > multiple probes
> > >    Regexp not found: "probe:vfs_mknod"
> > >    Regexp not found: "probe:vfs_create"
> > >    Regexp not found: "probe:vfs_rmdir"
> > >    Regexp not found: "probe:vfs_link"
> > >    Regexp not found: "probe:vfs_write"
> > >    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped
> > > due to missing debuginfo :: testcase skipped
> > >    Regexp not found:
> > > "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
> > >    Regexp not found: "in this function|at this address"
> > >    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped
> > > due to missing debuginfo :: testcase skipped
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with
> > > retval :: add
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with
> > > retval :: record
> > >    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function
> > > argument probing :: script
> > >    ## [ PASS ] ## perf_probe :: test_adding_kernel SUMMARY
> > >    -- [ SKIP ] -- perf_probe :: test_basic :: help message ::
> > > testcase skipped
> > >    -- [ PASS ] -- perf_probe :: test_basic :: usage message
> > >    -- [ PASS ] -- perf_probe :: test_basic :: quiet switch
> > >    ## [ PASS ] ## perf_probe :: test_basic SUMMARY
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing
> > > argument for -a
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing
> > > argument for -d
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing
> > > argument for -L
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing
> > > argument for -V
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary
> > > argument for -F
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary
> > > argument for -l
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -a xxx -d xxx
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -a xxx -L foo
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -a xxx -V foo
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -a xxx -l
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -a xxx -F
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -d xxx -L foo
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -d xxx -V foo
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -d xxx -l
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -d xxx -F
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -L foo -V bar
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -L foo -l
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -L foo -F
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -V foo -l
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -V foo -F
> > >    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually
> > > exclusive options :: -l -F
> > >    ## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: func
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: func:10
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: func:0-10
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: func:2+10
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: func@source.c
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: func@source.c:1
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: source.c:1
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: source.c:1+1
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable
> > > descriptions :: source.c:1-10
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable
> > > descriptions :: func:foo
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable
> > > descriptions :: func:1-foo
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable
> > > descriptions :: func:1+foo
> > >    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable
> > > descriptions :: func;lazy\*pattern
> > >    ## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
> > >    ---- end(0) ----
> > >    189: perftool-
> > > testsuite_probe                                                         
> > > : Ok
> > > 
> > > Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no
> > > suitable line detected")
> > > Cc: Jakub Brnak <jbrnak@redhat.com>
> > > Cc: Michael Petlan <mpetlan@redhat.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >   tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > > b/tools/ perf/tests/shell/lib/probe_vfs_getname.sh
> > > index 57a59ae7d4ae3d71..c091cd208beec056 100644
> > > --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > > +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > > @@ -64,7 +64,7 @@ add_probe_vfs_getname() {
> > >   }
> > >   skip_if_no_debuginfo() {
> > > -    add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find
> > > the path for the kernel|Debuginfo-analysis is not supported)|(file
> > > has no debug information)" && return 2
> > > +    add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find
> > > the path for the kernel|Debuginfo-analysis is not supported)|(file
> > > has no debug information|Could not find probeable line)" && return 2
> > >       return 1
> > >   }
> > 
> > I was just about to send a fix for the same thing, but I had something
> > slightly different. I think adding "Could not find probeable line"
> > allows for false skips in the future even when debug symbols are
> > present, like when that function was re-worked other times. And that
> > seems to be what Sashiko mentions as well.
> > 
> > If you just try to do a dry run probe of getname_flags() which has
> > always existed, then its a pretty stable equivalent for whether debug
> > info exists or not:
> > 
> >    perf probe -n -v 'getname_flags $params' 2>&1 | grep -E -q "^(Failed
> > to find the path for the kernel|Debuginfo-analysis is not supported)|
> > (file has no debug information)" && return 2
> > 
> 
> I included it here: https://lore.kernel.org/linux-perf-users/20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org/T/#t

Thanks, looks good.
Namhyung

