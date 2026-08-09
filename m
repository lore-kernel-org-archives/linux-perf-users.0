Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19C233941
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786250199; cv=none; b=h3FATbJKpJk6iLo/UsmPqFJnSL+h5wvn/71N5PTtKmhVSeRiDZyP9YTGZb3Oo3W50V9AZsEglimoSQ4QsJg/QplnEIn7G9SbQ7/thca1BHeqg+wKSNTjxe5hShrZ8jO9iEKyxdvASnO/ENuNHB10f90IUxKs465fQqDFcYOqlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786250199; c=relaxed/simple;
	bh=43uaAz0xNYvL868z67s5lQKiLVuhPAvjl1xbnDVo8aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H327307Njyjv1jJZX9oiEjz4MzZXMtsRdAA+brhSiVxdJRJ3oPh4AWcH0CaQZ7GB2MYsD365Bg7ZqMWbu7YORpFNpdQJOVXLjEyOliO5revhSjo0UAOJjFhCMgZzWR7APKHpaLFRhUjAbhCOWWNPZEWK/Lqa8+In1UMYgsacChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvvwOE0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvvwOE0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549B21F000E9;
	Sun,  9 Aug 2026 04:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786250198;
	bh=DkXhFilatppjt7WItqB0pt62HCs7+Gty9od2gRdalLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jvvwOE0UlARM3Lklj7Qx7F1bdQmsqzLlVlyi3+kt6Dxxy08cT3Wq7zm7lu5I6PNN+
	 /Z81vFwM3NlAvQIHdRu6Ij+++gOB6uRoNYxWenShin8QPYaxezIkdq3K8ZJEYKjpUp
	 +MbLvR4K+cmyKc+a7BRk+HYys1KB21qaEiLjSmrBt8LPg0TImubtU/iO/0uqKVYK8b
	 SG419u10fyrJL1PoOYC1nHqlF1NQAN9m5u0oWyMbaWg1JAP7mpxq8v9Ej+HdlTQjNF
	 8fA3F6Kq7mwGu6WerbuZ98aM/CBwPzF45Nazc5TMFrVdQv44Ynf4jtQmPG12q/x7Wr
	 x8Hs7rLtqKFaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf python: treport add flamegraph support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260809041638.2402705-4-irogers@google.com>
References: <20260808065743.2328212-1-irogers@google.com>
 <20260809041638.2402705-1-irogers@google.com>
 <20260809041638.2402705-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 04:36:37 +0000
Message-Id: <20260809043638.549B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Rich markup injection vulnerability from unescaped DSO/symbol na=
mes containing brackets.
--

--- Patch [2]: [PATCH v3 2/2] perf python: treport add flamegraph support -=
--
commit 0b23e0e4520eaa617a120b39e7e4595517aedb98
Author: Alice Rogers <alice.mei.rogers@gmail.com>

    perf python: treport add flamegraph support
   =20
    Implement a flamegraph widget that recursively walks down a tree
    splitting line segments based on their value. A visitor pattern is used
    so that the same logic can both draw the line segments and locate which
    segment had a mouse click. Add a tab for the flame graph widget.

> diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
> index 528a640e4d356..ec3263a6b6257 100755
> --- a/tools/perf/python/treport.py
> +++ b/tools/perf/python/treport.py

[ ... ]

> @@ -120,6 +150,327 @@ class ProfileNode:
>                              key=3Dlambda pnode: pnode.value, reverse=3DT=
rue):
>              pnode.add_to_tree(new_node, root_value)

[Severity: Medium]
Will this crash the TUI application when handling typical perf traces?

Looking at ProfileNode.add_to_tree(), self.name is embedded directly into a
formatted string alongside rich style tags:

    if root_value !=3D 0:
        percent =3D self.value / root_value * 100
        label =3D f"{self.name} [r]{percent:.3g}%[/]"

Since perf trace data heavily uses brackets for kernel threads (e.g.,
[kworker/0:1]), DSOs (e.g., [kernel.kallsyms]), or placeholders like
[unknown], the Textual Tree widget's rich parser may intercept these as
unclosed or invalid markup tags.=20

Does this unescaped input trigger a fatal rich.errors.MarkupError when
constructing the Tree widget?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809041638.2402=
705-1-irogers@google.com?part=3D2
