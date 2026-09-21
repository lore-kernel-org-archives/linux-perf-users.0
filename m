Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46635C6A2
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969133; cv=none; b=ElfwQEnPWAQgBkJPgPKfljqYEU4yOF2f23fvI3shA7hAtGhArGoOvK7pk5+jxCcMdSiQfn2k4fBNFO+44Sk67cGR4KGnNixTpoUPVSsveOhIZRlj4RaZj/qVAW5i87t24BAVumr4zSKc+xbFETQ+JJ29PJ4jkAM0FiwO2uvdcQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969133; c=relaxed/simple;
	bh=Ez1LEg6ddvK1yKtXEwGTiOK+RIcPGpAwmtvf8fFyw+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s29dKd20bTEp7117hWZ9611Drj6kPtr3piM87MO8iIJXV78v7Rf/89jPN95n6ZzsYPLUohNITdkt+sTWNzWgvzKkZLDglZGkBeWE+QCpt2aFqb0hoT2WQ0kDnryD5dsQm+S148vOysxBDi1H0nB5YhQBT7AJLBJL1GRz0pxF38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCtFOTYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCtFOTYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732931F00893;
	Mon, 21 Sep 2026 05:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969131;
	bh=Ob1yiOaQLs/MQasMlgawudwcaoE3KfLqCaStqp6aTUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCtFOTYHDbEtFbWzRcwDesdVZYd5efTFIF+4rJG8ke64B0ONrMSHB5gVnLf+sVpOh
	 S8rr1t1oxS2oFgKbU1zHx1h1Zl9ZYqDvjdu6N0TbGVu9CUMmexZ78dTJDLo5xYzDgl
	 b4fZ710K5k7dxAGVCbhIiWYk8Qe1jBs7VBMbUxE0pmYRDZgAkfLSBfJ0L7D3yt0XsP
	 hPxjihJFZHHsDN9FGVzPqBGsl2ckAfUEOgF5WlXKGlV2zt6IOlYWXUlfNuFZjqnqsA
	 jjQbvAFt/MCJSNvA0NYGjQOX2dTSyKKc41ITXqEzeJs5Wg/YgIFMYL6s7a0auRv3aq
	 5bKinnw+OAQVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 35/49] perf python: Port net_dropmonitor to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c20f25af247c58025dc6476a9a60c3cfcbc37454.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <c20f25af247c58025dc6476a9a60c3cfcbc37454.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:38:50 +0000
Message-Id: <20260921053851.732931F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port net_dropmonitor.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into a DropMonitor class with full type
>   annotations to encapsulate state.
> - Use perf.session for skb:kfree_skb event processing and add argparse
>   CLI support (-i/--input and -k/--kallsyms).
> - Resolve kernel drop addresses via perf.session symbols/callchains and
>   binary search over /proc/kallsyms, ignoring zeroed kptr_restrict
>   addresses with graceful fallback when kallsyms is unavailable.
> - Remove Python 2 compatibility code.
>=20
> Add a shell test (test_net_dropmonitor_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D35

