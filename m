Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D613B52FA
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717294; cv=none; b=FX2am/+PHPznzJyXw7P3l1/GNmQeI063sFrSWa44RAbD6mvYAZGLxRZf6kXWyoye1wfARwzJD6BLFj1gw98uPr4E2vaCHiz6eUOCeuZxM9VMZ7QpV72nxRnyTcR9BZeJ30hIcd8kdYxQYXWoaNNJALIPglbLlOxRpUMcXe93UMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717294; c=relaxed/simple;
	bh=iUh33/G/dfff0tgxNIaSkRsSzY0tmrg43OIt+SWSmNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i5m5BHNo2XOjP1ebTuV/HR4UGLoK451SYt+xG7nle/yrhL9hIXp9RhgUHmqzTMcxovCrltZ6v9SP6PbXKk1cP6oxdN8cwyO4rED5pmKLsO/O0Ktub0WyaAvqijPoWIhVs1NKaf8713laO/jLe4f4xh1EL5hdryyLWBJPsVYCkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j43sRbBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j43sRbBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CD91F000FF;
	Tue, 29 Sep 2026 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790717292;
	bh=8LeMRbV2TPB7F77dBfrdYxs6S3YONbpUktC27JH020k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j43sRbBs3tJMyPA2uqcRDriIoUTl0NGeRxudr/0963cc7agOecBm6UnmsYNMiBmD4
	 g5EBXL3rx/EPqAkrX5QEhf5N0XV5w1XPZ/O/UXXAbR0p5iBk+ROLZfAhrmZnMzpjZP
	 fKaHS6+Um2x32MXaZqvaMv6Ag3EnmG2Lu8H8jMb5ftXh04YFNeSSrnxvVZiKV+FVtv
	 8/WFtzjL5NMF5S4/Zta/aY18PU7DvbR6oMFju6IeN6zv+VmTX6b6Hd+U5EbGnfxtLO
	 BU4kUo4mrLqyzfk++B1vCusyfO2EKSBCpgeOa4OHa9DJsk/UMId+uf4hm97UaFfnqV
	 iVDv50FEOsJIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929212246.2532021-3-acme@kernel.org>
References: <20260929212246.2532021-1-acme@kernel.org>
 <20260929212246.2532021-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 21:28:12 +0000
Message-Id: <20260929212812.79CD91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929212246.2532=
021-1-acme@kernel.org?part=3D2

