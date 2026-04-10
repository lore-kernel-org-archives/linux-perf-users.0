Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35F3A4F5D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809044; cv=none; b=adFtwJS/vxllO2StnSUW8sukEs8MxdcqVi6oNw6xCYAs8syKAA/4+Ghz6nsybBe2QMc/dTwfzqSkyvmHxwNPY63P6JtoNmFuCmg1ehWdOqcO12FBiTDqN9JmgtFPGYTBkghFDKy1yCgjGwKMvymiMWHUs1woNC9z5rXS84v6jfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809044; c=relaxed/simple;
	bh=T3MWw+zUHygqID6q4WiCKYzmWs/UKZhGwhOCFto/Kro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kBfcEy5D42YiYop4NwomCl4cz6AYIN2RnqwYFKHo355zB7Lyc7lW6SiDvwjhKc4Gg5ZHZR/bo+7iBzvLjwEAxpt40BXCmgsY8nQfjj2FPM2F0P1RI40JnxEN8M16sE8R1PZ4DF2ZPGOmUWZo+QIjdWcoVecqnUO8RZHiPT4rW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdGhWnRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdGhWnRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B1EC19421;
	Fri, 10 Apr 2026 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809044;
	bh=T3MWw+zUHygqID6q4WiCKYzmWs/UKZhGwhOCFto/Kro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YdGhWnRCJfI5pI7IOEmiQxfJ2kR57+hpoF4I+vU8psiSH8Kl3Y/XzPpv/cxWx1RtE
	 wX/vb+EIP4oRNDJx9EEgrKns99x0Flq8irHRUOgmNYQlIcJn3xD2qK9Nv1j5J19zai
	 k0gF2Kc3Zo7yKEkuF5cr/6Pzf2r19h+Aazbu85eeKpGUnFhaT7Ot+KG7OQ21SOHytg
	 DsIGPSwGkxISSKsJqPg10MY+2PAQS3O/HYfnR4ZrwBfKgFVv1YLxqhaYcG1dIa0zIG
	 PfJvVERH3v3i+oPV661iLt6IBfuLCMlz3vYwVlsLSA6Own6pOnzrcYEVuHvkozoka0
	 1pkrjEUoKKkfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf dso: Fix kallsyms DSO detection with fallback
 logic
Reply-To: sashiko@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410071225.708005-2-tshah@linux.ibm.com>
References: <20260410071225.708005-2-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 08:17:22 +0000
Message-Id: <20260410081724.69B1EC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The macro `DSO__NAME_GUEST_KALLSYMS` is defined with an unbalanced =
bracket, which is deceptive and prone to misuse.
--

commit bff739892129d9369935f2dfb42b44d83b2f857d
Author: Tanushree Shah <tshah@linux.ibm.com>

perf dso: Fix kallsyms DSO detection with fallback logic

This commit fixes kallsyms DSO detection during build-id injection when
the binary type is not yet explicitly set. It implements a fallback that
matches the long_name against known kallsyms strings to correctly identify
the kernel DSO.

> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index ede691e9a2495..e44071998c499 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
[ ... ]
> @@ -20,6 +21,7 @@ struct perf_env;
> =20
>  #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
>  #define DSO__NAME_KCORE		"[kernel.kcore]"
> +#define DSO__NAME_GUEST_KALLSYMS	"[guest.kernel.kallsyms"

This isn't a bug, but there is a missing closing bracket in this macro
definition.

While it looks like this was done intentionally to allow prefix matching
against dynamic guest kallsyms names (which append a PID) using strncmp
later in the patch, naming it DSO__NAME_GUEST_KALLSYMS implies it represents
a complete, well-formed identifier like DSO__NAME_KALLSYMS.

Could this macro be renamed to something like DSO__PREFIX_GUEST_KALLSYMS
to make its intended use as a prefix clear, preventing it from being
accidentally used in contexts expecting a full name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410071225.7080=
05-2-tshah@linux.ibm.com?part=3D1
