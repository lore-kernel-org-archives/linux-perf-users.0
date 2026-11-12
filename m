Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515324;
	b=jgEZfhZUk9UhAV2VQu5sLM0nuWl8WD0WEBv1lHZewySCyLUh+f36oMDpKNwZdBq7anRM
	 3ibKpGVyakyPcnuXOdoGJnjU/4uwSGa+U1eEFtoU4Upd6MyjChuh7OIbY8pjDxOcI+16q
	 b/qFmACbVzFh4vjGjQDWj8AYjDSH2yCBTsUoJ0QEsSzIudOjYoTKd9yALMeP3ssGMUWMo
	 LNZ/ZChUBD7j3reVMMFSUHN3txTUYr0NpVWjfv+QgQq2AuYmCOT+Rk45IY7TMssN13RGO
	 wPZA7yikDSqRBqRHiLRK+dMhQGLkGsTCyFDHMd2xiW02B/KBbTF3+wbYORMQZgFy5kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515324;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ez1YMXwsuGRp8/Bsy0+CEqGhgXnmbfG86324uNv2xAE=;
	b=mQyUWByu8bLBmgL+7FASG4klz0pAGIllpp1pjYA7zGCS0jr29MJGDdWKT//rQWSp6DHT
	 L0TuKCjNgxuw6tIQDLMyStBx67oQvva8iqPqtI8IgfI+TGEnSuPYxY0Dx40pk9iG0MRo8
	 0IqRPoPDIJ4j6yxWZQbQ9xaKo4PGUu7SMYFRkusuOJQI4FxxxojpSAzdNKpKFW4POb4SK
	 hMYlAZsP4N6JEpbgz0fYJn71NzCvgDYvr4yGoVaH/vY1b5w9t9DSgulIkNIjFYVLirNRZ
	 WPFjeJGtYeW6G3mIhpdhT9Y43XoIIB3Cc3K8BqnNPAzUajcE57JLc106HcRz0gHmNwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9wEo+Lg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581D606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9wEo+Lg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333DC1F000C4;
	Thu, 12 Nov 2026 20:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515324;
	bh=ez1YMXwsuGRp8/Bsy0+CEqGhgXnmbfG86324uNv2xAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h9wEo+Lg67a6KOx4yP6gLSZnrYnSsv5X1lJLM+YdMzwPZuEB3p84BWKoRCp74vxDi
	 n9ZbYLfxnFpv6EtwYQgimQi3CiQk3RUA9hyJhS8GsOuN0o+Z2WNS5q05RSn5yxA955
	 AbdG6hbvhrFjNccMtdu9I0uw+kWlzOXyFgNmQgb3y15bNR+KmVUGjcves/qMWxY4to
	 dAYk+KjPOUwhqcEcV/UVJzmdjwlC5c+VNF559r/UJDPkSLeImn6V+c4bxvQqW9Suac
	 UOzdKgAyL2hLBpi83ovs+/Ql+x6ibAF+sn5HYgQflcaVDPZ0sCH9uEyZGxwpUHQR33
	 RV4tVRZ0Yslrw==
Message-ID: <sashiko-outbox-211792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Test piped data in
 inject-callchain.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Serhei Makarov" <serhei@serhei.io>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112201833.78630-2-serhei@serhei.io>
References: <20261112201833.78630-1-serhei@serhei.io>
 <20261112201833.78630-2-serhei@serhei.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 20:28:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] perf test: missing Signed-off-by trailer in commit message
- [Medium] perf test: trap_err() overwrites $? and exits 0 on command
  failure
- [Medium] perf test: pipelines ending in cat without pipefail mask perf
  crashes
--

commit e5bf6b4a81ccc0d0065f5b23fedc941ae4553914
Author: Serhei Makarov <serhei@serhei.io>

> perf test: Test piped data in inject-callchain.sh
>
> Expand the test to verify --convert-callchain on piped data.
>
> Also, check that it's now safe to run 'perf inject --convert-callchain'
> on events without DWARF callchain data. In the prior version of the
> code, the up-front evsel check (not possible to do with piping) was
> guarding against a segfault in the prior version of the code.
>
> $ /opt/perf/bin/perf test -vv "DWARF callchain"
>  89: perf inject to convert DWARF callchains to regular ones:

[Severity: High]
This commit message is missing a Signed-off-by trailer.

> diff --git a/tools/perf/tests/shell/inject-callchain.sh b/tools/perf/test=
s/shell/inject-callchain.sh
> index a1cba8010f954..900459a8dc9e8 100755
> --- a/tools/perf/tests/shell/inject-callchain.sh
> +++ b/tools/perf/tests/shell/inject-callchain.sh
> @@ -23,23 +23,74 @@ trap_cleanup()
>  	exit 1
>  }
> =20
> +trap_err()
> +{
> +    local SIG=3D$?
> +    if (( $? =3D=3D 139 )); then #SIGSEGV
> +        err=3D1
> +    fi
> +    echo "Unexpected signal ${SIG} in ${FUNCNAME[1]}"
> +    cleanup
> +    exit ${err}
> +}

[Severity: Medium]
Does trap_err() exit with status 0 when a command fails or crashes?

Running "local SIG=3D$?" overwrites $? with the return status of the local
builtin (0), so "if (( $? =3D=3D 139 ))" is always false.  Because err star=
ts at
0 and is never updated for 139 or any other failure, "exit ${err}" causes t=
he
test to pass silently when the trap triggers.

> +
>  trap trap_cleanup EXIT TERM INT
> +trap trap_err ERR
> +
> +echo "recording piped data without DWARF callchain"
> +perf record -F 999 -o - -- perf test -w noploop | cat > ${TESTDATA}.nodw=
arf
> =20
>  echo "recording data with DWARF callchain"
>  perf record -F 999 --call-graph dwarf -o "${TESTDATA}" -- perf test -w n=
oploop
> =20
> +echo "recording piped data with DWARF callchain"
> +perf record -F 999 --call-graph dwarf -o - -- perf test -w noploop | cat=
 > ${TESTDATA}.piped
> +
> +echo "check --convert-callchain without DWARF data"
> +# verify that running on non-DWARF data does not produce segfault
> +perf inject -i "${TESTDATA}.nodwarf" --convert-callchain -o "${TESTDATA}=
.nodwarf.conv"
> +cat "${TESTDATA}.nodwarf" | perf inject --convert-callchain -i - -o "${T=
ESTDATA}.nodwarf.conv2"
> +cat "${TESTDATA}.nodwarf" | perf inject --convert-callchain -i - -o - | =
cat > ${TESTDATA}.nodwarf.conv3

[Severity: Medium]
Without "set -o pipefail", does piping perf record or perf inject into cat
mask crashes and non-zero exit statuses?  When an upstream command in these
pipelines segfaults, the pipeline still returns 0 from the trailing cat, and
because ${TESTDATA}.nodwarf.conv3 is never inspected afterwards, a crash in
that perf inject invocation goes undetected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112201833.7863=
0-1-serhei@serhei.io?part=3D2
