Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F0213EC2
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648078; cv=none; b=Sgz0kkbUkdsdFGViaPCX5sLbu6WNMfncxO3gg0tdZHJztUCqa2N5LJEGX1nwY8x2wZq0OqO2ziOjrzomgkjBeSANxN6v9FBqfSNlr5EAA9MOynQzGxnpceqEJZT/kUiT/2r5Unp9d4Z545PVqwj28yTsE3B56tBXrOrR4PWny+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648078; c=relaxed/simple;
	bh=LT1IaCp5+fhZVHfVV7IJ+78xYx8h/eAPb/ijFeWEWc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPsz2FcQ49ktRpcK2AyAkIYmPTftcqntVmRcorUt/PqSjhAy2SiJYjWjrPyqF7nkRA7JCgaYMHn/UMaTSWenvh4YQmEglHiZ/24tZuaV7454zBFVS2+26AZ0T/WCQkslkAsEOQSUUIvrlU4NxjmuSvi+njiyAFgTntpZ0Qj8hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=L0xMS7Hu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="L0xMS7Hu"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso2525647a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1728648075; x=1729252875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpKEy9eKEr828a+5Sj4OEUU4agb/G4dm93dgL6VdZuw=;
        b=L0xMS7Hu8NwMr0kCjaWaygXhxozm9B59UBplkQd0duhe+1STGNetE5VXigNs9GM2hk
         FPvBByYHhure9xA0JxyUad4SM6QYElzA23+UzF2wlfra9sFmYvidS55q8lHwhNuu4QZl
         r39o6A9vGjq3YTiM054nZi19F83P8jNWA78/hYusQLLSXkfWnYJjJSKHrzqmx2pu+ySk
         kK//8XxBPA20zmLCxJ9v9mnMu2t6b3W9UprZfvBQa+FRrAIVi5t8Q4WxPF6DvXiB4W2P
         rv+lrbZLG/ZMqa+FHXD1eBH9VJqWEIOQq0G8RAWRhsKmkFySIYEXCI+r8g6BDnI8DbgH
         IlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648075; x=1729252875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpKEy9eKEr828a+5Sj4OEUU4agb/G4dm93dgL6VdZuw=;
        b=VfP7UoK4uE0FTt6h7JwT9RJ8y+105nK8uGxIjlASD6BmrbOAVPsVL4Pa6euGU9DebC
         vVlYeb4FIXWRKpl/uzTLLhnVHWIq/ZCFA3dWaQI/d7PTcB8ulduN0quymTD6nCvEKCZG
         P1MPVFH9sZVTZbDlYfgGj5TX7qXrifgmSVQ70sKbukkzxt0L4Z1LOEpr1NxBoENI+vmA
         ejZMkD0y5QCfmkFK0zeWeCCALnaIGdaeWkEsQAV9Z5+RKuxAzM/H0i8PFH0AwYWs9js2
         eb5y6tqvfITEFtCcUKKNrNNYaZ1enr09Bh4tX6G5+FuG8VEDXN7FEYPCC7ke6HlNc+Ay
         wR9A==
X-Forwarded-Encrypted: i=1; AJvYcCXUcn060mcOy8b7A/cJD2yTreMocJEjWaRHyd+pBXnRCinLbg8I2/pXudSqRBxCR7mkFfGDJkzovUskl14OIXuy@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIOYtjZhNOta8RFHVDLab0m5Agt30xj48fe/8azcGil/h6OUB
	38wCNZfGenHZia56/h9hRGQW/YM3X5uWopnNjZBG7BbmwTWE+2fGAqf0CRLHYoVcvp3F9a3FMmk
	3RmHx0WMdwMftXaAq8rYG5lG8eeUElkoo9+WHaw==
X-Google-Smtp-Source: AGHT+IFIfxq9+xDx7PZBV2IwVM3jqEqcPFmqwd/ztphHxEMC9D5lQLpx2XzRzy5zRcisVSixrYav/q4IK5ZlN2o4DbQ=
X-Received: by 2002:a05:6402:84c:b0:5c9:4664:e699 with SMTP id
 4fb4d7f45d1cf-5c948d5117fmr1490793a12.23.1728648074858; Fri, 11 Oct 2024
 05:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011055700.4142694-1-howardchu95@gmail.com>
In-Reply-To: <20241011055700.4142694-1-howardchu95@gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 11 Oct 2024 13:01:03 +0100
Message-ID: <CAENh_STz6DxQ483c4pwX=Gwfwy_iKSQno+zHmXXQ3N0pOpxcqw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Delete unused Intel CQM test
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:57=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> As Ian Rogers <irogers@google.com> pointed out, intel-cqm.c is neither
> used nor built. It was deleted in the following commit:
>
> commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifie=
r to files with no license")
>
> However, it resurfaced soon after in the following commit:
>
> commit 5c9295bfe6f5 ("perf tests: Remove Intel CQM perf test")
>
> It should be deleted once and for all.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/arch/x86/tests/intel-cqm.c | 128 --------------------------
>  1 file changed, 128 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/tests/intel-cqm.c

Reviewed-by: Matt Fleming <mfleming@cloudflare.com>
