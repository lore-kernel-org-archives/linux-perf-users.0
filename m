Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235204A92D1
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364568; cv=none; b=pFcV/g2iqd8fNwCj1161+A+gTDwdu13BqFb7gc/Fz9MvgYuaZskDq+DhNV9ExeEoyBqbw7B+fR/aZoKx3683nUUcIm+9GbfCv2sVNWriqmAhtYwmAp/9604jRel1r7wd+2LrJhT5Aa1zHdzibggd1KPMlsiN4xbOEyCvCuGTBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364568; c=relaxed/simple;
	bh=j4r3xRvoZL8avAypA9dgrj7hYo8EFbQTsOC1QGbeR60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bS5Iq/g2hv1RYLLBZjweU/dbGzRNJQ0oqj0+EpY1EKCq32us5mnq3A8oVmLKKSvJ0tDwz4MFLp433ZOTBrnTWyC4+ABFrexrIj0SB0JGWMcXshBNZU8PlJvbR0/ZkiGsDF/Lu+/jUEQoOdBcxiC+32kzFiVx82C/v1lpBwq3UQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGDhlOui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGDhlOui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7416F1F00A3A;
	Wed,  2 Sep 2026 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364566;
	bh=j4r3xRvoZL8avAypA9dgrj7hYo8EFbQTsOC1QGbeR60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGDhlOuiwSykblhquyg0nFcFIplWx0Ihbb+0gVgxjuJ/BbJErv8TPC9DqfeRX/7Qb
	 Qof5IvBnad8TsmjvRztZJgHLRSRQo117T0knoFOzIcdX+OJHZmJ5LCRyHYxk7CFRuw
	 hPbb6qrYhrmQ+k8kRgK6OmKuFjyemeBWJkTuYSmt+DeOQ4+TN6CieHm6zBKDBdXWte
	 joeXxJUHrVuLlPXQY3TnPHd9umac7vdyybo7T3srA78RDiGMtjC7Yl161rbLyZTfD2
	 Jjui+6964KjIN/VrZR/EMzooR/ND78SGIA7HKyEkMgJ7EPXUYA5nvfc+IXE5jz39yh
	 TD7nXAlNw4iKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] perf tool: Move usage strings and functions to
 perf.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902154858.2078885-5-irogers@google.com>
References: <20260902154858.2078885-1-irogers@google.com>
 <20260902154858.2078885-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:56:06 +0000
Message-Id: <20260902155606.7416F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The code is mostly used by perf.c with additional unused functionality
> such as function pointers derived from early git code. Moving it into
> perf.c directly reduces the code footprint, drops the util/util.h
> dependence from perf.c, and allows us to remove util/usage.c entirely.
>=20
> The string constants are exposed in builtin.h, as they are used
> in builtin-help.c.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154858.2078=
885-1-irogers@google.com?part=3D4

