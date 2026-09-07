Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46AC3890F1;
	Mon,  7 Sep 2026 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760249; cv=none; b=I9wGlaE+PI54jQ5mLJcpd3nFeHmIFDUQMWz/2FgUUqYNL6W1fh/i+Nt/ZNAhvrdcMnKSf+aksFu5CrbIY/72asXdGzxxTUVxiwX/4KjSGn8oM79Dg6dJGfhBgKH4vCltyexVtAzTU9kIJGoIPTvU2cIQ2I5LbHuYvkstkd+7qbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760249; c=relaxed/simple;
	bh=EaJNuxwRHrVQXn7VdQDfO5Fz3QL8yIZAwtG0CYeo09w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EsO9jXXbHQ9KWVUp70u+KyiqI+Yc5B79WFoIebDqgBqRHbWpkYYQ4+Iyrat6IrWxSxyqlXYxunC9OijqJcPVFYgZ+H28v9p4YbtAHDDLL/G1xS56hjTbYMUfHcJAZ4XCeKR0jWcbNE55pfPbwOQiGPX3nZe7pO9FcAGFqTduNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DclQyIOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DclQyIOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328851F00A3A;
	Mon,  7 Sep 2026 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760248;
	bh=EaJNuxwRHrVQXn7VdQDfO5Fz3QL8yIZAwtG0CYeo09w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DclQyIOAATrIYl5tDl4XodlWZMinmSeaejoYAXnQZK9hdKm1PFHovq4lX9fu84nhm
	 R9tWs1HXQMQVkG5XqfoSU6l18BgLEpggxTYKax4oWbALTEcV/Vv8fE3IS4rbpMnXyq
	 op4sfoBkKgw1f57349ydhV58H7c2274++CMm4x3fEBpCcpVqk81GWyddFoEXZCxx7M
	 2qkCIUrX7gNrwNnFE6m83nMb+DLDYA2muU5A0lPs2uudhCZ88h6LtXVi7chJvm2noq
	 K9OfUFP2eZ4eiExHjFll3KkZML+SzU+jdih4Kuc13rNl8j+aWdtWh0VUbfX5Iu8cA+
	 0vKfC5epMX3Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drivers: perf: Use __DEVICE_ATTR() macro to
 initialize dev_ext_attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260907-sysfs-const-attr-dev_ext_attr-v2-2-bf53afe57071@weissschuh.net>
References: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
 <20260907-sysfs-const-attr-dev_ext_attr-v2-2-bf53afe57071@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:50:47 +0000
Message-Id: <20260907055048.328851F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The upcoming constification of the device_show_*() callback
> signatures requires the users to handle the transition automatically.
>=20
> Switch to the __DEVICE_ATTR() macro which can do this.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-sysfs-cons=
t-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net?part=3D2

