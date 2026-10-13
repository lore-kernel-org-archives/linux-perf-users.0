Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF24A3F3B
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916562; cv=none; b=sXvOfzlyXnvQlWVNkSegZmQ5Yl7JLJarnsFAX7uI72LKH+81vaOg9/xuZg603Llz4cRov4XSpW5Y7cjecGh2gYgCjTyFhHIcqQ67jRuODD6qvVL9KHvXv1KA5ytYgs3Ogu59/oFNEUS86zM94i6+jFXirKxhIy+jL2UYYf5vX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916562; c=relaxed/simple;
	bh=pknrS+YP0ea1qU8jBq7EO6pjqTaNHNdVNF5V1V9rUPM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JJK58STzkridjkoEVYfn/XlhTjRpk7/YzXqopLDq6J+fvtO2c8kqhrLXo/fbSQo/Zzg4gRfzpgaRYxG0RAqEV8gKJCMq8jddkba2glgNb8yVulvOv3bonZgPBWK2/xuXlzt7LZEpmE6fZgNAy1WsuGmEv0acU+GqjRo+TyjdKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCaowUSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCaowUSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89E21F000FF;
	Tue, 13 Oct 2026 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916559;
	bh=fnUtVHfkax25Z3C4L5tXTFXbrW4nzy8xTkqDBSiqkHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCaowUSH7yRvV+m5ScvYJfIeLFGKwF/So/BHuVQRL4UAm+53Ro7LWK0JcBKqoR21b
	 1fWZVb/3BMb+gtZTtXns6clBttTROLf67+7ZapYKBPhIHjEKxI7jH7qw/06bKhDHMT
	 mJepotLXGh6dacm/KFGFMAbLEZW8KavzbwgtMl8Fvvxt6b5FbN6jNFoF/NTGcOwtmY
	 ZYSs/Js8kj2yM+W53BLGXJRyIUdDVPjk7+RZvkQe1gnepFAa+O/C9mi7iwqJDYXrsi
	 O7f7qIIblMHZw3zuTz5vBp3O8FZ6DepbCWSN4pWXS9DwLhbQw60wrgF34snIJOLEiB
	 buR96SGvCZtzA==
Message-ID: <sashiko-outbox-170340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/10] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-6-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:35:58 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] build: broken feature test using -E for parser flag
--

commit 0e33ca477acb734d0166b74d7f9ee83ae4860cb6
Author: Ian Rogers <irogers@google.com>

perf build: Enable additional Clang thread-safety flags

This commit adds additional Clang thread-safety flags (-Wthread-safety-poin=
ter,
-Wthread-safety-beta, and -fexperimental-late-parse-attributes) to the perf
build to align with the kernel's context analysis.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 39442577418ea..d536203ff42f2 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -64,7 +64,10 @@ ifeq ($(CC_NO_CLANG), 0)
>    endif
> =20
>    # Enabled Wthread-safety analysis for clang builds.
> -  CFLAGS +=3D -Wthread-safety -DWARN_CONTEXT_ANALYSIS
> +  CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -Wthread-safety -Wthread-safety-po=
inter -Wthread-safety-beta
> +  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -E -x=
 c /dev/null >/dev/null 2>&1 && echo 1), 1)

[Severity: Medium]
Since -fexperimental-late-parse-attributes is a parsing flag, does passing =
it
with -E (preprocess only) cause Clang to emit a -Wunused-command-line-argum=
ent
warning? Due to -Werror, this warning gets promoted to a fatal error, which
forces the shell command to exit with a non-zero status regardless of wheth=
er
the compiler actually supports the flag.

As a result, the flag is never added to CFLAGS, preventing Clang from corre=
ctly
parsing thread-safety annotations that reference struct members declared la=
ter
in the same struct.

Should this feature test use -c rather than -E to avoid this issue?

> +    CFLAGS +=3D -fexperimental-late-parse-attributes
> +  endif
>  endif
> =20
>  include $(srctree)/tools/scripts/Makefile.arch

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D5
