Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127E4AB1A6
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269832; cv=none; b=Ba32osH0cY0XWUvNrrb/z1cLpPKCtfP+uxBQ3QzNKi2sYmTTG+UVe9LZGDJlSi3SeOWb3fxXRXWjjSj878JfDs/3QBbIamnqyHvss5MU/tSs4qhwRGeWBTo6dKxfbMNQpO0kafRp4KGAFSwe/ltx//oCNxS65AiZvM3QGCevlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269832; c=relaxed/simple;
	bh=wfj0NMNma8IKXGmTpzmJFhqO7ET9LdenjrTQdvcTOiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V737w3Fmv7SzI1LXEYt6Rhd8I2P+BkPzMIc4ghHgafJqZt9otdzSODyUvy83RUT3Woit8xbJUNZyiN4bY5YpqNkJhmHPmHH8UOB0ovcgLdPHMoIZLYnHsEJqG1gt2jcBiDLqRP9sZ21R/rcj0zfH23ff7QaSNkbovG/g9pFnFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn934DDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn934DDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A943E1F000FF;
	Thu, 24 Sep 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269830;
	bh=v4y8t6438RvCZ4skZcaueP884/O0j6MKakqHbMAm2nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gn934DDLiyn/5aII6G5lZxvS58z6pJPiorxPb6klfTaEVXUdhoqLH5r4zkzcWUCvR
	 ZE1rtuB1LicKoxix5YrW8JRD8gOzvTtNkk4Nw/N/StJIQsNV1jHn0izee08QP59bTJ
	 NM0lgqDCxZo1o4r3YGrYkk4Jl77oQbaUBvT+j6DXIE+C+3w1mh5Gk2uNGx2k1GdxXU
	 zeKm24NpYahwiy5fFn3Xo94BloKnbkgh4FlrdYZxLiQknA/wmMNw12n99oPfdI9kEJ
	 feLOhey+LdhPM+nhA1KL5+z0pW+Os3c1KK8cY+bcSkM7kNqoBOxJrQWzigBV5zu1Rf
	 HgoXxdkrqozNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/26] perf vendor events intel: Update emeraldrapids
 events from 1.24 to 1.25
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-7-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:10:30 +0000
Message-Id: <20260924171030.A943E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/0929815a4859319c27d2aa9099d3944=
0829c5d7a
>=20
> Fix UMaskExt encodings.
>=20
> Fixes: 8c994eff8fcf ("perf vendor events intel: Add emeraldrapids, update=
 sapphirerapids to v1.16")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D6

