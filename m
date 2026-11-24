Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546863;
	b=tuHDsu11FgIvyDIHUbv4SxxXyptGGyJARijqUpbejEgN15juSHrK4E+TZ/956d29XuUI
	 XiSk3UCmfXFhLF9s0kkz7VvOxbxdGNmqMBoV9CQBnzRqmi5oFE8eeII8JmRQtYAdhF0AY
	 r9IrzS7Z+HY7mWsf/7BAqCuY2Cx/DB4zCtJMxY2b3tbivlyauLI3bsN+i2zOYBP67Smfx
	 vBGtmVx6/uKD0q9JLFgdoRQRKXEcq22mI2jL5g4Uya5wAXUQ99giBeu5ZlDEeJ5hVgFST
	 QnhL/aVfouGS5A6/BP44g6Q5c6ebONxN26OzRhCKE3sBjkOt+VP0SD7Mf+ZwqKWhGsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E09PwbJR1tpDomTq5kdx4+as4vnDjJXiagGEiehI7Gs=;
	b=MJMFHI80vSaytlbn+nzy18zeyyHYy30KichxlIE/WPfRUExazocdtdygecoN6OIsBO+e
	 2p21HpFM/3i7GowIIhduXvb/yW3Y+LJrne25ru0HyoC+G/3E+hNLnvlrdCrlHDOJNEV8a
	 ubae0OsbPmFMk7QfCrNpT7HbwncIxBCnA1p0FcZKZYWGQWZR1/exUqEEv4MMwIdTd6S6l
	 mgPO/zDlI9mI6C9reZp7aBkHIjJZVUxpfDlImQwZAXcgeZME06AGATE/evE0tCaHPe76Y
	 f7PyFvTFiIUJGM6DHXx3pX+AlRFnkT3b1I5OUgW9a2OuVYOtkQ8wqhaMQDXjH7nHoPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdH7QlGk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8E606A33A
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdH7QlGk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A731F000C6;
	Tue, 24 Nov 2026 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546862;
	bh=E09PwbJR1tpDomTq5kdx4+as4vnDjJXiagGEiehI7Gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BdH7QlGkbuTpncRV5voN+5Zfy+t5nfiBxBv5UcVsyqFl/fzKtdwdnP+rrYOlS41IE
	 4i7O9sSRo/j51xwVmH45PoC4tJl5Y/32lE8ZihScRu9rS5Lq9rbTpmTSMa1p/bygQ2
	 j9IpDkDH+ZJ7Jmxk4e69MgyT8PQRui4TSW/M8TUsMDPqWRS8mgB7SwiWMmdklcbg37
	 SPERJQmiMybBIggtF3ThVa9MduxEl/faBUkhOFKNmaqidAd1gLNhkkdJQHG6jhZ/aI
	 SY2z27VVFVa2FkCc64eLrKz2+4G1MTDUe8Uj1+JxR+qgNgIKfiiQmmca2yp9xuOK0c
	 ynMTA2SKOY6Gw==
Message-ID: <sashiko-outbox-231870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/17] perf tests top: Pin the ring buffer size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-2-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:01:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf tests top: -m 128 assumes 4K pages and can fail with
  EPERM on 64K kernels
- [Medium] perf tests top: BPF sideband evlist ignores -m and uses
  perf_event_mlock_kb
--

commit a27a5c7becc862ff1f80abad85898b11bfc88147
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests top: Pin the ring buffer size

This commit passes -m 128 to the perf top invocations in top.sh so the ring
buffer size does not scale with host kernel.perf_event_mlock_kb settings.

> diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
> index 3d52677ccb5fd..4808d79275178 100755
> --- a/tools/perf/tests/shell/top.sh
> +++ b/tools/perf/tests/shell/top.sh
> @@ -19,6 +19,9 @@ trap_cleanup() {
>  }
>  trap trap_cleanup EXIT TERM INT
> =20
> +# perf top sizes its default ring buffer from kernel.perf_event_mlock_kb,
> +# which a test host may have tuned large, pin it to the upstream default
> +# of 128 pages (516 KiB) so the test does not depend on the host setting.
>  test_basic_perf_top() {
>  	echo "Basic perf top test"
> =20
> @@ -36,7 +39,7 @@ test_basic_perf_top() {
>  	# Use -e cpu-clock to ensure we get samples
>  	# Use sleep to keep stdin open but silent, preventing EOF loop or inter=
active spam
>  	retval=3D0
> -	sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock \
> +	sleep 10 | timeout 5s perf top --stdio -d 1 -m 128 -e cpu-clock \
>  		-p $PID > "${log_file}" 2>&1 || retval=3D$?

[Severity: Medium]
Can passing -m 128 cause perf top to fail with EPERM on 64K page kernels?

parse_pages_arg() treats a bare integer without a unit suffix as a page
count rather than a byte size, whereas the upstream default
sysctl_perf_event_mlock is 512 + (PAGE_SIZE / 1024) KiB (only 8 data pages
plus 1 control page per CPU on 64K page kernels).  On a 64K page kernel,
-m 128 requests 8,256 KiB per ring buffer (16,512 KiB across the two
thloop threads), which can exceed the default per-CPU mlock budget and the
8 MiB RLIMIT_MEMLOCK for an unprivileged user.

Passing -m 512K in both test_basic_perf_top() and
test_hybrid_merge_perf_top() would pin the data buffer to 512 KiB
regardless of the kernel page size.

> @@ -83,7 +86,7 @@ test_hybrid_merge_perf_top() {
>  	# environments can seamlessly fall back to cpu-clock while real
>  	# hybrid hardware will naturally cover the merge logic.
>  	retval=3D0
> -	sleep 10 | timeout 5s perf top \
> +	sleep 10 | timeout 5s perf top -m 128 \
>  			--stdio --hybrid-merge -d 1 -p $PID > "${log_file}" 2>&1 || retval=3D=
$?

[Severity: Medium]
Does the BPF sideband evlist in perf top still size its ring buffers from
kernel.perf_event_mlock_kb even when -m is passed?

Before __cmd_top() maps top.evlist with opts->mmap_pages, cmd_top() starts
the BPF sideband thread via evlist__start_sb_thread(top.sb_evlist, target),
which calls evlist__do_mmap(evlist, UINT_MAX).  With UINT_MAX,
evlist__mmap_size() falls back to perf_event_mlock_kb_in_pages(), so on a
host with a large kernel.perf_event_mlock_kb setting, top.sb_evlist still
maps two huge ring buffers for the thloop threads and can exhaust memory
or the mlock budget before top.evlist is mapped.

Passing --no-bpf-event to both perf top invocations (or sizing the
sideband evlist intelligently) would avoid depending on
kernel.perf_event_mlock_kb.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D1
