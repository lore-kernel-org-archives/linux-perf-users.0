Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09E12DD8A;
	Wed, 16 Oct 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095358; cv=none; b=NU0MxKm7x2/u+ULYAwrvMHnSrmt6hLj3siBA/Nmb1F3YHFrKBXK6BCxwFUZVgftZZ9Ugol1NbHK+NL1USub9on3+wp5tiof6tDN7bPZcN8VNUGcFVSxHZH2hk+wQdcnHKWGDLkmtTSrJvWsoDljTdl+F+u7Q3cMNjk1sUwejrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095358; c=relaxed/simple;
	bh=nDW8GbEo268Zo2f7hNl1SIe4aRSaD6SbOrUXtyjJPYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+OmG6seVdiG5X9Ds9uapVdPXe+ejKQ4zS/+ekgxiVdUaCfi/1PiNunLUOZy19sLrtQp02K+rlTQgL92GY/+0SP/VRgbMlp4410Ex8Wk+IpbNXHxMzUUJZurj4ZpF4sEbCk/iKC6s9FMg3lVBX4O9EcuJkUe9ojMxiZzkDewY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI6MpBSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI6MpBSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B6EC4CEC5;
	Wed, 16 Oct 2024 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729095357;
	bh=nDW8GbEo268Zo2f7hNl1SIe4aRSaD6SbOrUXtyjJPYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZI6MpBSgspSf4nZyHAYVCUdlokiydyiaBQ+oA4Lw4/LXHZqJpXJGGycdvRYeer07s
	 Sq4Ucg1vT3mgNexN4t+uriAvNfZOwGHIuj2DNg000fiZCts5L37xmNTPOMklaoBdl1
	 WgtfTxLMogELdQWCcj9xPXS23wX1v1eBWnJNYZ/QYzUVr/ivJcMhjS1rmgvgWdpmpq
	 I0sWi6FY7tSRZ4+Fh+fA5VLA/8jcMJbxt6xu2BNoDCo5aeaeTtVhKUVYzZS79fpSzU
	 1Ckew8u7ZbpEjAaBtc4YI2PMHPHS4N99KPFg2BTA2AXuRBAvjv3HG/r2SZekJFWAr2
	 t8LiB4efHksrw==
Date: Wed, 16 Oct 2024 13:15:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Handle perftool-testsuite_probe failure due
 to broken DWARF
Message-ID: <Zw_mutl867MINXPi@x1>
References: <20241016091930.191761-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241016091930.191761-1-vmolnaro@redhat.com>

