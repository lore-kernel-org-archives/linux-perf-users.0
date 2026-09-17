Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9684DEC0F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661293; cv=none; b=NjUISeHhmcm543qAvo1EB1HQ9NZsNimtBqOBkFdBsj85aHl6DEv7LS4DRPV/mXa0MX4I8vTB9wUE0AvTiT079Snul1TWHAnLV5aZZ7XInugMfzPLzDFoh/9qIoN+uwwscb4H14NldTSa8ihE7H+HgrIDZE7wnvojRElXmN7WmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661293; c=relaxed/simple;
	bh=7CMuWvlgyQArtwYpxIBvO/Ifo3rbNxOxNaQCEX+N0sY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TJjFsfaCcTiThy6YSQGO5Td8MsBmXCr3K0trntYKQdfJmzu44sgS7qej/WJjvgOocaXczbKE97iDTiHbFqBMBOkq+AKhPEWS6izo4q8bnyD/Vpe8I+EWU3G1zt0YbFBUuYsdX9uf/PMLD2vh8YjpiGkw+t2umUepdogm0HXFAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnFNq0je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnFNq0je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A81F00898;
	Thu, 17 Sep 2026 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661291;
	bh=7CMuWvlgyQArtwYpxIBvO/Ifo3rbNxOxNaQCEX+N0sY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnFNq0jecBS+sjA0lcn9uGLgKa2IaEUes9c5lxSxlvHzC0dv3CftLpUvnU49QyQyt
	 peCm/cT3cECw5aqgBsZh3j6Fsbcq1iT+7C0KS9bY53sji6ETGY6vRd2jUQ+yqCXhlE
	 7Ht7pqMqjnjauL1V7XY2V2m0zyb2lGKw/NiVDJqGXkwwezbVQhd6ssmCYDQu8XRKxk
	 uCtvCHOko3/h31eAM7vUartVhRMwu4+G1IGPenLdAVEToAtv4fyMr/m5fJMNNXt7Ab
	 J4693j5/F4JQ71CKVKZ3lBLM+ToxKmVlA6cH0iy525LYdsor+l5jgYMMXAsnwoknq8
	 Js65zk0UNJo/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] perf annotate-data: Bound the member nesting
 recursion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-14-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:08:10 +0000
Message-Id: <20260917160811.3B7A81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Members are added recursively, and the same kind of broken DIE can make
> a member's type point back at one of its own ancestors, recursing until
> the stack is gone; nothing usable comes out of nesting members 8 deep
> anyway, so stop there, marking the member as truncated (reported by the
> JSON exporter added in a later series) and giving up on member types
> that don't resolve.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D13

