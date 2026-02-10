Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B03271FD
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724646; cv=none; b=U2fez3LER32xnb6c4ZcZqL3K2Y5RMEMGWiGR5b11KmeaxSlyD9U41ajlMN1sXtXx9yxUzPukkej3skJDZCOTe9ZxQ205Hu+fR1+/cA3OANFilITJoKIGy1p0r1qT6V21D2gSwfFJQ4/pRHcVxjpDrlxgkQXNJkf6upgs6R4MJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724646; c=relaxed/simple;
	bh=yZfejn5ZRZJkYXy/flKLrzDr82uJ4IsMcIACX41P7co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvh1cKZzA39PTuML/7+F9RyPtTDtPxW8Ao6Z4ccewGrlNdEows45WIEr7hkxmP766OGYl2X8F3OVesbzjKa8L3i7JjGAJffswKULo/gbgeRMjzEcHJqSXw1C7s+veu2BvGKH1kV9pERNtoWl3Rb88uG2OlX0ZDfDliGEKLJ4x5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo6HR3eQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo6HR3eQ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so7226975a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 03:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770724643; x=1771329443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9crJ0mI0JIHaMx5hzdSW3ynRTyZhd6BiU8BYorAKFLM=;
        b=Oo6HR3eQWBBK55d1QK2IJ7U8og7VPKdEQWX8tT5O5pxQEFkLIdryPJojVTwdgV7xbZ
         s+eYYiIi4vfHMW/zbZnFcY3VyRJVdjfdvaW7we0HRi5/VJcazYhZgaAZmzE2vV30yJQN
         OSJ0+df+e/+CMzsGCu/J3wZ8x5pjxv/UgQZ6ClUC7+3gOpqlaOUN9oLDM1C4RcPT51qe
         pQAI7mq5nLoPRkvffvV40CCzRqZGpsPUP0WfgOp2RewtculwXHdsYXXKnyBJuAP2BFZf
         5pCFSk4WmT9ClJy2YC2Ipxx7fFR2NskP1DieB0FXFq4tjG4GOf3jyO6hqH4fRiP4weq9
         bG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724643; x=1771329443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9crJ0mI0JIHaMx5hzdSW3ynRTyZhd6BiU8BYorAKFLM=;
        b=CCWTFSR7kN3cCS7FpaLDa9zOrFsVhj40W5aQQhPxYCwZe5EGlmkCXj0d5h3ru5UZle
         qd6CwdDrk1FdJ66ltVCdqLe1+kUpCtref0YlXXXGzkkp2KYh2tjkn8Otz6IX+6W5jY0i
         CNO9Uwx3EZeD5QeU9iDOXI3Gkj8hDN+h/LOmKpUnV6jvgBIIkuvJ2hoa9RDXJmN1LnLg
         dh9ManAWIw4BKoL6WAkj5i99/EANB/HiPi9tJtuipom0lXjqftOZm/UoVMAHCSQBorb0
         Ew7KZxSJ6AGLcljkhI1MuavlzYjhOjg4qij8swg5mwriUD+qS4Ser5tX+dcL0q/TSfmL
         JJug==
X-Gm-Message-State: AOJu0YzSh3HXyYPbyvWt3Ct50wq1DTZVbriVjQ+iUghGgk7HTbsQl4T2
	HbwKs9VXO59oDEBw8q3ldOr/kYljkWQ6kvPFmfenqEqEyzXU0nZbdlAA
X-Gm-Gg: AZuq6aIgxfVEQhDsUUXiVU6Js8blTFdk6wiIRgGlKv7x11kVGoOQhKNHJpZ8bkHmUx9
	svc3Q3GKZEsbwkszqBTf1yqG4BZCnnzi5ruyi4psIoZkzyg73IQzDuz4t70POh7ePnQeeVRDDAQ
	N1WlirY5NeH3uaL+qgjhWcoGuMNZVqX7rSa2Dh1tBjf1FN7I6GsK6ttYtAQqaQMqAZyI8s25Q2Z
	TYhu8RQixk6fkv8184WRpNegWpiM5YoammRm8djdBfxJUAjH1G6j76iurAMu7ChmOjX5SuR3kTZ
	Fx+PXkLsw8n5GaGsWjvIfYty3GOZUW8b8LA58EmZJWOWBViTlisDyaCrS5OzAYqMgJyr6Ir8tGz
	KSf5QRqnoaYl4C3wKcUKFAFGUVkj/usuZUltuhnXW12XBTtFNuG9iatvUEpENvCZgRwuBcpFfv2
	M3h18z5u6Z829SKJDtaiW0zRW94GZFh5R8xSFN3/KZ+G93+1gnVv/58lI/te2cJHGwqQjZ/Smg2
	u4MWbERROaIUNWvxrub6WHCiT/S8XWU6HYm
