Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C015748B;
	Wed, 19 Jun 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822246; cv=none; b=rAK1Dp5jrJytBKwRoDRNUGKdHyY+kJtObQEWucO7n47Ych7MAjo7Z0qJkXxCT1mZzyXSXJXJjyX/8cIU3uDVJXaGuXAAAzFzhoSAJhxdBOUbRvKa2+hoSzZnNZZtqIw1EVzEpPQDTxFVKELqRL7GO1xsbqM+wet07zzzAf/OlDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822246; c=relaxed/simple;
	bh=QhUYoWBf63AsJ/OW0Yna5f3rQ3Zd7nBKGpP/7eph1Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXh7VkfPgPsoZsqafwvbcHOxHvqJuT8jNl10qPgEtctHkIOG45zuAym8jUzwMnzW4wIA3Ft51z9xYWETfUItbKSaWk8iPmtiKikeWEvbz70sjKdeLnwn2b13DNGghtry9dZJo8qf/bhWtU+pWRl79Enge+GFWF7/hQKEPHstyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-705cffc5bcfso148739b3a.3;
        Wed, 19 Jun 2024 11:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822245; x=1719427045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW/h20d34xs/p3I5YUoc4XTJZsGBJiaZGRgH62s/GAA=;
        b=XAgoHWa+3z4MwYM63kS3ABkgH0Lijgbwues+rrCdK/Gm1t7mYH0CcmbH6K1coJVeZR
         3k1hJLL4GSDM4uPxQq6Mq9l5Ow9YINTie2tjuTdeuSCJllX5lkM66y0K2aD34GJQlugj
         1SxXNjOcYj8BzkrE1H2MCCay0L856SFujpqgvk9rYPY6kMIj/qA/AuxOXYCaiWKc8gJM
         zDozNrXw77BqqPWGYUC7eBAG1KKZYtn7adsQSMLZki3ZTLIEgJQdQApmI2tATHLiztoP
         V7FrHw6+IkhV7ObUGt29/Vn9phMZ2y1Wi5gk+fHcKwlwAIfao8iVm23/UaWDyVTmerOE
         nleA==
X-Forwarded-Encrypted: i=1; AJvYcCX9cLDrAtr6mW/zlNJWzewUdKWhWBEjeXvkIcOfJKfc1elUqbozyvQphBSZ61HkeoojbjXEn9OE4MjwbbOggfl724zqEXpioz+i0jLaRE1Wf4gW8HIuIzNTfMBXieb6JxUDZRZX+8AfnA1RRc43nQ==
X-Gm-Message-State: AOJu0YzsPL9VXbDuv3lHJhq4Ix2Wr6hFujtjq/SoZmhvIxJd1itcrbFV
	vCUXz8TTAnbUOWt4Hx2mocnLqriTp4MWJdhW34lmojLf8FOCbRF+vc2IEZ4qZKeHm5+iuvV4bqD
	v3NnKZuvjPBOCHjU7g4Pqa/iLBoY=
X-Google-Smtp-Source: AGHT+IFB3pt44wbgHuiQLRJ0LsGXwaW2pjJyI/BCA7wLetbqAMxPqLHjp99ZCqaHNXJgJDfpJPmOp/bP+X6Dn3p4zK4=
X-Received: by 2002:a05:6a20:4694:b0:1b8:5ac6:4bd8 with SMTP id
 adf61e73a8af0-1bcbb56afadmr3063880637.28.1718822244550; Wed, 19 Jun 2024
 11:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406180932.84be448c-oliver.sang@intel.com>
In-Reply-To: <202406180932.84be448c-oliver.sang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 19 Jun 2024 14:37:13 -0400
Message-ID: <CAM9d7cjzuJCGXLe_5Jzmcu2iiRtb07WwATnrz01sR7g++b6Frg@mail.gmail.com>
Subject: Re: [linus:master] [perf dsos] 7a9418cf7f: util/dsos.c:184:8: runtime
 error: null pointer passed as argument 2, which is declared to never be null
To: kernel test robot <oliver.sang@intel.com>
Cc: Ian Rogers <irogers@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Gainey <ben.gainey@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Chengen Du <chengen.du@canonical.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Dima Kogan <dima@secretsauce.net>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Leo Yan <leo.yan@linux.dev>, Li Dong <lidong@vivo.com>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Paran Lee <p4ranlee@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yanteng Si <siyanteng@loongson.cn>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 17, 2024 at 9:45=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "util/dsos.c:184:8: runtime error: null pointer=
 passed as argument 2, which is declared to never be null" on:
>
> commit: 7a9418cf7f05a74cbc9d4c750ee1bfddaa11f121 ("perf dsos: Switch hand=
 crafted code to bsearch()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master      a3e18a540541325a8c8848171f71e0d45ad30b2=
c]
> [test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d=
0]
>
>
>
> the issue can be reproduced by below commands:
>
> $ sudo make WERROR=3D0 ARCH=3D DEBUG=3D1 EXTRA_CFLAGS=3D'-fno-omit-frame-=
pointer -fsanitize=3Dundefined -fsanitize=3Daddress'
> $ sudo ./perf record  -e 'cpu/branch-instructions/' -- sleep 1
> util/dsos.c:184:8: runtime error: null pointer passed as argument 2, whic=
h is declared to never be null

It seems we need to return early from the function when
dsos->dsos is NULL since there's nothing to search.

Thanks,
Namhyung

>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406180932.84be448c-oliver.san=
g@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
