Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7D1F131C;
	Fri, 11 Oct 2024 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616059; cv=none; b=NI7CPOwclRSzeJw+aZXL5R6N8QCKqBmd/kXTqrGNksl4y7ic2QP21yorM9seBjrHrCtq7wwNvlcPljO3/bj2D7AiEVbb51s0bg5A+Vb10mn7fe3IMRfP+UPq8Kys3wq1PC3nTSg14ypPD9y5a6k+ZS7NdR1M74k5hvRv2CW+wQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616059; c=relaxed/simple;
	bh=/g4T86WcUDOW/mQlDq2aZzgHLK5x1eTu0/jewsG0q4c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oFY7yGggIUsWV9UNKwzUfwPsLCcbtmmnX4/8Vv/8fcx36CaVHIClW8TRKPVj1kyu9p1+qTdAME1+O0iUpb9DAy/UFace4cEZ/Iqplc6Wdf2h21puHxnQFr0hC7B01Jqji0uRq5Wcxg+V0O4a/NFVqSeHzJ3c//hAU00/9xmcsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apNOfGKV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apNOfGKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBA6C4CEC5;
	Fri, 11 Oct 2024 03:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616059;
	bh=/g4T86WcUDOW/mQlDq2aZzgHLK5x1eTu0/jewsG0q4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=apNOfGKVC1fKWR5kGHb9sOnH5gh+JndyhBj1iObUd7tbF/w42t9WrkAkFUTzlIAcm
	 588dI5RdhIARnbQkEfBNZqm+eiiK20Kg4alNLxzb+06BFo6VNf2Xhn9x1/jqDdaexs
	 KD0vuUBwh1eBrVtwt7BlcNcWlJGu3gVcg8z3b6lS61ZxGm6Wm3uinxDrBFctxP0rkM
	 su3wbgR2mHs2zsZDxbcjl/MNWkFSdoAe66Rf8yletHZlv5yalkSuLWoaYY1q1IU1QF
	 yIiYIWwne1n5Bjm7tST/3fZ8WDyXDzq+EtCE9kM/t0hR5D94YLAG11bBy8KGJU4oFB
	 AP0jZtWGFj2wQ==
Date: Fri, 11 Oct 2024 12:07:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Dima
 Kogan <dima@secretsauce.net>, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf probe: Generate hash event for long symbol
Message-Id: <20241011120733.5660c80f8f93e9659fa5a254@kernel.org>
In-Reply-To: <fab219bc-fabd-42b7-b42f-d92851b1d2f3@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
	<20241007141116.882450-4-leo.yan@arm.com>
	<20241011003408.f9bacf4e5899e88a94c3d7cd@kernel.org>
	<fab219bc-fabd-42b7-b42f-d92851b1d2f3@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 16:53:05 +0100
Leo Yan <leo.yan@arm.com> wrote:

> Hi Masami,
> 
> On 10/10/24 16:34, Masami Hiramatsu (Google) wrote:
> > 
> > 
> > On Mon,  7 Oct 2024 15:11:16 +0100
> > Leo Yan <leo.yan@arm.com> wrote:
> > 
> >> If a symbol name is longer than the maximum event length (64 bytes),
> >> generate an new event name with below combination:
> >>
> >>    TruncatedSymbol + '_' + HashString + '__return' + '\0'
> >>      `> 46B        + 1B  +   8B       +    8B      + 1B   = 64 Bytes.
> >>
> >> With this change, a probe can be injected for long symbol.
> >>
> >> Before:
> >>
> >>    # nm test_cpp_mangle | grep -E "print_data|Point"
> >>    0000000000000cac t _GLOBAL__sub_I__Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi
> >>    0000000000000b50 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzR5Point
> >>    0000000000000b14 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi
> >>
> >>    # perf probe -x test_cpp_mangle --add \
> >>          "_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"
> >>    snprintf() failed: -7; the event name nbase='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long
> >>    Error: Failed to add events.
> >>
> >> After:
> >>
> >>    # perf probe -x test_cpp_mangle --add \
> >>        "_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"
> >>
> >>    Probe event='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long (>= 64 bytes).
> >>    Generate hashed event name='_Z62this_is_a_very_very_long_print_data_abcdef_91f40679'
> >>
> >>    Added new event:
> >>      probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679
> >>      (on _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi in /mnt/test_cpp_mangle)
> >>
> >>    You can now use it in all perf tools, such as:
> >>
> >>        perf record -e probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679 -aR sleep 1
> > 
> > OK, personally, I recommend you to specify event name instead of generating
> > long event name in this case. But I understand sometimes this kind of feature
> > is good for someone.
> 
> Sometimes, users try to add probe for long symbol and returns error, but there 
>   have no clue for proceeding.

OK, no warning messsage is not good.
It should warn them to recommend adding it with their own event name too.

> Either we automatically generate a hashed name, or a guidance in the failure 
> log for setting event name would be helpful. If you have concern for hashed 
> name, maybe we can refine the log to give info for setting event name?

Yeah, I think this long event name is not useful for user to type.

> > BTW, I would like to confirm. Can't we demangle the symbol name and parse it?
> 
> I did test for C++ demangle symbols with the command:
> 
>    perf probe -x /mnt/test_cpp_mangle -F --demangle
> 
> The command doesn't work as I cannot see it output correctly for demangled 
> symbols. But I don't look into details why this does not work at my side.

Oops, that is another issue to be solved.

Thank you,

> 
> Thanks for review.
> 
> Leo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
