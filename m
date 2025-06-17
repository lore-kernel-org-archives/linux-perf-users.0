Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B460335C7;
	Tue, 17 Jun 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141987; cv=none; b=pIjmtxx+KQd9n3UUox46L0Dfd3c5sOJfKXwCJx+x+qEFdRrjXXpKewAVlA+WUkU1m3yioLh3OxBI8PMwm0U5JEOuwdrluY2+soYM2kwKN2QqnbFC2kRLaJNwO4Nd9Tp73rlvpU8MzYGNJmZT9hfOIpb6b4Z0ERng4hlI65e0+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141987; c=relaxed/simple;
	bh=o089/DcX6hGCVVYWkkX0LR4/6akPcznW+rKNIEoT1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQeiQFCqM4kUWEyv7f1pwgluzRYBQn7saXPu1EWt9ICwJDTyJrGEz5UlOyH2m1aXBVlBDaCy1VRlHKTFmubKbKo7fjCpYibMcEwbWRtdJuqt0mbyn/1fVAZi1CwrPR8RX37QZZVjfgQo47v9yZLWyfr7HQ/wMfv0/h02x3a1Pak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5VyircR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5VyircR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57BEC4CEE7;
	Tue, 17 Jun 2025 06:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750141987;
	bh=o089/DcX6hGCVVYWkkX0LR4/6akPcznW+rKNIEoT1Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5VyircRh3PmSdJEQJp0EHvniyntC+VMtVjTvvrS7ApVDlYLaM/7yiehxLI9EfYCO
	 rsxyZmo+24q3GcwztkesNUFUB8KY2f8UJ7ZzGhZ7gQ8X21A74GzPaG6PM4fHKFBvYC
	 o2VL3l0KHdWZnmZASzsdt+BKCcj0uzJOqMxlEwMzI60+kZlCxZGHynJVI5jdCDZ58V
	 WzFfjO49ysR5ZgeVAqHf4M75n/wqqwh7mmhI5PPRMzIG4iI5izxsEKiFdRxbVDoLgJ
	 GitL7fFkDgsd5bdq0ZHQ/iGQ2sp9MD+HIKuuE7rRJlEeBHxAUjvBdrYdCXfh+1wWdb
	 /FFOaK0Ym+lAQ==
Date: Mon, 16 Jun 2025 23:32:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Ian Rogers <irogers@google.com>, Yuzhuo Jing <yuzhuo@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
Message-ID: <20250617063236.GI8289@sol>
References: <20250617005800.1410112-1-irogers@google.com>
 <20250617005800.1410112-2-irogers@google.com>
 <c57de5bf-d55c-48c5-9dfa-e2fb844dafe9@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c57de5bf-d55c-48c5-9dfa-e2fb844dafe9@csgroup.eu>

On Tue, Jun 17, 2025 at 07:22:57AM +0200, Christophe Leroy wrote:
> 
> 
> Le 17/06/2025 à 02:57, Ian Rogers a écrit :
> > Type punning is necessary for get/put unaligned but the use of a
> > packed struct violates strict aliasing rules, requiring
> > -fno-strict-aliasing to be passed to the C compiler. Switch to using
> > memcpy so that -fno-strict-aliasing isn't necessary.
> 
> VDSO build fails with this patch:
> 
>   VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
> arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not
> supported
> make[2]: *** [arch/powerpc/kernel/vdso/Makefile:79:
> arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
> 
> Behind the relocation issue, calling memcpy() for a single 4-bytes word
> kills performance.

memcpy() does normally do the right thing for unaligned accesses of 1, 2, 4, or
8-byte values.  The snag here seems to be that the VDSO is built with
-fno-builtin (and -ffreestanding which implies -fno-builtin).  That causes the
compiler to no longer optimize out the calls to memcpy().  If __builtin_memcpy()
is used instead of memcpy(), it does work and generates the same code as before.

- Eric
