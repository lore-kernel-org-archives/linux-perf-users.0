Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B12364927;
	Wed, 12 Aug 2026 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786496681; cv=none; b=MXSnYNfJrBVC7B37BNCGoL2zHkcvn1z6hM7t+rBJfy/iFlaRtT4gcz3a2gdQxTNq8RwCTN6BF/zz24yka5I3KP94bOJdT+ZqTlixNXaYGxh1FT4UNgZ+ULzApfZU4Nz5uKaKtiQ3oYUDIjrf6IhrYCD9BDQeHrwGsy0YXbA/W+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786496681; c=relaxed/simple;
	bh=R9pMwnMT0S22nQ2QreVdnq4esafNM9N3nXnYhytS4Uc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BFx651kimwqkHt68mVJSA0qiv6q3pcNU+YV8NDaoE2LvLJWEkvjxWdxFSaUcnJfu3z7ONRtLshELBb/wx06KKF27GMhBR8LTQGAfdCJxPTWz85DPl6U8a982w6hLLO347HWvMyG+ooFHrps6s3Davba2XsC91Ev1PH442qXEjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8G/l1I5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8G/l1I5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A601F000E9;
	Wed, 12 Aug 2026 01:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786496678;
	bh=WKX7VNXBPgapL0AoeSRXV2Q2DGQaFFWHAmrcE1PQMK0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=a8G/l1I54jJ4YhqvsH0r9O9Popdifnp0OE718wLjwRbA2OzDphwBv+qEXRteho5hA
	 ypcPN+DhaiSnq+2z8RIfwslb9BiI0XC2tl9/UXWyzz7esaRIBy+xYdLZrZB4l/4UI/
	 x9Uwx1jMDOud8ve2qE0yOivxfsMCcps+BZOG8sYIaCNadNYoaGRzQBauv0symDsbnP
	 z9IksUA34pu1vjCU4JP+k9NiRyVd3M6gR0NZB+YoAcrIxou1FW2kE5KN6zU7I/VYuW
	 JbPran9kR8xfC3vjxDbnAKK3mDgBCxhQpRdeprMtDob4Qg9eWw8C1RnZ3Q3zThexRs
	 ImDKAp9xzzpfw==
Content-Type: multipart/mixed; boundary="===============1302207253100925257=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <42d2df770e6e5f9134476509f690ec9b7d68f0da4cd1ffadcf3f9c1b75f0adf2@mail.kernel.org>
In-Reply-To: <20260811235331.10044-1-kartikey406@gmail.com>
References: <20260811235331.10044-1-kartikey406@gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix data race in __perf_event_overflow
From: bot+bpf-ci@kernel.org
To: kartikey406@gmail.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,james.clark@linaro.org,song@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,kpsingh@kernel.org,mattbobrowski@google.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,me@kylehuey.com
Cc: linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kartikey406@gmail.com,syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 01:04:37 +0000 (UTC)

--===============1302207253100925257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit ffa161d3558e4937793a0c3e98e19e4b22e58bd9
> Author: Deepanshu Kartikey <kartikey406@gmail.com>
> Date:   Wed Aug 12 05:23:31 2026 +0530
>
>     perf/bpf: Fix data race in __perf_event_overflow
>
>     perf_event_detach_bpf_prog() writes event->prog = NULL
>     under bpf_event_mutex, while __perf_event_overflow() reads
>     event->prog concurrently without any lock protection. This
>     causes a data race detected by KCSAN.
>
>     __perf_event_overflow() can be called from interrupt/NMI
>     context, so it cannot acquire bpf_event_mutex. Fix the race
>     by using WRITE_ONCE() in perf_event_detach_bpf_prog() and
>     READ_ONCE() in __perf_event_overflow(). Also store the result
>     of READ_ONCE() in a local variable to avoid reading event->prog
>     twice which could result in a NULL pointer dereference if the
>     pointer becomes NULL between the two reads.
>
>     Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
>     Closes: https://syzkaller.appspot.com/bug?extid=651d2774bd1d8395595f
>     Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
>     Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>     Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
>     Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

The trailer block contains duplicate tags: both Reported-by: and
Signed-off-by: appear twice. Also, the second Reported-by: is placed
after the first Signed-off-by:, which breaks the conventional trailer
ordering (Reported-by/Closes/Fixes should come before Signed-off-by).

Should the duplicates be collapsed to one of each, in proper trailer order?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31550171807
--===============1302207253100925257==--
