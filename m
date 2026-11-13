Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607237;
	b=lYjSLmuXeX4fxHZBDZjFHapHrOGlJ6WWFSuRXofKJzOuxubRB2gVBfXle+YOCf0T3zVk
	 Fp8Jv6TtbmUwt0kZ/l3I8iC1Wh4JYw7unyhQiuDJVdcrgw1RQ8Fg9R/AcZ0QkhhnHE/+O
	 LxRvw3xq8L44xsZBIvuAE1h+Hf6d+wyi3wsGV/krYAX/vIu6I5iu1PPI9EuTg8ZtKgtUH
	 /L5TETpPCd02hI/8mDeJwvyLjpN1iy/iiQEVoroiPRurY39ZHW+4UNfL0e6gOz23P2Nk+
	 752ZnIsIFQLlfZU3MRLZkuJd8oHD2sFydK/ciXi5BsxkysdizPJLm/kdGy9IpaoJNnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3WTTSZiPt0R2WLt7Wdul5LQmt65wiRq1W2ertLW7ji4=;
	b=uykFYOgmm9XpWWyWP11EGloUF6+3vrGVMpAKPzzefucUbXAws7q7YvidelHkPLS12WLF
	 eT+6vBSyJ1TeKOpOrhOWpsVrfA0N5bcYGG+R0gG8YWTRU7OgdyR34IifIBPNC15ROkVao
	 hBsFoY4+/P/UPLW9J3VCavQ6fzCxGnRN+dVsrzCTpicxWm0qVoJygCPb6ELDz/emrlZDo
	 CdbhPRaVQhro6xtz3XCd8ihEc71FWbZE/JM7fNRrakfknt68xA0fZItUyuez+w9/6RmDH
	 jROxMilRSSvyvc7UpKH50g9rPopEP/PiXwT5Pdm6XBlxKfDXQMUIr3bi4KOP6Aa+xJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1niROk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAB606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1niROk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEA61F000C5;
	Fri, 13 Nov 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607237;
	bh=3WTTSZiPt0R2WLt7Wdul5LQmt65wiRq1W2ertLW7ji4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1niROk0/nRlppXcw9zeuZtk+4F8r8IJFV7mOYsKU5ZIOc0OQtygvgTuBTqnNqvGD
	 RdUpr5aKnF16A+pZU/GOcxSmEGjVj7seYzML27kdzFbhUgmrOXIK1FB8TpetSLH639
	 SXJzpH2DTX90M8L2/MsZKEhAO/ch5Uu65zOX7BRJUUUOCvHyocjTtMx0HmeRkiEUXs
	 ZXeimzV9yh9IIlZrpeSphkVj2sw8Zad260obXeem2EToGZqaGD1J1MIWazW1dUKVPy
	 ILvcTGBy2tkU+/Ozjt2MWEBgSmmeim1JwmX2K/h7tcB9QpTmLifJcIMgWq7VRlWQo9
	 l9MeygO8dfcLA==
Message-ID: <sashiko-outbox-213763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 22/26] perf annotate-data: Use generic hashmap for
 type_hist samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-23-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:00:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert type_hist::samples in util/annotate-data.{c,h} and
> ui/browsers/annotate-data.c to
> DECLARE_HASHMAP(type_hist_map, int, struct type_hist_entry *).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D22

