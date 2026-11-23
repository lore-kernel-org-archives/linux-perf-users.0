Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393474;
	b=qLHxYF/EgddKJRdj2w6DaEYV5gQKChvWJOFuSd5HFkfUup+kbcO3ljWaiACA1ypXt3hH
	 ohsopqXaMLLaq+Z8KgFnarWOD2/TDJb6uCXTMXUDXuA2g0CeS2KGfRig7siHErTIL7xqz
	 RRofbc7bB/AsEXK0Kn4NoyPkTu9u/9VmB6JpOhcr9RmfAmL148TNiNehR+3HiROBt0Pgj
	 E4dKqAUpUEuFFLf22OL9h7JiW5m53zhQDV32Kc9r4OdMj0LYCkrv/FLx+VMRx0hlhw3CY
	 pfb4OHxgMxUXJFGaWfug7FXOkNtcCSvIB31+PHrulV5OO0//d2ukNIblfqQwOuADTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393474;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yfxea34i0nFmPjyjIFxtA/94TX7MB6h/pufN+u3EqxM=;
	b=pEYIgY1Nt0zUbGKAfy1lun30Z+r8+s4CcOlfLhkpN0MVM0jQqnT08K9boDuEewaOWTZa
	 Xs08oW/VJpXfixcKF6/0BvTiEFF85cEJ63hUU7pKf0A0Q/WN8pKDFqa9s6h+pvUgXb/fM
	 ACpWudcSZFV7sSZrBSemKx59YV0MZncwzhlDe72lrFuXYu0P/g780S/MDP08RLMhTYXLM
	 zie/t9bdMf0vbij8TUmbfvJMBnMEZ+jHZNP4HHhrDn0cFa+HRuYK576sI9/RM7sGaxLbD
	 hITu3y7798Uih9Q8OF72VcrIW6YZgIwFPlxUVCL0MhRmQL2qVKVr48Ow+iPjj+jCNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=My3Div0H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB015606A331
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=My3Div0H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5629E1F000D0;
	Mon, 23 Nov 2026 00:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795393474;
	bh=yfxea34i0nFmPjyjIFxtA/94TX7MB6h/pufN+u3EqxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=My3Div0Hww1hWiHLQ+p0q5y4Z9qexsogJS41P0Rn7FkQx4SyCTYLuNIcK5QiBnLo/
	 Ub6v4qErwGQwQrTdh5U7AMSL2oAA0knm+IT3yfphTr+zREAgjBEpnN8fPZzTzSDKd8
	 A7kAybgUPLWAzNHUWpcGH22+bXlWKhdy1I4wlBzO5U3v8n3NqjYuPEUrNxsSbhy9QV
	 uvqdhOaggNhmbsgrSFfFB/Dp5Ia7H41FuZ5lU9Yhgh3IVAnwMpwnwWLX2UjT+wUalN
	 MAXfgROiIBbf4kmppki807TkYh3IqHO5Gwg4jNady5ZBXe0C/XwBfBX80w/8Rfbl+4
	 p05BKceJHdvdQ==
Message-ID: <sashiko-outbox-228471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 00/11] unwind: Minimal DWARF CFI stack unwinding
 for x86, arm64, and riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261122235757.3456048-1-irogers@google.com>
References: <20261122235757.3456048-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 00:24:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 11-patch series:

- Patches 3-5, 8, 10, and 11: no issues found.
- Patch 1 ("unwind: Add Minimal DWARF CFI bytecode interpreter a..."): 3
  potential issues (3 Medium)
- Patch 2 ("unwind_user: Support Minimal DWARF CFI user-space un..."): 1
  potential issue (1 High)
- Patch 6 ("arm64: unwind_user: Support Minimal DWARF CFI and FP..."): 3
  potential issues (3 Medium)
- Patch 7 ("arm64/unwind: Add Minimal DWARF CFI kernel unwinder"): 4
  potential issues (1 High, 1 Medium, 2 Low)
- Patch 9 ("riscv/unwind: Add Minimal DWARF CFI kernel unwinder"): 3
  potential issues (3 Medium)

Detailed reviews have been sent as separate replies to patches 1, 2, 6,
7, and 9.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122235757.3456=
048-1-irogers@google.com
