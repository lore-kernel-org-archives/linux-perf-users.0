Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467352;
	b=sn/Q1Apr4/UhiJGNXkiJZgleOnMocFaVzBQm7ST3YXsFI9BWBRlyjTKG8z6sdNgWYTgY
	 N7KvUPQkkA3nOFml90qWvk5QtA7+gSqQzuqpcOCJy1dcuV0X5vqUrtywR18KGOd10oA2K
	 ZxKrjkGvoH8Ezslw4UKP+h4qGXUp3oLnt+x6ZdI1fqFADYqlPzKUTDj7Nhaqk+gOeeqjM
	 /jQIW6m5N6zCb0APKBf5UbdvweBFigrpSgvYJtrLDSbHCU4tFgAKvVHcYaakSWmMktl2L
	 oClVAmYJQbARlfqSBMmuSMlQlqsp7lJVZM5Syz1cRATotFoi8kBIJfSSKxwKZhh04gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jC8OcSeHRdd3RsVKGpoelDfISX3MVzmR9xKrD5ogJJM=;
	b=1i/wfa9oe4iIKRN8RQtXaNXR3+GnBNPVdFiBb8oHDY2KzqI1ydum6HRUnkn7lTsUcvEM
	 NtHeAq27Bugm0mTbynq95AqsMFVqg72WX35we5Q1ZqAmW4ipBRJdYZxzc6cPVTMGOowwe
	 ewfwmzhakp2aq6XiwwyMjIvX8mw2lSJbfG5nOdnp3b5mzeIsUO7Ydjk9wUg0Voztux5P0
	 NaA0xAbm0cM2JANwe16lDqJBO98WjhWM9cVwJG9jKjQk9KUvSGNHKhcwae8FA6DC82Dav
	 xkjQz5igz4udKLCwPo3/cHIJgzEszdo7U0zfmhiA3h4Pp3cj1kNlU8rB1+nIll99aMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VNOMowRp;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031E606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 17:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6031E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VNOMowRp
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so13310205e9.3
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793467351; x=1794072151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jC8OcSeHRdd3RsVKGpoelDfISX3MVzmR9xKrD5ogJJM=;
        b=VNOMowRpdd7dZ4omQg/uRfJZqCER0Y9T5v4SO3h5ffrxJCIVO9Ec60GLh8eXGczcir
         7WrSYNchSOHE2w6UMqQrL3feGtET38O4aluFLsz8vQoJHS6PC5R5R6jrgLT/6QILXfmm
         KRGiBrZWIOMOiTWP18jlPO1f4lA7hYSVPYylKQFmQ0NqkqBemk3uDA2AJ/sM60k4Wjpn
         XrGCx0OlrWsgXZv+hr7zsfQZhpd4UsCvPCXkg9GgIZ4b52ktl4BDQMKYX2d2LFs2aO+F
         rNpH6FYNjaJylqQJQz89SaWgjmp1BssY5jV3SsRa4ErDJlZfUvfFHu30FmSxFjRz1sX2
         yNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793467351; x=1794072151;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jC8OcSeHRdd3RsVKGpoelDfISX3MVzmR9xKrD5ogJJM=;
        b=Iph8QRAZEFsOSHMJBbDY5pWHNjIL7Dx/8DD4tdOc4HuFPGFUNFHcE1+CMTCt0id3lV
         xz4FpMFAE/SxKEm+duIjxy2wntxP+nxjVlbraTN8ClZTgrr8qD537+a56qP1isvop0sr
         dObZPwmVODQLG6OtdjyI9BgHbPZPci5R2rG1xhBOGqLrXMJ0+nxqZ3P1NU9AOlSgVLfe
         UPsr2GV/Y3SmseHwWiopsO+c4X0aQ5F3TLYnnOM6tmaKkH5YslOJB3l5CD0kmDiSRbhA
         5jD/Xoo9yRymiKTgnEok4mNmhzB8zLah1JNbXjT4URMcYnMyH4j8W3z7jRrTdTMUF9HV
         LBgA==
X-Forwarded-Encrypted: i=1; AKwUvBx7T1RpIw5vjy5e+ql6XdvgtddS6dYawrHJxY64iwJ3RbMCNk/FAsh2+uuYYLKVmIltcYAMyxN0t/YprqjymCSC@vger.kernel.org
X-Gm-Message-State: AFq9FYL2/6sShRAxw0rjBdGbWld+HOaXzE/uHNfHb8rDuDAxkGo1HuAL
	644lM0PNOOmoQoCze4jRUUSpgrnUYE/bDgTModE8jOlS+z5CLwJS69xt
