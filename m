Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B739184B
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263487; cv=none; b=JAf92eETYG5rxvMSbYhycd6Upg8cGNUO0cDOXxq1MfjCaGNONWe4uSvhhW7PL5SqWRm+oWMoZeuD5KSV693xhM9pQB/Wjh0dQg8kJ0yqTn2by227T02kUZUNKAPsbDGmbP9V1FPr1wTMby62HVpY5pSqluglpdQmcO0uTmJ4Nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263487; c=relaxed/simple;
	bh=ZBUSG9idGAIbtOP5OsdUArPIqv6c8IwYaIDTEv8ohYA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=spqXMCt+IqzUM94O1cbDh8GilvRVfbOm+CRe/0Lhby6U6QL0mOuKyGmGUxcEzZphgudEgOcB8oWLvWQXHYabPaCctYifOTLyYl9gqYQbsGitFPkCZrFLBmTd/ThZshQHbVgmzM5Xlj+F3v/Xu6cn8zwvfHIAVpT/e8FpqGLt/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU5QRxsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU5QRxsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F1F1F000C4;
	Sat, 17 Oct 2026 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263485;
	bh=ZBUSG9idGAIbtOP5OsdUArPIqv6c8IwYaIDTEv8ohYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XU5QRxslrU2oXRUgW4ZPcXgG69NechI2AO9ABz2VuV7Ue1Hw/bTDSPsoU7KFfudom
	 KDzeZGNGkx0Isu72f+LhtVTZi7vyksAyE3w9rcNd5lYb/m3hIf9y76VnbUccG1bX9e
	 kE8jPbvPPeDAfk8g8VG+F1bV0zrkgGYHYFQuAPGUjC7cKKmyrPD/ZIJpw0/W/3HpC5
	 y5xbtXH9CCiJkbEtrOXcwSe0PR7sfjzghME6pwHfKpmR1icGF5IZnvM/9CuH9gjLzh
	 ebF0puCG8hJy41+eIaQOoF0K9IMEwforu75YbbcfDCaVzEY/OEFZ35PMz1tGI3ZUOv
	 W4zS4Ooe6/Yzw==
Message-ID: <sashiko-outbox-175768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/9] perf mem-events: Expose PMU init and name
 formatting helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-5-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:58:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Export perf_pmu__mem_events_init_pmu() and perf_pmu__mem_events_name()
> so callers can initialize and format per-PMU memory profiling events.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D4

