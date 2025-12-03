Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E41DDAB
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764725292; cv=none; b=arG0c0viDS7hCunirAgSaEiPEXOCB6SkmKqYsYIbmNXJ/nVhjjO30tV9UEvZtOB8VwR3LyempunAszE4NwHSenqBl+Q3j/CVx2TFUV7Zws3kh/bPlb7QXtdsrA/ReCYEOimSXkKnNPNXinTTDMvkRMDwVpwH7qJOatl4WHHGsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764725292; c=relaxed/simple;
	bh=YKUzWvNJdlQYgTLX/pWV09r1PX9+0LmCn8R8nVh5pBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch1035Vfn5BwxijgQcKmLKDajLOPYR0EWKtXWiKBOmaToSEF2nPjws5PN3kyce1WhNx2a3eXqvv7rCl+/vE6F1D5bIUIaxWjqCTvoT0iZOmvjYzbBtPZrxwhVmofobfQJv+265ka/l5TT7ZeOVcvQqJiMTkrMx0f3DV/tgMgylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b26332196so1570155e0c.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 17:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764725288; x=1765330088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OULFOWieLdWDEJWsO8MWmGNNjukLt8vuIsI3P0/MGDw=;
        b=MFVo+AbPPZUtHW3EPnp+cdSKEjLKVA4bTHsw5XVsg7yJrs5UfpOpsaZ/3A2hhSMxmy
         EW2flQJOxZW86wy3lrXrudACphkbCsDNvJjJ9XWZBpHpFplvadHB7FpczcYsbxnaL54L
         +6eYygcXOj/7zwasEV+h+jsHnUWDjadWOMpjzdw9eNA3xtpe26mmetvHffffbfEw/iJ6
         d5om8OWRlJ0J8ZQQPX34cDD4PPFPlHGpQVuSt2jGmduXXzA54OU/aYbSP5DnskUslz2I
         NGEhyVL/i5jCkhGWcOkhzgnQesz5GYBXAO39GxNMOHasGNbIQ5QNvDPu0TPt/Tx1Xobt
         7TEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBHJLSZA9ZiJzfoPOjSK1aGTGZdw5GC1LBpONVLQTsG4zAi0cK4aSccxuBLisPZ+1lDU2lcMh/N1d254MaI80V@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq805GPLoTrlfKTUa0R1CjGiuGUonM5Mzq92/i/hqmqiLeBMZ3
	40JI2XyB2sNV9pRYGAud0eQSS5iEep8G6vF44AhenSKUf2xQrVcZNZ/irsDUCd+e
X-Gm-Gg: ASbGnct83O4smCh7W5i7COF1XhahmGcEOUqDblkH1ZdUPBUh0scOhIEMy0CzWpf3Dfx
	pk9XZx2a+ZWuCWmvm5y7px5RhM65Ovkc409M6My9Xuzt4PLOx0uHwSDNNnJPBQ8/YqGPbLvRTJX
	uJ+hKE7X/bDHxbM9PuDrlrupfZygB0Ylf451ZZMrmzFABhWc3qk8pNEL+Iq79VfZo9HX7R7sTwB
	MpbxwEk5+NECoHLg6WIqsFQiSgvQZ/LJQOD3vuGChrnp2Qb/N7CRyjsZFdcBkku7DOSSfyJC8Lr
	5kZOy1QdcF0KDZKItJX0KdsXe0q38dngDbIO9tvivqDchLbNwVL4VGYqh1c9rkWuOlIDwbw+O5r
	yXFMbPiX5OWgfpXwxh4Gv4m1xkjQH52ACjp4ZFbhX8F/lUd2LkeJfdQ+26oH91YLzTyIq7jB5pU
	4vedA6w24fLeABAZuKKDkMpF93VieJzBHXCGoix7ucuVELmkzPN8P7/K8=