X-Gm-Gg: AYBFou32sP5XvX7Aegc+Aj8R83NtM/gxy0Qfx963vESmtJAl7Yic4Z+zG2NVQaGFNJR
	c0rRC0D7ODCyjoxZ1Tksge5jcQwOr+TDBzLNbQQGE+lWxMEoMH2N6vbnIQ7jE6GcR4CwXw9IocJ
	TFKFf/Lrl+9WRV42mBC6IquXe6z+REXBAqtwWvnoCnfEM+YzIbGoDTz/ljHthlz5clkoD205Fd7
	xnB2nGOnfqruT4u0o0CulUTG/eDi6rKgo2PO0SgaeKOlze0+V454pKvJ3sdxCF18DYcwbOeZugG
	gGSdLKze8yEGEeG8pZj1J2oVuMX0tVObmiTSsyX/loyDuwJjXkoj36bq9UEQ/ZOHwrRM+xmmGb6
	zZOG6B8fZ64g41w8x4AZPqFeafTYsQwDhZ15qeekmX6s3VJMerLHenxV2h8udKEA18PpWsBU5Tc
	MnXReiMzb2Iq0Ujcx3fUHcQfRG2GCxUXjrlL3olyCuqUtagojUgwP/zlbUfOmYl0BZu5VEdGB+w
	HZyppxhspa1i25uyswWnIkVLXErCJhby+q2u2rCgBVtj1C9KJcOevzqbK2O2JC4tdmAwelMtsU2
	yM379eEhrVtrf4c3U+H9vUEokl4p9xSzfnQWCg9F42fFFSSMt10aQR5bhwwBAbnV9YaLhcOVa4P
	lOL3WQ9rYUtk=
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id 5b1f17b1804b1-4ac17753befmr127595645e9.15.1793467350501;
        Sat, 31 Oct 2026 10:22:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1114sm153311235e9.7.2026.10.31.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:22:30 -0700 (PDT)
Date: Sat, 31 Oct 2026 17:22:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Alireza Haghdoost <haghdoost@uber.com>, acme@kernel.org,
 namhyung@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
 jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v2 00/18] perf symbol: Reference counting, sorted
 arrays, and memory shrinking
Message-ID: <20261031172229.0d178d73@pumpkin>
In-Reply-To: <CAP-5=fUJy=fZg3t0z7L=uKVVRjg8OQtCL3KxFR8Mrv-yVCtuzA@mail.gmail.com>
References: <20260928075237.3055101-1-irogers@google.com>
	<20261027231513.816148-1-irogers@google.com>
	<CAP-5=fUpji7seZpsxh0BN05oAA6nMUyM-bNdHBg4YfkeNAT00A@mail.gmail.com>
	<CA+w=M=TEYScc9rDyzthN75Ym41ATXoNLNu8_yj0dsjymb+m7jA@mail.gmail.com>
	<CAP-5=fX211V8=NCWyr9btd7=hbBB=oiMDETxCDdVr49idP13Fw@mail.gmail.com>
	<CAP-5=fUJy=fZg3t0z7L=uKVVRjg8OQtCL3KxFR8Mrv-yVCtuzA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Oct 2026 10:57:27 -0700
Ian Rogers <irogers@google.com> wrote:

> To: Alireza Haghdoost <haghdoost@uber.com>
> Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,   jame=
s.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,   linux=
-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
> Subject: Re: [PATCH v2 00/18] perf symbol: Reference counting, sorted arr=
ays,  and memory shrinking
> Date: Fri, 30 Oct 2026 10:57:27 -0700
>=20
> On Fri, Oct 30, 2026 at 9:10=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Fri, Oct 30, 2026 at 7:02=E2=80=AFAM Alireza Haghdoost <haghdoost@ub=
er.com> wrote: =20
> > >
> > > Hi Ian,
> > >
> > > I applied v2 on perf-tools-next e74880764bf9 with the ELF_C_READ_MMAP
> > > fix and your three fixes, and compared it with the same tree without
> > > the 18 patches. I posted comments are on the individual patches; this=
 is the
> > > summary.
> > >
> > > On a profile of a large C++ service, about 1M symbols, perf script an=
d perf r
> > > eport output is byte-identical and roughly 22-32% faster:
> > >
> > > Execution time and peak RSS before and after:
> > > perf script                                3.3s 334 MiB vs 2.25s 332 =
MiB
> > > perf report --sort dso,sym       3.0s 389 MiB vs 2.25s 386 MiB
> > > perf report --children -g caller 4.6s 706 MiB vs 3.60s 703 MiB
> > >
> > > Peak RSS barely moves. sizeof(struct symbol) goes from 48 to 32 bytes,
> > > but the address array adds a pointer per symbol back, so the net is
> > > about 8 bytes per symbol before malloc rounding. That is under 1%
> > > here. =20
> >
> > Thanks for your work and running the numbers! I think we should aim to
> > land your lazy loading patches ahead of these patches. The merge
> > conflicts don't look like they'll be too terrible, wdyt?
> >
> > Since the merge window for Linux v7.4 is currently open, I don't see
> > anything landing before November 1st. So I can do a v3 incorporating
> > your suggestions and rebase it on top of your patches when they land.
> > I'll work on pulling out the fixes (you highlighted some you thought
> > were particularly worthwhile) to mail for v7.4 for now. =20
>=20
> Chatting with Namhyung he mentions having the arrays in the DSOs be a
> `struct symbol[]` rather than a `struct symbol *[]`, because the
> number of symbols could be known for a DSO when we load the symbols.
> Currently this isn't possible because of things like the
> annotated_symbol that this series turns into a side table. I'm not
> sure it is possible in general to use an array of symbols, as JIT code
> may need the symbols array to be realloc-ed and the realloc would
> potentially invalidate any `symbol *` that had been given out. Maybe
> we can treat that as a special case. In this scenario, the symbol's
> lifetime would tie to the DSO's lifetime, allowing us to use the DSO
> reference count instead of needing one per symbol. It would still be
> nice to add functions like session__malloc so that we can reduce the
> memory footprint of a session when memory allocations fail. I still
> think this is work to land on top of your series.

Could you have two tables, one 'struct symbol []' containing the fixed
symbols and a second smaller 'struct symbol *[]' containing any extra
symbols?
Lookup would require checking both tables - but won't cost much more.

David

>=20
> Thanks,
> Ian
