Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62B370ACF
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572993; cv=none; b=RLOuCUsW4zblSwXsKeROPKIj0RciVyJeBma5FYW98hfNKibbDd6/6OYq93AG335uHj5dxPLodfFlpx65/Qdiac/Eh/LRPdcp314ApmJLb8lA8cRY5zvesi86OcGvRf1HVCzoXO/014/i2AL4FMsZrI5J98m52eEcWiqalcoB+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572993; c=relaxed/simple;
	bh=BmXN/6ByOjg0czfqvPfgnsJ8QJgJ9AKptYppBZADIYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Av0K5oyvceOOG+LzYvmyD4q3mu80/Bdw074DNg/BBzjhNC1jGOJF1beqrxpt/9CJzokuSSg7rQYVe6JCJ+DFxQi94KjJhzMyfB+mJWJEDxz9S1dr4fPRdPU6YsWLn6fGH7WEUYP5GciILhFR/Fbsvw/R4zfReSXl4xFFCF6CnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXl+F3zR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXl+F3zR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC101F000E9;
	Tue, 16 Jun 2026 01:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572991;
	bh=ek/2/c8ALZiJuAappF242UrXs3fSNXcFGsmDD1ZRoUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXl+F3zRjs4pHzX9dNWQSklcYdPr8bSKGHGXFHKinb2z6iRAoZgArLcrFnoH6Bl9+
	 vwAsAqXQcyNhL6SQQJeiMe+gEhYCUtn4r8NKWnJgvYKafU5OPHmiDPQWLY47xAD0uV
	 uwXS0rEQ25ccSW3redmqtPzzeZmEAM6F5ybiz+WEJ2pVJol8JspxsxmevHdEmqeq3Y
	 M4TfLpbBxs7cDKu8adkhXNHl3hrABLMKDU0vKOa7Ys2L0v+GXmZpwUXxB5LWWPvahQ
	 ULELg0KM3Qgb1jr0RD46glk1P/VM7zNpR752aR96eKcgfAVMLM9Q3Q3JVYNe/yLlSn
	 TX3qY0BW5G7oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf machine: Use snprintf() for guestmount path
 construction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616010834.37618-3-acme@kernel.org>
References: <20260616010834.37618-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:23:11 +0000
Message-Id: <20260616012311.AEC101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Silent path truncation due to unchecked snprintf return value can =
cause data corruption.
- [Medium] The patch claims to fix get_kernel_version() by switching it to =
snprintf(), but the provided code changes do not modify this function.

Pre-existing issues:
- [High] Unchecked failure of strlist__new() leads to a NULL pointer derefe=
rence in strlist__has_entry().
- [High] Unchecked failure of machine__findnew_thread() leads to a NULL poi=
nter dereference.
--

commit 95810f32b8a216c1bb3b9a1565b24c27cfec9f8d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Use snprintf() for guestmount path construction

This commit updates machines__findnew() and
machines__create_guest_kernel_maps() to use snprintf() instead of sprintf()
for constructing guestmount paths. This change prevents stack buffer
overflows caused by unchecked user configuration strings.

>     machines__findnew(), machines__create_guest_kernel_maps(), and
>     get_kernel_version() use sprintf() to build paths by prepending
>     symbol_conf.guestmount or root_dir.  All write into PATH_MAX stack

[Severity: Medium]
Is the commit message description for get_kernel_version() accurate?

The commit message states that get_kernel_version() uses sprintf() and is
being switched to snprintf() to prevent overflow. However, the provided code
changes do not modify this function. It appears get_kernel_version() already
uses snprintf() in the baseline.

[ ... ]

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

[Severity: High]
Could this unchecked snprintf() lead to silent data corruption?

If symbol_conf.guestmount is long enough, snprintf() could silently truncate
the trailing digits of the guest PID. If the resulting shorter PID=20
coincidentally exists (e.g., guestmount/12 instead of guestmount/1234),=20
access() will falsely succeed. This would assign the wrong root_dir to the=
=20
guest, silently corrupting profiling data by attributing maps to the wrong=
=20
guest.

>  		if (access(path, R_OK)) {
>  			static struct strlist *seen;

[Severity: High]
This is a pre-existing issue, but does this code handle a failed allocation
correctly?

If access() fails, a static seen list is initialized:

tools/perf/util/machine.c:machines__findnew() {
    ...
    if (!seen)
        seen =3D strlist__new(NULL, NULL);

    if (!strlist__has_entry(seen, path)) {
    ...
}

If strlist__new() fails due to out-of-memory, it returns a null pointer. The
immediate subsequent check !strlist__has_entry(seen, path) unconditionally
passes this null pointer, which causes an immediate segmentation fault when
accessing underlying structures.

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

[Severity: High]
Could an unchecked snprintf() here also result in a falsely successful
access() check?

Similar to the issue above, if the path is truncated, it might inadvertently
match an existing shorter path instead of properly failing the access() tes=
t.

[ ... ]

While reviewing this file, I noticed another pre-existing issue unrelated to
the patch diff:

[Severity: High]
This isn't a bug introduced by this patch, but can machine__findnew_thread()
return a null pointer here?

tools/perf/util/machine.c:machine__process_fork_event() {
    struct thread *parent =3D machine__findnew_thread(machine,
                                                    event->fork.ppid,
                                                    event->fork.ptid);
    ...
    if (thread__pid(parent) !=3D (pid_t)event->fork.ppid) {
        ...
}

If memory allocation fails within thread creation, machine__findnew_thread()
returns a null pointer. Unconditionally evaluating thread__pid(parent) acce=
sses
fields of the null object, which results in a segmentation fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616010834.3761=
8-1-acme@kernel.org?part=3D2
