Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F7446821
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932390; cv=none; b=omj/hOuf44RWvakQyao+JYonulDYWKMa9ul1RtFk1v1ux/Me0EkYntDukwMwdmPD+Xv4j5yIQUqqqgPFd4WqSWRqUsyPL+RMRCaUaeUIbIiGrfc1QbivA3FRhggZM1XBGCgwOOUNaknNDsVPy1f6BPwq0ktjgDyrdOi9mjH8JUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932390; c=relaxed/simple;
	bh=Vrjxo++S4eNyJDpJyrddT4p8f6JNSdTIOmukso3m1xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROk8t3TRHPwS29dckOaUAT5OIMVANVXW6NXWh71ZpBKzg4cP3+e36vcKM+DUz4xFqxPJOcbzBYAenQw3UPiqUXXfPXIKcq5PMIi7HJ2Xv6ZJLi+xttSEGduuldHf8OmYLSKjXzv0OsdKsAtZXZHEsoq1JuatTRsNPQb9BBbvH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9VjWsfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9VjWsfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20DF1F00898;
	Fri,  2 Oct 2026 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932388;
	bh=XNROQid2yF2QcigLkE9MLFCWXCRmcsaM+zKK2jX+QD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9VjWsfOvZFtDOM9eK0E747mZKCWehIigFrAdmvB8fKAKCHoLjxVOqvT5Zg88wmz/
	 bJZiifc0iR0SDynW4Ko5tUUR1vWOo871KX/bdMrkmkYvxCNoQg4OdTH2bg6UCw1YeE
	 7zMpLnl0Zs8rmkeSMzYeFocMYk97y7Nv8TwWr/Xg/9qGbotMvSSg+sJYh2R0VXlfdO
	 7U3xF3GWPPMbw1Wb9Frmv5cEa7vnOGtlQqKrDJXxo9C/4WyJyPVjIbB4CHIOz+VX6D
	 rpogCbuYEpMVm36/lUZ3qtJfXnjEtxF3aNarcPC7eIx2EJwUUhhqRRK80Tnjzh2+zq
	 8xemhRhGuXtzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] perf config: Make perf_etc_perfconfig() never
 return NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-3-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:08 +0000
Message-Id: <20261002091308.A20DF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf_etc_perfconfig() returns what system_path() gives, and that
> allocates, so on failure every caller dereferenced NULL, the
> pre-existing ones in perf_config_set__init() and in the daemon
> included.  For the usual absolute ETC_PERFCONFIG system_path() just
> returns a strdup of it, so use ETC_PERFCONFIG itself when that fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D2

