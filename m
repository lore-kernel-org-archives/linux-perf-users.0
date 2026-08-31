Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F75343885
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182638; cv=none; b=a0zKk4DHeCxJei+1H/tDCZ3MDfYPJP2onO/EwsgT4g3HMbwxbY38y3PrzP7+W8c3YsxLcOmvVkowD3rVK9UryWi8GL2ghQUFrlCSlCDSjsdpDvQjFOXdMyf8McM0ROeN51ySaEngLdAobBq0m9QWZnnDydcrLhhSjUfS5sDlmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182638; c=relaxed/simple;
	bh=JaCN0jzXDgzzoYb6BarpeS9hZ5kXMKhaeBKNt4gC56A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAY2FcDdofAOk7wMaLJMxmc/wKTGdWslGx36tVNDmEb81mrs4tBJFqmJWpIseALtD4/DzSW9ZsQVbRRjspu6Wepl9se5MO2b8ZF95f/olIbxx/j77Fru9B0xFyFPbvWb9JFOFzmTOCWejfUe05qzHQc0Rq6qrPBQjaWh1xE6NyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilW1gl5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilW1gl5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07401F00A3D;
	Mon, 31 Aug 2026 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182636;
	bh=tkbF3iZ9t2dt2TIcMW5Ro2eAu72tZxOgkfYvu3G2s5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ilW1gl5nncobAFD0eUYNxBxI4zSt7tbJYVjJzVZQB0tcI8Tp72W4JoJ/qOEwHO6Vy
	 QI/XTMrlitLHd1NyuLZ5k6WOOArLAyYTdnUlKDGU4yovgHWvY44pElamjLkkAqNvzB
	 GvKEcXrQiu3GvyFoKVv4bKo1JDYzVIlVceKd8gCelaaIcHhjyD7WL3sK+jz4lWe9a2
	 rqQZxNZqXoKdbz5+uwoQbgTVz+m59sIC2jHM82417XUSHtCbOgAl0TTWV95up8NcRP
	 MTdIKwaCMxZalQi2BLs8mgclRkzKBQRRPFdXMEFRTNybH8YHERPi/VExDj4/T6WVQa
	 BK+BclC6bxUoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] perf jitdump: Bounds-check debug entry byte-swap
 loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-6-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:23:56 +0000
Message-Id: <20260831132356.C07401F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unaligned memory accesses leading to SIGBUS crashes on strict-al=
ignment architectures.
--

commit 947f2eb889b5646cf554f70f7bd7ac567ceaa090
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Bounds-check debug entry byte-swap loop
   =20
This commit replaces fixed-size array indexing with pointer arithmetic using
debug_entry_next to iterate variable-length debug entries in
JIT_CODE_DEBUG_INFO records. It also adds bounds checking against the total
record size to prevent out-of-bounds reads.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index f79e9420c6bd7..7efbaa07f1ba7 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c

[ ... ]

> @@ -320,14 +320,32 @@ jit_get_next_entry(struct jit_buf_desc *jd)
>  	switch(id) {
>  	case JIT_CODE_DEBUG_INFO:
>  		if (jd->needs_bswap) {
> +			void *end =3D (void *)jr + jr->prefix.total_size;
> +			struct debug_entry *ent;
>  			uint64_t n;
> +
>  			jr->info.code_addr =3D bswap_64(jr->info.code_addr);
>  			jr->info.nr_entry  =3D bswap_64(jr->info.nr_entry);
> -			for (n =3D 0 ; n < jr->info.nr_entry; n++) {
> -				jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
> -				jr->info.entries[n].lineno  =3D bswap_32(jr->info.entries[n].lineno);
> -				jr->info.entries[n].discrim =3D bswap_32(jr->info.entries[n].discrim=
);
> +
> +			/*
> +			 * debug_entry has a variable-length name[], so array
> +			 * indexing would compute wrong offsets =E2=80=94 use
> +			 * debug_entry_next() and bounds-check each entry.
> +			 */
> +			ent =3D &jr->info.entries[0];
> +			for (n =3D 0; n < jr->info.nr_entry; n++) {
> +				if ((void *)ent + sizeof(*ent) > end)
> +					break;
> +				/* name must be NUL-terminated within the record */
> +				if (!memchr(ent->name, '\0', (char *)end - ent->name))
> +					break;
> +				ent->addr    =3D bswap_64(ent->addr);
> +				ent->lineno  =3D bswap_32(ent->lineno);
> +				ent->discrim =3D bswap_32(ent->discrim);

[Severity: Medium]
Does this code risk triggering unaligned memory accesses and SIGBUS crashes
on strict-alignment architectures?

In jitdump files, the debug_entry structure is packed with a
variable-length name string without padding. The pointer arithmetic in
debug_entry_next advances the ent pointer by the exact string length
(including the NUL byte).

If the string has an odd length, subsequent ent pointers will no longer
be aligned to an 8-byte boundary. Because the struct lacks the __packed
attribute, the compiler assumes natural alignment.

When it emits standard aligned load and store instructions for the 64-bit
addr and 32-bit lineno fields, they will trap when receiving an unaligned
address while parsing cross-endian jitdump files in jit_get_next_entry.

> +				ent =3D debug_entry_next(ent);
>  			}
> +			/* clamp so downstream consumers don't overrun */
> +			jr->info.nr_entry =3D n;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D5
