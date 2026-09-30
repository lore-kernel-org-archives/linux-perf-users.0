Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA73F20EC
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805139; cv=none; b=SvL/T4GNq0U4CafCV/UXh4tB1QhxQS7IoHfj/76HJIMoCWjKVrwXRwmLbJIVyJmzm9Q97M9k93QYLWyt+45+5eS0B13H5Eh2sAaVC8JMQmsfvKeeHhDVrm8FTzrFCVISYrKiBKw4CfcNlnqs6wxthyaxf9bEFBrOPsSuru8PW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805139; c=relaxed/simple;
	bh=n3WO1BD/gMkVYhI0rgWrwSR71it5gcgeITrWTXis0Fs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DBH2d8BHIfbHqNA3PJJstH1EXdRX2/gHmLW1y91XoqTXbU3DtU64xQN1verzKG+hY31mM9MVHDNYEJPy4C81zJMzdBLjQCo69o6UWOQ+14X4kBThI4GBNRExtqtiU65Fxm/TBzdU/ZdFFjzDnvZc3/ZPBY0FbHbNykDr9e0NEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRT7kFeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRT7kFeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581D21F000FF;
	Wed, 30 Sep 2026 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805138;
	bh=AhuAZpRjZo3YhtPcyXdmiy4Ifu3AJ4ndudK2I0/xuAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oRT7kFehq5986joYfDpIFtvOqn1ZEtaGLyki2KRBv+oUlfFjyCuXl2kZgriqJl8iZ
	 ESxo+sD423JQJ2Ejyv6DfLbB/9SdiW9RoChSXNHdleq6UWcUKBXjsF3q3oGoAJDK9I
	 /+2Auhuyymsmca3ZOZFtmlTm2dFYlB2zQVDPQ/rSqzsK9ctFtv0WA7ATKZ5HTeL5rr
	 TGLIXGZ9ch89OWMTNrcmQsYpE9bgH+AbCdLJDrpRwwNlLurrOyeAjrsz5loSIPdHUG
	 eqLX91qBfsWJ0YxhUja3uNLdsAjsL+PsWqnqjFWpmu+/gedb7RW6+qeiugxQLhrREw
	 HEcqHiAim6ulg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930213716.2633750-3-acme@kernel.org>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:52:17 +0000
Message-Id: <20260930215218.581D21F000FF@smtp.kernel.org>
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
>   Processing events... [ 42.3%] 317M / 746M
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213716.2633=
750-1-acme@kernel.org?part=3D2

