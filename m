Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E421C2DC0;
	Thu, 10 Oct 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564532; cv=none; b=GS6SoKmRZVNQy5LZGBtcUD2xOrm/RI1NxcMqsd+jIqbNps22Pk2mCJIR3CjoBazNK77dnApPmFCx1uTYis/MfUvp3c43fdaFXRJNhjZx+J6DhcdxcovlPg9ykTQNVaYDJvm4+bATA+X028ll0pJBcw1lvSPhGUl839lZzPgmBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564532; c=relaxed/simple;
	bh=WUsGBhNiUOGibvX+TfnhtxeDW+47I99Xj6155xLKYE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRPH5tkAukbAb3HETolcFvrZq7MBuGmEBmBXmMQzPLp8gUiLUj0aaHoXgthQBW+9rCyyf6Cil4YRjCa76uiasVIS6iucHm7O04tV+HLlq/JwW34BzfsnlkRlXHbX4T7GdHl6cT0PR32P7AoASFEXq/05cvGOoY4wwc46fZjHWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg0eNGU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg0eNGU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952DBC4CEC5;
	Thu, 10 Oct 2024 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728564532;
	bh=WUsGBhNiUOGibvX+TfnhtxeDW+47I99Xj6155xLKYE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cg0eNGU/DxBGfV06IVtnxr1gs8cgunS1vYUfaSsJiwnXcSjfPFjTY+whTG40x4R+A
	 2eA658sLq1Nf1aSZfPXKl+IzLp0RtCbSVF68PXy5GZgdiY215G3o5NVOfnwX9fxyuG
	 FTbRVr3czFEp0W8c5MVZFMLraKdeigDRW3gKvxfZ44aV2yvEaJlmhNyRYOZypkc3Ob
	 l57p91mxSMeDcDu05Ov4yZaSyL8QLGRwZ7whZDukUvFhIRGxl5fWwgt2fUNIvaKHf+
	 Eg9aDP5KDBS6spu0DerZIXyVTFAYIciQIYuaeO2B3eirQAFF2qMrsTR2ozk+h36z7/
	 KzgUILDUO4e2A==
Date: Thu, 10 Oct 2024 09:48:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: Re: [PATCH] perf test: Fix probe testsuite with a new error message
Message-ID: <ZwfNL2sLL8cDy2au@x1>
References: <20241010051620.1066407-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010051620.1066407-1-namhyung@kernel.org>

On Wed, Oct 09, 2024 at 10:16:20PM -0700, Namhyung Kim wrote:
> On my system, it's constantly failing because of new error message from
> perf probe.  It should update the regex pattern to match the message -
> "A function DIE doesn't have decl_line. Maybe broken DWARF?".
> 
>   $ sudo head -n 2 /sys/kernel/debug/kprobes/blacklist | cut -f2
>   warn_thunk_thunk
>   asm_exc_divide_error
> 
>   $ sudo perf probe warn_thunk_thunk
>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>   Probe point 'warn_thunk_thunk' not found.
>     Error: Failed to add events.
> 
>   $ sudo perf probe asm_exc_overflow
>   Failed to find scope of probe point.
>     Error: Failed to add events.

We discussed this in the past, I came up with a similar patch, Veronika
rightly pointed out that this may point to a real problem, Masami said
that since these are for DWARF from assembly those are known issues, I
suggested Veronika checked if the CU where the function came from was
generated from Assembly (there are DWARF tags that have that info), IIRC
she said she would try to do it.

I'll try to find out the threads and see what happened.

- Arnaldo
 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> index b5dc10b2a73810b3..01e5e09053c37e46 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> @@ -42,7 +42,8 @@ REGEX_ERROR_MESSAGE="Error: Failed to add events."
>  REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
>  REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
>  REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
> -../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> +REGEX_BROKEN_DWARF="A function DIE doesn\'t have decl_line\. Maybe broken DWARF\?"
> +../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" "$REGEX_BROKEN_DWARF" < $LOGS_DIR/adding_blacklisted.err
>  CHECK_EXIT_CODE=$?
>  
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
> -- 
> 2.47.0.rc0.187.ge670bccf7e-goog
