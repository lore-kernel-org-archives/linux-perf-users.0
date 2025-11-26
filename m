Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D930B500
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125754; cv=none; b=JW2ij2FmrufbDQiA+tUiMnykI/p0caihQ83PviO6qoCgMX5lBlquEzD3O9uZTu9Us+GOelr8fI55iyv/n4IdpMDxshIjXUjlPGTXlnMHPFBih5rDZcAgNfX+IZtee2uWdMdFTYhrbs2ZGwTUSPNkeSwteq7UiXc2S7FLcoO2h1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125754; c=relaxed/simple;
	bh=k6ODn+h4GMD5pElMKzN/y3oL1Qa5060Grh8ujLoVuFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UruhbFPgXWjEcMi5VZjPszZtsIMyHUYrkbBP41FZAFWVK5Wa7BZTzVp1SGAgt1emZqY2ygXhmzQAQSLhdp6NqJdPvfGZdRX/iTyCDDgehVS2MJW71OGLpZ/KryMBmwMZ2F7oxsLuCD6S4Wis63lKD2zqLGbAjimVUmMEFnTRsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIb9QAYy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIb9QAYy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295c64cb951so105745ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 18:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764125752; x=1764730552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d2IYUN6Qi6hFF0h/BgZUBXwSSP8cDjwAPXk4mMUv4w=;
        b=MIb9QAYyHSNhTV+3cfLnX961azZI973yilpZg/bWTGjywALSGYoWD1zWiH8YQIUOHH
         utQDA14F6QUB3KfUNztAPdJxKd58cvz2enj4RZMXBNjUhw3t8DBbJp02OaiIqTPjqqoA
         EQJHjSA8shS9F2FlYeM7LKS3cxF4XMVjn8p2SfJLvzauHDRn9IWImtxHrGoY44uzOgkp
         TQr01C1FS/GikiFBiQmLYNSq55EWWIxYStcRyNrVaM8vaxJlRDU1zw21xq1PDsaViQgw
         7PV6JtuLeIp/TlsU5aXnEGXMK/lrxOdTxpUNeX5bAOAySd5YoqIqgLYOcugmSlLePSiX
         T8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764125752; x=1764730552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7d2IYUN6Qi6hFF0h/BgZUBXwSSP8cDjwAPXk4mMUv4w=;
        b=NEMwl9zafYbhkjVAshPX5MZH14si4WFKoY5+rodb+u1QuJb6Jw/E8d2WzrQ0ibMa2D
         FjhU0HB8tdvfyELK2z3TQzd6XQ2eqEBOFP3kVYkriGCb8dO6nT2hZTb1od+GV5swEQOQ
         VhY3hM6J0ba+epeD2RnIni4Hk3IXKufGH8OHlME1oW4SY9SHgT9u4Sp+18vb+FKGpErN
         mULZk2sIcuFcwMGAD+jBrq+YNsIrn1oV4Jp2RN5Eswkvvoa5giEKbYoXQCyMmHBTgPBF
         0qbxVjrbLceIqaJukPt92B/gWKqCmBmPPPczQohwDh/gybn9R8eUIrvwVS0HJFtu4G1y
         C8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXjgGOC2NINL7iS8NC+++VkArorJ+8VjoFXTzidnEGGdvANtklVFsjq1yeAC7dsBuAGKu+UA8NWE566DipzgIS5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4V8xVgfZO8iQDYHjV3xztlfnDyzo0dfwopjgYw1PfWneBIdfN
	hs4GREy4Oh+Y28pDGQD5/CBgVX3SRT9QDBEjC1k7wdGgKNpW2clz4xdXn9P7A6UwucoAmIlRnl4
	ff2AC85pToS7zLzQPpFlC2H1ShpNnl/8rROJz2t0t
X-Gm-Gg: ASbGncvhloNs0xw9NUsFMpa3IJqFExEIPwT3OIBAsBkVrkZ9yld2fudOzj1WqfPhBZK
	4ptEHz882LwJlD7aICC5T0nl8CERMW4LjLDo2CYU0nv+JGnJfMbzR0TFUqGXmiM+e9aAUgBKfaY
	UX7TYvh3bi6zpbl1i+tai7FsSNQfd5kmrON1z2pdJyiV7c12alrdxwOUNjWwtzNzcb6ZDYX0CPJ
	VfW3Kml4uwlsiwzg+7acHNc0rr/qKMfdceEDCS4EUu/P83nbt09PNNzuRCf0/kJj++i6Cb0+hCw
	Czcx/QI=
