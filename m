Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04A2367DF
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968672; cv=none; b=uxUmWYttZajNRpTZNANh6phFxrB8yBNX+/hCw1Gdsy6206HGq7xcVmQ8S+5ko7uEK6vyEnim793RcPCK9hh+TzeQNXL+fjV777VxkuHAdYlseeFCoMf02CdN8uNmclrG/B4FXZcemSqoJCw4x/1tGUA92SaTTOimu/hNDE0j0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968672; c=relaxed/simple;
	bh=iudXqX/S5nP2ADaOJnshIBauf0rgwwDk+x7e9Csvvyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BowzjlSEXjDPzbQLNk6NF38Kll3hFpGeaPVVg08dvpFZd4FHBx9IG6b0U33Xh1HErsFMdtHj9iGJnpySewxV4nbyTa7+BWXEwwWH1gRCQx/v3dg1fgLqohflOLiXcVb00fTHaKN5t1v5AB7myynBdOs44fjv26vBEbXLTzVlwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqkdBVyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqkdBVyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7341F000FF;
	Mon, 21 Sep 2026 05:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968671;
	bh=uzzwR06z18ILb6Qdt/GxCSHYNcOD0OvyuGKU3yDYfOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqkdBVyksa+42cWEOSg3gCHT0w8XBH/rQ2iBt6H6Yj4GnYUOJwGo5gO4Z/KONN6QT
	 qZqOrq45WIp056mLKb7ZXOkErecY2vaOSNYRojznvjftVT8vBEinwHV2F2HeGdcbUx
	 txFW3ZDCbjV4V+PISukj0pwB0GdleU/QNfTS1BN8g6Ab5BDhKj94f3SoDm5ZHtLjpg
	 YKTCDmqs6YLQswXqqqPP6cHMGPraSl+JvjZKiBeMX+KHojCWkaW1DVahjVjaEnqSlN
	 pB2T/BMFY6B/ffHnbsotbaTrg5hJ3MMkD9F34vbFFAbwD9bQv/mUnCp0lAU36XPIFA
	 vuakI4Ea8DWig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/49] perf python: Add Intel PT call_return and
 itrace capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b1d417e1f28afa565fa01b4997e3c31140e4772d.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <b1d417e1f28afa565fa01b4997e3c31140e4772d.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:31:10 +0000
Message-Id: <20260921053111.0F7341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add support for Intel PT call_return events and itrace options to the
> perf Python extension so standalone Python scripts can decode and
> inspect low-level instruction traces.
>=20
> Specifically:
> - Add a call_return callback parameter and itrace option string to
>   perf.session, treating explicit None (Py_None) callbacks as omitted.
> - Expose the perf.call_return object with db_id, parent_id, insn_count,
>   cyc_count, comm, pid, tid, call_time, return_time, branch_count,
>   call_ref, return_ref, flags, and call_path (resolved as a
>   perf.callchain ordered from outermost caller to callee).
> - Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
>   perf.CALL_RETURN_NON_CALL flag constants.
> - Expose session.e_machine and session.is_64_bit properties, preferring
>   recorded thread ELF machines (perf_session__e_machine) over perf_env
>   so pipe-mode traces do not prematurely cache host bitness.
> - Support optional vmlinux, kallsyms, and symfs symbol configuration
>   parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
>   PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
>     symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
>   ptime_range in
>   pyrf_session__delete().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D9

