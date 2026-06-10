Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB91145355
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111848; cv=none; b=f3lXczGYwWlJ6MCHOcUlGJUD+pMRd4njhCfWhuUopKMVdZrQJ48Ync86K5jcz2xr7NJHpiQELQF+rvg0TkEkj5Z3udFznkv96bZY2iFCRuZQfIpVg414YB9LBKD/gjtIjlCxNevC2ctOTXwqYE6MRSt7FPFuOueOOyJAB/zsEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111848; c=relaxed/simple;
	bh=DKEq/7hk4xTkPokkETeSFTz91zF9kPDXXFQuwoAaULw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYw9b3aojCukNIyNYrI2TxL4CygFwLN57Fc9Ij/Isv+5C1YWvA4reLjfYyh3MtLw/BDdiW/NegsnXuU/AYk1uZuGySB3q6MSqCgQ6rdbiAPJJrXjtXho2dx5uvLo5RwRkN/bOSXHvD+cZu6mSvrzs8y7nKca9mX8pWcMCdRkYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXZD0fjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXZD0fjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD111F00893;
	Wed, 10 Jun 2026 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111847;
	bh=cfrujXichDQsxY3GGA/OcLK6p78BUZWdKVPihTObE5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXZD0fjUER5JzHKsnWUpJn3B75m6fTvDJHlIh7/Pj30dcfRKtZtCkNIF2zGH+FPwM
	 mMeXCkc0RdFPYWIupXajg2D7JsOdccPFjjyBsG2Nh0R2CZ3dX2EtgZTqDlegyHwMT+
	 XrIOvcvx9QgSu+YuEpsTkMvaiy214iWaFJfNbWq496OCxd/XkLWQ6KJy2SIC884tBQ
	 Yck50e4s/15x9pLkXpHn+gnuGH5Kmw76C9OhxHV/cqJiuB9mC2BdHQgOv6ySYTd9Pm
	 e+HxfS8US9Chee964dQqezhLMVBIL5fK0navdQ+Gru6omfJV/ka1hgxzGizc91HtRa
	 iwYuPre2cmhgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] perf tools: Use scnprintf() in
 build_id__snprintf() and hwmon read_events()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610165207.2077258-11-acme@kernel.org>
References: <20260610165207.2077258-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:17:26 +0000
Message-Id: <20260610171727.6AD111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Off-by-one stack buffer overflow when reading sysfs files without =
reserving space for the null terminator.
--

commit e6063aeb686d4d547e9272a51fc950e7a84f13a8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()

build_id__snprintf() and hwmon_pmu__read_events() accumulate formatted
output via snprintf(), which returns the would-have-been-written count
on truncation.

> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index fb3ffa8d32ad2..dbf6a71af47f9 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmo=
n_pmu *hwm, char *out_buf, si
> =20
>  				buf[read_len] =3D '\0';

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to an
off-by-one stack buffer overflow?

Looking at hwmon_pmu__describe_items() in tools/perf/util/hwmon_pmu.c, we
read up to sizeof(buf) bytes:

    ssize_t read_len =3D read(fd, buf, sizeof(buf));

If the sysfs file contains exactly the capacity of the buffer (64 bytes) and
does not end with a newline, read_len will be 64.

When terminating the string here:

    buf[read_len] =3D '\0';

Does this write a null byte exactly one byte past the end of the buf array?
It appears similar patterns exist in hwmon_pmu__read_events() and
evsel__hwmon_pmu_read() as well, where reading the full buffer size
leads to an out-of-bounds null termination.

Should we reserve space for the null terminator by reading sizeof(buf) - 1
instead?

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
>  			}
>  			close(fd);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165207.2077=
258-1-acme@kernel.org?part=3D10
