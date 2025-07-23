Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3231F1909;
	Wed, 23 Jul 2025 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308848; cv=none; b=EX7x88qPNZER2Xyn2YNVhD75hUZIxcU+fQtdjmlBQ2WvWQFOwje99qRLgppKHu8/bULkF5tiZFZeIZYA5Svs4THedUD7bhbBGLhZ8/Vmkhd/04xblkRqOiTbKEONNsAEeS0pEQAKgtAtXiLKX5uBSxOHLhgtOMXFgUR0pQ0Cadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308848; c=relaxed/simple;
	bh=1n2X3dSDnt+iiB9SB7H1HStj19tGyqnSrPupfMGdvpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ct8hKbaAG6t0uW+sTa9IaObbblRyN8SgxWo299DL3xpYBMG1JA4pa0PtWKEBQv1rRosGQxnPTVeKLcdz6CPPbG8l/olhWrB9SY+AWWGuNZEPRTzpOvyALiiefTRyokZMyGgbAQ6iL5a1wUqIi8rhg2OFp003oZ9/7dKsvzyXX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFqt3/4m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFqt3/4m"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d6ade159so1818685e9.1;
        Wed, 23 Jul 2025 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753308845; x=1753913645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dcxr9WChsXfgQ3Y6J1Tmdhs3S3jUnpYIY2ntdf391WI=;
        b=bFqt3/4mU32+NzzFuMr6aQVhJVb7bdzVPZFmFxQo6JxoLprYBciWt8kzJs4nDTd5lh
         /VgUvdbIGu0GDerYHo5l4Qdd5VvFMVmvjlmFXkmfkLmRTsVYYghhqW6mb/HTHRIGai6q
         myqDsoutpISDXuTHKycFbFj/5yWHOqXQ+U6GlJPAkcK8dTXSaCsIZJKoIJ/MXukT/f5U
         kZlptdFh+GoO1qdaQrXg7t3zoma5FqFjco/1WJuwr2VRWC9u2uuuhtYorbaXxAek59hM
         tXl9laUCouF65Bsuwo/0RaXHQUOmreozQY1/ErIsZ3QhC6sjDrU0JgH6XZEyZOt/c10B
         1d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753308845; x=1753913645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dcxr9WChsXfgQ3Y6J1Tmdhs3S3jUnpYIY2ntdf391WI=;
        b=UfS401Za6mnf4HIRuNx6a97cAyDLtBbUwb1T5PEMFZPgU/SMEIBW1Xtev4L8xWEqA2
         PI6xqtaJ+F6FmdqsHnJNUNgnjJzq5fMqyBDhl/aj/RU45lTYDIbWx4Ft+AX+rAw6C4Fy
         WRvaLlvJv438Uv/W2euzBJgGL+uf1L/N6NvIi+IbrnjloTGxxTnrL28X3hX+Cqd/aVna
         i+GxY80nFC7CHQdNEsutimyU4wTRAg7lVMQuiZNEWhUMs77dx1dBCGGmq62g0Q52c80u
         rrcZFmFwKlYbfhb8s/fEv3JtINarCMxXD1PAY7N6IlVk1JQvSPPPC3q7vqyEog3HOdGh
         NVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Nz6MsmvS6rbGZkE5XE83fjuvJiHru2Ygfww0NsyPH8UsBTM2jD+HA5NUxmXspdoVnFntsX0OySP5a2kHuJ8M0w==@vger.kernel.org, AJvYcCXIU744CuSzvHyXGz7BRJ2LitNekZamsoQWL8UVYC72WMCELONcNNdpHXPb4GQ+//cfyhtiePyuhhvmxDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgrZW/2ITsQFk24HeO9CcRBml97nSxhG0sA0hwEvqSXn6Un00
	N/00IB/1llxwGm3pI2TsK8stDPElnu7Jxh7NUeLeFSy90cqmWwI3gU6k
X-Gm-Gg: ASbGncuXqhoWGfoJUubm7eiKhp9pj6ddv9BF/DJCpxPAvcvg9Bu+93M33/pXu27lCP/
	K9DJWocQXSsDyy/YlME0DcJX14TojzTr8DQM5oHaRVCIQf+fbzATXbhljOtbq6u+trLwxpsghME
	sY5FVl15+Jkn2U/N8xxw/FzgZnSXc+Ecw+9jSOt+8hlac5r682piHY/yAPXghAig0W4jWiBEjyT
	hF73EjXp0+HYwUwll1rO4zb8bssGHqwdPhSGb7eWcnqd7iy7WfXk27z8+5VVpQZlIiDWnF6dJ6b
	LGuEhDaBVAVHCqfgBFURtjA1Jma8Bh/DoYF0MbXCPXfqhvef2Cilc0Y5VemyKRpry5nVJL6e9kp
	raUPCj7XyxNI8hC1pbWOJvO4/Fq0v19OYH5V9CmSNvnE+hiix0PTGj8/C0ob5
X-Google-Smtp-Source: AGHT+IEHu4yEUwkN54fD2xw9nPvwgj8fXax3ltxH3jc2G3S4Abiw8N8eyK0gVyU28RXmmWI5cYhJwA==
X-Received: by 2002:a05:600c:3b1a:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45868c8d67amr44059195e9.9.1753308845293;
        Wed, 23 Jul 2025 15:14:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f433c0asm1824735e9.30.2025.07.23.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:14:05 -0700 (PDT)
Date: Wed, 23 Jul 2025 23:14:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>,
 Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, Andy
 Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed
 struct to memcpy
Message-ID: <20250723231403.6ef5c162@pumpkin>
In-Reply-To: <CAP-5=fWeK4RnL8=BQm3o3u0KoONYEptwEYFBC5_DkJTbgpbx9g@mail.gmail.com>
References: <20250626054826.433453-2-irogers@google.com>
	<202507050736.b4hX0Xks-lkp@intel.com>
	<87o6tcrzh2.ffs@tglx>
	<CAP-5=fWbmo3ejmeWbweSk5waPtS2VTc1obtaWiibZC3cVmvVvg@mail.gmail.com>
	<CAP-5=fWeK4RnL8=BQm3o3u0KoONYEptwEYFBC5_DkJTbgpbx9g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 10:00:51 -0700
Ian Rogers <irogers@google.com> wrote:

...
> Oh, the actual warning is "leaves the object uninitialized". It is
> possible to silence this by changing:
> 
>   const U16 __get_unaligned_ctrl_type __always_unused;
> 
> to something like:
> 
>   const U16 __get_unaligned_ctrl_type __always_unused = 0;
> 
> You then get complained at that the code is using 0 instead of NULL
> when instead of U16 the type of the __get_unaligned_t is a pointer.
> Basically I've entered into an analysis tool wac-a-mole and I don't
> have a combination to make them all happy.

Can you embed the variable inside a struct and then initialise with {} ?

Does this code actually work all the time?
There have always been 'problems' because gcc remembers the alignment
of pointers through (void *) casts.
So if your misaligned pointer has a type that should be aligned
them memcpy(&dest, (void *)misaligned_int_ptr, 4) will still do an
aligned read.

You also really need the compiler to optimise the memcpy into two
memory reads, some shifts, masks and ors, and a single write to a
register.
I'm not at all sure that is going to happen.
(Especially since I've never seen it optimised to only two reads
even when reading 'packed' variables.

	David

> 
> Thanks,
> Ian
> 

