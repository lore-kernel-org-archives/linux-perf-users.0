Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838104EDCD6
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613110; cv=none; b=GXoMA7mVd7m7bscZgZT3rC5ulQR5pnc8cx9hdOGtCwPx8hvqK93l064F2xHZ1i8HsHLwXRwI8qajKeX8whad9UhYV/bfM6WsexQa/PoEA2OKwIMPN/yLRfDoN2QXvz5uOIo1MPX1v4MBtm6TB8I5qyO9/gD+bzy0OLqEzG3q8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613110; c=relaxed/simple;
	bh=rdBQD8pxg85IVChepzK7Yhdz6S+OdcAAlz/fwNtSImM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TzLZReLFp8UnWV/vBvj+vsyODvm/bc3XsC8haUXN75jIdJV318MNtYI3aa7a9src/Ih+VRPcNi5EB4mmNitPLeZk+EXLbTmLl4GpFRUuUqnW85NR7kHZMQ39ptFgef8B5kiGELIL9hGEtX1tTnnBXDOr13Qq5ynz3/jSolmV7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnHIjrPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnHIjrPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0D71F00893;
	Mon, 28 Sep 2026 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613109;
	bh=1aKAwEtw94np8VzA7IvBueWaWxcuJ0qT1kY2bUCzGOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnHIjrPSuaDZm4eEp/BucSw05sD9z+iU1GKUi5fqVN48qOtJXl6Zbu4fZ5HnkAvAP
	 GbfnAIqDaVHiE0FP5KJ1zxWhENWl+S3i2EbRQi41gjCJXyKO7ybUI1d9hxL7Zrs5tA
	 xMJRkrwMtBZXlIeNQkFSW3UcxvYgCuWXgFCMu5SKJD+BDRnnLkyD0eot2O7Kbne8AE
	 8kkxWVNifec225MR8LWAbpuwZApxp5pXdb0e+lajN7havoU3C2Wz89PHlIeukPbnqk
	 b1MDlE9/oVv+HLjiHhdTz08om75rwKdfww0m6um5FPThFcdf/MuVz3wZsqKMJnnW80
	 77zvyv6MZXIOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928162250.2413383-5-acme@kernel.org>
References: <20260928162250.2413383-1-acme@kernel.org>
 <20260928162250.2413383-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:31:48 +0000
Message-Id: <20260928163148.DF0D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: stack buffer overflow in false_sharing via CPU_SET(-1)
--

commit ca3d54512dd3bcec14cdfc83ca90f31bcb2e15f0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add false_sharing workload exhibiting cross-CPU false sharing
   =20
Add a 'perf test -w false_sharing' workload that hammers one shared
struct from several CPUs, shaped as a TCP connection. The packet path
runs in the main thread and up to four lookup threads hash the
five-tuple and pull the config.

> diff --git a/tools/perf/tests/workloads/false_sharing.c b/tools/perf/test=
s/workloads/false_sharing.c
> new file mode 100644
> index 0000000000000..6fccb81e3ed1c
> --- /dev/null
> +++ b/tools/perf/tests/workloads/false_sharing.c
[ ... ]
> +static void pin_to_cpu(int cpu)
> +{
> +	cpu_set_t set;
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(cpu, &set);

[Severity: Medium]
When false_sharing() runs on a single-core machine or a restricted cpuset
(where nallowed <=3D 1), it assigns -1 to the reader thread's target CPU:

false_sharing() {
    ...
    for (i =3D 0; i < nreaders; i++) {
        int cpu =3D nallowed > 1 ? allowed[(i + 1) % nallowed] : -1;
        readers[i].cpu =3D cpu;
        ...
    }
}

Unlike the writer thread, which correctly guards the call with
if (writer_cpu >=3D 0), the reader thread unconditionally calls pin_to_cpu(=
-1):

reader_fn() {
    ...
    pin_to_cpu(r->cpu);
    ...
}

This passes -1 directly to CPU_SET() without any bounds checking. Could this
negative index result in an out-of-bounds stack write that corrupts memory?

> +	/* Best effort: in a restricted cpuset this fails and the thread runs u=
npinned. */
> +	pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928162250.2413=
383-1-acme@kernel.org?part=3D4
