Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8D17A5B5;
	Mon, 12 Aug 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491560; cv=none; b=aTpgNVRMHt4QjdYLAlqZuDnWFu5yHjB2nV4HjYVqIUJjukXlF0q7oq0nGIx+U0Xkw7uUi97ez656tuNicjxEIIwDJ/jIK7bq2iA5m0cSFF6ddfSQfU48THBk8BE8O7TrpV6ayLOjoTDaNu9dmJ0n5fzjhTO8ba85I7GpEMAhyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491560; c=relaxed/simple;
	bh=4c2DWHnn3Rchka7MEhcsnyBGNJt8bJEvTsEN8uLK7bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFrej7Up7St8Lip6Ja2mbiuA8v3g46TPw/uEfy8SilW+jCf6LNO+Gk8hJ1utar0ZQ6Yft+0SuASrPuZABTj7JF4Vt4v3qPcOsvvk1RpjXUV/OwSg/jsgH90lxLzF8QsQQfnt5Z7EmVdKw4L/iI1atzLFHbUQNPp7uLr6K6oYOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOS/va7O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOS/va7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457AFC32782;
	Mon, 12 Aug 2024 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723491559;
	bh=4c2DWHnn3Rchka7MEhcsnyBGNJt8bJEvTsEN8uLK7bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOS/va7OJy2/8D1kn4Yqnfp7ko+6lVS48RjcgVfmcC6a+Sq4PNE5cW2h3ut2r7UMp
	 DYHkZ5yllSvFuhNMwJq4LeZWSq7nCUK5SCqjdcyY0ULkk4LyfUK6KTzA1lKORVmMzJ
	 d9UkHjuzc4KDUu2mXT1ZzMR6Xso3OKA9zMCCLa5hAyP6Fw8A5nUNwvxUPfKn7vZdkW
	 QNTqOuHFbKabM45W9VLLF2e9p+GzsZRhOEE1Pds8q72C/U2PCHdHAlRfqTfWASVQJ0
	 t514tK91Fq4fuQhLnWRUjYTCD6TaygU4yOo7YZo5LB3QuoJU9KTY/AmTQyJHK4CIHt
	 00Pl1uxfGgeIA==
Date: Mon, 12 Aug 2024 12:39:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V2 0/9] Support branch counters in block annotation
Message-ID: <Zrpk5a2GQl5i5APD@google.com>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808193324.2027665-1-kan.liang@linux.intel.com>

Hello,

