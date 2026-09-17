Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689583822B4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611270; cv=none; b=oLkniz8Wl4hyg4wQg4JHL4nv80aNHelaUtiZQwZiSZhSQKr9zOZm5stYWRCFIRUBltakIvoi4Zt9eQ9LAZT+6/hW+BiYsxvTSRtLVN5BzqDNhuYg60TCM62rd1XBgvBo2fcqSj74Yhkqywym/kFgQhJzxMfpAVX2v9OudLYkn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611270; c=relaxed/simple;
	bh=M1Mwve3GUwk5+zwlzvVk500ZrociTlW1P5BL6rngB68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eHWs1x+R9002J/aEyPlSaW2eXQYRPB867LIedNpLk7vpq2jNnnRBLk3foFD4E/cHwq6ihnKEIZfbMz18jNW4FRn4NjFFIRLXEqvxmxiHtAp2nFcNtaUlnKke8xbZnfwXUABFf8sTJYwNKgAAMO/SvadWcFRp5nycx9SqYDW8WCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgtVHXX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgtVHXX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDC11F00893;
	Thu, 17 Sep 2026 02:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611269;
	bh=M1Mwve3GUwk5+zwlzvVk500ZrociTlW1P5BL6rngB68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fgtVHXX2WJ9sn0ZrGuob99v0JavSW37U97gcXyyVBnMDyaKk4vQe+0WipliKbjxAA
	 XTuC/d/wn/6M7cJAPfrPeBqn7ssbpKxpAjrXG5ZYqH8+neTc3m7FcWzWURxk5BDGz/
	 ueB8Si6TPfPULH+LN9FvrXJ3FHiz+vZREAzRYtPBXEsjyPJFtbSVufiD33Qz5OMTga
	 +4sUu+q/x/U2knDBIFkAmskXamUXMHcI/iOj/sS9g0qoDonyitbNQ9X/uxGDUtJ2gp
	 JfJ5TkB/ydtx6mHzBV1uwJwOtqxtFsrvP6ePpOlICY8+fJSmrU6ilBnQG7kT/M3jAA
	 2IJIlak/eL7RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] perf/x86/intel: Rename NVL offcore_rsp attribute
 to offmodule_rsp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-13-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:14:28 +0000
Message-Id: <20260917021428.DBDC11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> NVL introduces Offmodule Response events in place of the legacy
> Offcore Response events, but it still exposes the inherited
> offcore_rsp PMU attribute for programming the corresponding MSR data.
>=20
> Rename the NVL PMU attribute to offmodule_rsp so the sysfs interface
> matches the underlying event name and avoids user confusion.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D12

