Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0D3B1EEF
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062384; cv=none; b=D6VIF+Eq4guZQ+IB/VwYR7bky+ATlZZxxkECbIUSlgHznhGlR+w4kstudXK5HPFrj3s3h0gaPM+Vr6Te3fg/4p9dgFmDLvpJ5NqYZamo5pc5qzxZ0ow0ihW4AIhuqI7e0ib3SZ3C0TF9+OjYfkGM5Ul8covrsuiPd14oA4Dg0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062384; c=relaxed/simple;
	bh=LU6WCHErLHsGIPHlykWu/TIAmlmlT7dJz0yps7sFc+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b7oY27Mrg25WHexZTokdeBnvVcxS7cfe9DGqt12xIjXT9BxqWmFN16kXZTX6vHR+PmFa2ECYQAXNHBRa99uwpbrWvLY8jq4uEgQWVdLFqmJ8+5sljgOcl8zm0PnFi8Nc/Mwvu5pxwP6qIyDMteuNpV9LEePId3Ff/EQVvNEXIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL4luTEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL4luTEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E161F000FF;
	Thu, 10 Sep 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062371;
	bh=+FcDi1DIa/75oA0SfMh6LA0xZgWX4/9b+gow3osusAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jL4luTElkAFq8lNbHoO/glcS7MecX9R4qUhFH2b0eGGn7o9lT569HOLadiBg+33dC
	 JQZtyxsO/5f0vtPObesDpB6YYyMTqBrFmxCw53sBLBX7wrDxrGSjNiqU0EXzwTFwpM
	 ye9vnnp+KqJBVI6TudcFG/xH1cbWpaEsJpF3JdzVDO/FH6X6aZ0r48YDiYP02KcPG4
	 JB2a/X5X2cKChXUNrZZdoOgKBAO+O9h7oECD616jP2Sq7m+TVlk7MU8dfCDosiDVNL
	 XBhrxMLIQFRfzB+DIj//M32g2F84MQEkJCExZJdcron9Uw1yKkfq9UIsFUBNn2xj9Z
	 1FcXPsuBgvXoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] perf header: Transition WARN macros to debug.h
 equivalents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910173715.2996571-3-irogers@google.com>
References: <20260910173715.2996571-1-irogers@google.com>
 <20260910173715.2996571-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:46:10 +0000
Message-Id: <20260910174611.47E161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing newline character at the end of the pr_warning format strin=
g.
--

commit 4a0b2ee01b018f0849023322af221ce512de09c8
Author: Ian Rogers <irogers@google.com>

perf header: Transition WARN macros to debug.h equivalents

This commit avoids a checkpatch.pl warning on the use of asm/bug.h by
switching the use of WARN macros to explicit tests and using pr_warning from
debug.h.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 78b16a098148a..a3e6c334a2894 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -1108,9 +1113,10 @@ static int write_dir_format(struct feat_fd *ff,
>  	session =3D container_of(ff->ph, struct perf_session, header);
>  	data =3D session->data;
> =20
> -	if (WARN_ON(!perf_data__is_dir(data)))
> +	if (!perf_data__is_dir(data)) {
> +		pr_warning("Expected data to be a directory");

[Severity: Low]
Does this pr_warning() need a newline character at the end of the format
string?

Unlike some kernel-space printk variants, the user-space pr_warning() does
not automatically append a newline. If perf attempts to write the directory
format but perf_data__is_dir(data) evaluates to false, this could result in
consecutive diagnostic messages, error logs, or the user's shell prompt
improperly concatenating to the end of this warning message.

>  		return -1;
> -
> +	}
>  	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
>  }
[ ... ]
> @@ -3714,9 +3720,10 @@ static int process_dir_format(struct feat_fd *ff,
>  	session =3D container_of(ff->ph, struct perf_session, header);
>  	data =3D session->data;
> =20
> -	if (WARN_ON(!perf_data__is_dir(data)))
> +	if (!perf_data__is_dir(data)) {
> +		pr_warning("Expected data to be a directory");

[Severity: Low]
Similarly here in process_dir_format(), should this warning string include a
trailing newline to prevent visual formatting glitches on the console when
processing a malformed directory format?

>  		return -1;
> -
> +	}
>  	return do_read_u64(ff, &data->dir.version);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910173715.2996=
571-1-irogers@google.com?part=3D3
