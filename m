Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65833B71B7;
	Sun, 30 Aug 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101085; cv=none; b=nXg1O5BtvzS8pig8UI96QUiWBo+YOQNqGKA/fTcoJasRxQPncJyKgy2qvhz9Vwk0zfbTBBzzzR07ORvF70yqe4xCEYTIeMdVBGdaSaUyMiMhkhaQMi+SqxRRZxcP8J3dIS/5YxkbyjfNFADlrEt+MxGInSXHlOTiFvXzA3gs02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101085; c=relaxed/simple;
	bh=g4+lris8TK2SgXSA8Dj1UybH4Dcjux+FtIxmJqbkNrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S2m6CaYTvnTz79LrnjKFXzq0qi+xZ4VAyVpzR2eoJeAn+j949QRnJXXR99avDPIwEb2865ugECY7HjcEaFCRDZDhkFihCaBbN6SpUOIRUVfGAlqaTXAO2Sk4+9ZDNyfXMxIjlXzzkVHPuNQ8Mr6an0RYM1AQdrICZmvbLREHZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5SLXJlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5SLXJlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7AF1F00A3D;
	Sun, 30 Aug 2026 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788101084;
	bh=g4+lris8TK2SgXSA8Dj1UybH4Dcjux+FtIxmJqbkNrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5SLXJlFHmesdle/RnRbQv56FRqnY+wSZ2TS7vqLTrw51fQdq0HEKHbBv4htS5MHA
	 qz2KplrnWP+A1x5wFGD2IjOKv/V0xBMteN+e0y8zwJNZrE5bvGzk4ozoTp3AbHOoFG
	 hvU7AhhFcvwRCti2PqOvEM/Or8kKnSQl0NuUMo5ewhWIMUfmCTmqDoc5WKPmNyhmJ0
	 0zoL8VTsAOMwe5YMUx3M4G5VF/1Kl2K09akH9GS1AyDINlgOO5R0Y98B4Lo7NfrOR9
	 T0eQPxILht8/Qxclq+qKFXzbUh/HBFQEDsiGX4TMZ/liLQ3dNMg3S9vjXR0oXz4GLN
	 lDT9FYucj1vog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/14] selftests: ftrace: Add wprobe trigger
 testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178810014324.64882.15498047688008538981.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810014324.64882.15498047688008538981.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:44:43 +0000
Message-Id: <20260830144444.2F7AF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add a testcase for checking wprobe trigger. This sets set_wprobe and
> clear_wprobe triggers on fprobe event and static trace event to
> monitor memory accesses within the trace-events-sample kernel module.
> Also add a testcase for verifying wprobe trigger syntax error logging.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D12

