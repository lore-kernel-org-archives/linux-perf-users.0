Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB4222581
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717596; cv=none; b=q3P9nDogBnEHdwaeuoxTVX19ik7ADQBubELpC89b0AkQAYzwR4uY+CDcj9lbaKlJqeVQD3gOGm7qo483KTDBvGE7zIazpUL16Bhtx9pMn0Y66uZT0gelofG7aKfsz9V8uQor0U8RnDe2H5vZPIZA+d5SdRnIcedtQ0faiCcHqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717596; c=relaxed/simple;
	bh=xNeLTC3/vFEjHgWEO3ptTwVEQ+fv9CQyFaewi0CuOv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=begAsy9fzoEQao/ZfyrAfxntGodlE8eREGBvUA4qO+K4cg5a4bcf//Z+IOphSnGGsXKHWpWB5ERU9qN2mIo/ZQ/Wzv6TjiMFExArJiMnA24+f+J8ihnSIcnB/1lfOpm0hFRyZ6EDzWYsJsIaIgtq0IT5cJynthyfjCZOZQ4TKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2S5YI6K; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2S5YI6K"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo45775ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 15:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750717594; x=1751322394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g63pirFbFSmTBdwgMEBjEZptK95ioxrwcei+ssJCFY=;
        b=J2S5YI6Ku49LaWsxkysHefY3Gn0fxQjoQ1HNbK0kRKOsZfE2ptQ3v+Cx8iFRGJeehe
         qlx9jfHPXkKv5xkio7xuMjCfzyqS4cI3Ug1LonB/RLOmgANGs3HehDqTEgNz8jG2pzkH
         FRZ5Mff+MEx0TucRksmgPFhXvi8Y0WbQRKtfQYYJ8EDJzUqUpVD4Jm9rL219SmJWRjxQ
         0dhm0xRmo2ICvUjzcOAXK42ly0vHRHgmYPGhChQtP1TVzh1wzXnsYiYbCHn3UULIgfIk
         xIzp1QMmn0b0C9cVnvGqO7sOT6yGwJvSkEE4+AMiuV8CYyjFi7s8lZemAhbYiggWjy57
         rlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717594; x=1751322394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2g63pirFbFSmTBdwgMEBjEZptK95ioxrwcei+ssJCFY=;
        b=RKAeIAK2SVMod13b2O3SzB8n1MBMSPDhCB23oKR6i3WOq7pvFJPq/vqLU1XYDIUN+d
         QZOgsH69ACoQXluSKkCJtOicGLblxmrpT3p8Q9HLbgEdaXrJV6JI14zp5yjjejiGuI35
         CgtaRVkHMB9wsDkL+NsHODYXcAQLNIXpywHReSCPICf6kyViRa3I+g/qjntCG9bOx0bp
         zFVTKB1HSiWGBqbZH9mRQBMW6fT44ucdXTkIv/ldceBiIQWhIIG7hupwh6VhS+4PWzDm
         CIfVQFLClFzfkgx/cBT/Cz4Q/OZowrtPUf8G1Anj3b20NixeROPC+PJutttiUOeAF4mU
         NmSw==
X-Forwarded-Encrypted: i=1; AJvYcCVg1/qf7rl0ioXQ+TiGADHdB0oHj5rzZJEKhrsNDb2arHT35IuYnxM2YV2FYshNsih1uwQCM2HGPUXbfXIrKj4p@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2J7/LtTNa/KNyJVYiXSDqhh0lRx+p2jDQmMHDDdoTy6Ws3IQ
	8sh8MfEvi7bUJWOPCNC8+4bGt7FUJy+LVRfEsHSLTBEirGqH0VP+R0Sh65H5k+howwqhEuWJhoR
	lzuRO1oCJiS4Dxm3xpCTrbasfGyViSsauq2lxVlex
X-Gm-Gg: ASbGncsyl/vWf/M6Lzd+pOpy8Y7jUkeobts3HPC5YEuBNG2em3++L8HrLPs+dVigFma
	Fh3n+Yah20Rk9lAqgD8IBfLcpvgsVS/g7ezWYz806wYBsEBSMe0sihbetB3ubLRX+YkVwrWWo2T
	zfLUR5houZTyi5Yuo/cyLhrUoF0ve+/91z+HlgRCXyEJ+uSnl39HRB0I4u+KVQn0DTkfdcyyYw
