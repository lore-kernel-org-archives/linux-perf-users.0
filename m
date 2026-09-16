Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E842396B6F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522666; cv=none; b=leoGcWVHtD8MhzqUhW9XkN9dMdz8VTd2dtnZNr5oMuzMRDThNlMWJ0XBLMcBEO5tA8XWtGQfzLuFo/ikG6P6uWGTUTWFXI7YcmVa4up6YoeWOx9VSQZl2MK1zwYawZPA8YE8WeiWR7JUAdnF+RJS3/2byHNOlGXhh8MMvxiN8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522666; c=relaxed/simple;
	bh=qgUae/3CEUbsTbyQcKY/Cwf+YeGW4GsYQCxfLkQjNw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5HpSJi3CNszxVFtSwxCIKz9f0WIJRqO1aWVoM7ONGttCB3b+Owx+TsPzNbUCIx0BpoYnT7Z6CExyo547vcNxYr9vcQI4QHiSMg6uenMTfceTgJzPTKM/UUI1rF3FJcrb6ROqz4x2sWmiPkVa65ZtzDgyAhabCswIdq/dlAFWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7jRosXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7jRosXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0541F00893;
	Wed, 16 Sep 2026 01:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522655;
	bh=qgUae/3CEUbsTbyQcKY/Cwf+YeGW4GsYQCxfLkQjNw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7jRosXuJJIo7s5PAzggZemm5lc9Zr04Q9GDU5QDUxhq8oiqf3p84jVegx2+xYjnv
	 yoOKuzE88+h9uUChvtqVj5cR/yFV4Sgst7YcGRsRecSQAWQfg9PTv0WP/GHKSt5t1+
	 8OP8on/BkldeVMJhHTruMySrmC0PA/jgN+FfXs9fYLB6Isk9L7kBMUI/WGlY5sbwTn
	 WDo0hAGnRY/gaHlSp6LoL+OGB+JUE55obYbKqdbSocvdo7fwji8t/ycfOTWDg3zy6b
	 2UpPpyUXV+KDrt5jCa2cPsF5EGRPX6B/gj1r6fTKxnPTXr0i4Zgsoh55N/zck4PXJu
	 1MtkhGwMKnksQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/26] perf annotate-arm64: Track return type after
 call instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4cc79c0f84c37c27c2c82edd75498d6ccc27fe51.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <4cc79c0f84c37c27c2c82edd75498d6ccc27fe51.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:37:34 +0000
Message-Id: <20260916013735.0A0541F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable data type profiling to track function return values in arm64
> annotations by looking up the DWARF return type of called functions.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D15

