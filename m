Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C022F39B8
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777708731; cv=none; b=EPlG/o2lW7Rli5TyC0B2RIAMULQsZLExyvZ/XOflqEUiYn0lHhVOlv3dpuVSehjn50kl2UIzpTBgV+QVumC3two8rhCpYuOAAC+4tvISgPAHYBNJtcGx8dQ1Vhb6c9E1mM1lHH50UVOh7Rh57NZHwaEGMHCM690UWLltmmgsnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777708731; c=relaxed/simple;
	bh=bcXaWycd3ReLdfpTti6Ium2mFmiSZ5MWJL9ekyqaiXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d/8iWwHnyMWWU6lboO1hrOt1nX+MQAXzz1Egx8GZ0WkggZ19N1nWN50BU5FsZsbQPDggwmUlsojVb5C3hIZG71fYhgA38hEN6uOUoAeTcQjkSYtO0LRflY6UgAFi/pmk6K2+7w8YjN3J3RtQeOvJy9u4ARCdXWvwtcUe3JAD2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgaRGgMv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgaRGgMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7303EC19425;
	Sat,  2 May 2026 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777708731;
	bh=bcXaWycd3ReLdfpTti6Ium2mFmiSZ5MWJL9ekyqaiXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cgaRGgMvleV/RVngVQQpM0F7ww0yq8UOg7zaRJcJZMU5717R4LsFyP316/PKzPZqL
	 3na5IDaR82IM8gvi5/iXoaWQt6Q3gSoJxcl9BxeEfw5eA28HMml/VCRSpVx3CsnEtP
	 8/lEH6W4u44E3o5stLtwTuivNh86Qw607xC2HS6L3LXBSRj4ahEYYpMdSBZysZoT75
	 AaSx9SJCfH3TKAKbt98GsUpYaZIoKlh11ZV9HqWZCakq08tDK7huT/B8KBA/GY9EAN
	 zrs5kaFFxN36wBuZupgS9Di8wwg3K6Tla88AZu+/9+MP2CW4m2PdoMuCt7erCkkajq
	 8cAWA0sBw/LnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/17] perf capstone: Determine architecture from
 e_machine
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-4-irogers@google.com>
References: <20260502065935.291960-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:58:50 +0000
Message-Id: <20260502075851.7303EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardcoded endianness in e_machine_to_capstone() breaks disassembly=
 for bi-endian architectures.
- [High] thread__e_machine() fallback to EM_HOST breaks cross-architecture =
disassembly for kernel code and BPF programs.
--

commit a3ff746537f2f9677ae9d6427555ff27588e61a4
Author: Ian Rogers <irogers@google.com>
perf capstone: Determine architecture from e_machine

This commit refactors capstone initialization to use the e_machine value
from the ELF header instead of the architecture string, adding support
for MIPS and RISCV translations.

Note: The format of this review has been altered to provide a free-form
summary of the findings without directly quoting the patch code, due to
recitation restrictions.

The new e_machine_to_capstone() function hardcodes CS_MODE_BIG_ENDIAN for
EM_PPC, EM_PPC64, and EM_MIPS, and implicitly assumes little-endian for
EM_AARCH64 and EM_ARM.

Does this approach break disassembly for bi-endian architectures?

Linux fully supports variants like ppc64le, mipsel, armeb, and aarch64_be
under these same e_machine IDs. Because the initialization now succeeds
with the hardcoded endianness rather than returning -1, it actively bypasses
the functional fallback to objdump. Since objdump natively reads EI_DATA
from the ELF header to determine the correct endianness, skipping it leaves
these architectures with incorrect disassembly output.

Could we read EI_DATA alongside e_machine to set the endianness mode correc=
tly?

Additionally, the updated code replaces machine__normalized_is() with
thread__e_machine() to determine the target architecture.

Will this break cross-architecture disassembly for kernel code and BPF
programs?

Previously, machine__normalized_is() correctly determined the architecture
from machine->env->arch, which is populated by the perf.data file header.
The new approach searches DSOs and falls back to dso__e_machine(), which
is hardcoded to return EM_HOST (the compile-time host architecture of the
perf binary) for kernel components like DSO_BINARY_TYPE__KALLSYMS,
DSO_BINARY_TYPE__VMLINUX, and DSO_BINARY_TYPE__BPF_PROG_INFO.

If a user performs cross-architecture analysis, such as analyzing an ARM64
perf.data file on an x86_64 host, won't thread__e_machine() return
EM_X86_64? This would cause Capstone to decode ARM64 kernel or JIT
instructions as x86_64 instructions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D3
