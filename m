Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552B55E40
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879210; cv=none; b=RMysEMLkHhnxE+J/z80RWvG2bZNCnrToM+/o0XZh41kei+9aKJ42VyuuNFg6MRJ+aAD0BEmFtGfBjSqJDCg/TiMtvhC6sS43zMhDj4b8D1EJwssUEyB0e8vVJepK4eVWwvtUzAM5Z65xeF3BWWG4l5Mbf+s//xXC63JyCEdsHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879210; c=relaxed/simple;
	bh=+sQCudOZfuqXiUUoG5vR5ACJJLNxAMax7xwD1W4e41A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWRFHku7HI1dtjk78pPi/lH+4WCnZH9almGsiufVUZ1Tut+YpuajxwnSZ+YIL5OZ9p4TtwWDiBHubvytnL7Jk09CXUTWn3VL/fI2zGHJyskyApiO1EAWamTWLB/HczPf4aSze4pK37jKyNtZmU+QFa8W23p5AL24NRkgMD9Ar7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lar24pDF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lar24pDF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1deddb82b43so45995ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710879208; x=1711484008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TmjIUAWre/OnPAbZKoo/CqmH4il78nzu/N6uFzuSi8=;
        b=lar24pDFUtX0vMzb51TSzwEnwoyRetN5jsA51ZK+b/N1rz662USWBlivjRosZbUgVu
         VuvOm2WMWPJktHRQI0tmukLK7fj6iW5Cn01nfso20ZqHRt5HJHykOyU680fvDrY3upXz
         Ehhw2tyJOaDF6zLunagaC4gD2vjE+PtWF19b2B4GKeidnrh5OYceD/tYIVdc3jceA3zx
         EoS9/z47ERCRLxCGKGSwEjZmoD8l0sUXDjMGS26CAQR0x20ZE6mCmJ8/zU3eVAlKIpd3
         xa18f/j3Y0FeeLx2JzNNkzSAkxbnHczZ1P/HWr91ZwCiO/6z+aaXVCeODoPFk8dM8gH2
         9nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710879208; x=1711484008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TmjIUAWre/OnPAbZKoo/CqmH4il78nzu/N6uFzuSi8=;
        b=bULmGHsNglmCHJyAiUDhD3lyig3Bz98UZJHqGmYVB0UauXfZcCPKKVS/rRtDITeYWo
         SeaxbQRtC61OskA9/c228OI+InRLvo6hKJQ2CW0aM7pZh/JYClDJuzHLmm6djoyqjL5H
         2hwVswXgGOs82N4ZGrnjBlryDaKTXQBy6MHR1m46yIpWsRIvNnYcDRl9+SvsuDlonK9Q
         PKsW8+gX/qMEXLAoV3VG82DZ4V7EoiMkuhMijg9qu23AP7BxBV7LOvswvGQnUbKBiNAM
         PmzE4qpWqOWtZHZhRWIFF1ihgV5GF0bbKVwVt1a0BGvqIL9o8/9zW5dFGS7VY2jOWNth
         8tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbiBIGNpjk4my0ihhh46b3upDrgp6pIb+lGH3vnGnsISXVDTQ6iP9ljLjZloH7rDdTzofXRQmZzQINA7NcTP90y5Sr/3mitqVZfg9fp7iB7w==
X-Gm-Message-State: AOJu0YxPWe6fnLbHc36mee/ix+EYBH0pE93jwpMNWaK58p3Z9JB1GbxZ
	pTpEXiGhXY00AOYIr0guUIBNH7B5H1zlLA3ka8K1Bem4reJrOXF15nnFFroiFOzjUIvwpVikWAL
	uSxowc4WOlujKWB3ACqhL3KppxWZxJ4E91Hxk
X-Google-Smtp-Source: AGHT+IEw7XqscOujrExd+TjwtySjz62M3/jll6P8bD2QCyweYla8m9DhRt5lU7Qo9n5jCXQMEtTIf22XYc74lAhBJZ8=
X-Received: by 2002:a17:902:ea11:b0:1de:ed50:41f8 with SMTP id
 s17-20020a170902ea1100b001deed5041f8mr65676plg.22.1710879207491; Tue, 19 Mar
 2024 13:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-3-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-3-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 13:13:16 -0700
Message-ID: <CAP-5=fXvQoOOpCTm1FXqatzv-wCTYxAymjAu5Veb2fBZE6KivQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] bcache: Fix typo
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:00=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Replace 'utiility' with 'utility'.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  drivers/md/bcache/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
> index ae380bc3992e..410d8cb49e50 100644
> --- a/drivers/md/bcache/util.c
> +++ b/drivers/md/bcache/util.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * random utiility code, for bcache but in theory not specific to bcache
> + * random utility code, for bcache but in theory not specific to bcache
>   *
>   * Copyright 2010, 2011 Kent Overstreet <kent.overstreet@gmail.com>
>   * Copyright 2012 Google, Inc.
> --
> 2.34.1
>
