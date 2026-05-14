Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346682D836D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783289; cv=none; b=ZycAYQI9CX9T/hm5rv7K7U5qhHZJbEKnWnp/jR2Kij4f4o8H86Cb4FJh+G1GSSGupsJvSIwqluEWEsMwViOVeZYjV6ih2+vqBb/8CN+Gn9SPJ+AvX3LoxiiwtUjc+Ql3aogxWB/sNnhtASDSMX810U7L09F7Hq12i9ckLykUkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783289; c=relaxed/simple;
	bh=IXUAFQxsjd7jrfq3fX/B6SxfJvVIvdVptvwpfQVzSEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPLp9MgE0OSr2KLTmQM76UR+68JbjUEko6fDNTzuKYXJ5uPcAaVCyiJzq8znk1x0mYJeZQrW0LYzUDF62qKweCP32G8hKDKU3r/8kgsmtIQWGdAWfwuMEAQGZ5J8QP/9obhb48ZpKKzmzFlT0w8B3440hBGa+9/0sOMS8vk5Yik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsLiUeew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsLiUeew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9847C2BCB3;
	Thu, 14 May 2026 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778783288;
	bh=IXUAFQxsjd7jrfq3fX/B6SxfJvVIvdVptvwpfQVzSEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UsLiUeewBi3sXoCuIz4WMiexAB06SgcCcoOmBsx7iTQjBO0EwxLg24J2+AxwXrcrs
	 /g26lJLkUPDeTntHwiY9qoLVvSPz5gVxTkCNU/pB8NX7COUDXGUFY1mwBiCrpmETrn
	 S01zEc6MteftV1SVaDI4sk8OevRfaCjWW0Hix7yw33JfdtSvM726icjS+TvwFC+3r/
	 lnwisQW15wmvlqxdbpFQL6TSCbOpMYojNCFeSHnVn9KxsOTGVqjViMtQHVkOqnUoPY
	 BOAq3xKbNlnPu8EMEJjMuZ1xNc4YC8H7TO42Rfq3pbXGhg3QxOACuA7g5/W4AhnBmb
	 CSfHjU8st9L4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/14] perf test: Remove /usr/bin/cc dependency from
 Intel PT shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513230450.529380-15-irogers@google.com>
References: <20260513230450.529380-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 18:28:02 +0000
Message-Id: <20260514182802.D9847C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing instruction cache flush causes SIGILL on non-x86 architect=
ures.
- [Medium] Corrupted timestamps on non-x86 architectures due to incorrect J=
IT dump flags.
- [Medium] Failure to propagate `mmap` errors causes cryptic downstream tes=
t failures.
- [Low] Dead code: Fallback error message for unsupported architectures is =
never reached.
- [Low] Insecure file creation allows symlink attacks.
--

commit e93f510895eeeef8fa2a184cec0136d1c167c471
Author: Ian Rogers <irogers@google.com>

perf test: Remove /usr/bin/cc dependency from Intel PT shell test

This commit replaces the runtime compilation of a thread loop and JIT
workload in the Intel PT shell test with a built-in jitdump workload.
It adds multi-architecture compatibility by dynamically encoding
instructions into opcodes for various architectures.

> diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/work=
loads/jitdump.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/tests/workloads/jitdump.c
> @@ -0,0 +1,165 @@
[ ... ]
> +static FILE *open_jitdump(void)
> +{
> +	struct jitheader header =3D {
> +		.magic =3D JITHEADER_MAGIC,
> +		.version =3D JITHEADER_VERSION,
> +		.total_size =3D sizeof(header),
> +		.pid =3D getpid(),
> +		.timestamp =3D get_timestamp(),
> +		.flags =3D JITDUMP_FLAGS_ARCH_TIMESTAMP,

Is it correct to unconditionally set JITDUMP_FLAGS_ARCH_TIMESTAMP here?

On non-x86 architectures, get_timestamp() returns a monotonic timestamp from
clock_gettime(CLOCK_MONOTONIC). If this flag tells perf inject --jit that t=
he
timestamps are raw hardware cycles requiring conversion, won't applying the
hardware-time conversion to an already monotonic timestamp corrupt the
injected event timestamps?

> +	};
> +	char filename[256];
> +	FILE *f;
> +	void *m;
> +
> +	snprintf(filename, sizeof(filename), "jit-%d.dump", getpid());
> +	f =3D fopen(filename, "w+");

Does this file creation pattern allow symlink attacks?

If a user manually executes 'perf test -w jitdump' in a shared directory
like /tmp, an attacker could create a symlink with this predictable name
(jit-<pid>.dump) to overwrite arbitrary files. Would using open() with
O_CREAT | O_EXCL be safer here?

> +	if (!f) {
> +		pr_err("Failed to open jitdump '%s'\n", filename);
> +		return NULL;
> +	}
> +	/* Create an MMAP event for the jitdump file. That is how perf tool fin=
ds it. */
> +	m =3D mmap(0, page_size, PROT_READ | PROT_EXEC, MAP_PRIVATE, fileno(f),=
 0);
> +	if (m =3D=3D MAP_FAILED)
> +		pr_err("Error creating jitdump MMAP event\n");
> +	else
> +		munmap(m, page_size);

Should this mmap failure be fatal?

The code logs an error but proceeds to execute the workload and return
success. Without the MMAP event, the perf tool cannot link the JIT dump,
which seems like it might cause the test script to fail later with
confusing errors.

[ ... ]
> +static int write_jitdump(FILE *f, void *addr, const void *dat, size_t sz=
, uint64_t *idx)
> +{
[ ... ]
> +	if (fwrite(&rec, sizeof(rec), 1, f) !=3D 1 || fwrite(dat, sz, 1, f) !=
=3D 1)
> +		return -1;
> +	return 0;
> +}
[ ... ]
> +static int jitdump(int argc __maybe_unused, const char **argv __maybe_un=
used)
> +{
[ ... ]
> +	/* Copy executable code to executable memory page. */
> +	memcpy(addr, dat, sizeof(dat));

Does this code need an explicit cache flush before execution on non-x86
architectures?

Architectures like ARM, RISC-V, PowerPC, and MIPS have separate instruction
and data caches without automatic coherence. Since memcpy() only updates the
data cache, won't the instruction fetch unit read stale data from the I-cac=
he
and trigger an Illegal Instruction (SIGILL) exception?

Could we use __builtin___clear_cache() here?

> +	/* Record it in the jitdump file */
> +	if (write_jitdump(f, addr, dat, sizeof(dat), &idx) =3D=3D 0) {
> +		if (sizeof(dat) > 0) {
> +			int (*fn)(void) =3D addr;
> +
> +			/* Call the function. */
> +			ret =3D fn() - CHK_BYTE;
> +		} else {
> +			pr_err("jitdump workload not supported on this architecture\n");
> +			ret =3D 1;
> +		}
> +	}

Is the fallback error message for unsupported architectures reachable?

On unsupported architectures, the dat array has a size of 0. In
write_jitdump(), when sz is 0, fwrite(dat, sz, 1, f) returns 0, causing
write_jitdump() to return -1:

	if (fwrite(&rec, sizeof(rec), 1, f) !=3D 1 || fwrite(dat, sz, 1, f) !=3D 1)
		return -1;

Since write_jitdump() returns -1, the outer if (write_jitdump(...) =3D=3D 0)
check will fail, and the else branch intended to print 'jitdump workload not
supported on this architecture' will be entirely skipped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513230450.5293=
80-1-irogers@google.com?part=3D14
