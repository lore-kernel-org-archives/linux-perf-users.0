Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679FF2367D3
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644735; cv=none; b=B+/XKfB817mFdDDio5vh0Ab1Un7XvBQ1YIayR/t8DIZSVdFlBUapHAcYKk5UNABBNOsM/jC/ZlyyoRKgOC4hv2nIWWw1v/QwapDUBfJCe8h4GTeBvMxWTkLE2stndBIjc4Shp9s98pTnXHWb/+JbdxAOUvEzSDoASso2hDe56jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644735; c=relaxed/simple;
	bh=pdu0u0bXqD80SR/CggMauy/5sHRXNeBttob43hADLOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BnqlI4IgSUECpFGuHTurAy13mESABhZDh+AP+4P8Bmom/UJS2V9DElGHftS1/6qaT918Iwtx4VsaHuPl1QXz05cgvX7svhFN5B5y/xMDRVMpdjoazYP0E3OJa6js5JsOoJ1w6P/XvoSxzMb60qnfDNs8i9LlaCvi+XuVVnPA6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsti8Oq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsti8Oq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13831F000FF;
	Tue, 29 Sep 2026 01:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644734;
	bh=qOWXG+Uj0NH1458ejrmIBckhzwjSicnQZ7MUSLDQLVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vsti8Oq5A56g8ag6DLwRKzrAGHUWYwWPMSKVh16hG4LSklvW/qtfM8TQz3imZSoiT
	 O177UIjUIPROFgp07EN4R/JxN2EonVJsNngbp//DiFDjuuX6c3mNbr0k75Y4m8cJY9
	 A43uPz8lhdpQvzpGz9oL8sqC3yiN2IuHY8qVywDfw6ENx7pmfwulAj+iq10l/gCR5d
	 TVXdD+jV14Ppl0or7lUvvN4gyKvU3mxVWpZro1fyxpGCd9EHBQ1laF2VK+SEgnDP3x
	 Ia68JREUk4dylbjFbvVMO4fROaQIqltuplx/f7jNHTZIeONGlsTx8T8O6VomNHa19E
	 DMWdCuB3SolGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] perf tools: Add dso->dbginfo_type field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-2-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:18:53 +0000
Message-Id: <20260929011853.D13831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It saves where the debug info is available for the given DSO.  It's
> sometimes different than where binary data or symbol table is located.
> So let's add a new field to save the info.
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D1

