Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72D30DECC
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404406; cv=none; b=qYhBdCANdkBGwWbQ0ZtQlEzbtGlrWat9OoIqE9mq2kgpadcPMM+nYGiEuL+aSOk3V/IjEWf4dg7UbF0PuSrRRQJ8xfkytMTk/axJ9phjHIBEz0o+1l/6Q+popt6//DZgIvj9TtE28Vect7NPvMsP0WLSLjuIDew7BHuci8cszhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404406; c=relaxed/simple;
	bh=MpIEPGsiJLQ+hZoUE2wvLRPkcnPGjBCl3czL/OijQWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XtoRC6alBhIkRXuyT+NzDzcGva7TuyhuNoRIbrfKeF4hZW3MT8q4JXW475SD83BOGDckp2pD+qdXGZQT2ZiC1JW7taWHVnPO5Z2XxcG0n2XOIQ1G4An76G87OaONfrDH3wgYDzsi+8cZMOrnTkIHG62b6KetkmX4J58F7S9kxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfQg2b27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfQg2b27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE731F000FF;
	Sat, 26 Sep 2026 06:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404404;
	bh=eA8Ie8SoDOm9B2wtdl1Ve+oOjogyq3/1t9BjCKTlgCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfQg2b27ZwHY2R8g/j1JTQiv/HAi+D7y9NjM3s0/49Jmgy34HEJqdZ95QflVQoDDh
	 B7jTIWT4LXcLlllR5V74CXZr0bX1lN4Mm4lD0TqCp49IELgmyQHhcvLFgoHrgDoQd1
	 x/8ByuUcqjLayUefIsBTLpQ6cn4DYvcLvfOGs9mCdsZIZt8hiSV2pwOLR2oaiEb2zc
	 BJKf8P8XXE4K5RcZ1CHaD/V+wLZ7pYE/d8xuq5Tt8wEjg/uzdkxpBHaTZawXdDZoBB
	 r19mXI3//oBGXh5yHkwLrcF7wLZrllgIBip2xKvjyYbUhldkCxqXntOZ5tnvZUDv/D
	 noMN72+ZcRIpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 35/49] perf python: Port net_dropmonitor to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-36-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-36-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:33:24 +0000
Message-Id: <20260926063324.ABE731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port net_dropmonitor.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into a DropMonitor class with full type
>   annotations to encapsulate state.
> - Use perf.session for skb:kfree_skb event processing and add argparse
>   CLI support (-i/--input and -k/--kallsyms).
> - Resolve kernel drop addresses via perf.session symbols/callchains and
>   binary search over /proc/kallsyms, ignoring zeroed kptr_restrict
>   addresses with graceful fallback when kallsyms is unavailable.
> - Remove Python 2 compatibility code.
>=20
> Add a shell test (test_net_dropmonitor_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D35

