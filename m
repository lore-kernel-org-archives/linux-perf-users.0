Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702551A4F2F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081060; cv=none; b=oCkeidnnw675HjkCqAh/HcqejuUOWsU0+sCqaWTS1rbCRJE/P+hK9g6Ja+hG4yX+QlKE+9aQwpP+rwfg18h+Cvey7sna4ANVEEB/gmokDZWn2GrdaCeeP9FRhJ6gkd9E3889GSBb1MxqKsLCeewtbdCW1B8n6ujnRYrpJHBAxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081060; c=relaxed/simple;
	bh=qMABxmzldRYVZXalKZQasrwaoC6Pxf1SEAMDV9mQk4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6/Vp2YvZFUi94elCnG6Qev3EcywPQoVjrltM50Nequn/Cu4x4Hph9ccySQYQBkIZnI9q5VbcDSdM+Td+SOQ36oo3zDBXW0AiGReHqlcyBymmIHyUzGLR6nSDtEmuxIdW+XzT38Z/w8HYWDBQ+GS41xcstlfhnUXiFPf2ewUSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScIF1WMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScIF1WMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4C4C19425;
	Sat, 25 Apr 2026 01:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777081060;
	bh=qMABxmzldRYVZXalKZQasrwaoC6Pxf1SEAMDV9mQk4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ScIF1WMmfNiVbuMis7nwyPlXpR/5rIEV7vT2VarDue2xyd7zn1LmIrJ6ecVZ3jDvS
	 9h5U2Fa87EkMT6XSO1lm7rbMPV6gYN5xyJewtTCEZsXMWQgAEcwLEANrP3Vr8wAesn
	 tEdmlQXhLVKAY3zfHca/fOO0a4SHZnz7QTuic1QKT5PeqxgWSJRXSvjTaFNudJ6KcU
	 2LUIr9wx7dtsyQQCgjnzF9V6j/2SCS875slwNRN0pLalvU2+fDQsTxLqSlVq/HSOQW
	 IJkTHlZe05zQfk9oZooKXNtRC4QZOKz8FH4YbKA3imlRDYvLPDsgPOEs8Cx+vVeSEV
	 g2xWRwzbPSGaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] rtla: Add libsubcmd dependency
Reply-To: sashiko@lists.linux.dev
To: "Tomas Glozar" <tglozar@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260320150651.51057-2-tglozar@redhat.com>
References: <20260320150651.51057-2-tglozar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 01:37:39 +0000
Message-Id: <20260425013739.BF4C4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Low] The variable `LIBSUBCMD_INCLUDES` is incorrectly used as both a com=
piler flag and a Make target, causing unnecessary sub-make executions.
- [Low] The manual compilation rules for `string.o` and `str_error_r.o` byp=
ass the standard `fixdep` dependency tracking mechanism.
--

commit 61af24c97cebeb1e051afb96f7fccb2a5c359a72
Author: Tomas Glozar <tglozar@redhat.com>

rtla: Add libsubcmd dependency

This commit prepares RTLA to migrate to libsubcmd by building and linking
the library alongside the RTLA build. It also links respective libraries
from tools/lib and adds tools/include to the include path.

> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 45690ee14544d..289e44c9664b2 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -27,6 +27,24 @@ endif
>  RTLA		:=3D $(OUTPUT)rtla
>  RTLA_IN		:=3D $(RTLA)-in.o
> =20
> +LIBSUBCMD_DIR =3D $(srctree)/tools/lib/subcmd/
> +ifneq ($(OUTPUT),)
> +  LIBSUBCMD_OUTPUT =3D $(abspath $(OUTPUT))/libsubcmd
> +else
> +  LIBSUBCMD_OUTPUT =3D $(CURDIR)/libsubcmd
> +endif
> +LIBSUBCMD =3D $(LIBSUBCMD_OUTPUT)/libsubcmd.a
> +LIBSUBCMD_INCLUDES =3D -I$(LIBSUBCMD_OUTPUT)/include

[ ... ]

> -$(RTLA_IN): fixdep FORCE src/timerlat.skel.h
> +$(RTLA_IN): fixdep FORCE src/timerlat.skel.h $(LIBSUBCMD_INCLUDES)
>  	make $(build)=3Drtla
> =20
> -clean: doc_clean fixdep-clean
> +$(LIBSUBCMD_OUTPUT):
> +	$(Q)$(MKDIR) -p $@
> +
> +$(LIBSUBCMD_INCLUDES): $(LIBSUBCMD_OUTPUT)
> +	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) $(LIBSUBCMD_MAKEFLAGS) \
> +		install_headers

Does this unintentionally cause the install_headers sub-make to run on
every build?

Since LIBSUBCMD_INCLUDES expands to the compiler flag string
-I$(LIBSUBCMD_OUTPUT)/include, make interprets this literal string as a
target. Because a file named "-I..." is never actually created by the
install_headers step, make considers the target permanently out-of-date
and executes this recipe unconditionally on every invocation.

> +$(LIBSUBCMD): fixdep $(LIBSUBCMD_OUTPUT)
> +	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) $(LIBSUBCMD_MAKEFLAGS) \
> +		$@
> +
> +$(LIB_STR_ERROR_R): $(LIB_STR_ERROR_R_SRC)
> +	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
> +
> +$(LIB_STRING): $(LIB_STRING_SRC)
> +	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<

Do these manual compilation rules bypass dependency tracking?

These targets invoke the compiler directly without using the standard
tools/build/Makefile.build infrastructure. By omitting the necessary
compiler flags to generate dependency files and skipping the fixdep
post-processing, updates to any headers included by string.c or
str_error_r.c will not automatically trigger a rebuild of these object
files.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260320150651.5105=
7-1-tglozar@redhat.com?part=3D1
