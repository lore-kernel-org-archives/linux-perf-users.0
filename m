Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916611850A4
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243523; cv=pass; b=BqUvRdNkkOzZ3SfxnQVMZxEpOOJjJDyzP9Vm4kHjfCgeQEropiS7SOExBzSp03wCZzD0CG+Drfrk9r/F8pBzsWxAZYoyNNJKF4csyaU8cemkY5Ly5phIjqPXP594b5Di/XeevKAyKpMM/d6j+UbGdKtX783RuIg6Ckw/EjahHZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243523; c=relaxed/simple;
	bh=1T9KpP9m9AuiepqAZ1xGpaUjyfznTSx5f5gIO/N9GtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgbT3zjv09Q4s4HRKRSCW1TAmgXHpIPEUp6QX+VUTO3wXw2A+UJRqXeDp2df5iDAQiRxqky0/uf6sJ1enSS8ABoBzxghS3s9fLSS67KzMkkc7CTI2+jlbX9b4ZJSedOuq+NDYqb0GtQ02xlO88RgtVUPHUH4F29legFL4Unt4us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bqvicb1i; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bqvicb1i"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a76b39587aso11745ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 14:18:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770243523; cv=none;
        d=google.com; s=arc-20240605;
        b=DERPTanN1eKDHSPgG37hB0Chga96yl+5zl4JVU+3/h3gYbQffIzyy9djQeXnDXlRUs
         3qd4Dxuxevu1zQiv2bMekTy1e9sviTXJEZX8Wi18fV7eLAJC2I232EyTdwp9lg+z5uUl
         ittWkBPJ3DrUC4JRurj76dRGJA9zxVwCq0vq7sSvn0bXLt5fYfLrG/OCCOT22J8uJTDn
         HHBEw3V2V7/FNrjOyTsD0wKrseIdhPD1CraPs0XPbn8tLILstYGGDKqClEV2h68XHtNo
         2RpEplFErGrvOuRlK1mieQj6OFvJM8iUG/g/aIbWXAzO8KsBdoIo2dApoqWjozFhNqxP
         bQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNCDZk5U/12FJnrVlSi0kuMYIeri/SGe4vYZ5zlsY5U=;
        fh=GhDBilCT9dW/wm3g708iLyJhektMRrl96VAWlWLL+Co=;
        b=XqTSmM+IsmE03N91fVETFY3Mbs6x3WZ9A+4Pfe0rQYdA2eoKE6scVu3QX2fCaR7uBv
         UR4VaykUMkHYOEU7kFwM8MTlU5MJ/y2NjT4ZxHwK0Iz8TqUKgTRG1zIZjanf8hkUoEBp
         LN6Decsa+ObaLmdSHfdVRndefVvgFBTi6xPsWeVGH4ieI9dK/sBNVofsIiAO1ygXMPcV
         Vy2r+5loeXZIEcjpfZdF6sMAZwc6Y1z7jqtxa5rJE7Xc3eHuoMa7dxqdbqGRnycTgpMV
         RjL34XP48ZK1NescHyP7K+OHqNUtUk8pW9o6MmyXSzT6n8BuuctbNvixVv0LDSJ1umev
         ZCTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770243523; x=1770848323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNCDZk5U/12FJnrVlSi0kuMYIeri/SGe4vYZ5zlsY5U=;
        b=Bqvicb1ijuMdsZAHs0969buTOSTqnqYZ7Hi7PZG+8QgokOViNhgJouYz//3N8eG1N1
         gRCCIwJzjwMIoSZUin2cNetsPrwIE64LIeingndA9JDlDZG5LRXqIrhFzsn/JaUsjSPn
         FiI0gs6wwmYvdc38/UjmkoxmAG5g7oyIe1s4viRtrD4euIDcZ+6ky708BuiFw4185+fV
         rJgAcqI2HhCBxBBmzbPOf7XbIaZKmtRvxiAIByRUHHAgQZNhnh8jzWo4C4KnqjsNiw6w
         Z2J8cQlfpoc1Fod+XQLTEuA6ECH+9UVmEpu9TfIYzQ3QKIUXED7ODBJexmuRIaBMds1f
         SUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770243523; x=1770848323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNCDZk5U/12FJnrVlSi0kuMYIeri/SGe4vYZ5zlsY5U=;
        b=dNtSXMjKVBJZeNS1Hlrac+1wjacndm2QJlfg8G3cCiRketTnVQlkuy6Q47dAs6oGrt
         jzqrq6jQrMAT/MS3ExY8egP+QAXBNBwd2mb3llYFyR1peBoTgsFZHoxdAxFJtbl2kusY
         I4cvA0eh1r6WcMHhxiHcBcKpGHvCq16uuVC7dYqODdx2QkkXswnqq6R+HVhTjY/24a8e
         VU0x2eXYxqxOO+GmsLt4jaxysd5rrha5p5+6YjYHEWvbgqDEFLxrF1hl4ZbvgLoJjAiA
         M/FWsyNxJ/b3l5iBv9hN/yhLGTR5Fk3qc+EHMxHbX24spmgFM539hLLP5pU8KK3sFHcW
         NmxA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3vNSD9111z7H2zQ9yxdKqaAwe2v3Y5wsn3IHSnfT7wCNMZJYXRPdw1u6CK4IGHwT/Lu1CDSsD14Ytty3xlSe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08Bnb/ucRluDCmS98AkzYHt+QP9HQMk0YC/EMR/5man9ERm85
	f37YNRZP8f6NvokDMMdfWP0QLp6q2VnxQDxz+EpH4MwDErmFhtuEpEefmw+zgUs2kUIZia4eL8M
	4yZqkVdpxghL5iy0vMOltvwfnY0nL0k69Z1Mkz87XPwgR0nBlrK6HWqtHIag=
