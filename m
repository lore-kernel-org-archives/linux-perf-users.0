Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83255376BEA
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991210; cv=none; b=QRUt4jPSTrOwETXgqUCBOjDPSdHsJFbfqDiqbRg1kHNwG7pJk/l1HSrKKh9oPvIBDGz1tx+xX/m4UnHRu/xtugjgwTaE2VzIc1ACNTcmbtEtHQ50t2PEX+/XtEyso29C9bKObUX/0ldxETpJfwcZGTVkQkuo0lhb+AZ1pqY7Apw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991210; c=relaxed/simple;
	bh=pueUQtq8OUVD+JisXSvHI+k0IHW+UCHgGCTsnq6VxIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZfT5nZlEJjVIViQ3u5QsEkpcd5z6QHfk8axcX5iZ+qY52VBHt0LTXxd12FP+CbnqGLvaMM1746SiquK51pQw4FuXGVyt06WH00rdWDvS6fxc3sFnmy2SkEO32aMtRIpTIXhB6jSzn/7XP94028hH7mAUtA/Byk4VXbcwAkuAqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0m817ug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0m817ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7E31F00893;
	Sat,  3 Oct 2026 01:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991209;
	bh=pueUQtq8OUVD+JisXSvHI+k0IHW+UCHgGCTsnq6VxIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0m817ugjLcc5bfP7PtNApuohMqr5hXzIVIRpNzP6p40CPzjFWvbyOvKjbOwedUHc
	 iv85eDpUZ9HUZPz/u1pLXhZveZ8vJusiKdNyePLrwKb+4LgrgIqisFLkUIfzAHlzqQ
	 2Ih0J41txqfyq79kEC98kwcS67VRkm4xsFQBKrFpmobFiDhuE9SHx1Qh1faZ5Snnow
	 Qc6T39/PYZRJfwJBFAlR1CmSW1/ayFO3HdSlmV3wfI7FyiXRoxHcbP16592rbY+BQf
	 o2AmPVmVB27pL1Uk4jYTifRLutLVuKMP346ciKaJ5UPY7oq0JBtr5E0W7UhuimLLpV
	 y8wJIt+RqzN3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/13] perf treport: Show the profile while it loads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-9-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:28 +0000
Message-Id: <20261003013329.2B7E31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Reading a large perf.data file caused a long stall before the treport
> app started. Start the app immediately and build the profile in a
> background thread, showing the report tree and flame graph as they are
> built with the progress in the header. The time between updates grows
> with the load time as updating the views costs more as the profile
> grows. A lock guards the profile shared between the threads. Quitting
> while loading cancels the load.
>=20
> Tree nodes are now created lazily as they are expanded, expanded nodes
> and the cursor are kept across updates, and events are kept in the order
> they are first seen as their values aren't comparable. Node names are
> escaped so they aren't interpreted as markup.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D8

