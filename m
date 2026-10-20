Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507842;
	b=TxnhuNNyu81IJ5j21SgL34Ula4O8jlevQmCL1mszyOD9xBCQHwy1bc3v3up+FYrY+jNm
	 2sJyVMYpNxKaTkHjruk7/Dnqno8O8nG9MgJ3TUeeAVIBgWRmgWNQZY6x2heFzsBAXyPY9
	 RTiaFtVirJCdICmW0d/6rFCGzqABZr4r687CPExper92BzpXlCHgz5t/4XiEra0H6HUwG
	 cgovXKz9EepGY9Mlwr1Zp1j04o0Md7lvJp7tSOhH8HRKWApruao9s0N9FTtGhh4MXd9AW
	 te9KybioyWHTGu9mdwVNE1pWOvED25PnjG14k94frWM4oPR1qQ4RBJDa3mIoaxX6Syg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507842;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0lNZu9RnQ/LAIlXyikRcRXTYxuiKS//J60VvaWyqqTY=;
	b=gRETH0oaHi0CqcD7lXw/S7ZuCkrIC74ymXiw5yqF6rVFgdyrTDOqdICPoQ1KNopz4eQ6
	 ZyzmHkQflwgxYaqiyTBzmKMyy/7fSkBUhTMW2ide4IqJpQTNT/TLSg0qoBo3u5m01h6w5
	 Vxj1Dm0JGXCJgjBEW5H0CQ6YGn++q/FXtm8K8H46BZnZY7Kpl5inVWUBfTCRad0xTYdUO
	 kpVoS7/h4ZMnJt6AHis1UQkSWIQ7l/48adhr4h3HrYM/hbkIt4z1QdHEMDtbab4BadGg5
	 n+6wiIhxTjpW1sz4xD+vmBRkW/dGEnMI0RT6KSW21Cc8URD9E2pLqolQAacyhjFj4Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EC606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3301F000C8;
	Tue, 20 Oct 2026 14:50:41 +0000 (UTC)
Message-ID: <sashiko-outbox-179196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/15] perf annotate-x86: Delete stale stack state on
 store of untracked register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <60c5fe1ce61fb79c9506516221deb18aa728b4c5.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <60c5fe1ce61fb79c9506516221deb18aa728b4c5.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:50:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When a register without a tracked type is stored to a stack slot that
> previously held a valid type, the code currently performs an early return.
> This leaves the old type information intact in the stack state.
>=20
> As a result, a stale type bug occurs:
> 1. A tracked register is stored into a stack slot.
> 2. The register becomes untracked/invalid (e.g., across a function call).
> 3. The now-untracked register is stored into the same stack slot.
> 4. Subsequent loads from that slot erroneously pick up the old stale type
>    because the stack entry was never invalidated.
>=20
> Fix this by introducing delete_stack_state() to search and free a stack
> entry for a given offset. When storing an untracked or invalid source
> register into a stack location, call delete_stack_state() to delete the
> stale entry before returning.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D9