X-Received: by 2002:a17:907:3d06:b0:b87:12d2:fa1a with SMTP id a640c23a62f3a-b8edf173ca0mr1019450966b.12.1770724642573;
        Tue, 10 Feb 2026 03:57:22 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacf003bsm516373766b.47.2026.02.10.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:57:22 -0800 (PST)
Date: Tue, 10 Feb 2026 12:57:20 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH v2 4/4] perf tests: Test annotate with data type
 profiling and C
Message-ID: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
 <20260208122227.3524-5-9erthalion6@gmail.com>
 <CAP-5=fXzUOhVku6=R1d=kq6JAo-ow18VQ+qt819_VHL4drkBsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXzUOhVku6=R1d=kq6JAo-ow18VQ+qt819_VHL4drkBsw@mail.gmail.com>

> On Mon, Feb 09, 2026 at 09:39:09PM -0800, Ian Rogers wrote:
> >  # The logic below follows the same line as the annotate test, but looks for a
> >  # data type profiling manifestation
> > -testtype="# data-type: struct Buf"
> > +
> > +# Values in testtypes and testprogs should match
> > +testtypes=("# data-type: struct Buf" "# data-type: struct _buf")
> 
> So in the datasym workload the struct _buf is a typedef and the value
> declared to be of the type of the typedef:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/workloads/datasym.c?h=perf-tools-next#n14
> ```
> typedef struct _buf {
> char data1;
> char reserved[55];
> char data2;
> } buf __attribute__((aligned(64)));
> 
> /* volatile to try to avoid the compiler seeing reserved as unused. */
> static volatile buf workload_datasym_buf1 = {
> /* to have this in the data section */
> .reserved[0] = 1,
> };
> ```
> This test is failing for me as I see "data-type: buf" rather than
> "data-type: struct _buf" (ie the typedef rather than the struct):
> ```
>     0.00 :   201290:        movzbl  0xbb5869(%rip), %eax  # 0xdb6b00
> <workload_datasym_buf1>               # data-type: buf +0 (data1)
>     0.00 :   201297:        addl    $0x1, %eax
>    47.66 :   20129a:        movb    %al, 0xbb5860(%rip)  # 0xdb6b00
> <workload_datasym_buf1>                # data-type: buf +0 (data1)
>     0.00 :   2012a0:        movzbl  0xbb5859(%rip), %eax  # 0xdb6b00
> <workload_datasym_buf1>               # data-type: buf +0 (data1)
>     0.00 :   2012a7:        cmpb    $0x7b, %al
>     0.00 :   2012a9:        jne     0x2012bb <datasym+0x9c>
>     0.00 :   2012ab:        movzbl  0xbb584e(%rip), %eax  # 0xdb6b00
> <workload_datasym_buf1>               # data-type: buf +0 (data1)
>     0.00 :   2012b2:        addl    $0x1, %eax
>     0.25 :   2012b5:        movb    %al, 0xbb5845(%rip)  # 0xdb6b00
> <workload_datasym_buf1>                # data-type: buf +0 (data1)
>     0.00 :   2012bb:        movzbl  0xbb583e(%rip), %eax  # 0xdb6b00
> <workload_datasym_buf1>               # data-type: buf +0 (data1)
>     0.00 :   2012c2:        movzbl  0xbb586f(%rip), %edx  # 0xdb6b38
> <workload_datasym_buf1+0x38>                  # data-type: buf +0x38
> (data2)
>     0.00 :   2012c9:        addl    %edx, %eax
>    52.10 :   2012cb:        movb    %al, 0xbb5867(%rip)  # 0xdb6b38
> <workload_datasym_buf1+0x38>                   # data-type: buf +0x38
> (data2)
>     0.00 :   2012d1:        movl    0xbc7861(%rip), %eax  # 0xdc8b38
> <done>             # data-type: sig_atomic_t +0
> ```
> It seems the typedef is a more accurate type name, so I think the test
> is wrong here.

That's interesting, I don't see "data-type: buf" for this particular test, but
I've noticed that "perf annotate" reports different data types (buf vs _buf) in
certain cases. E.g. if as in the test, the data is collected via

    perf mem record

then I get "data-type: struct _buf". But if we do

    perf record

then I get "data-type: buf". Interestingly enough, all the addresses looks the
same, except the final type_die in the end:

	# perf record
	find data type for 0xa00e69(PC) at datasym+0x71
	CU for tests/workloads/datasym.c (die:0x1ddfcf)
	found by addr=0xf7e000 type_offset=0
	 type='buf' size=0x39 (die:0x1de132)
	final result:  type='buf' size=0x39 (die:0x1de132)

	# perf mem record
	find data type for 0xa00e69(PC) at datasym+0x71
	CU for tests/workloads/datasym.c (die:0x1ddfcf)
	found by addr=0xf7e000 type_offset=0
	 type='struct _buf' size=0x39 (die:0x1de0ed)
	final result:  type='struct _buf' size=0x39 (die:0x1de0ed)

Not sure what to make of it, still trying to figure out where it's coming from.
