Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7794266A1
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646164; cv=none; b=NkcPTmk+/Th7wjz70D/5M6CmrHRMfYzlNcXmY58z8Z3wJQ/3Fp0znzh6sGdW0zENJyIopzdevDodC9L48RXOljMu8hO80TL3d/PTu/MXf1Thx0hIbH0iU5A+8MBHj8xza/FYiGkDo+JEbZuqRxZaNUAWT17CVi0z8cci1Db7cN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646164; c=relaxed/simple;
	bh=0NUf56Rdvn0wai6mmW6CNCl8bP+6AQJ078jqvw50Puo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E8gbC/yiSoT78Smu+wu2MwZ34KOBOKDRp/7NhfMbfJuHi+aUUGVjGWjAjj8bzB+YEqaaIadPzO/sjQ5Ga5ogsU7ZyjjagOBXS2RoQRgnhVBRwBOMn/Q5KoVHdpItfQezMS7qP4lQVhIJP90xBvJ3fRaT3L7DSdQ7PA25wXETCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu9JuCcJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu9JuCcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E4C1F00893;
	Fri,  5 Jun 2026 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646163;
	bh=9vYd7Qe9PiM6NYzF1Gx7yoFSfmerayvygTRGOflGOSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bu9JuCcJ1P2qD13/XOamaTkxcOvK1nFy2iATyzUF5w6rg8P/v3JN4lYPrHH/t4TIX
	 OJ265CeX/kHc4LLQiFNFNJPB+FMSS//+O/kXXq9UWs1jfkv8BtkuKnxszRa1nR1pfz
	 /CQnaNiMdRUDjGAbCYw9z5DM9093jQj0qwvmMdQ0MQ7Z85zOLdhyJ3NAP/m7ZxVYFh
	 fE082oF4OVasbcTIMpgQ2/p8Geam8m5TyfrYmUgBXLh8aqGN0nxrAaUpJgqBd+xqOC
	 OEhlXX83P8abbZ/RSFokF8pnzo39vmakMx0d2SuuDRNzM8Y9A5gqRl8fVALOYWhiA6
	 yqcZ1m2T36OrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/19] perf data: Add open flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-5-irogers@google.com>
References: <20260605074003.1730715-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:56:02 +0000
Message-Id: <20260605075603.70E4C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A time-of-check to time-of-use (TOCTOU) vulnerability exists when =
opening the perf data file for writing, which can be exploited to truncate =
arbitrary files.
--

commit 6ea2670fcd0afaed23b29eb27c1bda1c709e9986
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

Avoid double opens and ensure only open files are closed. This
addresses some issues with python integration where the data file
wants to be opened before being given to a session.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 94dc534a73866..33fd1b82019eb 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
[ ... ]
> @@ -375,16 +383,24 @@ int perf_data__open(struct perf_data *data)
>  	if (perf_data__is_read(data))
>  		data->is_dir =3D is_dir(data);
> =20
> -	return perf_data__is_dir(data) ?
> -	       open_dir(data) : open_file_dup(data);
> +	ret =3D perf_data__is_dir(data) ? open_dir(data) : open_file_dup(data);

[Severity: High]
This isn't a bug introduced by this patch, but is there a time-of-check to
time-of-use (TOCTOU) vulnerability when opening the perf data file for writ=
ing?

In perf_data__open(), check_backup() is called to verify if the target file
already exists, renaming it to .old if so. However, there is a race conditi=
on
between this check and the subsequent file creation in open_file_write()
called via open_file_dup():

tools/perf/util/data.c:check_backup() {
    if (!stat(data->path, &st) && st.st_size) {
        snprintf(oldname, sizeof(oldname), "%s.old", data->path);
        ...
}

An attacker with write access to the target directory could create a malici=
ous
symlink at the target path in the brief window after check_backup() but bef=
ore
open_file_write():

tools/perf/util/data.c:open_file_write() {
    int fd =3D open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC, S_IR=
USR|S_IWUSR);
    ...
}

Because open_file_write() opens the file without O_EXCL or O_NOFOLLOW, the
open() call will follow the symlink and truncate the target file.

Could this be exploited to truncate arbitrary files if perf is executed by a
privileged user in a shared directory?

> +
> +	if (!ret)
> +		data->open =3D true;
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D4