X-Google-Smtp-Source: AGHT+IFKs+bLN47jigee45nRcdP7Jzp2XWUVQad/jDnR7r62/6n2OPsOlK0pFQylXBIT4YmS9+Aigg==
X-Received: by 2002:a05:6122:6e13:b0:55b:7494:1736 with SMTP id 71dfb90a1353d-55e5bf988a3mr207433e0c.14.1764725288202;
        Tue, 02 Dec 2025 17:28:08 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf518c3efsm7378884e0c.22.2025.12.02.17.28.07
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 17:28:07 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b26332196so1570150e0c.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 17:28:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsNDt9Eth4Xjx1kPpSEWXKdu68aPydcQEmqeMAoS/GLEC+b8v46WUXUTUDXcUIRTQW919OT7/lDPAqbT7DOUq7@vger.kernel.org
X-Received: by 2002:a05:6122:2187:b0:559:65d6:1666 with SMTP id
 71dfb90a1353d-55e5be4ef9cmr267163e0c.1.1764725287209; Tue, 02 Dec 2025
 17:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125080748.461014-1-namhyung@kernel.org> <20251125192943.GA3061247@google.com>
 <CAP-5=fXh82HpvLhPr9uFtq=HK5V+ZL3xntz7-gspEE5az2+7nw@mail.gmail.com>
 <20251126030452.GA85316@sol> <aSi_zXuT8isr8jEC@google.com>
 <20251127221822.GA2977@sol> <aS9gms3-xGaIpUnt@google.com>
In-Reply-To: <aS9gms3-xGaIpUnt@google.com>
From: Fangrui Song <maskray@sourceware.org>
Date: Tue, 2 Dec 2025 17:28:23 -0800
X-Gmail-Original-Message-ID: <CAN30aBEdbSLH_ZRLAJzY0JwwE4jHtaWRpHkWeOnScqR4rbDHTQ@mail.gmail.com>
X-Gm-Features: AWmQ_bllQZKFWxq5wBQI9JU2o7nruhe-Vq5pYPJCdS73DB-cNQsakjDBpsVSB_c
Message-ID: <CAN30aBEdbSLH_ZRLAJzY0JwwE4jHtaWRpHkWeOnScqR4rbDHTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID generation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Pablo Galindo <pablogsal@gmail.com>, 
	Fangrui Song <maskray@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 1:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 27, 2025 at 02:18:22PM -0800, Eric Biggers wrote:
> > On Thu, Nov 27, 2025 at 01:17:01PM -0800, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Tue, Nov 25, 2025 at 07:04:52PM -0800, Eric Biggers wrote:
> > > > On Tue, Nov 25, 2025 at 06:55:39PM -0800, Ian Rogers wrote:
> > > > > On Tue, Nov 25, 2025 at 11:29=E2=80=AFAM Eric Biggers <ebiggers@k=
ernel.org> wrote:
> > > > > >
> > > > > > On Tue, Nov 25, 2025 at 12:07:46AM -0800, Namhyung Kim wrote:
> > > > > > > It was reported that python backtrace with JIT dump was broke=
n after the
> > > > > > > change to built-in SHA-1 implementation.  It seems python gen=
erates the
> > > > > > > same JIT code for each function.  They will become separate D=
SOs but the
> > > > > > > contents are the same.  Only difference is in the symbol name=
.
> > > > > > >
> > > > > > > But this caused a problem that every JIT'ed DSOs will have th=
e same
> > > > > > > build-ID which makes perf confused.  And it resulted in no py=
thon
> > > > > > > symbols (from JIT) in the output.
> > > > > > >
> > > > > > > Looking back at the original code before the conversion, it u=
sed the
> > > > > > > load_addr as well as the code section to distinguish each DSO=
.  But it'd
> > > > > > > be better to use contents of symtab and strtab instead as it =
aligns with
> > > > > > > some linker behaviors.
> > > > > > >
> > > > > > > This patch adds a buffer to save all the contents in a single=
 place for
> > > > > > > SHA-1 calculation.  Probably we need to add sha1_update() or =
similar to
> > > > > > > update the existing hash value with different contents and us=
e it here.
> > > > > > > But it's out of scope for this change and I'd like something =
that can be
> > > > > > > backported to the stable trees easily.
> > > > > > >
> > > > > > > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto depen=
dency and use built-in sha1()")
> > > > > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > > > > Cc: Pablo Galindo <pablogsal@gmail.com>
> > > > > > > Cc: Fangrui Song <maskray@sourceware.org>
> > > > > > > Link: https://github.com/python/cpython/issues/139544
> > > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > >
> > > > > > That commit actually preserved the behavior of the existing var=
iant of
> > > > > > gen_build_id() that was under #ifdef BUILD_ID_SHA.  So I guess =
that code
> > > > > > was always broken, and it was just never noticed because the al=
ternative
> > > > > > variant of gen_build_id() under #ifdef BUILD_ID_MD5 was used in=
stead?
> > > > > >
> > > > > > The MD5 variant of gen_build_id() just hashed the load_addr con=
catenated
> > > > > > with the code.  That's not what this patch does, though.  So ju=
st to
> > > > > > clarify, you'd actually like to go with a third approach rather=
 than
