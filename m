Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FE3F44C1;
	Tue, 22 Sep 2026 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051646; cv=none; b=eTpFU0Bcb8np7EKtZBLGhPdAJi/ukNkMNa6bOdC3LhGGcu+owBvRWAaX2BA34XcmZB5grHpn4ylbhoRqcvfxUGV40Bg6FTmLbMAlPxZOfGDjFGn/d3S7S80+E4W/3Hsm5NCV66YQA50fdzP2LmCIDambjUxeJaXWJ41+J4HmG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051646; c=relaxed/simple;
	bh=fceAGwjj2NalTS/NjHyaVb/yWWQtZsCCbGkNMxrjk54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a4AlMwxlCuaw22ZksY/4E451Qaxd26Ue2QerxdwiB117BszCcwjGK8y0ygUqYiy2CNtFXPy5F5GX1dgIJtXK8zD+h8W2MxB/WFRdpxI95qF0FFLcB9KRNIjYNPf0evtFhwxfZkc9KrJ+frzDWnh/gq71jkLaq25rZY0BMH1lPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3CZjY5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3CZjY5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB601F00893;
	Tue, 22 Sep 2026 04:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051643;
	bh=fceAGwjj2NalTS/NjHyaVb/yWWQtZsCCbGkNMxrjk54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3CZjY5utXf/k8SnPO13wFlxlvT7t4yFiwszBMnBfGvcqhzZoUMOQr34/83xKvUxq
	 jGlJAQFuJgtISM4F2bJ0OgDFAHDhRIvlCtTO542AWOID9RPRRe87FRZlyXvMBGoHd+
	 whKgHSquvfsPYXEoNrQ/HBLFp6rTiLodrDpspkHDOQF4dqxWi4LS90Rk1NjlMhCH7J
	 +LABqIkMSFXuFJwMxu59FYuRDuqaJAgTv8c6c2nvx6EN8ZBYV4z48CfMHZoi0GWY4P
	 Tqcw4FknfUUQBmTms+88LFOiGBuS7+X2BHnEP39s+LfQKIDBgpy0SDegeS5HUgyyaB
	 pvH5A7OywjbvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 09/13] selftests: tracing: Add syntax testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179005119078.388919.13826248487433752738.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005119078.388919.13826248487433752738.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:34:02 +0000
Message-Id: <20260922043403.4DB601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
> of the watch probe events.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D9

