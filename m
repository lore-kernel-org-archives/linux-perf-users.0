Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07F523AB88
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639015; cv=none; b=gDTy+IuSYKV2bfTboZ0SB5C65guSCPxs320rgBcn3ouGzPU02NyLp4i8HaL9rl5dWtSBsVLXV1WtS93/msSirY79D7ANbDdriOAIMJwzbsBaezDwHnnC6h00e7mKYCFr4lJsworU5fHx/AIRRqsjP+cFEWHce0ubEBc3WCFks0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639015; c=relaxed/simple;
	bh=pWme4kqs+z3mz3dcHxPUe/6CqZC4L9QqBpIVYR5nM3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D3aUeqvRUffuU1aCLiey4+EBOvk0joJhSn/dVW9ooDRlR5erkTJH7jWU3ZdAXkVa3o1A5EHI/2YNCE+WicoXm8jMOTRTrKfOuY18vRRH+iLnwfkacYXZRCSd9gqpI3ElKyBZLvYnHSz1nr9DQuIaUj0/d8ljoZrGr2+CyH993zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdIV8aFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdIV8aFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD8A1F000E9;
	Tue, 16 Jun 2026 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639014;
	bh=Vk8Ie5uxoZIDj7r0rH8IUbLSgWU33ChitXrmVQr32lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HdIV8aFdBn8q37wrGT2a5muR85SEZDwdbn9VHqJaesmBj7n+cfvxbI0bTeU/AXz32
	 it0psISrwR0gwv9ai80A+b78zjUbEwxbXW5ZpRFnGyrBVjjy00Gek4YQQBa8tTbWY0
	 QFU4yGOw6TUxKmL9afISo1ANEEQqT1/yMiiUSUnOzrrrvYm8aaTYSODrJkBCvrV0aX
	 L4NjsqbbGoz4gFkOyNzzJLOM9E5j2kQia33I2Wk3nuyRSoqzFAY3NkWqDJZEI9nWv9
	 sK03RTta9KM7/iAaJ6L1rX+lpFH9lp7/t+ECu2U7m6REKR9zzXvrvp6kwIo60MJCSD
	 PJOXoHg+3UDzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf machine: Use snprintf() for guestmount path
 construction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616193033.10035-3-acme@kernel.org>
References: <20260616193033.10035-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:43:33 +0000
Message-Id: <20260616194333.EAD8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent path truncation leading to incorrect guest mappings due t=
o unchecked snprintf return value.
--

commit dea96196f7173b00dde7201d55c1790141f1a31d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Use snprintf() for guestmount path construction

This commit replaces sprintf() with snprintf() in guestmount path
construction to prevent stack buffer overflows when using unchecked user
configuration.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -333,7 +333,7 @@ struct machine *machines__findnew(struct machines *ma=
chines, pid_t pid)
>  	if ((pid !=3D HOST_KERNEL_ID) &&
>  	    (pid !=3D DEFAULT_GUEST_KERNEL_ID) &&
>  	    (symbol_conf.guestmount)) {
> -		sprintf(path, "%s/%d", symbol_conf.guestmount, pid);
> +		snprintf(path, sizeof(path), "%s/%d", symbol_conf.guestmount, pid);

[Severity: Medium]
Is it possible for truncation here in machines__findnew() to accidentally
match another valid guest directory?

The commit message states that access() will fail on a truncated path, but =
if
the path with a PID like "12345" is truncated at "12", and a guest directory
"12" happens to exist, access() would incorrectly succeed. Could this cause
the tool to silently store the wrong root_dir and analyze the wrong guest's
memory?

>  		if (access(path, R_OK)) {

[ ... ]

> @@ -1260,9 +1260,9 @@ int machines__create_guest_kernel_maps(struct machi=
nes *machines)
>  					 namelist[i]->d_name);
>  				continue;
>  			}
> -			sprintf(path, "%s/%s/proc/kallsyms",
> -				symbol_conf.guestmount,
> -				namelist[i]->d_name);
> +			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
> +				 symbol_conf.guestmount,
> +				 namelist[i]->d_name);

[Severity: Medium]
Does this snprintf() call in machines__create_guest_kernel_maps() have the
same silent truncation risk, where a truncated path could accidentally match
a different valid directory?

>  			ret =3D access(path, R_OK);
>  			if (ret) {
>  				pr_debug("Can't access file %s\n", path);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616193033.1003=
5-1-acme@kernel.org?part=3D2
