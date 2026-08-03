Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3E27603F
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790873; cv=none; b=QWA1eSNwQGAR9RKDBGEq8ghtjcp/7irwxCU75RVV7xfWFf6gr/c7Kz3/4xxv0xRWxt6tNrgWq3CDLNFsxyu+Uf6+LWyIpfS70JjCxszeb22I+NuKCq2AzhpaoapSSLbZB4Pe8Tv/6XEMR9S+3YPWfZSzj9EXTmPzbwI+e+EoSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790873; c=relaxed/simple;
	bh=1+f2UtmWToUlmHfl8PR2/lo6G0T38FVl6GRMhuIiUAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t2If3Dg8UMEphIondgXfbjxZ4FS14ni/3x1Qe3RdjB/2vZfaXcLvzuaBFrXirlSvQwDZ5+97sDKmu+Mo+Uakv4NBOETh0798lUo4+Y8ND7oQstY3WAafiiH0H6Y6xrAjv5mJoADMb0NR6PN+DoaUL7G1Rix3HV4+115lPZyj5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chDdxcVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chDdxcVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDDF1F000E9;
	Mon,  3 Aug 2026 21:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790871;
	bh=qVU+uDoC42KHUScHzV2kXP41hApsfi4GIXlRgONTSL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=chDdxcVcJbUOj32AUywwhF0SNNkr/aSXfWpAr6LFSBXSac3bJqrc/FBB2od+U8VAt
	 xTBH3p38LkqrVR+zOpovuQxjrd3c7l0lR+x9Zl+FUzLjCqicRTgTpqdfo9WXPwnGSo
	 XAeSqaBj46rjY5KC/PkMysGq9fTkBrl1mOnfQHGRJzjn9wK6IWOCiRQUyqLirKO9uI
	 kObx3AVOyyZqTKbNAZqSKgUhH8/ml0xu03DDtT9rzuAspB0gWfp5QaM7/RGiEt+Qc5
	 fwNrBYBJemNkCVd3v6O5Eupj2ZFh8kFk+ZYAFv7Km46xVXv2Hfd9g3qjvVAZDf6BU2
	 4puMwoa5rFIwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803204540.100348-6-thomas.falcon@intel.com>
References: <20260803204540.100348-1-thomas.falcon@intel.com>
 <20260803204540.100348-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 21:01:10 +0000
Message-Id: <20260803210111.4CDDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `perf_mem__show_region` flag is evaluated before feature eve=
nts are processed in pipe mode, permanently hiding the memory region field =
for piped inputs.

Pre-existing issues:
- [High] Stack buffer overflow in memory event formatting due to missing bo=
unds checks, unbounded `strcat`, and unsigned integer underflow.
--

--- Patch [5]: [PATCH v3 5/6] perf tools: Show memory region in perf-script=
 subcommand ---
commit 453eaf4e1cef12c5307d93d17b31ce0722004b14
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand

This commit adds support for showing the memory region in the perf-script
subcommand. It maps the mem_region field of the memory information data
source into a new Region field in the output.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4468,6 +4468,9 @@ int cmd_script(int argc, const char **argv)
>  	if (show_full_info)
>  		script.tool.show_feat_hdr =3D SHOW_FEAT_HEADER_FULL_INFO;
> =20
> +	perf_mem__set_show_region(perf_header__has_feat(&session->header,
> +							HEADER_MEMORY_RANGES));
> +

[Severity: Medium]
Will this correctly identify the memory region feature when reading from a
pipe?

In pipe mode, the session header features are not fully populated until
PERF_RECORD_HEADER_FEATURE events are processed dynamically during
perf_session__process_events(). Evaluating perf_header__has_feat() prematur=
ely
here causes it to evaluate to false and permanently hides the memory region
field.

>  	if (symbol__init(env) < 0)
>  		goto out_delete;
> =20
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
[ ... ]
> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct=
 mem_info *mem_info)
> +{
> +	size_t l =3D 0;
> +	u64 mem =3D PERF_MEM_REGION_NA;
> +
> +	sz -=3D 1; /* -1 for null termination */
> +	out[0] =3D '\0';

[Severity: High]
This is a pre-existing issue, but does this code safely handle the case whe=
re
sz is already 0?

If this function is called with sz =3D 0 due to earlier buffer exhaustion,
sz -=3D 1 will underflow to SIZE_MAX and blindly write a null byte out of b=
ounds.

[ ... ]
> @@ -620,6 +693,10 @@ int perf_script__meminfo_scnprintf(char *out, size_t=
 sz, const struct mem_info *
>  	i +=3D perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|BLK ");
>  	i +=3D perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
> +	if (perf_mem__show_region) {
> +		i +=3D scnprintf(out + i, sz - i, "|Region ");
> +		i +=3D perf_mem__region_scnprintf(out + i, sz - i, mem_info);
> +	}
> =20
>  	return i;
>  }

[Severity: High]
This is a pre-existing issue, but can this sequence of formatting operations
cause a stack buffer overflow?

If a crafted perf.data file has an event with all memory levels, snoops,
and TLB bits set, the combined string might exceed the fixed 200-byte stack
arrays in data_src__fprintf() and set_sample_datasrc_in_dict().

Because i is accumulated without checking if i < sz, the expression sz - i
passed to subsequent functions can underflow to SIZE_MAX, disabling all
remaining bounds checks.=20

Furthermore, pre-existing helper functions like perf_mem__lvl_scnprintf()
unconditionally use strcat() regardless of remaining buffer capacity:

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
    ...
		if (printed++) {
			strcat(out, " or ");
			l +=3D 4;
		}
    ...
}

Will this cause memory corruption if the buffer limit is exceeded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803204540.1003=
48-1-thomas.falcon@intel.com?part=3D5
