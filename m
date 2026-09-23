Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193D38E8A3
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182191; cv=none; b=uK59K1TlhdhpS/auBgCLfJdHv3mGoJ6GNfdLFtK5MIjhPYPztpuVsvaxArMGMiWGyY2GYo4WyIaRMru9hUE1Imfv2yvmIKnRQmYwsoWjLbHC1Es0bSwcaNcIITfJFzOgkhKa99TzyWJoZogp6xhDqlQJtOPGCFWn8bZ38sXm5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182191; c=relaxed/simple;
	bh=tH8tEOYzeSrmf393bfTSL8v+8NbmPfhK/h7Q9cAqHW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LEEANO6LLVknWuPYcx89gGyu3PtO+XTn/q4HMTiP7LBJjGIwl/rDxpo6UD/ajXkxOMcQRkcWRLOT6TmgAN/kUTleBQAQ2w123Fzaz46hzTJfVX+A+eUBPXZxcFGn2qGWvBx9rciu6sOkoZuTcdUa4t6m8rQIa71Sv2YufJsEwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHFJ5wRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHFJ5wRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FE71F00893;
	Wed, 23 Sep 2026 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182189;
	bh=fD1MRzklenxCcCMbBDm0+qHYCXCcltXwuNHR4aIwwMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHFJ5wRSqVTtnfxiLNliz2bqszJ+9ag8XqbKmC5LUq8/S6hHgpGxlWli39o59YN1o
	 xrDXnJY3mPc9+whI2RGR9cf86TPKgup+11yNDhRCGKMtYVTv8LSjNJJTMgQK0bQcgB
	 Ot326ICWKfTNQQTL/+15QtBk1KBikd/AWl1Q8EnwxThO4gA4qpU4LwJGPYKUFw/wYK
	 jhyXoOA5PSFr1VY6g5IEJmU6u/0Em79aWPfo2R6M8+ZE5b47/EPe4Kr1c1mdpzdW89
	 3UVa3DnSk2owexne43t3XsQsLtunbGW/T4nbMGcY4QaMGigV6s903MPqsVwAN3oy0S
	 xo9hjCaGZDU0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/14] perf tests: Check CoreSight abort entry and
 exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-13-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-13-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:49:49 +0000
Message-Id: <20260923164949.C5FE71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add page_fault_loop to repeatedly discard an anonymous page with
> MADV_DONTNEED and read it again. Each demand fault is resolved without
> signal delivery, so the load must be retried at the same PC.
>=20
> For example, an expected int/iret pair is:
>=20
>   int            5ccadc =3D> ffff800080010c00 insn: 00 00 40 39
>   ...
>   iret ffff800080012284 =3D>           5ccadc insn: e0 03 9f d6
>=20
> The LDRB W0, [X0] at 0x5ccadc faults before completing. After resolving
> the page fault, the kernel returns via ERET to the same PC to retry it.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D13

