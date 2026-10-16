Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065051DE1D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172507; cv=none; b=KcEaZMS1WT3tAviB7/elvU7kg1o2tlnQAPp2tGcILRq/a6VB1jFpCtuxFh/kT3SRgbehUEtdiPi0ZiU9lg0fuBhtMfkhNn1tB0Lq3QvYV8VL1i6nIezQH0LykFkE2KMO2DO1BmZV5Lo5iHkGAOx4UIpd7r5EiCrR0rwKTKkUYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172507; c=relaxed/simple;
	bh=mBJ1Vb6pdIQ2Ehvzw0X49ni9Wg3qpDRiX6BDbcDNnWw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g+DzdgoFN94QqmMQlpMW3AFJi/BYnb9fFr0oo5PmENe9iujALeVc7GmHUAGYXXTUfip/shWrYwJBriE2B6AzOqlBBqKjUgTZND+Tczp8UqWjH73/2AVFfMw8z2zJ/WEQPPrCump1myKm18i1SDkMHhuUdqMjicvl8ooTXGufpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE1WOh+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE1WOh+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FEC1F000C4;
	Fri, 16 Oct 2026 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172506;
	bh=mBJ1Vb6pdIQ2Ehvzw0X49ni9Wg3qpDRiX6BDbcDNnWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eE1WOh+XmeaQUCWDnIubJ7QpH4XJTjSnVcXBBQyR2geV7mGBm/uEJ/xfgwRsFoeLw
	 0yAfDo2Y4fbGy1djzbMQH0SbJrVA4naIRCMta8FYzUQRjml3DJhyQqQdRnITLl54ul
	 KnX6kW68Jyjl7o/ICHq2JeBd2X2wbpHX8nkbH8o3M6CvFfJ3IO25zKDIODXcI9uBQj
	 aOLo9aiQCPC+1yJ8ubJOlCAKHTGurryP0iCNjyyKN5J7RzLcn8N0oEQ36OlVuJ12oN
	 5hob4f+ftponb7pomC/aXiFzFIHnHaF1ByeeMOR2Y+bMz7azFHvKh7p6HvQp/HqnHY
	 5SC2xv+ogHaQA==
Message-ID: <sashiko-outbox-174735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/17] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-7-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:41:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D6

