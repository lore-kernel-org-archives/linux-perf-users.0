Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08A2C026C
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203946; cv=none; b=dcqh12UQn75nqv8JbvJ6rXTyqg87o1ksRVQakVFIaqEsw9YpyEkLwI8jUZ2eV6BwMVkRtUy682R3oli4Hbdrm+LHsv2TeNiG9eCi4uYXJUkd4mq+ari8MO4iqufWzgDyxG+ZfL8hDfUgAcwlj4A22cSD0fvuTFWV+0uzhscIq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203946; c=relaxed/simple;
	bh=IUKLfJbEUqXxRG0MVB+WReNs5+cMyigear4yi5XKmgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WVJiOe/ghMgpJH8aL6UC46KPuBzhMquuiA0kQiDfu2mVbOTSyBE6FLk8pMseecfrP+bSAuzteSSRJ5rWL+rrm3W4cghBwHdlfW6hmzoGuhMT7JOqV1o/riVe7gojYxbLaHI9m0pncJw1Pl/9WJ6/IEO8d/vNpVoQy17C884I3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYVYe80w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYVYe80w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C561F000E9;
	Mon, 31 Aug 2026 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203944;
	bh=IUKLfJbEUqXxRG0MVB+WReNs5+cMyigear4yi5XKmgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYVYe80wnYFAX8xISIHpHtQDZzqpUcO9vQ34ZH69YvyXW8gzv5t3UDqezOHNENHhn
	 PShv3gA5q5Kb9ys1CtpWSrM/Fjo2KTOUDoS0hZzCfg1l+gCtrtow39uHtFzpiXLs3v
	 yl9eblQoHLvVHM4uSBo5x4Xl/Z75TEsH7S8Oe3vmjR1ApAXnryZwQc0eXB0gcBHZsB
	 LA7rTZFPaTd6Fm5m3AvmSdfWR3ae2pXc5qPtxmC4VG1x7EyIraVcNWTLe7LOmQyVaD
	 ZSM7UTnkCwJ6siYZVpZ/oxrh9Sc0XHJy0FU4n+OCKA9hJHuiiDzUI06edPLgsjtmjR
	 WVIS0C8HYe/wg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 06/19] ptwrite uprobes: Add a sample module to exercise
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-7-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-7-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:19:03 +0000
Message-Id: <20260831191904.30C561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Hardcoded local developer path in Makefile comment.
--

commit 6f339cbb02cf7327f16d076027733bac7f4b2900
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add a sample module to exercise interface

This commit adds a basic test module and a test program for uprobes ptwrite.
It provides an interface to configure and register a ptwrite uprobe in an
executable for testing purposes.

> diff --git a/samples/uprobe-ptwrite/Makefile b/samples/uprobe-ptwrite/Mak=
efile
> new file mode 100644
> index 0000000000000..086d84be6ad2e
> --- /dev/null
> +++ b/samples/uprobe-ptwrite/Makefile
> @@ -0,0 +1,13 @@
[ ... ]
> +#
> +# The userspace test target (test_prog) is built by the out-of-tree test
> +# harness (see /home/oc/uprobe-ptwrite-test); the harness computes the f=
ile

[Severity: Low]
This isn't a bug, but is this local path (/home/oc/uprobe-ptwrite-test)
intended to be included in the upstream kernel source? It appears to be a
local developer directory rather than a path that would be accessible to
other developers.

> +# offset of target()'s 5-byte NOP and passes it to the module's offset
> +# parameter.
> +
> +obj-$(CONFIG_SAMPLE_UPROBE_PTWRITE) +=3D uprobe_ptwrite_test.o

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D6
