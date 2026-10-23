Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783027;
	b=mLUjUzH2Kkv3k9F5wfcLr6m7lJjVW0uIFH+DmilQ+ezDKSYblYq4/yUOAgquRHi89XQp
	 pJJF0DKM93boHL7zJAQPAXmwwAekl+9/j7Mm9EPj/a1TLuHQm35lyIiSbFrRqB7ckbT/d
	 4Trnm5ZPDIZiVdcxTzY9EFBMN2O9F5xtipcXTANVWBba/LJyfd+/NdohyFgZjqoCb/nr8
	 FWWkR9MKbPCa+/WFy9zmh2U4nwXDdSz4MXHvcNV1Sjki4fL+PiyJ3aUzJACLohM/Rp51K
	 ucpg7Y+99A4QXUJKQu59DObCUjN1p64LxAAaS7dTsSRGllXurWK21l8cdVfaMTNrlwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K7WOzeVogpfxDJIRBCNsrxBRkIaW83m2xZwdrhYqAxo=;
	b=mtZlR0WcR9BEmLRmqWFsts7Ks7mFy13ktDxaQMOOr3cYU+IErGpLdugxf9BmO2LPRuAl
	 rW4UbLyceefo+9CjCmJyBsw+LaQtmpMR+6YfTF0TO2MKEvUfQn86SBI6lq/12bMCnSoeu
	 Nnow8iOex1b3XKYH9AvEams+LIHnW1fL5eA/VPrG8RzTpBxqZaIte1fhS++I/MQWLXTMn
	 +akBaUE+6goQIiZPFbsQgGXJzzUsC+vMcuvaGrqtowCai/XQ3pFyHMS1YHMap5bWXHXQP
	 xAiYbqY2pbLp8Gy6Qh5mFBwAJ21CVnxZbC4SDQuXmTuBItTTmmN1UNGykZ2G2iJasLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HY7QpmIf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE7606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HY7QpmIf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE721F01825;
	Fri, 23 Oct 2026 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783026;
	bh=K7WOzeVogpfxDJIRBCNsrxBRkIaW83m2xZwdrhYqAxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HY7QpmIfMpJi8EPlb4RkI6TBIKkLIMtRvzmULJCmaU/eY546Uv752Nao+Dn/GYZat
	 ybZDmivzAcNO9LqNq0z+PtNdTXdUDvdYeufYSQRyqblNTtK4k4fn47c9CuGAU+LCK9
	 bxT21WofoogHcCc0I6FehBwGToeSFyr2B4DZhea5dsxW+rDW87YuQGK1uxLPYSCjIf
	 t/sCej8ZidLUFXHyalBUYvR6/zOF7Oo7xLpsWL9uFVndg5H7CH1xu5YV/XQ6V6jMdy
	 1J4pgOgwT36hv+jzVx4OAdI457shk6AN/etkMGMcV8krdCYe8luwHu2JqcM9kyk2XT
	 eWqezHiFiJ4uA==
Message-ID: <sashiko-outbox-183102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/11] perf lock contention: Share common BPF and
 lock type definitions in lock_data.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-4-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:17:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Move lock_type_table, LCB_F_* flags, and the common BPF lock helpers
> (get_lock_owner, get_current_mmap_lock, get_current_siglock,
> get_lock_addr, check_lock_type, do_collect_zone_lock,
> do_collect_lock_syms, do_slab_cache_iter) and shared CO-RE structs into
> tools/perf/util/bpf_skel/lock_data.h and tools/perf/util/lock-contention.=
[ch]
> so they can be reused by BPF sample filtering.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D3

