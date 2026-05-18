Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B890380FD4
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128865; cv=none; b=brvDirM7+3A0LiJtxgY4wNkKXbouDoiDB/7BGUG3m9NXUkBZbhvjLFDiM9qH5RhHIRAnkRXRceZajFWc3IYHX3H69lXqX6XKXFv+oSPnIGW+N2WIoLD95yMelwUdRxyOs9sQXcye95s6E3OJo83716BSHzksqg10OH9EadXHodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128865; c=relaxed/simple;
	bh=0RI9P3kHSwt6NnAzh+6xVC9JMxns0704ueu2k7DtPqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNqJpveCaMIUYSfBukngPYKJmDhiCH/WOjOZxh6BnUDyjS2fDFkx2JFM4qO72SElYKpViVwqDDJYIa784v/Rpu6RwpD6BGE124Vv+uoz5stG0xVz9G/VbcebruuDWpR7wT6GP2bxeDNfCFF1us33kvqZhUzUeJpg43wJ77OHe48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6SypTzp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6SypTzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56CFC2BCB7;
	Mon, 18 May 2026 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128865;
	bh=0RI9P3kHSwt6NnAzh+6xVC9JMxns0704ueu2k7DtPqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s6SypTzpjxOV5ab9UAXnaGHqJ7ECznHraC7hBh13/KcsrjQ6vtK6R3OlaUMR+UUs4
	 PEC8sf73s8YXqjDv23H7B7mVnkYw3Q27TfDlalOi1D8wfvKhbyMGG8Pmn4VEzbn9ip
	 KL9PZccJ+njwX8dXrJEWYJ0KN/mo8xqKhzp6XiIUESA4O9+qUoLT4fERjsYo/dvgKV
	 4XexI1kwDC8Yjg3z+aez3FIop8SFntokNhKoZjBoTqPn6rmorsM+0bTlkrqZNwD95y
	 bjBrgBuR8Azng+IFZk0o0WibtKATpQO5EyUFcPA9ro7wSj6h2zsPnNrfvE+gkGd3/X
	 BpjQd+CviIa9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf evsel: Find process with busy PMUs for
 EBUSY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518174159.1177549-2-ctshao@google.com>
References: <20260518174159.1177549-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 18:27:44 +0000
Message-Id: <20260518182744.E56CFC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The file descriptor `fdinfo_fd` is permanently leaked on all succe=
ssful open paths.
--

commit 89c8fa0a46a0a7739ea59073f27c6161911eb75b
Author: Chun-Tse Shao <ctshao@google.com>

perf evsel: Find process with busy PMUs for EBUSY

This commit parses the fdinfo of perf events to extract the PMU type.
It then compares this type with the failed event to accurately report
the specific processes that are causing an EBUSY error.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2ee87fd84d3ea..f6282099320ee 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -3969,29 +3970,61 @@ static int dump_perf_event_processes(char *msg, s=
ize_t size)
>  				continue;
>  			/* Take care as readlink doesn't null terminate the string. */
>  			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
> -				int cmdline_fd;
> -				ssize_t cmdline_size;
> -
> -				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
> -				cmdline_fd =3D openat(dirfd(proc_dir), buf, O_RDONLY);
> -				if (cmdline_fd =3D=3D -1)
> -					continue;
> -				cmdline_size =3D read(cmdline_fd, buf, sizeof(buf) - 1);
> -				close(cmdline_fd);
> -				if (cmdline_size < 0)
> +				int fdinfo_fd;
> +				ssize_t fdinfo_size;
> +				char *line;
> +				u32 perf_event_type =3D UINT32_MAX;
> +
> +				/* Let's check the PMU type reserved by this process */
> +				scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
> +					  proc_entry->d_name, fd_entry->d_name);
> +				fdinfo_fd =3D openat(dirfd(proc_dir), buf, O_RDONLY);
> +				fdinfo_size =3D read(fdinfo_fd, buf, sizeof(buf) - 1);
> +				if (fdinfo_size < 0)
>  					continue;

Is fdinfo_fd leaked here and on subsequent execution paths in this loop?

Since this loop scans potentially thousands of file descriptors across all
active processes in /proc, could leaking a file descriptor for every
discovered perf event rapidly exhaust the process's file descriptor limit
and lead to EMFILE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518174159.1177=
549-1-ctshao@google.com?part=3D2
