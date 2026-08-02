Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268AB3BCD14
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682798; cv=none; b=DlL46fanqFPlHcGo+Ng2orlzbx/REd4P+b3dgbZJdEnmmxpJ6Xqb/Fydz6SIVqN3K1+gOu7F4i3RS1Rzg+LzvyKNjAZTVCRAvjA2PTunt+AXwT8H9wLfoVyE35xD+Z79liOlsldQk+rErFmLlEBCGjIpohXkgNEZhs4dXwg6ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682798; c=relaxed/simple;
	bh=F3Ku8RVbjM+eK4wNRLi75OD7lI7hfsDFAM9dErxHj6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dUFlqbNGDzp6ySdto4n8DAb5E0v8MPYqIsC5yvvSzzgePOVYMsbiRZqbPTyUqgTk56AWlVvemV+GvLE8WShdYoOlyEPfznIPVBtwHlS+0gdNkC2PQ1GPmnWLxFp+cePKcR7uonnisg22bq8IUUL0lsAGtgqXmkHqUvmuA916xZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvYMXmy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvYMXmy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481701F000E9;
	Sun,  2 Aug 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785682796;
	bh=nYzWKFkR95ds5VM6erlpUCoenNl8besWLxTXva8O/+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvYMXmy8Z8Lk6m7gtNI/giQJpt2XxfjDd2ulkAdW4aan4r8WzERKZvfXrouPKr741
	 dfZQoSyezwXoKCwwFPvOo2NJlFn0oGR8q7rUHYlwO2noW2mQsDaR6lMsrwoNJ5bvfv
	 t1YOSJiJY6SVZ4TyfVBRN2t/5I+e6Lb5K1TLv37UB9wsyUYUNjN1SRyPcUeZ/r5opY
	 0BU8F4QhXJ8AyOCtn6w3HNfTefwjjwZm5KT9joHiRfldi9SOKHi2x7tpsxtLNgpP1M
	 4pYFcHdDN/0c/G8dz0CnERmBqrkk3VNaTXU/UU3e4l+w5+Xh9Y9inZYTykhQDNNbYL
	 YcagNv0tfJ0xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf header: Use write lock when translating BPF
 prog info pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802142712.154726-3-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
 <20260802142712.154726-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 14:59:55 +0000
Message-Id: <20260802145956.481701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch changes `down_read` to `down_write` to protect in-place =
pointer mutations, but the fix is ineffective because primary readers acces=
s the data locklessly.
- [Medium] `bpil_offs_to_addr()` permanently corrupts the in-memory `info_l=
inear->arrays` mask when restoring a valid object containing empty trailing=
 arrays.
--

--- Patch [2]: [PATCH 2/4] perf header: Use write lock when translating BPF=
 prog info pointers ---
commit b51042073da80b7c616b5e20db21243852bbccec
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Use write lock when translating BPF prog info pointers

write_bpf_prog_info() temporarily mutates pointers into file offsets,
causing concurrent readers to dereference invalid addresses. This patch
upgrades the synchronization from a read lock to a write lock during the
translation window to exclude concurrent readers.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 091d8f7f6bd2c..70ba9570e3179 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1120,7 +1120,8 @@ static int write_bpf_prog_info(struct feat_fd *ff  =
__maybe_unused,
>  	struct rb_node *next;
>  	int ret =3D 0;
> =20
> -	down_read(&env->bpf_progs.lock);
> +	/* write lock: bpil_addr_to_offs() temporarily mutates info_linear */
> +	down_write(&env->bpf_progs.lock);

[Severity: High]
This is a pre-existing issue, but does upgrading to a write lock actually
prevent concurrent accesses from seeing the mutated pointers?

Looking at perf_env__find_bpf_prog_info(), it acquires the read lock but
drops it before returning the node pointer:

tools/perf/util/env.c:perf_env__find_bpf_prog_info() {
    ...
    up_read(&env->bpf_progs.lock);
    return node;
}

This means callers like machine__process_bpf_event_load() will dereference
the pointer locklessly:

tools/perf/util/bpf-event.c:machine__process_bpf_event_load() {
    ...
    u64 *addrs =3D (u64 *)(uintptr_t)(info_linear->info.jited_ksyms);
    ...
}

Because the primary readers are accessing the data outside the critical
section, could they still observe a file offset instead of a valid pointer
even with down_write() here?

> =20
>  	ret =3D do_write(ff, &env->bpf_progs.infos_cnt,
>  		       sizeof(env->bpf_progs.infos_cnt));
> @@ -1150,7 +1151,7 @@ static int write_bpf_prog_info(struct feat_fd *ff  =
__maybe_unused,
>  			goto out;

[Severity: Medium]
This isn't a bug introduced by this patch, but could calling
bpil_offs_to_addr() just before this return permanently corrupt the state
for empty trailing arrays?

If a BPF program contains an empty array (count =3D 0) at the end of the
serialized struct, its offset is exactly data_len. When this function calls
bpil_offs_to_addr(node->info_linear) to reverse the offsets, it hits this
bounds check:

tools/perf/util/bpf-utils.c:bpil_offs_to_addr() {
    ...
    if (offs >=3D info_linear->data_len || ...)
        ...
        info_linear->arrays &=3D ~(1UL << i);
    ...
}

Since offs >=3D data_len evaluates to true, will this falsely mark an empty
array as absent in the arrays bitmask, corrupting the live in-memory object?

>  	}
>  out:
> -	up_read(&env->bpf_progs.lock);
> +	up_write(&env->bpf_progs.lock);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802142712.1547=
26-1-acme@kernel.org?part=3D2
