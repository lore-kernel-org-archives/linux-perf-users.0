Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93633F484B
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228664; cv=none; b=cfvYJ/sd7W9s3Pzb73ULzcN7DZPgI7lin5s8y3MXBT1euSm9chDlrTqxQMs8MsHVKiO673pIbR/nwKm2yftrSasToCwPxAPbiB9viLe7y4HSA/HSdKMa955By6Ti94ndBH/X7NGkaNck8kodqVeYb9CRln1nPT0wjV4QvcVxJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228664; c=relaxed/simple;
	bh=DTss2Yr8R7WKPU4ry6OFiirR9PB+5OIfsfXieoXjD4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gR7w3U58kTW6+Gc0b8IggkUnh0cTvlTgbOzS8GlOkenk7lvk6HSJityZ4b5z+G4MLTXH54zrJUa/0DDw1u5uiW+DidO31FCaVP3qDIkZnfQHOojMzIkw/4gdffOIjUktw1BZDddorCJ12i29N2imPgMdFQVW5K53uBrMYxw2KTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DikigZ4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DikigZ4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A7B1F000FF;
	Thu, 24 Sep 2026 05:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228663;
	bh=Rzn9X8YCr9mcHOgYZSCkx6LbxMTASEyANPEZHXqQ7LU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DikigZ4XBDjWKyOrrkZnUSfE52Q0RtLrq7umjQUwwy2eKv02yM5VgR7k6LwHCSDxx
	 O32IXZn95jUP/h3GXIwadVp1ArlWvkjyFpDeW4E6Z8+B3QC1t2dXy18/z6b/C5cSuV
	 4AC4m/PVxbdb140bQ5oCKFYuDrAOQzhXE0DaiXRdDmJolw61Nf5r4VEpBNG3mj3RZw
	 FQmMXoccLB8fEH+tAx0SY9sEsFzX8WEK9PvfQ+0qPxnaFdLx9ZJtw6QqGLKULAjgYP
	 v1TahbdE/yzlXPS25vxwIAczwG5RQVkXnxpBYZBcMv+l+tnbROgHLhIpBbf8lraB6X
	 SC7sYt0svoR3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/21] perf vendor events intel: Update cascadelakex
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-6-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:44:22 +0000
Message-Id: <20260924054423.24A7B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated TMA metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D5

