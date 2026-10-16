Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693A3B7B98
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185829; cv=none; b=Xdl0C8WmEIhkuZs5KvZDpLA4iVCKvcQEuY3OKRw5dHO7XtvQPlTqDHRAYVePKy8bu0k5yyOB9oMyShC/sRsEOxAf71M3lX8gvraTk2nXWVfm7/NJBlRG4pNaQpM7u1E2CbT3DOo/aGi6zp/p1+fCAEG0/5O2Cuh7o2NiSx2WibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185829; c=relaxed/simple;
	bh=CrW9bqKQ4Z8HjmzJYALs+spwtjxHTuKq/nBI5SRrYLg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hmsLhsgMAjpH0js1hmgVguPr9XI8b72Jb8fmxOlpdpS9WkSr4K+Ph6FQMcDHdGFmnsQrf57yrWkd3cF9ISvY6eaEoAllUuErme1kAT005sjKnsmrUzgkt9bqjJLWJqx1CddGAoWMSw/aiSbcDy0P9PdZNWGKgNNFWJEh/2hr6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihR0fx2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihR0fx2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692AC1F000C4;
	Fri, 16 Oct 2026 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185828;
	bh=tVI68spx2iokU1DfcvwY+6g2v7+JxKAa3RvP2ed2JQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihR0fx2AIfUATNUy2iEC0BiGdBrDasMlmJuajqvMVT3KCoWiFVwWW8e64qg+3mFuR
	 Glcu65Nn1yEr25n/YILsg/wlsqUfdcbZ2evPs/mPbnQ7ZkPOwvBmdItltKXBg+eUUR
	 700MPjmhbKdTT/Z8HankBKeM7vmer6Ne3fU9dhiXWAzm3AwxU7KuLDbx6vxixgSkTc
	 9wDUuXHrcmNJ16E5OZmQEf4VONcMhDD7cuJM1JVLn5cgpHMH7uhwreDgOMKv5RC3PH
	 BrPZJr60OrTtZ95eFAjL3hEVi4TuD6CjGoLrz2U08fNLHq9mfeR7K+PE/MpM0BcUnJ
	 Ikn37AMKITNdQ==
Message-ID: <sashiko-outbox-174952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/21] perf test attr: Fix record dwarf sample_type
 expectation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-2-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:23:47 +0000
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D1

