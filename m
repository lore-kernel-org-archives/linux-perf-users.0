Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C430FF31
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969623; cv=none; b=ZskXuK6t6+9Xs7xUUNWOf1iCJerYzaOSCoLnOkR6DdBej0q/vJMZPLjhXo6v+XHfIvDI3EyE5hoYd05bys7r2nARNnia0Rc8+JFwIiZ+l3raW29gnc21x2QmqbuIuSKrAzH0O1JLl4koWzqOgjjz501Tlm3OJpqQM7KJhhtEK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969623; c=relaxed/simple;
	bh=eLHzwo8LBsiXey0n/ufyYtlB3zQ+5kKEARmWD+CH1a4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=seW57Jyppy5GiamEUjExRmLv92l+PVSIpGfBBShoNOIGWbFFvQMrL8dgJasoymO4rke6omr8XJpR6gi6bvaB4ImkaoqNIvWDysaGj/W/tPLqd//NEyoyt+JHI/rA3yDAw9UvsVxYvvQoJ28DYMZe7xSc4KAuuwQFXIrGIrT0J3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+31xp9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+31xp9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A101F000FF;
	Mon, 21 Sep 2026 05:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969622;
	bh=HiUMst0T7fvTWxDx+EBZWNJ+nEN6S53Td9lEt5SHVLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+31xp9P54k3v4J4ctomPNehbDyXrqVMK7NlwxYQYA6fkgA0Ssnk3Iu5NiBpgudKs
	 xTFC/v9B3TwVZhIDARJGxtV5mHCH4d44FZMTBUHXJUpJ5KzgEF+OycYJXNZNBRJbyv
	 wuw8DMJMKeWzY6HX/CU6z/O8AFA2ejLlxAVPzc5eOBbPTE0eI7+7Wx4JNdPTPzYAUR
	 MGX/SV4UbmJaJXv6HlFhfct0AugdnpLMEoeMqXvvXwpgHwzu0cIh7N8z+GeEjF5CxH
	 3+lbCMHoOw4y32/O0IHdfe02FazKq1yYy/OdKq8i9i4+O0Dovh6tlQMaB5uu6Qqt5L
	 MGk6seYxMCtDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 36/49] perf python: Port netdev-times to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c794dcf503b03d95428b8a2d434e2ddfe5a3f7ad.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <c794dcf503b03d95428b8a2d434e2ddfe5a3f7ad.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:47:01 +0000
Message-Id: <20260921054702.55A101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port netdev-times.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into a NetDevTimesAnalyzer class with full type
>   annotations to encapsulate state.
> - Collect events via perf.session and sort them in timestamp order
>   before analysis so multi-CPU TX and RX packet timelines are
>   reconstructed deterministically.
> - Replace custom argument parsing with argparse (-i/--input, --tx,
>   --rx, --dev, --debug), extract tracepoint fields directly from sample
>   attributes, and remove Python 2 compatibility artifacts.
>=20
> Add a shell test (test_netdev_times_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D36

