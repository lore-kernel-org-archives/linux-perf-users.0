Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516A3B2D1D
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228789; cv=none; b=qH5E04LPpkDhdG7j0YK/+alq1lBdBW4XWKmIfOBrdmg/+oL6taazd58PQsnNJOrxtZm/jt00ED37w//hngq6ofhpM/NnmZJOh3noecSERM4fw7lqRt/KrfnEEZTcyetnmOHfcmVLsIvfwR4KBir6ZfNqs2xAW/SsDgjmymQxG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228789; c=relaxed/simple;
	bh=w6M36psbgc6t1Zk03x4MJVYjz0lfkhq0eXyJtaWp6hU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPQ9ISUuoMMFvbcPsXAPbLaenzgsHAjQci9mm9avZv8KP1E59/3CntoR6ydsOzvPAZPMG4hjIxH2I+mGnCAEikMefyrBFct2LynKBqfdTwL9nBTjMF8tq//q4zd8Cbebtilu+69nNFsV7Q4zZQMa1G5GSYjy6mv69H5M4VymV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgY6drWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgY6drWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E691F00893;
	Thu, 24 Sep 2026 05:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228786;
	bh=sPdrC80PyL6dMZgLkflfqr+dAWQeKWl/QSm0Er7YzsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UgY6drWn20+3+/y+nQ8NTGBk2xpV/e43rfzpHzO9n1+HyZFkZgQWYpJ0waFouulxU
	 G9jBzUemMua/sE91yi7Zbs9jOB3XvVW4RQv+DRWDEnbDx3+Q638ARy1bje9N60XqNc
	 6f7hbcy2ZktSwnO+P0YCi0Hwq2RKsYf6uwst2T4TNfTXHdktTyhjkZRi+dtl2fWvJZ
	 UELyPW7Bl4r0C4+RDkue7iuhHK7yZYdYRT2TOoRxX3VbXSfrPsNrCQUFeVsF8V/Wn8
	 TtEDEf4GoBrEf0M2HbHfENwAhpNgi4gr1lK/WaRV8FNmtcgLKpegSSceX4eOD0eBPr
	 9cR14vSbPbadg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 20/21] perf vendor events intel: Update skylake
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-21-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:46:26 +0000
Message-Id: <20260924054626.86E691F00893@smtp.kernel.org>
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
041-1-irogers@google.com?part=3D20

