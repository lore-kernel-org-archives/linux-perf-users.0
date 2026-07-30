Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D53F8886
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403193; cv=none; b=b12qUg6GNb/Keme+1tKeH7QLue7gj5PcaOGj+EWt1bhi4uHNU9c7kOiqCdQxBl3+1B/5gqnKB5ZjMy+jRttjsffcMn9GXrWzlhYmK89Z1W2YusoIvF6zQZyl4y3kQUD3fy1yjsqtYLGQ2/mpdDxfNC7MbBUAq7xaJvahyN6kpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403193; c=relaxed/simple;
	bh=XjwbUmRmcGwIJ5ZaT4KUoj3Xrtag0FYdekutMzqrQfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jIvrwSzr1JKAt6ET1ghLQgeqap9Lxt3bJZAo7QWbw77KihAlS211nwm4VLE3W6rVqZelCAgUYiT5IbH5NcNHH2ABGomqy70qijRtX7lO2I6b+KQIFS8kwRgJKVmyOYVSgb/LnA+Sr4guqS1GTpY9c5u2qkcc2B4wLXmTO9BUNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bat+e8Fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bat+e8Fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AFA1F000E9;
	Thu, 30 Jul 2026 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785403191;
	bh=vdQrjEG+JMkQHGXx8mZ1bKxN1AWpHEX+YQ0a+kVNH2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bat+e8FyyIMSOyfmf2NwPKAcGyARTXkGhXQbRS2akUQgoFDNVNTfWnBuqrDI7fMrV
	 8/lg31zvuofB+MzbpMVXJ1r9xIc09HxLYJYrsAZ/QHt8gGKMXdDPg8XPufIXRgGSAm
	 IGvGI7n/yoC4tgOPWRLMIRmdD6xRB1jLBWAQ/mR1L+cKPL9nQrzOdK3p84CErougnN
	 fRwbMz6OHlc93Yd5j6EsNLiuLgPqurpWRJ5JZZwd/8O32JKil8YRedHIh1BxMKuH+o
	 BYLUxkoYu4MA0whOEmi/1uVsDj/rBjqJPyZZbX+G95Flo8ue9PW8ziLlTN3l4afWlu
	 Divu3Qhi8694w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 v5 6/9] perf c2c: add function view hierarchy entry
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260730090521.2206375-7-jiebin.sun@intel.com>
References: <20260730090521.2206375-1-jiebin.sun@intel.com>
 <20260730090521.2206375-7-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 09:19:50 +0000
Message-Id: <20260730091951.31AFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Raw pointer assignment of reference-counted structs bypasses lif=
ecycle helpers.
- [Medium] Custom destructor `c2c_child_he__free` leaks lazy-evaluated stri=
ng fields.
- [Medium] Missing `ops` callback initialization on child histogram entries=
 causes NULL pointer dereference crash risk.
--

--- Patch [6]: [PATCH v5 v5 6/9] perf c2c: add function view hierarchy entr=
y creation ---
commit 53abae650d662cc8bba9920d631a2983397312a7
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view hierarchy entry creation

This commit adds the entry-creation layer for the function view hierarchy.
It introduces child allocation and insertion logic, alongside lookup-or-cre=
ate
functions for levels 1, 2, and 3 based on function symbol or cacheline inde=
x.
These functions are marked as __maybe_unused until integrated by later patc=
hes.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 051c38697edd5..b3528edb387a7 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -793,11 +811,6 @@ static void c2c_child_he__free(struct hist_entry *ch=
ild_he)
>  		zfree(&child_c2c->hists);
>  	}
> =20
> -	zfree(&child_c2c->cpuset);
> -	zfree(&child_c2c->nodeset);
> -	zfree(&child_c2c->nodestr);
> -	zfree(&child_c2c->node_stats);
> -
>  	c2c_he__free_hierarchy(child_he);
> =20

[Severity: Medium]
Does this custom destructor leak lazy-evaluated string fields like srcline
and srcfile?

If the user resolves source lines in the function view UI, hist_entry__srcl=
ine
dynamically allocates strings for srcline and srcfile.

Because this destructor manually cleans up fields instead of using the core
hist_entry__delete destructor, it misses cleaning up child_he->srcline and
child_he->srcfile, creating a memory leak when the hierarchy is torn down.

>  	free(child_c2c);
>  }

[ ... ]

> @@ -876,6 +889,260 @@ static int __maybe_unused c2c_he__prune_empty_write=
rs(struct hist_entry *l1_he)

[ ... ]

> +static struct c2c_hist_entry *
> +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *=
src_he,
> +		       int depth, u64 ip)
> +{
> +	struct c2c_hist_entry *child_c2c;
> +	struct hist_entry *child_he;
> +
> +	/* Function-view children never own or display callchains. */
> +	child_he =3D c2c_function_he_zalloc(0);
> +	if (!child_he)
> +		return NULL;
> +

[Severity: Medium]
Can this regression cause a NULL pointer dereference?

This allocates a zeroed hist_entry but leaves the ops pointer uninitialized.

If core code ever iterates over the parent's hroot_out subtree and calls
hist_entry__delete on these children, it will unconditionally attempt to
execute ops->free(he).

> +	child_c2c =3D container_of(child_he, struct c2c_hist_entry, he);
> +	memcpy(&child_he->ms, &src_he->ms, sizeof(struct map_symbol));
> +
> +	if (src_he->mem_info) {
> +		child_he->mem_info =3D mem_info__clone(src_he->mem_info);
> +		if (!child_he->mem_info)
> +			goto out_free;
> +	}
> +
> +	child_he->thread =3D src_he->thread;

[Severity: Medium]
Does this code bypass reference count lifecycle helpers?

The map handle inside map_symbol is copied via memcpy, and the thread handle
is assigned via raw pointer assignment instead of using map__get and
thread__get.

If the core code ever iterates over these children and deletes them, it will
call thread__zput on borrowed references, leading to double-frees and
use-after-free crashes.

> +	child_he->cpumode =3D src_he->cpumode;
> +	child_he->cpu =3D src_he->cpu;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730090521.2206=
375-1-jiebin.sun@intel.com?part=3D6
