Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E13F3296
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005586; cv=none; b=MQ8X2HUCtJt4ibTmxW3+YV7bVE9aQMrEDrOsmPrNESzubhbSCo5y170a9nRy125U4tWKua+amh3Rx7kB58CYf+Fj9IUnKDETaN51Ea3dVtsGvc1/XwfDioEUN/Hn8RYvzGP2JR991ySDt8lMx7vj65Db5Bp5UDWbgNmwgRUtDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005586; c=relaxed/simple;
	bh=cUVBMhmq678pknq+/nqAxd4/DZjYoMX5nTake7ATmjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSu5xcuUgpicyiZF0HANzX50u6iHYBaJJK6sl0RgRBL+uxIquSUshUwqfwfK0uMB64zhtWLWbfaM8FpN6VlmLEvqX/JAqSQWcoT+y4S/luD/XQ13DUfSIAmcjRuRoVJEQzkVDG8R+rxFRqYPXG6QHjMTe20MtMizkXGGltcWaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9H06Mk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9H06Mk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A6C1F000E9;
	Mon, 17 Aug 2026 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005585;
	bh=cUVBMhmq678pknq+/nqAxd4/DZjYoMX5nTake7ATmjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9H06Mk+uHDTknKCSz0iu658EryYIc2H8x00R0VooMF5OYUrbNVI3WSnyyglsbfWI
	 8W9zZrN6PB9ubP4LL0/Ctkawii9E+an2pu6De8Vsxf5dZdCOc47iZWcWduwJi0Scgh
	 eSaCgD9em+vWygKyim8xv5XbeH9v1LkAUjTTlFLJgw7uPmgayHt7u935R7VyN2/9l5
	 guSF8zgsu+vOJ9QxFbL4147JTOgo4cSCKDdSZMGNlPEb/TyxytXqZmiwrLghSf/uaY
	 JpMyaJgRInuZS78UvGvTbLa/Y/+9aFHwC28pHZ/+9kVL8nf6C8FRgNLmHKyeXCGNIq
	 ykGVrlDcZOeCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] Documentation: coresight: Document
 context-sensitive PGO workflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <9c4b59cac4a2cb21ab552398e3deda9e5067fe32.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
 <9c4b59cac4a2cb21ab552398e3deda9e5067fe32.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 22:26:24 +0000
Message-Id: <20260817222625.25A6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Document combining callchain-bearing AUX pause samples with the ETM
> branch history that precedes them, which is the pairing that
> context-sensitive PGO tools consume, and the --itrace=3DL64 decode with t=
he
> non-empty branch-stack dlfilter.
>=20
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787005265.gi=
t.aaupov@fb.com?part=3D5

