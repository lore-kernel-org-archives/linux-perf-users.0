Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082623CF04F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412845; cv=none; b=I2dDHi6iS/usmAZdezosXXtY+fxZQw2TVGs16EKLBYnaBKNY3mWd/LXUJhmRqSNJyhE41HFw3nNwJYfgr0Ks4XcyTId8PPLoX5vMjeZMSwebJf6OrBfG8C7uHg5UUOtRdyqmYR/MTuirR/rf6OHaFMOXPWWpIt+LyhQD/x+RblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412845; c=relaxed/simple;
	bh=6b4yZQ7hSvEAc/0fJ9Ni8Ts8oUeSwzB0NF8K4F8f0vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a/UEkgcDGbeMqYdRfo6uyD0ddAxNH7jCxGXG1LR8T/DLuLUi0KFoOfL4p4slzpbUHt5DgLitYGdZL74cl4TZA1IaBN4O/4q1RzHgFBguNkulzXg03sUlLRegHJEEVG6OOLWjzjo15TzsKP7KUDTooBJSPV/7yGWKyqQyeFwdkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLNCstsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLNCstsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A17C1F00893;
	Tue,  2 Jun 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412844;
	bh=1B+GboDnVpgWStI/f7ZV+4IBahYxZMexHbokbPMR3eE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLNCstsy3JTWfEY6T/MuHVYIs2pplQNN05tEqw640OR3MyPIb/0hbwxBncdMlX3y5
	 qBmZgJvbVdKv5m9UH21AWVM/wGGCExWE5q9Ni9/TWdik+gZ0RLQU9Cow1EhTDULkCZ
	 0R06p4n+vyGykrt4Js+HXJBnLKaa5ymsL+mHcffUzBTZ4dEoqCzGA9aL/cbKrVTfdT
	 tSm3WE6y6q0Op9asgFJWjrBtuWWM8oChq63daMrkeuddun3HWTn15Ra7uzRmdhhJZK
	 MxFjOfZuF6O2H7TaZv15XPYCpy4MjX5qswKIIZftfcxEyNyq4QwuHYIOdB6rY6hXCt
	 MbyoN2HUjZZDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/23] tools: power: acpi: Append extra cflags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-17-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-17-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:07:24 +0000
Message-Id: <20260602150724.8A17C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] EXTRA_CFLAGS cannot override optimization and debug flags.
--

commit bdc57550350069918185456205e82edb378bafaf
Author: Leo Yan <leo.yan@arm.com>

tools: power: acpi: Append extra cflags

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile=
.config
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -69,6 +69,7 @@ KERNEL_INCLUDE :=3D $(OUTPUT)include
>  ACPICA_INCLUDE :=3D $(srctree)/../../../drivers/acpi/acpica
>  CFLAGS +=3D -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
>  CFLAGS +=3D $(WARNINGS)
> +CFLAGS +=3D $(EXTRA_CFLAGS)

[Severity: Low]
Will appending EXTRA_CFLAGS here prevent it from overriding the default
optimization and debug flags?

Because CFLAGS are evaluated sequentially by the compiler, any flags added
later in the file will override earlier ones. Further down in=20
tools/power/acpi/Makefile.config, the optimization flags are appended:

# if DEBUG is enabled, then we do not strip or optimize
ifeq ($(strip $(DEBUG)),true)
	CFLAGS +=3D -O1 -g -DDEBUG
	STRIPCMD =3D /bin/true -Since_we_are_debugging
else
	CFLAGS +=3D $(OPTIMIZATION) -fomit-frame-pointer
	STRIPCMD =3D $(STRIP) -s --remove-section=3D.note --remove-section=3D.comm=
ent
endif

It appears that user-provided optimization overrides (such as passing -O0
in EXTRA_CFLAGS) will be silently overridden by these defaults. Should
EXTRA_CFLAGS be appended after the debug and optimization flags instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D17
