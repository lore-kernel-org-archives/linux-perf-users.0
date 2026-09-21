Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DA30E828
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969530; cv=none; b=Qh0ssgrP8g94UjfMcpn0wULlBx2dZ5MvAbBn3NZUSEJKXmAKrcMHHcq/e+zYp2KmJI4HomnEbRb93WZ0ixiOQa5dxtlUBv0Yi9UAI5Hw06E0eP76uXz9L8IseeswfFQOkxWw71eGydzPyfNCLn3gPEhqcKHhgyN+SzgS0g7PPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969530; c=relaxed/simple;
	bh=gUyQVQPRwU+wjVM12scjBQPUnCpQzj24OmbgWBK+UIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sgf6cmnlVDPE+VwVuCxKaWsobNNayxa9cbYJrmR5kNbWhemBjtp5wbFgnVcUK4APEJtW1cGkAvaKU7UYCqUBPC3zUqlY+Mdp/e83LVHMPlSBf/zXx3x8l5NNkjkxGyhsm8EJO0ZtFCiiQx4ap40aeXOETWyFtJeOJtph7tnVQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG3A5+Tp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG3A5+Tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A751F000FF;
	Mon, 21 Sep 2026 05:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969529;
	bh=yqy+zzzVRVWve2J2wTpSsUFWXUbWo/nju6qmTeLfZIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VG3A5+Tp7wTMDa2Jvi9k8JG6EuMn/hp3xJ6v5ctCV62L5WCYvo/vmde87Ec14Msh9
	 +LvUZa3mdhAgwRth+di1OG4tfwLVriH34JvJtPDNInPCGAXmV8u5F5I8IFfx3dk3oF
	 rBVDsjumMQB165tHo/5BeSluM0xncKmRzl9y0swTqDX0ZHlYQGcvQW3l5FfuWW/Wef
	 j8PDSRvWWWcJmC5MXdM3wSWlHuxOvGSoZNANqLlM21nUHMc2fikf5hwNygMlwS7qC4
	 rIB5reBcb3MuMfgjURB1/ppxV68Qqy5x56DkUPxURQJ2eMbTGNJPMLOlYkESpcUFHd
	 rsCyoSubN+RUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 45/49] perf python: Move and clean up
 parallel-perf.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <950778ea405b6ce0b23a2a3a5872c557eed6c803.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <950778ea405b6ce0b23a2a3a5872c557eed6c803.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:45:28 +0000
Message-Id: <20260921054529.08A751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Move parallel-perf.py from tools/perf/scripts/python/ to
> tools/perf/python/ as it is a standalone Python utility that invokes
> 'perf script' in parallel across time slices and CPUs. Update
> tools/perf/tests/shell/script.sh accordingly.
>=20
> Also fix bugs and clean up the script to pass mypy and pylint without
> suppression comments:
> - Fix Work.command() to return the shlex.quote()-escaped command string
>   (previously sh_cmd was computed with shlex.quote() and discarded in
>   favor of unquoted self.cmd).
> - Close self.popen.stdout in the parent process after spawning the
>   consumer subprocess in Work.start() when --pipe-to is used, ensuring
>   the producer receives SIGPIPE if the consumer exits early and avoiding
>   leaking the pipe file descriptor.
> - Convert method and function names to snake_case, specify utf-8 file
>   encodings, and add type annotations and docstrings.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D45

