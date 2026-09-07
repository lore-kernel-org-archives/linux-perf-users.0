Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9D3C2D;
	Mon,  7 Sep 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760383; cv=none; b=RtbPQMXLOE7+OuDiGfY9ASzRg8u5upRA5FPcnbCIcY/SNrsJM3dQPxvWJeym0JxWWu5I8gNbF/VERxYQfYQx1xfK9aEmjKnzt6LAYW1UIDccQwJGnGq+9VuFQaxM4bmIxgriunCcE69aCcr4eb7tnz26SmExkdhDghgMM/TnK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760383; c=relaxed/simple;
	bh=oV8ZMN20Uj0XLpXODbYeSQ4L+O//NskmDctNMFUcXNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hFYpYttleMqKDK1f2OI1YChqLNg9heulXiscOWEBLiyZ/vWPtmRr/+h7ANjKHxQqJR02n8FyhVwgGC7vQe9ktWkaML0eD0C5siWE+ylJHdYaSu6t9C7KiM0yCkEuxZ2attzW7tpZ+XNlUg+IltLHFQV9JkpXG3Ir3/zHYfASpaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iReTl0rT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iReTl0rT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5718E1F00A3A;
	Mon,  7 Sep 2026 05:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760381;
	bh=oV8ZMN20Uj0XLpXODbYeSQ4L+O//NskmDctNMFUcXNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iReTl0rTEGI+TSs98IOpPYF5k4nar5oIe+nqe4V+SMt8cmQ5xtKOxoRzIt6tLNn3Q
	 xHDuD295srKgXOu5wtSvl13ZFadH3PItbeTLmNf9YOG2YC2dnrJPWAGbiPU4FaVOv1
	 La5dQQpvO4QgjgIlUswDyvZ141oIqNk6yrcd2XLbVnDxSJDT3YnYz9CXkfmzg/4SGi
	 q8gulMl2iXv0xe4N6CFvhh2u6iizILWlux/MfBJ3ZQK/nQqUmxVveOv5vEeyam7drC
	 G1pz6KvZEZ3KxCkAh+nMR7MGvKDBuHFYBGWplOUB4jpARMhvssIXdYH+hyzwCN6TFx
	 JFiulBE9KrreQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] driver core: Constify the signature of
 device_show/store_*()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260907-sysfs-const-attr-dev_ext_attr-v2-3-bf53afe57071@weissschuh.net>
References: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
 <20260907-sysfs-const-attr-dev_ext_attr-v2-3-bf53afe57071@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:53:00 +0000
Message-Id: <20260907055301.5718E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Prepare for the constification of 'struct dev_ext_attribute' by changing
> the signature of the standard callback functions.
>=20
> Migrate the hv-24x7 driver in the same commit. It is the only user to
> manually assign one of the standard callbacks.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-sysfs-cons=
t-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net?part=3D3

