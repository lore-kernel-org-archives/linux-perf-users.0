Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76973469EE
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jul 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774914; cv=none; b=t2V13CBK6/cmyg9VKntQ5+9txxL2E5r2YZFmtZk6chp7c/EqkGD2nJUNfaKP+CvG8OI/AY6ll/oXG7Tajks39+F+733BEJ+64TXIBezHNvDBDW4q2CzP2V2dqAFtHBw6No85XKxUjCMdJSuM6+ARVZiKTlJBPyk6rbk/4K5ygqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774914; c=relaxed/simple;
	bh=7sRtOZF+YPTQA4fFn6HdZmoBJ2AcEBCS9lMdLmotymc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfMzii+OoPF8WrJFATmYjleicGA5Gy7B2gM74eocUbTsiQb7hYZcNVxcVFnuhvvAY8BYvnc0g+W1aQqWxzzwQZwm8D1CVSMvo7BoDgi1HY+3cE1gr+9qL9mA59k0T2oCXNGsAs2eDk3fiVlj8rVi8M9he+UpnRfjLcOG3jRPh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8Z3gAtC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8Z3gAtC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783774911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6vDyJk3Cy2WXcJVb9Fz2t23mdGudHpQUdVcvkmNRO8=;
	b=N8Z3gAtCjNlfnbx/FxBrqsnQ1XrXLUtzgHP7r8gkiVlzbmT+Bg0kpfhpE2rL5wKO8eMotG
	bE0D4+/1hMdVijfjkBYTbyhrUO1mCKnOlMrN+1ULfrmVl8QrIu94llkZN5sGSuCFsHidYm
	cp0bBBVxhzonK/i1FV30acSyzYFOmbs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-Zf1DJUG4OMunXLcWCMzOvg-1; Sat,
 11 Jul 2026 09:01:48 -0400
X-MC-Unique: Zf1DJUG4OMunXLcWCMzOvg-1
X-Mimecast-MFC-AGG-ID: Zf1DJUG4OMunXLcWCMzOvg_1783774905
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F89119560BB;
	Sat, 11 Jul 2026 13:01:44 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8AFE918005B7;
	Sat, 11 Jul 2026 13:01:35 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 11 Jul 2026 15:01:43 +0200 (CEST)
Date: Sat, 11 Jul 2026 15:01:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to
 SRCU-fast-updown
Message-ID: <alI-rKAWUdoPCy5k@redhat.com>
References: <20260706172744.3920417-1-puranjay@kernel.org>
 <20260706172744.3920417-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706172744.3920417-3-puranjay@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/06, Puranjay Mohan wrote:
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

And the commit d3f52f53a562 ("srcu: Create an SRCU-fast-updown API")
even mentions uretprobes as a likely user.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

