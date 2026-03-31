Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E2371D09
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940202; cv=none; b=kX4tduk9dp4kx/G1CND4Pg8fo3VZOEcb9WZumLB4DomUMCeZEvCKtQfKWB94Yz84/HeyshFMKddAKYK9X9wAp/UUP5hJhVGXPtkLYetmgmQd+sInr9X7pTwjTZtLr9mCZrH6MI7lkQRwfND1pqD4ULldImq+4y/9Ff9LUfSc67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940202; c=relaxed/simple;
	bh=D7MxuOi8KI6bZqP+w1RUt5iGTAhET4LGj8dP1dYXWIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQHuRnyvIFe5m8mAgB53GNjmD11u1aMvIaK6sABItkMqKKMvl5oIFrAL8ITvzlgsaSwsJENXV1jVDmypdCHl0T91v7XdhsBpw71aoxCmgzwiwMO/oG1h33wcll4FtLox2FjYGkjRtBm3JXnM1lSOpq1AQZx4oklAnXsEgEmhv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIG4GRU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIG4GRU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85EAC19423;
	Tue, 31 Mar 2026 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774940202;
	bh=D7MxuOi8KI6bZqP+w1RUt5iGTAhET4LGj8dP1dYXWIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIG4GRU5hJash20KUYnVmszeohqcAcMHyctn7TVJoBboA+Z78K4a58PFizQsVUwaH
	 U7cSC9yTCRmcRv76JvWDfIlQzfV9yY+xLfbRepNIFlxmxGNpAemvGd5rRSXfVqLNiZ
	 ePa4U1QsgYTUfCtdvzXqPZ4UpLeD8eDrfJp821rpU5i6SixoxCSn1Qiy7kDmp5XIvD
	 eMZ+Tau2ayAQC2jWbl3aNZ54X6wNyQolLvWeehXeP6uB97IDzXOsCrXpQjOLQkpB9m
	 bV3iAqbujbmpOeQ11Uo/5BE+ugNAJxTEPc1b3B/aYOoLTFD1K0+yrQCENsw+XiWJ0n
	 z19Slwk/GzL0Q==
Date: Mon, 30 Mar 2026 23:56:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
	maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH V2] tools/perf/tests: Update test_adding_kernel.sh to
 handle proper debuginfo check
Message-ID: <actwKNAzk6PnoBDX@google.com>
References: <20260323122424.88068-1-atrajeev@linux.ibm.com>
 <acW9tz0KZWgaJjTV@google.com>
 <3E20DA19-2C2A-45EC-A2AA-7C05CE89C4FE@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E20DA19-2C2A-45EC-A2AA-7C05CE89C4FE@linux.ibm.com>

