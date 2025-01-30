Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464E1F0E47
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266680; cv=none; b=OJz/yjWwNSzvSBt5/wloYZ/7yuiUqY58KDBExST45u0xPHscT8A+lTjJ8LbY0wf6Zr0PxOVB1g6Ugy/L8C1rL+I0shTe6zZXNmZeEfhuz41bdajVVTgzVQ9WxVsFtia6J56LQQ16s5UJnmiV8Kis/SWxV6SxPck/mSFmyqa0D/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266680; c=relaxed/simple;
	bh=PZWNQzuUvdb2tvBIx8Zf9ULMprA+8Gln+UkXCCSy7qo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uA7euGgT5DigFepD20s3m3MZ8HVAPFzRtW2j7j7ULrlCan36ABNOuQk6JcH3YcPnrtPqK0hUWMGwHF3XbehNM1zrnlHzDFRvmbEGsYgDMxRyxpKtUAZZ1Aob+cJyQ2b7hmiFPkQeTKUUWGgV+cKWTnHr9aTlO54SyBj84bIWJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzzYfMiJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzzYfMiJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2178115051dso26853735ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 11:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738266678; x=1738871478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMsKcJUtai6CYSlXHhkH0yde/9mWjJ8zpnj2lgaYAJg=;
        b=tzzYfMiJc/MHQvL4riReOBMpnhzqRRJTlUFHaCJMRD8wD6wfTslPx4EfkDt2baIwEv
         VfX2oSPD6vHRN0a9N75S5WjjBvjguPuzMBdMBP7+e2voyuPTVNtLNHX2jXdvqZenIumc
         7YF+6u8f7lgJkgYHQwwFYnYcyNAQJI53MMdjpaUP8ZvAde6Rct3DFktpTx/r4u3O90e1
         Sguyv14hx/jRukn+rVOizOhWSDnL7nBrA3xGvCm1KJjVkRcjv66faltt6K4W/IGcdqtc
         dfx/G+j5rr+RO+H2nHYtofaskML7t78szhF396sYL14VqaD9LaRc163h/uAPorpEU195
         ykcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738266678; x=1738871478;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QMsKcJUtai6CYSlXHhkH0yde/9mWjJ8zpnj2lgaYAJg=;
        b=GyjP/M4iR0HgCmUOJLqEu5dXHGib0mPJET4iTQl7JRbEQJSrA8o93kdux8/rQyiveb
         KKTLcVzeUDz1B4gndNWQTh/UTkd6x5WLQKEQlubid17sl62s7iv9NgnFgniQe2GOIKEN
         CBmkmp2BgZDVntssa9yy8Cl3aWJtXr1MbO7P9vDo9KzxZJEEHVFY8qheEMOyoW1HlQhc
         /CsU2t+x8VA/Ruz6B9SXt/ya62A9wrHeMb6z6M/uzlNmVX3yX4KDnziI0FZnLVG4z6hy
         dE7l5jtHmm+7Ay3JDZUpBAmf5VD3AtHjXrd+5Tn/Jv1e+VXF7dzLRT49dSDcE6VeRcmH
         rB0w==
X-Forwarded-Encrypted: i=1; AJvYcCXhSQv9BJcdejPlL/Ch03AMkq9Txg7SUqDvofLB+8C5QpcgDWcI+QmkNljBnRVaWRUuKdda61m1B3++Lrcpv68D@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaBgJkNkhW4d3ygcB6W3rkqwrQdC9+kjQpWc8Sxb/39mqXDsB
	uaQI6XXJLX4sAE8cOWB9lBgjFTxpEKinqairGy/glea305WbNPB+Cnaadpsv59dJdbeUibAO3Q=
	=
X-Google-Smtp-Source: AGHT+IGfOIsvmccXkgCUUIFyQDMN+VuLslZZrxRjAneC2/LkBQ7Gqo9u8bUVeMagNQQ9k+vc4Y/Z9o1i5Q==
X-Received: from plbkw4.prod.google.com ([2002:a17:902:f904:b0:216:499e:dadb])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec92:b0:21d:cd0c:a1b8
 with SMTP id d9443c01a7336-21dd7c3cf57mr141286495ad.1.1738266678124; Thu, 30
 Jan 2025 11:51:18 -0800 (PST)
Date: Thu, 30 Jan 2025 19:51:15 +0000
In-Reply-To: <20250124214107.ycccp4gapbdudzux@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250124214107.ycccp4gapbdudzux@jpoimboe>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130195116.3930772-1-wnliu@google.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
From: Weinan Liu <wnliu@google.com>
To: jpoimboe@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com, 
	broonie@kernel.org, fweimer@redhat.com, indu.bhagat@oracle.com, 
	irogers@google.com, jolsa@kernel.org, jordalgo@meta.com, jremus@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-toolchains@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	luto@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, sam@gentoo.org, wnliu@google.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 1:41=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
> On Fri, Jan 24, 2025 at 10:02:46AM -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 21, 2025 at 6:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> > > +static __always_inline int __find_fre(struct sframe_section *sec,
> > > +                                     struct sframe_fde *fde, unsigne=
d long ip,
> > > +                                     struct unwind_user_frame *frame=
)
> > > +{
> > > +       unsigned char fde_type =3D SFRAME_FUNC_FDE_TYPE(fde->info);
> > > +       struct sframe_fre *fre, *prev_fre =3D NULL;
> > > +       struct sframe_fre fres[2];
> >=20
> > you only need prev_fre->ip_off, so why all this `which` and `fres[2]`
> > business if all you need is prev_fre_off and a bool whether you have
> > prev_fre at all?
>=20
> So this cleverness probably needs a comment.  prev_fre is actually
> needed after the loop:
>=20
> > > +       if (!prev_fre)
> > > +               return -EINVAL;
> > > +       fre =3D prev_fre;
>=20
> In the body of the loop, prev_fre is a tentative match, unless the next
> fre also matches, in which case that one becomes the new tentative
> match.
>=20
> I'll add a comment.  Also it'll probably be less confusing if I rename
> "prev_fre" to "fre", and "fre" to "next_fre".
>=20

Nit: swap() might be a simplify way to alternate pointers between two
fre_addr[] entries.

For example,

static __always_inline int __find_fre(struct sframe_section *sec,
				      struct sframe_fde *fde, unsigned long ip,
				      struct unwind_user_frame *frame)
{
	/* intialize fres[] with invalid value */
	struct sframe_fre fres[2] =3D {0};
	struct sframe_fre *fre =3D &fres[1], *prev_fre =3D fres;

	for (i =3D 0; i < fde->fres_num; i++) {
		swap(fre, next_fre);
		ret =3D __read_fre(sec, fde, fre_addr, fre);
...

		if (fre->ip_off > ip_off)
			break;
	}

	if (fre->size =3D=3D 0)
		return -EINVAL;
...

}

