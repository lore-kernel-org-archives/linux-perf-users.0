Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634261;
	b=jLSMGoT0wuDKxMKErYIl7ouKQrfY007lQ1YfZ/hKZ3zOhfW4xWf0oJKFmUpzocAgqouy
	 jWS4hPVgvGmoOz0u74i1bm+3NkadXhnOzotKpraUPnkuGl+ddKruxAmhov3lPJMagrRbe
	 s9zblXTQ1QBrtkrumjaTmBoeyGmL6TuZ77xbFlf/kUG3qc3rb9emU9YSOgrO6KsJK225N
	 wdCS3qf3+NqzSJf7iAldyaIRFTPbEXotkeJ7Jw3Zlveuj+Hdmu2zPEVyyBdRDqu7jrvOK
	 /zYEvpLKuLuPnhpHarYYIM60BIMH1pCaraIOcPemqJFn9c7XdHF9xLixwPYfiDbCeWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634261;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h+qJ7AVv/2TPbRxPGluMKWopX+jgLTpjd8UbRNu6hqI=;
	b=CoE6Uss3t/P8i8jiCfkBwpF6dEpG1r6gmaEbayDbutZR8ScozbAwBUAIhKH3bY+fehbs
	 0lRkN6g6QsDBhkzxwiSQTlmtcmvvJOq6pIk66QJgT5gCg2uAaVn6LIFsmw6bu5ECK0wlv
	 393fxERSoYIge8e8w/nRm7oAUEL4GGTfriMtbPfUUWVA5fImshjLAu3i73BGqp+RTVB1Q
	 JTykEes8XOcJpfmm7oOvwSPX34UPp6V2x1PwyFmdL9M/rCm2Pa6eWQK4AGp1wTKJS/NtS
	 Toj4lsM62gaX+F073ugydtMBIEKrBR01jABLFaoBzrK09KN4sERJj0cQOYIVsPkHXsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvW2yX0s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CED606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvW2yX0s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5F81F000C4;
	Sat, 14 Nov 2026 05:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794634260;
	bh=h+qJ7AVv/2TPbRxPGluMKWopX+jgLTpjd8UbRNu6hqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QvW2yX0sxMgsp18aPcTCvmYcE9RC0Juy5Q+dKQ8nixD/mdHv051Qq0qHlt3uu+EzJ
	 5Mk0Ppmti/8jPn9Vw0FevWl9OJohCktKoNA4hXy6B3qYzSg7GymMnlQmdM5uS+zcdV
	 p+ficZ0nt7IGib9jTZvkjJSLqEKSTN97mavPNqsaVddpohpwT7OBgK2F5LCYRA90wY
	 ghbAEbCvYbKHkeHaL1eqMNyIBz1kclV1RcO/snmyV/TEFK6EFmuiDrEXebsEuiZmaI
	 AQvrRjcB2hsJQAWFuXSsXIVanHyDLgUDuIOYadxZjHpEx7LUMAgdYtCaTfpwE9Ltal
	 X1+ArqxI3Ftbg==
Message-ID: <sashiko-outbox-214179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] perf script: Add --lazy-load-symbols to load
 symbol names lazily
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113-perf-symbol-memory-send-v7-3-d992eced9f9c@uber.com>
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
 <20261113-perf-symbol-memory-send-v7-3-d992eced9f9c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:31:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf symbols: skipping .dynsym copy in dso__load_sym_internal()
  alters fixup
--

commit bbcf49c4a773356002f2cf428fb0dbd0071729ba
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Add --lazy-load-symbols to load symbol names lazily

This commit adds a --lazy-load-symbols option to perf script that defers
reading and demangling userspace ELF symbol names until a symbol lookup
returns them, storing the string table file offset in the meantime.

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 98b6d7c73d235..7b7f06a882f61 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c

[ ... ]

> @@ -1774,14 +2020,36 @@ dso__load_sym_internal(struct dso *dso, struct ma=
p *map, struct symsrc *syms_ss,
>  			}
>  		}
> =20
> -		demangled =3D dso__demangle_sym(dso, kmodule, elf_name);
> -		if (demangled !=3D NULL)
> -			elf_name =3D demangled;
> +		/*
> +		 * Most .dynsym entries are copies of .symtab symbols, which
> +		 * duplicate selection would drop anyway. Skip them here, so
> +		 * that perf does not read both names just to choose one.
> +		 */
> +		if (lazy_names && dynsym && !symbol_conf.allow_aliases) {
> +			f =3D lazy_dynsym_copy(dso__symbols(curr_dso), elf, &sym, elf_name);
> +			if (f) {
> +				if (GELF_ST_TYPE(sym.st_info) =3D=3D STT_GNU_IFUNC)
> +					symbol__set_ifunc_alias(f, true);
> +				continue;
> +			}
> +		}

[Severity: Low]
Can skipping the .dynsym copy here change how symbols__fixup_end() and
symbols__fixup_duplicate() resolve symbols when .symtab also has a
zero-size symbol at the same address?

__symbols__insert() places symbols with equal start addresses in insertion
order.  If .symtab has a sized symbol followed by a zero-size symbol at
the same address (such as an assembly label without a .size directive),
and .dynsym has a copy of the sized symbol, eager loading inserts the
.dynsym copy after the zero-size symbol.  When symbols__fixup_end() runs,
the node following the zero-size symbol still has the same start address,
so the zero-size symbol keeps a zero length and symbols__fixup_duplicate()
drops it in favor of the sized symbol.

When this check skips inserting the .dynsym copy, the zero-size symbol is
left as the last node at that start address.  symbols__fixup_end() then
stretches its end to the next higher symbol address (or rounds it up by
4096 if it is the last symbol), giving it a bogus non-zero size so
symbols__fixup_duplicate() no longer discards it for having zero length
and can select it over the real sized symbol.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-perf-symbo=
l-memory-send-v7-0-d992eced9f9c@uber.com?part=3D3
