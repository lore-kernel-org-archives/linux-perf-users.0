Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D4253351
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003118; cv=none; b=FqEoitTevq6bxOcns4txhhnlcA8W1nEnqVYsf28c5W/vXCGy2184Hln9kquVN++m/3NiSAcaaRLUMCXAoGPviPyB+yb6lqCgPQrtl1/vQDGz/dFGrdhy4QxjS9vmg3RIHbqziLRBXqC1U45Vr7WEsgXR6GIDILwT1z/Br1CwrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003118; c=relaxed/simple;
	bh=ZSV2XFFcj0GPI8zUDnU8tdH44VjKfteko0rzddXUI0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9tLdw8Ue0t8IKf9faQ7NDkmM1+qdrsVFBHPdqqecfLyqVE4vApj5AVUaDJ3GzDYefJ0FBgB2cRA2u7Q9MSivu2cYanSwjlDtsN4sqmLLcuVBVYyKGIIaC3oKgkAjKdu/2WlxD/+d19+GV+1MlJ34ntFv3TTVFV2UTJCVylv/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nv/4T04U; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nv/4T04U"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d2ad29f630so41815ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740003116; x=1740607916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6ArLCB4R8roBsda9VKkvi/MZSJCY2OE3VLm6uu/stU=;
        b=Nv/4T04UZLA6R3cezr+UfAK/yqfNNb9qzjnv33RH3cGuPvkwBeVLCUGuKI1GN4t0Cu
         kN4f3VenvuWmCxyAcTa9nRUVHXC4ZkSvUU2frJZqUbVF+lUbGnkP1bTgLbYrnW8hfAqi
         oMBcATpFjam5Ah216oitlR9/HqNMg+TB7EbrbIVbRtjEi38uJyW9FoZYRitgf/2b++hD
         +GVL8J4/388A4BjNIRDtDvP2UrmiKrVnQx4K8WujwvQEmQv3pPh68URjVf8ULTdvgYP7
         thIx/PqL/YSCDShv5iiWErI1FItFpKLGFzxzOENXCNisTb3OY56t0Y06ENTlvhqt7EZi
         Iecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003116; x=1740607916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6ArLCB4R8roBsda9VKkvi/MZSJCY2OE3VLm6uu/stU=;
        b=QQgZc7yCMtgXf1azfZfg1mWr++Ntxd2nXN0oTBvDuDKUodOk1wyect+DpLw+Plt1KT
         XmyN558wT60eT9pXux1iOHJdllsH9peOtg7TWmj+fcwAvzO6cz938W5u2i+e+dDYlLEr
         nwfoaJBGrpFlnW0v5RK0cWTP3W1bXkqmu57+wM7u5QYCjQR8pU0tQMFkYbQPI8mt9esr
         kbbHU5CbSeOg1cLjlDK6gdI1sUBuOL8T1O5iXZzbJV6TWlxaHNJEkh+6yqPDtoWpVrtu
         sWu48k1yf3Ttei22BC/wwY41SpksxYg61meEo07qAjUJBMVXT040Gs4gFypU4zhv38LI
         r00g==
X-Forwarded-Encrypted: i=1; AJvYcCXrnuxKHhj0qaZlEHYmj24Wv575hERrvKHBPVqhubui6u//esvH7yHqWTby+1d6QVJ5dLRoh0M6Fgqh9DvlgidW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VOyerCiF7vcyBwqPzSSxLzFA9kEmEthwi7X/QWh2WKNElGBt
	J34N9mRQ+X9lYkXBp6Q430+iMMBJeK8KSJtcjFVkcbFOid/b4/4cbUk1XF+n8wMCE7mIjrKJjII
	Xb3UPBVjUmjYZW/k8IfIEBSCyiSCQLEd4lu/i
X-Gm-Gg: ASbGnctKd9vV72fl/Xk8pPWR+J7hgeJoK0zROtERtW2pS7uUG/h2zGrNi0TY11uOU+m
	vG7HovSIMcFaGnk9VYShjBPExBoYX9qEcTFcgJuV1QeddbOPRG2wU6q6Ylh0oc6tGmy20SOI7If
	npVDLLaW+xoWKXWRvkwtYU11iWkw==
