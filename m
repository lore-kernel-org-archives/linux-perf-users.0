Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0C230BE9
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270658; cv=none; b=D8/tlKn98aD7x+nDF0JRQYDSJtC8mesV91YMYaJHaaFxXt/oJ/CSr4gPba4BqniHb/YdC+piWc4w65BdOavNJH2sVhi9ToekYFrsWo4v2GuZhb1TsR8mfKlNvUC2+hV1CPa5nhHriv7qdMJv5fxQQKMcZdnkKwETPjh5oglyfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270658; c=relaxed/simple;
	bh=DJgiJWPBERqh08t3NkePB8t5xhYZwNXMrZvjC3oYdNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c9PhhnIdBUDW30MFoSsdJC8m09MG9BvntEVxsq2PbCHsn1hbaY3kyYXqbedVHqgL/434Y/Ci43c/IqsZ3CK3QJYuF8INfvDRE+jTEVm+BtvvVRaZnGFYziWmI/fpElCb5jS5JPgoat+xuJy+iKGFZCZ95pm7/vFx2cTJ1okO/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2MBaux4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2MBaux4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CCA1F000FF;
	Sun, 13 Sep 2026 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270657;
	bh=qtN7AzkLBFbVUc6et8nDV/ch+HdoZsvkCHS/BHEW3g0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2MBaux4bHnjMZy8hXZOi4rr4+4cETvTgEKplb3qimBqs1OU327WUwmVXkGta4WSK
	 +0QhOWRSBb7lZcQhMVDnzpkUifeeIPDrC5YiZnSdVaIdNdm1yiK8L1s9UqWmWrkjj+
	 0XMGetbgu5Tfmahpp5bA44pBm1AIfgcTmdBYS+hTQLuVO625/LorToV2/qn0oWIAY+
	 o20vuHckeWJlQLzt6mAZttoM2lXA+rrkfadwqwjtcEUcZdAj+b4JUKzl4Mu9aur3JV
	 FWf0mJzTfUoVDoFWbdmj7o6GyOU9IBKBa5EK0+2OF1hYjmB85c1X+xnLNYlRuSgOKF
	 LNAyvDzdJoZpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-7-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:37:36 +0000
Message-Id: <20260913033737.03CCA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `perf-dso` GDB macro uses invalid C syntax to access fields =
of the `ms` struct pointer, causing evaluation to fail.
--

commit 78fb763d9dbe173145a580fdc9c3bef811e7fc40
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit adds a script and a GDB command file to help identify where a
running perf process is stuck. The script samples the process at fixed inte=
rvals
to detect unbound loops or recursion, and can optionally invoke GDB to prin=
t the
DIE chain when no progress is made.

> diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-=
stuck.gdb
> new file mode 100644
> index 0000000000000..12a3f2952a68c
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.gdb
[ ... ]
> @@ -0,0 +1,104 @@
[ ... ]
> +define perf-dso
> +  if $_any_caller_is("find_data_type", 20)
> +    frame function find_data_type
> +    printf "dso=3D%s ip=3D0x%lx sym=3D%s\n", dloc->ms.map->dso->name, dl=
oc->ip, dloc->ms.sym->name

[Severity: Medium]
Will this macro fail with a GDB evaluation error when running
perf-stuck.sh -g? If ms is a pointer to struct map_symbol, GDB's C evaluator
requires the -> operator.

Should this be accessed as dloc->ms->map->dso->name and dloc->ms->sym->name
instead?

> +  else
> +    printf "not in find_data_type()\n"
> +  end
> +end

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D6
