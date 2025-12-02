Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50463200C2
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718033; cv=none; b=NvhgNsd2MWdYprQgpnZ1Zy4fMWvxzDKdU8SsLqd9ufaIVvo7frOk17wSEHbBAu6LVqsqCchYOnqYmJrgMOhYhIVGj90EVAMNvo50iPyAH7OOTYHOptxE6U335n4CcpN0YCOsZLeJM4bXNl5ke791U82tWWvbeEXRi7AOg23b59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718033; c=relaxed/simple;
	bh=jxPxNFZzazf+jEo0eCbTc6mrmonbY2MAHKVyJdYjKxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJiLaZKB5orcov5oAqPnSvJiw38Wq/vxQohx16WF28v7SvjHf204dgZu+cOsSo6YEm2ixar7uhL3rpAFa/Jzh7ux1dPfM5N2C/viAnfVpSc/OEOiHVCMWvZK0aJ0Nx1iAcQj9OVrFKAdHabALnOl5t511ydAujnHMVk2gigFv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4F79JM5a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4F79JM5a"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980343d9d1so32715ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 15:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764718030; x=1765322830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWFQCVhiQmz5Lpf2ZXwd0aP4zbVFu1vPcerzGzxuFaY=;
        b=4F79JM5aE9ZZIfNG/sSLY+FJPI/H5Oe8m8PQ/SWeUjmMZK2or1MRr7+3Hdru8r89ps
         YnVq4NBft91XX3Q2rEdeH6k1yPsHjWyRaeHsof8MkYhpKhZ/mahPlOFZvLAtvW6AZ6Oc
         RB6VUNuM+6DAGbXUIY3yx3RmAB/IAE3ViR0+Un/jBzCldHPDkY6TBtho/NXIUl0CGyVT
         VPUFEQmmIo6GWgQHW9aKz3v51UjEiIGkgPKuPaUk/S+PZnaZhWZ5NGW0XuNMwQCX7+sk
         irxjlzikRjjwPxPdfj0g19rPgpG/Uvgc71QCh3YtdKcLK4K9/TwwSgl2YGSEXOYGy43J
         uGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764718030; x=1765322830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWFQCVhiQmz5Lpf2ZXwd0aP4zbVFu1vPcerzGzxuFaY=;
        b=s1zcOHjqcZPxte4YGHE3jn8VicPHCKzH1V36s9hiyrL/wykRncR3Bv27C1wJvPhyS4
         zoLU1ZuwdIy682m4f4nTuezLZEce1+EnBOtLbjnEv9khx3o3yBVOyHYXCUtSWqstuzkS
         etaFwhO+CgDryaTK6SZdweuDS8EVtTvrHUU5PSuarntMqqfkfz+smDKhT9EKh4Cwn55W
         g8truRscwYH0LByql+yrBpEqd422A7/XdDr8GuASOWqZRvDvQanxlm8fM/FUjgOWfJgM
         3A8AzH5UiNBangZiqACkuBSsC+CbTApaQrsyLdKx6NkFEEdxujW1xALA9vz4Ot7U1IWt
         2/3A==
X-Forwarded-Encrypted: i=1; AJvYcCXay36ZDJMQb3ljLkIM+2ZB38dKNyNs4/tewOf/H77oYRzqdIhX1XvWM1WtAx+RjiqMCYFnwrPdA6TUW5jPR8gG@vger.kernel.org
X-Gm-Message-State: AOJu0YwsPGB4X0Gv58E7dXi+twSgb98otspuKZ/9pAXZ2ytt/MhTeF6A
	MBJGIZOeOb0d1XDl0qIY6h27SaMYzNyDRXkioiArI5NKxl5Fx72weiiP+aI3rJquBZnRmj6iGYT
	UcEilAU2k+3WkZqEv2rl7k2ND9nXSjzrbUBnQTcpE
X-Gm-Gg: ASbGncuwk/WKoyRUXj8FSxIeHoHKVdM3fNij/AWzRdfktFEwPXmTUPwMW16s/96GDbD
	CzW7EASXTrzn6zncQf1Cw7sCacJZHjiPZIq6qxPP2BvGdicwHqi8YQH9qz5Q1wOh19R8zAX1rw/
	Nm2VUB9T2kjXSNdRnTOCC+mw9zn5Ngl/ePplVZ8Uvoyzfacm3cZxbaK8H4gkcs/nxJF351OWGOH
	Es7Wos1ycEQEoNkg85bw7AFvekCwlF/qDip6g2zFgU72kMyeWvQWLQaljxYiHwjnG4Dmb3gULLD
	vxzjoJkmYqph8W05/q5SyUTDocXLrYOhoGA=
X-Google-Smtp-Source: AGHT+IHe0kpscPJ6RcgkMYDw7q6QIf4y1tzNWl5guMVqXLIpiFLjoEObl96NDVohwfw8PY4bKuNgA7vlATyyj0orW+Y=
X-Received: by 2002:a17:903:182:b0:29a:75b:2774 with SMTP id
 d9443c01a7336-29d67f9a420mr372325ad.21.1764718030246; Tue, 02 Dec 2025
 15:27:10 -0800 (PST)
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
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 15:26:59 -0800
X-Gm-Features: AWmQ_blAQ8IfChaZIiu8WHHt4FW0r-GFBxzUtvxXAA_amrg3N_OqRRxCLzA3R3Y
Message-ID: <CAP-5=fVoGKnhcN5Rqx-EqsCC-UMx-eKNdFory7XaYpdG_4wu2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID generation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
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

Reviewed-by: Ian Rogers <irogers@google.com>

I think everyone is agreeing. Let's fix the python JIT issue with
what's here with SHA-1 and work upon truncated SHA-256 with
incremental hashing that's truncated to 20 bytes and without the
load_addr hack. We could also hash other ELF sections from the jitdump
output at the same time as it may be theoretically possible to have
matching object code and symbols but differing frame layouts. Thanks
Namhyung for working on the fix, Eric and Fangrui for the hashing
support and build ID insights!

Thanks,
Ian

> Thanks,
> Namhyung
>
