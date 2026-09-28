Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D146C841
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582559; cv=none; b=LZoxBQciGlBIRPsgY1aLCqVzPRv3kwhzI72vkJGsbJwH/1PVEWfBsuNbiwgnpLAZMuSu8UHtgtm81D7igVMQHggZTk427CeSaTzdIj8Kr3gbWlIljJJ9lesELDLmjhoTkZ3kjw3ZQ6/B/NVtsZ6GkPKLqSP6DycZm+dWcGzrkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582559; c=relaxed/simple;
	bh=DHkm0/UIcwsXz+/347yHvf6otRh0oP1X6kKXz/DpIwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K+oQPE09ee6EW4Eag8vShNfHBqgZZTa0QqAgm6S/KGYVjAlo1ao/WLt3kKPv988Z+Q10FckmQXtVXfREFB+djg4ujNgvXcoKKJwQrLDGRxscXwrxOCLHgdUTprsz0esYQxi7FZNuRkEtm2c75e3BD3sKpN2oKauUrKajoHtBDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEff/sQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEff/sQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6C51F000FF;
	Mon, 28 Sep 2026 08:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582554;
	bh=DHkm0/UIcwsXz+/347yHvf6otRh0oP1X6kKXz/DpIwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dEff/sQ7h9atZHKqawMRTIEOvcQV8ujHnWzR9dvX6fHY1gszKrX3t4uZbEV5+oHws
	 gr/CMI3CxuyhOEtxrN/TYlhT/9o4zHZ9tcY7oimKApDVhXSCWgnCC9CQuI0l1YjpnU
	 9VS6zU5BsNK47Fzayjl2dcfXphuYGYa0kFyJB9xlpPeBW1FHZmon62bXWTgRy8rwBK
	 87GJruSzhnwwa2f2hDbrgHSCFWeSi5xzH4UO4DAkJVMekXwgnLg8TyZAGEc8Ihqfht
	 Tose7rjX+JTpd32FzJObjRfQjnXgwwH7jBcyX0Q0r7KjG8TxIr+3bHaZgOepZktxhR
	 a6dIhH3UNdhlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] perf/x86/intel: Make ACR static_call update
 architectural
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-13-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:02:33 +0000
Message-Id: <20260928080234.5B6C51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Auto counter reload (ACR) is an architectural feature, but the
> intel_pmu_enable_acr_event() static_call update is currently done in a
> model-specific way.
>=20
> This is only necessary because older platforms such as PTL/WCL only
> support ACR on E-core, which made the boot-time capability check on
> P-core impossible in the generic init path. Later platforms such as
> DMR/NVL support ACR on booting P-core and can detect it architecturally.
>=20
> Make the intel_pmu_enable_acr_event() static_call update architectural
> so ACR can be enabled correctly on supported CPUs without relying on
> model-specific setup.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D12

