Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12205846F
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769451; cv=none; b=jtLFi9T4WbUSdqjBdRoVhWKGPj27/SV5X5XSAHVoe365XZgDOxyW9CDkC1+CQmXULoob6/f91/mJLZLThFUTSMHWO6fxrXKPAVebLh5AqQWGzLK4t8N/IEIhM3XB0krB5nFxgLDcvo8yyS+LEaCr/SYTeNgeq5RxFWdMKKNcsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769451; c=relaxed/simple;
	bh=E0usclP8h7J6a7ryjK9ynNEEBiwpYLSMFVqJCCSy+bE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZKNZNCXM0iVF1V3tsVuXwIC9/x2lpW0jNUdALH1PeuJzwdfRc0vln/dtJqEz8eY82eJ7rtK3NxmuMHiLTqGoEA/MTVuUimoZWXgVp0fWow3apcLJasKIPCmrx8MQdBye2MOOkQkaJ06vR6P9MrmHIJUU4dPlY1NB08b6e/OeiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXx3br+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXx3br+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D8FC19425;
	Sun,  3 May 2026 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777769450;
	bh=E0usclP8h7J6a7ryjK9ynNEEBiwpYLSMFVqJCCSy+bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VXx3br+ZuZymXc4aOBFLwwukK6O63eG8mUuQqlgBiJYg2knF+Q8Oievi5RCw+Y0ZX
	 D+393GqgxxnDpHobLy8e4Mf8a3HQRavRAdPsY6/+gy96amEPE1muRw/lFK+SXC8qIQ
	 6doVBlgtmZtwK4bj5aDfZDhYX5qCAevC1Wql8l+9dBDkuqnzJLkJ9YGM0amhuiRGZp
	 wxgLWDJJUcwqt10mRfV3Ka4RvqnHe+NFFdD3TdLJdaSaYjzoQwNdKbG/vUBHQaUQoi
	 b+BUVcfHyxB66I6hPlv5/cOUXcVIWQ7gbfcaw3kT5F4PNFDlXFFzl3kltQI3krqNxL
	 Jp9I/P+rHq2eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/18] perf capstone: Determine architecture from
 e_machine
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-5-irogers@google.com>
References: <20260503002248.1040791-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 00:50:49 +0000
Message-Id: <20260503005050.65D8FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional application of CS_MODE_64 and CS_MODE_32 breaks Caps=
tone initialization for architectures like ARM, ARM64, and RISC-V.
- [High] Uninitialized `is_big_endian` on thread cache hits causes big-endi=
an architectures to be disassembled as little-endian.
- [Medium] Lockless multi-variable data race when caching thread `e_machine=
` and `e_flags`.
--

commit 438f1b068410120794eb1080db889c82f269a06e
Author: Ian Rogers <irogers@google.com>

perf capstone: Determine architecture from e_machine

This commit updates Capstone initialization to use e_machine instead of arch
strings to determine the architecture. It also adds e_machine translations
for MIPS and RISCV, and removes unnecessary maybe_unused annotations.

[Note: The report format has been altered to provide a free-form summary of
the findings instead of inline diff quoting due to recitation restrictions.]

Regarding the implementation of e_machine_to_capstone(), is it intended to
unconditionally set CS_MODE_64 or CS_MODE_32 in the mode parameter for all
architectures?

Capstone defines CS_MODE_32 as 4 and CS_MODE_64 as 8. While these mode flags
are valid for architectures like x86 and MIPS, they might not be supported
for others. For instance, RISC-V uses CS_MODE_RISCV32 or CS_MODE_RISCV64,
and ARM expects CS_MODE_ARM.

If CS_MODE_64 or CS_MODE_32 is combined with the architecture-specific flags
for ARM, ARM64, or RISC-V, could it pass an invalid bitmask to Capstone and
cause cs_open() to fail with CS_ERR_MODE?

In functions like capstone__fprintf_insn_asm(), the is_big_endian variable
is initialized to false and passed by reference to thread__e_machine_endian=
().
If thread__e_machine_endian() finds that the architecture is already cached,
it takes an early return path.

Does this early return path bypass updating the is_big_endian out-parameter?
Since the thread cache only stores e_machine and e_flags, could this cause
big-endian architectures to be disassembled as little-endian on cache hits
because is_big_endian remains false?

Additionally, when thread__e_machine_endian() caches the architecture
details, it appears to update e_machine and e_flags sequentially without a
lock or memory barriers.

Could a concurrent thread observe the newly updated e_machine, take the ear=
ly
return path, and read a stale or uninitialized e_flags value before the fir=
st
thread has completed its update?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D4
