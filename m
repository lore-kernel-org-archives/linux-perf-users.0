Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AE2DF6E9
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899090; cv=none; b=NrbtdpBdBanWqsFsGuNTZ/X5NekjUSRdjb2AhinnAiXREykaPNUeA/hPWzZmKfSNoBgoyGZAjm/Bh0480hVptsZvdOT4NgeR7x0r6+HcMffIaC0pjJ7nu8yI4fpZGl6gSNPgtaGBJYcFrMIXoiTqjMDqT7e6sHgA4rWpx8XSu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899090; c=relaxed/simple;
	bh=ssALhbbIYtsT1Mhq5EfBeENs0DlFzHL9LEunzyTH6qY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Kr6wvH4wGg3ybsyTKIyO+cJxPFbDgv5ICVyXqTkxHSoK6x9qW6cY3/sxe6yvblVLhhBnP6A8TzyQ+gyDXnSC5PPkRGjSD8rNSZStn4nfOw540gjG5gXo3MI51ua1ed15+an1JPwIncZQmxTsbcv8tLqxkWDizia1/VDhKoipCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4pqNhRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4pqNhRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73DD1F000FF;
	Tue, 13 Oct 2026 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899088;
	bh=nN4Ll083WRQzV34PcmaAV4e+SlT2g42uYjQjoUvgj6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H4pqNhRm5m6kfAOoFASMqKxY64i/Wdb4R2WAEaPvQxC1ZKW+AOnJDzlsQourbHuhs
	 9wdwhMd9svhh0DifILjtiNgmRjq4FeEZXmP4IdFTbg0w4N29F7HOrun/7aoLvS2/p7
	 s6POIyBns19bzxigs2rZ6Af7DuqLtKPjnQS1MwBDrmSOlEIFrP9zcpiDXPek479xYx
	 E53RHX9WeqP+k0RFsFG4AJv2Silxb5dsUtcpI6WnGBXyDFFdLSaGXueQTq/I+89X6C
	 /hq5kOAhZgRMVvN149PjdnHqKq2f3bD0T/JzIfWcDsIYU/BGTxZxWHMFN+6MbGDfO5
	 CMcXoIgCWQJpQ==
Message-ID: <sashiko-outbox-169853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/15] perf annotate-x86: Delete stale stack state on
 store of untracked register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <000d2327536620d3f8356a0fc21d2f2fc928d25e.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <000d2327536620d3f8356a0fc21d2f2fc928d25e.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:44:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a register without a tracked type is stored to a stack slot that
> previously held a valid type, the code currently performs an early return.
> This leaves the old type information intact in the stack state.
>=20
> As a result, a stale type bug occurs:
> 1. A tracked register is stored into a stack slot.
> 2. The register becomes untracked/invalid (e.g., across a function call).
> 3. The now-untracked register is stored into the same stack slot.
> 4. Subsequent loads from that slot erroneously pick up the old stale type
>    because the stack entry was never invalidated.
>=20
> Fix this by introducing delete_stack_state() to search and free a stack
> entry for a given offset. When storing an untracked or invalid source
> register into a stack location, call delete_stack_state() to delete the
> stale entry before returning.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D9

