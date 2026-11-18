Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973035;
	b=vRWKldJvmr7Yw1/weoAu7oGhPPp1Lrv8VS+nj9mYg/l4t497+ugPd/xwYxBj++ltyVER
	 EUdO5a8YFYOrCFho1sy+gluxShEA622eaUOs6zY5OY6E0YZKtPXfOtRJ/Vc5sfABpbXJw
	 xFBEDInYurstO3zc5U+dVDHA5uuAg31XqRQpKSM+3CsM3MhkpMpwYY1VasUpbjGxFNT6a
	 5WEV303ER7Z7XxD1Ytl8hNklDkoZ/OmZ7VoSGxcF7ertcDm4P+MhdPCtsbBj4pkJt51sd
	 Ex8qo5fKpDrtHNK5TeQdLC5tq0TIA+DICfzc6bXbMD+WZlOOSGOXHylA9tC1OmoG0fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IZJGB1HjiRMZEuF2RHGCAk2FF69CFw9zWlMsByCTgt4=;
	b=raZblNZ7stuNM5/5ZWZBQZ2uWq13frDWuFjuMQ6zF1ANzsUvHEqgBZplybA94zf1U7vB
	 N8z9VoJ8g11qBxhRuTe9/9y0ipBsGQLz4DC9KfcXHlJ9iaFxF3gFYJeZeIvmFq/Cfg9oW
	 zwqV2eJVlhFhfyOltgA03+Zcn4Gs4nVf0H+AnGHTjqQ++n29YU8k79ESx7v5nL8WYU46n
	 d265cgWQuZ14ayJ8yo+HM0ioWCIxjCmRzvx+PfMVsqOUaF7R7wfp8sjy1u7cb+f7M9hX7
	 8AJZvTNvc5aFroWHxBLZHGLSgcs8xPF41q0kOvTyRJsz0CO16iK/x2qQG6/84DJc71g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtpiMcrG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE8606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtpiMcrG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AE31F000C4;
	Wed, 18 Nov 2026 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973035;
	bh=IZJGB1HjiRMZEuF2RHGCAk2FF69CFw9zWlMsByCTgt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LtpiMcrGFQ3Lz/sV6dYWkzkecLyrxaQlIPjcoiDBPCMVzK3t4eULOk5/b60qIPw9T
	 Zlx5BpuwTEVxk0bAy/DrrkjgkIpUrDU2nxRlJQA/KGY64fuiOMEldRJny1CzddKspA
	 pTfpgt2pey4rNGffQkClVOAZOWNggUZxhIKD0aY7ryf9Ndvokbz12PwyjoCG847Hny
	 x4rN4kHS1H4HxJeA/wQjb1iLykKbjm1T7KYFaKHaWGB4ewBQ9Zqq6GAZfgEeTEmHMN
	 3k9ZMLTvZtGSQq433oh4SLI4WbUbOz3LpBqJZJBS1i5oklYzfy70mHyIw1qEQZ8uce
	 T5quwd2ITK+Ig==
Message-ID: <sashiko-outbox-220025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 04/24] perf/x86/intel: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-5-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:37:14 +0000
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
> Limit copying to lbr_stack.nr entries, and reset lbr_stack.nr when there
> are no active LBR events or the guest owns the LBR hardware, so that
> stale or guest LBR data can't leak.
>=20
> For the case where all LBR events are PEBS events, hardware LBR reads are
> currently skipped; that can leave stale LBR stack data from previous PEBS
> sampling in place and may be inconsistent with the intended semantics of
> bpf_get_branch_snapshot(). This will be addressed by making the BPF
> snapshot always read the live hardware LBR state.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D4

