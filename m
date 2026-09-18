Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80952CCF2
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766924; cv=none; b=mi2hr+/19yaNZKR5WqbqhdOsBY6QoGiSQWXHA+wCVTRrX7cB9NBWdqGVE0chQmYt17j95I21tMM+Nih0jb/k3S0T6z6SX7pkd5oqxgidIVnG/JpuxqbNUrzFqRZ4NTixjSu2PYpnU7nfqD843Tx0dE44xD1E6BPgLW9k/WLNYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766924; c=relaxed/simple;
	bh=6zF11sLaTKZYo766+YP7foAmykg/rejCcoOqWugXIt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQoHKQPEPt3gyQNVMMW/zxU636qjgKbPeeBITYS8+reUasvAS7qEGJLlp0n7ziDk4UCM5SddsApR7cXn96tlHzUiTK00MGASQB9rsuWdpVj8p1fx8x87geGF/VvEDLspeKLfjxW2ItE32g0CgAxyA9F91y412HR/8nzcdhv0fDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdKn/6nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdKn/6nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80A1F00898;
	Fri, 18 Sep 2026 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766920;
	bh=6zF11sLaTKZYo766+YP7foAmykg/rejCcoOqWugXIt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XdKn/6nwi1NXYPknUMfSQONh8baLLxa+99ksiBCGDQWvMyKnzIkYjVceWIbJpv7rw
	 /ipkM/LXojzYys4Vq6k4H6mqCz3yc/D19ZPDHksDFUgRdvKllARXoqTVtueTkGL6vj
	 GK5wONe/PAzl4XBi/ks8NoTOWzu4ViE135hS8cgowiI9s7LXthTnYdc/8gkfsOSaWN
	 6zfeuGn9ji96wWOymjn+hZmONL9v1/R7em9Om/gv+8mLq0Jls+E63VzgHrXIVg+gyK
	 71vCjHX45u6KHgH3qtKk0uwoEfCitVk18GxApFev2XSzBUemBjKa5w+ycJKAy88aP0
	 vAkpJfL9Bnbmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/18] perf test probe_vfs_getname: Scope probe name
 to PID and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-14-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:28:39 +0000
Message-Id: <20260918212839.EE80A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The probe name `vfs_getname` was hardcoded, causing collisions when
> tests ran concurrently. Furthermore, `cleanup_probe_vfs_getname()` used
> `perf probe -d probe:vfs_getname*`, deleting probes registered by other
> parallel tests.
>=20
> Scope the probe name to the pid, and rename it to `getname_flags_$$` so
> that it no longer begins with "vfs_getname". perf trace calls
> evlist__add_vfs_getname(), which opens every event matching a hardcoded
> "probe:vfs_getname*" wildcard, so a perf trace run by any other test
> would otherwise pin this probe and make `perf probe -d` fail with
> -EBUSY. That also unblocks making the perf trace tests non-exclusive
> later in this series.
>=20
> Enumerate the probes to record and to delete from `perf probe -l`,
> matching `^probe:${vfs_getname}(_[[:digit:]]+)?$` exactly, rather than
> [ ... ]
> accumulating a set per run. The fixed name at least meant the next run
> found, and went on to reuse, whatever the last one left.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D13