On Wed, Oct 16, 2024 at 11:19:30AM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
>=20
> Test case test_adding_blacklisted ends in failure if the blacklisted
> probe is of an assembler function with no DWARF available. At the same
> time, probing the blacklisted function with ASM DWARF doesn't test the
> blacklist itself as the failure is a result of the broken DWARF.
>=20
> When the broken DWARF output is encountered, check if the probed
> function was compiled by the assembler. If so, the broken DWARF message
> is expected and does not report a perf issue, else report a failure.
> If the ASM DWARF affected the probe, try the next probe on the blacklist.
> If the first 5 probes are defective due to broken DWARF, skip the test
> case.
>=20
> Fixes: def5480d63c1e847 ("perf testsuite probe: Add test for blacklisted =
kprobes handling")
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  .../base_probe/test_adding_blacklisted.sh     | 74 +++++++++++++++----
>  1 file changed, 59 insertions(+), 15 deletions(-)
>=20
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh=
 b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> index b5dc10b2a73810b3..f67b3b267ac55269 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> @@ -19,35 +19,79 @@
>  TEST_RESULT=3D0
> =20
>  # skip if not supported
> -BLACKFUNC=3D`head -n 1 /sys/kernel/debug/kprobes/blacklist 2> /dev/null =
| cut -f2`
> -if [ -z "$BLACKFUNC" ]; then
> +BLACKFUNC_LIST=3D`head -n 5 /sys/kernel/debug/kprobes/blacklist 2> /dev/=
null | cut -f2`
> +if [ -z "$BLACKFUNC_LIST" ]; then
>  	print_overall_skipped
>  	exit 0
>  fi
> =20
> +# chceck if locate is present to find vmlinux with DWARF debug info

check

> +locate --help 2&> /dev/null
> +if [ $? -eq 0 ]; then
> +	VMLINUX_FILE=3D$(locate -r '/vmlinux$' | xargs -I{} sh -c 'test -f "{}"=
 && echo "{}"' | grep "$(uname -r)")
> +fi

And that matches the running kernel? Maybe its better to use 'perf
probe' itself to find it:

  root@number:~# perf probe -V icmp_rcv
  Available variables at icmp_rcv
          @<icmp_rcv+0>
                  struct sk_buff* skb
  root@number:~# perf probe -v -V icmp_rcv |& grep "Using.*for symbols"
  Using /usr/lib/debug/lib/modules/6.11.3-200.fc40.x86_64/vmlinux for symbo=
ls
  root@number:~# perf probe -v -V icmp_rcv |& grep "Using.*for symbols" | s=
ed -r 's/^Using (.*) for symbols$/\1/'
  /usr/lib/debug/lib/modules/6.11.3-200.fc40.x86_64/vmlinux
  root@number:~#

I'll probably add something like this to 'perf buildid-list':

root@number:~# pahole --running_kernel_vmlinux
/usr/lib/debug/lib/modules/6.11.3-200.fc40.x86_64/vmlinux
root@number:~# readelf -wi `pahole --running_kernel_vmlinux` | head -12
Contents of the .debug_info section:

  Compilation Unit @ offset 0:
   Length:        0x2b082 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0
   Pointer Size:  8
 <0><c>: Abbrev Number: 246 (DW_TAG_compile_unit)
    <e>   DW_AT_producer    : (indirect string, offset: 0x4eda9f): GNU C11 =
14.2.1 20240912 (Red Hat 14.2.1-3) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -=
mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3 -=
mskip-rax-setup -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -mindirect=
-branch=3Dthunk-extern -mindirect-branch-register -mindirect-branch-cs-pref=
ix -mfunction-return=3Dthunk-extern -mharden-sls=3Dall -mrecord-mcount -mfe=
ntry -march=3Dx86-64 -g -O2 -std=3Dgnu11 -p -fshort-wchar -funsigned-char -=
fno-common -fno-PIE -fno-strict-aliasing -fcf-protection=3Dbranch -falign-j=
umps=3D1 -falign-loops=3D1 -fno-asynchronous-unwind-tables -fno-jump-tables=
 -fpatchable-function-entry=3D16,16 -fno-delete-null-pointer-checks -fno-al=
low-store-data-races -fstack-protector-strong -ftrivial-auto-var-init=3Dzer=
o -fno-stack-clash-protection -fmin-function-alignment=3D16 -fstrict-flex-a=
rrays=3D3 -fno-strict-overflow -fstack-check=3Dno -fconserve-stack -fno-fun=
ction-sections -fno-data-sections -fsanitize=3Dbounds-strict -fsanitize=3Ds=
hift
    <12>   DW_AT_language    : 29	(C11)
    <13>   DW_AT_name        : (indirect line string, offset: 0xa546): init=
/main.c
root@number:~#

> +
>  # remove all previously added probes
>  clear_all_probes
> =20
> =20
>  ### adding blacklisted function
> -
> -# functions from blacklist should be skipped by perf probe
> -! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOGS=
_DIR/adding_blacklisted.err
> -PERF_EXIT_CODE=3D$?
> -
>  REGEX_SCOPE_FAIL=3D"Failed to find scope of probe point"
>  REGEX_SKIP_MESSAGE=3D" is blacklisted function, skip it\."
> -REGEX_NOT_FOUND_MESSAGE=3D"Probe point \'$BLACKFUNC\' not found."
> +REGEX_NOT_FOUND_MESSAGE=3D"Probe point \'$RE_EVENT\' not found."
>  REGEX_ERROR_MESSAGE=3D"Error: Failed to add events."
>  REGEX_INVALID_ARGUMENT=3D"Failed to write event: Invalid argument"
>  REGEX_SYMBOL_FAIL=3D"Failed to find symbol at $RE_ADDRESS"
> -REGEX_OUT_SECTION=3D"$BLACKFUNC is out of \.\w+, skip it"
> -../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_F=
OUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_AR=
GUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blackl=
isted.err
> -CHECK_EXIT_CODE=3D$?
> -
> -print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted funct=
ion $BLACKFUNC"
> -(( TEST_RESULT +=3D $? ))
> -
> +REGEX_OUT_SECTION=3D"$RE_EVENT is out of \.\w+, skip it"
> +REGEX_MISSING_DECL_LINE=3D"A function DIE doesn't have decl_line. Maybe =
broken DWARF?"
> +
> +BLACKFUNC=3D""
> +SKIP_DWARF=3D0
> +
> +for BLACKFUNC in $BLACKFUNC_LIST; do
> +	echo "Probing $BLACKFUNC"
> +
> +	# functions from blacklist should be skipped by perf probe
> +	! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOG=
S_DIR/adding_blacklisted.err
> +	PERF_EXIT_CODE=3D$?
> +
> +	# check for bad DWARF polluting the result
> +	../common/check_all_patterns_found.pl "$REGEX_MISSING_DECL_LINE" >/dev/=
null < $LOGS_DIR/adding_blacklisted.err
> +
> +	if [ $? -eq 0 ]; then
> +		SKIP_DWARF=3D1
> +
> +		# confirm that the broken DWARF comes from assembler
> +		if [ -n "$VMLINUX_FILE" ]; then
> +			readelf -wi "$VMLINUX_FILE" |

Can you cache the output of 'readelf -wi' for the whole vmlinux file so
that we don't do it more than once?

Doing it for each assembly function in the blacklist probably will add
up on this test run time.

> +			awk -v probe=3D"$BLACKFUNC" '/DW_AT_language/ { comp_lang =3D $0 }
> +										$0 ~ probe { if (comp_lang) { print comp_lang }; exit }' |
> +			grep -q "MIPS assembler"
> +
> +			CHECK_EXIT_CODE=3D$?
> +			if [ $CHECK_EXIT_CODE -ne 0 ]; then
> +				SKIP_DWARF=3D0 # broken DWARF while available
> +				break
> +			fi
> +		else
> +			echo "Result polluted by broken DWARF, trying another probe"
> +		fi
> +
> +	else
> +		../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT=
_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_=
ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blac=
klisted.err
> +		CHECK_EXIT_CODE=3D$?
> +
> +		SKIP_DWARF=3D0
> +		break
> +	fi
> +done
> +
> +if [ $SKIP_DWARF -eq 1 ]; then
> +	print_testcase_skipped "adding blacklisted function $BLACKFUNC"
> +else
> +	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted func=
tion $BLACKFUNC"
> +	(( TEST_RESULT +=3D $? ))
> +fi
> =20
>  ### listing not-added probe
> =20
> --=20
> 2.43.0
>=20
