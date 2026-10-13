Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7FC5476E2
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922899; cv=none; b=mwzOlrBMH85chA25NKy4ITZguVq/un3j4MAYcyOFWrzzmTlhRA3Ms2Cny/Qokgy+T15ia+XoE9xk8zjWUMxI+p5sG+EzmW0gs9yRCUsqs/6z90Vgs0ZEYuY/u1UE5SgFHQiSv1KbqTds2iYl7O6wVLp9rbdmuvXWBMY3NeLpPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922899; c=relaxed/simple;
	bh=NtOmbdMVoG3PBHKTcRE0arXt/KKuMMRr1hlMxn6mO5Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cBv5BcPJImHkkSuCXzXy3nYT1tOkgmvEe6XXAEyqCQNVOpZ/ayPbVq/srDTkclYTvGn0JqE/82VFFMlRME2B0oHS0qYB9hp8NPuuKJKT+LDlBvW/M7xyftSxoHzf/N0A26KVOOFXLRSaCDECEK+E/prPeVt3GxCtiLFWJ0MjznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ9l0HbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ9l0HbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466FB1F000FF;
	Tue, 13 Oct 2026 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922895;
	bh=NgA4YFb8lQ4kMzXljbLdU4Q6Pj0svEvLdyoUTnb5cP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJ9l0HbZPmV1WwZsZYywK/Yyfe9Fb25d58dSohjNheD1XulEmU5MX0IrV2I9eAkQm
	 8MUkQIqmnaOUUx6uSyjnAjI3yxX9RdrDUILMLoXImCD1PsdjeT1B1h+pWrm4hdHjA5
	 kmThXKi8b4dqgGtJ6oq+s2B8U4mov8bkrCXJ0ZKrElgnHkeIQyU6hsk4WS77Hmmk1U
	 tkbqtf0FcQUKakGVwrz3AHcOp5a8P566Nj27lz3z4No+juv8xFy+1A/4gq0OBiFp+y
	 nha+fFP+YQg0YHL06M7CplDRwwpmKB2Z5a+QV5AYPgaa7mD+B+EQaGYJzEzXRglVjQ
	 M+dq4WGSz2AqA==
Message-ID: <sashiko-outbox-170446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/19] perf test attr: Fix record dwarf sample_type
 expectation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-2-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:21:34 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit bdd051e24914 ("perf record: Split --data-mmap option"),
> record_opts__parse_callchain() sets record_data_mmap instead of
> record->sample_address for the DWARF unwind mode, so -d/--data and its
> implied PERF_SAMPLE_DATA_SRC are not enabled implicitly anymore.
>=20
> As a result, --call-graph dwarf no longer sets PERF_SAMPLE_ADDR and
> PERF_SAMPLE_DATA_SRC, making the test fail:
>=20
>   expected sample_type=3D45359, got 12583
>=20
> where 45359 (0xb12f) is:
>=20
>   IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|REGS_USER|STACK_USER|DATA_SRC
>=20
> and 12583 (0x3127) is:
>=20
>   IP|TID|TIME|CALLCHAIN|PERIOD|REGS_USER|STACK_USER
>=20
> i.e. the values differ exactly by PERF_SAMPLE_ADDR (0x8) and
> PERF_SAMPLE_DATA_SRC (0x8000).  The mmap_data=3D1 expectation is still
> correct as DWARF now enables record_data_mmap.
>=20
> This went unnoticed until tests/attr.sh stopped ignoring attr.py's
> return value.
>=20
> Fixes: bdd051e249141c79 ("perf record: Split --data-mmap option")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D1