X-Google-Smtp-Source: AGHT+IGMcaEmAHBaUWIflmFryit/RZswlMNpVQKzvPg8TKCyZkCgrIutE6ln2v3QEQqxlYfYLr2nOks4w3TCO9MrVZk=
X-Received: by 2002:a05:6e02:1544:b0:3dd:a562:ce54 with SMTP id
 e9e14a558f8ab-3df2a569ff8mr209175ab.15.1750717594065; Mon, 23 Jun 2025
 15:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614004108.1650988-1-irogers@google.com> <20250614004108.1650988-3-irogers@google.com>
 <CAH0uvojjfOcoZmxPL+bG5NEid8xcAVth7UxOUc=aYjgF5nqs2A@mail.gmail.com>
 <aFBF1ejZQBBvX7F4@x1> <aFHeY_-hVNKtXPAD@x1> <CAP-5=fWXQBdg8Uq1hFgRPC4z4vQAvUuT6TnUkPHSBfdGPNaYwg@mail.gmail.com>
 <aFHi2FUDZy_cEA5A@x1>
In-Reply-To: <aFHi2FUDZy_cEA5A@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 15:26:22 -0700
X-Gm-Features: AX0GCFsJl1V6SmtpGR-Xq9huuZQRBov8XhEK5Pczr6a2e8qDUAx9ANIj0zleZD8
Message-ID: <CAP-5=fXXOEH1Hf=je9EgmKgSKEiSSs+9abUo0vUoS3_7dp0Uow@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf trace: Add missed freeing of ordered events
 and thread
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:49=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jun 17, 2025 at 02:32:37PM -0700, Ian Rogers wrote:
> > On Tue, Jun 17, 2025 at 2:30=E2=80=AFPM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > On Mon, Jun 16, 2025 at 01:27:04PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > > On Fri, Jun 13, 2025 at 5:41=E2=80=AFPM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > > > Caught by leak sanitizer running "perf trace BTF general tests"=
.
>
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > > > > Acked-by: Howard Chu <howardchu95@gmail.com>
>
> > > > Small enough, applied to perf-tools.
>
> > > root@number:~# perf trace -e *sleep ls
> > > anaconda-ks.cfg  bin  bla  commands  dtel  firefly  logind.conf  perf=
-install.txt  python
> > > perf: Segmentation fault
> > > Obtained 11 stack frames.
> > > perf() [0x5c595e]
> > > perf() [0x5c59f9]
> > > /lib64/libc.so.6(+0x19c30) [0x7fd43ce27c30]
> > > perf() [0x5dc497]
> > > perf() [0x492d54]
> > > perf() [0x49860e]
> > > perf() [0x49890e]
> > > perf() [0x413413]
> > > /lib64/libc.so.6(+0x35f5) [0x7fd43ce115f5]
> > > /lib64/libc.so.6(__libc_start_main+0x88) [0x7fd43ce116a8]
> > > perf() [0x413a45]
> > > Segmentation fault (core dumped)
> > > root@number:~#
>
> > Thanks, I'll take a look to see if I can spot what's broken. Seeing
> > this stack trace makes me remember we haven't landed:
> > https://lore.kernel.org/lkml/20250611221521.722045-1-irogers@google.com=
/
>
> Yeah, I just pushed perf-tools to soak in linux-next/pending-fixes for a
> few days and will switch to processing patches for perf-tools-next, will
> try and pick that one, I also noticed that the backtrace wasn't
> symbolized, thus your patch wasn't there :-\

I sent out a fix for this issue in v2:
https://lore.kernel.org/lkml/20250617223356.2752099-3-irogers@google.com/
Patches 1 and 2 I see are in the v6.16 fixes PR:
https://lore.kernel.org/lkml/20250620155415.88215-1-acme@kernel.org/

Thanks,
Ian

> - Arnaldo
