Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D44499A4
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636295; cv=none; b=VO1ZOZ1JF4DBH7KvYVHYk8Mr1CSygRtAll/tsaebkmqScZ5rJeBNhZpdD7H2A+/GyrpDf/o+7BbE2+pdoxyy8+qn1/Hxzs3Ft8hURd5sbUxTT55GqSwvhw5taUu2I5WwvL+yj0al1D5gx4Q1InVzgyYtLHwmeSuipUh5mv+qCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636295; c=relaxed/simple;
	bh=sXLe0iW1Tfnu57u61k9rDmqbRzz5TYPnykF2bB3t8CE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=buuAdF7iiLTTlOFhJmBpXTv2t0w/ODuqyD6/UWaUaE5RlA5YC6ew9MBg5eMtoUenJNyl1og9xn9lPYxjOgansYdcXHsi8W8dRqldQFWDG7su0EK9a0ecVAAwJzeR8fXOBmknaD5sdtbqmGYLFEDt2WNmC1k9B9lqUAavtu+1gV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg0MBoEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg0MBoEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC1B1F00A3A;
	Thu,  9 Jul 2026 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636293;
	bh=ZRvd0s1rlKT5nRcynjmoUgeUpZGBqGC4xMuguYycosA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cg0MBoEi/a0DDaOD7abNRFz1BerT1NRFiXeBRJSlLkSHwKQOj2qD+vKQAYDfu1f2x
	 COTKKFBym6v38QirQn6BvrXfOATvqOhfRtt2Lz039Z1UcfWlyFyJdd0jxBbO7z6Jii
	 66NzQj/ZeUXw31Bdp3NHtddCfm/ptwGxaQHLNjd0K5UlrsPds1YpfD6bm8ZGADZ4si
	 Kz0DwK2lhsbeEkTx7e1zmUsJ8HcwTiEn1tyL5lmTs9m060LtaHtmz+KWByBNQF6mEG
	 5ZlqZffy89aXdQkubS+2rUNcaZZQwUA1PLu95Bg83mlPY4DXQAsX1AQP0+hZkbDAb0
	 a1jAYqhzVxnwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709221736.33446-6-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
 <20260709221736.33446-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:31:33 +0000
Message-Id: <20260709223133.9FC1B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Asymmetric enforcement of `MAX_MEMORY_RANGES` allows `perf recor=
d` to create perfectly valid files that `perf report` will fatally reject.
- [Medium] TOCTOU race during sysfs parsing can cause `perf record` header =
generation to abort.
- [Medium] Unchecked return value of `sysfs__mountpoint()` is passed direct=
ly to `scnprintf` as a `%s` argument.
--

--- Patch [5]: [PATCH 5/6] perf header: Support memory ranges ---
commit 42917cf527bf0744d5a38079c4d626fee56bf5e9
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

