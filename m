Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1682F43;
	Sun, 18 May 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592304; cv=none; b=Gtb2vMwCnZaXnAKY4GRypQfmAA6+dJ2Bblcc8IQct9TLvYjDtf8Eu/2bp7Pxt9kvDhnosOSuOn6teIOKBGyGbNIbMBe5cqRGgFknNAGa/6ARSguQ40leEHRy5cMYRTMjx3APRHUcDqYGM2x7SFn7Onq7Tz2dTCLTdMoWuzfJ5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592304; c=relaxed/simple;
	bh=1+CVu1DlL8lQvWYePYnTBD7SDsv7YLJ1FnV+LYZAuC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYXCAPSS3N9leixj+UWwdteUqX0ZXSOTfp3uCYnEfTGytfVm711Lz88ai/6RwFw5yhFNT1W/xHGkbkP3loTFJ7r+ok+J6o0IpvI/vZIxYNr4tMdUcroa7bHWV4vx2oA3f+VIl+9ejniajK/qosAYF6p77W0diRKWQqqzk2+MSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVC2jFsp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVC2jFsp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70ccb7effb0so3383037b3.0;
        Sun, 18 May 2025 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747592302; x=1748197102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2suEvd2FaI1Ik2oDRDBc6d8t20M90J71SYRtVoxC3hc=;
        b=KVC2jFspkLqE5sny9S8VjzZj33mJPC4bk8jXz9XQETXGLviZRpXhhPqk1KgTW6zzWI
         9mkg74He/cg8ZnyKh3wvPQIF4Qt06JD9f6EH3m/6PyfZ0UZjqJethoyFnQw60OaTuDT3
         tMSvRVlZGWGzrpNOMNIrE0jYMdoZiGnEci2OpKxhnrIZyLtvwPCdnklZsMT3QbcbAYXr
         WCQwUv22THw86lXVHOrKXjgCvObq8Pq0je4ihHzXzcv18BcK+3AuLDhbRMt+8Ujc91LO
         N18XngeyJTYLdghseqNDsxzrQpcyhJ7orwNdRtfrMF9o7Bg85jLW12i8QtraBZYLQvRQ
         R3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747592302; x=1748197102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2suEvd2FaI1Ik2oDRDBc6d8t20M90J71SYRtVoxC3hc=;
        b=XiVqUXxt+vhpJ+T5inSXyv/+kUNcn8F72EyLDX9nIL5bi/hjIwkJMdKxbOQqs123l9
         /dtENHfQh3HZtiv1tMPxHecuPWTSDEks6/u3Kh3h20q2IA4sdUr8Q4z3xw2m2MPzgraH
         GuVcJou0l0imLZd0tGSxSrM8q0itFzvfqBmq3Dd6U+ShRVbcclBjgSCcoJ1XkTbQaPMz
         8H4G3T/rkn3VcdSHWw53E+amRAtRXozNnVRfxBAvNQ+JJ4aUDzWyLUSqv4FmB50a4SMM
         oQ0efwuAxlofK3P5eW598KkAumN5m1T3bsApxyrBjox2hrNkuV5i+U3Sq7Du9XREeSFC
         5Ogg==
X-Forwarded-Encrypted: i=1; AJvYcCU3aY+4yjIyWcHFqjzRqYCGNWWUHAvP7ypWlHu00ZyImgdmul7zesd7V+nowx5x6DGyBAOa0tzf0+C0Kesc2b7A/Q==@vger.kernel.org, AJvYcCWgws02xJLvbhdILsEVBKT1xsZgw6OHKjlHaaxjNOIYE5bZ3+DYJTMEK2Bu+pD15PzZaWanr5PvfHWQqKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAwgc0pomHcw+kWg2/95PqFdEj35Emg/ni6DprBcjnH+SiMwS
	1tUhUMSbHaPh26QOHNpbSDMRSwVFPFtrsXEPBSKafKABAMcfaJOjjw90Jh52qwapuMQX+RXZP0W
	NvVoWcWRbohjZkOT7IGv60dH8jsfxG8E=
X-Gm-Gg: ASbGncvu5I2QEcnthxET6M0lvQkQh68SIkT5aL6eqpeIUZTnMa8Bm/kdOpF8kbIrAWJ
	QztmkLN3PEmiwngML4UYSj1W2KN1R9VZEFrlAfPR0Go3kRSQPDCfuPCF5JTg6kO5IM0LEXwbCcF
	ZMLjiLspjN1T0jMR8zb++R/LGal6mMN8KdkAD0J6rRfw==
X-Google-Smtp-Source: AGHT+IGZ+9/gTpfzv5da8wRUdM8CtHVX1RSiGzO0V6hycvi9y9GMuMxAh2tXRrXYZp04Pj8nk4tOWrOG9PSRjq0qO9A=
X-Received: by 2002:a05:690c:6189:b0:70c:b534:868f with SMTP id
 00721157ae682-70cb5348db4mr110615867b3.20.1747592302121; Sun, 18 May 2025
 11:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517163230.1237469-1-howardchu95@gmail.com>
 <20250517163230.1237469-5-howardchu95@gmail.com> <aCobLyqonDU4qnzv@google.com>
In-Reply-To: <aCobLyqonDU4qnzv@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 18 May 2025 11:18:11 -0700
X-Gm-Features: AX0GCFtULoXtQPwkt6KgC_0fpUvME3sQR_zmCjQes2c_g2fSl0R_T4q_QWHF6cU
Message-ID: <CAH0uvoiMhvbcw8_4no3-j+Gvq-TwFv1a5upKVJyHFLeuM=X9Rg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf test trace: Remove set -e for BTF general tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, May 18, 2025 at 10:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sat, May 17, 2025 at 09:32:29AM -0700, Howard Chu wrote:
> > Remove set -e and print error messages in BTF general tests.

<SNIP>

> > +  if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${f=
ile1}\", .*, \"${file2}\", .*\) +=3D +[0-9]+$"
> >    then
> > -    echo "String augmentation test failed"
> > +    printf "String augmentation test failed, output:\n$output"
>
> Looks like you need "\n" after the output as well.
>
> >      err=3D1
> >    fi
> >  }
> > @@ -39,20 +38,20 @@ trace_test_string() {
> >  trace_test_buffer() {
> >    echo "Testing perf trace's buffer augmentation"
> >    # echo will insert a newline (\10) at the end of the buffer
> > -  if ! perf trace -e write --max-events=3D1 -- echo "${buffer}" 2>&1 |=
 \
> > -    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) +=3D=
 +[0-9]+$"
> > +  output=3D"$(perf trace -e write --max-events=3D1 -- echo "${buffer}"=
 2>&1)"
> > +  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buff=
er}.*, [0-9]+\) +=3D +[0-9]+$"
> >    then
> > -    echo "Buffer augmentation test failed"
> > +    printf "Buffer augmentation test failed, output:\n$output"
>
> Ditto.  And probably for the previous patch too.

No problem, thanks. I should also mention I used the wrong title for
patch 3. It should be 'perf test trace: Stop tracing hrtimer_setup
event in trace enum test' instead of 'perf test trace: Stop tracing
hrtimer_init event in trace enum test'. Thanks for the review and I
will change them in v2.

Thanks,
Howard
