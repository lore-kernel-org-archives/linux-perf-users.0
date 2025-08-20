Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192542E0B48;
	Wed, 20 Aug 2025 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733135; cv=none; b=u55jIkHGC01drosOuRT15VaW59PeS+ixRbZsJLgV+PSzvlMcsl1AOHbCWA/uVgfzHmQwMsQMgtr/AjOPRgt3TWJ2u6zpc3DEovAA/nmcxQHDmAim6M/Ge17xqLEtAOLpieckqXudavbyBicoa0nBvUc21amUklW5q9Uny1bKJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733135; c=relaxed/simple;
	bh=Gx14nRpjQZohcF74zyHh+xLcM1zVvJmpDjMTrKsOzXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX9tlsw1fEFJPmdo26wBXYw74VjQLEoHal1Y3UaQhsQKKb1Mc0/Ivpy/tuqMKFgnUhKYdCEgCCRmS78bJd8MxvCO6h0z0/V6rvFKAQRdGF962nXKcIUP3//2dQHqT+94W3eWD15w6JHBy0J2UD78ubcbf3kzBdU7/SeecSF7lsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/r3tTFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/r3tTFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA84C4CEE7;
	Wed, 20 Aug 2025 23:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733134;
	bh=Gx14nRpjQZohcF74zyHh+xLcM1zVvJmpDjMTrKsOzXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/r3tTFzn3iQIGRC4mbelwAc7MGO84La4goyv4A/NUQ4xpKMM9k94W/MkBj/izKhQ
	 ViZjXauAdi7kPn3uE+17PZ0A+j+t7GUDvkI22maeFKiOOAf/DqHdhwg/ZhKjkzjzmt
	 Bz9Z9eR11Oz++CZ2zAC5UaAYbSJT0RhrH45Nd532ls+D3F0kifor1pAne/4l0ziTat
	 Po12NjL/f/gApY7w+2JGZws5A2wq4El7lYM1NKUeOU0IJ9NGCES6CNC9NgKhn4Av0t
	 FxEu2TQzC1nwDlDBIzNg5TlB295gbB0gKJbMeee/ZZE6n+61+r6Qb++Xk+cjRFRmSh
	 1hDj9cth/2l7w==
Date: Wed, 20 Aug 2025 16:38:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/12] perf annotate: Add --code-with-type support for
 TUI
Message-ID: <aKZcig1ZIjZV8f1y@google.com>
References: <20250816031635.25318-1-namhyung@kernel.org>
 <20250816031635.25318-8-namhyung@kernel.org>
 <aKYZ-dhGJvWoIres@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKYZ-dhGJvWoIres@x1>

Hi Arnaldo,

On Wed, Aug 20, 2025 at 03:54:49PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 15, 2025 at 08:16:30PM -0700, Namhyung Kim wrote:
> > Until now, the --code-with-type option is available only on stdio.
> > But it was an artifical limitation because of an implemention issue.
> > 
> > Implement the same logic in annotation_line__write() for stdio2/TUI
> > and remove the limitation and update the man page.
> 
> Samples: 54K of event 'cycles:P', 4000 Hz, Event count (approx.): 25749717559
> poll_idle  /usr/lib/debug/lib/modules/6.15.9-201.fc42.x86_64/vmlinux [Percent: local period]
> Percent │      mov     %rdi,%rbx                                                                                                                                        ▒
>         │    → call    local_clock_noinstr              # data-type: (stack operation)                                                                                  ▒
>         │      andb    $0xfb,(%rbx)             # data-type: struct cpuidle_device +0 (registered:1)                                                                    ▒
>         │      mov     %rax,%rbp                                                                                                                                        ▒
>         │    → call    *0x1342a22(%rip)        # ffffffff8384f778 <pv_ops+0xf8>         # data-type: (stack operation)                                                  ▒
>         │      mov     current_task,%r14                # data-type: struct task_struct* +0                                                                             ▒
>         │      lock    orb     $0x20,0x2(%r14)          # data-type: struct task_struct +0x2 (thread_info.flags)                                                        ▒
>         │      mov     (%r14),%rax              # data-type: struct task_struct +0 (thread_info.flags)                                                                  ▒
>         │      test    $0x8,%al                                                                                                                                         ▒
>         │    ↓ jne     6d                                                                                                                                               ▒
>         │      mov     %r12,%rdi                                                                                                                                        ▒
>         │      mov     %rbx,%rsi                                                                                                                                        ▒
>         │    → call    cpuidle_poll_time                # data-type: (stack operation)                                                                                  ▒
>         │      mov     %rax,%r12                                                                                                                                        ▒
>         │49:   mov     $0xc9,%eax                                                                                                                                       ▒
>    0.75 │4e:   mov     (%r14),%rdx              # data-type: struct task_struct +0 (thread_info.flags)                                                                  ▒
>    0.42 │      and     $0x8,%edx                                                                                                                                        ▒
>         │    ↓ jne     6d                                                                                                                                               ▒
>   97.81 │      pause                                                                                                                                                    ▒
>    0.70 │      sub     $0x1,%eax                                                                                                                                        ▒
>    0.04 │    ↑ jne     4e                                                                                                                                               ▒
>    0.14 │    → call    local_clock_noinstr              # data-type: (stack operation)                                                                                  ▒
>    0.01 │      sub     %rbp,%rax                                                                                                                                        ▒
>    0.05 │      cmp     %rax,%r12                                                                                                                                        ▒
>         │    ↑ jae     49                                                                                                                                               ▒
>         │      orb     $0x4,(%rbx)              # data-type: struct cpuidle_device +0 (registered:1)                                                                    ▒
>         │6d: → call    *0x13429cd(%rip)        # ffffffff8384f770 <pv_ops+0xf0>         # data-type: (stack operation)                                                  ▒
>         │      lock    andb    $0xdf,0x2(%r14)          # data-type: struct task_struct +0x2 (thread_info.flags)                                                        ▒
>         │      mov     (%r14),%rax              # data-type: struct task_struct +0 (thread_info.flags) 
> 
> 
> Some suggestions:
> 
> Align the # data-type: annotations.

I was thinking about this but then probably it needs to align to the
longest line like call instruction.  It can be annoying if you are
using a small terminal.

> 
> Remove the "data-type: " part, just uses space and it should be obvious
> what that type refers to.

I think it's better to have some kind of signature to find the info
deterministically as I need to extract them in a script.

> 
> At some point, if we can do it super cheaply, maybe BTF, do this by
> default.

BTF doesn't have variables and locations so it's impossible to match
instructions to types currently.

> 
> The 'T' hotkey looks great, but perhaps we should have more visibility
> for it? Like what I suggested in:
> 
> https://lore.kernel.org/all/aBvx-J-ISifmw0NS@google.com/T/#u

Yep, in the next patch. :)

Thanks,
Namhyung