Memory ranges are parsed from the ACPI MRRM table via sysfs and saved in the
perf data file under HEADER_MEMORY_RANGES. This data can be viewed with
perf-report and perf-script.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 091d8f7f6bd2c..5c1f767dad159 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -92,6 +92,7 @@
>  #define MAX_PMU_CAPS		512
>  #define MAX_PMU_MAPPINGS	4096
>  #define MAX_SCHED_DOMAINS	64
> +#define MAX_MEMORY_RANGES	64
> =20
>  /*
>   * magic2 =3D "PERFILE2"
> @@ -1891,6 +1892,126 @@ static int write_cpu_domain_info(struct feat_fd *=
ff,
>  	return ret;
>  }
> =20
> +static int memory_range__read(struct memory_range *range, int idx)
> +{
> +	char path[PATH_MAX], file[PATH_MAX];
> +	struct stat st;
> +	int tmp;
> +
> +	scnprintf(path, PATH_MAX, "firmware/acpi/memory_ranges/range%d", idx);
> +	scnprintf(file, PATH_MAX, "%s/%s", sysfs__mountpoint(), path);

[Severity: Medium]
Can sysfs__mountpoint() return NULL here if sysfs is not mounted?

If it does return NULL, would passing it directly to the %s format specifie=
r in
scnprintf() cause a segfault on environments using strictly compliant C
libraries like musl?

> +	if (stat(file, &st))
> +		return -1;
> +

[ ... ]

> +static int memory_range__parse(struct memory_range **ranges)
> +{
> +	int i, err, nr_memory_ranges =3D 0;
> +	char path[PATH_MAX];
> +	struct stat st;
> +
> +	scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges", sysfs__moun=
tpoint());

[Severity: Medium]
Is there a similar risk here of sysfs__mountpoint() returning NULL when
evaluating the initial base path?

> +	if (stat(path, &st))
> +		return 0;
> +
> +	while (1) {
> +		scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges/range%d", sy=
sfs__mountpoint(), nr_memory_ranges);
> +		if (stat(path, &st))
> +			break;
> +
> +		nr_memory_ranges++;
> +	}
> +
> +	if (nr_memory_ranges =3D=3D 0)
> +		return 0;
> +
> +	*ranges =3D zalloc(nr_memory_ranges * sizeof(struct memory_range));
> +	if (!(*ranges))
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < nr_memory_ranges; i++) {
> +		struct memory_range range;
> +
> +		err =3D memory_range__read(&range, i);

[Severity: Medium]
Could there be a race condition if a memory range is dynamically removed fr=
om
sysfs between the initial counting loop above and this read loop?

If a range is removed, memory_range__read() will return -1, which propagate=
s up
and aborts feature writing. Should the reader gracefully handle missing ent=
ries
that were counted moments before instead of failing the entire operation?

> +		if (err < 0)
> +			goto out_error;
> +
> +		(*ranges)[i] =3D range;
> +	}
> +
> +	return nr_memory_ranges;
> +
> +out_error:
> +	zfree(ranges);
> +	return -1;
> +}
> +
> +static int write_memory_ranges(struct feat_fd *ff,
> +			 struct evlist *evlist __maybe_unused)
> +{
> +	struct memory_range *ranges =3D NULL;
> +	int nr_memory_ranges =3D 0, ret;
> +
> +	nr_memory_ranges =3D memory_range__parse(&ranges);
> +	if (nr_memory_ranges < 0)
> +		return nr_memory_ranges;
> +
> +	ret =3D do_write(ff, &nr_memory_ranges, sizeof(nr_memory_ranges));
> +	if (ret < 0)
> +		goto out;
> +
> +	for (int i =3D 0; i < nr_memory_ranges; i++) {

[Severity: Medium]
Does this write loop allow writing more than MAX_MEMORY_RANGES (64) entries
into the perf data file if the system has more than 64 ranges?

> +		ret =3D do_write(ff, &ranges[i].base, sizeof(u64));
> +		if (ret < 0)
> +			goto out;

[ ... ]

> @@ -4201,6 +4339,54 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>  	return ret;
>  }
> =20
> +static int process_memory_ranges(struct feat_fd *ff, void *data __maybe_=
unused)
> +{
> +	struct perf_env *env =3D &ff->ph->env;
> +	struct memory_range *ranges, *r;
> +	u32 nr_memory_ranges, i;
> +
> +	if (do_read_u32(ff, &nr_memory_ranges))
> +		return -1;
> +
> +	if (!nr_memory_ranges) {
> +		pr_debug("memory ranges not available\n");
> +		return 0;
> +	}
> +
> +	if (nr_memory_ranges > MAX_MEMORY_RANGES) {
> +		pr_err("Invalid memory_ranges: nr_memory_ranges (%u) > %u\n",
> +		       nr_memory_ranges, MAX_MEMORY_RANGES);
> +		return -1;
> +	}

[Severity: Medium]
If the writer successfully records more than MAX_MEMORY_RANGES (64) entries=
 on
a large system, won't this strict limit in the reader cause perfectly valid
perf.data files to be rejected?

Since the writer dynamically discovers all ranges without limits, should the
reader also process all recorded ranges instead of imposing a static 64 lim=
it?

> +
> +	ranges =3D zalloc(nr_memory_ranges * sizeof(*ranges));
> +	if (!ranges)
> +		return -1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709221736.3344=
6-1-thomas.falcon@intel.com?part=3D5
