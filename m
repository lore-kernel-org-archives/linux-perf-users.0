Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AD351C02
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832017; cv=none; b=t6/tB39HXPSSabB1bSpUqMGG2kKzBjhycWs/+UDc2QHRIBuwBpEQc37GtJ3jfUytOS+DruW761w3PwDD7Rh+5JuJ4S4taPH9fU28Uq0+sdPpsG6TaWixyXZhA/0Ir3UmHb9PCjAKE9hNLioYs5kijOcTK8p/H1Wirbkq9NocP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832017; c=relaxed/simple;
	bh=qiWMJihVf2DdPe28HLoZmzC5PDmnNyUBGxAdGMRMqE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I+RUzAmFDyFOb752OcGGsudqB3kFhtVq+7CRaBpyvOiITGfHI3BX2/9IHTrjEWGoR5vh+SpJRr6OuFFzP3qgrWhTzwNVekt5bpdBkEmdX4NWQ0Cw2djusLYTB03g9dUNnCUWrdqmXTYkXpS/gwPHnUScKgIv1E5UoK1JrdWn0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqirsPU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqirsPU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72251F000E9;
	Tue, 26 May 2026 21:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832016;
	bh=TZUuW4nT8BzNxfag1wS4GFoG7WkHlMzJQoHaxZWV+2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqirsPU+TBhaJR00HBJyzIECx4kgADwxV8OIeIeCQd/IU2Zp6brZuPuwOdbQosmhR
	 TFFDITfrI7ldf16haXSsOeUSnnwTD3TZKEuQvDuxaUtftGMZUjiqeMUL6JncekBi8g
	 afv8TfYTzO/kbp7Wt1LfT8bLSnLOtW7haEVaBPfngW4TEWi0d/NNaRJJ9pVLGiR4Ed
	 1YjtowcXmBZYhNeMlT8chCGJf/uJoHEy/NUT+pC2x9/cVkP+KxNow+1oCb3j1kGvcH
	 1YYIENDgGn0Ec/WgYCuAi+AgeniycRquW1HobQyvH+H5wYyea0luWsqp5xmZmaacWC
	 LHb6yb21nr0yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf clang-format: Prioritize Python.h and expand
 other categories
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526213911.3993710-1-irogers@google.com>
References: <20260526213911.3993710-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:46:55 +0000
Message-Id: <20260526214655.C72251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Python.h shares Priority 0 with the implicit main header, failing t=
o guarantee it is strictly sorted first.
--

commit 68559f2bb53c7691fdfd5703129afea21a0050da
Author: Ian Rogers <irogers@google.com>

perf clang-format: Prioritize Python.h and expand other categories

This commit adds Python.h to the clang-format configuration with priority 0=
 to
ensure it is sorted first. It also expands the standard and system header
categories, shifting their priorities down to accommodate the changes.

> diff --git a/tools/perf/.clang-format b/tools/perf/.clang-format
> index 902b2f7456f61..68b1c073d070b 100644
> --- a/tools/perf/.clang-format
> +++ b/tools/perf/.clang-format
> @@ -2,19 +2,22 @@ BasedOnStyle: InheritParentConfig
>  SortIncludes: true
>  IncludeBlocks: Regroup
>  IncludeCategories:
> +  # Python.h must be first
> +  - Regex:           '^<Python\.h>'
> +    Priority:        0
>    # Implicitly the corresponding header for the C file has Priority 0

[Severity: Low]
Since the corresponding main header for the C file implicitly has Priority =
0,
does assigning Priority 0 to Python.h guarantee it will always be sorted
first?

Because both share the same priority, they are placed in the same include
block and sorted alphabetically. While uppercase 'P' alphabetically precedes
most lowercase filenames, it might not provide the strict overriding
priority intended here.

Would it be safer to assign a negative priority (such as Priority: -1) to
Python.h to strictly guarantee it is placed before the main header?

Additionally, I noticed that the C Standard Library headers were shifted to
Priority 2, leaving Priority 1 completely unused:

>    # C Standard Library Headers
> -  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|=
iso646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbool|s=
tddef|stdint|stdio|stdlib|stdnoreturn|string|tgmath|threads|time|uchar|wcha=
r|wctype)\.h>'
> -    Priority:        1
> +  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|=
iso646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbit|st=
dbool|stdckdint|stddef|stdint|stdio|stdlib|stdnoreturn|string|tgmath|thread=
s|time|uchar|wchar|wctype)\.h>'
>      Priority:        2

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526213911.3993=
710-1-irogers@google.com?part=3D1
