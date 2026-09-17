Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7E4E5337
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661390; cv=none; b=Zed29YAbtSQRlkiUIpOFvLQMCvkwYyTaLNoKOrilohq3a0+jwZCusfwkIchUp0DieVgPfosN8oS+UIqfEwyWUgJOiOXxESwpStoe4DjbdsNYFXtYgbnDgWyLCIoQkKZFJbjAHMG26iDNZW6YrYwbmR4aDcDr5eO4YzvYBvLYX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661390; c=relaxed/simple;
	bh=TjMxrAS7c8hSB5jnFBs42m78UQyRXojO9Zk1lo9iFqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KYq8cQY0z3pvbLQLAZa1jL+a6RTHZRMXMp117GYxqWW2qqv3iZKhkFc+VtgmAPgnauUy3XZnG2qEXgchBWdi0ob7JYYN6EvxDYP8jkZeNSng9PByozuNyfxr0KR/v+EWA8q8jGt9CmCAx6uNiC/p+z3yBat6YKCYGJASaqxpeso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/QxK5N0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/QxK5N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAFE1F00898;
	Thu, 17 Sep 2026 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661389;
	bh=TjMxrAS7c8hSB5jnFBs42m78UQyRXojO9Zk1lo9iFqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/QxK5N0LtF1HS7i3+4fhk3zo+Vz+hrfYDmwga+QMF/q3SYm5oHPAH4nrBpv7PuIt
	 53jLG0pl1u32xlPjqjnYJtUawl+9KlbAtajhDcd5thrlbHVWKDC8Y29E2B3mEgh+WF
	 LGUSdFAOeWHjJEYqeHpEPhAXMDI1ru6rURZ1tU9dB7IdVzIjseo3j0SQdrTmkN+LNt
	 p1oYtnIf9G6L1WlvPY/iXgmBj52dBGxPDEfqL+d/ttzh0tlyiBghfXAkkv/dKp+POb
	 Kr8vgmEQPn1ArtcRQAvm/mo1eM1kTjLP+Gs5QQ2psBIK/1WUIdl5401bY94MPkIbZ3
	 bL+zhYO5O0uZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] perf annotate-data: Resolve type DIEs in the
 debug file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-13-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:09:48 +0000
Message-Id: <20260917160948.EBAFE1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D12

