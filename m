Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478037C0F6
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291859; cv=none; b=Ga7/oekc7HckDOk7rLU8GMFgevB6kvCBHMmi9nE8L3i/awW8XVnF9zYQkGMnhtXx6WrLyH0v9Vw/k96RzuViWh5oOXvRx5gZoajq6jQCtNEl8e6roz+CvvSmRVWxL9bFeIJup8rTdK4zgZ+bfrgUupra9bWTzAa2Zm9uPNBZHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291859; c=relaxed/simple;
	bh=1LqWqD80cZ2SsDie9VwsR6D4hSHwrrCjtez5EOoPD6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=djx1LuSamPwF2oLCQdtRYppSrT32w3gF7xeO+9Y/X9qBxCzRgfngfmzQ58BpOpmsX8VxG21QVHNsGpqAgQ4fs3RCxfog0KKMPEQ+AfnlBqlMSgCHThL2opz5zkloxcgpY+VYhrHXv0iCPfsLSXi4wY2CyocYjS4geNzeaVuVzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNlhUXDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNlhUXDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDD81F000E9;
	Fri, 21 Aug 2026 05:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787291857;
	bh=1LqWqD80cZ2SsDie9VwsR6D4hSHwrrCjtez5EOoPD6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNlhUXDP8wp5hrWshqMaq/hO9+szbxjW7m6L/n7rygm3cd/HDGOpz3lwIiJQ9T/Co
	 0aXhkTyyjuKSyt2g6GzMp0KpdCZ/UJs1BmJrXAqmnJ2RkO5YG7Ulfs08f6gYA+IedU
	 9kDu3J9+ZhlEdQ+7Njqipu8Uppx/FMd9Ldmu0XeH/hGC7Sok6+Xkkb2+x63dwMsbCi
	 AQZepwYXWOcKnb9zHHrate8aCf2M8gD8XK7GNoMnGrrO5uWYOhSP/JzpuKTZ6v4aXD
	 mWGXKttM9e07fhqNoOAYazIWIz8w+nYKjmPNHI0pcwev0FFzm+l747+wM8Lb5W4ShS
	 QdHZhmfJdXThQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf c2c: Fix documented default coalesce fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a18212b62d45c7816dd8dc5fca90602365c6fdaa.1787283281.git.jiebin.sun@intel.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
 <a18212b62d45c7816dd8dc5fca90602365c6fdaa.1787283281.git.jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 05:57:37 +0000
Message-Id: <20260821055737.BDDD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The default coalesce fields dropped pid in favor of iaddr, but the man
> page still documents the old pid,iaddr default. Update it to match the
> command.
>=20
> Fixes: 423701a0c8d7 ("perf c2c: Change the default coalesce setup")
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787283281.gi=
t.jiebin.sun@intel.com?part=3D1

