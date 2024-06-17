Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EB823B8;
	Mon, 17 Jun 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636413; cv=none; b=e0EWrrw/GYFODDATU0rL5juVc42ZFX+wwTLq7iPOWcGPDUaE8NUQ/NR5bNSUNFZ1Zq+MnqTk1wV1QYvyjSVdSbUAcXhlx+hvqt9wiOifS0j8gWx6z7JBekJIIg6o4aF9vPaSKSISZ/oauzOOIftIj9VFHo2vJps6tBu/fdYwdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636413; c=relaxed/simple;
	bh=VtX9hVDLR0eiTAXx2qCuh+/KQ1kO+ysSwbv+qE8urU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah/NnrNMOWPS11pucyGQviYOCqK93rd/Qr2XAXXP954gYqSdmRBAr+0m7u1tTY6IQynKVfIa2wMJAPcXddGh3b/NrTlp+n5eFLxtK2NuWTkZHUEDpYJhOhPlammxzeDm4YyRO2jzAT+l5hzt4ooMycFdHCdobgxgbwiwD1VteSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F7CEDA7;
	Mon, 17 Jun 2024 08:00:35 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9E03F6A8;
	Mon, 17 Jun 2024 08:00:08 -0700 (PDT)
Message-ID: <588beeaf-2015-40f4-a34b-e36556e20707@arm.com>
Date: Mon, 17 Jun 2024 16:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf: Handle perftool-testsuite_probe testcases
 fail when kernel debuginfo is not present
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, acme@kernel.org,
 jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
 namhyung@kernel.org
References: <20240617122121.7484-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240617122121.7484-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/06/2024 13:21, Athira Rajeev wrote:
> Running "perftool-testsuite_probe" fails as below:
> 
> 	./perf test -v "perftool-testsuite_probe"
> 	83: perftool-testsuite_probe  : FAILED
> 
> There are three fails:
> 
> 1. Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
> 

On a machine where NO_DEBUGINFO gets set, this one skips for me. But on
a machine where there _is_ debug info this test still fails.

But in both cases the probe looks like it was added successfully. So I'm
wondering if this one does need to be skipped, or it's just always
failing? Do you have this test passing anywhere where there is debug info?

The list command looks like it successfully lists the probe for me in
both cases, it just doesn't have an address on the end:

 perf list 'probe:*'

   probe:inode_permission (on inode_permission)

Does the missing address mean anything or is it just not handled
properly by the test?

Ironically the machine that _does_ pass the debug info test also prints
this, but it looks like it still adds and lists the probe correctly:

  perf probe -l probe:*

  Failed to find debug information for address 0xffff80008047ac30
    probe:inode_permission (on inode_permission)


