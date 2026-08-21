Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D044780F
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307026; cv=none; b=XgCxQZ0bQ78kKNuw96XTC9TF0afoLWMSr6zlEck173r6/qdt4nXLsnok7IWcsYzWLnJXYtaO61aW+GvCd9in+nbE8O+1pskcdwBAQcbsptFg3ToxhU8EhuIy8454Je+XmOPs8Iyme8Tv6aCKRPoaF81/b9y1kmQpFchvizOxOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307026; c=relaxed/simple;
	bh=JMWJj7bQVedzmPKCtTQc8U3D5roE7F7cT1EC4Juk5PQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nv/QXP5IfK2ImPmyT4IwtRHrHTjhVbIVopgafq38ID5dT16o1zCWw0ZLQAqbGPEq36kDl7lkqR5rS0YPLGoZTRuSLCEwIEvH/+cl8OoskbTVXqN+esRLJp50z5C/m4pbQXzXhNENw3IFYtCAYckW092lC22j7xVc5pg9z2YAYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIKWt76Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIKWt76Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F641F000E9;
	Fri, 21 Aug 2026 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787307019;
	bh=JMWJj7bQVedzmPKCtTQc8U3D5roE7F7cT1EC4Juk5PQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BIKWt76Q7mchEKbP7Ix/KEmGDQze9TCl+3+JWzEVafKB7VRonRBcbCOm1KqJdWMjJ
	 bHhUlzmdyZRlQfXkamcTOVH7Vo0YzGYeZJJbB7jQEF9fk7Gd5KHhn+m9dcm8mAX/bP
	 dO6ELGQxOWsr4i2H4auSpAn+uTLET3BsFf7Y9K5ixVfD6QGrrdZ8ml9w/3Fn4eP+Pz
	 w4bcytPI7G+r0FoWrefllPpsn4/UACLPfs5QmGSy2LcuGN0+9P32ici5tchQ/DyDS9
	 s59VsojuaS0Ncnrn94IYswQphHjDnTB2LEfAqXBJikpEBe1FvqIkiTWRoMQnN+aknh
	 VYss5ScGANYEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] perf/core: Return errors from
 perf_report_aux_output_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-5-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-5-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:10:18 +0000
Message-Id: <20260821101018.C4F641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It's useful to know if this failed or not so a retry can be attempted
> later. Return the error code or success.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-h=
w_id-output-failure-v1-0-9d532ddabcc3@linaro.org?part=3D5

