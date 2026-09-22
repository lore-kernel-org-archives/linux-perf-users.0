Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3C37105A
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040322; cv=none; b=MfF4ZS7vxQSjDQ2P6bFsUjj7sG0hFxQvgEPWjfd4o6TQRTkdPITQn05DbpnH48+g+TUsdKAurbrog5Axjbb70VabnnmaSgPpRkj/eo3+eWj4d54Jovj1nHPhC33lhyhr6wP8ph9WmjzVKyEzsm95v9erHD1eByWVKcykH/xYeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040322; c=relaxed/simple;
	bh=ySnylgscbugMWs1K57N+TIPhe7boY7ERBcCwe82tku8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HLlyAnMNLMLo8Ff3Ty7sCe8m+TFl0HzVcWzwfW63Rj0wz1MYm008PCfCD9kNHKhYUPGU1uQS5cDJO7Zqq4Bq+dZS44iWle31wRmzUT+77JQapgCxlFQt9kLRgkvxtg9NOe9fFfjGp2akZOU5JAwJBlG/1yntGC/gn1G+q5XSib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUJZUTrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUJZUTrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21521F000FF;
	Tue, 22 Sep 2026 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040320;
	bh=ySnylgscbugMWs1K57N+TIPhe7boY7ERBcCwe82tku8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUJZUTrdp5FTEJr9cLYs1YklJsYkMi4CDDRallFyy/JDCb9DjJJF/liNS1jcQoYZT
	 x9V7DRvY6E08gIuUefoblkNEs5QAZFPf5ZnQjJyYKtTEriOU8ZqQqXMSvRDN85wIsB
	 L9bz3liyvYms/DhanZGuBs0ZLXg79jbuTpNjF/3UmyzDEi7kIdKaPlJ3dfrE/ELHGm
	 s9i5NCxqzZFV9rkKFhxFw3wwGu0wQfAliw4DF08aDEnDnS5bSPjt9iiNee84AcmKbA
	 VEyWytmnfHe4zZoV60CeOvl6gO1mqbUaasxPae9PIXjQZ/7C9XzVDm/EAur3GJ2N0B
	 PocB7+jLe9f4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf/core: install the guest callbacks before the
 guest_state gate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921-mb-perf-core-v1-2-ac56a719c02b@vt.edu>
References: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
 <20260921-mb-perf-core-v1-2-ac56a719c02b@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:25:20 +0000
Message-Id: <20260922012520.B21521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Jaidev Shastri <jaidevshastri@vt.edu>
>=20
> perf_register_guest_info_callbacks() updates the __perf_guest_state
> static call first and __perf_guest_get_ip and the interrupt handlers
> afterwards. perf_instruction_pointer() and perf_misc_flags() test
> perf_guest_state() and then call perf_guest_get_ip().
>=20
> Without CONFIG_HAVE_STATIC_CALL, which arm64 selects only under CFI, a
> static call is a plain load of key->func. A PMI on another CPU can then
> see the new state callback while get_ip still resolves to the RET0
> default, and report an instruction pointer of zero for a guest sample.
>=20
> Install the callees first and the gate last, separated by smp_wmb(). The
> reader keeps its control dependency.
>=20
> Found with MBCheck, a static herd7-based memory consistency checker.
>=20
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-perf-co=
re-v1-0-ac56a719c02b@vt.edu?part=3D2

