Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214741;
	b=ViREitifRAlnaBjUxy40CwqKR1b6wQM1eTKYjH+csK/3WSAYC67k0IQCg83DkVNjzIYL
	 sS/4HJ6j3AEf2arZq+yZ1UPNMFdidGSiNgIHrXry5MkI47qnxCiZFJAhbRY31MEzWjjkW
	 Nfdbma0GCui7g9oNbeBpBtQqprF0eU7x/8FK1s+cMTqhnNpY3o3TnhStuoisY8TkKHmFE
	 ZjVXxAmJs+ReocMik6taIbUmVhN0k3rYKkQNfHJZ29OHzU35tZggKhhCCm2iLE9JKiv3Y
	 DIITqTNaMAnCdzgyTogeuyHj0LcBrfzswt4w+w8nQ5GzJepUiiazLZ4YmiZqi6XHuxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214741;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LQlyb23uvi+Nkt5ZowS5IDLpp8yCUUG6EZjggSv6PK0=;
	b=lG2amTRVGVxXq9TlHvxP6RNUbrG8nQvuU1UjYz/kwdlezE3H6+a081lKZDuwxRAVLWkr
	 l1XK/2r6+MQVOLgnaVy8gybNGrYxuBaosSoheyxyH7bf8w/hWihxv2xr6osG6X6BMKH8+
	 Gg1gjclVfBZh28Csjk0Qxn3SsJLoTwsR17b6cJYYHGVDEZ6zKuTxgElIhL3Ndueb3fT2r
	 Ze3ZpxVtbaCew1sxTghSfm8U3ONiXcT+RlG3Pba4e3AEedJNlokib+KMk9LK3JK2ES1OS
	 1o73AqGMOkyqWnLn0F1POTm/BW5FNKtZ2KhKCHx/zOABdd/VnW7vZnu8myugI1QkoyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3kKNZHl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E053606A68E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3kKNZHl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4C31F000CA;
	Fri, 20 Nov 2026 22:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214740;
	bh=LQlyb23uvi+Nkt5ZowS5IDLpp8yCUUG6EZjggSv6PK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W3kKNZHlEO7SZS/RUylAT+olpM0dLCpEzzRPOxSakX7uXgRNAGukkb4WDr9iQpXrq
	 87YM8D/LUY8zbWbSDTy26CKpZizQ0NXrixuc53KvrVov8aZVj+pzCmey7qWeR/dkmZ
	 CkbtqEH99wJQOJ/M7Lr1B/SPIfYmw/W3wm1NiMJ+XyoLrUEJFqyJEugXYLP9O7VUPD
	 FteNG2ksdC8JFICC82v9vqZPG99Mqmv+lyp1grvdTaI9AJuWKTTM04sRABTiSGaoP3
	 eOdCWrd3/aNl6SuoL2bcWW6CsLrlb8AdflkEniC4on5yTMpxoO8GVXplYtSOxprhz0
	 eceSL0KXzAumA==
Message-ID: <sashiko-outbox-226308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 00/16] perf sysinfo: Add subcommand to probe and
 summarize PMU capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
References: <20261120222615.2291168-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:45:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 16-patch series:

- Patches 1, 2, and 4-16: no issues found.
- Patch 3 ("perf pmu: Add perf_pmu__probe() for basic open, coun..."): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120222615.2291=
168-1-irogers@google.com