X-Google-Smtp-Source: AGHT+IHIvmXP4Ez0Ta921dj+kykbLTpa+PnVM4TvDE9kKpXDbtr0v5O+7Sb25E+ttHMy7LrGeBgDse7heWgRLabefcs=
X-Received: by 2002:a17:903:2341:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-29bb8f38d02mr1375935ad.4.1764125751822; Tue, 25 Nov 2025
 18:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125080748.461014-1-namhyung@kernel.org> <20251125192943.GA3061247@google.com>
In-Reply-To: <20251125192943.GA3061247@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Nov 2025 18:55:39 -0800
X-Gm-Features: AWmQ_bnXulSaSKTvNpjzwHINdKdzIlZtbD2ddoiAegyrZ4GLTzHlQgGU4CrW0q0
Message-ID: <CAP-5=fXh82HpvLhPr9uFtq=HK5V+ZL3xntz7-gspEE5az2+7nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID generation
To: Eric Biggers <ebiggers@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Pablo Galindo <pablogsal@gmail.com>, 
	Fangrui Song <maskray@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:29=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Tue, Nov 25, 2025 at 12:07:46AM -0800, Namhyung Kim wrote:
> > It was reported that python backtrace with JIT dump was broken after th=
e
> > change to built-in SHA-1 implementation.  It seems python generates the
> > same JIT code for each function.  They will become separate DSOs but th=
e
> > contents are the same.  Only difference is in the symbol name.
> >
> > But this caused a problem that every JIT'ed DSOs will have the same
> > build-ID which makes perf confused.  And it resulted in no python
> > symbols (from JIT) in the output.
> >
> > Looking back at the original code before the conversion, it used the
> > load_addr as well as the code section to distinguish each DSO.  But it'=
d
> > be better to use contents of symtab and strtab instead as it aligns wit=
h
> > some linker behaviors.
> >
> > This patch adds a buffer to save all the contents in a single place for
> > SHA-1 calculation.  Probably we need to add sha1_update() or similar to
> > update the existing hash value with different contents and use it here.
> > But it's out of scope for this change and I'd like something that can b=
e
> > backported to the stable trees easily.
> >
> > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and =
use built-in sha1()")
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Pablo Galindo <pablogsal@gmail.com>
> > Cc: Fangrui Song <maskray@sourceware.org>
> > Link: https://github.com/python/cpython/issues/139544
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> That commit actually preserved the behavior of the existing variant of
> gen_build_id() that was under #ifdef BUILD_ID_SHA.  So I guess that code
> was always broken, and it was just never noticed because the alternative
> variant of gen_build_id() under #ifdef BUILD_ID_MD5 was used instead?
>
> The MD5 variant of gen_build_id() just hashed the load_addr concatenated
> with the code.  That's not what this patch does, though.  So just to
> clarify, you'd actually like to go with a third approach rather than
> just restoring the original hash(load_addr || code) approach?
>
> Also, I missed that you had actually changed the hash algorithm.  I had
> assumed the perf folks were were pushing SHA-1 because they were already
> using it.  Given that the algorithm changed, there must not be any
> backwards compatibility concerns here, and you should switch to a modern
> hash algorithm such as SHA-256 instead.
>
> I'd be glad to add an incremental API if you need it, but I'm confused
> why you want SHA-1 and not a modern hash algorithm.

Hi Eric,

Thanks for the help with the hash functions! There's a bit more
context in this thread:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfWLgaWsv82dcPajVk=3DUmBbmw=
yEd7OVp6psZQ4TiXh-Meg@mail.gmail.com/

So genelf is trying to take snippets of jitted code and create ELF
files from them for the purpose of symbolizing in perf. The buildid
hash being used is SHA1 and I think the MD5 support was removed as
unnecessary. The problem this patch is addressing is that a JIT may
create many identical stubs which then end up being deduplicated into
the same buildid as only the code is hashed. The BFD linker seems to
have the same issue (Fangrui filed a bug), gold and lld appear to hash
the symbols (which Namhyung adds to genelf here) but still yield
different build id for the same source assembly code. It is possible
to hash the address of the symbol rather than the symbol itself, but I
think the intent for the code should be to best match what a compiler
and linker would generate. The problem there is that this differs for
every linker :-)

Something that is unfortunate in the code now is copying/concatenating
all the build data for the sake of producing the hash. It would be
nice if the code could incrementally build up the sha1 hash to avoid
the copying. I don't know if there is functionality for this
currently.

Thanks,
Ian

> - Eric
