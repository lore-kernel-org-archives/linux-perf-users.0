Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A63C3F7B
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912650; cv=none; b=OiEoDc2KBbz7Emi3xxHN8CIgvI9FH7ZfkbWNIt9BEabT+mQjKsgDkRVYxSf3BL+8KDcdsBJOe7ZQlut7Zhrv3Bs28NjEZEs5Oixnhe0uuqF2/nnXM4Wepx08HC2WzI/2fcdz6OX62Vudyo5aaaA2/WvBRH+DduoFeOwow2RTZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912650; c=relaxed/simple;
	bh=FVWJUr/D6x4w+Iakrlub36ExoIkIhnHVLD4K5A76Pdo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I3KOC7mdAeTnuPIm6u4Q44HxLcZZ+oA93+AwbrRJ/EoVcxJeuP/0mVTtHD0gYHJFZg/QNp1NuIhuo2AFGcPbzd6asUFLqaI6kxhOxDnET7UWbi/Qv1D5Coww03/oz7XqiVqsoqD5hdms0El2as99Oe9YOGHNPvpKWM4bMWjRT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1zWi7wE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1zWi7wE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FF91F000FF;
	Tue, 13 Oct 2026 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912649;
	bh=Z4ed0EgjyRfU8K+16/U8Ks1GPCZ7CbtNIqC/YYS9NDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b1zWi7wEh7fy71LL9bXgqIUnTilzmqVTbRJ4/axNrNRgBm+JHRWpce/j2E1EcaTK5
	 RHaEBX0sEEeYbBvCgskL/OwLOuvgCdf50zCX3iGFJs0bnjfeYYCCcGab7odpU79/E8
	 zfHAI6gKHgJVDrogZriFkXYleiEBnpCfVz7i4wpPKvmdymzJxvGNa1EL6l0DSVl4VP
	 cXiVRodizd/+ikoSj4L3PSjG7OHjGwfpwSM77uexSGZfUolcp+619WvsodKZ9r71LC
	 RzoJDtUPHrgeztaDgI4UbmAp+daXzoSCjxWHtFbnsxZLqWNt1NyhQd7dOcYmTwdgJI
	 SCcAu/0XHClbQ==
Message-ID: <sashiko-outbox-170232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] perf tools: Factor out dso__find_binary_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-8-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:30:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Separate out the logic to detect binary type of a DSO.  It checks if
> the candidate file contains ".text" section.  There could be data-only
> DSOs but as our use cases focus on the code (perf annotate or intel
> PT), we can ignore them for now.
>=20
> But it also can fail due to open file limit.  Handle the case by
> retrying with _dso__data_open_lock.
>=20
> Introduce bintype_searched flag and it accessors to prevent repeated
> (failed) search.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D7

