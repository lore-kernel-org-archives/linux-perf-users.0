Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1F384244
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611698; cv=none; b=u+QijMsr7UP9lu5a/yWF3AoUraN67XbwaG6X2zKyGX9UilHo3nhBGfekZLEVsxvAVgP9DVCm8Av7KA8W+vClNDsXhct2LvIv4Mi09/UN1LFYaky58gkIOHUKXsoJAdVfuIJgXHUR44ZFy20RtrtI/tAZ269bjFwXm2OmT4kXO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611698; c=relaxed/simple;
	bh=HtfyHxYWgcDIcADqYsLzuHuEkTemzsi4tjqMzWcpEdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CMv6+pZvANmB9uuFDsoGoBLS1blU2UFRERZRM5FjwzT0zmkEVhLvkqntqZuO2PDAj0YhajBf/2nDfJOKVuUR30onD8MnQvYBsIZSBeIU6ByOI1LJNyG4ZQ4G16FeKphFCPRLQQ8fo7qzJrO8Jf4bCnKiKEBU+OPaJ/gynOUJAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEnCawnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEnCawnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9F81F000FF;
	Thu, 17 Sep 2026 02:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611696;
	bh=HtfyHxYWgcDIcADqYsLzuHuEkTemzsi4tjqMzWcpEdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jEnCawnOD4gG5AdLG/9uHEl8flijXTmvWtJF5dXrplLDX3Y+gTV0sNuGQDqPZgGMU
	 Iz3LkO8gxgSi7gZwAVyXWwQcPxfcGzzLcaGRmlRrkE7NFqtsXLoz0iAlQ9Udt9cLSg
	 KVQId2kOTDudzMENw3JYSO11LFyKGyLEHz0mQ31ccld5aCc9JvcvJWRIg2YL9ElO3C
	 SZYXEHLf+phct/JMwb12byBhARvNJuLAyCeQL3lfreV5n26lrJBCzUX3nz7CRiq273
	 LSahbhZok3WAeyi7wUY2ORQXeWwfsEoQvYOa5+7SUyzNgkQr69pwMFnEGz3WE52i/n
	 d+T//f48jqgGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] perf/x86/intel: Update arw_latency_data() mem-op
 direction handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-5-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:21:35 +0000
Message-Id: <20260917022136.6A9F81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Align arw_latency_data() with other *_latency_data() helpers by
> explicitly decoding LOAD/STORE event flags when setting the sampled
> memory operation direction.
>=20
> This keeps the latency data path behavior consistent across platforms
> and avoids relying on implicit direction inference.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D4

