Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D7377EBF
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109883; cv=none; b=u4NQ+BHzh5G6mN7/lZk/8JWJbDfawxWTDSJ62ZDQemXy/I+sDm8RHZ1JbpFmDmrrB7HAMbLgpGMMfKG7YPr/6dqrz3uVF+tlXMD9IqyGvQvAqmK/cD64ECZf2o/cDb+nesHudslU45PUBQ3HnqfJKgWxNBgX6XfRrvmE3C/zvrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109883; c=relaxed/simple;
	bh=vX3IkCpo3etrmYvJOR51zEByfLb7yyyxOlAjO+vcjUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GoKSBA00KYM//veaALKvhnuavGjEA2KVAR9I8LrP8KrNC1KGj7kBkegsfKDTwDLAXEu+1/hfDvZCaPz/ITb2shiog30nMdxZ+dTX8o1GV00Kec8fjA5shXLtO3ArQbi6CjmXBfaktBiq0BpX6PUCwW7rYUjbG/friRc9FsyE1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVA5NFHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVA5NFHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4A61F000E9;
	Sun, 26 Jul 2026 23:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109882;
	bh=mUjKEW4VG8+P8bDaGfulehQots2+fQE0iO8q4+BaYJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AVA5NFHl/3METwNOMtFTf2aLwkBHumE7XNlqZTMRLm14Qhx/RFByBVksNNotQ6/Zw
	 yIIRhUDRG7UepUvztYerT9FA6eosI53zM5Por67OUz74xN6OW58EkozP5nO1pQ0KaQ
	 cz3F9lDIkYALk7IfbSPnOoUtXE5uLaYJTPe1P1HcuvWYrNbvMJm7/I3jGUxQ9mEAeZ
	 u2MrycpACbaQZ2ss8U8ctfexC8FBcfxGfM+zx5pRWpsIGTDVguF8WKNDu2wEShoCb1
	 pY2Bk0+fpJAcfLjXlsjzJq+kzNJd56aB9MRqWvgNxQRd6nfJCQTV1arPh41qw9A9uJ
	 FynJFhjtGmibw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] perf machine: Check snprintf truncation in
 machines__findnew()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260726234014.63111-5-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
 <20260726234014.63111-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 23:51:21 +0000
Message-Id: <20260726235122.2F4A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing NULL che=
ck for `machine` in event delivery causes NULL pointer dereference for non-=
SAMPLE events when guest machine creation fails.
--

--- Patch [4]: [PATCH 4/8] perf machine: Check snprintf truncation in machi=
nes__findnew() ---
commit 6d258a0499e2df813b5de954dd914c53ea5c78dc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Check snprintf truncation in machines__findnew()

This commit adds a truncation check to the guestmount path built with
snprintf(). If truncation occurs, it bails out early by setting the machine
pointer to NULL and returning.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index baf855e596c26..05724277c2a97 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -333,7 +333,12 @@ struct machine *machines__findnew(struct machines *m=
achines, pid_t pid)
>  	if ((pid !=3D HOST_KERNEL_ID) &&
>  	    (pid !=3D DEFAULT_GUEST_KERNEL_ID) &&
>  	    (symbol_conf.guestmount)) {
> -		snprintf(path, sizeof(path), "%s/%d", symbol_conf.guestmount, pid);
> +		if (snprintf(path, sizeof(path), "%s/%d",
> +			     symbol_conf.guestmount, pid) >=3D (int)sizeof(path)) {
> +			pr_err("Guest path too long for pid %d\n", pid);
> +			machine =3D NULL;
> +			goto out;

[Severity: High]
This isn't a bug introduced by this patch, but does returning NULL here
cause a NULL pointer dereference later in the event delivery pipeline?

When machines__findnew() returns NULL because of the truncated guestmount
path, the NULL propagates to machines__deliver_event(). For non-SAMPLE
events, it appears machine is passed to tool callbacks without validation:

tools/perf/util/session.c:machines__deliver_event() {
    ...
    return tool->mmap2(tool, event, sample, machine);
}

This flows into the callback and dereferences the NULL pointer:

tools/perf/util/machine.c:machine__process_mmap2_event() {
    ...
    ret =3D machine__process_kernel_mmap_event(machine, &xm, &dso_id.build_=
id);
}

tools/perf/util/machine.c:machine__process_kernel_mmap_event() {
    ...
    const char *mmap_name =3D machine->mmap_name;
}

Can we safely check for a NULL machine in machines__deliver_event() for
these non-SAMPLE events to prevent a segmentation fault?

> +		}
>  		if (access(path, R_OK)) {
>  			static struct strlist *seen;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726234014.6311=
1-1-acme@kernel.org?part=3D4