> 2. Regexp not found: "probe:vfs_mknod"
>    Regexp not found: "probe:vfs_create"
>    Regexp not found: "probe:vfs_rmdir"
>    Regexp not found: "probe:vfs_link"
>    Regexp not found: "probe:vfs_write"
>    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
> 
> 3. Regexp not found: "Failed to find"
>    Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>    Regexp not found: "in this function|at this address"
>    Line did not match any pattern: "The /boot/vmlinux file has no debug information."
>    Line did not match any pattern: "Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo package."
> 
> These three tests depends on kernel debug info.
> 1. Fail 1 expects file name along with probe which needs debuginfo
> 2. Fail 2 :
>     perf probe -nf --max-probes=512 -a 'vfs_* $params'
>     Debuginfo-analysis is not supported.
>      Error: Failed to add events.
> 
> 3. Fail 3 :
>    perf probe 'vfs_read somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64'
>    Debuginfo-analysis is not supported.
>    Error: Failed to add events.
> 
> There is already helper function skip_if_no_debuginfo in
> lib/probe_vfs_getname.sh which does perf probe and returns
> "2" if debug info is not present. Use the skip_if_no_debuginfo
> function and skip only the three tests which needs debuginfo
> based on the result.
> 
> With the patch:
> 
>     83: perftool-testsuite_probe:
>    --- start ---
>    test child forked, pid 3927
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission ::
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: -a
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: --add
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf list
>    Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 2 2 Skipped due to missing debuginfo :: testcase skipped
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe (should NOT be listed)
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: first probe adding
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (without force)
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (with force)
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
>    Regexp not found: "probe:vfs_mknod"
>    Regexp not found: "probe:vfs_create"
>    Regexp not found: "probe:vfs_rmdir"
>    Regexp not found: "probe:vfs_link"
>    Regexp not found: "probe:vfs_write"
>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 2 2 Skipped due to missing debuginfo :: testcase skipped
>    Regexp not found: "Failed to find"
>    Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>    Regexp not found: "in this function|at this address"
>    Line did not match any pattern: "The /boot/vmlinux file has no debug information."
>    Line did not match any pattern: "Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo package."
>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 2 2 Skipped due to missing debuginfo :: testcase skipped
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: add
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: record
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument probing :: script
>    ## [ PASS ] ## perf_probe :: test_adding_kernel SUMMARY
>    ---- end(0) ----
>    83: perftool-testsuite_probe                                        : Ok
> 
> Only the three specific tests are skipped and remaining
> ran successfully.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  .../shell/base_probe/test_adding_kernel.sh    | 31 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> index 63bb8974b38e..187dc8d4b163 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -21,8 +21,18 @@
>  THIS_TEST_NAME=`basename $0 .sh`
>  TEST_RESULT=0
>  
> +# shellcheck source=lib/probe_vfs_getname.sh
> +. "$(dirname "$0")/../lib/probe_vfs_getname.sh"
> +
>  TEST_PROBE=${TEST_PROBE:-"inode_permission"}
>  
> +# set NO_DEBUGINFO to skip testcase if debuginfo is not present
> +# skip_if_no_debuginfo returns 2 if debuginfo is not present
> +skip_if_no_debuginfo
> +if [ $? -eq 2 ]; then
> +	NO_DEBUGINFO=1
> +fi
> +
>  check_kprobes_available
>  if [ $? -ne 0 ]; then
>  	print_overall_skipped
> @@ -67,7 +77,12 @@ PERF_EXIT_CODE=$?
>  ../common/check_all_patterns_found.pl "\s*probe:${TEST_PROBE}(?:_\d+)?\s+\(on ${TEST_PROBE}(?:[:\+]$RE_NUMBER_HEX)?@.+\)" < $LOGS_DIR/adding_kernel_list-l.log
>  CHECK_EXIT_CODE=$?
>  
> -print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf probe -l"
> +if [ $NO_DEBUGINFO ] ; then
> +	print_testcase_skipped $NO_DEBUGINFO $NO_DEBUGINFO "Skipped due to missing debuginfo"
> +else
> +	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf probe -l"
> +fi
> +
>  (( TEST_RESULT += $? ))
>  
>  
> @@ -208,7 +223,12 @@ PERF_EXIT_CODE=$?
>  ../common/check_all_patterns_found.pl "probe:vfs_mknod" "probe:vfs_create" "probe:vfs_rmdir" "probe:vfs_link" "probe:vfs_write" < $LOGS_DIR/adding_kernel_adding_wildcard.err
>  CHECK_EXIT_CODE=$?
>  
> -print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "wildcard adding support"
> +if [ $NO_DEBUGINFO ] ; then
> +	print_testcase_skipped $NO_DEBUGINFO $NO_DEBUGINFO "Skipped due to missing debuginfo"
> +else
> +	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "wildcard adding support"
> +fi
> +
>  (( TEST_RESULT += $? ))
>  
>  
> @@ -232,7 +252,12 @@ CHECK_EXIT_CODE=$?
>  ../common/check_no_patterns_found.pl "$RE_SEGFAULT" < $LOGS_DIR/adding_kernel_nonexisting.err
>  (( CHECK_EXIT_CODE += $? ))
>  
> -print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing variable"
> +if [ $NO_DEBUGINFO ]; then
> +	print_testcase_skipped $NO_DEBUGINFO $NO_DEBUGINFO "Skipped due to missing debuginfo"
> +else
> +	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing variable"
> +fi
> +
>  (( TEST_RESULT += $? ))
>  
>  
