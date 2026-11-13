Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582992;
	b=OMTaVFRPd4HbXmljvON7EpZVRlpwBlTX+/Hwx72RFeTNLsnM3LLhfmW2Fp+A7p/EOydC
	 mGtx6ToZL0FOXW9D6VpISMFrO6o4L8qf6qpM2mmCus8bhB61x0TTTnKN0GqIJtdXD0cug
	 tVQNkkpajUSBdmp6rSVmOfL4Cg7uyTBWtR6+HGF0rZ6BJDYbF5KhFuacprs3TyCl1U2xG
	 ivdHbnLYFZiLM27w/OLaeoyttELSMv0iNbw+S8bzHRBGrFo2u1y/Q/iLupiBympXGvcl2
	 8yowaS5IMoyUcFOvt7831EiU4vxenVgJRm091H55ffPkekTQoyx0SrBNl+xO8PwWvTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Ud117V2mYqQTptz2IxRUtbU5CYmbvPZ53Xvl6qpuLk=;
	b=lWPZfTUzuFQIY3+0tbjzTfXJsepxGDzXY0f5Y4/v2U0AibXtmgvW0O5lL4epyQ3UcAzR
	 PT5Zd1f1OfBJIhzGQyE8tE3R4BGuHJlgXnUyu7tyHexw3p9Jw5eD08aHzOKPlkfKZw1Gd
	 r0MaB2t0PakwndDNrveoWaA0bb2yg4AAyWsA6XyS+r0pT37l02UQv59vsHeS24wm1/Nl2
	 spUMcbOF8D8MhmiPlm4GHhB8dRECOsWBsHJyIu4jjIEHn89jainlZdxLbogU1Vf7PVA4w
	 UwVW4ozqkmNtrSZJ0VhfWRctST6dGbYRypdGdYQguswhZBefrueoz4/VqykOO0mH7jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt71gqGx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B179606A8A7
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt71gqGx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69DC1F000C4;
	Fri, 13 Nov 2026 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582992;
	bh=6Ud117V2mYqQTptz2IxRUtbU5CYmbvPZ53Xvl6qpuLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lt71gqGxZQRiqsdIkP/CPEzcacNeqStCkxRU6sq0At6TY5pJArIWcfgdBNzGTXA9b
	 VJLjHnLgLscha+TrKp8GBanmYTOWgcuMZSEchzkGJu9OnFofzkft5rZhAb+CO6yLca
	 +CENM77vt+kXQKbx7E2Z3HpKnXpsqZ4+xHrxwSKEU3s9Put+iKEJQM03jBzB56/JX9
	 tIMNx+IUJ32j15a+AdHFHTcgbGFkZ5je/Y34Rce5loY59qyBmnWm3r1tBij50YGBLk
	 Ta9o/RDTrHq5EaoyRzdDtWq/yXlkeGiHaltqOlIylOII0ChobBtsjEKMf41V1QZ5w9
	 NcxKJWj15CYLA==
Message-ID: <sashiko-outbox-213071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/12] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-13-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:16:31 +0000
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
- [Low] perf test: incorrect Fixes trailer in commit message for
  test_lbr()
--

commit a78b0cf1c3a28b268aa40ae18726740e97e69c32
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

> perf test: Skip the LBR inline unwinding check when unsupported
>
> The check only looks for the PMU's caps/branches file before recording
> with --call-graph lbr.  AMD BRS advertises branches but only samples its
> own retired branches event, so the record with cycles is rejected and
> the test fails instead of skipping.
>
> Probe the record and skip when it fails, as the branch stack test does.
>
> Fixes: 54a23bff770961e0 ("perf test: Test addr2line unwinding works with =
inline functions")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

[Severity: Low]
54a23bff7709 ("perf test: Test addr2line unwinding works with inline
functions") only added the dwarf test; test_lbr() and its unguarded
"--call-graph lbr -e cycles:u" record were introduced later.  Should the
Fixes tag be:

  Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline informat=
ion shows on LBR leaves")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D12
