Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE1568536
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200877; cv=none; b=SiCnYuV2FtLG6Z7a7PnTIriqDfE35Ozf6yO/stY2dIoEEwfcMWP8FqoOXk5zmDxIKg0DfFk94xd5srlfQWJ4+CCnmuPyVApwvki2d8Y3HOxdUPqT9YJ0yCH03EWSGCuSVcQYx+4Rjete/Oblza6TxhFQC/QIRufEw3U7uHWeW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200877; c=relaxed/simple;
	bh=Pit2mz2h/WmYxjCEFZ+M403+I9esrSVAgk3cUKmonVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pHeJAJ/qU4J9w4gW3Zp4r7yUsWZXnpKYq/xrevF5JmAfpseSoph0m2nOo4QDLCMMv1kzMfY6dF17Oy8CbVP9htydMqQeOMhTARu6KTYV7h8IQFhcOhbIecwPi6vUy3ysOswfNhEaS4KF1HcNC1iUlKenV/M6aff8dcw7jiJ2DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTfIl+Rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTfIl+Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341881F000FF;
	Wed, 23 Sep 2026 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200875;
	bh=ztZy1ZijSpS8l1YIdLmvM9ZhSyrZ04nT825DU72qte8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTfIl+Rwrn/71q5wc99pRfFXNmOzXpjmOct3T7ttD2w/L2ZiQDjKfUcTdb49rQJ4u
	 DaXMGfnjJDn+fIIhKj/LR5aDmEGgO7FaMTahdLmjiLEHsE9UOGoEamZ1vKXmHn8XCM
	 T/MECRurneJZvC2KfTKOw0doG/kzyLcAwnB9koosB6I908HmtBwskuNv/VejqeFy/E
	 O4h/gyv3a1k8P8+4kVnoekPy40WkxqQjzjYbxJxqb0q0zbHE8pGpG7Y8q6H2NJtuFX
	 OiSz1xbQnkh4jZGmEW9xUaQa6fS2lA53doE9//3Hq3FTgIDea51eyAxz5Sk7lRzEaV
	 mJNznrVowgw2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf test: Fix record tests on Intel Broadwell
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923215255.3329181-2-namhyung@kernel.org>
References: <20260923215255.3329181-1-namhyung@kernel.org>
 <20260923215255.3329181-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:01:14 +0000
Message-Id: <20260923220115.341881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> I noticed it failed for leader sampling tests on Broadwell.  It's
> because the period of groups members are a little bit different.  Maybe
> there's an hardware issue but anyway it's close enough to treat them as
> same.  I printed the value like below.
>=20
>   $ perf test record
>   ...
>   prev: 462507, curr: 462506
>   prev: 494783, curr: 494782
>   prev: 454350, curr: 454349
>   prev: 502782, curr: 502781
>   prev: 566693, curr: 566692
>   prev: 606558, curr: 606557
>   prev: 559770, curr: 559769
>   prev: 595737, curr: 595736
>   prev: 643386, curr: 643385
>   prev: 663672, curr: 663671
>   prev: 620622, curr: 620621
>   prev: 650419, curr: 650418
>   Leader sampling [Failed inconsistent cycles count]
>=20
> Let's update the logic to compare values to allow 1% of errors.
>=20
> Also I think it should compare only if sees the non-leader samples so
> split the check of (($index % 2)).
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923215255.3329=
181-1-namhyung@kernel.org?part=3D2