X-Google-Smtp-Source: AGHT+IGhcAVq+WRuRQVnOuGGJtUQeqPrN7aOEOZtJgaXAh4ql05WNUT5TuGe/Y3K+XW3iNQqSaY3slehVT3VVATri5c=
X-Received: by 2002:a05:6e02:1564:b0:3a7:e3b3:2e3 with SMTP id
 e9e14a558f8ab-3d2c24e2cabmr249395ab.17.1740003115887; Wed, 19 Feb 2025
 14:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109175401.161340-1-irogers@google.com> <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
 <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com> <Z7ZD5phOOCbKggrn@google.com>
In-Reply-To: <Z7ZD5phOOCbKggrn@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 14:11:43 -0800
X-Gm-Features: AWEUYZk6j6515T41cTNxcsJrjdJ1p2AxDpZySNgLbQrIYaG_Rg_DMAueizS4zec
Message-ID: <CAP-5=fXeZM7iWNQq0ar1HmAwWrH4HAHqD3F=ueB=jaw-2UMn_w@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Feb 19, 2025 at 11:02:40AM -0800, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 11:23=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Thu, Jan 9, 2025 at 9:54=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PM=
Us
> > > > before parsing") names (generally event names) excluded hyphen (min=
us)
> > > > symbols as the formation of legacy names with hyphens was handled i=
n
> > > > the yacc code. That commit allowed hyphens supposedly making
> > > > name_minus unnecessary. However, changing name_minus to name has
> > > > issues in the term config tokens as then name ends up having priori=
ty
> > > > over numbers and name allows matching numbers since commit
> > > > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with dig=
its
> > > > "). It is also permissable for a name to match with a colon (':') i=
n
> > > > it when its in a config term list. To address this rename name_minu=
s
> > > > to term_name, make the pattern match name's except for the colon, a=
dd
> > > > number matching into the config term region with a higher priority
> > > > than name matching. This addresses an inconsistency and allows grea=
ter
> > > > matching for names inside of term lists, for example, they may star=
t
> > > > with a number.
> > > >
> > > > Rename name_tag to quoted_name and update comments and helper
> > > > functions to avoid str detecting quoted strings which was already d=
one
> > > > by the lexer.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Ping. This patch addresses name parsing inconsistencies, in particula=
r
> > > events may start with a number without a PMU, but not with. It also
> > > aims to give better names to patterns than name_minus and name_tag
> > > (with term_name and quoted_name respectively) that have drifted from
> > > their original meaning and become to me less than intention revealing=
.
> >
> > Ping.
>
> Sorry for the delay.  Can you please give an example for better
> understanding if there's a change in the behavior?

The example in:
https://lore.kernel.org/r/20240510-perf_digit-v4-3-db1553f3233b@codewreck.o=
rg
is `perf trace -e '9p:*'` which allows the number to start a
tracepoint name, but what is true for tracepoint names is also true
for event names. I lack the tracepoint but the patch here is making
that work if the event/tracepoint is specified with a PMU, so:

Before the input is just seen as broken:
```
$ perf stat -e 'tracepoint/9p:9p/' true
event syntax error: 'tracepoint/9p:9p/'
                               \___ Unrecognized input
Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```

After the input fails because the event wasn't found:
```
$ perf stat -e 'tracepoint/9p:9p/' true
event syntax error: 'tracepoint/9p:9p/'
                    \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'tracepoint'

event syntax error: 'tracepoint/9p:9p/'
                               \___ unknown term '9p:9p' for pmu 'tracepoin=
t'

valid terms: config,config1,config2,config3,name,period,percore,metric-id

event syntax error: 'tracepoint/9p:9p/'
                               \___ unknown term '9p:9p' for pmu 'tracepoin=
t'

valid terms: config,config1,config2,config3,name,period,percore,metric-id
Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```

But the patch is just about making the name term more consistent and
cleaner, the weirdness above wasn't its main point, I want the code to
be easy to read and understand.

Thanks,
Ian
