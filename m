Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768475;
	b=FqeLrkr8JTOMcN1FGwc7YIVi/bfm0dIHUxTyApR9i6lcQD87ztjzlm1RMTqrfmq6JBD8
	 FhIy3kozHKp07+bFKYA7bWqwaUq0OYfXSpKWsR1JPvWpKA1pY0NvaevkMd5ozJOnP+g6A
	 SKIozvZgmkwZyY7mzYU4m7tfd+r+YzKWJU2W6xbli+Ef3Vl8cWfv3WnYoJb0P5bOtb6sb
	 UpFUpAvYvvgRw0RN5Sa9xxbm83q1JFz6j40veVPg32qvyU0Sf9PJeDAWTUbBapILOtHYP
	 FaTMv38fYY88oceCGuBgyXHecm3YMC+x27/TkHJeuT5A1tGXzG0w16b8JgGrXtKBXOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QfSKH161pCNIucrsow/KfQzPeo7wv/ygzAUTTQaAoxw=;
	b=uGSc/bbn6gajnGd52CMC3L7h+egJU60zTuaZXUAlL9pk4xe5RZ1WjV6zKiZzPzT8rgcK
	 o+nNNf2SvJRyoRo+36Y8sUIkW3n8hVip7Vsu+ydbaW1q9DMX5LMEWToRJP//ELCWkvvWh
	 4B/DrqsKp/Ks964YGuXaQMGm7NLNvvmq92Qavk6whYCNPqt9DINgvqtyVFwbSDHAxkAHN
	 bdRW6nus2bHyvfs21qiP3UzfbDVsM7IFE4DEJhGFC02sRw2wSKrRYcTwEfj30QdAeeMLI
	 HEpE2fxaTTHZMIvhGlqS3MBgC6ymG51Hwa+XSsxmEru17f03wpLd7Xmf/NzJkb7iOqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIykFzyK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA40606A328
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIykFzyK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512021F00919;
	Wed,  4 Nov 2026 05:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793768474;
	bh=QfSKH161pCNIucrsow/KfQzPeo7wv/ygzAUTTQaAoxw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PIykFzyKVz5BKTq6K2d9HqoPMobiyqUJCbZ5IPv70kX9zMHaTlBbV4nPpq2AyFAQl
	 VhFe5DIIofDaZmZEsFpAbHDDpZvQobnCr+kykh49CwrdOEleTSY2WXaHfmpDE/BCrh
	 QQfHhmhnIIu4vAniki9DpnGZPWKlEAxensSu3gjs1M3LM4mRj15+HvA7skjmbCL1r+
	 fon2aqxblj+rdkMRa9nhpjcGTzTJG/eiaCWCOUS9R5nxI4KtbTYc5yfyub6T+TISOT
	 cVnGPXZgkxEIExy4m9bkFBEHXuR+Lli2HJEKqY7ni+04sM6WdVOmyjbA7WWO7G6Mcy
	 n0pN+sEORvScA==
Message-ID: <sashiko-outbox-196666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 25/41] perf test: Add stat record metrics test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-26-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:01:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: test_stat_record_metrics() leaks ${stat_data}.old bac=
kup file in /tmp
--

commit 7661cf6ce76dfbeea0363bcd9ee3e8c0ff9b87d6
Author: Ian Rogers <irogers@google.com>

perf test: Add stat record metrics test

This commit adds test_stat_record_metrics() to tools/perf/tests/shell/stat.=
sh
to test how metrics recorded by perf stat record are displayed by perf stat
report and perf script.

> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index ac9e031831dac..bc7d29ec7b0fa 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -92,6 +92,121 @@ test_stat_record_script() {
>    echo "stat record and script test [Success]"
>  }
> =20
> +test_stat_record_metrics() {
> +  echo "stat record metrics test"
> +  if ! perf stat -M insn_per_cycle true 2>&1 | grep -E -q "[0-9]+.*[[:sp=
ace:]]+insn_per_cycle"
> +  then
> +    echo "stat record metrics test [Skipped insn_per_cycle metric unsupp=
orted]"
> +    return
> +  fi
> +  stat_data=3D$(mktemp /tmp/perf-stat-test-data.XXXXX)
> +  if ! perf stat record -o "${stat_data}" -M insn_per_cycle true > /dev/=
null 2>&1
> +  then
> +    echo "stat record metrics test [Failed record]"
> +    rm -f "${stat_data}"
> +    err=3D1
> +    return
> +  fi

[ ... ]

> +  if ! perf stat record -o "${stat_data}" -e instructions,cycles true > =
/dev/null 2>&1
> +  then
> +    echo "stat record metrics test [Failed record with events]"
> +    rm -f "${stat_data}"
> +    err=3D1
> +    return
> +  fi

[ ... ]

> +  if ! perf script -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_pe=
r_cycle"
> +  then
> +    echo "stat record metrics test [Failed missing default metric in per=
f script]"
> +    rm -f "${stat_data}"
> +    err=3D1
> +    return
> +  fi
> +  rm -f "${stat_data}"
> +  echo "stat record metrics test [Success]"
> +}

[Severity: Medium]
Does test_stat_record_metrics() leak the ${stat_data}.old backup file in /t=
mp?

After the first perf stat record -o "${stat_data}" creates a non-empty file,
subsequent perf stat record -o "${stat_data}" calls invoke:

  __cmd_record() -> perf_session__new() -> perf_data__open() -> check_backu=
p()

which sees that ${stat_data} already exists with non-zero size and renames =
it
to ${stat_data}.old.

The normal completion path and the error return paths after the second
recording only run:

  rm -f "${stat_data}"

leaving ${stat_data}.old behind on every run. In addition, the script's
cleanup() function:

  cleanup() {
    rm -f "${stat_output}"
    trap - EXIT TERM INT
  }

does not remove ${stat_data}, ${stat_data}.old, or ${stat_config} if the te=
st
is interrupted. Should test_stat_record_metrics() and cleanup() remove
"${stat_data}.old" (as well as "${stat_data}" and "${stat_config}" in
cleanup())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D25
