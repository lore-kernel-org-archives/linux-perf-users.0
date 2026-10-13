Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0233FFD
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849804; cv=none; b=HVtOPwNW8hihULlez6Hens6d2oNO53ZOjIn4hCYz4R6boY/9JkiHBut0/IQPOw0oQRHc6nFacP0eLB8m81+IgB09q+ee6U+8VRERSEWuIylyakS0K5YCkSXmKB8MOrvVuotxzcnXv9ddR+Hb3U4E0cXPDEMV7jZ2bXbqUaOBIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849804; c=relaxed/simple;
	bh=89BB8WVT6WG2R9Ho2+auwsHh28jFHr+GrK2Y3OhNEQU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LDSmJzKlaw+16A65YgdDIUgeNyv1F3mTwqC+f0/TOUggJq7ZZvbxLnVpiD+CqQL/YJ7uwVatgWQAbf4dhdudvjai/ttW8SySk/HB4TZDbKASnqrN5SSaE72bDX5tJC6YmkAYiZ1LVjvrDYUZFBk7LTgOLP57Gdoi5f/lhUFFBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUhmE2Y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUhmE2Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CD1F008A1;
	Tue, 13 Oct 2026 00:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849803;
	bh=0sqtYgGZEzLnQpnty7q1cFo4/v9+G3G2BH9NkntPTTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUhmE2Y+EMo8BuKGGm9DNmK0bR8GUpNu5f2OuN4SGkQnrGRNKgWK4jDR8i6f22n1n
	 8mkkqmyoF+xt92ZAF24oGwQpNmn7Q5V8EAG19toLifOmu/h8SYZKdgJtyDszTErr6c
	 u2nZdfPJ0Rbr3m3G3HRLBSJVLGCNJRwy+SssE/t23XpIUnYqO80n5xV8FgAbaMW8i5
	 3WbY7ykInY9u/uyKEEpo6TrqIhWy6xpHGU8tl60eRYDE5nKq4ho9jOKl3vSHPwwPYy
	 NuEBkGSkRXvQ5jbZLDaL7711ukOdGPRCaDLGR6D7QRNNECtBmB9/qiXiEQyoar58M0
	 Lrtf4EoURUZyQ==
Message-ID: <sashiko-outbox-168766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] perf symbol: Get rid of
 machine_or_dso_e_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-6-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:03:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The function tries to get e_machine from a DSO (preferred) or env from
> the machine.  But currently it's only used for kernel DSO's during the
> load which refers to /proc/kallsyms most likely and it doesn't have an
> ELF header.
>=20
> Also machine->env would have proper information about the kernel so no
> need to check DSO in this case.  Actually check DSO's e_machine requires
> a correct binary type to be set but it'd cause a recursive locking
> problem.  I think it's ok to use machine->env info for the kernel.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D5

