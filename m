Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4D255F28
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533010; cv=none; b=sImFoA2IgaNkhDl7TSxavAtyyAEvmik8dL3riB7wOJsT95On+U++z6aZNNyJonzmpTox3iD4vMuRs41e64PFRBAhvPHgyW1RnPaNydTuN5Z7noKEOBrE/QKKGD7yL+GaXJkUqyEW8+UdsD5nqyHVSC9H2fnJ+rrHVCRbcoQXqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533010; c=relaxed/simple;
	bh=C5r0WHOtFObLFpKCMhNyDDNdrXKyoewOu/87RMDqYBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfPtEkJQjRr1Kftm6Jp5PA4oBQz13KN7EHLAniLw10GwSvkPvsJGhuzAnTd2ZRemQr7fKZsYyy8Hdcs2+UyLRZ5cFzVsdP42H+AvDDrPbf8CTM/+NMVlC7iPN1nYCN9BYj3R43p0Vbpzr2n9QKvrbqhn1Fy8wiXwcn/uqlbqig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjnHGDAz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjnHGDAz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-242d1e947feso387515ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755533009; x=1756137809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy6Ekik4wtxdU/sGrdmJ5Z/mbLCDvKAO6pGEYg8MRYc=;
        b=QjnHGDAzl+nxno+dqXnshxozgbcrgdgg3zUKEeC8r//WaltXZRe3ZwwbjGTdr3wCft
         GJ9MXT1LkSZhoC3aVHd01s76cvrwcUYCYiI4C9jXqnVeuaROGA+PXPrZ6BgxPPrX8dzO
         QYON+QwkBZyYaY5eamMzQMvM9nWjE4L2OjmSlCLLBzZPHMYeGlcbNkOXimwuo+TvdDAn
         z0ZuQjDAq9c8yjJDZBQmsL8lud7Q35pb8vzvbtPj/goEzDgQOw6Td88axLsKTmJwBSsy
         IWEqGt076VZNF5p4rBFs5SGKXxf6ywgUWBUBJFeeCCTovXTRu+v3J02zdYWL4u/oLief
         8EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533009; x=1756137809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy6Ekik4wtxdU/sGrdmJ5Z/mbLCDvKAO6pGEYg8MRYc=;
        b=LCxD4XYtAC01EhvEWZUxHTm/emYNRAmm2aH4Eq8bmCs58w5HJRMRRIu0giuazoNMBi
         hjMWnxv2oSXhSw/tdmVWvEbMbwHEWVN2hEbzcds78FU0QYMLt9ogcj7hpI9PitxTviV8
         O8Yb5CW2MxgwVJr2URGsRP5grcrx9HYhyIY8JnSId3cmye4W/l93YPLKapeGn8WKIKI8
         NVYq8EaOFOt/k6/Odj9tmEoHOC/s9OdpLmUU1AMGG3WfKarGRBP41pQJc4SdUPP3AWpg
         y6qHoQVZdTV1oEbj9UeXw1eb6b/Mnrpweuk4ai/BWsLNoeNkCrcZIR0hsfCXgirk7vVz
         YCig==
X-Forwarded-Encrypted: i=1; AJvYcCU1GiGsBjjgKmrFDmVaXc5HiXzCCIHp/rM2ghNJ01dKKBT1htICa1XUvER6yqTjVrEuwBVfjjh2wca8+zIKZl9K@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmKJd2Z7Kv00z+XyNdmALJShNZPR4eitfXpWmZfvKwFSN/EEc
	qKRJoOcqINfUk8EEJhe+g3dyB0+3yobLEr47PXgV+VVUSIHe166rzmdo4ALdX751xSj2rwWt36/
	vkUQ14yjgofIXSlhVEwhYfuVdUd1mc6BqnlQBg/Ae
X-Gm-Gg: ASbGncsK0rOSe/M7ZL+71BOCDaL/gu+WjxfITQFscw4FK2E/FzZKCfNJPqtZhNC9VkZ
	VpsrkBmu4GSxFVWcWLy+IXlmEq47Ro/Zk11U3NMVNcYuutA/sKf9ga3M/1zI5mBVF9XUCvtGEZK
	rbLXObQxJy0qGaE3dUQlE0ke2tswWI0fkFfmtMEWM9CcVDLbYA1Y7e4ZXHvhvWTLDQtC9yGaqTJ
	Y7ErmNo/QxUVUv6vIWYQpeXI3tXrMvXNOCID0STIX068RI=
