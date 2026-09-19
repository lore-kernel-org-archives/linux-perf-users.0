Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936B547058
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850832; cv=none; b=KbzjCseW0D7keGie3Hlmnn2Srb1CYdkwl1csG1SvlGyV0dxzeEVNZcVhG7Wr88vUph2EQKrMgcLPYSvxck12lFrrCeJMLACQQo8fhUqLz5vEf5+lakWEP61e1iPF+OSuYgig15QuNeizqmicAHqrGknZJltMFVLgPn/Oi107wMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850832; c=relaxed/simple;
	bh=XwkHPyxyJiRyszihEsLK7iaFYSeyZZ45qQwf8HerxoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ol/QytFV2HagzTe/msjMdtZZIqGI/pyS/HY7R+ESYqfSN2szBHg0JXgrzMWWeoMT4DVqvo/HK2stFZDOzggRkireXWvxluVNnzFzh7XxLA8bymM7YtQK4DU3KayIxeIKQavboElhDOR130eDCvyFZtho7yK5ZTzxfe90S2qQk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUNhS188; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUNhS188"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A77D1F000FF;
	Sat, 19 Sep 2026 20:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850831;
	bh=sNrIG8icPdQjy5djZXqEsS0mPVkW7s8dwIW8z9MgZUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUNhS188UiVBjvJxlykZMKGOojogjAXf5k/nZ8xZdPhkNsD/h/6HiCnqU515AJvyc
	 KgOMBHHWotZ2cMMNFFSJxbgLOkrhM+fy+7oY9ITOQ6oQKVXfwqGBX9enS6sNTAt15z
	 cs4gLKURNZ9dSJIF3KmiQMn2F8HLmofK0z9GaptCCLsePFUl1/kRRSBgSU15p0sylo
	 G9M3owWl4GWcnYruIUityqaKm4lTkHifZvugioInpaaa7tWSNaoIKl4FqMNAZL+8gW
	 kMyzT/w8fvykRRtbJa0MYBH+GIosgooYUIWabTjB+oMC8GRDpzQR3zKP4d3YRcnTr8
	 pOqGSKeyZTijg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] perf dwarf-aux: Add die_same_file() and
 die_get_type_die()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919204027.8504-3-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:47:10 +0000
Message-Id: <20260919204711.1A77D1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204027.8504=
-1-acme@kernel.org?part=3D2

