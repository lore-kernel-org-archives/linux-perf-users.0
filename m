Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A9349CEF
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968873; cv=none; b=DxRPsWtJY4CpAyzygnFKPVBBuqNFK5YWTI9hoGkQaFIDNlFFuJIaa2ajpZ/W5uyfUZnh3SesnA/mYzkGeMywml26r9tpCe99sXTaZOh7Hd4zrKWLFYJr9a2ktvxMiScZ8QVDmKqWqNIIhapVU3ZA9Od+j/i8uhlTk7smeo64FCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968873; c=relaxed/simple;
	bh=058VwLe8mY6XAw0cIo60amgNrPwMhcTbFpAoPOfskLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjkmAeFmjWliBT5Xeb/bOlsqoqa61rzwqN/bCXpuqKErhCFd2G+IQHFn7+kXual+tdq+Bl2llma4/FJh0EcH9dWyWE+rp2YHMip3T6LNnhPXhOwTLKPGd5ItI+X35pwGflTKdqnGyZwLkEI9MgTS+kxVx6EpPOhKtQSQa4qAKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SklJxMWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SklJxMWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA81F000FF;
	Mon, 21 Sep 2026 05:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968872;
	bh=EBL2v/gS1YU7niC8PSDpkfIcxab+Vg7Up6VqMheo+ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SklJxMWoNTdVlqY0bhDHXDVWnVQjfPErvsJu13ihPsbREtzUFeeW3s4dNvtOEPdqw
	 75Sz8/W8WtGPc3b5tDuMYR8tdMN5DYGoc760qdQFYdJR533S2Jr5U56WsJJkTMXVg2
	 snnN/XdSYSPG/7WblzsWVwlkpnLhYiudN+PFLvvgMroZVJPbv6k3Bq9J5YeqH/boyc
	 16EdAViKg1Kue57kSO/g+SJTfk+aw0Du8DdMcfkFVGno0L7sucT0R1X6apsKfN1Td2
	 cAODiTmCTfOH6sTt6Ky7IPahky0iquRA4mlk0LLQtMVYlxZP5PreoArGjHQ2xOa7NO
	 O27BQ0KPqCknA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/49] perf python: Port gecko to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8af8c6b81a2fccae0cfb2fbf359e3ef65d8647ed.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <8af8c6b81a2fccae0cfb2fbf359e3ef65d8647ed.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:34:31 +0000
Message-Id: <20260921053431.E1AA81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port gecko.py to a standalone script in tools/perf/python/ that uses
> the perf module directly to convert perf.data profiles into Firefox
> Gecko profile format.
>=20
> Improvements compared to the legacy script:
> - Encapsulate profiler state in GeckoCLI and CategoryData classes with
>   full type annotations, removing global variables.
> - Harden the local HTTP server in _write_and_launch(): write the
>   temporary profile to an isolated tempfile.TemporaryDirectory() with a
>   randomized UUID filename instead of the current working directory,
>   bind HTTPServer exclusively to 127.0.0.1 on an OS-assigned ephemeral
>   port (0), restrict CORS Access-Control-Allow-Origin to
>   'https://profiler.firefox.com' instead of '*', and restrict HTTP GET
>   requests exclusively to the randomized profile filename (returning
>   HTTP 403 for directory listings and any other path).
> - Add -i/--input and -e/--event CLI options via argparse.
>=20
> Add a shell test (test_gecko_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D20