> > > > > > just restoring the original hash(load_addr || code) approach?
> > > > > >
> > > > > > Also, I missed that you had actually changed the hash algorithm=
.  I had
> > > > > > assumed the perf folks were were pushing SHA-1 because they wer=
e already
> > > > > > using it.  Given that the algorithm changed, there must not be =
any
> > > > > > backwards compatibility concerns here, and you should switch to=
 a modern
> > > > > > hash algorithm such as SHA-256 instead.
> > > > > >
> > > > > > I'd be glad to add an incremental API if you need it, but I'm c=
onfused
> > > > > > why you want SHA-1 and not a modern hash algorithm.
> > > > >
> > > > > Hi Eric,
> > > > >
> > > > > Thanks for the help with the hash functions! There's a bit more
> > > > > context in this thread:
> > > > > https://lore.kernel.org/linux-perf-users/CAP-5=3DfWLgaWsv82dcPajV=
k=3DUmBbmwyEd7OVp6psZQ4TiXh-Meg@mail.gmail.com/
> > > > >
> > > > > So genelf is trying to take snippets of jitted code and create EL=
F
> > > > > files from them for the purpose of symbolizing in perf. The build=
id
> > > > > hash being used is SHA1 and I think the MD5 support was removed a=
s
> > > > > unnecessary. The problem this patch is addressing is that a JIT m=
ay
> > > > > create many identical stubs which then end up being deduplicated =
into
> > > > > the same buildid as only the code is hashed. The BFD linker seems=
 to
> > > > > have the same issue (Fangrui filed a bug), gold and lld appear to=
 hash
> > > > > the symbols (which Namhyung adds to genelf here) but still yield
> > > > > different build id for the same source assembly code. It is possi=
ble
> > > > > to hash the address of the symbol rather than the symbol itself, =
but I
> > > > > think the intent for the code should be to best match what a comp=
iler
> > > > > and linker would generate. The problem there is that this differs=
 for
> > > > > every linker :-)
> > > > >
> > > > > Something that is unfortunate in the code now is copying/concaten=
ating
> > > > > all the build data for the sake of producing the hash. It would b=
e
> > > > > nice if the code could incrementally build up the sha1 hash to av=
oid
> > > > > the copying. I don't know if there is functionality for this
> > > > > currently.
> > > >
> > > > Again, I can add support for incremental hashing if you need it.  B=
ut I
> > > > don't understand why you want the hash function to be SHA-1.  Also,
> > > > given that this seems to be a regression fix, it's surprising that
> > > > you're suddenly changing the inputs to the hash entirely, instead o=
f
> > > > just going back to hashing load_addr concatenated with the code for=
 now.
> > >
> > > Historically MD5 or SHA1 was the only choice for build-ID in linkers.
> > > I don't know if it's changed lately though.  But because of that we
> > > support build-IDs up to 20 bytes and it's in the UAPI too (well.. it'=
s
> > > implicit in PERF_RECORD_MMAP2).  I think we can support other hashs i=
f
> > > they fit into it, but SHA-1 would be the right choice for now.
> > >
> > > About load_addr, I don't think it's the right fix.  We cannot have th=
e
> > > exactly same build-IDs as before since we already switched to SHA-1.
> > > What we actually want is a way to generate unique IDs for each DSO.
> > > For that purpose, it'd be nice to use sym/str-tables as Fangrui said
> > > instead of using load_addr which seems to be a quick hack in the past=
.
> > >
> > > So I think I can merge this change for stable fix.  And add increment=
al
> > > SHA-1 (thanks in advance!) and update the code to it later.
> >
> > If it needs to be 20 bytes, you should just use a truncated SHA-256.
> >
> > The only use for SHA-1 is backwards compatibility.  Which it seems you
> > don't need.
>
> I think the linker (ld) --build-id still defaults to SHA-1.
>
> Thanks,
> Namhyung
>

In all GNU ld compatible linkers I am aware of, --build-id is an alias
for --build-id=3Dsha1.
However, lld (since https://reviews.llvm.org/D121531 ) and mold
actually truncate BLAKE3 to 20 bytes for "sha1".
