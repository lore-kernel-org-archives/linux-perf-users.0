Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593F3BB9EB
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009764; cv=none; b=oCK5E73V0MNDk1YsT6IyOHIf5/828BSsVIYx/g1kQv+NI7YJpwyHYjHssz0lEQC7HEnSeEvS1ZkQJosXyCoeDpEdYbbDNdHKMxL2JsOzvq9Sbiha4MJrJvO6ZY/4kgoLaHMQ61NDfsmKL1U87PckZoylo728wSW5tkVCo17eBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009764; c=relaxed/simple;
	bh=RE2uLTROz/PsSHrDHcuGN4NOv0Y7cRR6V+sj7Jkgp1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UpFVs5DWoHZHTR8ADarJwcQh5a9t6xEl8s8XJ4/2AFbEHTrbUBshyZ5UokvLswEIRanV1UuVfCgsHRH3IDgTnykG+sglJzRJhuNfpjp9xD0E8pXKmKrlpDtbQQrv0xWNxhz8XmizMuuIiscM8RB1VeKYWl1MlrNgi1ZcKbJPgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOUUhaIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOUUhaIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D4E1F000FF;
	Mon, 21 Sep 2026 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009762;
	bh=QT+kTymfzfDZuPvu901p+bo7UgtqDrFv/FbEcdT6A30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOUUhaIgMo1vzhn9cXJ4yTG8npqH6PzkUkW7mMBHfnxnPHzrsruXvyW0d6V71FkBO
	 qiuCxBRbppUlf5OW8lAUxdZvdwfj1JDjFhRWMSFPzbhxKWM8Ck6rHUqI0q2xI8vmCY
	 0LUryEOOGPMZpCOfdTndX+upaQLUNZUqvhwOtkJkk3hufpdpFQAWG2dMHuIaMw1u4d
	 8gFS3bY1YT9azs76AfT65tWalmJvv7hSdu7c+g5fkex1d4G1HvKR8b7HGGaFtAVoue
	 aJih6TsaafLgMv/nmHnmUDKTE3BJEvnC83d73KqvyeJCrlMb9WtG3dJO6GzRS3w7i1
	 1kwU2PDDXIy6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] perf dwarf-aux: Add die_same_file() and
 die_get_type_die()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921164813.6727-3-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
 <20260921164813.6727-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:56:01 +0000
Message-Id: <20260921165601.A9D4E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> dwarf_dieoffset() is relative to the file the DIE is in, so an offset
> saved by die_collect_vars()/die_collect_global_vars() is only
> meaningful in that file: add die_same_file(), comparing the Dwarf each
> DIE's CU belongs to, to record which file that is, and
> die_get_type_die() to resolve the offset in it, with the saved tag as a
> sanity check.  Resolving the offset in the main file instead parses
> whatever is at it when it came from the dwz common file.
>=20
> dwarf_cu_getdwarf() is new in elfutils 0.160, so the libdw feature test
> probes for it and Makefile.config says 0.160.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164813.6727=
-1-acme@kernel.org?part=3D2

