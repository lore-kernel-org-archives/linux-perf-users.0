Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5F302CD5
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850915; cv=none; b=rTY4ju2EXVGCoscXscaxUjqz86v9+kpVRuaMwM2moELcJ5FyRkTDu6XSmZLp/f19+j9Ltqp3AJQtLLiT0+9+sFJLxtUKlpdJn13v17y9+XKXyXv3lzekSrfmubSJiU+LsxRa6KVO9lCPO6PPJtRbI9QWhGwkB1J+zKAt0+W311o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850915; c=relaxed/simple;
	bh=k25Ywzi9TCjpnRpMy+XeacIZMMyHznvaWcRpjJgt8Ow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YUQh0YfZ3OrZJedfd8mjzqns1BvDTVRvdpLg+6g/xW9mn2c+Kzbv7IZfsIN/RUuYzgx7C0pLLxE8Mu4gL5zdSo7wTAthQ3cWqFHvi0exQHtuSO5kN0XONlI7DLUaW+W2YcBInIGa8OyIBGUb50S6q+BGSHanDoanbdx3eYYQ51g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCiTwz+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCiTwz+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05ED1F000FF;
	Sat, 19 Sep 2026 20:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850914;
	bh=k25Ywzi9TCjpnRpMy+XeacIZMMyHznvaWcRpjJgt8Ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCiTwz+ai4z8mnUzlMiwmd2JajPUNzfFEcJGxVoVTPnUZd6W1ZYARo59xatREiIms
	 8vZq8QBQli6GHi4vH/jt5tu6oj7DKbapraDuOX+uafD6x+KxwSVvbJxDMuVcfBhxUX
	 /V05rS3S5SRiwumLSCRI8JmhamSZbhXktKjRdrozZdNxDIpk1FdjOMnVtvxMBQ9oUv
	 sCmp3JTKEiGIlV4GXZMmSCZdOxFdV9AMmR905kPZ8kBURIJakqvfTT5UdSTyGEjU/L
	 jyZnEKy3l0ZTAOkzEl8etiyf4xTKtQ4ARDF3C7Nj2HoVmqNo4EWE6SsopZbmUjR5dB
	 rTEzqTj7T6D0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] perf dwarf-aux: Bound the type chases for broken
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919204027.8504-2-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:48:33 +0000
Message-Id: <20260919204833.E05ED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A DIE that is not what it looks like, e.g. one parsed at an offset that
> is not the start of a DIE, can have a DW_AT_type that refers back to
> itself, making the typedef/qualifier chases in die_get_real_type() and
> die_get_pointer_type() spin forever, and the same for the type name
> recursion in die_get_typename_from_type(); 'perf report -s type' did
> exactly that on the dwz compressed debug info of zlib-ng (libz.so.1).
>=20
> No sane chain of typedefs and qualifiers is 32 DIEs long, so give up on
> the type with a pr_debug instead of hanging.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204027.8504=
-1-acme@kernel.org?part=3D1

