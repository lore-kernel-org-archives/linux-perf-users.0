Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB04379EFE
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566842; cv=none; b=p5O/sa2frtELiBnbVDyCwglHx1UQmAWj6vfmhw34NpKvk/Q1Bt1TvMctq3vptZFeWdWeCujIn3jk/ueaYXgX8pAyrAhip2+/Dx++nivDMJWWIU60AJp/1u72sxTVcvjKPkksXdbfrJ1O4kb2udn5RigumUaf94mQAMi4uaYfDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566842; c=relaxed/simple;
	bh=u4RJ9O9+gfXzZdgVUzGMPLSaeyo9wy6XkYU3+iZapro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyrBbzCQZMVe0bmRLOHhshjRbDV/c8xGb5LzCOvTxDYky3NX/4eIVBsl2D6I8rzkjyGb/E0A714UmYz8XR0GPg47A/1eh1yCNOBbxKSvQaY6D26R1wMPEoPMABKMcgB6HDzMRMWUqrSNuX0rnRiE6DGh12ck8hxEGeC8BObJS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNBLxSpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNBLxSpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114F7C116C6;
	Thu, 26 Mar 2026 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774566841;
	bh=u4RJ9O9+gfXzZdgVUzGMPLSaeyo9wy6XkYU3+iZapro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNBLxSpT8m0Y225KbDt7EmVCPTEJwk2vNx3zJHGXsbiR+NmUXZTrtwzcuxSNoB1Pw
	 M89Pj6iIuSYR69cZ0n3Lk1lPbj+UH/ZHc91/BhZRVcyBbjV1E4de/ciEWpQNpOGyMF
	 jTUsmOtr+10btwiudAeOjdRWNGx5sr8KzH/1Jp+tw9EhgUrMx0urtd+c1hJpPLMurx
	 UqsNISL/4aMr5tx02hePlxltfXaASI0ShUBw1Dj58I4KYTkV6dHraA7RNTmFBhcSO7
	 t1/aXIzRHcYC8gn13U3DbiO+X7JAIWkEi6qcM3RydJ90aOJXTERcs2hICJFIotMb9h
	 hdeintXqns3Tg==
Date: Thu, 26 Mar 2026 16:13:59 -0700
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
Message-ID: <acW9tz0KZWgaJjTV@google.com>
References: <20260323122424.88068-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323122424.88068-1-atrajeev@linux.ibm.com>

On Mon, Mar 23, 2026 at 05:54:24PM +0530, Athira Rajeev wrote:
> Perf test perftool-testsuite_probe fails as below:
> 
>  Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
>  -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
>  Regexp not found: "probe:vfs_mknod"
>  Regexp not found: "probe:vfs_create"
>  Regexp not found: "probe:vfs_rmdir"
>  Regexp not found: "probe:vfs_link"
>  Regexp not found: "probe:vfs_write"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
>  Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>  Regexp not found: "in this function|at this address"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
>  ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
> 
> Further analysing, the failed testcase is for "test_adding_kernel".
> If the kernel debuginfo is missing, perf probe fails as below:
> 
> perf probe -nf --max-probes=512 -a 'vfs_* $params'
> Failed to find the path for the kernel: No such file or directory
>   Error: Failed to add events.
> 
> skip_if_no_debuginfo has check to handle whether debuginfo is present
> and the testcase checks for debuginfo since this :
> commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
> testcases fail when kernel debuginfo is not present")
> 
> Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
> via this another fix:
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected")
> Since this commit, first add_probe_vfs_getname is used to prevent false
> failures. And based on return code of add_probe_vfs_getname, skip_if_no_debuginfo
> is used to skip testcase if debuginfo is present. And this modified other
> testcases to call add_probe_vfs_getname first and invoke
> skip_if_no_debuginfo based on return value.
> 
> The tests in test_adding_kernel.sh which depends on presence of
> debuginfo are:
> 1. probe add for inode_permission
> 2. probe max-probes option using 'vfs_* $params'
> 3. non-existing variable probing
> 
> For these tests, probe check for specific line is not required.
> So call skip_if_no_debuginfo with argument to say if line check is
> needed. This is to convey to skip_if_no_debuginfo() function
> that test only needs to check for debuginfo, and not specifically
> line number. Update skip_if_no_debuginfo to use simple "perf probe"
> check if test only needs to check for debuginfo. And for other
> tests which rely on line number, use add_probe_vfs_getname()
> 
> With the change, verified that only three which required debuginfo only
> is skipped and others ran successfully. Also tested with debuginfo
> to make sure tests are not skipped.
> 
> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changelog:
> - First version used "perf probe -v -L getname_flags" for debuginfo
>   check. This will not catch fail string "Debuginfo-analysis is not
> supported" which is used in cases when perf is built without dwarf.
>  So use "perf probe -vn add inode_permission" to capture cases when
>  tools built with NO_LIBDWARF=1. This will capture debuginfo missing as
> well as tool built without dwarf case.
> 
>  .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> index 555a825d55f2..f3db125c8669 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -23,10 +23,23 @@ TEST_RESULT=0
>  . "$DIR_PATH/../lib/probe_vfs_getname.sh"
>  
>  TEST_PROBE=${TEST_PROBE:-"inode_permission"}
> +PROBE_NO_LINE_CHECK=1

I'm not sure I follow but shouldn't it depend on the return value of
`perf check feature -q dwarf`?

Thanks,
Namhyung

>  
>  # set NO_DEBUGINFO to skip testcase if debuginfo is not present
>  # skip_if_no_debuginfo returns 2 if debuginfo is not present
> -skip_if_no_debuginfo
> +#
> +# The perf probe checks which depends on presence of debuginfo and
> +# used in this testcase are:
> +# 1. probe add for inode_permission
> +# 2. probe max-probes option using 'vfs_* $params'
> +# 3. non-existing variable probing
> +#
> +# For these tests, probe check for specific line is not
> +# required ( add_probe_vfs_getname does that ). So call
> +# skip_if_no_debuginfo with argument as 1. This is to convey
> +# that test only needs to check for debuginfo, and not specifically
> +# line number
> +skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
>  if [ $? -eq 2 ]; then
>  	NO_DEBUGINFO=1
>  fi
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f6..8ae2ea2bc8a2 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -39,7 +39,18 @@ add_probe_vfs_getname() {
>  }
>  
>  skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
> +	no_line_check=$1
> +	debug_str="^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)"
> +
> +	# search for debug_str using simple perf probe if the
> +	# test only needs to check for debuginfo, and not specifically
> +	# line number.
> +	if [ $no_line_check -eq 1 ]; then
> +		perf probe -vn add inode_permission 2>&1 | grep -E -q "$debug_str" && return 2
> +	else
> +		add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
> +	fi
> +
>  	return 1
>  }
>  
> -- 
> 2.47.3
> 