On Thu, Aug 08, 2024 at 12:33:15PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Add Acked-by from Namhyung for patch 1 and 2.
> - Use array to replace pointer to store the abbr name. (Patch 5)
>   (Namhyung)
> - Add -v to print the value like "A=<n>,B=<n>", rather than histogram.
>   (Patch 6) (Namhyung)
> 
> The branch counters logging (A.K.A LBR event logging) introduces a
> per-counter indication of precise event occurrences in LBRs. It can
> provide a means to attribute exposed retirement latency to combinations
> of events across a block of instructions. It also provides a means of
> attributing Timed LBR latencies to events.
> 
> The kernel support and basic perf tool support have been merged.
> https://lore.kernel.org/lkml/20231025201626.3000228-1-kan.liang@linux.intel.com/
> 
> This series is to provide advanced perf tool support via adding the
> branch counters information in block annotation. It can further
> facilitate the analysis of branch blocks.
> 
> The patch 1 and 2 are to fix two existing issues of --total-cycles and
> the branch counters feature.
> 
> The patch 3-9 are the advanced perf tool support.
> 
> Here are some examples.
> 
> perf annotation:
> 
> $perf record -e "{branch-instructions:ppp,branch-misses}:S" -j any,counter
> $perf report  --total-cycles --stdio
> 
>  # To display the perf.data header info, please use --header/--header-only options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }'
>  # Event count (approx.): 1610046
>  #
>  # Branch counter abbr list:
>  # branch-instructions:ppp = A
>  # branch-misses = B
>  # '-' No event occurs
>  # '+' Event occurrences may be lost due to branch counter saturated
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          Branch Counter [Program Block Range]
>  # ...............  ..............  ...........  ..........  ......................  ..
>  #
>            57.55%            2.5M        0.00%           3             |A   |-   |                 ...
>            25.27%            1.1M        0.00%           2             |AA  |-   |                 ...
>            15.61%          667.2K        0.00%           1             |A   |-   |                 ...
>             0.16%            6.9K        0.81%         575             |A   |-   |                 ...
>             0.16%            6.8K        1.38%         977             |AA  |-   |                 ...
>             0.16%            6.8K        0.04%          28             |AA  |B   |                 ...
>             0.15%            6.6K        1.33%         946             |A   |-   |                 ...
>             0.11%            4.5K        0.06%          46             |AAA+|-   |                 ...
> 
> With -v applied,
> $perf report  --total-cycles --stdio -v
> 
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          Branch Counter [Program Block Range]
>  # ...............  ..............  ...........  ..........  ......................  ..................
>  #
>            57.55%            2.5M        0.00%           3               A=1 ,B=-                  ...
>            25.27%            1.1M        0.00%           2               A=2 ,B=-                  ...
>            15.61%          667.2K        0.00%           1               A=1 ,B=-                  ...
>             0.16%            6.9K        0.81%         575               A=1 ,B=-                  ...
>             0.16%            6.8K        1.38%         977               A=2 ,B=-                  ...
>             0.16%            6.8K        0.04%          28               A=2 ,B=1                  ...
>             0.15%            6.6K        1.33%         946               A=1 ,B=-                  ...
>             0.11%            4.5K        0.06%          46               A=3+,B=-                  ...
> 
> (The below output is in the TUI mode. Users can press 'B' to display
> the Branch counter abbr list.)
> 
> Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }',
> 4000 Hz, Event count (approx.):
> f3  /home/sdp/test/tchain_edit [Percent: local period]
> Percent       │ IPC Cycle       Branch Counter (Average IPC: 1.39, IPC Coverage: 29.4%)
>               │                                     0000000000401755 <f3>:
>   0.00   0.00 │                                       endbr64
>               │                                       push    %rbp
>               │                                       mov     %rsp,%rbp
>               │                                       movl    $0x0,-0x4(%rbp)
>   0.00   0.00 │1.33     3          |A   |-   |      ↓ jmp     25
>  11.03  11.03 │                                 11:   mov     -0x4(%rbp),%eax
>               │                                       and     $0x1,%eax
>               │                                       test    %eax,%eax
>  17.13  17.13 │2.41     1          |A   |-   |      ↓ je      21
>               │                                       addl    $0x1,-0x4(%rbp)
>  21.84  21.84 │2.22     2          |AA  |-   |      ↓ jmp     25
>  17.13  17.13 │                                 21:   addl    $0x1,-0x4(%rbp)
>  21.84  21.84 │                                 25:   cmpl    $0x270f,-0x4(%rbp)
>  11.03  11.03 │0.61     3          |A   |-   |      ↑ jle     11
>               │                                       nop
>               │                                       pop     %rbp
>   0.00   0.00 │0.24    20          |AA  |B   |      ← ret
> 
> perf script:
> 
> $perf script -F +brstackinsn,+brcntr
> 
>  # Branch counter abbr list:
>  # branch-instructions:ppp = A
>  # branch-misses = B
>  # '-' No event occurs
>  # '+' Event occurrences may be lost due to branch counter saturated
>      tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (home/sdp/test/tchain_edit)
>         f3+31:
>         0000000000401774        insn: eb 04                     br_cntr: AA     # PRED 5 cycles [5]
>         000000000040177a        insn: 81 7d fc 0f 27 00 00
>         0000000000401781        insn: 7e e3                     br_cntr: A      # PRED 1 cycles [6] 2.00 IPC
>         0000000000401766        insn: 8b 45 fc
>         0000000000401769        insn: 83 e0 01
>         000000000040176c        insn: 85 c0
> 
> $perf script -F +brstackinsn,+brcntr -v
> 
>      tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (/home/sdp/test/tchain_edit)
>         f3+31:
>         0000000000401774        insn: eb 04                     br_cntr: branch-instructions:ppp 2 branch-misses 0      # PRED 5 cycles [5]
>         000000000040177a        insn: 81 7d fc 0f 27 00 00
>         0000000000401781        insn: 7e e3                     br_cntr: branch-instructions:ppp 1 branch-misses 0      # PRED 1 cycles [6] 2.00 IPC
>         0000000000401766        insn: 8b 45 fc
>         0000000000401769        insn: 83 e0 01
>         000000000040176c        insn: 85 c0
> 
> Kan Liang (9):
>   perf report: Fix --total-cycles --stdio output error
>   perf report: Remove the first overflow check for branch counters
>   perf evlist: Save branch counters information
>   perf annotate: Save branch counters for each block
>   perf evsel: Assign abbr name for the branch counter events
>   perf report: Display the branch counter histogram
>   perf annotate: Display the branch counter histogram
>   perf script: Add branch counters
>   perf test: Add new test cases for the branch counter feature

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-report.txt |   1 +
>  tools/perf/Documentation/perf-script.txt |   2 +-
>  tools/perf/builtin-annotate.c            |  13 +-
>  tools/perf/builtin-diff.c                |   8 +-
>  tools/perf/builtin-report.c              |  25 ++-
>  tools/perf/builtin-script.c              |  69 ++++++-
>  tools/perf/builtin-top.c                 |   4 +-
>  tools/perf/tests/shell/record.sh         |  17 +-
>  tools/perf/ui/browsers/annotate.c        |  18 +-
>  tools/perf/ui/browsers/hists.c           |  18 +-
>  tools/perf/util/annotate.c               | 253 +++++++++++++++++++++--
>  tools/perf/util/annotate.h               |  24 ++-
>  tools/perf/util/block-info.c             |  66 +++++-
>  tools/perf/util/block-info.h             |   8 +-
>  tools/perf/util/branch.h                 |   1 +
>  tools/perf/util/disasm.c                 |   1 +
>  tools/perf/util/evlist.c                 |  68 ++++++
>  tools/perf/util/evlist.h                 |   2 +
>  tools/perf/util/evsel.c                  |  15 +-
>  tools/perf/util/evsel.h                  |  14 ++
>  tools/perf/util/hist.c                   |   5 +-
>  tools/perf/util/hist.h                   |   2 +-
>  tools/perf/util/machine.c                |   3 +
>  23 files changed, 567 insertions(+), 70 deletions(-)
> 
> -- 
> 2.38.1
> 
