Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1A450404
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936843; cv=none; b=tZDqhZne8EiTxnatn4QKPglHblMQZ0A/g2WqwRCiJAlFhiazxM1lUQhI3M9AZ8I0/ksou4dr/xdyuVG1HlTYIKdyrJFpBz1AVvBE39gc4cVma7qRFFQqq0HkcLW6c2zsLAtE11WKnNrLPMZnbX88sM9/YYtaUZMD4/9HaqGWiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936843; c=relaxed/simple;
	bh=GLCvVXOQevikeeed3jVr9EwksJ31imp7WnvCJU7IJhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hxO3DdryNN60+Fv6/mzYq53HlV36yJ8rztJQR7iiJF+ahzsLUXv73dmCIR6Q7UAFk1at9u3UAGmDcqgJF9FGIns21kq8r0V9WIRH07XKmMOWgb4wF/a6TX1YL4FPPwg3xi3eGKrblapMUa9zwpQg3HLZog9jT0hfKSCJ1pJmSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOT3iuAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOT3iuAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FD71F000FF;
	Fri,  2 Oct 2026 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936841;
	bh=GLCvVXOQevikeeed3jVr9EwksJ31imp7WnvCJU7IJhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dOT3iuApainLI0DUMpWW4dzXnPIii13z6yj0OOXEkAEEuAaykem7Gdt6NIKbvdXDS
	 Z2WmFmDAnZOSFqDsdLx/WrZDQ3nwE+qTKDzRMDLS/KN5KhiX0HGC89/NWASFm6TGwt
	 KdLW9AxzHRvHvb9KvEhXU5HAFcH2kT0AbrXZgDrtH0WjOwUSftUdhcfng4QLh+kCXs
	 zIfbr5xIfQ92MNKTVpeASvumk2ydJuKkRNsoh9p7wczeNcyNWtjF3YFzGHG+yO6iEF
	 5tNnWiKKYWxfSKOaSXgdGafeXqG8hUS36XFcI+4ZJzdBpNMK/ezcMT7Izbk19eTsp7
	 E5zlP/4MdQtjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/9] perf mutex: Add DEFINE_MUTEX() static
 initializer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-4-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:27:21 +0000
Message-Id: <20261002102721.B8FD71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For file scope mutexes, so that they don't need a constructor function
> to initialize them at startup, mirroring PTHREAD_MUTEX_INITIALIZER
> while keeping the clang -Wthread-safety annotations of struct mutex.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D3