On Fri, Mar 27, 2026 at 11:26:48PM +0530, Athira Rajeev wrote:
> 
> 
> > On 27 Mar 2026, at 4:43 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > On Mon, Mar 23, 2026 at 05:54:24PM +0530, Athira Rajeev wrote:
> >> Perf test perftool-testsuite_probe fails as below:
> >> 
> >> Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
> >> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
> >> -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
> >> Regexp not found: "probe:vfs_mknod"
> >> Regexp not found: "probe:vfs_create"
> >> Regexp not found: "probe:vfs_rmdir"
> >> Regexp not found: "probe:vfs_link"
> >> Regexp not found: "probe:vfs_write"
> >> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
> >> Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
> >> Regexp not found: "in this function|at this address"
> >> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
> >> ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
> >> 
> >> Further analysing, the failed testcase is for "test_adding_kernel".
> >> If the kernel debuginfo is missing, perf probe fails as below:
> >> 
> >> perf probe -nf --max-probes=512 -a 'vfs_* $params'
> >> Failed to find the path for the kernel: No such file or directory
> >>  Error: Failed to add events.
> >> 
> >> skip_if_no_debuginfo has check to handle whether debuginfo is present
> >> and the testcase checks for debuginfo since this :
> >> commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
> >> testcases fail when kernel debuginfo is not present")
> >> 
> >> Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
> >> via this another fix:
> >> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> >> line detected")
> >> Since this commit, first add_probe_vfs_getname is used to prevent false
> >> failures. And based on return code of add_probe_vfs_getname, skip_if_no_debuginfo
> >> is used to skip testcase if debuginfo is present. And this modified other
> >> testcases to call add_probe_vfs_getname first and invoke
> >> skip_if_no_debuginfo based on return value.
> >> 
> >> The tests in test_adding_kernel.sh which depends on presence of
> >> debuginfo are:
> >> 1. probe add for inode_permission
> >> 2. probe max-probes option using 'vfs_* $params'
> >> 3. non-existing variable probing
> >> 
> >> For these tests, probe check for specific line is not required.
> >> So call skip_if_no_debuginfo with argument to say if line check is
> >> needed. This is to convey to skip_if_no_debuginfo() function
> >> that test only needs to check for debuginfo, and not specifically
> >> line number. Update skip_if_no_debuginfo to use simple "perf probe"
> >> check if test only needs to check for debuginfo. And for other
> >> tests which rely on line number, use add_probe_vfs_getname()
> >> 
> >> With the change, verified that only three which required debuginfo only
> >> is skipped and others ran successfully. Also tested with debuginfo
> >> to make sure tests are not skipped.
> >> 
> >> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
> >> Reviewed-by: Ian Rogers <irogers@google.com>
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >> ---
> >> Changelog:
> >> - First version used "perf probe -v -L getname_flags" for debuginfo
> >>  check. This will not catch fail string "Debuginfo-analysis is not
> >> supported" which is used in cases when perf is built without dwarf.
> >> So use "perf probe -vn add inode_permission" to capture cases when
> >> tools built with NO_LIBDWARF=1. This will capture debuginfo missing as
> >> well as tool built without dwarf case.
> >> 
> >> .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
> >> tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
> >> 2 files changed, 26 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> >> index 555a825d55f2..f3db125c8669 100755
> >> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> >> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> >> @@ -23,10 +23,23 @@ TEST_RESULT=0
> >> . "$DIR_PATH/../lib/probe_vfs_getname.sh"
> >> 
> >> TEST_PROBE=${TEST_PROBE:-"inode_permission"}
> >> +PROBE_NO_LINE_CHECK=1
> > 
> > I'm not sure I follow but shouldn't it depend on the return value of
> > `perf check feature -q dwarf`?
> > 
> > Thanks,
> > Namhyung
> 
> Hi Namhyung
> 
> Thanks for checking the patch.
> 
> Yes, "perf check feature -q dwarf” checks if perf is compiled with dwarf support.
> But for “test_adding_kernel” , we need to check if kernel debuginfo is missing.
> The check this path is trying to, also includes “debuginfo”
> 
> In environment without debuginfo: perftool-testsuite_probe fails as below:
> 
> Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
> Regexp not found: "probe:vfs_mknod"
> Regexp not found: "probe:vfs_create"
> Regexp not found: "probe:vfs_rmdir"
> Regexp not found: "probe:vfs_link"
> Regexp not found: "probe:vfs_write"
> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
> Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
> Regexp not found: "in this function|at this address"
> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
> ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
> 
> We have “skip_if_no_debuginfo” check in tools/perf/tests/shell/lib/probe_vfs_getname.sh and
> “test_adding_kernel” calls this to find out presence of debuginfo. 
> 
> Recently a change got added via commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected”) where we return if specific line is not found using perf probe. And hence debuginfo check is not
> happening.
> 
> 
> The tests in test_adding_kernel.sh which depends on presence of
> debuginfo are:
> 1. probe add for inode_permission
> 2. probe max-probes option using 'vfs_* $params'
> 3. non-existing variable probing
> 
> For these tests, probe check for specific line is not required. So this patch updates
> skip_if_no_debuginfo to use an argument that communicates whether line check is needed.
> If only debuginfo/dwarf check is required, use simple "perf probe”. And for other
> tests which rely on line number, fallback to default add_probe_vfs_getname().
 
Ok, thanks for the explanation.  But I'm afraid you didn't change other
callsites to pass 0 explicitly.

> > 
> >> 
> >> # set NO_DEBUGINFO to skip testcase if debuginfo is not present
> >> # skip_if_no_debuginfo returns 2 if debuginfo is not present
> >> -skip_if_no_debuginfo
> >> +#
> >> +# The perf probe checks which depends on presence of debuginfo and
> >> +# used in this testcase are:
> >> +# 1. probe add for inode_permission
> >> +# 2. probe max-probes option using 'vfs_* $params'
> >> +# 3. non-existing variable probing
> >> +#
> >> +# For these tests, probe check for specific line is not
> >> +# required ( add_probe_vfs_getname does that ). So call
> >> +# skip_if_no_debuginfo with argument as 1. This is to convey
> >> +# that test only needs to check for debuginfo, and not specifically
> >> +# line number
> >> +skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
> >> if [ $? -eq 2 ]; then
> >> NO_DEBUGINFO=1
> >> fi
> >> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> >> index 88cd0e26d5f6..8ae2ea2bc8a2 100644
> >> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> >> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> >> @@ -39,7 +39,18 @@ add_probe_vfs_getname() {
> >> }
> >> 
> >> skip_if_no_debuginfo() {
> >> - add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
> >> + no_line_check=$1
> >> + debug_str="^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)"
> >> +
> >> + # search for debug_str using simple perf probe if the
> >> + # test only needs to check for debuginfo, and not specifically
> >> + # line number.
> >> + if [ $no_line_check -eq 1 ]; then
> >> + perf probe -vn add inode_permission 2>&1 | grep -E -q "$debug_str" && return 2

Sashiko found that it should be '--add' or '-a'.

Thanks,
Namhyung


> >> + else
> >> + add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
> >> + fi
> >> +
> >> return 1
> >> }
> >> 
> >> -- 
> >> 2.47.3
> 
> 
