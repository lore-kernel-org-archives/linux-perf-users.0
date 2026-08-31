Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62E59B67A
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184305; cv=none; b=j9OMDZ5IMMmXeWixwH31Mu931l2ay1vtoMXJqBVRjjgZJiCw+tqfcseoYKN+zlmhEBwY9KBkydHoQXXMHWxCD911rc4Br0O/1QNEMAFvYHIfDn4/EBOhGBAf1KYCTh7KSKqhkYWKvDAA+trSFLStx01jbaNdmbro/YauATwnriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184305; c=relaxed/simple;
	bh=+adHu6aYk/Eoo+/9sxhoS3RuB21c9ZfZp9yvmK4K9dI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T9nurQcrdJ3Ofmxbm7ctNKNotxqWv3IPQInuRx5Kk39YC8T7Zn7y0LKmpQJLzjVk4sdzW1AVyL3FyzGrDBQgWzDsNYvOJGKebjryWLviErmv9EdYwPN8pdpeGtEilQu7sJUQ4XWcXvWG9utSHbVifakg9MWv1WUMfGN1MTs8r/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5KxVtVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5KxVtVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BAA1F00ADB;
	Mon, 31 Aug 2026 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184299;
	bh=+adHu6aYk/Eoo+/9sxhoS3RuB21c9ZfZp9yvmK4K9dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5KxVtVm+jiSR+Hb/z1wZmxvyieddn2LM1oXGTFCOajj9whRXaGZXfTzm9r7APYKI
	 ErQntprxqZbPtV6VD6aKdG9C8JTX46IONQVJO8gzlDRjVK5ZALSZ7G/v9gQrVkqzX+
	 g8pQc4WXwtkQbvfD9A/XlSdMfE6XfrsrBwy3TUfN//QwA8e/CTknAmoTeHXkYVUpnx
	 vnlZJO18WVHZLL2Zcv6+EexjCU7QkQQHg96ybMrwshvy1ZrH1KFE+4yo7jkenxnKtR
	 6vf23LYifVw1Nv2v0yq2LO8TZSZS8zRSA9fH4CsfHW1L/yyeEHzVMUa6gRuKOBEyP+
	 60H/GBNWiMzGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] perf/x86/intel/uncore: Guard against
 invalid box control address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831133314.4125787-18-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-18-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:51:39 +0000
Message-Id: <20260831135139.77BAA1F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Zide Chen <zide.chen@intel.com>
>=20
> [ Upstream commit 3c19ea24f02658c4b8ad364458fae4d77fdb3fae ]
>=20
> Theoretically, intel_uncore_find_discovery_unit() could return NULL,
> e.g., when a CPU die is offline during uncore enumeration and its PMU
> units are not added to the discovery RB-tree.
>=20
> Guard against a NULL return value and the resulting invalid box control
> address (0) before accessing hardware.
>=20
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Link: https://patch.msgid.link/20260602144908.263680-3-zide.chen@intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-18-sashal@kernel.org?part=3D1

