Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4714078E8
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622416; cv=none; b=HKwCpYJa4N+DXpGHgHcsZBL7S0qBO9aBP+sf+B4qOhemP9C0FclSy4bBinb3O1UOsXljCNJNJpHfvLCO9n2bG3qmn7ND/4sslTQIaXzUCf0m8KY17Li9po+9Gr9CMo/SNOThxZHQyJDCi4mQWe0EF/LHAb6SBKIrv5KjnMF4+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622416; c=relaxed/simple;
	bh=evWgdTCprpDrpwromUUyxzJrcZTl+p7r0gFLuWhKgdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S7UJgWJIrqXh+V74Qa0Cmox+dar+gtlFD7HHNpLQcxAuxS6XolMW3fdKJEbqzs8By1+fxv3Vruj+E4NsDr73iC5AsJxXcTiEaCk+cGU48m9ABybV463YoA4MZ8YNIuAVI57VvPURpo+Y79icJb5IkEbEDRMThy0tiM9V0S7lUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZgExjS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZgExjS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A8F1F000FF;
	Thu, 17 Sep 2026 05:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622414;
	bh=evWgdTCprpDrpwromUUyxzJrcZTl+p7r0gFLuWhKgdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZgExjS1ki/HCYPdZMObPkaQeGA91q60+YWM4o8oNqL/f0hHeZ7X0c653yllNDnro
	 mWq7EqhSkO1DAI4N0tvA8qDK61gb04RRgASnW9HA9rHfOy2bQwoJKT+VgWyPD1p+Go
	 OnYRIYofBJ8ownQqGTE6FyczVjjLiRNt//QFjXGjxB+TwK/HW3jCnApd52g/+iiPNK
	 k9/4Vms/vP0ihNU15nmlMPwRSVUrU++H9bGhR4wgECFQhGuhwCfuXXqzbGk0yCLA9g
	 GoZEg7HKBxbLPpOwv8N8ngFshiVN+YHW29eUb+7jG7abhVwxl3FOoGkaF1KxNC4BAP
	 y5KLEys1XMWBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf libdw: Fix Dwfl discovery with split files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050450.703018-2-irogers@google.com>
References: <20260916234402.437113-1-irogers@google.com>
 <20260917050450.703018-1-irogers@google.com>
 <20260917050450.703018-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:20:13 +0000
Message-Id: <20260917052013.E8A8F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> dso__libdw_dwfl() opens the Dwfl with dso__long_name(), the file the
> samples came from. When the debug information lives in a separate file,
> symbol loading finds it and records it as the dso's symsrc filename, but
> the Dwfl still refers to the original file, so libdw has no DWARF to
> resolve addresses against.
>=20
> Open the Dwfl with the symsrc filename when one is known and fall back
> to the long name when it isn't.
>=20
> The symsrc file is found while symbols are loaded, which can happen
> after the Dwfl has been created and cached, so drop the cached Dwfl and
> the addr2line cache built from it when the symsrc filename is set.
> That teardown can run while another thread is using the cache, so take
> the dso lock across both the teardown and the Dwfl accessors, and
> re-read dso__symsrc_filename() under the dso lock in libbfd__addr2line()
> and cmd__addr2line() to prevent a TOCTOU race with cache invalidation.
>=20
> Fixes: b7a2b011e962 ("perf powerpc: Unify the skip-callchain-idx libdw wi=
th that for addr2line")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050450.7030=
18-1-irogers@google.com?part=3D1

