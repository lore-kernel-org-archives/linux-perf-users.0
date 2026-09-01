Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C2371D15;
	Tue,  1 Sep 2026 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224039; cv=none; b=dFkVlDU2wp3e/f+dci+oUPjuNwldi3NBe1DdTDsrEUHa4R4rNU6lpQwSbSjWQzDvSa/eQgH296FcrTzB931jTXYflctTZiSyzG9O4LtGXENyARvUE6LN5cz4AiqQ6d7g9D8TPO0Xt14KfQxX+FniLzRMZ23NxQJo2L3UVPtWrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224039; c=relaxed/simple;
	bh=oaX33diDON/Wv5K+mFQHfIf0GPdK1jKypxRBvcDDd3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YRbo5viEWSTTBtbu+bejpwEEjRGxfX4HBmkbIlEBF7XCfaoVV9fcpDaOqCWdsf2iKMqw3n+x1wzHBWpHDxGcVruin3gZprAwlpiwQaKWxprONqDiH52HZNnjbTneZT0Jv88x/g4rQcMvx0iC83DfVtjyetF5P8JyDfhzyluAtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEx7cZU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEx7cZU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DD41F000E9;
	Tue,  1 Sep 2026 00:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224037;
	bh=oaX33diDON/Wv5K+mFQHfIf0GPdK1jKypxRBvcDDd3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EEx7cZU6T+hSIvliShPE3kPsu6AzfDJeUpptFz5cP4KHyd1xj1T4GIyMBti+i2uXD
	 hARFcS/+0evbaS7tMv6aCO8RakEG+NClFVSIscbhjkD/32NLEC0c+IvbX2uuOdF9af
	 DLawb7A+7kAuyHYdyGNl+1L7B0iTuIXpehgUcZeW3O9V2EKIXxE2n1IZ2kShPykyK9
	 9Mnqw8Tyfc3DDELKjp9TIc62ZqDbIicNxVi191bLUD68tq5AjJSRHhck+629/ZUs8V
	 9k/pKUyufsPv7aoaYNuHn0wisa5JdYYoGbZf99emPEfvvPqcex2VKFG8qefW+OJndf
	 FDBanPwKdSaPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] tracing/probes: Fix anon_stack check for unnamed
 bitfields in btf_find_struct_member
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178822362571.115597.5746407820036730968.stgit@devnote2>
References: <178822361441.115597.11442662641658772793.stgit@devnote2>
 <178822362571.115597.5746407820036730968.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:53:57 +0000
Message-Id: <20260901005357.86DD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> btf_find_struct_member() traverses into nested anonymous structures
> and unions by pushing members with !member->name_off onto anon_stack.
> However, it does not consider the unnamed bitfields (e.g. `int : 5`
> or `unsigned int : 0`) which also have member->name_off =3D=3D 0.
>=20
> If such an unnamed bitfield is pushed to anon_stack, the
> btf_find_struct_member() return an error even if there are other
> valid entries in anon_stack.
>=20
> To fix this, only push unnamed struct/union members to anon_stack.
> Also move the btf_type_is_struct() check to the entry of this function
> because now it is sure only struct/union are pushed to anon_stack.
>=20
> Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member o=
f a struct/union")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260830143859.D56991F00A3D@smtp.kern=
el.org/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178822361441.115597=
.11442662641658772793.stgit@devnote2?part=3D1

