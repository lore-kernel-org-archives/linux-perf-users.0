Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73619C546;
	Mon, 26 Jan 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414622; cv=none; b=Y3Rpe4mHUY6MeKSj2GF9LtYJdbuviXV0Zvc0ogiti1RRYmqBz8gkMTSxN+7qcoxpB+raDC5CpeyvWeOJUDKu8tDtvj7yTK9kg0gBs+DGikB99lacEC2OP3ccrMUM3XqtbC7tzCf8fLbMbsHgWja36Pv8bDwhAHu0Qf8OBepaL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414622; c=relaxed/simple;
	bh=+EBIMl9jh1kDL4APuxxrdWyQc0NGMvAiNy3l6vA9WJ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r1QNgJZRKhXcgGDBpghQG2kH5txXkovjCp9gHVFR2HtgUmt0jO7IltE6YKGL5hL5W0/h684aKngy/pwSH3J/T00G1MnkxwUxjdLJhAAgGxY4lHsd1k/D2j+lAHk8S1cJ86u5ZdyaUN89d6tC/5wcG6GC2VhuRjwgR0tRwrs+xTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdbdYqTd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdbdYqTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6535C116C6;
	Mon, 26 Jan 2026 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769414622;
	bh=+EBIMl9jh1kDL4APuxxrdWyQc0NGMvAiNy3l6vA9WJ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BdbdYqTd0O1oRSosHS4O+IVEyql9qCxIsFsmXKenLe1Wef77Yqtk0FnkBAVmWXLHm
	 TmRkd0Lw3Owq6vkWmZY5EwDmTiduXFPdO9ZWTf9VgtsjXspOUG7TBUDy8X1lBmH9cE
	 LDNbb7Z+v75FIJLRb4k75/IPO3intgSukEhx3hC8oaQvAL33s68p3wEOBvCNK601MW
	 ivl7JFoZpqXj3SMXmSrzkYUVcaDImQdd2bl2pqWFpKKgw9+fh4NWjPjcgVdRfu3alV
	 9dmkMUFRMG3PnA100sEsuukE1fNU0jgEWNN5XNPwxZ6w7MWyUhSzswNJrcpGyEM9Qm
	 eBx1+Z+7+Lqvg==
Content-Type: multipart/mixed; boundary="===============6019120941928558411=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <89d94076412b6fc7e05e4d4884f3830601b390d3dcbee91aff2ec214117411fb@mail.kernel.org>
In-Reply-To: <20260126074331.815684-2-chen.dylane@linux.dev>
References: <20260126074331.815684-2-chen.dylane@linux.dev>
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
From: bot+bpf-ci@kernel.org
To: chen.dylane@linux.dev,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,kan.liang@linux.intel.com,song@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,chen.dylane@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 26 Jan 2026 08:03:41 +0000 (UTC)

--===============6019120941928558411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 9ded2e582c60..0330f265173d 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -57,6 +57,7 @@
>  #include <asm/local.h>
>
>  struct perf_callchain_entry {
> +	int				rctx;
>  	u64				nr;
>  	u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
>  };

Adding rctx before nr changes the structure layout in a way that
appears to break the perf userspace ABI.

In perf_output_sample() in kernel/events/core.c, when PERF_SAMPLE_CALLCHAIN
is set, the code does:

    int size = 1;
    size += data->callchain->nr;
    size *= sizeof(u64);
    __output_copy(handle, data->callchain, size);

This copies (1 + nr) * 8 bytes starting from the beginning of the
structure. Before this patch, offset 0 contained nr (u64), followed
by ip[]. After this patch, offset 0 contains rctx (int) + 4 bytes
padding, then nr at offset 8, then ip[] at offset 16.

With the new layout, this copy sends the following to userspace:
- First 8 bytes: rctx + padding (kernel-internal data) instead of nr
- Remaining bytes: nr + ip[0..nr-2] instead of ip[0..nr-1]

This means the callchain data sent to userspace is shifted by 8 bytes,
the last IP is truncated, and the rctx value is leaked to userspace.

Is there a plan to update perf_output_sample() to output starting from
&entry->nr instead of the structure start? Or am I missing something
about how this structure is used for userspace output?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21350234831

--===============6019120941928558411==--
