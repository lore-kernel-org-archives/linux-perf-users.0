Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB754CF70
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873660; cv=none; b=AtkBa6xxHnEmkeWxZRyYydS7K2bph/hFHi+GMGn9+zDflFjr9RLDe8kXmlFbF6myMY4FjFh906hmPkWqGJxk2QtNqhXi+GxGxi2+tns4noHPZg4U7c/qmEY6a7HTpjSnHr2OFOxWzL9tBm8TcBtna4TM8Vk+Mpyuyge7Hu+yfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873660; c=relaxed/simple;
	bh=wmBjBJggJ5YBeVUlNlRvz5LCywNzI1H6UFBGJsbFluU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZRiBZk8gEtcc823jm9fcHadIgZWtnXwAf+FD0GTP1mLdNbI8zKsrRI8jtm9aaP6kXNJuA4kB2NxcFDPZPgMxXTpumHKMUtuAoNtWyf56QH47oy/TeLs03lUGU1KQ6oSrm6SaEewunkRj3aE8W8ihxqmseQadAp+LBbDkVF3XTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6D71F00A3A;
	Tue,  8 Sep 2026 13:20:57 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/26] perf annotate-x86: Delete stale stack state on
 store of untracked register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d8120878619b98f3956f8a63676dfbe2cee7a59f.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <d8120878619b98f3956f8a63676dfbe2cee7a59f.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:20:56 +0000
Message-Id: <20260908132057.DC6D71F00A3A@smtp.kernel.org>
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
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D20