X-Google-Smtp-Source: AGHT+IFveFdgcbnAa0xdAeel5El0U/UpEV28fWYRdt1wjZXR/9I3EHWlOUiuyZoLjhTOw+/kwb0Rj4OlzWrWcdRxPtw=
X-Received: by 2002:a17:903:2302:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-24478e4ace3mr6846525ad.8.1755533007752; Mon, 18 Aug 2025
 09:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626054826.433453-2-irogers@google.com> <202507050736.b4hX0Xks-lkp@intel.com>
 <87o6tcrzh2.ffs@tglx> <CAP-5=fWbmo3ejmeWbweSk5waPtS2VTc1obtaWiibZC3cVmvVvg@mail.gmail.com>
 <CAP-5=fWeK4RnL8=BQm3o3u0KoONYEptwEYFBC5_DkJTbgpbx9g@mail.gmail.com>
In-Reply-To: <CAP-5=fWeK4RnL8=BQm3o3u0KoONYEptwEYFBC5_DkJTbgpbx9g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 09:03:16 -0700
X-Gm-Features: Ac12FXzxrkQN2qF-Ga-gtgg0Fff-w28PrY7z1q2GVj_JWSudKFY9dllqpgV61kk
Message-ID: <CAP-5=fW=tWLwLoozZfVHQ7QgKS3ACf0_LxztGcs5mhpAO23sww@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <lkp@intel.com>, Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:00=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Jul 22, 2025 at 9:44=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, Jul 22, 2025 at 8:56=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> > >
> > > Ian!
> > >
> > > On Sat, Jul 05 2025 at 08:05, kernel test robot wrote:
> > > > kernel test robot noticed the following build warnings:
> > > >
> > > > [auto build test WARNING on linus/master]
> > > > [also build test WARNING on tip/timers/vdso v6.16-rc4 next-20250704=
]
> > > > [cannot apply to acme/perf/core]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a n=
ote.
> > > > And when submitting patch, we suggest to use '--base' as documented=
 in
> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > >
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/v=
dso-Switch-get-put-unaligned-from-packed-struct-to-memcpy/20250626-135005
> > > > base:   linus/master
> > > > patch link:    https://lore.kernel.org/r/20250626054826.433453-2-ir=
ogers%40google.com
> > > > patch subject: [PATCH v3 1/3] vdso: Switch get/put unaligned from p=
acked struct to memcpy
> > > > config: s390-randconfig-002-20250705 (https://download.01.org/0day-=
ci/archive/20250705/202507050736.b4hX0Xks-lkp@intel.com/config)
> > > > compiler: clang version 21.0.0git (https://github.com/llvm/llvm-pro=
ject 61529d9e36fa86782a2458e6bdeedf7f376ef4b5)
> > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci=
/archive/20250705/202507050736.b4hX0Xks-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202507050736.b4hX0X=
ks-lkp@intel.com/
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > >    In file included from arch/s390/boot/decompressor.c:48:
> > > >    In file included from arch/s390/include/uapi/../../../../lib/dec=
ompress_unlz4.c:10:
> > > >    In file included from arch/s390/include/uapi/../../../../lib/lz4=
/lz4_decompress.c:36:
> > > >>> arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h:109:9: warni=
ng: default initialization of an object of type 'typeof (*((const U16 *)ptr=
))' (aka 'const unsigned short') leaves the object uninitialized [-Wdefault=
-const-init-var-unsafe]
> > > >      109 |         return get_unaligned((const U16 *)ptr);
> > > >          |                ^
> > >
> > > Any update on this one?

Hi Thomas,

I sent out a v4 patch set:
https://lore.kernel.org/lkml/20250722215754.672330-1-irogers@google.com/
which has no bot complaints but also no reviews. It side stepped some
of the challenges by always operating on pointer types. If people
could PTAL it would be appreciated as then we can pick up the changes
in tools and drop:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/Makefile.config?h=3Dperf-tools-next&id=3D55a18d2f3ff79c=
9082225f44e0abbaea6286bf99

Thanks,
Ian
