Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37551C05F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171605; cv=none; b=iwbLFev08qWqHt7SiY17gP+ZofWV8qwpRu2wPaxNgt46MHuZLLrMpD+VAan+7qYrQ423A4wtT0Mw3a+h2AcRQLCya6+Gw9+5FxIrfJQQCCe8QdqvqTXNyq4eVy0ESc8ejhPo9UlyQy6Jpj6nYKW4swdR1DvT6OBzre4caK8tLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171605; c=relaxed/simple;
	bh=0DZeRAnHSVXr4pQ2MAWN7M5MocHIHCk8RAJ+sHTLEVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dLRAwnzOz1rohLjmk3ac7ykhjkuztBcmB0dIYPTOjDSW+s2kpu4Gh6qupXxpCxRsx7dI0D0UQEdK/MfiD8zoeSpsClqFunst3JSmKG3Mnu9pcxYDWWcRoGav2fjr+oCRhd2mJRvqrNEA6m7Tbdfda5Yx4qNqazoz7Q+U4sDlL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceMXr2fD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceMXr2fD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAAD1F000FF;
	Wed, 23 Sep 2026 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790171604;
	bh=0DZeRAnHSVXr4pQ2MAWN7M5MocHIHCk8RAJ+sHTLEVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ceMXr2fDEoflnE1Kv5VbBZOjSw7CCHHSq8SeHbFHp1yJ7iXcgZ2JUlNItDmVkfPIn
	 I4+oT+dRhCKBmtK+XlVRY/pWMnj0gpAYCl8lTnyyQHqJIg4LY7LFPkonJb7svv8tQo
	 yWEKq71dK9BT/IPvmfebLVRDG+gkDVo++HtmQpv1flH6p4ptR9wM+nYdIzzMc8z0vB
	 6uznMVYJUhvLNKu+bkdOMnTfpxnNHKDofCBOCwzSqjyvLsFlI5xV1eFwkw6jzzwa5W
	 lmevzsMiDunNMblevyRipLdF7VNSLr5mZ2jKWgy+fQYkhDQH/VgdL/tZz/E6z5hSGC
	 /S0NLsjToj7cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: document task-clock/cpu-clock in TIMINGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Melendez" <chrismelnu@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923135140.386033-1-chrismelnu@gmail.com>
References: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
 <20260923135140.386033-1-chrismelnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:53:23 +0000
Message-Id: <20260923135324.0DAAD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> task-clock/cpu-clock appear in perf stat's own example output but
> were never explained in perf-stat.txt, unlike time elapsed/user/sys.
> This came up unanswered on the list in 2013 and 2015 without docs
> ever being added.
>=20
> Link: https://patch.msgid.link/CAP-5=3DfV0-yvc68BUSKoSajHjHY_A6COgbEJYiFx=
Rg+G-8LeJhQ@mail.gmail.com
> Signed-off-by: Christian Melendez <chrismelnu@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923135140.3860=
33-1-chrismelnu@gmail.com?part=3D1

