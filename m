Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8615698D;
	Wed, 19 Jun 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821190; cv=none; b=kSNUaxXiVjikwiRUbsbIV9X1HghBFnt7FF8YMNwokWj7JJk5qIflc28T+DHkLbPKzJevvumUQvbTWs5uiDgnVD6u57d89H9Ckq8viO3FJnFbbvoK5fUv4qeDn0tME5m05UZn+Fq8nK743L8ug9SMcjI484ZP4EuSWDCrOMeYDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821190; c=relaxed/simple;
	bh=RMsTNCBqZwxDP7hdRlojuriaNhJGqTfA3YNcQUHC/CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNsHKU6Lx1faxfmG5uUUA4boZYGkgkBinl2lcqnFtwNWtDDfi+gxIVQUnowNPfMKmVF0zELpS1Qupmcr6RRsg9EfUj36SYS5CwNJMmB4DZrAuVBUSFTq1I60s0JcuAzhuxmbmrEaThR77LG4uz4RpBQnAomu8trxEcAwDD3DE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so55330a12.1;
        Wed, 19 Jun 2024 11:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718821188; x=1719425988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqdyyGhBufgRtRZ7+rM0rZt76nGjgHPleo4iuoTw0mY=;
        b=AWOY4FYTikvHegsJbEflw+0L1bLnqXA/Dp0C/LxO3Gn9rK2bg4pm/+GZYUIjOsuuoP
         DfIC9ruveniXKKA4ki1HM/c3NOng9dq7s/SeceoyZDizSTgppql8bjx6wPm23ImVSGUZ
         ZfJLRvKlLXqt0MrJYk+H92Rx1h69rgN9LT+8Di/mn38xTEhEVukoJEfk5mCJ6EiCl/Ka
         ZJOKOoDyake1qSISMqNAOmllpTn08B8nd268DlhwQvWT5XSZeZjOxmEL5ND5PrOPhmwX
         YB5SzBcrz3B62qg62Mf0rRYbu/pWHnifPb22pE2J0d1tu7Cfraxu/LVkVCeUNRFisxEw
         rxSg==
X-Forwarded-Encrypted: i=1; AJvYcCVVVCnt9RL4Ac2Gx7b+/JloC1tkukXwFRpMHFXT3F6I+MiLz98uYvJuLU7PG/4xI3yMEPUSdEBIivJ3AAkozEsSm6FthiyReF6cbhX1e62ParMEWCPeX36G/Pq6dTZC8N+SP9QqF6/yo6gTKlJ4xw==
X-Gm-Message-State: AOJu0Yw5U8alCiTzfUaTW/2oBQ0x6I4R1r4uttaEL0qN4Xa662BDBQ2C
	6kwFR3/4lPdaP9dRxp3N6pNOl/xcgqz75RbTxH6skE2Pzh9ae/pHuz5lQl5f2OcwqZituPqnlFU
	Cn85tL6hb3DHYqIdwDYw3NLYJMX4=
X-Google-Smtp-Source: AGHT+IHLhpxyx+1bvSddBuy5hkbDj14/14VxVzP3tCB2fiDY3vipYm/OFB45EFiTa4Fndt/PsnlUWQHMULf5d/2RH7o=
X-Received: by 2002:a17:90a:4944:b0:2c7:c703:ef1e with SMTP id
 98e67ed59e1d1-2c7c703f253mr1897811a91.4.1718821188237; Wed, 19 Jun 2024
 11:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com> <ZnLjT_m90EDtRFE0@x1>
In-Reply-To: <ZnLjT_m90EDtRFE0@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 19 Jun 2024 14:19:37 -0400
Message-ID: <CAM9d7ci+TEXG49=-7oLfFpTakUMHikxGFc-=NhEPPG0sf-UC9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf trace: Augment enum arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 19, 2024 at 9:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jun 19, 2024 at 04:20:37PM +0800, Howard Chu wrote:
> > changes in v2:
> > - Move inline landlock_add_rule c code to tests/workloads
> > - Rename 'enum_aug_prereq' to 'check_vmlinux'
>
> Usually the versions descriptions comes at the end, after your signature
> line, just before the list of csets in the series.
>
> > Augment enum arguments in perf trace, including syscall arguments and
> > non-syscall tracepoint arguments. The augmentation is implemented using
> > BTF.
> >
> > This patch series also includes a bug fix by Arnaldo Carvalho de Melo
> > <acme@redhat.com>, which makes more syscalls to be traceable by perf tr=
ace.
> >
> > Test is included.
>
> Thanks, the patch submission is now very good, at some point you'll be
> able to point to a git tree from where to do a pull, then have it with a
> signed tag, etc, all this is not necessary at this point in our
> collaboration, but as you evolve as a kernel developer, it eventually
> will be asked from you.
>
> And it comes with a test that introduces a 'perf test -w' workload,
> super great!
>
> - Arnaldo
>
> > Howard Chu (5):
> >   perf trace: Fix iteration of syscall ids in syscalltbl->entries
> >   perf trace: Augment enum syscall arguments with BTF
> >   perf trace: Augment enum tracepoint arguments with BTF
> >   perf trace: Filter enum arguments with enum names
> >   perf trace: Add test for enum augmentation

Please make sure that your change doesn't break the build
in case libbpf is not available.  For example, a build without
libelf seems to be broken.

  $ make NO_LIBELF=3D1

Thanks,
Namhyung
