Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744338;
	b=nNQ4jM0D0Q5qHahr8FoB3iZw6I/eP5B4J4EZnKrI9KKJqoYV+Qynd2ns2Phl+4wQbtO2
	 Tv1hEN9s48YSMFfvLiPpWVWWSQ8KWJoD8USpAXu68I4CqPjJwc2KyFbjovXlkcxiKE0hP
	 OM4V8WerbKeiCHNRPKbQdbTjvKjGV4hxAaRUEKotLLLJJx7MjZjmxzlQX3kEkSBvhDECi
	 XqcjFJ37iwybpFZ5NdFNtugdms/GZ8+s4SNtjJFvEDGW3VTUxIa4knrBXhREmN967LqDF
	 QI+jZ2F1K1CE42H4yiCY6RtULyZpGPl836XUm6wsy/LoJ5ITeOnRsZpK+uP3xorS5vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rX4U/iQCLQozxn+D2y8C6B/4D3WL6a5ToUooPxeNx14=;
	b=BxXxkb0n+8hsl3DWXX3T/NtDmHotO5rzLCPW3q+jlIGymViWjVN5oP/axNBaEDXuJA3E
	 5LRrLn6+9lpmNX/SFtXjhXFU21YJ+zY721pN4MeYwz7dwdq6f01sNPnwUIe9DFZeKe3da
	 JrrWmrPx7tqjbHwRQU76BopO9QFGCXKItr/qbuIKy4zEjtuzoSrR3LkJD5O7mvmqelron
	 APkUijxY1nb6qWU5wAC9PEkbaREjIq0whCCGU7CKpo8RQvp7QPyNM4orEudqeuXYsaVTw
	 2gu4ksXsuGNG0qTvhnxIxmafMmYtxLwbhYo/xWSlgqaql1x06LxL2MgP0kk8Oe9aQHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvpdkEwi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51136606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvpdkEwi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828D31F00898;
	Fri, 27 Nov 2026 01:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795744337;
	bh=rX4U/iQCLQozxn+D2y8C6B/4D3WL6a5ToUooPxeNx14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvpdkEwi14cNyaLHsQbAPtuxUOYSPL37Peg2+CcqxpadffThAbfOiANC9ySBi8g+g
	 V05fSxASz1f6pGl8CxuplO7kzM9KX0WsOCubcqSpTdlhuc+rmtlPnE/ayqSXuhJA6n
	 7vZqZvKNnkfQVmqw4+B8zLFlKZw4Yk83ysN9gDJfMVIOT4UEH4Bs0B7JPRJky+5g5G
	 gvn+ucSQrRHPAfSz5+lWAc/ohqD+FEEgWix6c/ikt73j0cgN3Mq0QJ8BL5d+xFeldN
	 bqqicW9OgMiZPDfXmB/cUJ75YndjhZYHwcYfyHnYNNHI/wXU/zIIENZs0u/GQ1ViZU
	 +8YatCWkfNwig==
Message-ID: <sashiko-outbox-236418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/18] perf tests record: Exercise more record
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261127013801.14841-12-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
 <20261127013801.14841-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 01:52:17 +0000
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
- [Medium] perf tests record: always-true test -s on sysfs cpulist in
  threads_numa_supported()
- [Medium] perf tests record: unreliable 4K switch threshold in
  test_switch_output()
--

commit 9516ae4b075b086c3162b32da08e72df6c1965fa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests record: Exercise more record options

This commit adds a new shell test script that exercises additional perf
record command-line options.

> diff --git a/tools/perf/tests/shell/record_options.sh b/tools/perf/tests/=
shell/record_options.sh
> new file mode 100755
> index 0000000000000..ccedb1ebc3dad
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_options.sh
> @@ -0,0 +1,215 @@

[ ... ]

> +test_switch_output() {
> +	echo "Record switch output"
> +	if ! perf record -q -e cpu-clock -c 1 --switch-output=3D4K \
> +			-o "${temp_dir}/sw" -- sleep 0.2
> +	then
> +		echo "Record switch output [Failed: perf record failed]"
> +		err=3D1
> +		return
> +	fi
> +	# --switch-output also timestamps the file at exit, so checking for
> +	# a sw.<timestamp> file is not enough, there has to be more than one.
> +	if [ "$(find "${temp_dir}" -maxdepth 1 -name 'sw.*' | wc -l)" -lt 2 ]
> +	then
> +		echo "Record switch output [Failed: no switch happened]"
> +		err=3D1
> +		return
> +	fi
> +	echo "Record switch output [Success]"
> +}

[Severity: Medium]
Can test_switch_output() produce only one sw.<timestamp> file and fail on
systems with few or no loaded kernel modules?

Without -a, cpu-clock only fires while sleep 0.2 is on-CPU during exec
and exit, so reaching the 4K threshold before the workload finishes
depends on synthesized startup module MMAP events exceeding 4KB.  When
startup synthesis is smaller than 4KB, any threshold switch is deferred
until ring-buffer drain at child exit and runs back-to-back with the
final at-exit switch; because fetch_current_timestamp() uses 10ms
granularity, both switches generate the same sw.<timestamp> filename and
rename() overwrites the first file.

[ ... ]

> +# perf record --threads=3Dnuma needs every online NUMA node to have CPUs,
> +# a memory-only node (empty cpulist) makes the NUMA topology setup fail,
> +# so only run the test when that is the case.
> +threads_numa_supported() {
> +	local range lo hi n
> +
> +	[ -r /sys/devices/system/node/online ] || return 1
> +
> +	local IFS=3D,
> +	for range in $(cat /sys/devices/system/node/online); do
> +		lo=3D${range%%-*}
> +		hi=3D${range##*-}
> +		for ((n =3D lo; n <=3D hi; n++)); do
> +			[ -s "/sys/devices/system/node/node${n}/cpulist" ] || return 1
> +		done
> +	done
> +	return 0
> +}

[Severity: Medium]
Does [ -s "/sys/devices/system/node/node${n}/cpulist" ] always evaluate
to true, even on memory-only NUMA nodes?

In drivers/base/node.c, cpulist is declared with BIN_ATTR_RO(cpulist,
CPULIST_FILE_MAX_BYTES), so stat() always reports st_size >=3D PAGE_SIZE
(and reading an empty node's cpulist outputs a single newline byte).  On
a system with an online CPU-less NUMA node, threads_numa_supported()
still returns 0 and perf record --threads=3Dnuma fails in
record__init_thread_masks_spec() with -EINVAL.  Checking that the file
contents are non-empty after stripping the newline (for example,
[ -n "$(cat "/sys/devices/system/node/node${n}/cpulist")" ]) would detect
CPU-less nodes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127013801.1484=
1-1-acme@kernel.org?part=3D11
