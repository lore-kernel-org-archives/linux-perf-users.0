Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FF3542F6
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Oct 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657299; cv=none; b=K0nAuaWA914pspwO+Nt61MeHm3G7wvRbsHEFDEtd91IIKfmz5aCzxuAAny9xycR9Wo1n8rGCgKb+XoyVU32gQd220xzg8UiUa/cx2NP2nXp7gLlsfxpLUr6nodDWyWvgWNZMnKTjOFI7GSJWgiTOWOkoEPkYC00oTPr0i4qst64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657299; c=relaxed/simple;
	bh=ZeV3luTVDkcPmjQXrGff/1RhuHrsVr6VcqxvO+I7yv8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g/nk2QWaaq9MuupOE3Nznrb/vuEJCK0Wq1tKZSW5znkLfruunQ0oe+E0TlYVx7dpVV1HLW/QVhwHqdNSixWoei60j+cqt4TIcbfU/IoYio+95aEhWR2OFINZatQaimoh+qjudXCQLqamInYvKHkOu+HmMX/Ps8lpXGjW9EgWhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWkC/+Ju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWkC/+Ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C883E1F000FF;
	Sat, 10 Oct 2026 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791657297;
	bh=7xqidzMSD4700cYht6d5NJj0AJmv1kSQm3HoZM0LQbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWkC/+Ju5oNyKUQsWh66jZhDo/KpsVaq1XIVF2rG5+yGmsHEBQzykuPG8sUdzTBZx
	 3nAaa9ccYuc2fwhPH9OuHXMNwx2MlW0YbpT2UWlUngVWUDTaIiMH6Kpq51WxOIY0cL
	 LRL3ypm9xQiSWP/YE59xNQ8pIcibLZdXEVBV10PwVl7Tnusc4o0tFHsfjR76o5khQt
	 q2KbeNcYjalkH3YPe60N6pNXwPKVB18QnympVKRn+NiyFPHb1Ax1B+l1b0UpJed6Y1
	 Z7RLkXEC3jXkoh9IEzOxKPQnmOSaPSqlPn1nvyy5+RQkVcOX4gfP9J/oIQiYBR7JSB
	 SSX8F6pwgKyEg==
Message-ID: <sashiko-outbox-166826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf symbol: Add missing symsrc__destroy() for
 libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261010182439.9732-2-namhyung@kernel.org>
References: <20261010182439.9732-1-namhyung@kernel.org>
 <20261010182439.9732-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 18:34:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: double free and UAF in libbfd fallback logic
--

commit 27e7b4b66a3038201c422641092c060f7b466328
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Add missing symsrc__destroy() for libbfd

This commit aims to prevent memory leaks and symbol overwrites by destroying
any pending syms_ss when libbfd successfully loads symbols.

Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 6e327eaec8c0e..5e63c3477570c 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1925,6 +1925,10 @@ int dso__load(struct dso *dso, struct map *map)
>  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> =20
>  		if (bfdrc > 0) {
> +			if (syms_ss) {
> +				symsrc__destroy(syms_ss);
> +				syms_ss =3D NULL;
> +			}

[Severity: High]
Can this sequence lead to a use-after-free and double free later in the
function?

If syms_ss and runtime_ss were both set to point to the same symsrc object
in an earlier iteration of the candidate debug images loop, this block
destroys the object and clears syms_ss, but leaves runtime_ss pointing to
the now freed memory. The object also remains tracked in the ss_ array.

After the loop breaks, could the fallback logic in dso__load() resurrect the
destroyed object:

	if (runtime_ss && !syms_ss) {
		syms_ss =3D runtime_ss;
	}

This appears to lead to dso__load_sym() being called with the destroyed=20
syms_ss object, which would cause a use-after-free and overwrite the=20
successful ret =3D 1 result from BFD:

	if (syms_ss)
		ret =3D dso__load_sym(dso, map, syms_ss, runtime_ss, kmod);

Finally, since the destroyed object was never removed from the ss_ array,=20
would the cleanup block at the end of the function trigger a double-free?

	for (; ss_pos > 0; ss_pos--)
		symsrc__destroy(&ss_[ss_pos - 1]);

>  			ret =3D 1;
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010182439.9732=
-1-namhyung@kernel.org?part=3D2
