Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953D214812;
	Thu, 17 Sep 2026 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687272; cv=none; b=uZ1ieOzZJ8mgDpXEna+xGuy+husw5fh8hgaf2iH+T8J7P0jA9WZ/Cde5fpSZ/2E6zVJ0ZWiEz/IOCrRPOAMjeJAsObtoDkmTodYgKjncYC9cnZ4NNNxlACZcgpU0n1xMywoo3teQfT2Yvqzhcapi7KGDLrssV9hdVokCnrg2CJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687272; c=relaxed/simple;
	bh=NTLQ/w8n0UMgqCyWbmsDIlkMSdHGvQvDjeE2lW+2XsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HuRSSN9hrdhoBEvrSfOwlfeJGYEWUJj+4RvosczTB25Fa6yXJ21SVGZPQVllPoRfc0JX6onvtVf0t7UaJodtT2YTkoFDUrTQ99rT1xz8y5FP5wZuJHsmlAnyTL9KO4YTlaB1w2624RR/neB71tdS/zTtkGvoO/cdQbrvfvH4hHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFvoqthM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFvoqthM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFE81F000FF;
	Thu, 17 Sep 2026 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687268;
	bh=NTLQ/w8n0UMgqCyWbmsDIlkMSdHGvQvDjeE2lW+2XsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JFvoqthMEW7ZuS+Be2lMCdbzuMQnuRx+atW3NAKiJ4ezgmUSG+6/EIOV2mtW0vCm4
	 7lQFmUv+AfidPj0icZZFHYmkhdNnriWZ9VRFmZk6gU+EmtqNLDD958uiCVaFYyFECS
	 tSmJW+kVvUph4h1noaki5IIVyQUqrroPJC3pBSK9kOgX1LO1nzqoV2CEcxDhn3Rxia
	 vJ6T+i/eMqgHcEXtDY4yY77qbB/wV8RAABhDlND3g9qipQ9hXHx8RXZItuSMt4JXxO
	 b6lXtA2y9nz4Szt/6MPVaPthoTEMpWU4WLqzek/AdTaMzYuqMnaDz/D2jL9QQyij43
	 9H01iTc0OhhpA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/11] ptwrite uprobes: Add a tutorial and
 overview documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260917230127.924985-11-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-11-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:21:07 +0000
Message-Id: <20260917232107.CAFE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Document the PTWRITE uprobe interface, syntax, requirements,
> limitations, and usage examples.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D10

