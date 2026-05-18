Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930841FECBA
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147267; cv=none; b=tEH8L00Hw31YhC9byo8lV0IWDMQ88q+ljQ/R9w2ixPa2VfD8OeHzpPaWCTQh/LPzT+YUZRxexinOzQk1GEBySaEACLFpBcsOV+ncbRJGJlywnfTOiAwsgVWHgz/SPhk+i9sXC3UZo4R+899p8H5vqgnzJ4nFShntGlpSNfQIqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147267; c=relaxed/simple;
	bh=MrVZ4M7qSAyCN39c5W/XdsVICgh6PEE++Od1H79mg+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UYXC8X4A4QrV4EcisCP69vr+Mmpp9HwDyvFR8OIdL5BUN1Wq5T2LeL/1XmGkMNCP6yHZANsKHVsyop94L/+fytlf1BEl30nqmVmPgyrvSh2JRZcQAUldp92fqS61OiIRmT39AZveHtM+8RpGxZmdDbsWoH1KpOJutfxRhUsAjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS/G+IsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS/G+IsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301B2C2BCB7;
	Mon, 18 May 2026 23:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147267;
	bh=MrVZ4M7qSAyCN39c5W/XdsVICgh6PEE++Od1H79mg+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lS/G+IsL3YtBAqOB7D7jjwg8dWmKYntgpQnGx97PxAY2jtTMMIyzHM3VGfhOjzIPr
	 GxexJ45eOZkDkSs11Sz3JdlkgDXReQPKPjP/WkehYGM7rsPTVHWP3rVwy+xwTFC77+
	 AFiqlxgmVYYv14ofigRzTcYdg9wLH71sir86Rh6iEjxu0xmN64dl4Cvob/3dHsJhK6
	 RQMMoYrsHEUN7ao8ev9am0MWNh2thL1Y9X1nPVvQf3Q2W/1+eOEvJhREn1xhPLegHr
	 083/ha54O6d1Gv9nFDMN8X0qMNLZFj/RlctI+gL80KnjLoO31OHs2BVLUcTl0Xid6d
	 xnebsaMF6ZnSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] perf evsel: Find process with busy PMUs for
 EBUSY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518224819.1247382-2-ctshao@google.com>
References: <20260518224819.1247382-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 23:34:26 +0000
Message-Id: <20260518233427.301B2C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use-After-Free and state corruption due to strtok() on a stack-all=
ocated buffer.
- [Medium] Terminal injection vulnerability via unsanitized process command=
 lines.
- [Low] Improper string comparison bound can lead to false positive process=
 identification.
--

commit a4a94ff69c8d665f6d09eaea15fdbbbd89954b18
Author: Chun-Tse Shao <ctshao@google.com>

perf evsel: Find process with busy PMUs for EBUSY

This commit parses fdinfo to match the PMU type of a perf event that
failed to open with EBUSY, and reports the conflicting processes.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3969,29 +3970,64 @@ static int dump_perf_event_processes(char *msg, s=
ize_t size)
>  				continue;
>  			/* Take care as readlink doesn't null terminate the string. */
>  			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {

Is link_size the correct bound for this comparison?

If the symlink target is shorter than "anon_inode:[perf_event]" but exactly
matches the prefix (for example, if link_size is 4 and buf is "anon"), this
strncmp will return 0 and falsely identify the process. Should this also
check that link_size equals the exact length of the expected string?

[ ... ]

> +				buf[fdinfo_size] =3D '\0';
> +
> +				line =3D strtok(buf, "\n");
> +				while (line !=3D NULL) {
> +					if (sscanf(line,
> +						   "perf_event_attr.type:\t%u",
> +						   &perf_event_type) =3D=3D 1)
> +						break;
> +					line =3D strtok(NULL, "\n");
>  				}

buf is a stack-allocated array. Since strtok stores a pointer to the parsed
string in its internal static state, does breaking out of this loop early
leave the internal pointer pointing to popped stack memory?

If another part of the tool later calls strtok(NULL, ...) in the same threa=
d,
could this cause a use-after-free or memory corruption as strtok writes null
bytes? Would it be safer to use strtok_r here to avoid clobbering the shared
parsing state?

[ ... ]

> +					cmdline_size =3D read(cmdline_fd, buf, sizeof(buf) - 1);
> +					close(cmdline_fd);
> +					if (cmdline_size < 0)
> +						continue;
> +					buf[cmdline_size] =3D '\0';
> +					for (ssize_t i =3D 0; i < cmdline_size; i++) {
> +						if (buf[i] =3D=3D '\0')
> +							buf[i] =3D ' ';
> +					}
> +
> +					if (printed =3D=3D 0)
> +						printed +=3D scnprintf(
> +							msg, size,
> +							"Possible processes:\n");
> +
> +					printed +=3D scnprintf(msg + printed, size - printed,
> +							"%s %s\n", proc_entry->d_name, buf);
> +					break;

Does this safely handle unprivileged process command lines?

While null bytes are replaced with spaces, other non-printable characters a=
nd
ANSI escape sequences are preserved. If a malicious user intentionally hold=
s a
PMU and crafts a command line with escape sequences, could those sequences
execute in the terminal of the administrator running perf stat, potentially
allowing terminal output spoofing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518224819.1247=
382-1-ctshao@google.com?part=3D2
