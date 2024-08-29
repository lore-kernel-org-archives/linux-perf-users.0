Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7E43ADE
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944949; cv=none; b=Blle4jzFelFJH8t8djLvmjV4z7MviMW5AKugDCB5bd8BrjDm26FiJcatxP1CfpLb7XWtYu34vJctjHcAs9aovzy4d5mgxBygJ+VKoXD6HtsZZrDxlSUtlyvCvBO27bWNgS84vP+rjDbvze+ofG/hEle7b2Dq9oygRz9kAJH1GKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944949; c=relaxed/simple;
	bh=HH8sx/TA6/pNWRYrB7RmJsO+f0w+WEsEntCiDvFlNzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HZ9IQ/d9KXjlVmKRtzdlS2OS3nPeMvieSFItY18ACe+wL5HST3Ayy6e2B8wkcsvJYkg0UDxU/IVssZhpfkIpvxVog/p2wgsW1ByMvJmif+ejNJdd2YagYlETkH0ZQpmJ4z2IeuAOYNv0mk+E+PSSqhZtbGGw06GQRFbg3MCrm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZ9LGX82; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZ9LGX82"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d2a107aebso223315ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724944947; x=1725549747; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF94Ev7NiAfJ9Qw+ZlzToo/oy/beE+xR2EiOAmtXCrs=;
        b=iZ9LGX820fsprPBbMFLWDcYHZtkG1hWEWPLFY68F0eBqql1SKjhq5Xys8Ic7mxikvP
         dJywc7pet0cYi7WdUm0BohAurLSylRrbHbBzLXRU4JwENWQPKQB6qzXL1d+Z46x/zaXV
         t2QWuMnQu3wP6shzY2m2v/NM1WT7f+6rcskSmSG4EnYsOinCkQusWi9ZS0YcTgm2621S
         XMu2ZOdYS7mAtC3A8QY7OA4nWoyyrAbI/qG+Or8kjZVeurdJohyezMdA+M5O3LEjP5Oj
         YqtxPZcTWXy5EJI7BM+CPAxnBMNL4T7Ran4L3ryV7xHUAUG2zjsT3HVwVQgooqHRkgrH
         /+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944947; x=1725549747;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF94Ev7NiAfJ9Qw+ZlzToo/oy/beE+xR2EiOAmtXCrs=;
        b=hGKhjemoXxa2JwluucrNDip0L5QMR1ezP+oyJ1RThqsd9w+NEmNVVbP+YRTdimKtGz
         b0ZdaH1wTGhy0WJ4R6wE9iApzDsJN0Mf5GeFCvzB1gUEDYkjLQ3F2y/ngx3tfhOcACxF
         j2bEclNGoenly2qWAmlcaVzCuRMZNShO/qEqWJNdjiZnLs4uo8+XL1z7+XOISJv0YzJ7
         XYZKtoSYCWHfvEhkfaPpuj/HgVt6CXNLie+yoDqARAvNe7XTQNiyEaI0Nrun3TsLy5uY
         lEzeNLruesy5bbXSU9ExSmF14LohIv5ZdtSdkzA0Iu0nbsk8Zb3CkUbVlAeKnDOLpUbZ
         Zonw==
X-Forwarded-Encrypted: i=1; AJvYcCXtb58KZQjfzfeIwKhf8mZ4MEMVO+iD+p9ata6vZYD17nm2zdDZTrDQ6JYuymjOcXLyZO2pJEXnLmh9mq7FfZ1r@vger.kernel.org
X-Gm-Message-State: AOJu0YyCB4CsChSUzwCVogDh4FgvxLnLnLMfouIsM7B/YzX9BeCRkhuQ
	VbLiYuHj6C/nG1gJny4VxljutDj2/KWUneQ0QuUTa4RW4EnSmmn/W8LLp8GnEbYnlYGdrYar1iB
	+cvkg9fpMW4gXqJNitHvUXbrcuduEkDS+nDWy
X-Google-Smtp-Source: AGHT+IFsYbwNQoOhWmsOIVkY35FQpepRbEGGPO/U9rnNfujEMT0bYZlSfGELKY5IxkJ9tuxnGW2oqbLhVITYPPkzg1I=
X-Received: by 2002:a05:6e02:216f:b0:39d:24db:d515 with SMTP id
 e9e14a558f8ab-39f38508fcdmr3789115ab.4.1724944947063; Thu, 29 Aug 2024
 08:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Aug 2024 08:22:15 -0700
Message-ID: <CAP-5=fXfvoFANe-tZX_2jG88Gz5VzqXo5St7k9QXL463t4Nfxg@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Correct inject's handling of pipe files on disk
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:02=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Perf inject tried to repipe the header, but this isn't possible if the
> input is a pipe and the output a file, as the attributes are events in
> pipe mode. Add an ability to write the attributes after the data so
> writing the header doesn't need a possibly too large or small region
> reserved for the attributes. Add testing for the case of a pipe mode
> file on disk, add checks that the perf file's header isn't obviously
> corrupt by having the header, data or attribute sections overlap. Add
> more comments.
>
> Ian Rogers (8):
>   perf report: Name events in stats for pipe mode
>   perf session: Document struct and constify auxtrace
>   perf header: Add kerneldoc to perf_file_header
>   perf header: Fail read if header sections overlap
>   perf header: Allow attributes to be written after data
>   perf inject: Overhaul handling of pipe files
>   perf header: Remove repipe option
>   perf test: Additional pipe tests with pipe output written to a file

Sorry, patch 1 was a resend of a patch merged yesterday. Please ignore.

Thanks,
Ian

>  tools/perf/builtin-inject.c         |  60 +++++------
>  tools/perf/builtin-report.c         |   1 +
>  tools/perf/tests/shell/pipe_test.sh |  26 +++++
>  tools/perf/util/header.c            | 151 +++++++++++++++++-----------
>  tools/perf/util/header.h            |  21 +++-
>  tools/perf/util/session.c           |  12 +--
>  tools/perf/util/session.h           |  52 +++++++++-
>  7 files changed, 223 insertions(+), 100 deletions(-)
>
> --
> 2.46.0.295.g3b9ea8a38a-goog
>
