Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC95478D
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767034; cv=none; b=O7dxjCrwiGCxI5eMQwBxfyCAGTcpX741w0/0EIXMHPvkmnU7z+h1gY99VD7/6z5UfzJlBJNrGrVb6IQz2niaKbsKc3WkzJUmn4MLPD3HBiabEghdkS8vlslEwhfbfB56U3VENX/hJ+Q+ZlZYQNm6eUoW+8aSMiWlcFxMf4GGq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767034; c=relaxed/simple;
	bh=Q6sjzXGiJjZhpIPLEkmBJB2uWw6nkpgS8JRo4VBpNm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBUy5Wz3IzRQYJbjlnN2tI4ZWX2AY7PTG8AqSFiiKanLFCaMUfF8TEI8hccY1gNcHpqvW99lbDY1WeulYx3WkbPB5N8wQYtZQumnKXzc0MAN6NocOh4lkjaoyx8chFZiK1R7cathzW+y+jn+t+O2+FAtzIaWrd9YSiErslNDlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6bzi/4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6bzi/4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA431F000FF;
	Fri, 18 Sep 2026 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767032;
	bh=Q6sjzXGiJjZhpIPLEkmBJB2uWw6nkpgS8JRo4VBpNm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6bzi/4dZSv80gMe1ckec4MOqrLw10xMYGkdIt0DRlkXxh4JnK5XqHY65hUdKbM/o
	 JSXDcu5tuO4BiFQZHGMfCGmJLVL16DXgLYarIgp9Us6HIuhp5zswUcsyprtasAF13p
	 Y1UI7L1xElx0cI8wDvjN+YIL3fyrnuqw0aAFhqPlfWR+75E47FqqstJdb2OBQQ8fuy
	 nfZih83s87XXRXDGgk/fEqakTiTOuXXLAzCbLZF9zQ71W1xGpzAKNyxARXeGYWM5qR
	 QxMYNr8UiD0LeD2Fv4Vn1YlpCiDsfe9apTjy21IRJmb58FRPchc8jKRI3ecdGwD/Z4
	 EZuFnr49BeFfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/18] perf test record+probe_libc_inet_pton: Scope
 event to PID, add retries, and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-15-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:30:32 +0000
Message-Id: <20260918213032.ACA431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The uprobe name was not scoped to PID, and concurrent writes to
> `/sys/kernel/debug/tracing/uprobe_events` can occasionally return
> `-EBUSY` when another process holds the tracefs inode lock.
>=20
> Scope the probe event name with `$$` (`inet_pton_$$=3Dinet_pton`) and add
> a retry loop with backoff for uprobe addition. Drop the
> `(exclusive)` tag so the test can run in parallel during pass 1.
>=20
> A PID scoped probe is no longer cleaned up by any other test, so add an
> EXIT/TERM/INT trap to delete it, otherwise an interrupted run leaks the
> uprobe into the system. The trap is installed only after the root and
> IPv6 checks that `exit 2` to skip the test, as trap_cleanup() exits 1
> and would otherwise turn those skips into failures. Deletion enumerates
> the probes from `perf probe -l`, matching
> `^probe_libc:inet_pton_$$(_[[:digit:]]+)?$` exactly, rather than reading
> [ ... ]
> true, so the negation would skip the failure path and the test would
> go on to pass without having recorded anything.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D14

