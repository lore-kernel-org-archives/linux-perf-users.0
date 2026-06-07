Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8461DFF0
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780876144; cv=none; b=JJ+C5rlfVVAcdFf8PqnD9UdC22gvqw+m/SBWqn28fpm1yXpNza8fIt3G/0pppyeyFgmmuKb/f7GYzxmU4Jy1upYl0cBskSrWb/UrIC83HkyrnMxegpPK92RD97W30OJrpdDChvW4w42iFrODVrdzSyGOUkf1gnTMisAAKLMA6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780876144; c=relaxed/simple;
	bh=mIPBfmQkZCZpeu4Wp0hL53eQ1smdswxh9jy+n+oD5So=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h60jyI0GmTELIAPsA0KJfWlK/UqRyKI2EMAIKhxZaztWefNzgnLxCq/GLGq0/dOUZy1iijZvuYYGoIValVeUg5tKJFJLRMbMekwB5yxzz0pa8EtMmk2Cd5STDUIm8xB1ajAtyt6X396/asFI3JEH/eHOqMsz+ndGyDTEWu1nboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr+uYnhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr+uYnhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDAB1F00893;
	Sun,  7 Jun 2026 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780876143;
	bh=SoO77JZy0MMIA2o7r2nXvA0zEg58lXtU/mHSypkYoXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr+uYnhgKjxwtLNhrsUnnbm1BMOX+2OFVC663JcT2qgAyWVl4ouxs/ZzR+MKHlGWw
	 WxEi+uONvwhIyjxIywVIJ6JJ18QfKToKokhy6JSYXej0pp9vUUpIqoXtcSK4CJ5X2O
	 Ya+KGOErUpNbMPq49nHpOqPkPkrDXmImKb+Y/Ezkq/SNP3rq682JEmRhsSt322YWNP
	 PK00SeJIArL1mUsVer43VkPIzAia2fiQ16nd1RlAWTQNUQm5/Lfz1R+ur21Rm7XPMT
	 jeNTBWEGekz4DtS1ijecvP5k8wLRfx7JIcKTnrS6i9jsr9JwQ674FGqqU/X+mJGrmf
	 MW5dwrQMbjjKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] perf tools: Use scnprintf() in
 build_id__snprintf() and hwmon read_events()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607232925.1935819-12-acme@kernel.org>
References: <20260607232925.1935819-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 23:49:02 +0000
Message-Id: <20260607234902.EDDAB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Reading sysfs file contents into fixed-size stack buffers causes a=
 1-byte out-of-bounds write when appending a null terminator if the read fi=
lls the buffer.
- [High] User-controlled stack buffer overflow via misused `strlcpy` in `pa=
rse_hwmon_filename()`.
--

commit 48628bf245e27619381dcbb4cf7723991e4f5a11
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()

build_id__snprintf() and hwmon_pmu__read_events() accumulate formatted
output via snprintf(), which returns the would-have-been-written count
on truncation.  In build_id__snprintf(), this inflates the return
value beyond the buffer size.  In hwmon_pmu__read_events(), len
overshoots out_buf_len and the next 'out_buf_len - len' underflows.

Switch both to scnprintf() which returns actual bytes written.

Fixes: fccaaf6fbbc59910 ("perf build-id: Change sprintf functions to snprin=
tf")
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events fr=
om hwmon in sysfs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

[ ... ]

> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index fb3ffa8d32ad2..dbf6a71af47f9 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmo=
n_pmu *hwm, char *out_buf, si
> =20
>  				buf[read_len] =3D '\0';

[Severity: High]
This isn't a bug introduced by this patch, but does this write out of bound=
s?

In hwmon_pmu__describe_items(), the code reads from sysfs directly into a
stack buffer (buf) using sizeof(buf) as the maximum length. If the read
fills the buffer exactly and lacks a trailing newline, read_len will
equal sizeof(buf).

Writing to buf[read_len] would then write one byte past the end of the
array, corrupting an adjacent byte on the stack with a null byte. Should
the read size be sizeof(buf) - 1 to safely null-terminate?

This same pattern appears to exist in evsel__hwmon_pmu_read() and
hwmon_pmu__read_events().

>  				val =3D strtoll(buf, /*endptr=3D*/NULL, 10);
> -				len +=3D snprintf(out_buf + len, out_buf_len - len, "%s%s%s=3D%g%s",
> -						len =3D=3D 0 ? " " : ", ",
> -						hwmon_item_strs[bit],
> -						is_alarm ? "_alarm" : "",
> -						(double)val / 1000.0,
> -						hwmon_units[key.type]);
> +				len +=3D scnprintf(out_buf + len, out_buf_len - len, "%s%s%s=3D%g%s",
> +						 len =3D=3D 0 ? " " : ", ",
> +						 hwmon_item_strs[bit],
> +						 is_alarm ? "_alarm" : "",
> +						 (double)val / 1000.0,
> +						 hwmon_units[key.type]);

[Severity: High]
This is a pre-existing issue, but I also noticed a potential stack buffer
overflow in parse_hwmon_filename() in this same file.

When copying an event prefix into fn_type:

tools/perf/util/hwmon_pmu.c:parse_hwmon_filename() {
    ...
	char fn_type[24];
    ...
	*alarm =3D false;
	fn_item_len =3D strlen(fn_item);
	if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm")) {
		assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
		strlcpy(fn_type, fn_item, fn_item_len - 5);
		fn_item =3D fn_type;
		*alarm =3D true;
	}
    ...
}

The third argument to strlcpy() is passed as fn_item_len - 5 instead of the
destination buffer capacity (sizeof(fn_type)). Since fn_item originates from
user-controlled event input, an arbitrarily long name ending in "_alarm"
could cause strlcpy() to copy more than 24 characters into fn_type,
overflowing the stack buffer.

Could this be exploited for memory corruption if perf is run with elevated
capabilities?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607232925.1935=
819-1-acme@kernel.org?part=3D11
