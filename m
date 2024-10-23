Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CC14EC62;
	Wed, 23 Oct 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715055; cv=none; b=lsxtezJ2HkaR8XEjL98gOmRUfPHFiqUyFOp//bVxBgEQMPt4J0vfG2/o8ffL1nRJDgoQQR4d0cWSMQ62w83RvpKGfo50eRnomZowvu2eCwAhZf61y0F6QV25udIGz1t+tc91JR1QZfCvqGZC3o62awi9bCFlb6pbl2j9epJh57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715055; c=relaxed/simple;
	bh=BlgLFVi9BOXbusOcDAl1qyQmxS9LNlPv5ENh5+eQVhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwmewI/dinH9eHI+CTOD1IMCEA/rnnyZ3uR/a/BRl0/psvz08WXuuA8xAFn8gKLkJubvYAHUDCFSB9mfjfQw/O4saza8ygKL9qF0qAXzxZqfWBaJAB7fzjrCXG7bR1fG9VBI5X45YCzOvrUH9MR2f38xyzUAYaHaxw4Sfp5s9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/EyUbTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/EyUbTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E4CC4CEC6;
	Wed, 23 Oct 2024 20:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715053;
	bh=BlgLFVi9BOXbusOcDAl1qyQmxS9LNlPv5ENh5+eQVhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/EyUbTZtQRKhmaIicmx1lg30QFPzaQEl3Xghdj2drn+cdpGQ3/zLxGca8yCrWk9y
	 kkruTIGhwwrX2Wpwa7K/ERPKR7zzZoR4J1b7eSgTvl5wx3T0hJOUZ93SOYIyG8pyIQ
	 Bvt8PZGtJwKBqURhRPY7Z8zeZqFwQYIOoDY96xXBbDTCNDuJdiR9sXh5gtEawx1TRg
	 oOMB7bQ8rrVabnDQxxAjewzrbOAvQ9EMhyp9j07bOOud5hEz5xjYGUne8jwNhWyWB/
	 rQcB8543fEsLC+Pg2Mb7h6S6T80FzwvnYq5+s88hnOv7iM9fr9bkYpXO1ShJUBh7K1
	 YbwU7OgeAg6FA==
Date: Wed, 23 Oct 2024 17:24:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Handle perftool-testsuite_probe failure
 due to broken DWARF
Message-ID: <ZxlbakzNhwDTTlWf@x1>
References: <Zw_mutl867MINXPi@x1>
 <20241017161555.236769-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017161555.236769-1-vmolnaro@redhat.com>

On Thu, Oct 17, 2024 at 06:15:55PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Test case test_adding_blacklisted ends in failure if the blacklisted
> probe is of an assembler function with no DWARF available. At the same
> time, probing the blacklisted function with ASM DWARF doesn't test the
> blacklist itself as the failure is a result of the broken DWARF.
> 
> When the broken DWARF output is encountered, check if the probed
> function was compiled by the assembler. If so, the broken DWARF message
> is expected and does not report a perf issue, else report a failure.
> If the ASM DWARF affected the probe, try the next probe on the blacklist.
> If the first 5 probes are defective due to broken DWARF, skip the test
> case.

Tested and applied to perf-tools.

- Arnaldo
 
> Fixes: def5480d63c1e847 ("perf testsuite probe: Add test for blacklisted kprobes handling")
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  .../base_probe/test_adding_blacklisted.sh     | 69 +++++++++++++++----
>  1 file changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> index b5dc10b2a73810b3..bead723e34af3f0e 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> @@ -19,35 +19,74 @@
>  TEST_RESULT=0
>  
>  # skip if not supported
> -BLACKFUNC=`head -n 1 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
> -if [ -z "$BLACKFUNC" ]; then
> +BLACKFUNC_LIST=`head -n 5 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
> +if [ -z "$BLACKFUNC_LIST" ]; then
>  	print_overall_skipped
>  	exit 0
>  fi
>  
> +# try to find vmlinux with DWARF debug info
> +VMLINUX_FILE=$(perf probe -v random_probe |& grep "Using.*for symbols" | sed -r 's/^Using (.*) for symbols$/\1/')
> +
>  # remove all previously added probes
>  clear_all_probes
>  
>  
>  ### adding blacklisted function
> -
> -# functions from blacklist should be skipped by perf probe
> -! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOGS_DIR/adding_blacklisted.err
> -PERF_EXIT_CODE=$?
> -
>  REGEX_SCOPE_FAIL="Failed to find scope of probe point"
>  REGEX_SKIP_MESSAGE=" is blacklisted function, skip it\."
> -REGEX_NOT_FOUND_MESSAGE="Probe point \'$BLACKFUNC\' not found."
> +REGEX_NOT_FOUND_MESSAGE="Probe point \'$RE_EVENT\' not found."
>  REGEX_ERROR_MESSAGE="Error: Failed to add events."
>  REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
>  REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
> -REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
> -../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> -CHECK_EXIT_CODE=$?
> -
> -print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
> -(( TEST_RESULT += $? ))
> -
> +REGEX_OUT_SECTION="$RE_EVENT is out of \.\w+, skip it"
> +REGEX_MISSING_DECL_LINE="A function DIE doesn't have decl_line. Maybe broken DWARF?"
> +
> +BLACKFUNC=""
> +SKIP_DWARF=0
> +
> +for BLACKFUNC in $BLACKFUNC_LIST; do
> +	echo "Probing $BLACKFUNC"
> +
> +	# functions from blacklist should be skipped by perf probe
> +	! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOGS_DIR/adding_blacklisted.err
> +	PERF_EXIT_CODE=$?
> +
> +	# check for bad DWARF polluting the result
> +	../common/check_all_patterns_found.pl "$REGEX_MISSING_DECL_LINE" >/dev/null < $LOGS_DIR/adding_blacklisted.err
> +
> +	if [ $? -eq 0 ]; then
> +		SKIP_DWARF=1
> +		echo "Result polluted by broken DWARF, trying another probe"
> +
> +		# confirm that the broken DWARF comes from assembler
> +		if [ -n "$VMLINUX_FILE" ]; then
> +			readelf -wi "$VMLINUX_FILE" |
> +			awk -v probe="$BLACKFUNC" '/DW_AT_language/ { comp_lang = $0 }
> +						   $0 ~ probe { if (comp_lang) { print comp_lang }; exit }' |
> +			grep -q "MIPS assembler"
> +
> +			CHECK_EXIT_CODE=$?
> +			if [ $CHECK_EXIT_CODE -ne 0 ]; then
> +				SKIP_DWARF=0 # broken DWARF while available
> +				break
> +			fi
> +		fi
> +	else
> +		../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> +		CHECK_EXIT_CODE=$?
> +
> +		SKIP_DWARF=0
> +		break
> +	fi
> +done
> +
> +if [ $SKIP_DWARF -eq 1 ]; then
> +	print_testcase_skipped "adding blacklisted function $BLACKFUNC"
> +else
> +	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
> +	(( TEST_RESULT += $? ))
> +fi
>  
>  ### listing not-added probe
>  
> -- 
> 2.43.0
> 
