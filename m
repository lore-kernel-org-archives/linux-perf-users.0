Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082401DC9B5
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776129512; cv=pass; b=b+z8yZhIFjXT1wV10ASZGRgNVfTjkL82o+kq7A/Xk7AXyhFUQ/U+Wk4vv9V+ZiWSieppy1LuYyo8zt4PxCwx/3MynfXOTYa26tUqI9/doFpGf5j81AFxQF4efKBIM5+zzGlDVxkYZRvX9Q/RrnfDlQ3QnPkIyOtoaUP9opd2dQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776129512; c=relaxed/simple;
	bh=r/B5FgrGRLGNvREPhROVObKT+v+R2oXtyEIRxZ/urog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ+xAwga5JiBRbh6OCp1L5NSY506JR0ojI4dZ+HzW0yfi3uwh+ugn4mN0DEDekc8kQdxnWwOZJvVgPjMdmgD34Poxzgsrl2hl3SdjSlWGlKRwYlsd/DSjIbWBKDEHhTalzlIG+sCjYx61UfS0sQYNrJCQLRxe4d+giiQFFUZtaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b=eAWuOF7P; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b="eAWuOF7P"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b4ee3a88e1so3531307b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 18:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776129509; cv=none;
        d=google.com; s=arc-20240605;
        b=C3/wkWuCFQ8B6JhQYTBUb3LZkz7fwlfyKK1a4kGZi2WfhVb7N4yN3j1xph4nNd8gCv
         1ajHDh5qTi52SEHVX348c+uLLSXMvIbGtND/BkUHCy5AueRyhf6hUuoOvGM2Sww33nDY
         s5Y4wnB7VjhoX7EzAoVPLogS32rm2ON+PIec6QxuoZopWFNbPzVSuDaNhZu5iOvE0IA+
         0LR5GYNXMBNd5aPtHB6UDYcCbIMsTcKZpxuP0pfUE/6eg3w4/1oN3v8xmdPKEovKkApC
         2GYb9XOSDO9i+4ROQw0gbNCADxNBru+91g9ldR2rvFXsIgIe0LtFVWyJN2lgO0Vn8SJL
         os8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IrEpUWhdq/JQ2fIqYqebNC4R+txxo9jSE1dyCgQYRdI=;
        fh=kvJCZcK7A+vSMSy18GQpFir34gJew29gRhdPAje3tZo=;
        b=biPObyhUpZUeF5j9xK3PJjwu5fywbMY9mcMtx/VnOHLiCbLGa95wPzn/+2RYdQsquu
         3sWQBcvCCb95l0sibTAnlfxsmah36peiKb0zB793UJ0/8o0/W5IA9EGWQOkSlOB3GrYP
         TvJn9GFxuR1+wQ5aYGca7VXtS9iR1ThyFIOULuf+6pw1fZDqJFehjYLg5iWNFQFsEU9k
         Uc0qOLt0dOhNNgE/BquZqsQ6Kxy4Lfen8nowejFbqniPtqMJkMG2h9MTk+qmeb/RMrdR
         zwp23jyik+vacUvkpuTfXRSXMDebqOnA066IDPfxoEeTikyKIu6Y+SwpmgM9W2osPE/E
         +mbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20251104.gappssmtp.com; s=20251104; t=1776129509; x=1776734309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrEpUWhdq/JQ2fIqYqebNC4R+txxo9jSE1dyCgQYRdI=;
        b=eAWuOF7P+NDel7zaVy8Nz9N7uTzXZrZcGqbKz77z5W7ScLlo73wFKjiim7wPz/9A6r
         GRVtoK/5OP5V4vtWasva9y9BnxhInRj/HPLKbxjOIifeHL9a23mkKrw7L+K5iCeo+fEl
         uMIa6i4PTWp7BDgTTQo9VMIj9obZlL8K8outLVyL84JeyB5oYgb6vlvDb4ubJH52pFIR
         XZhQsCQiK7cseZZZ64Abp/PPAycdm/F8rS8JjYcWOvKHb/O8ZdoYxze69Kd+FDRoBm5H
         1QCLBToe+gfCSF4P4e10D+67C0FgtYin5UU/kykw9qh9CopoqTn99ybnCan1I+tL4Iuq
         CeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776129509; x=1776734309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IrEpUWhdq/JQ2fIqYqebNC4R+txxo9jSE1dyCgQYRdI=;
        b=BsNRj/4qJFdo+4e0XLt8mKwdYzxiaG0DJDReUuwV5OM7CMaBGUkkr62GOaWODBiPXX
         r1fpCU+viMdlyhMy0voLPYqoKo1IHEC/JJLb0QNork76lW19tWdWx0yIH29205RKkTIs
         DkMyDS1Wp15fa2fCAk5F/LIGz4vg90dDK7cz1+BaChZYeqBmb73glmtNmQ8v8gKB4uvJ
         R/iVNRHfAFRY11KSM+3tb9wyRjs6QjZiRUBsx25nM4kZrxmMu6wkLzvw+dpwml5e1bF6
         yZxYTV+f+LlINuE9iFC9hlKnKCOvT29Fuu2bGKsOOvJcoDcDGrSIXKXTSxYTP3wpUqFn
         Oz0w==
