Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956D50278E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633776; cv=none; b=d/ghPAfi5sv6XPX/K0tZLxhTy83NJzNy0ebwe99rpMLZRyeADAo/g9PdH/9yG5B3V2bcbMGW6LufOyV54LA+6rQj29lXv91qHDonliKYsr945ohdrbGmdBHYEIQQKBlES0Qa3KtX679R7FbO3LBBDKk8KIq8DTLDBk5P0T5/4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633776; c=relaxed/simple;
	bh=7zZJ84tkUDd8rC9/Bhk9aBK99bPXlPryXOc/+75t2S4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AT2LxmVYtYNI7yPsyWo05BuxLzO0AcmcM4k3yiCMdro75Vzqm4RIykRDcJpUOb6YAIM4CbaOb8IvlBzxX6/X5KvGkSAZudhLt0ZB6dNUFJUKUOhyIP0ZgS1NjzVct6aniMvkQX4WiPPNWbyL+ha1l30fqgi874zS3n1dySZCfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac1rsK9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac1rsK9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1F1F000FF;
	Mon, 28 Sep 2026 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633775;
	bh=k3slciu5uTXPLix0XMKCsoArTo6hJPbWMapf6tzgLk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ac1rsK9xnnSnVwnovMjcUHBcYBhURf+L4J32Gx6mNWcd0l9HQHEBw1yMHCEw6U9It
	 F6BxREn48UfWnFduRhOPKgLt6uP/bMzCjj93m8lLgx/VgLL2HInyIqjG1eSFJZs9UA
	 j3hIyo30aCH/yCjCyMLZ2mFmki/qeSAVYMwC9WWX0K2ZvxC7bcUki6+dCT0mUHZetr
	 ddcyOM0idVuJLpkFpQ+mi6ogek8g211itlr1Zb6ATIc0kfT3IkLTwGdVKfYLwuqimY
	 pZMQDH6yS18Pbp3xI02ZcDxI6+MQVh4sy4Jwx45I+ImeQKI4pREtoIlJ4XnvxZ/qIR
	 b33KrJugM5gRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928220634.2451784-4-acme@kernel.org>
References: <20260928220634.2451784-1-acme@kernel.org>
 <20260928220634.2451784-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 22:16:14 +0000
Message-Id: <20260928221615.12C1F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf scripts: perf-dso GDB command fails on ASan/LSan builds
--

commit 3e959f0b96fd50b6f00f007448b2245cac82c305
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit introduces a prototype perf-stuck script and accompanying GDB
script to identify where a running perf process is stuck. It samples /proc
entries and can optionally use GDB to dump the DWARF DIE chain.

> diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-=
stuck.gdb
> new file mode 100644
> index 0000000000000..2022f83c6bfdc
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.gdb
[ ... ]
> +define perf-dso
> +  if $_any_caller_is("find_data_type", 20)
> +    frame function find_data_type
> +    # REFCNT_CHECKING, implied by an ASan/LSan build, wraps struct map a=
nd
> +    # struct dso in a proxy keeping the real object in ->orig, so there =
the
> +    # dso is map->orig->dso->orig, giving map->orig->dso->orig->name her=
e;
> +    # struct symbol is not wrapped, so sym->name needs no ->orig.
> +    printf "dso=3D%s ip=3D0x%lx sym=3D%s\n", dloc->ms->map->dso->name, d=
loc->ip, dloc->ms->sym ? dloc->ms->sym->name : "(no symbol)"

[Severity: Low]
Does this command fail on ASan/LSan builds?=20

The comment correctly notes that REFCNT_CHECKING wraps struct map and struct
dso in a proxy requiring ->orig access, but the printf statement hardcodes
the standard non-ASan access path (dloc->ms->map->dso->name).

This causes the perf-dso GDB macro to fail to evaluate and abort when
running perf-stuck.sh -g against an ASan-instrumented perf process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928220634.2451=
784-1-acme@kernel.org?part=3D3
