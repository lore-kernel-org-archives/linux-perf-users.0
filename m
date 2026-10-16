Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEE547052
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110268; cv=none; b=VS520Sig5y+BtG4Uqi448EWI9Br4bNYEvwMIlbmT1ClTWIn9VmPzK14kmm3NGRFC/yKsd5jiEt2zj81RxHVMMEP7iDYUOgnHzsxqWwWvVFgSRNq2tP1XBLYqslViuamqOnhi2CILPmM30lgI/UR9NVt2q7c/f8D7/dpY3PpXeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110268; c=relaxed/simple;
	bh=+n3L80u81QuT+yzF+DWw9vy6WYZgHTXLWvfVWyqIQUk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lfzehKCdfAbbj7MO1CK/wVVBkreYRBJc0urT1xQfRRhJ2DxqIF8A9HaaH5h43OptlO6GRkb6poLNMPfsxxUpHxpiJoj0CReH07XjQlGxkdl7IAZM/nKMnKuwvcEthpNm7PZvE2po19dmQTzl5rcRT7e/8E4WygRx2oso7buZ3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+IihA/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+IihA/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6F01F000C5;
	Fri, 16 Oct 2026 00:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110267;
	bh=M0ClTE7F1oF+vsMe1UcsmHMuEnjX/ZIYVQ4APlHHJCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+IihA/8zmnfXrjfEN9r/WgI7WCMmxdgBOyC4kqqoZ7A4awOK3B4cfNgR7dEiWdQE
	 UffHv5wZOlRdAGBw7EpU9oT78UY2Qp7MiCxYVS2ilTevV5Sqs3fMENMhrKuFmEDZlS
	 bIzGJoTHDGhTm35Nf2iASXhPKPPZtKo3NZvEslmd0smWcSHFs/IDGgcUm+kwyp4xuP
	 N/rhWVJgxN4uu5+wtlU8i2EWNHbC4EMEf69IebSI+S+iZRXVDk1xKNkK9ZbYQQHLeE
	 5R6X0h43HRjwOSDE10GcN5WYUCUJwub6PrwKNSJeh17CzypOLEX7Vho2um9YPB1vuR
	 a/o0vjRcMJ3Ww==
Message-ID: <sashiko-outbox-173519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/19] perf test attr: Ignore the group read_format
 bit the PMU count can remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-14-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:24:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> read_format's PERF_FORMAT_GROUP bit asks for the group members to be read
> along with the leader, which aside from this bit is verified with the
> fd/group_fd based group checking in Test.compare(), and with more than
> one core PMU a group whose members are pinned to one of them, say
> 'default_core', leaves the clones for the other core PMUs without any
> members:
>=20
>   $ perf stat -e '{cycles,default_core/legacy-hardware-config=3D3/}:S'
>   ... the A53 leader keeps its cohort, both A73 cycles clones are alone,
>       read_format 20 instead of 28
>=20
> so that bit isn't there: whether it is there is a consequence of how the
> evlist got expanded to more than one core PMU, not of the groupness the
> [ ... ]
> when the evlist has more than one event even with a single core PMU, keeps
> applying.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D13

