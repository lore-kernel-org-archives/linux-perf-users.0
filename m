Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294E527FBF
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418573; cv=none; b=If5+RNYM/rILEbhCib1f2E6UoGw0SdW5vAxQWiyHkKZiaYmeRHyE2BL/k+TDVuJ9j77qCSj+15ydPj+xjVkhMnMkvSXkJyhOdEshA3KAyrt1UmjkBLwtVF+KXUX6ByAVM9mzsZeNIoyLkBGg983zecRvxAwGdTGYcMQqde9G+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418573; c=relaxed/simple;
	bh=b341PRJwSKtqqJ+Q16wSZl+VHMwkS1hB8wrsdOzXy/E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bNxLo0dCIr4bYKVH5SGApI3+lBc2wSZRIUPbHGxhy3ruV6TdPhBIx1QbdTgJt8o+dg7hJGf6A7LbwiAd1ColCfFcSCnkExaWyZVjITV5LAYL62YFCOjxddQFUpfNqAU8myVAqtjuL16ky+YWXJ4dt1fhc52iEotIqx757ZM/zWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPjHbbiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPjHbbiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BAE1F000C5;
	Mon, 19 Oct 2026 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418572;
	bh=bKEAvYEkuDz4Fzs/npbUBy/MQ+l3JR5ZCYVfWM4tf58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SPjHbbiVh5Z9QAfZVNWeZYBcSMTid62IKbFvdloEf1xK0EO0oXyDJKljrube6vEZf
	 8ZAViHmElP1Y3jsdtBs4RagJI6ju/fvpC+4x/5mOLr4/eIdifgMYqaV31x+5xGEmOf
	 QkiXBLY38Q7hM+o2Ar45vVWYUkP0bcrUlU5sHgmiJWhglYchHeJ6kVerOWhrJ0k/aC
	 3Q9fH2qNJWatn+Dz2O+9Tca3g82+1gBKdMgXhdpf2ZpVuUZTfqgON4hYs4A3GndUI/
	 yNM9+oWDE20nMTF37C+uT7ukvHWrWhqrfkHlo+e0RoXTMZwZgZVH9Bo2I0WM68QrRY
	 HGuopzHacyKRw==
Message-ID: <sashiko-outbox-177265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] perf/x86/intel/uncore: Fix PCI PMU
 cleanup on setup failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019135441.1420968-19-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-19-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:02:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Zide Chen <zide.chen@intel.com>
>=20
> [ Upstream commit 003267cb94e21d762eb72d6977d84f44f1705bb7 ]
>=20
> When uncore_pci_pmu_register() fails, pmu->boxes[die] is set to NULL
> before returning.  In the uncore_pci_remove() path, this causes
> uncore_pci_pmu_unregister() to be skipped entirely, leaking
> pmu->activeboxes.  In the uncore_bus_notify() path,
> uncore_pci_pmu_unregister() may still be called and must exit early
> when pmu->boxes[die] is NULL to avoid a NULL pointer dereference, and
> to ensure activeboxes is only decremented for a previously active box.
>=20
> Additionally, since pci_get_drvdata() returns NULL on registration
> failure, uncore_pci_remove() can no longer treat NULL drvdata as an
> indicator of an auxiliary PCI device.  Remove the associated
> WARN_ON_ONCE().
>=20
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Link: https://sashiko.dev/#/patchset/20260512233048.9577-1-zide.chen@inte=
l.com?part=3D1
> Link: https://patch.msgid.link/20260611160033.66760-2-zide.chen@intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-19-sashal@kernel.org?part=3D1

