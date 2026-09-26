Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A438F941
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449809; cv=none; b=j2VTPQZQARkYseILGAEpUhp2tStZ4H9ILYz3E5a4cF+4DqovChoeEtP1NOSRORqOl8o8T8fkSWppgwQENdAQH4TxSW5hZoHjpVw0AJIr7kJu9EWsSZfblNwiYaaaXrpkHSr99zMbR94Ie7kY13UrmJ3jSG681wVnfPqXBdKVlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449809; c=relaxed/simple;
	bh=zQoIqGhlE2EAmfZKruOrzediUwkv4dhFpF0gUcXWZVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NEHKoiEDMaQVJgI+C2tefodgdk1Pel+vYcNzMC4XK6uOjHKCkCqLhvPuBbpCr7lu3Ssk6ApQ0fDhZBakNOysiwkhOQgT6fH1wMTW9RX+CGoQSG5gtRDstC0GWViRfTEfIM8AejKT4s1r8hv2goN1b60G0dBAB5wJq4Znui8ZrlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH+i7zbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH+i7zbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5821F000FF;
	Sat, 26 Sep 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790449807;
	bh=zQoIqGhlE2EAmfZKruOrzediUwkv4dhFpF0gUcXWZVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KH+i7zbnzwT3TiTwsOwEKvdCLPjDWN/sU4GpLsu9CWQJsoREM3+9yxSxXH+rg2oif
	 SRHl9d+BiD+NkFvKCSVbJNndMQCkuoILYJ+f7o8NiX5wzFcAlFG2Pd2UVDtYdpsGVg
	 tq7wDJxhgzhCE1E1bh5aOHSlZ5UeLGhxmFuztGWzapDjzIpwdBJ6ccNykm60OykhAk
	 aiy9OLGEb23CuAt2/NS9p7/TbcswP22Tk3KbFD8Fg9yZo4hUuINSSS5ZGvKyGfqkDe
	 q8ZqakNJJ+2AjOMehJSjiU87kwsGFxQ7ZhPe1T2GGoo1xcJRkp7RkffP0qoXgQST8B
	 xoi3Rz6lgyNZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf bench futex: Use a 64-bit operation counter in
 hash and lock-pi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-7-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-7-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:10:07 +0000
Message-Id: <20260926191007.AA5821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The per-thread operation counters in 'futex hash' and 'futex lock-pi'
> are unsigned longs, which could overflow on 32-bit systems. Use u64
> instead.
>=20
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D6

