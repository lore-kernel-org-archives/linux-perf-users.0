Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795590556;
	b=GCUGxqs5P9aLCfxJd8bwXNRys1F92FmO1D+s7uu/46pHzJ21iVsmBAmtMKH3QsGdapu6
	 eARqkddBfydPHre2IFaM+/CpEMWo5rLYUZkgD0ud8NNiUiRgBSmqPbA7/KxWnMd4drymh
	 JQESibCkKzQC0/W9tZnzgfv3kdDi09lvROARFqG8fv9q0qLx6DGTHsOJ2AYUn6H4egfz7
	 VI7WLVKCSz3H5KNrbxSmQqoXbCYuOOuv5dWy6jcMQ2MKTMTqAJ3whc+4wyQqJMCq6E1iI
	 GEUNqEkIFw3PgXcGtlPmmZtOgMLbv7mjRLaZoacUGxMCaaiZSEHLVqQ/M5JKG1niAYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590556;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P+Dr/3WIUqeFF9uIoSVXROgL8P7aOopEXoqyCKzoNuk=;
	b=V6e+7GaMd3dbQCBd/fg5PirLusLq/MHUth2ZyhIk0GXZLdR2Nt/VdOYexdrTZ7dDvPzl
	 2bpbsrP4YeS717JRpw7ZuVYNJpNZSYL/E+j9tyhBkCH61UFUwWouFYGJuXdL6qTpEeqky
	 CRc41RNcWoHxug2j6gEPmuihe0VX+izYAUtqQjNF6rEkysAkYnAqDM7gynQKVAdPalByb
	 NFeDyLyF9podlE6KtrtEDaIG6kdUsEWf7aP1DMtLAgGo+p/3CtOj9E68bbNt8hR/Hf7Bx
	 ioIAWsNRLF4lWfNuVRcg9WWDiMVzD1IfNNjwF0VBzFnxyCNVWf/Ps7xYIZgvr07I5Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwdSz8uM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89333606A33F
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwdSz8uM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0971F000C4;
	Wed, 25 Nov 2026 07:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795590556;
	bh=P+Dr/3WIUqeFF9uIoSVXROgL8P7aOopEXoqyCKzoNuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwdSz8uMQQGz24/yFG3/TURTvWWShwAwqQV1oz2lf69I/3XpbYxebQEWTINTKOdAG
	 abMkuDPdImiXHoGKU/NViBPsIHTZKzyCploDZukxz97gaDwCKfQWJRISuHHdZsdB4D
	 jzkrnSKYUDZdxXIpQx+nffO0NsdLPQB6zah9oIHteE0Xq120XcDXQJfLSI4yaalvye
	 ZmWv886JYVG/aNbdLEv7gYdpAXQDNyW+hkdvUuqGvHvy0NA+cTjCCSp0uwQmkAJe1Y
	 VQbvcjNCrHdXTRtYKdTsrMOqb7RBvh3hGs5olgmTI4WIBWgwVzNVgBSYBzNHIxAySM
	 JIwVANPV4ppDw==
Message-ID: <sashiko-outbox-232755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf/core: Add PERF_EVENT_STATE_ON to fix
 filtered event enabled time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <80d983c5713537f5743b69e9b35ced1177e4732e.1795589380.git.irogers@google.com>
References: <80d983c5713537f5743b69e9b35ced1177e4732e.1795589380.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:09:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/80d983c5713537f5743=
b69e9b35ced1177e4732e.1795589380.git.irogers@google.com
