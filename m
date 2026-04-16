Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F631E831
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366495; cv=none; b=UcA42ZNApAoZOaeTTq+1jizwB6lkssP//yJ0HTIr40kU4TmdqrqHtBKs1dS/Isb/7clGok0kB7VKl8xX+41mA6CsJz0PN/upSBnmZjOZU6pY6IMBoEA1jHrOaudB6NjGKsiL+gkwzgteCKnCfWlt5cahskHRBxXcKLoGxDcLZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366495; c=relaxed/simple;
	bh=ZwSZpf6u3WYhCaJI9gEu4XynOcpuomGw0mSmSLaA8T0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qNp7Bx4Fbg5NrB7VGfL7H1JbRVyaS9Xwmk6ve5LpEcBL7SZF5YGiS97pnzg3PIt2VXx7JSi9U5Qo8kbah5J46/4y/BHji4B1Nr8Xz/VtnIIc1zhjIRIS0w13OTPCiYeuevfhea6N1hKa4MO6bG3ybpJDlNvRqR4SN2oGIlTNi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEPxKIrK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEPxKIrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A16C2BCAF;
	Thu, 16 Apr 2026 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776366494;
	bh=ZwSZpf6u3WYhCaJI9gEu4XynOcpuomGw0mSmSLaA8T0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GEPxKIrK0kzsxUFrQgZZLDH9NHmvTccxhRYixRX7jM2quk70rKL+tVJNSKIc8w4Ga
	 xMnyipY9KbtvmOQxiWDYcM32EuC5c0fm0DZg45aWgZppFnFWXwxduyTN8xD6Ec9Gza
	 4i7CUbjSCNsS8Whe2NyAYNuaLUOhAG44N9wszUt1mTgXUpnaenKIQpoPPOVB6f7t8G
	 FJDp4Rt820mx4nFtbyPh9qsKuy5tcQkFacn8B9TWBEopJgmqsj9/90148c9G00IPVV
	 +Sr/6tnVV3j+1q7tXzR7LHlEe926NzYPcovlt7kx/WMTdFnIj3FLPZ020q6ztmHwYv
	 PqK2U8Rl2MDWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/7] perf test: Remove perftool drivers
Reply-To: sashiko@lists.linux.dev
To: "Jakub Brnak" <jbrnak@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416111419.385010-7-jbrnak@redhat.com>
References: <20260416111419.385010-7-jbrnak@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:08:13 +0000
Message-Id: <20260416190814.84A16C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Out-of-bounds stack write in `append_script_to_suite` and `pre=
pare_test_suite` when reading directory paths via `/proc/self/fd/`.
--

commit 1230f358b280e45e7854550cfac958f0de10d7ac
Author: Jakub Brnak <jbrnak@redhat.com>

perf test: Remove perftool drivers

The perf now provides all of the features required for running the
perftool test cases, such as creating log directories, running
setup scripts and the tests are structured by the base_ directories.

[ ... ]

> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index fc5e1b835ecc3..a83e30ee4a099 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -487,9 +487,6 @@ static void append_suites_in_dir(int dir_fd,
>  		if (!is_directory_fd(dir_fd, ent))
>  			continue;
> =20
> -		if (strncmp(ent->d_name, "base_", 5) =3D=3D 0)
> -			continue; /* Skip scripts that have a separate driver. */
> -

Since this patch exposes base_ directories to the parsing logic, can this
lead to an out-of-bounds stack write in append_script_to_suite() when readi=
ng
directory paths via /proc/self/fd/?

Looking at append_script_to_suite(), readlink() reads the directory path in=
to
a stack buffer file_name[PATH_MAX]:

append_script_to_suite() {
	...
	char file_name[PATH_MAX], link[128];
	...
	len =3D readlink(link, file_name, sizeof(file_name));
	if (len < 0) {
		...
	}
	file_name[len++] =3D '/';
	strcpy(&file_name[len], name);
	...
}

readlink() does not null-terminate and returns up to the buffer size.

If the directory's absolute path length is PATH_MAX or greater, readlink()
returns PATH_MAX.

The subsequent code file_name[len++] =3D '/' then writes to file_name[PATH_=
MAX],
which is past the end of the array.

Does the following strcpy() overflow file_name[], causing a regression with
a stack buffer overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416111419.3850=
10-1-jbrnak@redhat.com?part=3D6
