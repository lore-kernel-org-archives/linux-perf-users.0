Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583525;
	b=FqwXA4IDRFsR519lKmhtN6BYo3RB0wypEvRuuJX0yGL1TNB4DORW4xcHdeoiAs69ZZIJ
	 ttNfeA9OSm6VRqgI66cWQYj4QmuQrB7KfrLBDUFOBENutsd/gTCeQFAFqjPIcItCCLrXV
	 JFcUz7vd94qVgIi/8xncvRxYW7n7Fg8KCmf61RL3zyHiV4Ce+zwgRYzgIJS9AbaRnrxtI
	 s7Tj4K7nFUub/1D1I7lErhUBLzAG30/a9ou8h9rDFjAUi/U0u4WeIhxTy66P+Rjg7b5Rl
	 VgeS7/fkWbKHJtCCphK+5cChthcSkSzT4ZqgWf6OsQuOv5EExQM4uuILl8rJspBPZvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583525;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wGJQgONfVfGLqqyMqngsn+i3UCBsZZX+7hf96apUU48=;
	b=DcHfxK6Gvhj6nydkpLKSMdAuRYmh7c2g4i/qXxvDDlXMi3WvN0KzXvZUFALQR7c5ntyZ
	 Gw64qj9Ym/b9PgKsIntw26XjkOyTYsylwsLtKcVr8oMDYUB1LXHzzd7VfSwW12mOHXR5p
	 AlFNC6e/pQK34jGZHbptNtpD3tYMSsPD6HMg0i6U9kHxZLi7nWHfBTS05VI4zjmjRY27Z
	 xHw/laaVMDLG0SGAZlQqLAbKC8aBI/lDIYZEx0kRkqf02mT5vrDwnmbytJlXNXq0WmVC7
	 88s07EqtOPzsw4GU2fjBq+/M0G+x1tVjo8aQJYwkm0/IQVGUf/lcDZ5rTj3ltZ3cSNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2z1UxNI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65610606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2z1UxNI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCA11F000C4;
	Fri, 13 Nov 2026 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583525;
	bh=wGJQgONfVfGLqqyMqngsn+i3UCBsZZX+7hf96apUU48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W2z1UxNIFUTFoLH7DAiZ7yGq1VtY27917bl4g7TQFlGlASCxAz7+k2vEUhGOlmxxq
	 bFXVatYx3XT8I7y6dX3qfn8Gj2i55lFe2b8cZ0alDdMpQW1FsVLuPWHLZS22BOrCFl
	 BZPhPcKbf+y6CDdgIps3mjMLcxFBPucP3QZazJrzKB+wwKJ3Jb9R/u6F7iYojlx5T/
	 AHYotpKtzKK1pUzccfRJtA1D35kMYu4JNHsBfaGm70jsgKRQ/lS5rYG3u99Whyr5+g
	 ujsYVHOIe11KVENqKZT8V/E0OslSuqaNIXGNu8QTVia7m+uxB+BgKvA/cizagKOoHH
	 8pm7q2ebi300g==
Message-ID: <sashiko-outbox-213085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/12] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-11-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:25:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf tests: missing Fixes: trailer for commit 915d6b14dc0c
--

commit 8d6a959ddd3628adc90143588c99d2bf9b1a9f23
Author: Arnaldo Carvalho de Melo <acme@kernel.org>

> perf tests: Fix the Intel PT virtual LBR check
>
> The record this check uses writes aux samples, and with the single data
> page the other tests ask for they are lost:
>
>   Warning: Processed 29 samples and lost 100.00%
>
> so no branches are decoded and the check fails with "Failed with virtual
> lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
> decodes 64 branches and still fits the mlock budget.
>
> Require the python perf module to provide session, not just to be
> importable: a perf whose python bindings are not found can pick up an
> unrelated module and fail with
>
>   Error processing events: module 'perf' has no attribute 'session'
>
> instead of skipping the subtest.
>
> Detected building perf on fedora:44 on the runner with Intel PT hardware,
> where the subtest failed with "Failed with virtual lbr" in the container,
> and with the python error when run as root on the same machine.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

[Severity: Low]
Both the python perf module check and the perf_record_no_bpf call in
test_virtual_lbr() were introduced by 915d6b14dc0c ("perf test: Migrate
Intel PT virtual LBR test to Python API").  Should this include:

  Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Pyt=
hon API")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D10
