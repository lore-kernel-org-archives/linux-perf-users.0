Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973439;
	b=Z0tqe60+37zawO8NX1qEtDPMqPaVvVlkhECEgisYQERanIJUfLqK3aSkQZfRw3NTPj2X
	 Ru5sjz8dW3K7IR/KEVE9Hy5R5ZR/jqbH52tuZzb4T5HHNfKV8CjjDAVIyLVxpNTsDGclo
	 bqx9QwrnJqdk+vz9Zv1zIVDMc+g+j20SAignhYBbBX3x7yoK3MHLlt4/d1sSKZ3FDUoxf
	 +Lngm4MlKRFxpm8WJYfCYaSOUwhYiUX/+dA5qeY/1FVcK8fmH6x1xgK/Tc1Xh5e66g4E5
	 MkGTYtuhWg2LFMWxvRyEGLai3Y4cYUYWpII7K7BhPiJJKq/8azhm5sGV5a8ZdgDFcqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PlCcK/slcw5CHOKRnaGHtXaqiAE9f2iakyb1z18arQg=;
	b=Ly0HBKIVkKBEPmWZ+0eJtZ23EqIRgUbREVGvwSyfzvZ9F4CCkkYzZ8U2jHVnCI1uAyiD
	 OHReq5KiMBwTbVqQ3xN9sz6E86tZ1YaiJbva2cCdtzJjP3ua7MMfZyPjCZia3kwLc2wAz
	 hCyjiJeRJoDiftA36SZy0j9vKoXG5FueEGCaN4dmcnnXU47aN+/HxuYa1V0kEQyKpbhb/
	 sMhlHxsXxecJHDuuFU60DAzLIRVuGb4FTZywACkYa+yYY+nY9QCQSJH2tESXxbKcJ3Q08
	 H7DbOWXRs4Pg4ZJW2myVJK6dZj8AImMp2n2bAt6e6aN1B7MLyGu055xtWikxJk3aRMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Db41ypyJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44026606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Db41ypyJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3731F000C4;
	Wed, 18 Nov 2026 03:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973438;
	bh=PlCcK/slcw5CHOKRnaGHtXaqiAE9f2iakyb1z18arQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Db41ypyJhfi98n89t9DnzsXjgTZL/WCCpsiaXjQ4a1t1ddcpy/fy2aeCZnJx2tfAg
	 /cVkbNvyWb4gPrXgBcdaWmhGRsPazcHAd435lBXuTttsik6a/zK3QJXROh+u3j/Ngk
	 VIZYjK+8EFc610LZBe0By4XoGKVDS3ZMTlfn2lXRz4t7kuWQMTZJWMNZi2d/bpwjKV
	 VqJdo5jsgmZGuEtv03iu9V8FMOi+qZokW81RfnXtqJhrxiP/Ljh7+zeEYT5bEooLyh
	 VXlupob49nVAgVZOOeiKBl4r1Biio7XMnJunGAucFriqjYpNv/7Mh8L1wkWfyB9qhm
	 xfttMf3s8doGw==
Message-ID: <sashiko-outbox-220038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 12/24] perf/x86/intel: Use a dedicated LBR stack for
 BPF snapshotting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-13-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:43:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> BPF LBR snapshotting currently reuses the default LBR stack
> (cpuc->__lbr_stack) when storing sampled data. This is unsafe when the
> BPF helper runs in PMI context via bpf_overflow_handler(): it can
> overwrite the cached LBR state for active PEBS LBR events, causing
> incorrect LBR data to be reported to userspace. When the PEBS and BPF
> stacks have different depths, this can also lead to out-of-bounds reads
> when the LBR stack is later exported.
>=20
> Use a dedicated LBR stack for BPF snapshotting so the BPF path no
> longer clobbers the shared LBR state used by other perf events.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D12

