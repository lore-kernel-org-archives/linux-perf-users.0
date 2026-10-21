Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561057;
	b=1vKHRQdKUyGmorkmFXejlc2f/W4e4ZLB9AVU/6lJQkCdnK/8MM4LAAvdm6lcG8fJuKoa
	 R6LnisIUkMqdq2dyCmDaZJxV08Rx84bFe1FcoJn+dp7GLmyqUcahYwkGbfZGVC0XvFCZm
	 B/Fn/9mmKDCZ3c2nQBc5W0EcV1Jv83j6sXPrzkFsYjhrGn9Bu8xEmCv5U9qa+OSCZXajY
	 nH6JBJtPKLLUglYCM6CTIee+DBEOyQnNFYfXY3mtKF4jwGcEIRtjzezBEulopkWF0pyiL
	 GgXmZEsRM17UuBD9ZjQMav2sqAHKG2QjpvXSOqRNTQXwHVMnYks5gXV4znILgsLvu3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561057;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZLknNG4j+P+5xiDYU0vvVoDMNeUOGnnS8wOAc7BfbMQ=;
	b=TyDmo1tDL754D521TZDfKusxjhoiLOJN0x18VDm1oY4S8jVL9DCHrL0maLDhSN7Z518H
	 u15A291kW6guH1QAkkL7G7NXhyQeuYttftYOCkOWrhLrw0gUH2ejokalC057Eh8DIITp1
	 gY1zU9jqlxKGiStqeRL0D56r9hu2fYeszdT+jDW6jIDuX5vrGZJeiFmEB8hlpTa1W0/t4
	 IcRmK1zibRCXcGRX3y+L3Mo4o0k77kmxn5zULQWS0fbbY3CCvhMvhEfPIckbPAA1puAr8
	 fSkXXSNgsaJet8XN+Sy6jh73lsn9tMuPPCqIkMxKxbfjVBoAMcoQVCQpgSVigbSSSPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqpY8hha;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAE606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqpY8hha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02CA1F000CB;
	Wed, 21 Oct 2026 05:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792561056;
	bh=ZLknNG4j+P+5xiDYU0vvVoDMNeUOGnnS8wOAc7BfbMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqpY8hhaQJkZgtz/hCq0uV6saW1z3l6l1ldaFG3mwHE8HyynR0vn3JTmfL26vI7CY
	 bRoTcvttFg6iDsUzpLJDm9MNLmfeTbWB7Eer9SGgE0By39/tXcAqAXqYTK+flzhOB3
	 OiDmEFWJx1TuAJaW3YRjCJBXFN8vsZeakI1zNIniLQe2A3HwyaVkg1COqZWXFdtX9t
	 JMzjMbS7cJwIq7dGf2koqtIjlF4xxIi08hkjw+2fFVXMgySFE+O4iDXPmEtqY0pWil
	 Uut5Z3pUdNWc9Z8X86EAeoFZD+/G4re+Y903RH16QZQ/4eugpvYQUQ1+uAzl1cefAf
	 7u8lXJZQb1vUA==
Message-ID: <sashiko-outbox-179810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 4/5] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021050711.4043703-5-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 05:37:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The branch snapshot callback used by bpf_get_branch_snapshot() always
> copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr hold
> invalid branches which end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> no active LBR events or LBR hardware is owned by guest. So the stale or
> guest LBR stack data can't be leaked.
>=20
> For the case where all LBR events are PEBS events, hardware LBR reads are
> currently skipped; that can leave stale LBR stack data from previous PEBS
> sampling in place and may be inconsistent with the intended semantics of
> bpf_get_branch_snapshot(). This will be addressed in a follow-up patch.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021050711.4043=
703-1-dapeng1.mi@linux.intel.com?part=3D4

