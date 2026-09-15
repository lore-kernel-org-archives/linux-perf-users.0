Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF934FF62
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505918; cv=none; b=pglvLBGR/hnbhlBg1BjVNy8GVOrCgxWXSM02zFGwJb+2UXoGvYgPZ+OO1GmTr7zq5NDy5BMUa+b1LE7KFq2wsfjX3DN+90xZThdEpZIw+jFyTgeIh/rIOD42GjTubn0r34yOl0cTAYouybRMJNezVbxDhExKph3tIc7sqvLc+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505918; c=relaxed/simple;
	bh=rjSgieroUMCbKYmaUw9Eb2f0ZL3+Qx0Zv9MYJwZwD0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UTflk262XkWP2aNRBgepAuS9B0MxpTwf49aVCBuN6ZfnlPKccf0PElpuCr9x/23MkVoB9fGadg8l7jwMUpQOCxYSDdPdHog23c+LBoN2ujU6lf/6Rza5rxTGqQLtxNA8QzyKj+2WmSmFOiRLW/FrFqLMsj/GyOq657mtevZiybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNnjrCYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNnjrCYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654691F000FF;
	Tue, 15 Sep 2026 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789505916;
	bh=e8ZpTbrAqjanLwmmIrxBKu7V9pl51nVDtH11M1LIpCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cNnjrCYqdmYBWHTaJLnVAtYcJwPZim+BAQ09RJtpcbu6elKZIu6bt7XQn1+0kAPgh
	 lwNKcpm37eA59lvGFLVUlKCyNyyGc+bRPb0HW1+i4klOpuKLy6kkJii8VbGGpX/mup
	 Fxzy0CrTRS0ZsBhhGsem/CqIqLfO7MN3Qx9SG7k1VnjV2W2hDgZO31TlF0qHI0eM2z
	 qoQTnwAqt+rjo6/5df5+tDKC2cErZACEEuUi2btRF08qCo4BNS350gP50NixDQrL6C
	 6jY6ncxRGwAzK3L6TLcvCRf0+UEf1AwDv7zSHq1kh373fwsiFV2PTTuo4byYn/o3uM
	 7h2GnCxCPZ0rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] perf evsel: Find process with busy PMUs for EBUSY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915204951.2935261-2-ctshao@google.com>
References: <CAP-5=fVzG-2oJ1gN=s-W+2r58k8P4M-E3r8aP9zJ2aK_w-K9vQ@mail.gmail.com>
 <20260915204951.2935261-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 20:58:35 +0000
Message-Id: <20260915205836.654691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing POSIX header inclusions for libc functions
--

commit d5be35562f4cbefd7876eec8560215b17ee34b81
Author: Chun-Tse Shao <ctshao@google.com>

perf evsel: Find process with busy PMUs for EBUSY

This commit parses fdinfo with PMU type, comparing it with the event which
failed to open, and reports the processes causing EBUSY errors.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d4..e6d67d522ebf3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c

[ ... ]

> @@ -4288,12 +4300,51 @@ static int dump_perf_event_processes(char *msg, s=
ize_t size)

[ ... ]

> +			/* Let's check the PMU type reserved by this process */
> +			scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
> +				  proc_entry->d_name, fd_entry->d_name);
> +			fdinfo_fd =3D openat(dirfd(proc_dir), buf, O_RDONLY | O_NONBLOCK);

[Severity: Low]
Will this compile under musl libc without explicitly including <fcntl.h> for
openat and O_NONBLOCK, as well as <unistd.h> for read and close?

> +			if (fdinfo_fd =3D=3D -1)
> +				continue;
> +			fdinfo_size =3D read(fdinfo_fd, fdinfo_buf, sizeof(fdinfo_buf) - 1);
> +			close(fdinfo_fd);
> +			if (fdinfo_size < 0)
> +				continue;
> +			fdinfo_buf[fdinfo_size] =3D '\0';
> +
> +			line =3D strtok_r(fdinfo_buf, "\n", &saveptr);
> +			while (line) {
> +				if (sscanf(line,

[Severity: Low]
Does this require <stdio.h> to be explicitly included for sscanf to prevent
musl libc build failures?

> +					   "perf_event_attr.type:\t%u",
> +					   &perf_event_type) =3D=3D 1) {
> +					/* continue parsing */
> +				} else if (sscanf(line,
> +						  "pmu_type:\t%u",
> +						  &pmu_type) =3D=3D 1) {
> +					/* continue parsing */
> +				}
> +				line =3D strtok_r(NULL, "\n", &saveptr);
> +			}

[ ... ]

> @@ -4304,10 +4355,12 @@ static int dump_perf_event_processes(char *msg, s=
ize_t size)
>  				for (ssize_t i =3D 0; i < cmdline_size; i++) {
>  					if (buf[i] =3D=3D '\0')
>  						buf[i] =3D ' ';
> +					else if (!isprint((unsigned char)buf[i]))

[Severity: Low]
Does this require <ctype.h> to be explicitly included for isprint to ensure
compatibility with musl libc builds?

> +						buf[i] =3D '.';
>  				}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915204951.2935=
261-2-ctshao@google.com?part=3D1
