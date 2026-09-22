Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E5279DCC
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040256; cv=none; b=megeHLn3qcCrrujCDuzafDX6DOlAd6UENZc9CS480PkFhgH70JV3P5bK2O5/f5iyc7jds5js6K42CbwAZoyCLozzLvtuhR24r81NAM0thcvsZnBJnizntwbFW54mOQpg2dARA2vffvlR1jrC411tV2wA9Am4m3LEEQTLnL0DPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040256; c=relaxed/simple;
	bh=FITjG8yZLg39sIOn0D6k3EdXX6PuJZhZKMLPJlrxwf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lC/STObZbniTevLmhx3Mi0OnSx09FjwLdifcw1xdJeX87wJe1YEzpesEqT21l921LDoFUp6ivrQl4DcTkQLdt0y1TDNIhC4oY3LfgbYnBgUyKYW/dsABqm03mKqnux4l5z2X5wXW/bCqJpj/BE1yjgS0Nul5Vz3VxLZt4Yw24RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNg/1p2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNg/1p2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C371F000FF;
	Tue, 22 Sep 2026 01:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040255;
	bh=FITjG8yZLg39sIOn0D6k3EdXX6PuJZhZKMLPJlrxwf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNg/1p2AwhWnUq0al022lvhfDF8MK83+Hlvp6JDkuGJ6otowbDv8ukdYx/jYgS2BU
	 NvIHoJmQgnVmNtfFDVAfDq0w4pR0Ys7mwcDH2/jhcPMevdLCjeE7ATJUHtX1xKjlHt
	 j28VYPtYitOYjkYzREt85trlHNiImLvgAQFzts5QGVfB/eQbdZalbWVGvtp3/vI5ta
	 byYA/n7Khhw5bAYdUqrS2wOI1hAZiXEvTd/6ty+DyQ6w5uABhDf0VNO9okUkqP0E1P
	 7KzgJ6YGYCsLiOtvCjBDpW8A6k8XtJiTz/8XzK9w38WuM+dQzAOFWFFJXCi0Jw3ccA
	 QRn3r0VjETbGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf/core: publish the aux_event link with release
 semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921-mb-perf-core-v1-1-ac56a719c02b@vt.edu>
References: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
 <20260921-mb-perf-core-v1-1-ac56a719c02b@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:24:14 +0000
Message-Id: <20260922012415.04C371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Jaidev Shastri <jaidevshastri@vt.edu>
>=20
> perf_get_aux_event() links an aux_output event to its group leader with
> a plain store to event->aux_event once the leader has been validated.
> perf_aux_output_begin() and the AUX sample path read the link with plain
> loads, from the PMU interrupt on the CPU the event is scheduled on.
>=20
> Store the link with smp_store_release() and read it with
> smp_load_acquire(), so that a reader that sees the link also sees the
> state of the leader it points at.
>=20
> Found with MBCheck, a static herd7-based memory consistency checker.
>=20
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-perf-co=
re-v1-0-ac56a719c02b@vt.edu?part=3D1

