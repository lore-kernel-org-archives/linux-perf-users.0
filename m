Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98431F5828;
	Thu, 26 Jun 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959561; cv=none; b=ozt57KNhBcUx+yaqRZSHcS5ai9HVhQp3DgzsJWaDj+0DVhqCgnLMxVQwpAEYq3cX4eIfCUE17Hole1Ui5cTAXay55GYvx4nktu08BhJDpUlqOX6h4BmowKy+2KIMEHYud7A+JTcRqKGG5LAs3UuLQCLs/pRgbYbVu0dvQxb0hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959561; c=relaxed/simple;
	bh=4KWMnpDiHiL5PRJqhB2qQEqywpZCJEWlv6miNsOm83M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soVZfIzx0ocn+k91Xqd6H0K4Aepegk0nGAO5Ihbce4+d713sHROlV+nq/gH/EFWkLlVhu9TPnK0WhB4xSkM0qXciHwvBg3NR+XWB94S8UGgT6qhr6HSu+1dY8W960TxmkYoXrTFagxeAJjA3okAKC2mtsRxnlYeUPFX1nE4b7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIjwuvKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIjwuvKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12E5C4CEEB;
	Thu, 26 Jun 2025 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750959561;
	bh=4KWMnpDiHiL5PRJqhB2qQEqywpZCJEWlv6miNsOm83M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIjwuvKpYV0r8ExMwKFrWMTyFmyfun0DeAy/TEBMM/QYyeSdk8PzOdnSmVG39nnfy
	 ssISvo4U6Gs/lUjl3wfxydvia3nOJtyCWKmYRPOxOdu4c2IQ2vbnAs3DcsRv1xhDcS
	 NIzfF3KCnjDCoouaEemwLjMdUqaZTd6zA0JAysdUKp2MrzWfvzsF8otTdv8q7KTbdz
	 EsYEYaxRTUyhm5iNFwUbcqGTJ/92odbvlKW4Bh5U6CdF/BoLMjbBU9bfmrcbHvCTS4
	 Kwogyg0ZKzFnzwKhO8U+A4CgvLIMVCA0Q88ht3y87VsUqmsgKQ9MPqv44h3B8hNwdC
	 yMoNpnEeU7EXw==
Date: Thu, 26 Jun 2025 10:39:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf build: Specify that shellcheck should use the
 bash dialect.
Message-ID: <aF2Fx-cYy6B69d4S@google.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>

Hello,

On Mon, Jun 23, 2025 at 10:44:59PM -0700, Collin Funk wrote:
> When someone has a global shellcheckrc file, for example at
> ~/.config/shellcheckrc, with the directive 'shell=sh', building perf
> will fail with many shellcheck errors like:
> 
>     In tests/shell/base_probe/test_adding_kernel.sh line 294:
>     (( TEST_RESULT += $? ))
>     ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((..)) is undefined.
> 
>     For more information:
>       https://www.shellcheck.net/wiki/SC3006 -- In POSIX sh, standalone ((..)) is...
>     make[5]: *** [tests/Build:91: tests/shell/base_probe/test_adding_kernel.sh.shellcheck_log] Error 1
> 
> Passing the '-s bash' option ensures that it runs correctly regardless
> of a developers global configuration.
> 
> This patch adds '-s bash' and other options to the SHELLCHECK variable
> in Makefile.perf and makes use of the variable consistently.
> 
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  tools/perf/Build                | 2 +-
>  tools/perf/Makefile.perf        | 2 +-
>  tools/perf/arch/x86/Build       | 2 +-
>  tools/perf/arch/x86/tests/Build | 2 +-
>  tools/perf/tests/Build          | 2 +-
>  tools/perf/trace/beauty/Build   | 2 +-
>  tools/perf/util/Build           | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 06107f1e1d42..b03cc59dabf8 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -73,7 +73,7 @@ endif
>  
>  $(OUTPUT)%.shellcheck_log: %
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-y += $(SHELL_TEST_LOGS)
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d4c7031b01a7..e0cf8db5462b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -252,7 +252,7 @@ endif
>  ifeq ($(NO_SHELLCHECK),1)
>    SHELLCHECK :=
>  else
> -  SHELLCHECK := $(shell which shellcheck 2> /dev/null)
> +  SHELLCHECK := $(shell which shellcheck 2> /dev/null) -s bash -a -S warning

This caused a trouble on a test environment where 'which' (and
'shellcheck' as well) is not available.  Now it makes SHELLCHECK
non-empty unconditionally.

So the version check below failed like below:

  make[1]: which: No such file or directory
  /bin/sh: - : invalid option
  Usage:	/bin/sh [GNU long option] [option] ...
  	/bin/sh [GNU long option] [option] script-file ...
  GNU long options:
  	--debug
  	--debugger
  	--dump-po-strings
  	--dump-strings
  	--help
  	--init-file
  	--login
  	--noediting
  	--noprofile
  	--norc
  	--posix
  	--pretty-print
  	--rcfile
  	--rpm-requires
  	--restricted
  	--verbose
  	--version
  Shell options:
  	-ilrsD or -c command or -O shopt_option		(invocation only)
  	-abefhkmnptuvxBCEHPT or -o option
  expr: syntax error: unexpected argument ‘060’

And it failed to build later on shellchecks.

    TEST    /build/arch/x86/tests/gen-insn-x86-dat.sh.shellcheck_log
  /bin/sh: line 1: -s: command not found
  make[6]: *** [arch/x86/tests/Build:25: /build/arch/x86/tests/gen-insn-x86-dat.sh.shellcheck_log] Error 1
  make[6]: *** Waiting for unfinished jobs....

I think it's better to convert 'which' to 'command -v' (in other places
too) and add the options after the version check.

Thanks,
Namhyung


>  endif
>  
>  # shellcheck is using in tools/perf/tests/Build with option -a/--check-sourced (
> diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
> index afae7b8f6bd6..d31a1168757c 100644
> --- a/tools/perf/arch/x86/Build
> +++ b/tools/perf/arch/x86/Build
> @@ -10,6 +10,6 @@ endif
>  
>  $(OUTPUT)%.shellcheck_log: %
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-test-y += $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> index 5e00cbfd2d56..01d5527f38c7 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -22,6 +22,6 @@ endif
>  
>  $(OUTPUT)%.shellcheck_log: %
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-test-y += $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 2181f5a92148..d6c35dd0de3b 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -89,7 +89,7 @@ endif
>  
>  $(OUTPUT)%.shellcheck_log: %
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-test-y += $(SHELL_TEST_LOGS)
>  
> diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
> index f50ebdc445b8..561590ee8cda 100644
> --- a/tools/perf/trace/beauty/Build
> +++ b/tools/perf/trace/beauty/Build
> @@ -31,6 +31,6 @@ endif
>  
>  $(OUTPUT)%.shellcheck_log: %
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-y += $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 7910d908c814..2dfa09a6f27d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -421,7 +421,7 @@ endif
>  
>  $(OUTPUT)%.shellcheck_log: %
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-util-y += $(SHELL_TEST_LOGS)
>  
> -- 
> 2.49.0
> 
