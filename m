Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E430596F
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369139; cv=none; b=PNxKyogh9TY2FvtgeMCrUkho98JXJ38DHL/EO5A+FfFlLfi3tCNuh7SYdIPypb3P9vuaTKRgzZIcCpxxplDo3zZALPhGve1CMbpE5lCGrzAGDHPlABv5Ml2FRFJ3U/jgZhrgKYzuB85NiH/ISYNfiBF0ilL03wGwAUA58mffLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369139; c=relaxed/simple;
	bh=1s+M11GQXkmCQMUjTSQgpLWb1Qqj5+3hkTHDFpgcQiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pt8KZX33rTCNaFsAGXWbOhnin7Y9tyI/JdY0Qu2hYv75UkYbKYbMEdOSTLK228qTehiFKDgu1iiAQpRx8ZaF+sfa3m/OjWZm0aSyJTjfLvbctdAPzgWaJbS+5r2crH3L0gsH4a00AsVms84Xf+jiIEofgE9UI8rPejS1q5F1ZQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAA0GQS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAA0GQS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ABF1F000FF;
	Mon, 14 Sep 2026 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789369138;
	bh=CcAWXh2ahSk6gkTGKYMNo/+orLy097PplCGQX6WWZCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAA0GQS1D5tTPflU98MvpiPtkYg7RK6kMM2Ypx8340uIGLksLtXNr1uVV1WlXEtLY
	 b4LNCWvR1aLXOveskLPk8qRC8otYX8kv+UauKTH6UeQs9p4w93ztwnbiffKc7bwLDJ
	 I6jYUx4ijV/mY29mxyzMFrUGvcV5EO4HAzfbjA7kNm3O3EDiYKYH9qwA7RNXxjHOgg
	 hdA+8yJZRkL1HDXhJxAWlxui9V8SEYNSmMk6bhAe2mv32UGxiiYJ8Zzc0lhqjP4a0f
	 JggobxlFw4VaeTqG+E5m3/yj1NyhvnV9KxNtuQSJ15rFYAG/ADFi1fmS4fhUmc752A
	 /iEJF3nb6WE3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf annotate-data: Convert type histogram to
 hashmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914064535.1671939-2-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:58:57 +0000
Message-Id: <20260914065857.D6ABF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The type histogram maintains sample counts and periods per offset.  Use
> a hashmap instead of an array to reduce the memory overhead.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914064535.1671=
939-1-namhyung@kernel.org?part=3D1

