Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B985476FF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922947; cv=none; b=FMeQ1PHz70RQNwyRxWQGqb8VfIH+DTUyqlt3/AWAAzsYv17mwgBNrxPGHtOoYkhMPF1vXW5AWA9lI+z+WbkPMaGGKxLG2c2QRDxY+3ZhUYARewYSI6ZP+7+4wcfi3Y/tTj9o3xQiyoOIaEBjebaFcDP73/zy6bC/giMgUUPxAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922947; c=relaxed/simple;
	bh=5NW9CXhef/Bvj6W7vJIyOYZr7jVZeexN9UBPs1Es40w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DoK/vPbVL6LwXNyl4G3Fo6nxwukd0t7MAaT8yT5jM16eIQ1ZRLNeaIB6xvejsnxqzI9Vni0vzZUcN/DzDj4udENe4+0JQ2UjvXgZek7ToU67EGO4hcrwadyjZ6Az8eacb+xg+GrxpJc7YOLdnUKv7wpXIwVPLygZhozWHh2TKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCuM2g0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCuM2g0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17421F000FF;
	Tue, 13 Oct 2026 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922943;
	bh=8/JzNdca/ExM2NvJ5LC6k4VemYE+Pq0+BJGdzof0LOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCuM2g0hZ77KjxOlhPZhwRoNM+EAT6TrXhpAT1slkJgS2MLlMHkJFxLYWoHLMvEH4
	 HEurSl3gvMpWBfLOtlv9KGWes4tsQ8KtSpr3TnguEerRFvdJd/5q0Ew7gxPw4axouz
	 XrFdE92SOJN5QSGIlQnajqRO550cpmWhazteAPHcIjkLSPaCgpWEp1t+nH9zwmgAxR
	 4xBZNVnhRE6XR0rAr8upbn8t8EpWG/EWP4w5yUDKBkeYLQVAl43yxa9bLNajQyShmC
	 OrN1Np1hqshbGoLOMu39hyIR74KbmP8zLFWbQvmKpz0FKtipaee1TClqzIG9RdewtB
	 R6rvwwaBToj2w==
Message-ID: <sashiko-outbox-170450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/19] perf test attr: State, spelled out in a line,
 why a test is skipped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-15-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:22:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: TypeError and IndexError if kernel_since or kernel_un=
til has one component
--

commit 21b41941c9b2a0fd4a3bf8744960357d34dbae9e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test attr: State, spelled out in a line, why a test is skipped

This patch updates the test skipping logic in the perf test attribute scrip=
ts
to return descriptive strings instead of boolean values. This enables the
test suite to explicitly log why a test is skipped instead of just reporting
a generic skip.

> diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/=
lib/attr.py
> index 3bf07d4df9598..ee78c912d9469 100644
> --- a/tools/perf/tests/shell/lib/attr.py
> +++ b/tools/perf/tests/shell/lib/attr.py
> @@ -425,13 +428,17 @@ class Test(object):
> =20
>      def skip_test_kernel_since(self):
>          if not self.kernel_since:
> -            return False
> -        return not self.kernel_since <=3D parse_version(platform.release=
())
> +            return None
> +        if self.kernel_since <=3D parse_version(platform.release()):
> +            return None
> +        return "kernel older than %d.%d" % tuple(self.kernel_since)

[Severity: Medium]
Does this code raise a TypeError if a test specifies a single integer for
kernel_since (for example, kernel_since =3D 6)?

Prior to this patch, Python's native list comparison safely handled 1-eleme=
nt
vs 2-element list comparisons without crashing. It looks like formatting a
variable-length tuple with a fixed 2-element format string %d.%d will cause
a TypeError for 1-element lists.

> =20
>      def skip_test_kernel_until(self):
>          if not self.kernel_until:
> -            return False
> -        return not parse_version(platform.release()) < self.kernel_until
> +            return None
> +        if parse_version(platform.release()) < self.kernel_until:
> +            return None
> +        return "kernel newer than %d.%d" % tuple(self.kernel_until)

[Severity: Medium]
Will this formatting also trigger a TypeError if kernel_until contains only
one component?

[ ... ]

> @@ -529,20 +537,36 @@ class Test(object):
>      def run_cmd(self, tempdir):
>          _junk1, _junk2, _junk3, _junk4, myarch =3D (os.uname())
> =20
[ ... ]
> +        kernel =3D self.skip_test_kernel_since()
> +        if kernel:
> +            log.debug("  detail: the test file's kernel_since =3D %d.%d,=
 this kernel is %s",
> +                     self.kernel_since[0], self.kernel_since[1], platfor=
m.release())

[Severity: Medium]
Could directly accessing index 1 via self.kernel_since[1] cause an IndexErr=
or
when the list only contains a major version?

> +            raise Notest(self, kernel)
> +
> +        kernel =3D self.skip_test_kernel_until()
> +        if kernel:
> +            log.debug("  detail: the test file's kernel_until =3D %d.%d,=
 this kernel is %s",
> +                     self.kernel_until[0], self.kernel_until[1], platfor=
m.release())

[Severity: Medium]
Similarly, does accessing self.kernel_until[1] raise an IndexError if the t=
est
specifies only a single-component version?

> +            raise Notest(self, kernel)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D14
