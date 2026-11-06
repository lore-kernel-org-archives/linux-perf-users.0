Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962644;
	b=nlVQ2ziDuhOj79uht5VWU8AP2BJDE2imzNQQ3+egvt1PCk1mvYBQQDh/8xc/85lxP2My
	 jlyUPEW9yxI+JOi2/NMDvWX/LBNtJ+h9yiTE8riNIAuiF5OQOTvmU37S+5esL4LQDmtFK
	 UdkkNl2c267dcI8ngakVU9v4e5yvLemMxzHbTbMQYg6yAR4OdksiOejQb5C9s3fnL2+5Q
	 t//g00NNhbtFyxL5QQc8/Ru6SupFFq08jGVIrHLehqi3HFwmpMhI1/WGTYagv0hBruDoO
	 gUhPNXR93TqtKw3jX2M34Jg0nXIEPG04s4eLFfvO/SMIP7N3lghIvkqn4M1MHRIBq2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OsVHSrqIi6Jw8yNGoiVsqbgA1aLLrjYGf399gywruL4=;
	b=IIUYz+pbIYiJsWBX29zLCCJBQjC9ycI6G+FGrK2rF8Ervs9qEijIf+Crpbx1Mvwd2AMG
	 Mu5D5Cw9qv7BdrnvkA/F7Aoh1Veb/Ped5Pinbq+ij+RGk7dxxlPhQQ74+VbBKvqedMKSm
	 3GLI9uwbmtUUtkFwAIKY1x4Q5ebbSIArsjJI8XnZgjt9EqyIpyH1/JTy2tQWRhTOGQYCu
	 6uUqR4oPzFX8WcHv5grn+fJ8Lb9uP841K1yBS2br3dDKHldFDfYoGXMi0UyH06FyCA9Jd
	 kAmhRTTKFN9XUioiwFMKXr8xG/Cst28De7I+CzkUnLfb1wMgGIiSWVS/s6OmGND5+lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3mpIMJi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFAE606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3mpIMJi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953951F0089F;
	Fri,  6 Nov 2026 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962643;
	bh=OsVHSrqIi6Jw8yNGoiVsqbgA1aLLrjYGf399gywruL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3mpIMJieb7OnWyFGdu70oRXcHlnA0RIwMJNZcLnaooUKQE5FgidsHmO7j2GAt4kV
	 R+telnIEWUi0qybq7MdEZBaOpGL7d3HRfB7ATj+N9712FZnihcQ2eBmGc9L2uSGx6G
	 CdU3xyQgkvUsi3mzj2vzUUU3fCYq0/ARmbE4Tda0s6dFAs3qUB3hjUf9wQ7JXewk3U
	 kJvjFntY2ABUX3ibDhrTgnTTfB6M5nw5/dFETaiXqaSeycE3uDUpD+m2dFj6UJCU+b
	 jBk2u2OECYWMTEIeQm/NJCu8DURrdnDCfMHm9PlfSQp+bSy4+IdsrOUQQl16ywZmfm
	 Wy1UD1BxtasMQ==
Message-ID: <sashiko-outbox-201257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf libdw: Find the CU by iterating all CUs
 when aranges are missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106-james-perf-test-fixes-v2-1-9a912662f822@linaro.org>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
 <20261106-james-perf-test-fixes-v2-1-9a912662f822@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:57:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> libdw__addr2line() finds the CU with dwfl_module_getsrc() and
> dwfl_module_addrdie(), which use dwarf_getaranges(). In elfutils 0.190
> this only reads .debug_aranges, which can be partial. For example, when
> Perf is built with LLVM=3D1, clang doesn't emit .debug_aranges by default
> so the lookup then fails and no source lines are found for most of the
> Perf binary.
>=20
> This used to be hidden by falling back to the next addr2line style, but
> now missing information stops the fallback since commit (62d7cdc8d587
> "perf libdw: Optimize fallback logic for missing DWARF").
>=20
> find_cu_die() in annotate-data.c already handles partial aranges by
> iterating all CUs in .debug_info and checking them with dwarf_haspc().
> Move it to dwarf-aux.c, then look up the line in that CU with
> dwarf_getsrc_die() and use the same CU for unwinding inlines. While
> [ ... ]
>   ---- end(-1) ----
>    79: test addr2line inline unwinding : FAILED!
>=20
> Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-james-perf=
-test-fixes-v2-0-9a912662f822@linaro.org?part=3D1

