Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973879;
	b=hM9xM+YspM3CKrquod11zIGKx46utbvajBrkM++xz0Mkuf0lGSwhk+9Z8tAM+QmyUoeG
	 Tt+v+0lCp0uh+PtU/t2sv76CpsLw77KTL60LE12l2JC3JNvGyxuTjL3rehdEcrUgNCIuS
	 xMg9UYct9BjuAmJaueAEprV5ncjw3RIQIY7G9BOXGEEEAV6/9So29u40sa8MJ/29hLz5X
	 E+txBo3+VszjckFm5lzXI+lKBNhJ7a9uKOjmIIZsajTa/g3vksGtKQJC9qXctqB/R4Jbk
	 Ixv7zgVvUiwslJJQvAJKen1i9o1wxXZRMjsd7zeruDXwp4weNWP7AjCuO7P/W7NLKiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973879;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nRYdaQj4qN279DbJkpyUCYuzwatcXv5uV1iCo0kQzrw=;
	b=vxvQrayHHAlHgwPiYlJGtC0k+0gco/SrYSYXDLedwwW9btHu3JAs5azNrga58eWNudhL
	 NkejTfwoxngKky6bNk34upWddq8jk4wznCeOs8gBAWVaVPFL0V0z1xPaKCRdRtqIKriG0
	 IRnlQQoBsp0s3GWvNvZsKccq6KlyPXIiZVQssA5i+Yq+Rl5XERjdYoEvvEVGkh7XAjaga
	 H/4y747zwFt2u7ybM0lpWaB/PL83naCAA/exOw23qV5wpxaQetdWYaaNq1Db+T0B7b3zt
	 Ycxw/YuHmWa7ZBDsDMuZPfHExChmrUrftUkf9Gkg/0yqRFwOOtiSeLjKmbMHKVNs/hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgM1zAUe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583B606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgM1zAUe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7971F000C4;
	Wed, 18 Nov 2026 03:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973879;
	bh=nRYdaQj4qN279DbJkpyUCYuzwatcXv5uV1iCo0kQzrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LgM1zAUeDoXm25VpfpcEJlWclCtRWspPkNsBjy9RpbmJ/0ehRqTDNT5J7nSJN8xXe
	 ZcvS1Tqpvdh4Z447/CypbxzAGvNCZd7MvNT7ctNDHwD2kVjmvvaFS/BCJxuXxMJgwP
	 DNGFqS3dsCiOoK9+iXvjJG4oE9SpnVZhpzMRY1SYALZusMkhmYQ8s66i0H+mZxBX5d
	 sxncvqm7C3+ru9mkCYoRQLi7VA1it4Q1F1LSHD14FSApA0ftxh7TBcw4e9bqGyoDap
	 SobeVzok+NC3fqqI1mwVxGO+JWhHEiUoaV6Cjo2jmWkFQScKGT8KAhFQwATLA2vzb0
	 Le66LIyWDlAAQ==
Message-ID: <sashiko-outbox-220053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 23/24] perf/core: Don't mutate shared branch stack
 depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-24-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-24-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:51:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_sample_save_brstack() clamps the branch stack depth by directly
> overwriting brs->nr with min(event->attr.sample_max_stack, brs->nr).
> This is unsafe because the branch stack buffer is shared by all branch
> events in the same PMI: once one event with a small sample_max_stack
> truncates brs->nr, every subsequent event processed in that PMI sees
> the shrunken depth and silently loses branch records it asked for.
>=20
> Add perf_event_brstack_depth(), which computes the per-event depth
> without modifying the shared branch stack. Use it in the relevant callers
> so each event is limited only by its own sample_max_stack, without
> clobbering the shared LBR state.
>=20
> bpf_read_branch_records() also relied on the clamped brs->nr, so switch
> it to perf_event_brstack_depth() to preserve the same per-event limit for
> records returned to BPF programs.
>=20
> Fixes: c53e14f1ea4a ("perf: Extend per event callchain limit to branch st=
ack")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D23

