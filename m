Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E83D649F
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454927; cv=none; b=uQLqjdYP0wtK+OoQdolt1z18JSO1h+QSM7dXSKFQHcsn95KP6d8/MKiGFrp3KvwJh9h3a5FaZ/Y92sk6Uwg3Y9PbDnGxv8ZOB6cTFpTI5e0/QyJ9EBMjGAslanE30yOtatFZd7abmBvS21jp8yC4KqqH5nSna/x3Ns3Y90XYb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454927; c=relaxed/simple;
	bh=cWFPimDnDOWRh9GHR9AVAwTsniSHd3ySMzv/XqqBw/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7ABD2uGKSEboX8MPy1hxigy5y2KP3Q08hlr0xNUxbLEF+DIVQyItdqi12bJgHfkW7EpggLp2noldaHkC2XWF6ims9CiZFQdVYnwOZheYnqqysLbongOLM6SuOBxXsoE9kLV/PyRF56pU729SLCsFmgKzInF0scv6wlBbZV1TrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIPNU8l2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIPNU8l2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBD41F000FF;
	Tue, 15 Sep 2026 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789454925;
	bh=W/go1yh/VJDio3yCiO3REbeeuz//uv32kQwllUek024=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIPNU8l2sTmfmga4DxjxMjQR0EqX4P88AufPzzvYTTgN6nu2FBBydon3KI9y0YfkE
	 0cht2oOtTu8J1zcOPSnfYxJVbtueKRyrPBvMXeqxyNo2SqQczdKHAwcRyhcSERrkFq
	 1/DNpOoW7WwEdByTqPDa6e9U4I+XYwbB43YDfl7W6eTndVNEXcFmQXGcA4DSoCgdau
	 SgtPsPvnMN2mU/UnfkOFFLL5eSQ+/qkCGJ18augEA/qTt+6CEp447pTJScnHsaWEMM
	 clsHrDD3oM3v0eFe8UEVVfkoYXJxJAV+4rKPIzAuD/waEq592zftfnKV1AgZOpwE/O
	 5GzbnLMlG8Khw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf annotate-date: Allow out-of-size access for
 flex-array types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915064035.1970175-3-namhyung@kernel.org>
References: <20260915064035.1970175-1-namhyung@kernel.org>
 <20260915064035.1970175-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 06:48:45 +0000
Message-Id: <20260915064845.8BBD41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Structs that have a flex array will have accesses beyond its original
> size as the array was declared as 0 sized.  For now, it just allow any
> offset bigger than the size.  It could be refined later.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915064035.1970=
175-1-namhyung@kernel.org?part=3D2

