Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942274;
	b=3AUSLQGsTsZ2ELuKk9u6g8NSr41CsgFg7ZkKjCNt84p7Rc6PLS2kOrAKqSUnZT824s05
	 iDk9k2Ug5KCCWNRtPBKb23ZUCuytnzVZPj3Vflb1fo/UML+uu6zTOtqy4eglUm86LY2Wa
	 wlUXQvWoUOnMay91t/mkPMxXtDAVvzLo2L2a91pIcUsrlU3XEDWifF+6S4FztTxhAwLY2
	 J0mr2tTZWt0fJMQlPamDorcDGZFqamCnE5G5JIVtdBEQZQWS4AvqLvMJSo7Cfm+VIaKw+
	 9GQAaTKxyWIJ8w11kcuh8UIJJsZ6QttLzUalB2fmQllJmlqR/OY9vcILkHeO6k3MX5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NFSJ9NYhYA4NX2x2SYS23L83g95j7y9yh/pYjXP3o4s=;
	b=yYcVn1buWcz5mCZrCNpfdCMBuh47zyjRvf2HLM1PmU1Wy64E7hKFXx8x/L/n95O4CznJ
	 7rtzQbK4XHLG/1CZpmsxlNk1slFCrccTQbPxSkb6Eks6QTqbYp3rM6aoYDBP9ceVQV7Zy
	 i9kxGEaeIJhLsBxgIS5kY5cFH7D0kv5Y92x4NKceyH0/XOEa3mrcohcl48HXvAJZGd3GS
	 X4gimWiANQecoI6sFc10wgevCJR+pQEd9Xem5QiKuNShMdiu80a6mohwnutxSZc3L+Knk
	 uKr8sPPKyCZu2XFrlFZt5m9hIDepoeta3B4hbQh0Fez5gUxx0cyightlMhIqSl9Rvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4Zppj5k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E388606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4Zppj5k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A71F0089F;
	Fri,  6 Nov 2026 05:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793942274;
	bh=NFSJ9NYhYA4NX2x2SYS23L83g95j7y9yh/pYjXP3o4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H4Zppj5kM89uZtt2KFqXM9AGP33Lvr2GSNg/Kn6n9wTPbuB+3r7Gw+pxZGSa7F++r
	 kramcyTgvJTjvSfUd9xZdP3qbHuIAVupCMC0QWPWzi85tWvUVwLUCb8dlflDFgl/wr
	 X4xTgsy0PcDcxXsHImMUobno/WlC7iLsNSpHBxgOKbELQZV+LZhtXNtKUJz6884AU1
	 7tvrWqBfsZb04GlG/MMiXpeScgMtvtvtHvxgb/m+2/fr42XiQol3N/NrSXWSlArS+L
	 xrbomWdb9umdcQGL+Ico6phd6PUMdyVuHoHOHQuIC95it4+bvV0Q7qee95YLKNmKjA
	 0h2z9N6Z3s7rA==
Message-ID: <sashiko-outbox-200810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 20/20] perf/core: Don't overwrite shared LBR stack
 depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-21-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-21-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:17:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_sample_save_brstack() currently clamps the shared LBR stack depth
> to min(event->attr.sample_max_stack, brs->nr). This is unsafe because
> the global LBR stack is shared across all LBR events, and a small
> sample_max_stack from one event can shrink the depth for all others in
> the same PMI.
>=20
> As a result, later events may output a shorter LBR stack than requested
> even when they do not require a small sample depth. Do not overwrite the
> shared LBR stack depth in perf_sample_save_brstack(); instead, keep the
> per-event limit in a local variable so each event is constrained
> independently without mutating global state.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: c53e14f1ea4a ("perf: Extend per event callchain limit to branch st=
ack")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D20

