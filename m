Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFA3D7D80
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539992; cv=none; b=DzBMte3YSy3wsddglOOUaAcDD1PTWyLWIFi6tvijaQ/rKVWmYISjOqa85GKJ5wwAOQWIMyiaqjYsw2vfR8OPCng7DXDWnuKIb7nJHFe1G+64ok2dMfGRoLFXdxE83XnIwca1KAzujtEYA/AeQFizcqOF92DmQ72yQ99jk+kWvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539992; c=relaxed/simple;
	bh=tyZHmujl6WhGFt+jNvchWW8E+FeLDl7jdS8R5FOcHl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDd8Rs3pLw5R0f5P8QnA0X2HTwvuI4nvWaE9PWTHUx0UMwaVSAl+aQnEo53wMRIHO0TXu3TSW+Tg3IDKP2G+JMQO5USsu5kS/jIm4PUcq/xgI5X0eTG+DfB3MOLxllC6hc/RlLqMnEHDeW+dAU7B7s7VdmRzMD2EmA6gQ1v6gZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYzSzx0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYzSzx0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A896F1F000FF;
	Wed, 16 Sep 2026 06:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539989;
	bh=IvQhGYKHBnJlb2qW6eIbQWMTFcB0sKRujoXCcbkMl2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYzSzx0c8C9/HAjxyAJ/1IWUYaZ9SkHIdBBd13O51MXgBja9tOKDmsfBALNtUWRNc
	 2vVlfZy/Tjd0jjIhIVjOrmLIJ8fWQL2CGkKGojkyQi7EeVBz1uu4yxf6MQZkAUJvcl
	 f+/DjUmtTGiSzwydNo+pshWb6+hkFFkXELPkYSof6NBNF/WFnKwFa4Uiv/7oBf2B0l
	 BfjRmcpWNMRLPJCs1s+8sLg66MguNR5xzwDCDHmzRzHh86kswC9hR19zrQp18aKhft
	 rXB6GiJ4M/MfFwfZSN280CPucAFnIaR62ZxVmGFGw1xaVOLSAGDL5/oJ1DqYShUrSZ
	 Hb0wXyVfje+2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf dwarf-aux: Add die_has_flex_array() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061926.2224222-2-namhyung@kernel.org>
References: <20260916061926.2224222-1-namhyung@kernel.org>
 <20260916061926.2224222-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:26:29 +0000
Message-Id: <20260916062629.A896F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The die_has_flex_array() returns true when the given type is a compound
> type and contains an array at the end.  To prevent an infinite recursion
> add a depth field to the internal function.
>=20
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061926.2224=
222-1-namhyung@kernel.org?part=3D1

