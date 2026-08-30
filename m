Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02801CDFCA;
	Sun, 30 Aug 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100488; cv=none; b=hfqnlt3POyVpM0ZJzisWEQbI4GpILSof4cdFnINCr62BL4GNdDMZDikCOwtwg+q7vEJdowO1/GwbCUqXGUNmolJGc6s4/C6ekxaHWjiuz1sF+80aqy5diafITFs/IwtyHOQznk++dVtMwAhhUQZ74FC1+zsgfeL8AzuV03r7z6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100488; c=relaxed/simple;
	bh=3iV5MnaYNCQCuCaKA8U6mLpN2RoZf4ZH34eQVczpiyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nso+7qPnu06k3+1jSDttO+vNmb5M+VWCULj62TugCxsyb9lN0NyTdkuMOkGYlo6W8Uhk62HV2lkVo6jS79xQ6nXJ4G2tggSBPgZWxG8pheHoo+XXjnyWVdd0zSdByHneUjVXLPqW5Ekh9CN+k4KaAMPRLPoY7C/yde5HUwAg5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSroH/L2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSroH/L2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533A41F000E9;
	Sun, 30 Aug 2026 14:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100487;
	bh=3iV5MnaYNCQCuCaKA8U6mLpN2RoZf4ZH34eQVczpiyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DSroH/L2zpH2e49QQQjK2N1U+ihqgpF52a9Dv/0GMxgsAL9MU791wRFjx1hjZZosx
	 JR1XF3H6UnzmvgKLR4iFLaI3bnLFFJQwZqqGSaI5XqlVaKImBo+6yD5L7/42WLqtS7
	 UU/xPte7buyvkAmtCYSpnGCvAldsGb/K0ZSq3IMKWCyG9GfxlQSxG+7zQa4PtfljAi
	 QUsIREKKUBYW0yiEMd+4xX4kOIoVYHHjIX5mZ0a9YvGIGQEaSXwYVM7s+/CkECGrW8
	 8U91pNt7fICeP/OlCNtIcoUS/1N+7dsQN26VVZIYhklPbnBZUht9Qn65RAeXxT4GdP
	 emh/zJ5PJOYVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 09/14] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178810011000.64882.18336960198177093627.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810011000.64882.18336960198177093627.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:34:46 +0000
Message-Id: <20260830143447.533A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> tests adding and removing operations of the wprobe event.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D9

