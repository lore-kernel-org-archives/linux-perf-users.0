Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940771;
	b=r3OeM+N/7Ihy8hkJ+x7xRU2EcthWtvvYySEASRMrleXKZ2kx9tngXWprLULplJkhU/PF
	 xlJk7fp2W0PZMNxqX4zEFzz45QXM6KuXgL6LSl9X4wB+bpwmnEz8+dwDu9hW7TiZIWAgb
	 QUsoIEpTTontLKppoyDit5nGx0K/IpOpG+9bUZq/+h4wWLyGCNZQ4YtPfuUfguypAqLnd
	 G7Af+esDgVDkM4e28fpdY6D66jGqVtt2ISjgm2ggIldTFy8pnT2rPHhStA3hzpWj76r0r
	 iYfJKUhnvtjhh+Mv92yTHo0mcerPu1xADpoMwqFyrJd61141ecT3reW/9y1Ed9SFtbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RRI9ead8QZVuWOKfwuuGgaPREek3ZQ+UMvPBqE1vGFY=;
	b=WPPMOjeRpHbfCnrQB9BVRLayn6KebvhGgDcaDBOXb3vV8N3EFORFwcwM1AXI0VY/PGmJ
	 5IZJPwDJzm7BJBSUvMYmfgtmr6aZWBXwRu7yr0O1Ia2No8DA340YZE89tuoZVcbqdOASg
	 7L67XZgJ7FBwARNRRKbLu0DKxj2y925f9MeOdIXRrCp2Q1+QwlGmsAI+zuss3oko15At9
	 ldV11K14HpCjd0a1V4QpUM5LzYTAnMQKJhjKptXsWNJEXlfvhnDNjknDwR6cZRu+jDkfh
	 8WN0n8KuJFGY2S4uWrQ1NnQJhoPp0OQreDw98rfbKaPPC7+PC5ARj030Udqdghyffww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cr50Nexl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FC606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cr50Nexl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFE11F0089F;
	Fri,  6 Nov 2026 04:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940770;
	bh=RRI9ead8QZVuWOKfwuuGgaPREek3ZQ+UMvPBqE1vGFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cr50Nexlo/YMk8TrguDi9nOZN85WcgcQG/0wsUcYtPKr5Q0xnCoOYILPWxjqijE5Z
	 gU5wQj3mtjCPkA4ftzZ3xEtH664FqlsnOzXjfjZ2B2oq/0ASpculNFw+JF0DoKKMJG
	 hlWubuF52Q+j5EmsF1vcBytS9BhNBLhWJfV/jMR3VloKezC2r6UEfuxhYIOUlDDbV5
	 8w8IoO2V2lIrLX3SBa/NuMWPRzjWiKCyG6iyBpfzluLKnnF/6gqhzwoLJHLFGcFyc6
	 0Fr2sJGZVjnqCcYFy0sRvsU3CD2sbqrTKRfBCvxs0AbHRM3CSlwl/TXoojZNvMA6Pj
	 Q8g/mDu+spOqQ==
Message-ID: <sashiko-outbox-200775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 04/20] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-5-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:52:50 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D4

