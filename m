Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018C314D26
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158871; cv=none; b=TtyzLqLUCWD6Nau29WSuYKy9bUw4YyZpymAHjmExxSwkRxcrB26Roho4AZZfBf9NicdgggRoAQkIJq241KzHI4XVRQXY74tKQJHJmkTP0hux3N/DtJ84ouNmTww6rdk8/WsLyviokhxH3inKJAsVcHq4N3b9+z1j9EOut1z8oK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158871; c=relaxed/simple;
	bh=FQoVtEoQQSNzcf9nWo/Hb/6LN2s6fxDtNmsyURxd88k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sBDU3iWJPWgeqMr0mirVRRuzyER1PpnAX7CZXLdl1E5DoYgXMcZ/k8j+oH6VIy8dmedfmUZzKSzHgIZmQccY1+E7jUgx/cfZPlC6fFZOZN6IJzfchDQVbz6LAhL6XOlEaJpOWlRZXfoYETBdoiRHSGNfX9RVH3vFytyZVMJuVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKZCGxJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKZCGxJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B428C2BCB0;
	Sat, 25 Apr 2026 23:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158871;
	bh=FQoVtEoQQSNzcf9nWo/Hb/6LN2s6fxDtNmsyURxd88k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UKZCGxJVhwDu8b5zeNop2e/3ejMoU3CzUAWLi9kBerHxtRHBJ+b17whkcfsfuNggc
	 o9c82ZoS+q38uRDdQoNWvTS8HfYpgjuE7cX5ajWrU/Yq/uEjwkUDyE+1QM39Q+40rN
	 bMfsILn4cwdKCm5AmaJ0viXOrAJWo4cWw9kRKbSmPrNAJKDdguE6nn/aliCFSq7uEM
	 E9Nqmix3JE6hiLN7cw5BtAqqiSFQljEO5pAwHEUy0W3wDlEkj5QrSfnN/rexp+IxI2
	 1tUrzkjRWe1z2ZeSBdgxENJUkSHnBhwN7rEnZNoiwB0nYI1lLjEC17Fd/i2NVI4qWH
	 V9dWfklWOKTUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/59] perf data: Add open flag
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-10-irogers@google.com>
References: <20260425224951.174663-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:14:30 +0000
Message-Id: <20260425231431.3B428C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Using `--switch-output` alongside stdout pipe output triggers a Us=
e-After-Close and File Descriptor reuse bug that can silently corrupt profi=
ling data.
- [High] In `perf_data__switch()`, a failed `rename()` fallback destroys th=
e existing data file via an `O_TRUNC` overwrite, causing severe data loss.
--

commit ae03fcd2a8865263d13dc316b361633ec2b22deb
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

This commit introduces an open flag to the perf_data structure to track
the open state of files and directories. It updates the open and close
routines to check and maintain this state, aiming to prevent double opens
and ensure only opened files are closed.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 94dc534a7386..17baf71897d1 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
[ ... ]
> @@ -457,6 +474,7 @@ int perf_data__switch(struct perf_data *data,
> =20
>  	if (!at_exit) {
>  		perf_data_file__close(&data->file);
> +		data->open =3D false;
>  		ret =3D perf_data__open(data);

Does this sequence accidentally close standard output and corrupt subsequent
file descriptor allocations if the output is directed to a pipe?

If output is a stdout pipe (for example, using perf record -o -), the call
to perf_data_file__close() will close STDOUT_FILENO (FD 1). When this
reopens the data file, check_pipe() will assign data->file.fd back to
STDOUT_FILENO without performing a system open or dup. Since FD 1 was just
closed, the next unrelated file or socket opened by the process will likely
receive FD 1. Subsequent writes to data->file.fd might then silently corrupt
that unrelated file with the profiling data stream.

Additionally, is it possible for this fallback path to unintentionally
truncate the existing data file and cause data loss?

Earlier in this function, if rename() fails, a warning is printed and a
comment says to continue filling the original file. However, because the
rename failed, data->path still points to the original file:

        if (rename(data->path, *new_filepath))
                pr_warning("Failed to rename...");

        if (!at_exit) {
                perf_data_file__close(&data->file);
                data->open =3D false;
                ret =3D perf_data__open(data);

When perf_data__open() is called here, it eventually calls
open_file_write(), which strictly passes the O_TRUNC flag. Will this
truncate the original file to 0 bytes, destroying all previously
collected profiling data before the subsequent seek?

>  		if (ret < 0)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D9
