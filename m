Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738461C5D60
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585762; cv=none; b=H05Mo2dyJo3BNYvywCDMvwqvtoqoQ5tQzO5ZbrFkknqN2y2H7HvlfUcH1rHUk8OEJ7N3Zdh/2UZPWBgGh+rPcUu8WayrNvMrU3U2G00ZCsYN/0jduo6MH9wT0SFBBM2LFrr4YTRz7Ob3igxvlJ1XQmRUy2hmUgns4oWVqzBLdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585762; c=relaxed/simple;
	bh=WxRxLNmAPyUcLLxVYpsAStNNFy32ldZHtuS8YS/VnZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwxjnYlZlfIhnDzcBUjyEFzfhHL1gmeSk0/VU7EkbCTVCECla5ehKtJZrd3QV2HOSAkgezw5zgw4U9J+2PqRoWKyds5TbnTcGEXLoCpgdwS4Q0zFIyqZwdOoc0aVV4vXTYNIiIukIzx9kHletNB+eG1REu4H7Qrj9OHgY+PRJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjFowcoC; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjFowcoC"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso15475ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737585760; x=1738190560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdQqEYylhQnR7GmUoqf/ZNlCgiFdYKItjGOj+KMaLn4=;
        b=BjFowcoCKqRTcmCrih4x0DNAeqWrJGGWBw7RWTOjHhTjcjOYwI7NMTlzD37QMyOavd
         70dHKLxdgnQ1529ZDIml5v+qSRyaAANY3Kjlyl06fcgqgwktnkpeaPUo8Bh90rUBsTa/
         cWN3NenFZu3ti8Zb9RcpzZPTp9i2Zav45M2HkAxwcdwkzySFn4TDdCO+CP8PKZenuAQ9
         FNPDg8px+TIf+exFZleQ5NyU99H4hQwCnJAgJSGOadR83V8Y9HPMLOAkCuKB+RLQTJG2
         2zDBPMzm3nLf7iuOdMXWukpPgWODwbM7HQuVylBvpKmuQHPhBsaut8+GSZCCSn0pcG++
         qltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737585760; x=1738190560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdQqEYylhQnR7GmUoqf/ZNlCgiFdYKItjGOj+KMaLn4=;
        b=jyjIVxrgBv6Hvp6b3cmcmBLcU5fDzLkS32d39W6tPN4uEJCSDmXk7dosi7ASjF7/sd
         iSlOQ6cfaeC4w9gT4UNMa7VhS4BSElIDVTmRg98oPTSPVSfuH4+ZQyCiCIg5QdydyNhb
         +i9L8/KtA79Jfqha/QTdF/GpX0rm/GrsM2yFv17i+X7SSo+YnbDIuLp9yHb+b+d4Bn+W
         M3rJVIptwm1kuK/5NndhVDgPBmCnr6DGm1mj9QdqgC0F5f4ebR9oUWWxnGU5ZZAyvDm5
         WSR8SGZVRPQBUGyGPZC7RUU8P/XNLoI3Sl+9Tn3QybHfmWW9IMBGSZ8+2PZ486I++ZKP
         sLOw==
X-Forwarded-Encrypted: i=1; AJvYcCVGwtHtiGbw2h+UbBSg6CPQ7magOoQQC0IuVkEjYiXJZ2xgxRu8XuebevbDSt6QJ1nipns5JeDJTxK3jmNjVHzC@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5vDQK5tBAhzF77wF3zp7NC598q+/3oD2/2L70gbG3RlGcEnf
	jWZtEb/8W0AVSJPePVW6/lS7XD8/G1xlqY2uK7HKrXFofJisbKYI1fX8WN3qPS17KxZA0TeoGZR
	Mdhb8yoOsZE0qcBKHXAd4d3raLz1GkySxed8z
X-Gm-Gg: ASbGncvfB8N7YUsqSMsUANYdojBWo7B5uhaOysVwJQXwvmw3rBRHdEDBzmAFoBkQUIy
	5W3tDkZdLVAGB72cXpZU6Ro3r+T9J+KBhQFobIO0fHvh9Nf2iL4f74jzK5Y2cpFPjTy03vtz2jx
	bonfU=
X-Google-Smtp-Source: AGHT+IGbhqyoaqIScjShtSZ3NK5yA9WeXZYjaOofa6tWB0i9NR0wrImqL2d01e0QGGh2Hae78dUu0r3/IV0owzY7wBM=
X-Received: by 2002:a05:6e02:1a0c:b0:3ce:6758:24fe with SMTP id
 e9e14a558f8ab-3cfbdd83c7cmr384555ab.1.1737585760333; Wed, 22 Jan 2025
 14:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120173208.344231-1-irogers@google.com> <20250120173208.344231-5-irogers@google.com>
 <Z5FwusFZ_bYlu6aK@google.com>
In-Reply-To: <Z5FwusFZ_bYlu6aK@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Jan 2025 14:42:28 -0800
X-Gm-Features: AbW1kvZPdNegWIwwKqz2CFL7jWTDXTlWqfLgpKyMAo5cBo1YUpx2gsEF0tmQ8Qw
Message-ID: <CAP-5=fX4vtKzMtrEbZhqH0dmKpXY3Ke+pVJ-ZbnHnAVuto7Z8g@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 2:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Mon, Jan 20, 2025 at 09:32:07AM -0800, Ian Rogers wrote:
> > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
> > support dlopen-ing libcapstone.so and then calling the necessary
> > functions by looking them up using dlsym. Reverse engineer the types
> > in the API using pahole, adding only what's used in the perf code or
> > necessary for the sake of struct size and alignment.
>
> I think reverse engineering the types is fragile.  Can we simply change
> to dlopen if libcapstone is available?

The current behavior is if HAVE_LIBCAPSTONE_SUPPORT then we will link
against libcapstone and can assume the header files are present.

The reverse engineering of structs and constants I agree is brittle,
but these things shouldn't change, it is used in this code when the
capstone/capstone.h isn't present. If capstone/capstone.h is required
we could change the ifdefs to indicate:
1) capstone is present and we're linking against it (this is
HAVE_LIBCAPSTONE_SUPPORT today);
2) capstone is present but use it by way of dlopen;
3) capstone isn't present don't #include, don't link and don't dlopen.

My thought was that this is less good than the reverse engineering.
(1) relies on the builder having libcapstone, which at build time is a
warning that flies by. (2) also relies on the builder having to have
libcapstone and to opt into a dlopen behavior, they'll need to read
Makefiles to discover this. (3) gives a less good perf tool with in
the source lots of __maybe_unused and ifdef-ed out functions all over
the place.

With the reverse engineered values if you have libcapstone then
HAVE_LIBCAPSTONE_SUPPORT works as before - no change. If you don't
then you will be opted into getting something better than objdump -
albeit it could break if the reverse engineered values drift from
those in capstone/capstone.h. Less build options also is less
complexity and cleaner code.

Thanks,
Ian
