Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058F36D513
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687945; cv=none; b=DIQMSQ5DD4w2leVa1HqlhebIcCJWUa7QeuV62D9fEdBvJTL9IAJ7trjlq/HXUTHFsCOnw5zd3oWbPIAktis/AM1j0SOpm2Utb9AnmGkc7H39b11YZZcWftiMqnfOrVjEBfz1vYmoxM1hdK9XbSSytsqIBB4XWthxoTnl9/XWqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687945; c=relaxed/simple;
	bh=LlGBTtEPysvRG9WKELXrtenQjCjqM1AUrE3kyW7kCe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gi+vurBB0ER+TeDo4CnXepqNIGmnhdX1kYazbLje9DT7es13iqkKdJDN05XuN6izovmq2wgYrO9Qokh3ok1qoNnWtX5UMK9tVuTIp5pn7Qx59bvYUhR7Wezwa2vg8EEt7SUFzMVmbsLu2UokePJ0p9DHR0JVaNOXmT+g6//7C7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7FV+qHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7FV+qHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56A91F00893;
	Fri,  5 Jun 2026 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687944;
	bh=E7QTKgP2S2bQOrC/B/nzpIRR8zS1YFui/yTKfvIMFnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q7FV+qHwshYFJSI1fDsaNiKyclbjdUFuS7cAKeNjVFIZB7JGjo3uC+5b7Jk43byPS
	 uIVpVRNhuCCxSX8Xx0IZd+YzFmnmgYQB02zg+4VOnOfzBLg3k37+RMPN0tZRGjYUKz
	 4EMIoaxcX4MWSKvJV76c7AzmOUuSuaS3zUHmhjvht44wpBoV8FyIdloajN73yDvWXY
	 3ZBxNUP9Ct4yhjhftN+LMx7pZ9ypvkbjXYAnqNMMjXVrLnumRUnzHgEhwo0DjTKx3B
	 mtQ3+gMMQgZ2CiefpKFY++lLdaDHy2BrvFSBQeFbbPxh3FTX8ZUyTHGQtzVBn0Ggai
	 Mis088E4SRBTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/19] perf data: Add open flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-5-irogers@google.com>
References: <20260605191500.2477026-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:32:23 +0000
Message-Id: <20260605193223.D56A91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `rename()` fails during log rotation in `perf_data__switch()`, =
the original data file is truncated and its contents are lost.
--

commit c62907f96616fda36f9afb612d87efd788da81f6
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

This commit adds an open flag to struct perf_data to avoid double opens
and track the open state of the file or directory. This helps resolve
python integration issues where the data file is opened before being
passed to a session.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 94dc534a73866..33fd1b82019eb 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c

[ ... ]

> @@ -457,6 +473,7 @@ int perf_data__switch(struct perf_data *data,
> =20
>  	if (!at_exit) {
>  		perf_data_file__close(&data->file);
> +		data->open =3D false;
>  		ret =3D perf_data__open(data);

[Severity: High]
This is a pre-existing issue, but does reopening the file here truncate
the existing data if the preceding rename() fails?

In perf_data__switch(), if rename() fails during log rotation, a warning
is printed and the code falls through with the intent to "continue fill
original file":

    if (rename(data->path, *new_filepath))
            pr_warning("Failed to rename %s to %s\n", ...);

However, the file is then closed and reopened via perf_data__open().
Because the file is opened for writing, the call chain is:
perf_data__open() -> open_file_dup() -> open_file() -> open_file_write(),
which unconditionally opens the file with the O_TRUNC flag.

Since the original file was not successfully renamed and remains at
data->path, doesn't reopening it with O_TRUNC completely wipe out all
previously recorded profiling data instead of preserving it?

>  		if (ret < 0)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D4
