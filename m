Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C74519A3
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587150; cv=none; b=HX2C4fvqqdb6DCZr5DuLRM0DRsKsfkbGrdWuSl25JxF7dXB1cpYFiZShqOaZj7Wv5slCaH0HZgON7edd75qh4v4z+6/rDueKmH7PnhkWg51n/yaE/1fqKlDtQpHMxUjmT+bnRE4IT2ne/0Yf7aDvUvLVQ2b70vM+kO6nwjw84JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587150; c=relaxed/simple;
	bh=9J3AcSv2kMQbTMlQHlviNEkdPL8KrSp5qEip4jmwl08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQ6ZViPmRH1SxxXqwuxSy2+InutSnlN1HiuKDhy/3j2oK+ZkVzao9TNVMv/q1fhltn7ZvBUbn37kUQ0EgHQiYdJp4ib6d4hXLatdSNFE8ngr2C3KvtofUQMIQr+wyIsmPaCW5F1VUc2c4kfY2jNUedPJ3msPLf7V89JtjkrX31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJgqmS09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJgqmS09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01101F000FF;
	Mon, 28 Sep 2026 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790587149;
	bh=kIUCChVR1R/zXQUAKOd0olnO6hrM3HCJ9nptynHj6MM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJgqmS09jj2hByFsSXjupcdhqC3nFEmcW/jiNRLH85vtZxdtnocA4ZyLBBGvk2Ur6
	 XQsYI0H63MkjG7TGXrgZv1d5BAJtwu0TEj90Hq3pezBXzGJT4pNhUspk27swvyPpmi
	 VJEY1gIbrQIDoO5DVUl8tK0JtYc0pYl0GupN6/CDcjKJQ2psTjoMQoauG/zqnrIo1R
	 j+1ZJcpreFc0OhY7oAHPrdL300kKrLM0ODVNOjxohNBqlstiJrcaap7POCkOQAdOCd
	 76HJYfjUrKdxwR8p/983LTWmxPhxMHcr5Y2z1x1M5gQaj7dE5mH+pwGUjLLbm4mk++
	 HM1HW4nRfe2rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Record kcore for the CoreSight callchain
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928090644.24346-1-leo.yan@arm.com>
References: <20260928090644.24346-1-leo.yan@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:19:08 +0000
Message-Id: <20260928091908.E01101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/test: fail instead of skip when /proc/kcore is inaccessible
--

commit f13d58799b60cb0c738cb7c9e2cb5ed0a5fa9e32
Author: Leo Yan <leo.yan@arm.com>
Subject: perf test: Record kcore for the CoreSight callchain test

The CoreSight callchain test traces both userspace and kernel execution
and checks the callchain across a syscall.

Add --kcore to perf record to save the running kernel image alongside
the trace data so perf script can use it to decode the kernel trace.

> diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/t=
ests/shell/coresight/callchain.sh
> index 13cca7dc11184..b69187f1a37f5 100755
> --- a/tools/perf/tests/shell/coresight/callchain.sh
> +++ b/tools/perf/tests/shell/coresight/callchain.sh
> @@ -43,7 +43,7 @@ record_trace()
> =20
>  	mkfifo "$cf" "$af"
> =20
> -	perf record -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$=
cf","$af" -- \
> +	perf record --kcore -o "$data" -e cs_etm// --per-thread -D -1 --control=
 fifo:"$cf","$af" -- \

[Severity: Medium]
Will this unconditional --kcore flag cause the test to fail instead of=20
skipping when /proc/kcore is inaccessible?

If /proc/kcore is missing (e.g., due to CONFIG_PROC_KCORE=3Dn) or restricted
by kernel lockdown, perf record --kcore returns an error. This error causes
record_trace() to fail, which propagates an overall test failure (exit
code 1) instead of gracefully skipping (exit code 2). This may cause false
positive regression reports in kernel CI environments.

Should skip_if_system_is_not_ready() be updated to check [ -r /proc/kcore ]
to ensure the test degrades gracefully?

>  		perf test --record-ctl fifo:"$cf","$af" -w callchain >/dev/null 2>&1 &&
> =20
>  	# It is safe to use 'i3i' with a three-instruction interval, since the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928090644.2434=
6-1-leo.yan@arm.com?part=3D1
