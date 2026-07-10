Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0993B7B99
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718634; cv=pass; b=BxnUgh4aQqGBd238kSTkoRL2X1DhV4iS4mUEK491SE7XG+wGHqzDPc2UItfbKpJP/Hpp+NODb26cS8DzYR+igQ0o1ryycM6UqNEdDakc8QZyzb4QirWVEmXms5j/CN3FuT0niAR5Jnpzx44fcdBjhY2RWtvlNJI6scnUntrrcqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718634; c=relaxed/simple;
	bh=ZffsXEKRzy6BPrYFDZBFjLeefjvojwkwyzHgCSgBeJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByDxLH79LjsL3vZX7sfmQDceWMgt+03FtVceCtYPqMwiozI4pKJM9DRoVyaOt8XFQGYuu3GYfNlXR0DYWwlZ8xOVYFUH1ijWMrCWfnU+UUnno6Dh4dJkf5DBJ7iaK5Q8c6CO0fR4+HPWgyWQIz6wUFht7ma0L1CHqsOR/beeKxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfiEZkVR; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfiEZkVR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38175907a56so2013744a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 14:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718632; cv=none;
        d=google.com; s=arc-20260327;
        b=q/CczLuef3yqvvXtBm4UjEPwK1GHs+xGzk+UbB45ZFPG2zixPA8TCiSiYki9uwncb4
         W5hiRDDrgOr4nDIGMeghKmB0cI/0eWozxwBIDEWgeCNkNTcEfjrH4obDYoKX+MXMeQvq
         HPiXYIMziMtGsVMxncCXhqXT8WE/RSHnFr7cggriEU01HASf8lS+T8GgTfPMdv7KOhlk
         G+cpvM54SmVNHXlagcA/J2rx0hq3mHKkL8VN0oRrZrfiMufYjfcyIxuCYCuvhUu2FlQ3
         0+dRMwNBSbbWssPxBDehqe47gXhbvroXYMPHV+NAhHhX9PxRMbXNji9kJK/iU733X/PF
         /iNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        fh=q+hu2DgIV5Ix5Pydkjgz8sclHZHsnfVORFekQBc+GPQ=;
        b=oSGCXmDeTznaNJ6Nc3QfZMEDVt1lYpK1bJH+o7qOYoxVDpwlm9SyE1UDGTDuMOkgCK
         ptEXDlYZAodlAFlcCTP3EgYxJN8I/OzmQJAMBA+9N8Po1gySf7lYj5xZBfTMmLJgx9Kl
         dUIOdIIEm9cWYyW+DWimZMRnWcRvsD7yueTz36fVaovKAXRtwZSyl5jG7ofSatjLgprj
         sDnT3l7oJ+UEFvjX9MjQV3TCNM2hhPR99oWifExs68DPFnABexktQK4Kcg0ppfB59/4p
         zRQ+r5mwNhB4GJtmBYdDg0OUPcULKDrnjR9QEZt13cRg97ynSRmCvnsux8JLbDHw+wdF
         ZnWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718632; x=1784323432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=gfiEZkVRkxY3zvcQlPbas/3Cycw47n3fcFyJ5mfu46UrrgcTvkI0356jgCEZcaZafW
         X6cbSUJanZS0Mo6YOChyU/8CzukJyrdbK3RXgTB3KdWymKLh2qd67PwMA3WpUcZFIW10
         r6wgLSZ8WUnZACqQ8DlT2qkuqJSTPx1a/HQ0pI4+wbP48h1SofJJoDlHNaEiGr+1iRpp
         oSALXPlMh62CoSf+dubbQCWTGgAZMRWYEEfE+hs9vLnezx0k6tktUQL31TPkHk/465HC
         I7VEdO3fKkg/syWpwHvbBCjr2Ykni/j2Zgp9pmCrXJssapi1k2eceXGm5OYVZMRwLIcE
         ioQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718632; x=1784323432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=MEtmHgk6h8QIPJfKEAPAdNc4AgU0D5SsxtwsPr0iiKX9ifDBGT8VRNiUeq214j0/x8
         CEhBRzZLFvX0xksECrvoyO0+o8x7yhBys8KSUli3V0BQO8iYlkMaslhtgq/sHGdjif8v
         WILrVne9ug/NJsFQi4g//FEg8DqTMiuxMFeXKNp9LNcTo413lHY8V/DWLoRN+8GVI0J7
         tI0HEbO2fXP84CYDrbaTK3SAKZG+FiBhMSM5LKBhhGxfwAy6ZDDbl44m5CWP3NGPwgMR
         VzQhjVcTiQcTgB574lAE6qHPSuBffF/Q59Rx/v2eLu4jZJULtzERpZonnKFbMu3BfDWm
         s2tA==