X-Forwarded-Encrypted: i=1; AFNElJ/gUufmL4xpfMSCT2r0W/muisjhf0ffiFwT+4fuazkBfyp+wxCePsL/ku6xPjaqzooKZg6JgeM/oA7LeIptt+0o@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuy5tjl1z1JWVFGgwWrATMeQVpU6fmtPy2OEt/EgbtrDVPAF2K
	uczokSlUx86SIupeyYE77zHIB+ZsW7pU+otGxHDg3rjbC5j7HwegmQK1XxfRNjKLJB7JOCQSEje
	OAFkjTguxshDBbzJ1Dr5EYcdX/jLrYWmjz/rgGZy/1Q==
X-Gm-Gg: AeBDievMf9BJs/e0Fr6d8TKElMwkS1NZMnMGimAlIneZfYcnZmFT2XozIp8u7F4xLi4
	iWN++gurCfBNZe8Qwxt92U9JxF+B2t4weK80kbc+eJQBObkGqXtnH2IomcUh8FSeCnHHSSdDKy8
	NC7lhbs9zi7qH6gjX08jWdoWgcqAbPgezWVESQGl6+E/J8tRoKLEGWN57XLGgDMc9WAcYs9enpY
	TwHRztHxgbIcEkjHKRkBZZ5z/k3vPTVCpq4rSIIypJN94Y7OFUsRq/wy9l1o5GDEEbhojobJ000
	C8Ean+cQRcsfX6sOf5AT4qAdWePCwWw5PFxxf7CTN+m+Oin6W8Q=
X-Received: by 2002:a53:b198:0:b0:64a:f163:1554 with SMTP id
 956f58d0204a3-65198a6cf59mr11028006d50.14.1776129508992; Mon, 13 Apr 2026
 18:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414005152.10550-1-r@hev.cc> <CANVb8WZXZj1Yqd7foqHBLSHjO73r0Kg62bMbrb--aE8wR3G2hg@mail.gmail.com>
In-Reply-To: <CANVb8WZXZj1Yqd7foqHBLSHjO73r0Kg62bMbrb--aE8wR3G2hg@mail.gmail.com>
From: hev <r@hev.cc>
Date: Tue, 14 Apr 2026 09:18:18 +0800
X-Gm-Features: AQROBzDXHKcDiM7ytv6ZGBgkaWU-pXvKEfBok_mK6DXk_L-fF_PJq41YLK00YQM
Message-ID: <CAHirt9jA3G5kRjJbmosttEDkvZhKfx3U6oa63JZOnpEx4Cqb2g@mail.gmail.com>
Subject: Re: [PATCH] perf loongarch: Fix build failure with CONFIG_LIBDW_DWARF_UNWIND
To: jiny L <leeavianna3@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 9:13=E2=80=AFAM jiny L <leeavianna3@gmail.com> wrot=
e:
>
>
>
> On Mon, Apr 13, 2026 at 5:52=E2=80=AFPM WANG Rui <r@hev.cc> wrote:
>>
>> Building perf for LoongArch fails when CONFIG_LIBDW_DWARF_UNWIND is
>> enabled because unwind-libdw.o is still referenced in
>> arch/loongarch/util/Build.
>>
>> Fixes: e62fae9d9e8 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
>> Signed-off-by: WANG Rui <r@hev.cc>
>> ---
>>  tools/perf/arch/loongarch/util/Build | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loon=
garch/util/Build
>> index 3ad73d0289f3..8d91e78d31c9 100644
>> --- a/tools/perf/arch/loongarch/util/Build
>> +++ b/tools/perf/arch/loongarch/util/Build
>> @@ -1,4 +1,3 @@
>>  perf-util-y +=3D header.o
>>
>>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
>> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
>> --
>> 2.53.0
>>
>>
>
> I happened to have the same build issue on linux 7.0 and I found there is=
 already a patch fixing this  https://lore.kernel.org/lkml/20260413024805.1=
316480-3-irogers@google.com/

Thanks for the reference.
Rui
