Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B982FD696
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350979; cv=none; b=seg0b6wV/Cuyrb+XIisKQQPXU3EYzpbk+9JgkQ2rm1E4XO9UOPGEvRuxr1Ti3Gz5oGOgtbKv0AGjCMBO8u+Umls/iVglkoBoRPaF8CVSrkLqmURI4Yf2EuNDLMQZ5syE79pfoH6BjKnbvHOqf1NFWoU8TPPJPVNiMcZzqFZHiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350979; c=relaxed/simple;
	bh=z17Zns5P4zvcmmeHyXmUMi80dNtclnGCiBODMEJYavQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjTibrQ1n2e6J8ggZlbOg7dQIv7UMeZnDn9dNMQiKTFpGRqckAjKSglmCYRxLc2bqLxmGfduWLekdESHTXEDWkvXJ2ioLmlfFJ9MNBxpblWWDk2AsgtGQtDCEDKw9GpfKCK7Itvm5Vb4w4xX5+L8PmXCogDdQVBZhnBNaBLVLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVMySSH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVMySSH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E731F000FF;
	Mon, 14 Sep 2026 01:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350978;
	bh=KKmw/7kyC4Iv/I8Z3HYsm02hlt2/oy7NbRqP8vWrERM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVMySSH/82A7r0pMS0Ad+6vlX2XXDecLA5ad+IZUnV62t2Jhi5JIZkCAqHXvPrbNm
	 FGaMdhSuo3cLYwcnVNSjifCeKF0ZhcXZ5ORZN00ASkGpI/GKzW6IglOlwprCsNWucc
	 AUj/WiTM98Be+xlYGE8Fdcz/cFygxblbhL88H22loe6ykN2/E9CNu+tdSmUfVvqV9W
	 gr2anwIg6E9RrGEOCSnYb+febFRFGMT/mvQzDmrqYB1ptlFROOcNP9juigUNslasMJ
	 ZY8bU/GIq8BbJo1pjchKCxjYVxtjg03MfSYZLo50GA8KgTqvBI4PLd8lUO9nIdxNOQ
	 GLJCk3RDFfgNA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 08/10] perf dwarf-regs: Add SIMD/eGPRs support for
 x86 DWARF registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-9-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:56:17 +0000
Message-Id: <20260914015617.F2E731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enhance the x86-specific DWARF register handling by adding support for
> SIMD and eGPRs registers.
>=20
> This update is based on the "DWARF Register Number Mapping" table from
> the "System V Application Binary Interface AMD64 Architecture Processor
> Supplement" (version 1.0).
>=20
> Modifications include:
> - Updating the x86_64_regidx_table[] array to incorporate SIMD and eGPRs
>   registers.
> - Enhancing the __get_dwarf_regnum_for_perf_regnum_x86_64() function to
>   retrieve the DWARF register index for eGPRs.
>=20
> Since currently libdw doesn't support SIMD and APX eGPRs registers yet,
> still keep the original return value for get_libdw_frame_nregs() helper.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D8

