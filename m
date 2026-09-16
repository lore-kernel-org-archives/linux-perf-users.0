Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19543ACF17
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522992; cv=none; b=aRu4dwvmehDCMxjmMp0Ls/wxRdq/SV164n1zY1VZSa3Olf7uZTo+x0oV+ftZtVZBfMlR7hwFyy6JS0fV/vuc8EDjCXGRwlGZDEh5R+DoWUMpvoDp9RW1eZ3To9fUpCjR+LwgJd1Fxs2jF89H3mqCAZ02sA0ZgYrOY9+jFROSEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522992; c=relaxed/simple;
	bh=/PIC5QDt504JnFJbW0u4Exw5b9NloliMKnLDSSXXE78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BzPU4J4oElh7PU3kcY4Ab10Mo5pAznMiVbBqOigfgdlAqzgTOuJrf6TQRzt08o3k1hJgkNrd0CqQsyV07Cre6DYP7SZkIbFpx+R+6q0jd919YSOVgvAGwVE9q1Bk+Z6IBMCrhFxNZa12FSbmeE61McQExRc87GaaAdbBLgxGW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCbVWzpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCbVWzpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392051F00893;
	Wed, 16 Sep 2026 01:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522983;
	bh=zet4wCavDO7VUXVIq4gWMn90khjNYV1JyfpjV00KO3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gCbVWzpxwV8E17DrLXgILC8AtzBXo4AQBj0kk7QWBJgJM2Fs6PE6Wp3OYAMJfYQ9W
	 rZiRAJNRduuAjZsUNFfltIgs3I3jD4/g6EPC8Bf715zHEiOFEsuOfNJVYn9MCGe/s9
	 WHbuPb3Le5H3iNGEa0JK6qvGN0SibIji9ZqHRqGneOOKl2d3E+ROAlzJUpKF/fnZpg
	 kxn43rodQ5/gOlEwLkJmOOhzuP3PrOIFm9A4P6RjfIFSAGRhdgmJJSbmZaARkdefGU
	 +aPf+IAuzWo7XntE5AeOmxu75H1IRIHVOfCPlF0p3vEjWpde7efrZrE+xqZ2MMgyfz
	 qG1Prop20aCLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/26] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1f03970d9efc5195283158362873d1e445b4afe5.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <1f03970d9efc5195283158362873d1e445b4afe5.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:43:02 +0000
Message-Id: <20260916014303.392051F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, arch__dwarf_regnum() assumes that all architectures use a
> register prefix character (e.g., '%' for x86) defined by
> arch->objdump.register_char, and uses it to match register names in
> objdump output. However, this assumption does not hold for arm64,
> where assembly syntax uses bare register names like 'x0', 'w1'
> without any prefix.
>=20
> As a result, arm64 builds may fail to correctly recognize register
> names from objdump disassembly, leading to incomplete or incorrect
> annotation output.
>=20
> To address this:
>=20
> - Make the register prefix check optional, allowing architectures
>   without a prefix character to be parsed correctly.
>=20
> - Extend the delimiter set in strpbrk() to include the closing square
>   bracket ']'. In arm64 assembly, memory operands often use bracketed
>   syntax such as '[x1, #16]' or '[x2]'. Adding ']' ensures clean
>   extraction of register names like 'x2' without trailing characters.
>=20
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D8