X-Forwarded-Encrypted: i=1; AHgh+RrNLucMv/8JjjZ/CJT7sgkaOfOIDvwROK3IoQ8B04XikcRy2xqeOOTJOdQH/ZaQI40HpYEUd1hiV8QP9/ekI9Ua@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkI8IMbGHMx3pBQKET4+6LueAOStJnR7vO+zJXcn2iPLW3op/
	Dexwp2khbWggJIHz5jAvOS114p/SyVPpyEqwwJojWqhmeA8XN7wvy94cRwNfGQguOqjL0twgH7W
	yCTJ7l70bp2xKfdDoXfNiF5Ze8qBN2ds=
X-Gm-Gg: AfdE7cnB7oRYU7MPlmQqThJvkjAmaiV6lQg820313YrOfUJ4B+K/IBX1+wmK0DPXOqx
	d9D8F9B0CEOHXXyAVNgr+dOFUbj/GHBNZbuA/1J8fF0NHOCaPmN/yI4EeK4hGqGlFdDa/i/FGb+
	6GkfeE7qSSE5KUNiIgGq1J5BMKWzGvYnQvfAHYVJ5gSV2Z62PZeGB7zi2yIhk8jLHTA6V0CfsR5
	JeZ5kU+lWwH4euREXxTp+hGpqu+zjNFvzSJibDanRYc2RdjVxlkMeE9w8Li7+c75m7i0QUBUSRh
	QK4aJpnWli40yPGmSoMPMhOMqwDrK9qoiB6fWmXZgmNsTr6SdlYwLw==
X-Received: by 2002:a17:90b:5903:b0:37f:9e21:91d8 with SMTP id
 98e67ed59e1d1-38dc834de8fmr359486a91.15.1783718632544; Fri, 10 Jul 2026
 14:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
In-Reply-To: <20260706172744.3920417-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:23:39 -0700
X-Gm-Features: AVVi8CeESE7KrO4SofyyKXRIq0UuNC-RWDudhRYzrwkmSGZKKMPllM8AreG8cCk
Message-ID: <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> uretprobes_srcu currently uses normal SRCU, which issues
> two smp_mb() per read lock/unlock pair. This overhead is
> paid on every uretprobe hit.
>
> Switch to SRCU-fast-updown, which eliminates the per-reader
> memory barriers by moving the ordering cost to the
> grace-period side (synchronize_rcu() instead of smp_mb()).
> This is acceptable because grace periods (uprobe
> unregistration) are infrequent compared to reader-side
> uretprobe hits.
>
> The updown flavor is required because the SRCU read lock is
> taken in prepare_uretprobe() when a return instance is
> created and is held until that return instance is finalized.
> The traced thread returns to user space in between, so the
> lock is inherently released in a different context from
> where it was acquired: on the normal return path via
> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> ri_timer() (expiry) or dup_utask() (fork) via
> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> are designed for this acquire-here / release-elsewhere
> pattern and, unlike the same-context srcu_read_lock_fast()
> variant, do not carry the lockdep read-side tracking that
> would warn on it.
>
> The short, same-context SRCU sections in ri_timer() and
> dup_utask() (which guard the uprobe against reuse across the
> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> for proper lockdep coverage.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/uprobes.h |  5 +++--
>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>

Very straightforward replacement and will improve performance, thanks!
LGTM. Peter or Mingo, I assume you guys will want to route this
through your tip tree, right?

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
