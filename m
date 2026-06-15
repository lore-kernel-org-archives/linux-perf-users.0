Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17570416D0A
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544436; cv=none; b=O43uNt6SpWZ9KTt4oXMdELDJLLbDL0TqgJiNJbdK9+1iZegY09+qxA7XSMPYqX5cVhr/FZoQzczzrN/Tlx42N5mwKRkQhQ36xriG3wV4a6SXcQtFHb2mIw34Apxrs0gzldKLBjukk6we2PU3k5uJ5M8po+sVerebIceOx2eJW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544436; c=relaxed/simple;
	bh=iimiVUmsWZOVnwE9NMSPR4KhFJXQcc1ZwoG2URa7HGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oWfoiYRLcQ/Ly/4GsJ2m0aLOkSn6/0FdwwdpB/yFMeV0UZvZw+9/ax40lj4mUWIBpDSYRyatXaPDPIdnebG+B0pBNqiviJI9a6l94Ns2dpjwZpyNiF3tG4JQ1O0qJIFy5Kt0+KwOkOg2Hh/hDrg6RbvSYO4tNXJWRdzrA7JehVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Joero0a3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Joero0a3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C144C1F000E9;
	Mon, 15 Jun 2026 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544434;
	bh=W5AzyBO0gb1Mcuwk86XNrr36LFH/nZk1XnMWcmOUGP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Joero0a3LceRvaBCxpoDKIKQ4p5RYoTRCd0PLOn1VxXGxFXybIMMyTRRNNjfx96nt
	 xgUNs7YX+wZ2dXEo0kbfRzj+ZJWN4FvRxm2s26NTT/XI+uWOqE/RoaM1EeHH1CDEsM
	 oa2mGPw+hU3b3Kq4LZe6IrmrQO2z/Qx0WslJ93GdoHQlG1qIzAaK1JV2p/ho4SuVwD
	 tafL8eby+zlC836ptDRXG9l7qLws6OFa425gPYfV1R1sn+KaIDAdRRYeg89ZnXDIh1
	 nD6aAMEwTTI9iIn9eRa48dmmlzQx9//yZSVRlMFrpQd+OQvhB+RYD7Sm0ih9zPWU19
	 /a7hKWpmC2jrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 16/20] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615165010.2724690-17-irogers@google.com>
References: <20260615165010.2724690-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:27:12 +0000
Message-Id: <20260615172713.C144C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit adds C extensions to resolve syscall names but fails =
to update the python scripts to use them, rendering the new code unused and=
 failing to fulfill the commit's claim.
--

commit 72b1a7ea10b43fdd77a1f5eb255eac5d96b44e66
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds the syscall_name and syscall_id methods to the perf python
module. It uses the syscalltbl support to convert between syscall numbers a=
nd
names for the host machine.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c5b8b9f1ea4a7..f1230bd222d76 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -3954,6 +3956,40 @@ static int pyrf_session__setup_types(void)
>  	return PyType_Ready(&pyrf_session__type);
>  }
> =20
> +static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyOb=
ject *kwargs)
> +{

[Severity: Medium]
Does this patch miss the updates to the Python scripts?=20

The commit message mentions avoiding python libaudit support in
syscall-counts.py, but it appears the scripts themselves were not modified
in this commit to actually use the newly added perf.syscall_name() and
perf.syscall_id() methods.

For example, looking at the existing behavior:

tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py:
def syscall_name(id):
	try:
		return audit.audit_syscall_to_name(id, machine_id)
	except:
		return str(id)

Will the scripts continue to require and use the legacy audit fallback
until they are updated to call these new C extensions?

> +	const char *name;
> +	int id;
> +	int elf_machine =3D EM_HOST;
> +	static char *kwlist[] =3D { "id", "elf_machine", NULL };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165010.2724=
690-1-irogers@google.com?part=3D16
