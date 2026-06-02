Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509293C3C13
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412643; cv=none; b=XY9cEijHreuN84eN1OjWIq6jmiHelj2WXz8djCW60O638nLC1iGTVqwmwSZUvWp12s1fgpTqaXl+7vOxCYkYz7xhhPG6WkGkWdaPwiC9pHHJrdRqFIjxZa2tj+QF0OSQrKPbZeVffC9pRp0YS+WDjztdhFxSRezCqWL56NoKNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412643; c=relaxed/simple;
	bh=yFgkQN6jXZEeV5NZrX2bQFgImvMlEEhH0XuctqAC9OY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZS3rN7QIg65wSPVok3g1/9iL5vhxZoa77pmQ2TQJNll7qbKIumuLkiGJsXESyt7U7HcjXSHRwxewUX39yfVeWTfyCWHrNZz1aX1pu3khJ74w85kPphmtfKoyISxcNVHXxDXE591LM7Hed6B7Zrhl4bcmrKH5joz+Ux/0C3YIOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk8qgkpd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk8qgkpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0CA1F00893;
	Tue,  2 Jun 2026 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412642;
	bh=D/t4p4ufOC/BLsrZzpWH3FrFYPRLI7TYFgJzeF74LPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uk8qgkpdDTznGIzoU/mHAZA8S6E/fQwWVTPPpOQiABomMH2fNkrOQ0ReQkN+VtvcT
	 CXaNnIvXXONXleCDF4h/8fDMfebbkW3grrEIbSMgYkamN9pnJ1s1n5jRDmYFeY2ny9
	 Bag6xbpUnObiENWwDWcO+/KQlYDXUEXuaQkOBhOy/FyIOccYaaOA0y6K0GHfrkrZa3
	 lZxotQL9JdR/mE3FIyqNNJVWzRq/Kz39ouKl6S3GzgCk9dUAb+Aq/Hphk+wEllZeqn
	 8aOSmH5Rt7d+wUi+U5fjBEd4EslDKguyAA/oELbNV6QgIFuyhvzrEwLZvzh0F5gGqP
	 pKp+btqiEwVkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/23] tools build: Append
 -fzero-init-padding-bits=all to extra cflags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-6-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-6-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:04:01 +0000
Message-Id: <20260602150401.CE0CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `try-run` macro attempts to create a temporary directory in th=
e source tree, breaking out-of-tree builds on read-only filesystems.
- [High] Unconditionally appending to `EXTRA_CFLAGS` in `Makefile.include` =
breaks `libbpf`'s default compilation flags, causing it to be built without=
 debug info and optimizations.
--

commit e8ede2fdc1b643da62469cb30003522715558696
Author: Leo Yan <leo.yan@arm.com>
Subject: tools build: Append -fzero-init-padding-bits=3Dall to extra cflags

The kernel has enabled -fzero-init-padding-bits=3Dall to zero padding bits
in unions and structures. This commit applies the same option for tools
building by adding cc-option and host-cc-option to dynamically detect and
append it to EXTRA_CFLAGS and HOST_EXTRACFLAGS.

Link: https://gcc.gnu.org/gcc-15/changes.html

> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index 41971a68972dd..17d24cf84051a 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
[ ... ]
> @@ -139,6 +139,36 @@ else
>  EXTRA_WARNINGS +=3D -Wshadow
>  endif
> =20
> +# output directory for tests below
> +TMPOUT =3D .tmp_$$$$
> +
> +# try-run
> +# Usage: option =3D $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwi=
se)
> +# Exit code chooses option. "$$TMP" serves as a temporary file and is
> +# automatically cleaned up.
> +try-run =3D $(shell set -e;		\
> +	TMP=3D$(TMPOUT)/tmp;		\
> +	trap "rm -rf $(TMPOUT)" EXIT;	\
> +	mkdir -p $(TMPOUT);		\

[Severity: High]
Does this break out-of-tree builds on read-only filesystems?

Because TMPOUT is hardcoded as .tmp_$$$$ without an $(OUTPUT) prefix,
the mkdir -p command will attempt to write directly to the source directory.

When performing out-of-tree builds (like make O=3D/path/to/build) on read-o=
nly
source trees, this fails with a read-only file system error. Since the
compiler flag uses immediate assignment (:=3D), this failure might spam the
console and silently drop the option during parsing.

> +	if ($(1)) >/dev/null 2>&1;	\
> +	then echo "$(2)";		\
> +	else echo "$(3)";		\
> +	fi)
> +
[ ... ]
> +host-cc-option =3D $(call try-run, \
> +	$(HOSTCC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
> +
> +# Explicitly clear padding bits with the initializer '{ 0 }'
> +FLAG_ZERO_INIT :=3D $(call cc-option,-fzero-init-padding-bits=3Dall)
> +override EXTRA_CFLAGS +=3D $(FLAG_ZERO_INIT)

[Severity: High]
Will this cause libbpf to lose its default debug and optimization flags?

In tools/lib/bpf/Makefile, there is a conditional block:

ifdef EXTRA_CFLAGS
  CFLAGS :=3D $(EXTRA_CFLAGS)
else
  CFLAGS :=3D -g -O2
endif

Because tools/scripts/Makefile.include is included prior to this check,
EXTRA_CFLAGS will unconditionally contain -fzero-init-padding-bits=3Dall
if supported by the compiler.

This means EXTRA_CFLAGS is always defined, causing libbpf to completely drop
its default -g -O2 flags and compile with only the padding bits flag.

It appears libthermal was fixed to avoid this issue, but is a corresponding
fix needed for libbpf in this patch series?

> +HOST_FLAG_ZERO_INIT :=3D $(call host-cc-option,-fzero-init-padding-bits=
=3Dall)
> +override HOST_EXTRACFLAGS +=3D $(HOST_FLAG_ZERO_INIT)
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D6
