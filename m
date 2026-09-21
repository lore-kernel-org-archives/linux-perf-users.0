Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315C34E774
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968188; cv=none; b=qtpi62rduB5oZ/vEVMurEnMhKkdXcEih+Ade9mGXGE4toM/X92yCV3fE2mR7E1wFye4XDFCS3G2BEvLonPipKcMb0b5iapTjJW8z+J5GGDzIg5F2aU+4SuA5KgPSOSotNBCpay0RxW1gJCNC+UK3vS4QGDE347IT3DRpPvIRwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968188; c=relaxed/simple;
	bh=8/QXqkJvoYEeeifIHMirA0GCsFtUscg8fRvcuRC7sxk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JdrdkaQjHWMYoKpLiWL80JBjlrsQ+9gLT6EysYIKT6IsuBBhWl3dVHeD3Bb4LlQAYa41GDR5u4tnXkVeAXN/AHYCE45fyWZg413S9xohBvNpGCFhKwfDtBgUsrARY0nyfLjCdDttm6HNmkcCy2cMRgSjt6ARy0Z3bovu2Nz+1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPeOvlX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPeOvlX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1A51F000FF;
	Mon, 21 Sep 2026 05:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968187;
	bh=aihvzARLW7xuTzyvBFHFIRqplSakRRFRgeE+T4/T0UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aPeOvlX0dz3mFwyj7FyhPAPHYyLugVeyHObRyInF4ETnY7IOXSLha8uBSRbt1R/I3
	 7z87p6C7gebVzDkz/VIzUDVpdRAGSBYuFNEvVCR2QfrF6mtgpSDeqxK/lvEUYjaCaa
	 WIypmXxXFRrfp3uqTwGAnM2HR184P6oqKGij3ES82atYVyk3OMESbLAidadbYnu8wP
	 awUHf+TCYrcFHzi8mhDKF/v9qeoT89/A42XCy2Z2hanXjG6YQohyALjYem4Y+MFjIU
	 a75ANQwReuQEUN8yugBsouw2FI3E7vg1IW51hCAJMjo4/Qk50qUqJSKoGKA+6XdAxT
	 FebGcmOZhxVhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/49] perf python: Clean up pylint warnings in
 twatch.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d05062e2b188b513f66a91d2ee7c2c03f7407486.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <d05062e2b188b513f66a91d2ee7c2c03f7407486.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:23:06 +0000
Message-Id: <20260921052306.CF1A51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in twatch.py so that it passes pylint without
> warning suppression comments:
> - Convert tab indentation to 4 spaces (W0311: bad-indentation).
> - Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
>   after evsel.open().
> - Convert floating multi-line string comments to '#' comments (W0105:
>   pointless-string-statement).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D6