X-Gm-Gg: AZuq6aJDZJEEoGLkE+EbCZRstd5JEJ3mNgw4PM7S04k8d75Oaaf71aKuVGHBu/dDs9I
	B0fcNNwMSYyPFJyrJHGk4V6TZ0wTk2KkGNzg3eXih8uxisOWrDHinR/hUqiFQ8bDOVbWkVWCosY
	RQWtlP69GaWNkhn/w35OyhMfnAeA80TgY6KyaL8Cjb/Kx5zRj1puA8DM3Ueo8dMYWnpDjLTbaYl
	kIhMa45Y0DcnjNOaZ25mg9+kO+EU/YyHFyhayVf8x4oOeYF9UCw+cMFtB+lBLUdnAOXamlzjybQ
	FBUdDcj0sYm2u1iTru5VzY4=
X-Received: by 2002:a17:902:c950:b0:295:1351:f63e with SMTP id
 d9443c01a7336-2a941941139mr894225ad.10.1770243522628; Wed, 04 Feb 2026
 14:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127083030.5909-1-9erthalion6@gmail.com> <aXjvF3N5ZGJlZzFi@x1>
 <2frzr2cebxes2qoxofwqshfkb5k3d7jeq72srqnt4ywrlpkz5r@7pzb7cpbm4yw>
 <7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o>
 <aYIKHjxCGFbReY7Y@x1> <CAP-5=fU-aJYKAcbFeFYcgMfpvt8oY4BTxEgczP_rvUAiJt+U-Q@mail.gmail.com>
 <aYO_k4G-iF3CUY02@google.com>
In-Reply-To: <aYO_k4G-iF3CUY02@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Feb 2026 14:18:30 -0800
X-Gm-Features: AZwV_QizE8lUHaSSdDRsTTE2MqNRrLb8R3kR9BJ0he3BYGlfm_WWZ5detsN3Dyk
Message-ID: <CAP-5=fUGNDzVPt60J3zwXjwD9gMADRozHwFP+U3gFsPk4SHi0A@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf tests: Test annotate with data type profiling
 and rust
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Dmitry Dolgov <9erthalion6@gmail.com>, 
	linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 1:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Feb 03, 2026 at 10:15:30AM -0800, Ian Rogers wrote:
