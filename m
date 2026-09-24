Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED363F9A1E
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228587; cv=none; b=JHM12sAtn0Av0rxb1CyZ3NBW7dhIIBGhgRRlGbqVz5XHIcvtQ+ewvrZgvQBZxNWyGTx9GIbjotODEqWtYvSnd+YBbphQCXpVxmvTR4yDyRK6GX+5YrUrpPUji5eOJgrpQdzgZQ0Pwwq7ORIzn+sEHpTjvx9LC3DrC3Fo4ytlpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228587; c=relaxed/simple;
	bh=5O/vuwFHlfY/x76zBv3sLvq4NF4if1S9wceCcvC8Rc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MtMAExlg2JbZfkJYLGVqOKGtpFYEPKQqVZrU1WYqj44A/PMSlosiexVyD19I0mjY4+qdv9hIOPBCSagmYlfqFmjci5J8gpxOjaR0hkU/aR0lymS3L0juGk0t3u2ubyNxB3delk2ArOQob2wY73iXpkYRLs/IqqIQKF8WfvdF80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bN215ZG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN215ZG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107021F000FF;
	Thu, 24 Sep 2026 05:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228585;
	bh=DNIDuaJ0TKY6nxTQsnnSbW+yNQ/tWRWr7iI24sNZovo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bN215ZG1JL2Vg8/jbZjH11LRQN/J7Pz0e9fQPMsaKOk1HW8frWjReWevc9a+cviCp
	 uUG3C/zNR117KGh5i7xAg4hnia/U3t1wQ1W0P5zp+Vf36yTRCyg7HITSSJqf0srWZz
	 2iIZ33YGqTFN0BLuc5e6lnp7IiG5Tk4J1jxUvabijHvPFRN7JU3+wffngZY1LNCNNA
	 Ip2WEv9JeXldwIl0oD6gCjBeTxOt0yiGl3BEIpRL3Q8G+GCGUKP51irWruSsS7glY8
	 HPA6RJW9dY9yPLVmMuyrwPLgX+fLv+iJC2GM/8lle4XZnUhD5yT6+JzqjGi3XuoeYH
	 CJYEIAnX4pUVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/21] perf vendor events intel: Update haswell
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-9-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:43:04 +0000
Message-Id: <20260924054305.107021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated TMA metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D8

