Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30356420E7C;
	Mon, 14 Sep 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378786; cv=none; b=iI45PZygItsvw74nbAtIaKbotcwZNaWJMXCpGMPDEMS+kkAORI1JpHI/Iy81VaEA5SDri+D+HhWvfNhmbaPyphTWInU3Ag+TyJnbwFkYA/N4XKiESKduLHBYa7fiuSIUSzpmnHXKn02UcaeycOAdbVLkxTVGlqLnZnS6L/rOLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378786; c=relaxed/simple;
	bh=SZhUBWRxEDUOC90FtS3fxraJlCf4xG5NGSQ85WQEWsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qao82mYP+/B4ij9VIXE0x2h812/RkBS8EzbH+sOFYHlQD0NTlg7qxACUllcNl4XSNNm27eMUZnV1M0K2jr1wr8tvZYYoNUWpHIFFIr7iO2Q9itXcpRkgU6G+ge13J/o7F1yGI/86F6zOSnLSvMavuDw6lxgTdCiCDY0KV45XzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsEGdHYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsEGdHYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56711F0089B;
	Mon, 14 Sep 2026 09:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378785;
	bh=SZhUBWRxEDUOC90FtS3fxraJlCf4xG5NGSQ85WQEWsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsEGdHYjO3RUyfi7ZFLPVxPyrBYtQ821jHld3Z3LMUiTuPEohKAUZ5DLAIoifr3LN
	 g4fBzp79T34XPY2gTwZp7NE/K8ZvCiGk/MV924UTm3YeAQMNlKi5769SKnmMgRHkAH
	 fEPXoCRoK/sYCPwA6sQKvRE0fUKLZTyMxSarvsB3OWpU+KHUBq90GNZ1E9k+rBgjv4
	 aqyXXTjC8+EptEwNT6HiKH4Ql0doc5W1xgdMOTJTL5Qco2cMoyYpEv5tmOqPKnYwas
	 ciVXAtKrfUD5XIwTQNEeXJ0Kw0B7QR/+JCZthbQ5GqlXIFwsrnlJBR9G8QWyH9sj3t
	 BT5AEBOoPFftA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] riscv: stacktrace: switch to frame-pointer based
 unwinder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260914092648.51254-6-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:39:44 +0000
Message-Id: <20260914093944.E56711F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> Replace the open-coded frame-pointer walker in arch_stack_walk() with a
> robust kunwind state machine, modelled on arch/arm64/kernel/stacktrace.c
> and retargeted to the RISC-V {fp, ra} frame record convention. The new
> walker tracks stack bounds, consumes frame records monotonically,
> understands the metadata pt_regs records added in the previous frame
> record metadata patch, and recovers return addresses replaced by
> function graph tracing and kretprobes.
>=20
> This commit introduces arch_stack_walk_reliable() but does not yet
> select HAVE_RELIABLE_STACKTRACE; that is done in a follow-up Kconfig
> patch so this commit can be reviewed and bisected as a pure unwinder
> replacement. Until that Kconfig change lands, livepatch is not yet
> enabled and arch_stack_walk_reliable() has no in-tree caller.
> [ ... ]
> !CONFIG_FRAME_POINTER builds.
>=20
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092648.5125=
4-1-xueshuai@linux.alibaba.com?part=3D5

