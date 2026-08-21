Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCE43CEF8
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306461; cv=none; b=aqQkpQin+i5OrgikSgRR5wGMJevYyXEd2lOSF+v3m+pM3nyeIIhQeAHA+tVrq2vhNRYhX+bL5AraAfFPlKb32gh5x9TUIINza7ERNTTgUGWGid/TEhv1pYYmebWR+sVAy9J0xMnEYs9w0gM0AN9xQb+WVxTZvpyy+rqlMi9KXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306461; c=relaxed/simple;
	bh=Wmk1CM0BEmZcLF7GPlAQLN1cPC8QPElqavncXvtj7uQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r+TJAQ+/0R6Veesve0FxeKEOvwUQj8ZaBjaiIqzDsrFNyDIplQO0K3XnvefMqll3ZQnBtvtF846r5wenKbzUhAuGaexaowW5JAH8mPgMoK31aC1NhLUWFWuWw86x3vHSkAU//AbLfLkFFMXCvU39SpOMOtu5djPEw0PMuYFkuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG/LOeZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG/LOeZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B97A1F000E9;
	Fri, 21 Aug 2026 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306449;
	bh=Wmk1CM0BEmZcLF7GPlAQLN1cPC8QPElqavncXvtj7uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QG/LOeZJZJtfvnikhoGroX0mf/B4Qibkt0WOmVFjMuRuZb7OsNVgedyQ3lttK/VAg
	 yqV2sjjSqijjnEaAoNDI357gUJDcFFgvtUgSHr10lAkW50UAVUfAj+8EBFEUBd0K2W
	 +OKWvII0CAZPbPji2NBh7B3ZW/jQ8zzhwZhsVYni/MhMXXRuaiiM+/p1qAIP4UdDdE
	 GPcgy6Ps2D8lzI0d7ddmkRjs049u1x+gyPvk7eFeaALqf8s12jyZf169+YFSXE6xBT
	 yNdliYgHwDlqTFrLjYImQJw/+eE4vF5aJGopgxktpHpCi2HHhc+a7m1CO6nj4IrJYA
	 OcIUcXv5EI/vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/14] perf auxtrace: Turn Intel BTS snapshot search
 into a generic one
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-6-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-6-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:00:49 +0000
Message-Id: <20260821100049.8B97A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently each auxtrace user has to implement both the snapshot search
> and the logic to fixup the 'head' and 'old' values after finding a wrap.
> IntelPT and BTS have the same fixup logic but different wrap searches.
> BTS and Arm SPE have the same search but SPE modifies head differently
> (although it probably shouldn=E2=80=99t), and Arm Coresight doesn't have a
> search at all, but later it will want its own search and same fixup
> logic.
>=20
> Start moving towards a system where the pointers are always fixed up in
> the same way by auxtrace.c, and users only have to provide a search
> function or can use the generic one without reimplementing it.
>=20
> The new auxtrace_find_snapshot() calls the search callback if it's
> implemented, handles pointer fixup in a consistent way and is based on
> intel_bts_find_snapshot(). auxtrace_record__has_wrapped() is the generic
> search function based on intel_bts_has_wrapped() and includes the
> caching from intel_bts_find_snapshot(). The old find_snapshot callback
> will eventually be removed.
>=20
> No functional changes intended apart from changing the pr_debug3()s
> to print hex to match __auxtrace_mmap__read() and no longer leaking
> snapshot_refs when expanding the array length.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D6

