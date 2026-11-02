Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606730;
	b=L9Ies6TFnaY30P7agER353rLSi/OaEcUK0qvJ8xUUw2YtY6moRk/ZPYUErhBsrBTy71+
	 Yau1omPVr4VaTPOFObdaGH1rYMSfWHcvnarZb9ov6rUe+/KECUgpn7I+BdgJc/B07fF/o
	 PKPETuR58ZihLPxvqeoOSUyNmYdwjlZ8c4sZMQHEEAU+NJmQuT8zsGxlwAaqMPZXMUd1S
	 Yf8i/7n3S6V93uMVwtfy6ZGWdSKPlYZy0CUUYh6ki1wDMNooh3g9WgdqPTsgmGkU+Sc7w
	 cye13PtXqI1RTROKRM9yvjSHzdqkHOD9wnxHfxl0H67YKiSPyi72bmY+TIeJBqK7WZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606730;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f8tivY+kihNZjwodlbKp9h20a/S7qXgwZ0Aq2zrldIs=;
	b=prLnC+GLNe7FRkv+zNafnCCRaKiVruMVZjgPEj8YVLpWTccS4MkHKx9eIaWSC7mb1XiL
	 cjWRy1mD4tKNULAiBt0h65Ry0zodu7kjsgQHpNLd8JyFGdj9CKIFYyVGVQrpmZWHc2TDP
	 ID9gQu9/aUuqltb2qKvzggryUlLXaRqIFZoTHhtaUQgjywYAQbQNS2+Dd02ot+J7l/lPt
	 z2x8JIe7wv9SkPTX5n4kw4bwjy5uv0AWWbxatf7uoDpcrBEEtCgyrHkxFfJYNIGD92eG4
	 Ik8sI0/CUqjEiprwNvGO0flddsDFO1p+G1DkyTc+U5NbbBH7Q1InD8/9CSmxe1KkkEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNT6m7HA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B03606A32E
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNT6m7HA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E7E1F000C1;
	Mon,  2 Nov 2026 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606729;
	bh=f8tivY+kihNZjwodlbKp9h20a/S7qXgwZ0Aq2zrldIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XNT6m7HAb8mZG3lcJXfFd2LLlYP1yBT59J9RxtgNPvfntIRY+jI+ch0AVdch25PTZ
	 q7NGJsF43MpkO4yzmrS3bbTTJKSW9fIhhFoxqr91BfZuw8yYeKdW/0ildPdhCKkAtd
	 zx4oxIt/VsN57+360Cg6j8BbaQX3ozSvLyaGH6+DKMh8+8CQ3AWvXgQFzfNBU1JtUR
	 OUL2mf6gP/8ylwpZ8ITl8V/YvaktGjHilXOWxHq91QeCxbNyQuMeC3rRnN2lPKlWYw
	 fBNsF6J61ZGl6C1PEDmmTvstVckQaZnklqD6aim0bqeeFuknRN73Be8CFS2H1Zkph1
	 Y7q40+q9BYBUQ==
Message-ID: <sashiko-outbox-193074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102074039.26983-4-adrian.hunter@intel.com>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:05:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Intel PT tracing can survive a shutdown sequence and continue into a
> kexec'ed kernel.
>=20
> The perf reboot notifier removes only per-CPU events, so per-task
> events can remain active, for example:
>=20
>         perf record -e intel_pt// -- kexec -e
>=20
> Tracing can also remain enabled on CPUs running traced tasks when
> stop_other_cpus() halts them.  On systems where Intel PT is unavailable
> in VMX operation (IA32_VMX_MISC[14] =3D 0), VMXOFF during KVM shutdown can
> re-enable TraceEn via intel_pt_handle_vmx(0) if a tracing event is
> still active.
>=20
> As a result, the new kernel may inherit TraceEn set and Intel PT can
> [ ... ]
> 	dmesg | grep -i 'PT is enabled at boot time'
> 	[    2.065889] pt: PT is enabled at boot time, doing nothing
>=20
> Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102074039.2698=
3-1-adrian.hunter@intel.com?part=3D3

