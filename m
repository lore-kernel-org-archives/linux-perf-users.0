Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D42BB17;
	Sun, 26 Jul 2026 05:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043438; cv=none; b=r6gzLj1E67jH/k+4LUVkURqkaatEyVPm8RVcfSlP9VlJPjfGn7xigqvhXLLgHEwuK3++pp1/DKJOaScN0eIop5NC0wNr70Zi+abdXKGjtTXK0RWkPIe3XxsQMpmxSbozYKFTzpfsebjR2v7xBVYKzMp6ZhUZA7Ejm6H3O2825gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043438; c=relaxed/simple;
	bh=7/XANsgMjtklSdHdNiUMUyCQZ/PiJy+Il5Wd7yOS/8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XAoNFFzmfr7dlxWAKYgPItERCvQic0L4apPbo8zyxv29VjToNw6cGSac/qvr4TGf4V5Xi6Ju+M//KXe5dwfsWEZ6z+2u5biLrambV9QD/lIYOjhblzh0A9vgc90Sy394hosvUJT81xqHHobC5NdssKqq1BicK/xfCTwb2U0Ft6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltdEOfdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltdEOfdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6610C1F00A3A;
	Sun, 26 Jul 2026 05:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785043436;
	bh=EqCC09EA6UikzXERCt+ngchc2AMI6+T6zMxro3OC4Fo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ltdEOfdgPRmlK1XN9Lb13tJkGLOttSFNVswpyN2Lj/D1NHrb3wZJ+8R4s7ko2hJxI
	 BWWdcRuwsCrGyU3gq+m9L37+1zHLP9dqt6XXXxK+rWd44o1ec0FDMSvTL08C9dhaTV
	 J1PRY+LyEI1UtZxcP4tIz6tPfDV89akjtwZuvw5HmDoUiOUG1eFT4fEBMn9iVMv6sh
	 uQ55VZtW2vZZM+wJY3m3CgtEwQ81/1wuKlWm2o5ShF3SdHuilBLVUxMlhoDE06/jUf
	 HjuJetoH+jS/Ylv19p3OVyE9d0GpdsurMPOSJm9mLAXusp8WTev1e3GvWz7YjnB38c
	 5wS2y3THz4kNA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
 leo.yan@arm.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260723172709.1271166-1-irogers@google.com>
References: <20260723164421.1232688-1-irogers@google.com>
 <20260723172709.1271166-1-irogers@google.com>
Subject: Re: [PATCH v3] perf python: Clean up and restructure setup.py
Message-Id: <178504343636.1075259.2178744894379944705.b4-ty@kernel.org>
Date: Sat, 25 Jul 2026 22:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 23 Jul 2026 10:27:09 -0700, Ian Rogers wrote:
> Clean up and restructure the python setup script to resolve pylint
> warnings, improve code quality, and increase robustness and
> readability, targeting Python 3.9+ (the Linux kernel build minimum
> Python version).
> 
> Changes:
> - Restructure the script to use a `main()` function as the entry point,
>   leaving only imports, classes, and pure functions at module level.
> - Eliminate all global/module-level variables, making them local to
>   `main()` or the respective classes/functions.
> - Make `clang_has_option` a pure function by passing all necessary
>   parameters explicitly.
> - Extract clang compiler flag filtering into a new
>   `filter_clang_options` helper function. This function uses a loop
>   over a tuple of options, replacing ~30 lines of repetitive blocks
>   and reducing branch/statement complexity in the main flow.
> - Cleanly define attributes in `__init__` for `BuildExt` and
>   `InstallLib` and read environment variables dynamically within the
>   methods (including `srctree` in `InstallLib.run`), removing their
>   dependency on global variables.
> - Replace legacy Popen with subprocess.run for safer process handling.
> - Use quote-aware flag filtering (`shlex.split`, filter, `shlex.join`)
>   on sysconfig CFLAGS and OPT instead of regex `re.sub` substitutions.
>   This avoids boundary bugs and safely handles quoted arguments and
>   options with values.
> - Rely on setuptools to handle user CFLAGS from the environment
>   directly rather than manually prepending them to extra_compile_args.
> - Safely parse `CC` env var using `shlex.split` to handle quotes and
>   pass compiler arguments as `list[str]` lists to helper functions,
>   avoiding redundant string formatting and parsing.
> - Remove unused `import re`.
> - Rename setuptools command subclasses to PascalCase (BuildExt,
>   InstallLib).
> - Add type annotations to functions and methods.
> - Add missing docstrings for module, functions, and classes.
> - Split long lines to adhere to standard limits.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


