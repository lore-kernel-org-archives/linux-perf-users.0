Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93E37A848
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407009; cv=none; b=YeX6vfxkcMiAMa7PPMcEgflyp83EMgEyGo83zprac2WSIKJGWAjdRNVitgwyZoO6fKNZwiVzBDNmvMoBzK69TmJ87KGFt1i6Z5TaOZXDidoCVMsZjX5bi93/6QjgbHwiiDw30j5LHs/wg5+VXyLPNWEaRLdEaHLSyqGbwPH41jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407009; c=relaxed/simple;
	bh=e58amcfmuDXgOTGgGJ7Pl4MjuNxx67WMXAJ56gY6B+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iwU1IJPTntiC4EUtDPJW3F8gpxqJUByFF/Fb9pCD8mRqVbu0hj37M1MSsVojuppzOho0m43P5duF3+wwaCktBd0fCZINlqTSl4zT4aY8H7qwwgakFRwLogwzatO7sbGrI7o4AYF5ZHvwm5Uw8u2Q324x3sAswnjDzo2YmAJFkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq8MKm+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq8MKm+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFD91F000FF;
	Mon, 14 Sep 2026 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789407007;
	bh=zFo2B5psX36ftJToAPl2SIeEtfgzIgL7CKP0PFb4ZMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hq8MKm+z5wLjixNauh7i491ipbr/A1evAkeeZA+CoSUR7soyGM0m8rBQHPCBqCRkA
	 4ocZhfGjsrBAaB95k7RkdpKBXQHsIHWQGS+y397i0vNIQvyWtwzsqiOR47vBgHJbMW
	 OLyz/gV3tn69x/0Sa6QozOGgx6gA2ksY0LGaDlZD4STUhrSP1wXaPyMqq730pLQYc1
	 lsMBTN3RjFWOOIfmt/hcIhJuYve1XRB6Qcd+8hSOFsvhcxdX8Iv3Xza6Gi1HljqiHb
	 8ojEvuKqR58fiwiVvLQD0WZIhqGvwUQ1kjLzQCe1SwTDTTutHWd7k1mJLgKZstR3Yi
	 cvs4QRBtbA3XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf libdw: Fix Dwfl discovery with split files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914170759.1992947-1-irogers@google.com>
References: <20260914170759.1992947-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:30:07 +0000
Message-Id: <20260914173007.9DFD91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Early error return in `cmd__addr2line` leaves the addr2line subpro=
cess pipe in a dirty state, corrupting subsequent IPC queries.
--

commit 15f52b88a78ae8721f4ec48695f230d6450c86f6
Author: Ian Rogers <irogers@google.com>

perf libdw: Fix Dwfl discovery with split files

This patch dynamically frees the cached Dwfl object and alternative a2l
caches whenever a newly discovered split-debug file is assigned to a
dso, and scopes accessors behind a mutex.

> diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> index 4b0d349ed334b..7c7eea3cc8dd2 100644
> --- a/tools/perf/util/addr2line.c
> +++ b/tools/perf/util/addr2line.c
[ ... ]
> @@ -414,12 +426,21 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>  	}
> =20
>  out:
> +	mutex_lock(dso__lock(dso));
>  	free(record_function);
>  	free(record_filename);
> -	if (io.eof) {
> -		dso__set_a2l(dso, NULL);
> +
> +	current_dso_name =3D dso__symsrc_filename(dso) ?: dso__long_name(dso);
> +	if (!io.eof && dso__a2l(dso) =3D=3D NULL && current_dso_name &&
> +	    !strcmp(current_dso_name, dso_name))
> +		dso__set_a2l(dso, a2l);

[Severity: High]
This is a pre-existing issue, but an early error return in cmd__addr2line()
(such as a memory allocation failure when calling inline_list__append_recor=
d()
or a parsing failure in read_addr2line_record()) aborts the read loop and
jumps here without consuming the rest of the IPC stream.

Since EOF is not reached during an early abort, does this incorrectly
restore the dirty subprocess pipe back into the cache? It appears this
leaves unread output in the pipe, which could corrupt subsequent address
resolutions for this DSO when other threads query it and read the
leftover garbage data.

> +	else
>  		addr2line_subprocess_cleanup(a2l);
> -	}
> +	mutex_unlock(dso__lock(dso));
> +	return ret;
> +
> +out_unlock:
> +	mutex_unlock(dso__lock(dso));
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914170759.1992=
947-1-irogers@google.com?part=3D1
