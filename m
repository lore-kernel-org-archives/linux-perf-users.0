Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569557;
	b=lfNU+6aL0IbbVxjbiwVp5AW/qIrkNNHV4IT01+Wh5s92WsH3OpwJmaO4DS/TEex1dekB
	 oo3Z0aBXSFCCG8GpEqrOWgnJum6Cq68d1tUQAhYZz1PddoXod2AVlUDjYHMWORvrBUISG
	 y02OOfHqRlUVSNSwnKDBPIVmItRegaTZ2iPtCWghe/LRFi7G368R3TTQEJ4FjtAPY2M4w
	 fKPT5/vu8XmWUeiGu+BlvvvrZMMRJtVwZcJPoX86zmlasHVMxxaTFcVzTYbDbIVumxW3l
	 /XBK7i6YVS1feX9b2RUml+O7O6/UCvpDwEyYV8n6G9VRBYhV0FEUAGLvKdYt4JOcg1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569557;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wsZfQH6ZZ16yKA1Rfs66zwRh9qdT8dGRXWiqgb5iG8g=;
	b=rLRz0Mse4kb8wpVLm1gi6wv0ylQnnP3ne7TBhgx/96SC2p1AwVn68HeOCIz4X66Shb5w
	 P+TfjQjTeO9uoDoGNvDs8cwqmGqHsgcfhcSNkbYV/EMHXhujnXHLF2fgL7+mwomLjpkAg
	 5JhWo77gtE17SyFTNQPY2W+CY6jTGAtDhzY5tIaiUS0iDQmrhIaqYSa2V6OSMC8ABjWPN
	 5YkquywB12hQjXLJM93Meriu3mL1Yb3A8R1JWuQvQjr40DiJ8yPf9I94iW0QvRB8nRtnS
	 dPGTO/WW+F0Bo0vQSGy0501xEO8mynRP+ER3UTioLwnNNjBdn7xQE9kVpfNymHTw6tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYagJ5PD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD386606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYagJ5PD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771BA1F000C0;
	Wed, 25 Nov 2026 01:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569557;
	bh=wsZfQH6ZZ16yKA1Rfs66zwRh9qdT8dGRXWiqgb5iG8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYagJ5PDzJj6i02KnoVfr92W+bB8MI0jEHFNQ398Hh0nohl3soSXWK45dqRFnQzfl
	 9LlmbxXGErS40q455a3wqPxaJENzvEL7KslZypZuj0SKoN+92M23nY2Zwp2XxnL+0i
	 mSI38YIvZfrWcppWfZukCJs99c9VGWiQdLfID9jTcqbzrBB4R/Rp/6nA5Th0Yb/jb9
	 F9Hi/mRCFTkmuf07ydhZplKAgYFkNgCJDursNReKHewmfNbQ839l876JXt67P5iDXU
	 +t91o1XS8SaQtjMESM7YskOFf/uftmFfyJ2pbzN2Ebgl6o5bS1pkSHBN4QrwQ7NEwc
	 9TgZmD5OYjZ0A==
Message-ID: <sashiko-outbox-232325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 00/19] perf/core, perf/tools: Add
 PERF_SAMPLE_BUILD_ID_OFFSET support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
References: <20261125005108.1020003-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:19:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 19-patch series:

- Patches 1-4, 6, 7, 9-15, 18, and 19: no issues found.
- Patch 5 ("perf/core: Implement BUILD_ID_OFFSET and CALLCHAIN_B..."): 3
  potential issues (1 High, 1 Medium, 1 Low)
- Patch 8 ("perf session: Avoid double byte-swapping re-parsed d..."): 1
  potential issue (1 Medium)
- Patch 16 ("perf inject: Add --sample-buildids to convert sample..."):
  2 potential issues (2 Medium)
- Patch 17 ("perf record: Add --buildid-offset option"): 1 potential
  issue (1 Low)

Detailed reviews have been sent as separate replies to patches 5, 8, 16,
and 17.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125005108.1020=
003-1-irogers@google.com
