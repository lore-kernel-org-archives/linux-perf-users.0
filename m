Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16821474255
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306185; cv=none; b=dWFeWjAorDfrcFoW8YVpbMdcAoKWkXfNfRgduG1Xl9vo6xp1+hFy5quFdg25xfTZqWRGJexbBECSTBs32gqWOZ7+cXJ05m6YTgsjlqjhBYO1y3Ibl9uMODrDDkBRWuFKdamS5EwNONQ4AyNDBHeBHrkHtbXxQ70jYESr2PP+muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306185; c=relaxed/simple;
	bh=iM0dms7u1kDs07KxrBML6R8449KUq6QV2UnfwEDi48g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FmqIXbEKPI9DkrspSdRT7djqD4zi9/POp8AOkreNhera9Mmh5Sr7Ib9UPB0xvdrCpZ2tIxAdtNfuooiEbG3t9CcI7SxrN/4AXGsY7WmUK+j4Giz39FCFwM4cuWMnBuQh+a2XRgwm70K8RpijVr/3rSQYBFlwb8C6L1g+Owx/4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfJadK3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfJadK3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E52C1F00A3A;
	Fri, 21 Aug 2026 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306174;
	bh=iM0dms7u1kDs07KxrBML6R8449KUq6QV2UnfwEDi48g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfJadK3/oz4ejtY2j7FP4eRvw0+OTDbxgo1gEc2MsBIkCNfgrbrHjA2V0sXGEecKN
	 HLWscZjU912GSGiZ7jmit0kh9QS9pCc+TUMPE9IDN2AA2u7iq1taU/VuQ39Xxew3vK
	 dLXVyxLHcNhtHLweer5paWxoB4FphEB1EAAhDitqIcxoccAE6gFjDSbYYUpYTG2uM2
	 velsiCxwN4IeYwj2JooxLruotOZqIsETRSWSxHVsmBs+iDnQCXFDvyRwJSkAUsYVqI
	 SIH2f1TXGHYapy0VLhGGOG34CLLTZ478QnUZz4ZHlViYMUWqyy90maQtk401IDG2I9
	 buQuDi6jkxeqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] perf cs-etm: Warn for invalid timestamp option
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-2-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-2-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:56:13 +0000
Message-Id: <20260821095614.5E52C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Instead of silently returning an error, print a useful warning.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D2

