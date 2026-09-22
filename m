Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF033F59A
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080609; cv=none; b=TpHZfH2+zyfTrOzu6sU1X6rbPQ6F6FBxzlN1iMX/Odp202Vh6L1L4R9CHHl1k42IZQhl4OUpLp+w2xSFjij8/nQEfbT0N7YhuLHneDkRE7rqcZW28u6O5nvcBBF6gsKmuEt74UoxHjqzaMocUd+lmvmSS2cRH7R1LPoMKF+LXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080609; c=relaxed/simple;
	bh=wPsK1fGhwxNd5VCY8SZ83anSZT09/E7R9iP/jb5nd+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlb4DGtIVpBt/L8VWCLSTm99GwKmfhH1ZWEKZGaA0BrWXke4LwOsnbs8ZpEARnVuQp1g/QjTac60r9U9DQcDazyh51YVUc0niem1ncnzVoYM0RoUHQKRCAZs59csrYYRceGv4SMKKazoEjK+Cgo+zTl/AXKCvukgsSrfvBAbQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gen1dxsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gen1dxsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04471F00893;
	Tue, 22 Sep 2026 12:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080607;
	bh=wPsK1fGhwxNd5VCY8SZ83anSZT09/E7R9iP/jb5nd+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gen1dxsiamNeSw8WhxR2bsvXAbnECMzMNknKwynfbtpviYdjzHO2lra2YjRmucE8P
	 vuikMGrtT/qCKaPBsz1rubQMAqE5dKG4GVYGNSRbKqkSCAfmGbHKPDaQJ8vPsi3Dx4
	 3RPtgCPEPm9nK5/0/Xi6Ve3G++KsSgwFFR9LP19+Ao4ccXM1qmeu2KVrNezr957WHd
	 NvrAcnOxThdfV0teSmuFZcKR6CPoV1/AU1JBxJCksTu3FY60sdp9sQem6wCozFLKLU
	 EBV3FHlZmxjb+RjwYSt03j51BC8+dKcfaPzYEJEBmHnotGtzDtnJBlepnEBL3efQgZ
	 1PQgnqgr2lO8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] perf annotate-data: Resolve type DIEs in the
 debug file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922122623.1029132-4-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:36:47 +0000
Message-Id: <20260922123647.C04471F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> 'perf report -s type' hangs, burning all of a CPU with no output, when
> resolving a hist entry on the dwz compressed debug info of libz.so.1
> (zlib-ng): die_collect_vars() saves the dwarf_dieoffset() of the type
> DIE, which is relative to the file it lives in - the dwz alt file for
> the types shared by more than one CU - and update_var_state() resolves
> that offset in the main debug file, where it parses whatever is at that
> offset, here a typedef whose DW_AT_type refers to itself, making the
> type chase spin forever.
>=20
> Record whether the type DIE came from the alt file and resolve the
> offset with die_get_type_die() in that file, with no fallback:
> resolving an alt file offset in the main file is exactly the misparse
> above.
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122623.1029=
132-1-acme@kernel.org?part=3D3

