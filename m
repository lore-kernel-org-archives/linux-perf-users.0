Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB531B6527
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644932; cv=none; b=eg7LILbRLAteV3pSOef/ljcZ4BcHiL/dMwYxMDVJHYI8scU1PwHNzf6TlwPTd0zuPBqpBzDgPI0TDimbh17Jf2uQfAHf6C+XDdUsi79H++rrpVYZl0E8nIjIbrigHZcIq5D45y7zVsV4E2YqaGvJ8z9lebFklRvSUZWa8pkmSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644932; c=relaxed/simple;
	bh=KBiTM/DfQR46Xd8iEINKcP/OnruuMCaijsUaYdzMBps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=idBxLrNBZ0V1A3F+2vWwT0mtHdfqFStcbrCN08mmh1eseCSlVKIANuPE5mUDk158sk+RhJ6FEtS4sJuezG9EeiwWQvasY2s5Scm2DI8df2P7ziUn11D6s9/g8DuPhCiKXie+uc/7lNE6UUZko5mUjjBPesX4gneq5AEV1d1hinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTeeIf5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTeeIf5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B40AC2BCAF;
	Mon, 20 Apr 2026 00:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644931;
	bh=KBiTM/DfQR46Xd8iEINKcP/OnruuMCaijsUaYdzMBps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mTeeIf5JDKhwD2MKcN4yqXIu0CZM/osi3g3VJgsHniGD1516aBl14ZbYikaKB4bL7
	 Z+yI0ElDjAtJkPUEoNrB88T0eJXdA6dxPb8Jyf8aLp9m7PQubEhTGrRWm2LGZ0C/Cp
	 6v43jQ5uLWOSCi9hp5zV4AM+Nx6QnbOmi/UXD8wjWrEA/HKfbsvtupxRSZhUIjU4e0
	 TKZ+B1+3r3BEhGTvXm/8HINSelhHpY6EINCIjrhribgFkURhfPaZ9F11kmKrhdUi9C
	 cF9IgRhgV+9diFXt5HpZd5Ew8XWqTckFhb7pCnFIcAvw+nAk2yrfcWZrm8m6B+K43b
	 esUmBhidHn8KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 41/58] perf netdev-times: Port netdev-times to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-42-irogers@google.com>
References: <20260419235911.2186050-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:28:51 +0000
Message-Id: <20260420002851.9B40AC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Tracepoint field mismatch causes all packets to report 0 length =
and '[unknown]' device, breaking script functionality.
--

commit 650861cea8b019ec7d7a76a67b9c4572675db6f4
Author: Ian Rogers <irogers@google.com>

perf netdev-times: Port netdev-times to use python module

This commit ports the netdev-times script to use the perf Python module,
encapsulating the state in a class and processing events in time order.

> diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev=
-times.py
> new file mode 100755
> index 0000000000000..c7110a0064059
> --- /dev/null
> +++ b/tools/perf/python/netdev-times.py

[ ... ]

> +    def collect_event(self, sample: perf.sample_event) -> None:

[ ... ]

> +        elif name in ("evsel(net:netif_receive_skb)", "evsel(net:netif_r=
x)",
> +                      "evsel(net:net_dev_queue)"):
> +            event_data['skbaddr'] =3D getattr(sample, "skbaddr", 0)
> +            event_data['skblen'] =3D getattr(sample, "skblen", 0)
> +            event_data['dev_name'] =3D getattr(sample, "dev_name", "[unk=
nown]")

Are the field names skblen and dev_name correct for these tracepoints?

The core networking tracepoints (netif_receive_skb, netif_rx, net_dev_queue)
typically expose these fields as len and name.

If getattr falls back to the default values, does this cause all packets to
report 0 length and '[unknown]' device, breaking the device filtering logic
used later in the script?

> +        elif name =3D=3D "evsel(net:net_dev_xmit)":
> +            event_data['skbaddr'] =3D getattr(sample, "skbaddr", 0)
> +            event_data['skblen'] =3D getattr(sample, "skblen", 0)
> +            event_data['rc'] =3D getattr(sample, "rc", 0)
> +            event_data['dev_name'] =3D getattr(sample, "dev_name", "[unk=
nown]")

Could this block be facing the same tracepoint field mismatch with skblen a=
nd
dev_name?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D41