> > On Tue, Feb 3, 2026 at 6:45=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > On Sun, Feb 01, 2026 at 11:33:54AM +0100, Dmitry Dolgov wrote:
> > > > > On Fri, Jan 30, 2026 at 09:44:47AM +0100, Dmitry Dolgov wrote:
> > > > > > I'm not managing to reproduce your results, can you please elab=
orate
> > > > > > some more?
> > > > >
> > > > > That's most unexpected for me, the test output I see looks like t=
his:
> > > > >
> > > > >          : 54     for _ in 1..count {
> > > > >     0.00 :   5423b8: mov    %ecx,0x7c(%rsp)
> > > > >     0.00 :   5423bc: mov    %eax,0x80(%rsp)
> > > > >     0.00 :   5423c3: lea    0x7c(%rsp),%rdi
> > > > >    12.28 :   5423c8: call   541f00 <core::iter::range::<impl core=
::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
> > > > >     0.00 :   5423cd: mov    %eax,0x20(%rsp)
> > > > >    10.21 :   5423d1: jmp    5423d3 <test_rs+0xb3>
> > > > >     0.00 :   5423d3: mov    0x20(%rsp),%eax
> > > > >     0.00 :   5423d7: mov    %eax,%eax
> > > > >     0.00 :   5423d9: test   $0x1,%rax
> > > > >     0.29 :   5423df: je     5423f6 <test_rs+0xd6>
> > > > >          : 65     b.data1 +=3D 1;
> > > > >    13.69 :   5423e1: mov    0x48(%rsp),%rax     # data-type: stru=
ct Buf +0x18 (data1)
> > > > >     0.00 :   5423e6: add    $0x1,%rax
> > > > >     0.00 :   5423ea: mov    %rax,0x18(%rsp)     # data-type: u64 =
+0
> > > > >     0.00 :   5423ef: setb   %al
> > > > >    11.17 :   5423f2: jb     54243a <test_rs+0x11a>
> > > > >     0.00 :   5423f4: jmp    542426 <test_rs+0x106>
> > > > >     0.00 :   5423f6: lea    0x30(%rsp),%rdi
> > > > >          : 73     }
> > > > >
> > > > > Where '# data-type: struct Buf' is as far as I understand a manif=
estation of
> > > > > data type profiling succeeding. But my environment has slightly d=
ifferent
> > > > > version of rust -- I need to figure out what's going on here, tha=
nks.
> > > >
> > > > I've being testing this in the same way, but without any rust code =
--
> > > > just on a simple datasym workload. Surprisingly, it seems that
> > > > 'data-type: buf' marks are disappearing even in this case starting =
from:
> > > >
> > > > c31040085914f1188720073baa43d1483693c0a3 (perf dwarf-regs: Clean up=
 x86
> > > > dwarf_regnum code)
> > >
> > > > I'm not sure yet why this is happening, but don't see anything in t=
he
> > > > commit mentioning that -- since there are no code-with-type tests y=
et,
> > > > maybe an unexpected side effect?
> > >
> > > Ian, can you please take a look at this?
> >
> > That particular commit is largely adding an i386 to dwarf register
> > number mapping table but it also expands the x86-64 mapping table:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/commit/?h=3Dperf-tools-next&id=3Dc31040085914f1188720073baa43d1483693=
c0a3
> > The code to search the table is largely unchanged so my guess would be
> > that the new x86-64 entries are causing a dwarf register to be
> > returned in cases where previously this was -ENOENT. This may have
> > broken the type profiling, but Namhyung would be the expert on that.
>
> Any chance it can get an invalid e_machine?  I'm not sure if it handles
> EM_HOST properly.

EM_HOST should just be EM_X86_64:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n27
or it will be EM_NONE and everything pretty broken.

It was possible previously for a non-dso to report a broken e_machine
but that was fixed in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/util/dso.c?h=3Dperf-tools-next&id=3D7d0ebeb6c0f735d4edd=
c679283a1de1dea2ae878

Thanks,
Ian

> Thanks,
> Namhyung
>
