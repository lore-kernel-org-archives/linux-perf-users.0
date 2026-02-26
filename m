Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BC3D4103
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124305; cv=pass; b=YJYM/aaRW/aHocUhqhhLnyi9MXujq06U3FMRxOgkqrtA5c/61X6SqV5EBaefJEIPhg1KwpdFChirBfMxPsz70Y+k/ar1LtCQfroFmyPJZDhVEeVcKo3vqsOFC1iHYEsb9l51G7Pp7s90K+XpiWD+4UqQFbVTuUxqmoW6Lt7569I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124305; c=relaxed/simple;
	bh=udkhAo8CRupuCv0msl/Z3RH85ijHMm/A2AoMS5Wt1gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYFbosGU903FaIgDCcd0SgRpaxlQ+LccMSk67vDSb8EbTZvBxJYg71R5+rJ50Z6L5DgPHAF4brbM1/7SYA8qYg2pnF6zfJy88uaPHhElpP6GfRyPZO8Soc+Lia1I29ECd7CpD7pekCih95WpfNJf+ve/scFfQSTs8+wuk8r7mZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lid9CbSe; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lid9CbSe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ada9e4ea32so101805ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 08:45:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124304; cv=none;
        d=google.com; s=arc-20240605;
        b=Twz+/w9rM92h85e8RLvhPBoHvLa3OD027EDQKb7ZI3bnXfq0XXoWXvMx7P0yz2Iuf4
         6Wm6K3OZOU9YldQ2GuIjD8/iX2OU4SWGkq9ufHhFloiw6axiL6NfYkKJA8uOUkB1aTvP
         9VIn5+9aTX44dPFyqMx5D0WlCEibkULXLz2pqDlkalLXI+PZazmfm29NGx378fAwDjGe
         Ja+GVEdvezVr1lbGqO9Q8Aku8zKx5VCK955rpgefw9aGioBuxhLMKmQlKHuGlMhx5ShQ
         O7dYKxO7fRxcWAeZrVzwLVu9JPhT951c6VBhKmJV6ODOCGx7wKmgPwXe/XFTNwHZIg21
         BU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0VKoywbTOA4sWUXs9zGAAqsU0xPN4EhGa3jw9NuqR9w=;
        fh=if/OqwS9dH3XjTfQS6sczVJzlAR1063NxcsrZOYL6UU=;
        b=fcLzzvyVHkI1c9TCUjjHuZDEUDE355lDYGLukmZw0j948anXgcM+brKCmP6atqDl0v
         3EmaM7yHx6xaf2ninQmLvu89X+kUciYzjwsXe9h1cpZ/qxUkOSOYTfZ/hDnTm0jL0ijz
         kC0eMlkTpB0KsJ8XN8jZzq/i/u24cmUhwEp7nWtNrbBYZF0xkVns6AbvQKEbdjeinR9f
         9Fke1X9mfDhSfle+pv65g4qJvFlQGpWSnN46cSFHJXPftH9sbDqb9eBXpklZmS9oxraY
         FR/dy6SCpB6qMP7pWwr9kWbEuNRfDjfsV8muCyzYfkHzVyeBXOGt1qJbZy9eGxLf0RxP
         SzFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772124304; x=1772729104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VKoywbTOA4sWUXs9zGAAqsU0xPN4EhGa3jw9NuqR9w=;
        b=Lid9CbSejo3GHX8SXd13tScep27yGCunwsD3GHhC0VyUiSK/MlVSyqOq7yIQh8GnGU
         sd1HFJFyCtJ4izGlVt8ZJOF8NTeT6CKvY8q0BRjFvH+sYE0URGp9gRvr+degPiUYqap6
         6xE5UxemW2eIsxOS00HWqtTSnlDNY85RTe6avkKWhGo094+vEkZ2Ef+9Sm8RaBVJ19cT
         +eQ1cwXx9pHdNjJt8APAwxTzZL0mFGdd87t6PF92/o+GOYNka5AReX/pwudhBNjMj2W+
         nSo8JYyjwdo8y2S4UzOhnqViIWSL9VxlaofiY6e60tn4lOmXZMqWPHIitel6PKj1nPg0
         Htig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124304; x=1772729104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VKoywbTOA4sWUXs9zGAAqsU0xPN4EhGa3jw9NuqR9w=;
        b=hu2MvtTf0U9eGthLlVE/msraceaVcOqBGZGB5LS8OsW+blYcA2z3s7klgqh2saIoMy
         233dYFr5AwLKppSVccnr+S5rF8bODnB+0gCIjniRW3M8hq9q6yhEyBhOsHLhn0q4TBdI
         pmMwhl1Xfps9hMRz6oYA6WaQnlVmbMFU34cIoojU4mBUpwuKG97SmwN1/wRUoZwreGYo
         rtET9r63RMYZFpUMQN6XQy1sJYXT/GhT5VBN5G5b3w/4vtIJY+ZymmogdPGGcwWos3jw
         Ct9u6+mWeoJqoBOctZL3Kgng6AJJ5ItYX/HQr9xgya0dbjVoSfLE4ItmLsOWFj2hkUcJ
         kXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHocXuGrm6ysbHPvsid4QFJeidnWXUC7UpdVpfnXnWVSy7kGQkxq9wFwy3FGx78dwIGHhz50oaMlZY2cLEYCBz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SR2ohLn5pjk/NGCpeRUua7gqBuvsigvzLKR2g53bx5nPkPYh
	18ZqtJN8+huMr+rSv4PD5QJfmRorhdHCh5SVpOwgtzMoHVf1Q+tqjJmgAJR78p7lZnvURosFSSh
	sahVw/A9K6mqcp7sxrXlKe89ck3jwCvo6VxUQ7c/o
