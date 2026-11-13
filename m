Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588653;
	b=2xMbM0QjJhd+QAR0mY65OrQ4OiDHFv6OJHX+Iw0ce/IlyyHeVt999zmGC1HrdMZbO/2K
	 5i5YuIlm+4U8WVzlNfTnghewLOXGq1abYNsa0U6cOzRXYmEAbr/RZruBjPfD5yNtheid9
	 TMxiqB6epdgqLqEbCFceXCFFJh8IiHgDalANnng6b5CC4XLj7Gh5XO6oSman+jEvdqMq1
	 B/kOij8mUXtOMmisbk2si1fopEPwHduFoB+R70tDjJPEI4SFm8xDVPUCDnAozNKR2ukoC
	 CJvCdHxVVtiDftTBtnjd7U6VuZIFsUapUxUOeI4ZcOzgkwF/OXyAYvWC4RflwrSU/Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588653;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v9j8wbExjNGpjEjOtRsgowSLQlLtjPVL4rio7zT+V3s=;
	b=2Kt9EW+jkx2FHbclCwDoNoCk8+sEW9kfmYTxIPV7n1bWbHzFIa3+XHQFmKPJFp4DfVr6
	 +caFKAGw4oOCrqcgwcVBiaYnTD+5pU53pXHdclR15NmDVhEHD9M2zs9QnOrhY1Jz/fZt2
	 7CtIHwpOizczXQPTenYtUkFv2lezO7kRx5HhPOfdL/mcikN3ouBp+1yy5VzqStTJSUFcK
	 x/syDWc6XN86oP00nmQy+1uRYLoLl85Yy8dNDqwYU9REbK+J1d0McfMiIjAKD/VUbNcUJ
	 79Mztt3LByyDNdcQGYjMJqwqtSieKVsG99yJbaql1LxA9UhnDbQkgNeCluk0CDcNp5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgIBOjzG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57D606AFE6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgIBOjzG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F3A1F000C4;
	Fri, 13 Nov 2026 16:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588652;
	bh=v9j8wbExjNGpjEjOtRsgowSLQlLtjPVL4rio7zT+V3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OgIBOjzGGiZ0Ph9FfUmuFmazqtiY70UHHgrCD930yimNTyZ8ckGhaibdXMgUgyBgh
	 V+/14kinfWsNYewnlZaQp2kLaL1sQqWLWBt8n3Eukjk6JZbBLVLTqRWhd010IOq+X6
	 +0imO40Z72Qo6m4sigyeXrTVs1xeHjCVQ58sMTyFDAVhS4YG9NngjBRwTEw+c4PaQC
	 a1FmAGh/1HMo+9VppikZb9D29d8ZPGJk1BJRN3n5Nw0lPwGea2iwYuCjvlgBq6rPYv
	 Iphd3DK3MZS2cPjXz+9nYbLWmyHsHVWwbIV9X8WryBnQmdRtmDcsyhE9cNjoyZHroz
	 2GTeckIHdF0ag==
Message-ID: <sashiko-outbox-213235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/21] perf vdso: Fix unlocked __dsos__add() and
 race in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-8-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:50:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>=20
> Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D7

