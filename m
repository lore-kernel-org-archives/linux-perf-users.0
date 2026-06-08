Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3AB2EEE9C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883675; cv=none; b=cTOgomPdtHWlixjAQf6hHQ/ziG9r/YBfqSBSK0TTI6L9J+TfqYGyZQr4Ftk3T66BQ+twx6bj24J1EJkgAOzG/1I57QgiZl5Pm/h86+VQG4iRvUGFsvVEgkFNBvtNSnDIIgngPuZScwyNcjDE8ixj3LTTCog2FqOQk5EKvzol5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883675; c=relaxed/simple;
	bh=v/9YA3pQ8sCncjDHE4wO7wqvkFh8qI77S4kPEAl3S54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TOYdBmArYD44JiyBbYBTjzF6rlATjddkmlLa+Ci9pyEkUwDUlEboWH3jtJRxiMgiFj4E9Ofa+F1eN3ExfoYGB0J/dsKi+sLzt1196LvxGueOiYurGlSs07lGW8nnMB6stBtuGjX1V9KSmznEOcm8oXF79ywEn087sXHO+jg8QWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYe1pt13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYe1pt13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F7E1F00893;
	Mon,  8 Jun 2026 01:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883674;
	bh=J9+jqvuZc/OO71LqkCCdyzmzl0oWPWx7jGFDyFWVp40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYe1pt13wu1jKMhkLJRsbp6DU5CBV9MhJMzbXUhda1gYiyiDsIRd2pqMrwqjxmQ80
	 Ww1C+AsbguTGr/UCNAjjoTHwU2ey2geSFsEPbs5kb8saRB14o590a89qBhSfxnse/P
	 RAhVwFA+ktP3eVUCPCAQvzmosFEKWxeN35tlGRVul7hkwkSoyTnwmIG0rnuF+wwU69
	 0Ejuiu7KfaSc7NbM7FTXRa2Iv4EUQRfm2+n5HE6LcVUPyH6M4uPJ1Ft+yt8RGEhTUz
	 xp/cDwizkg0RoRqwkA9BicLcB88wdn1dO3Wzno1R5kh2mphIe1zudi/Eu3FlUPdvwX
	 jTVlhD2xKhlTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] perf tools: Use scnprintf() in
 build_id__snprintf() and hwmon read_events()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608013057.1942953-12-acme@kernel.org>
References: <20260608013057.1942953-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:54:33 +0000
Message-Id: <20260608015434.37F7E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing size adjustment in read() and pread() size arguments leads=
 to out-of-bounds null termination on stack buffers.
- [High] If the `read()` system call returns `<=3D 0`, uninitialized stack =
memory is evaluated and potentially duplicated, leading to an information l=
eak or crash.
- [Medium] A flawed check `if (fd > 0)` fails to process or close file desc=
riptor 0, causing a resource leak if openat returns 0.
--

commit 63dc76c4229ffb5cbb25da7f0bdc34b17ef66fae
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()

build_id__snprintf() and hwmon_pmu__read_events() accumulate formatted
output via snprintf(), which returns the would-have-been-written count
on truncation. In hwmon_pmu__read_events(), len overshoots out_buf_len
and the next 'out_buf_len - len' underflows. Switch both to scnprintf()
which returns actual bytes written.

[ ... ]

> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index fb3ffa8d32ad2..dbf6a71af47f9 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmo=
n_pmu *hwm, char *out_buf, si
> =20
>  				buf[read_len] =3D '\0';
                                ^^^^^^^^^^^^^^^^^^^^
[Severity: High]
This isn't a bug introduced by this patch, but doesn't this result in an
out-of-bounds write?

Since read() can return up to sizeof(buf), if the sysfs file contents
completely fill the buffer (i.e. read_len =3D=3D sizeof(buf)), writing the =
null
terminator here will overwrite one byte past the end of the buf array on the
stack.

Could we pass sizeof(buf) - 1 to read() to avoid this?

This same pre-existing issue seems to be present in hwmon_pmu__read_events()
and evsel__hwmon_pmu_read() as well, where read() and pread() are called wi=
th
the full buffer size and similarly null-terminated.


[Severity: Medium]
Also a pre-existing issue in hwmon_pmu__describe_items() just above this hu=
nk,
can this leak a file descriptor?

hwmon_pmu__describe_items() opens a sysfs file using openat(), and then che=
cks:

    fd =3D openat(dir, buf, O_RDONLY);
    if (fd > 0) {

If the tool runs in an environment where standard input has been closed,
openat() can successfully return 0. The current logic treats 0 as an error,
skips file processing, and fails to call close(fd), causing a resource leak.

Should this check be if (fd >=3D 0) instead?


[Severity: High]
Another pre-existing issue in hwmon_pmu__read_events(), can this leak
uninitialized stack memory?

If read() returns 0 or less (for example, on an error or empty file), read_=
len
will be 0 or less. The code skips null-terminating the buffer and proceeds
to check:

    if (buf[0] =3D=3D '\0') {
        ...
    value->label =3D strdup(buf);

Since char buf[128] is uninitialized, wouldn't evaluating buf[0] and passing
buf to strdup() result in reading and copying garbage stack memory until it
hits a random null byte?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013057.1942=
953-1-acme@kernel.org?part=3D11
