Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946308;
	b=ciNJncqEO+L5Chk0s80gYlpUaXYgX7tiwEx5r+OWrhrpUzr5s4Ieay1Yx14WDn5X2F22
	 McgFRG05d6Y3wuCxzBWRemltrQ2VU5Win1NCPwVmicrOSuQgBoPZ/lr0q5KG6OhNDo0p3
	 b/tQHbq8NkS/LPR2LinnRJkYy0/MTsbr/9ufkZnj4HmaZgL+wCSbRJg7+8GPQkgKV9tPn
	 vyVUi+M0V0IdgxPFc/2HbekXK0xa4fhwGr4WQJKSdjmO91qMxCSlpfmXvEZmAjwbXsRXh
	 YOQTNXyK6ERNTOQJM1ysMHbC0wIcFoc/YtsBTSR4wBbuv4iGzlCKh4TE1xxNRPNv+TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RnCx4SaQzJAa8dV+rVEHFcQBDmv23jpy7RIMZ3ijFCc=;
	b=OX0TPOvXTeeFM1qr7qqNqmPMc6xfEjRLabgrX56L/On3Sd/TjcQxLzkZD0MFq00akb1/
	 KakyTu6VTms+FE4DC/W4isIcuj1vIE/PssgKfYOa7O7Dgm2/YhiEXcaE/Ht+DEHQtgriF
	 vghijHwctSFvsS62upISXGuzh77858hwV9XIwbXVFaHrhTfrGOfSD0bFz5Q7lt4NnY4ld
	 jubt6nCDEapoU5RWrs/i5/Bbhzg9AxLqK4mLAGrkrr4fJ7erGspNNZhAo8vH1rE5w9mWC
	 xiUUtWJmPvZGc3Rgsg5WuBBsjm6wVhuUokNim5616csmj5rD+6YtrMPiqY7JGlyjX3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKbd4520;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260D606A330
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKbd4520
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE81F000C6;
	Tue, 17 Nov 2026 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946308;
	bh=RnCx4SaQzJAa8dV+rVEHFcQBDmv23jpy7RIMZ3ijFCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKbd4520UTEc86Y6GZfO/eRY9CuTvr/7FPgjPP3n1lLT0zl092wnVzXnOpnCcQ15C
	 JTn3vRzoRSEkYSVxWDGl9LtF4c4cwfLuLNhLGwmI7u3b9B7IumjzLOahsLdQJiTDBi
	 qeqjO3W3sgCIeKLGgoRjIwrX/euIA24XTvhMh4NsGo/UIK9ok3ecX0Yzww4KdVvDWw
	 emMHIdKdKZwhfcXkHXpnf8XFqs93RYDa9ugt5VMivwxi8FTR8oZTCPOLNniiRHc4mt
	 louKPOysMT/2+EKB3Ipf1fFvHHQv3SEDDyV13DBb8NvAxjCAI/W/oOms8unHl0erSN
	 eUMYdbrxMK5xw==
Message-ID: <sashiko-outbox-219572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/13] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-6-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:11:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member; find_data_type()
> folds offsets past the struct modulo the element size back to the
> member's offset (+0x4 for char data[]).  The test skips on 32-bit PIE
> builds, which reach static globals relative to the GOT base register.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D5

