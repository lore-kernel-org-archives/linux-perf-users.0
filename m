Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD003AFCE1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522779; cv=none; b=F6ZAH58fU62Ie5CPKXLfnqgT32bQNdwXJnwUbRoclygnDusgzOkU+RRtifFBSN3cqk2AkvnXlPHQ649XpKBcWkQctcddLh0VW0rdtvC1+GfOBSmKBWpVxFBi92PIOSndA4kYM5QXA1g9KbuaygR1tI8/lnb9dKg3p4DogU7zQI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522779; c=relaxed/simple;
	bh=559QqiIPScF6u4YYLN2SNXBOSv/QkowaKcQUgXiBrE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IKJMEpfVHKxYbP/E4MvUKfCmtt4K8ngBFxyyAC3Ebs2I+MWBVbPfKZGskZXjJBrsRuXkY5xsBZ2LkgwZL9fEw/ud0b9vn1VKj5NulqfA/WHkA2diUlqyWkzyPiSwWkaEmm8fQRTKlTjqY/smXGBE2c2hsgelZuhnvHHIFXWhAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h29iNu3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h29iNu3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F451F000FF;
	Wed, 16 Sep 2026 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522763;
	bh=559QqiIPScF6u4YYLN2SNXBOSv/QkowaKcQUgXiBrE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h29iNu3L61JtTSSSZZzJ9OTHcp0zrnHdJxDLeaLgUlGec33b4vwQF+xoqs43vi685
	 wkoaZFkzctk2rnSvdUWPwIdgwvtzfmCWeSvm2NF70JcrCOSzNM5JYpCDWOps5T+iel
	 cmIqjEDBvvG4Bofz7QLyB9iIaJqAy1rbg/hhKCE3UGsAhASsmMUewrvVmhC0Q+7/4T
	 t7f3ZN7Gv4jIlA/Me6vI016pEn8DHaexyLomNx7IlkRw8USuWFhYNJ8+nLumLzMkED
	 /DBdPbAo5idRrF0mngd0iO6yhqkKHXtEmatGJc+nmpLNqVhaM1xnnEp2CDQyivEWWj
	 q0iUfGZ+dpbcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/26] perf annotate-data: Add arch_get_reg_offset
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ea1159a887a2f756d64097651f9ac87904968bec.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <ea1159a887a2f756d64097651f9ac87904968bec.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:39:23 +0000
Message-Id: <20260916013923.74F451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a helper to compute the effective offset from a base register
> for instruction operands. Currently handles arm64 addressing modes
> including post-indexed, single-register, SIB-style indexed with
> shift/extension, and constant-offset register pairs.
>=20
> Fallback to instruction's raw offset for other architectures.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D14