X-Gm-Gg: ATEYQzwF+QwWQHFE7ODoKLJA4WZeiW78mAd8eA3ilmXc5b5+ohOw+n32ieucW2RcT6W
	h1ey3sNh6gLzhqQ5RHGqOY3F5w103Ux/OGaB9ItbxlNd0oXAAJxhVO/RLF7FYW/zuJeL1c+67Sz
	wzDf2Pm6WW5zq+Ix1PoFaL1ZX3fUx40lZ2hpk6qLrIaSNE18XuiHUo/e0xtzsGo7Zxga6AB2a6G
	jLZhhqpM6rcjPa0FqTSWk69e7bKM0JoKReMv3X97UZfERkbHvF6MTlGdQSL8xlkU9A4QxgYDRxe
	rxKlfpQnep85HgeuhjI/BEfMAIlYEE8wmxz5
X-Received: by 2002:a17:902:e805:b0:2ad:6f9b:7818 with SMTP id
 d9443c01a7336-2adff727bb2mr2400435ad.23.1772124303022; Thu, 26 Feb 2026
 08:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>
 <aZ-oYb-FDLVT5MGq@google.com> <CAP-5=fVCdQZ584s_24wQc_+03xL2Npj2qDbqGSjE=Ms1-y8raQ@mail.gmail.com>
 <20260226095255.GF4184494@e132581.arm.com>
In-Reply-To: <20260226095255.GF4184494@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Feb 2026 08:44:51 -0800
X-Gm-Features: AaiRm53xXqyLEa4GYOz2WbGuVYACoA3pTI3nxwQFEyqukqzmfX0C6Fud7CNp6Zg
Message-ID: <CAP-5=fUAK=vzeZWDXuun+wptSeBwUMhZuVqdh4zwLoXoV32VPA@mail.gmail.com>
Subject: Re: [PATCH] perf kvm stat: Fix build error
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 1:52=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Feb 25, 2026 at 10:36:26PM -0800, Ian Rogers wrote:
>
> [...]
>
> > Hmm.. it looks like something has gone screwy with the include paths.
> > The header you've gotten is:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/arch/x86/include/uapi/asm/svm.h#n137
> > rather than:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/arch/x86/include/uapi/asm/svm.h#n137
> > where the value differs between -1ull and -1.
> >
> > In Leo's change he has the include path as:
> >   #include "../../arch/x86/include/uapi/asm/svm.h"
> >
> > but I think that is off by one and should be:
> >   #include "../../../arch/x86/include/uapi/asm/svm.h"
>
> Sorry I did not check the header path carefully.  A bit thoughts:
>
> The perf build will not include headers in relative paths as we
> expected.
>
> It tries to find headers with appending search paths.  As Ian said,
> I saw .kvm-stat-x86.o.cmd that includes kernel headers:
>
>   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm=
/svm.h \
>   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm=
/vmx.h \
>   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm=
/kvm.h \
>
> I'd suggest a fix in Makefile as below.  The idea is to give priority to
> the lower level folders under perf, so that headers in the deeper perf
> directories are searched first.  This avoids searching any kernel headers=
.

I'm not opposed to the change but I still think we should make the
relative include be to the correct files. Some other thoughts below.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a8dc72cfe48e..47359f672b6a 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -388,8 +388,10 @@ ifeq ($(DEBUG),0)
>    endif
>  endif
>
> -INC_FLAGS +=3D -I$(src-perf)/util/include

Not clear to me why we need a util/include on top of everything else.
It seems somewhat random what is in util/include rather than just in
util.

>  INC_FLAGS +=3D -I$(src-perf)/arch/$(SRCARCH)/include

Hopefully with the removal of the arch directory (and fixing of
cross-platform profiling) in slow chunks by changes like:
https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.com/
we can get rid of this one.

> +INC_FLAGS +=3D -I$(src-perf)/util/include
> +INC_FLAGS +=3D -I$(src-perf)/util
> +INC_FLAGS +=3D -I$(src-perf)

This:

>  INC_FLAGS +=3D -I$(srctree)/tools/include/
>  INC_FLAGS +=3D -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
>  INC_FLAGS +=3D -I$(srctree)/tools/include/uapi

to here means that we prefer linux headers over uapi headers, which I
think is the opposite of what a user-land process would expect. I
think we should move these headers into two libraries, build them with
an `install_headers` rule, and make the include path pick up the
headers from where they are installed. As the linux and uapi headers
are licensed differently, this would clarify the dependencies and
licensing implications.

There's another can of worms regarding whether libperf is something
useful, outside of declarations in event.h.

Thanks,
Ian

> @@ -403,9 +405,6 @@ INC_FLAGS +=3D -I$(obj-perf)/util
>  INC_FLAGS +=3D -I$(obj-perf)
>  endif
>
> -INC_FLAGS +=3D -I$(src-perf)/util
> -INC_FLAGS +=3D -I$(src-perf)
> -
>  CORE_CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_
>
> As a result, I can get the search paths in .kvm-stat-x86.o.cmd:
>
>   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/a=
sm/svm.h \
>   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/a=
sm/vmx.h \
>   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/a=
sm/kvm.h \
>
> Please let me know if this makes sense.
>
> Thanks,
> Leo
