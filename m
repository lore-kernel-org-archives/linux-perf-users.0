Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7E4CF49E
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195532; cv=none; b=Al3ppeZBGN+8IEH+SF8BWRWDE4exBQqAXBPw+29tCQ8kbGCVeVKMPqOLjHh5kKqWEQVIFhz4VoB/OOOdenarh8jjQOk0hUJ8sVu7wMVmBHVNZSnlB5MIUjVGcpa9EbfVhA8FkN5fVkJ0EF696DTTld0cKPQ88gbxsPrLPKLpbB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195532; c=relaxed/simple;
	bh=boZU0pb8YcsgvcSDb1vcpX+ke+fQeAfcriUSPnWFzEk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FaXgTDqLu2lwozz91XrHQZjAsk6Fu2hnCSQ+9TB9se+32LTCFyyIEI+xUGFfyan616A4es1ZA2Y3L8wH8UKEriSxwOzbToG4MDWsfGTCRQ8xHw4+1TUnLPZSNKsKt393YNbokzTDLzeIZ6SAnJ8I1EQf/GXgN5oKl/Rw8t8DyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHh8iO/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHh8iO/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390181F000C4;
	Sat, 17 Oct 2026 00:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195531;
	bh=boZU0pb8YcsgvcSDb1vcpX+ke+fQeAfcriUSPnWFzEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHh8iO/vQQcZQm5acnNIzemfhFB35AZXLWuGqC7t4rCmsSwCShd9/g9vJV4YcWBdx
	 dJoT+Pmb3SujkSgKThkaqHtStbf4XXGAAmg9TQatj6FMg9XOnK0W2YBpf286NCiuf8
	 oZLu4iGkMbb4gtnwq5xhaxiIWl3CcMQtBSeSJ1dgpPFetmrma/210rxWIYQ7oAP1oV
	 +cbDRow1NLrRnGF6XMhanXblm4/RJvmAEW+VI2P753LN2nrnGi2DlflrH2i31Yp1bK
	 oSjqmJUKvasvE5t62SWT6g3bS7Mu3wZRmPUHYHJR2WbnDEViSA0iJr3NGztHTHd53b
	 liTOrqB05me3Q==
Message-ID: <sashiko-outbox-175057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf dso: Move dso__read_build_id() from perf
 inject to dso.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017000158.1178269-2-thepacketgeek@gmail.com>
References: <20261017000158.1178269-1-thepacketgeek@gmail.com>
 <20261017000158.1178269-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 00:05:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> dso__read_build_id() reads a DSO's build-id from inside its mount
> namespace when it isn't known yet. The libdw unwinder is going to need
> it, so move it out of builtin-inject.c and make it available to the rest
> of perf.
>=20
> No functional change.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017000158.1178=
269-1-thepacketgeek@gmail.com?part=3D1

