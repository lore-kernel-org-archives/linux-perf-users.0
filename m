Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560931E84B
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578205; cv=none; b=EW8CqlT4iZlRyEAOT5sJrhFV0v0dW91N1yQadNQyXcBEUpVW+5NG0uQQ9Y/ipiopTHimeYWs+CKngM1hmI6OQ0EWkGEFPVGRU6mESUeMOZPX+n9JNO60ZPBrQeR1+UKvbglLa69VasTeUqDEIRBXGhLirPelzLbEEe1HAZPnjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578205; c=relaxed/simple;
	bh=GOg1ZFdipkxSZWo3KQrNRlLinqyi5RaN1n1y5uB2yek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KMbgpviXdp31C9fFITfeEqoAidIx69tQRuR6G0GToc2O+xQxACrfQtlngi6BkaPhwYdl+CfABP3+t8yppHZ78v16qWBB13hJSeKNjsc4AZammxy3X3dMSnsCB14GbJQwWUyABAtIjzojFtWv88PzdPpeNoOBEmoiuRvAR6VNiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqWcvr3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqWcvr3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B381F000E9;
	Tue, 16 Jun 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578204;
	bh=Glf8DsP9kCUabEWk08nzw5LvUsLIUw5EHKBUzn5AxT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JqWcvr3bLdJJdgeVe5tlBS1DuS+YR2YZoZPA/61vslO9RWQTSaIW9oFGCuYmFDI1o
	 RELAmngYJh2eS6fhhaCIiJiejoUfFTbeovdNe8dTV+oLjFcU0le9t0zRDXwX913rIP
	 RqsagQG0JRUlZiIwhJ7MjZd+XA0gNrcpnxRVxeTl+n67b0skaC7yVweTAX8e/+51KG
	 ONkJNsfdME1+8Cf8ZzqqKwygk3ktfgm39JzLq2xLKuuD4wSQHggwoGV8uU1sprHG3f
	 mXhrgN/K7g6KnhpOqMsUeOjZSZSx4GN4q1ndF+o2xp14n9Zqhe6WSRiXs3WbkaovN0
	 lmFTi9Hf6WgJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf machine: Propagate machine__init() error to
 callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616022715.5739-2-acme@kernel.org>
References: <20260616022715.5739-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:50:04 +0000
Message-Id: <20260616025004.73B381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The return value of the newly fallible `machine__init()` functio=
n is ignored in tests, leading to potential null pointer dereferences on in=
itialization failure.
--

commit 75ef0ba718fac4d2482673c59e4b0fde21e0bfe2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Propagate machine__init() error to callers

machine__init() always returns 0 even when memory allocation fails,
because commit 81f981d7ec43ed93 introduced an error cleanup path but
left the final 'return 0' instead of 'return err'.

Fix by returning err, check the return value in __machine__new_host()
which was ignoring it, and change machines__init() from void to int so
it too can propagate the error.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 31715366e29ff..9329d319bd033 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
[ ... ]
> @@ -124,11 +123,11 @@ int machine__init(struct machine *machine, const ch=
ar *root_dir, pid_t pid)
> =20
>  out:
>  	if (err) {
> -		zfree(&machine->kmaps);
> +		maps__zput(machine->kmaps);
>  		zfree(&machine->root_dir);
>  		zfree(&machine->mmap_name);
>  	}
> -	return 0;
> +	return err;
>  }

[Severity: Medium]
Since this patch changes machine__init() to return its internal error inste=
ad
of returning 0 on failure, do we also need to update the direct callers in =
the
tests to check this return value?

For example, test__kallsyms_split() ignores the return value:

tools/perf/tests/kallsyms-split.c:test__kallsyms_split() {
    ...
	machine__init(&m, root_dir, HOST_KERNEL_ID);
	if (machine__create_kernel_maps(&m) < 0) {
    ...
}

And test__vmlinux_matches_kallsyms() does as well:

tools/perf/tests/vmlinux-kallsyms.c:test__vmlinux_matches_kallsyms() {
    ...
	machine__init(&args.kallsyms, "", HOST_KERNEL_ID);
	machine__init(&vmlinux, "", HOST_KERNEL_ID);
    ...
}

If machine__init() fails, it cleans up and leaves machine.kmaps as NULL.

Could this lead to a NULL pointer dereference in functions like
machine__create_kernel_maps() that expect kmaps to be valid?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022715.5739=
-1-acme@kernel.org?part=3D1
