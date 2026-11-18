Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972851;
	b=hEokf0s3WyfSGzy29xMuagqmVjw2MmNYw1HbaF97FdNOPtm06tZ+eQga/rO94RsqXcf5
	 qEQ9Oq2BtIauWUmIf1FP7me1WVA9a4EzE90rvBVNBpTYGTSPjehy6wOQENpj+RlRBjGqi
	 yyUnyG3ummWn049vm+4cfF7OeSVYp1kqO4sIj2yaRuxJ7jBHvvG+4hNeodoE3CgJJp2Hn
	 us9TYSVSXYTF5hDX+DzOm4hNrBfGLwDMfZIY7wW8RR/A5nAdA/ysf/8zCwKGuasMvqAJ4
	 vKgP/WmCAZfQpv2SdEVu4vautdWejy5+vzu7ogyNZpPJUAlnD9aNwZDqBBbYS8EYd7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tsyH5dYob721DJAy9kDXpu9o9KGesGFiOLVWRD5D38w=;
	b=IvIiAfsLuET3HXU4UL5QWYNseoshqZE/SPVzSYAN/gUchnTHOtpkK0KhAPGUYdc/VaCW
	 SrvtsdX70uDSePGjhjGnx++ia86FnL3sJlvcoFlPCN6cfi8AcbVQo9SJPTQb1dcGKXaN9
	 Hbo7bKO1dzWbceMEQTkrYLfKPnUmP5C6r4kKfw2UGoIH/aHbPzGrv9OjE8vcOcVoBK6AV
	 gy88sBo7GH658rxBLClUldF8J/173bWUkEXGScZbFuMPtg3yMo6ZRZYqheQEhEHPrRwUy
	 C9WdgHxxowe/0gPNJHSGMT0fMaxS07TWzFRPO3qOY1hBZxnHavNHDojusuniOHBt/4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TF5DJm44;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC50606A331
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TF5DJm44
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2CF1F000C4;
	Wed, 18 Nov 2026 03:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794972850;
	bh=tsyH5dYob721DJAy9kDXpu9o9KGesGFiOLVWRD5D38w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TF5DJm447YACbXzU/xgSEc1YG1+NqeKj5tNnkErEwQ9li2HTJ9eAmCYLf7MPbyz+0
	 BsdQZRoh1uo1B2M7uqVBBMov2gIJf6pE87ScSHyhDwna4RVsyKBV+9Qrw/GLyPMGPD
	 LrBECauMsqfWNuIY/ftmfuGY/7RFewwghk4EJY6AzYgewt+bwbopA7LjerzhFcIQah
	 EXz0JCmYUzhfpMj2aOYxL4LtBOH6fG8QX6j5bwTtl+w5pQV5wHIgcZjqAvYQ585p2+
	 fAga+xq8OAZ+TkA2+cqpH7tpyH8eSrIzbJNnlRJAkoWJVOzYkkmNnTPm4Lnz1m5uES
	 M9ck6hALeaq0g==
Message-ID: <sashiko-outbox-220018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 03/24] perf/x86/amd/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-4-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:34:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Sandipan Das <sandipan.das@amd.com>
>=20
> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>=20
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D3

