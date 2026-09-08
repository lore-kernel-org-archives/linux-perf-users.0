Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BC538D9B;
	Tue,  8 Sep 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878558; cv=none; b=DwVGfH4jTTmjA4MZc9gCxW8tpNacaE/gmFWdAfzcIMXurr041doiz84LiBO1f6eAikt1Ayn7keu5dYbmCdpAuDUP3liob3PHK8vCJkGu9ptsIY2R7US3tHj9BuTPSVJzwHrGXIfGj1K4GHmZeBr8YPU+NXYWHK4CKH9Ef7WbHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878558; c=relaxed/simple;
	bh=EbcrSlPqsyxBfrQ/yJpBhi/8t5JpxjvLN1Tok+Efy4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AoOpevG33Ra6nepRvV9i/+NMUXUImGR6clvC4KdqTkJrcMfsPGiNMdzhy6ETlTmutNp8sJpnXIlqNrSaLNM4NK5Y+vg1ilJ0dJBKcJpmRvh5SnXhH9IkIVNMs1S+/UJfQREurtEaZNpBZIiimNUHi8JKdF4MQC9CKgvUfaoaCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDTsAA4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDTsAA4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9B71F00A3D;
	Tue,  8 Sep 2026 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878545;
	bh=EbcrSlPqsyxBfrQ/yJpBhi/8t5JpxjvLN1Tok+Efy4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JDTsAA4MQ9n6+twUGMYnrB50R4kbfq5q5yq6QKmQYLDKNHCr0ePxdK3VjZCLTgJNa
	 Ko1YsyX2WnZI6diftPj4HTqZOh258frQ0NMhINwL3WwWTlAhVe68NmkQgu5nxbYvbA
	 ETi550T3jxLu20gHBECd7D6yQR/tmMDE5FyLCEzabI5N8LBoFUF7jjf13zv3n/PSGA
	 /KJdOhSZBx72gdm7uSvFHapPD3KwiXyuEmOG2B4hk/QHt0yk08rIp9FNBADJctb4A0
	 qef75HOyswWaPnQbVr18HXcDzd6Qv3Ks1W6KCbQWfui+hY9TtCGlSb0ArC/ebHiz1t
	 C9NRNNi6g2j2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report
 cycles per run
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:42:13 +0000
Message-Id: <20260908144225.2E9B71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Perf counters can report too few events when the PMU multiplexes them.
> Scale each per-CPU value before aggregation.
>=20
> Use the same CPU set for derived ratios. Report cycles per included
> program run, and preserve the total run count in JSON.
>=20
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-bpftool_cy=
les_per_run-v3-0-60e86f325c35@meta.com?part=3D3

