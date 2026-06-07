Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213E1DFF0
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780876038; cv=none; b=c7hZRSifXmJ8HaCDJvzbSIE/y0O15Nv78W424G4apgB+gIoO3gdgKlkQIeHphCiHWvb+Ve82NLnK3Tm31P7F2lJkMU6AiCKh8DBD39Qk/VsW5HWDvpt2rXx9qwKsVYkl2Le6hWkYEpbc8RGqGrByiYpSW6Bz0VUdLPXMT4Ek8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780876038; c=relaxed/simple;
	bh=2WNYL6A/nnTIvWPcEHWN/qKKYEa34K4mjWF0nww9U4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7gBQJcVuf+gD3EEuoCpQUk7tt6jMTUUUO3s5DkAsmzE7JWAtaGZuqmcsca4IPuEdMwICb+BeoT56DUpyccdpVpW9l8LbRmh/bzyjHmMTbmzrczNub34fL/59bf13Q/rmlGkB/666M4fyAthbEfM8s4sXfGGBYwMKjgDzQYUpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5fp6hJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5fp6hJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E71F00893;
	Sun,  7 Jun 2026 23:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780876037;
	bh=t3IcSuHPF5mek/S/JqDZI3BsqCmIX5DEixjx14ugdNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5fp6hJKzibi7vQILb0wCr5ZJkYdHDj0n5DrU2HFo+3u6zGjmCyukGXYL0qLVwzuL
	 HXFwUnUSnT1OwtEH0ViU4yAL1jJb9JoIWvSdf8/VtJexdQcigPX7c+T341rmZtC/t9
	 uMc2MOSRCUTya9f7hNlnvISvzjrq76u1jQC9vLyZGeQsL6Vlwsbx1+tFiTFWPJZX5J
	 PZPCqwBPPlSzGIBsLoZM167FuxJ38jNQX01DUYzZFPoDuE8yFYe0JP8vwsvJU7klXk
	 Yqu2EMMBKfibm6UtXZlzBtdookC0EqUHxfxkk8uTW/t+AR4iOb1g5dIiZBB61VTHgM
	 Q/gVwghqZCOjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] perf hists: Fix snprintf() in
 hists__scnprintf_title() UID filter path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607232925.1935819-11-acme@kernel.org>
References: <20260607232925.1935819-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 23:47:16 +0000
Message-Id: <20260607234716.EC2E71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer overflow in config_show() via test_driver/test_fs sysfs att=
ributes due to snprintf underflow.
- [High] Buffer overflow in pm80xx_get_non_fatal_dump() when reading sysfs =
attributes due to unbounded snprintf usage.
- [Medium] Stack buffer overflow in hwmon_pmu__for_each_event() due to snpr=
intf underflow.
- [Medium] Stack buffer overflow in perf_pmu__for_each_event() when parsing=
 PMU aliases due to snprintf accumulation.
--

commit 68f841f9ed7f1af9b87ee345589a137d67d74612
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path

This commit replaces snprintf() with scnprintf() in the UID filter path
of hists__scnprintf_title() to prevent buffer size underflow. It ensures
consistent buffer length calculation, matching the rest of the function.

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 811d68fa6770c..df978c996b6c2 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2963,9 +2963,10 @@ int __hists__scnprintf_title(struct hists *hists, =
char *bf, size_t size, bool sh
>  			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
> =20
> =20
> -	if (hists->uid_filter_str)
> -		printed +=3D snprintf(bf + printed, size - printed,
> -				    ", UID: %s", hists->uid_filter_str);
> +	if (hists->uid_filter_str) {
> +		printed +=3D scnprintf(bf + printed, size - printed,
> +				     ", UID: %s", hists->uid_filter_str);
> +	}
>  	if (thread) {
>  		if (hists__has(hists, thread)) {
>  			printed +=3D scnprintf(bf + printed, size - printed,

While reviewing this fix, I noticed a few similar pre-existing issues in
other areas of the codebase where snprintf() return values might cause buff=
er
overflows.

lib/test_kmod.c:config_show() {
    ...
	if (config->test_driver)
		len +=3D snprintf(buf+len, PAGE_SIZE - len,
				"driver:\t%s\n",
				config->test_driver);
    ...
}

[Severity: High]
This is a pre-existing issue, but could this calculation underflow
PAGE_SIZE - len?

Since test_driver can be up to PAGE_SIZE bytes long, the accumulated length
can exceed PAGE_SIZE. If snprintf() returns the would-have-written length,
does the subtraction result in a large positive value that allows subsequent
snprintf() calls to write out of bounds of the sysfs buffer?


drivers/scsi/pm8001/pm80xx_hwi.c:pm80xx_get_non_fatal_dump() {
    ...
	for (index =3D 0; index < output_length/4; index++)
		buf_copy +=3D snprintf(buf_copy, PAGE_SIZE,
				"%08x ", *(temp+index));
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but might this loop write beyond
the bounds of the sysfs buffer?

The pointer buf_copy advances with each write, but the size parameter passed
to snprintf() is constantly PAGE_SIZE instead of the remaining buffer space.
If the hardware provides a large output_length, would this continuously wri=
te
up to PAGE_SIZE bytes and cause a heap buffer overflow?


tools/perf/util/hwmon_pmu.c:hwmon_pmu__for_each_event() {
    ...
		char desc_buf[256];
    ...
		len =3D snprintf(desc_buf, sizeof(desc_buf), "%s in unit %s named %s.",
			hwmon_desc[key.type],
			pmu->name + 6,
			value->label ?: info.name);

		len +=3D hwmon_pmu__describe_items(hwm, desc_buf + len, sizeof(desc_buf) =
- len,
						key, value->items, /*is_alarm=3D*/false);
    ...
}

[Severity: Medium]
This is a pre-existing issue, but is there a risk of a stack buffer overflow
here?

Since value->label can be up to 255 bytes, snprintf() might return a length
greater than sizeof(desc_buf). Would passing sizeof(desc_buf) - len to
hwmon_pmu__describe_items() then underflow to a massive size_t value,
allowing scnprintf() to write out-of-bounds on the stack?


tools/perf/util/pmu.c:perf_pmu__for_each_event() {
    ...
	char buf[1024];
    ...
			buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
					"%G%s", event->scale, event->unit) + 1;
		}
		info.desc =3D event->desc;
		info.long_desc =3D event->long_desc;
		info.encoding_desc =3D buf + buf_used;
		buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
    ...
}

[Severity: Medium]
This isn't a bug introduced by this patch, but does accumulating the snprin=
tf()
return values into buf_used risk underflowing sizeof(buf) - buf_used?

If an earlier snprintf() truncates, it returns the number of bytes it would
have written. Could this cause buf_used to exceed sizeof(buf), making the
size limit on the next snprintf() underflow and write beyond the end of the
stack buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607232925.1935=
819-1-acme@kernel.org?part=3D10
