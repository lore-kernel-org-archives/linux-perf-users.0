Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A513F65E6;
	Thu, 21 May 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374154; cv=none; b=C9AGfZQaMv7NZgQjRRa/hrOoYYSudB/KCxvZeheZIwYiAXxTO9cLTCgNDbc7zH1J+waG/6FwnVfJm3kraPj0S8+XmBPIdEkS/0XcIH1KuTsGyWRKedQXPhvilPmAzf1NlTSGf4zuRx5g9rsiQtc8ZMeQVrhjPZYfA3zZLZ+oKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374154; c=relaxed/simple;
	bh=7ajRaCCjggV/CvLCO8jZ1pCldMcckFcBWl5d6nspqno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGS8oiT3fW/fyUKG2OZFvxfytn9qvP0pXgZEx9b102hHQGOg2ZljQV+qg0zWgqmZqy41aILC4u6wff4BhjexrrGcWtPBSmsRFdMRGU6jqRxSqHHEgP40GoIs5vgWenhUHu6FsZqpFo2S17Qgoi7N1MWnGmoLKrQPdAw/LbNJAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NaNAicDh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NaNAicDh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eDFAvDXV+ZvV80xJzE+zWmfVcp4WL8wMCp101EPEsOk=; b=NaNAicDhNhNMgbCHPzT3trGjDi
	mj1Id1HnaTc3RxACDB1pdHKq2hQJSjy73QcY4sdwHFJOrHNSMXjvrOYB6w8OCu4ElCoevvB2R07dd
	57CpFUyYtcFGgmWFl816ZvgBOzBHoydvqN7z4sDo5UiVw6Kw8lylWV3o2KPRPMocmsq+flPI4KCkN
	UdF2NdYTIqRoH754DgU3zDhcV+Kr2hdDzmw5oG05JWSXbkPBshX+F1kStanlQCiB6G63YswfIZ0pX
	8kC1v4XlTrRW1mVMNrI28MNontsWhPJt/IQfIpCzvomprOwT1RafBTcLm6sPj8ZpdbsLbyO9oZN/w
	iNhqB9jA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQ4V1-003x5o-2D;
	Thu, 21 May 2026 14:35:47 +0000
Date: Thu, 21 May 2026 16:35:46 +0200
From: Ben Hutchings <benh@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf tools: Put Python bytecode in output directory
Message-ID: <ag8YQmHiaFc8Hpb-@decadent.org.uk>
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p/bIMzKB2HC0ALNQ"
Content-Disposition: inline
In-Reply-To: <ag8X7gcDw6jpJsLq@decadent.org.uk>
X-Debian-User: benh


--p/bIMzKB2HC0ALNQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The PMU events are processed into C sources by Python scripts, which
normally results in writing bytecode for each module into the source
tree.  This prevents a fully out-of-tree build.

To fix this, set $PYTHONPYCACHEPREFIX to relocate the bytecode cache
directory in an out-of-tree build.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/perf/Makefile.perf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 899a4249a42f..c35b65f9fdda 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -400,6 +400,11 @@ PYTHON_EXTBUILD_LIB :=3D $(PYTHON_EXTBUILD)lib/
 PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
 export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
=20
+# Put Python bytecode in output directory
+ifdef OUTPUT
+export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__
+endif
+
 python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) =
$(OUTPUT)python/perf*.so
=20
 # Use the detected configuration

--p/bIMzKB2HC0ALNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoPGEIACgkQ57/I7JWG
EQn31w//areC9SUmtuwS6lX8pK73HlYQtz9jKU9RI2F2AR1zThceCl9NlRGja9Kp
av3afZB62++sm7nZ8Ejhy8LcOfGLxyktmu7Z1nu0qBHoBMjbLCn5JHlQk8cQDE+N
RKzJox2T/DcLzSOaJHfZTgRRqYttfzKQYzywxZZAeXeQrU7b5K/A+6kGtwpf6Zu7
Z8w8/1zt/Zi+fAcKdDMP8WE5r0i3T4FF7BC6ghXcR4TzSL0GhsL8RyovBKqJDr9C
DPgzZuuNFo/2/33JN/gSCH/MmePxSYG6Xk83wx7r/VDOLFubemmXS8fvaxSjvbyR
YhEaTW6kew28e01GdM2iLY9mLoSwusPtBez7Qs5wqw0JhaxhQq6CQP5zO4URSyT7
NqnDYM2S/fMXYbZmrlmzViwcUwiP2CVM19MiHcQH4pNFpJl/CnVxHKMESjII2vX4
3U6zvT7recK2abdmgpKv37RpZuhnWHrkXucQ6bSdgkEB9J3VVBDV9lShsOG8zmbW
NMAXBSrkxVgpliZGdcSe9vtO0DbtdPOrkk4Sunycuz7yQEis2c6D4i/ndnEk9q+4
b7DkOWMd3HPMvDjQE+WuLbo95CcyZsfOeZzN15waGpgC3TRqWWb4ldwHgA+Q41pK
Lo1EwNDMzMFA1vR3ztMmFo3YYIUPZBfGHiTuO1zNypC58rFZYPE=
=OUsZ
-----END PGP SIGNATURE-----

--p/bIMzKB2HC0ALNQ--
