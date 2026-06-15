Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1179CD
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563705; cv=none; b=bsotFDLxL7lkABxkwmTQQA9gQYNXoX4LU3vUqHVHNIc30gT1wksNakBhvwWCisx9Cl0rZaEuo6vBfUyMU1biCfADt44WBjYfVYXWvHNVfmn+4gEy5VEXxV8Paqn1ad2WuYdr68IYv7FNIH6giYZaXQcQwoU6VHPhwaGiNiwdIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563705; c=relaxed/simple;
	bh=MO0yZJBk9ZRPD9GpD+zNdiNxEfJPJHWgaii83/2IiOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMo2K1kZgvtgWK998Q0viFA8cIa1jFevhCKMn/BmxTT+3zL6VFH5OKO/qOl2LoCz8tWZSE/os31jeuFuzt+UDjZZ3coDJHTs8OiOxgoeV070ntCV9ZISL/8TRAGbepamAduv2wNL2NDGd4CYY3O5wwvupkE04NXviW2LXhoQFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO4s6BQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO4s6BQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B9F1F000E9;
	Mon, 15 Jun 2026 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563704;
	bh=SfQUR+lnHx8zbo+mC7txSOFJat1GzrDc2OOdW3gsUzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NO4s6BQeQEZw7DHlqcfBrozSQpWOBmuv9Dp5IMCZIZNujm5EDmDR4YHAIR4hculnH
	 c/UdNnhuQaumjmbuTnE7oB1gaGYLqscFM1KGf4d7w+FD53hLcHIcDfcEBcfcWqDeOv
	 4bV5mj24TB2e44VmSmKH2lzOsmHIQm5S6BaHZcokBJYdSskCQPDxgK2OiHrCbNif7v
	 oy4eafmICY++1E44eLGHd+bh3uEFe3p4RCu19JqmJan9gxPjvxo2VIjjqDfON1X7mj
	 0VvxkQVa5Hsk1XMHl1z1WDWM4bc41wTp8gENgDzfIKqa4VgN6y5v0m4YVERXSEupp7
	 Z5OqZP+9Iqp1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 04/21] perf data: Add open flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-5-irogers@google.com>
References: <20260615223011.3873955-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:48:23 +0000
Message-Id: <20260615224824.07B9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data loss due to unconditional truncation of the perf data file wh=
en rename fails
--

commit 26acb29abc0e2719d33b4b5e15059ab05d391594
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

This commit adds an open flag to track the open state of perf data files,
preventing double opens and ensuring only properly opened files are closed.

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
This isn't a bug introduced by this patch, but could this sequence
unintentionally truncate the original file if the rename step fails earlier
in perf_data__switch()?

Just before this block, if rename() fails, a warning is printed and a comme=
nt
states it will "continue fill original file". However, the code uncondition=
ally
closes the file and calls perf_data__open() here.

When perf_data__open() executes, it eventually calls open_file_write(),
which uses the O_TRUNC flag:

tools/perf/util/data.c:open_file_write() {
        int fd =3D open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
                      S_IRUSR|S_IWUSR);
        ...
}

Since the rename failed, data->file.path still points to the original file,
so wouldn't O_TRUNC wipe the existing profiling data instead of continuing =
to
fill it?

>  		if (ret < 0)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D4
