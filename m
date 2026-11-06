Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941933;
	b=C6iv4MA7qfVvayjMDSnOAhOtJlRo/qZP8yafyAMy7wm4Gvqjs3pKGzOTY2RZiJiE/iPO
	 odhkxHvbDX/lGAB0kTOcJ+mFcacYm8cIaMnKZDBCsmrPCGITd/9SKhln3XJyi363v0Aug
	 MHvWvitG2yIhcioiV1qJeuLJQnY+bFULqj4De15JjH1qGUchrp3UZR9LyX6FchX26Z1aL
	 ytAtx8xAvJtU7wE1rU1EOJNIkKawfi/AsczwHYQOmKIDWM/DBk2SuVndodusDXtZmlJ8Z
	 bAJcihBf8NWM7R9SZ+L0HkzBy7avKhbFafEI+1gr3w4WlW59iMG9h2sxhFW6TW6WiMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941933;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2lNykqOtZlbeJcmXPNsMzN4u4D1Um65D0Z/MNt9hfRg=;
	b=o1CNkYpU1Ym9dALLdORJ6h64GTkEZuisR6hbJKkPpYfnUW4SylF29oNJLQTj17nzULW0
	 O4IUTTFOdcgElW/7zPpNBRjrLKGkMsDUMvN0kuhw6cjATrP8IqukixXxTeuJgnLVnUL5v
	 ZH6maMn70jvczYb2hbbqm/tDm78AmAoIm5aBEruL/sgjBblZaFIz8YVRmeunTQWqoFpPB
	 yv2V+RKi9WIpeztRqej7AP6sPDIgnj9QfulrrdM84dDgCEYeGRc1ye39qkJtD32C+m+R2
	 K+h9wtkqqQ6zTMZMJ4jkp9RRMf4feSAGijjChYPXFqN8/x/RDe36lU8ZHOe9YO1Gg0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrvcgDGs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71058606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrvcgDGs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58441F0089F;
	Fri,  6 Nov 2026 05:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941933;
	bh=2lNykqOtZlbeJcmXPNsMzN4u4D1Um65D0Z/MNt9hfRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrvcgDGslZMXGqVBKqDYBvYrIky/Uv7TKixKuQQy2W1Nur7fWAM1kYQcgNfEFHOG7
	 718Oj44opwi/KzGFe8+3khsDLMVtuFszJtFD6N6CY9qet+0NNirw6j4GZA9TYvOg9S
	 6Hl7TyAThSVgHjH6dFVxIa01u0ZROk/dslA9K00jCvPM4x6vLZqrBwdyOsOjwUn460
	 lSk9IEYdEg7aX4aH0JPX2TjxQFYB8cqMTO5KOXKakogL9qocc0ApAvMTlCyex/zHaf
	 b2kRqAI5okE/9SfCQAPt7t7j35y4ZmYyC3UcF/HYcgBUgDJuxNqS+aL3Lj8kmHurXS
	 QSNrTjCN1fAjA==
Message-ID: <sashiko-outbox-200802@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 19/20] perf/x86/intel: Pass LBR stack size into
 store_lbr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-20-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-20-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:12:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> intel_pmu_store_lbr() assumes the LBR stack always contains
> x86_pmu.lbr_nr entries, but arch-PEBS can use a smaller configured depth.
> This can result in out-of-bounds reads when the stack is shallower than
> the hardware maximum.
>=20
> Add a lbr_nr parameter to the helper so the code only processes the
> available entries and avoids overrunning the LBR buffer.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record=
 fragments")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D19

