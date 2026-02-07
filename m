Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27626FA77
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770502024; cv=pass; b=p0XJDkkN0XZbruJkhqitfjyT3NcUsnR0co0o12uGEIPakuJBmYZMn9T12+SsnJJgWv3+SaE7DQSkDpUvUJAD01/1lKJ8MucOpauxAB/NQ5xGIl1owadIS8r+WQctj+cl//iKwTv24eLv+cNUeefpAMFMSE0/D2TjawB/Li3dcG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770502024; c=relaxed/simple;
	bh=7kTLyrIqEeBYMPXrfcKIpipgbii4dBxT1afSE5hho0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWBMSnsVVH5UatTD5VzsY81qOmC8S3KW8qMUGoYRtzB9EWGVONHxKBLB7CFjBL2W4mk0JE2dcrmhwTpkoL8BXdxPTm562e0CzoZEnTYPSTmSetxzJNO6aSiVLC9mQBDL9rGFvY22BPh+VjObtaUYZXVagFtEXTobM4mZStaVdw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02DfaiRy; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02DfaiRy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a885af8ee7so50595ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 14:07:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770502023; cv=none;
        d=google.com; s=arc-20240605;
        b=N/wOWrnoakZyIfNkTUur4Koj9np9D/fBugjeri2SjdEoFJaDq4ZC9tb+DGZwGiMf+s
         dsszUURF1ja82p9qIeK3O88Rdy3QyakwIDhUcu93xb9JxoVyD3qCtX+gaMkizNCV3ja2
         yXVYcKcef/bqFK9TtHTn+raKY6FS4eVu/uTs1kJHX9rCFJW3sYtg1UYPT6bULY7vIgyB
         UD9hfTjIGp3CFxrZMvaABwfSdjCD15rBu2rEd730kO+LQqagAB4jaNr1QWiBD6gVtvsn
         Q1i4tHSN1PKGynYes+qhM0AAFZWDPJBdi6QQuYIf8oUD2iZj+7smzv4YxN/oNaHU+ejJ
         IGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J3C2hEyl05hEdCU16Qu+GAUyjf5mEA691562VQd1BHo=;
        fh=JOum5LC+NaM/yvItzjC9TXQ/4uznGmg+VJuARNJrJa4=;
        b=Ofqzm4k18rM6kUH1JGCOLHbe5jG1PEbuWak3XqM4J+zb5URMpcDIJFhQuh1NH16N28
         m7h+b+sLxBwOVJw2AjNzs9WAZ1PklI0ED3n2xyFXl0BwAiRBfXE7i/Uz7oLathte2MlT
         lKTi54MIvWeJKGHaLBRI5XESw1RQNZPEFfqW7/ORqxTgnZZYJ0+f/Wo4OrnS16IOK2OY
         +1N542J/icnxslHi+FGLKST2zVoYETqc4KAz+TufkRJmuhhaHLtHxP/3eddb0ZntGp2v
         vewIweNEEaYcTM7RlZ0j2CVDIjNTTzcTG/4svTeZ8kdPmRLaiLhMerou2Wt53e5G6Gmw
         Qz7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770502023; x=1771106823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3C2hEyl05hEdCU16Qu+GAUyjf5mEA691562VQd1BHo=;
        b=02DfaiRyWqh1ZnOVxBQhrO3X1GUpQ1tBQq3VzoszXMpdsTLvIRngrL+1Q7JNdNloNq
         bjvTVbCyLiBwrUzZMoqv+AbHectrQKifULJCJOgbZKTSmvcf2C0cCE7uNVqxoKFROB3A
         eo0eiR5tmRbymssjRWtu4M5qtLrP7f1rq9+4HDGJQmKPAxoS5wgrKA1RiWTNJD0Oc65r
         NTrYMH5pU4N5lHOCHbBKfyYMm5tEDw29dmWDzXDfPhFbWY2kqc7Bm/rbsfPoye7kbk+w
         clmU5/dZTEQ4OiC1ZLOqD7zBRdJhhDNNcO2ccxO/tYUKK7PHJ0HT8j3a7onXAe8I8K1x
         dhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770502023; x=1771106823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3C2hEyl05hEdCU16Qu+GAUyjf5mEA691562VQd1BHo=;
        b=jj9Y5XJBobPNjDL3Ery+vLs7j/bMlmiyXLdrzo+ORr8jh2nJ3Ox1T7+cDR7gZqeBC3
         3yEuog4BFXv9LtUcqfPVtYi/lV2xF3nsbB/uYcQURFjnLRsQ/Ff+R2CjuqY+yQAzbo9d
         /CIK1p4pCX40ylcHzuuyDK5vJM2IQFGQA9yAQGeQqVKppvK+FuOtMrcTv3jRD2dzvyJO
         85A/r3EFSfIfv7etE4ITkdAi2IQgNt6j+4e6DoGIOAp16Erful8Tr/OWuRqfOLw/i9HZ
         Eo1/jUym8JMG0A6XGo8+CFOkf9U6Ni+xvf4HzNi6iNcZuOkMRnVQieExkVMz1lhAUKMk
         8KWg==
X-Forwarded-Encrypted: i=1; AJvYcCVGAKt5TpSK3MPR4K/tpqrhS8nlCmFTLNURm9wekVFJWfiVe5OhvY33pxHaT1XLW0Qi39joKRK6tteu2rMdJfEU@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbvXTnr4D+1QsbzG3/aq24Ew9DpALUfsZNxxG6i6dsij6+9QB
	6xxZ77GsI7CjXhz3+PSFQz+bK5EcBQOM/4ElkORJgNCjQV+LpEdAGT4yrfO2lyTJpGGHcVtX9C5
	Lz2EcqsO3n04ruRI4NMz/mhnUfZ2qjBjlCAcQjHBr
X-Gm-Gg: AZuq6aLWjff/IrHD7Eiciz/lXSaDVLMy5QzzlyHDxMopf/xhVQCztUiuEYWAbPgbH9O
	Wrk73vYzbkd0Gjn8xXdSDU7C0h5fbyhDy23t8Qxw0c8fgpIausRbPiSYKaqJOoV0dsxHEJWuwm2
	/8f+2QZYYD18qhvxSKHpcQ1K0+mCwfcgtVnRC7s5Yymgjd93mxf7yxSu2qgNelzpiHbq1Lc435h
	7vx74bpe12DmrUhiA/JrnZCJzwPEESD5r8oPe6hd40mcfAXt/KfKgnCS5+ZvfGKDN60c73W
X-Received: by 2002:a17:903:18e:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-2a96317bcf8mr1841385ad.5.1770502023030; Sat, 07 Feb 2026
 14:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128091139.1309755-1-tmricht@linux.ibm.com> <aYZgGlh3e84ZrUNQ@x1>
In-Reply-To: <aYZgGlh3e84ZrUNQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 7 Feb 2026 14:06:51 -0800
X-Gm-Features: AZwV_Qj4lIuevn1tAZJddgShRS2g2WCpdZDPcsAzuoyzJJJEN9NqPq_JGAkEYIg
Message-ID: <CAP-5=fXJd+gXWrgRC1vBzueCgsLjGesV+oenq3a9irq0+gLNDw@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Fix test case Leader sampling on s390.
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Nov 28, 2025 at 10:11:39AM +0100, Thomas Richter wrote:
> > The subtest 'Leader sampling' some time fails on s390.
> > - for z/VM guest: Disable the test for z/VM guest. There is no
> >   CPU Measurement facility to run the test successfully.
> > - for LPAR: Use correct event names.
>
> This one fell thru the cracks, still applies cleanly and the extra logic
> affects only s390, applying to perf-tools-next,
>
> - Arnaldo
>
> > A detailed analysis follows here:
> > Now to the debugging and investigation:
> > 1. With command
> >        perf record -e '{cycles,cycles}:S' -- ....
> >    the first cycles event starts sampling.
> >    On s390 this sets up sampling with a frequency of 4000 Hz.
> >    This translates to hardware sample rate of 1377000 instructions per
> >    micro-second to meet a frequency of 4000 HZ.
> >
> > 2. With first event cycles now sampling into a hardware buffer, an
> >    interrupt is triggered each time a sampling buffer gets full.
> >    The interrupt handler is then invoked and debug output shows the
> >    processing of samples.  The size of one hardware sample is 32 bytes.
> >    With an interrupt triggered when the hardware buffer page of 4KB
> >    gets full, the interrupt handler processes 128 samples.
> >    (This is taken from s390 specific fast debug data gathering)
> >    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x0 count 0x1502e8
> >    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x1502e8 count 0x1502e8
> >    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x2a05d0 count 0x1502e8
> >    2025-11-07 14:35:51.977252  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x3f08b8 count 0x1502e8
> >    2025-11-07 14:35:51.977252  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x540ba0 count 0x1502e8
> >    2025-11-07 14:35:51.977253  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x690e88 count 0x1502e8
> >    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x7e1170 count 0x1502e8
> >    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x931458 count 0x1502e8
> >    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> >          perf_event_count_update event->count 0xa81740 count 0x1502e8
> >
> > 3. The value is constantly increasing by the number of instructions
> >    executed to generate a sample entry.  This is the first line of the
> >    pairs of lines. count 0x1502e8 --> 1377000
> >
> >    # perf script | grep 1377000 | wc -l
> >    214
> >    # perf script | wc -l
> >    428
> >    #
> >    That is 428 lines in total, and half of the lines contain value
> >    1377000.
> >
> > 4. The second event cycles is opened against the counting PMU, which
> >    is an independent PMU and is not interrupt driven.  Once enabled it
> >    runs in the background and keeps running, incrementing silently
> >    about 400+ counters. The counter values are read via assembly
> >    instructions.
> >
> >    This second counter PMU's read call back function is called when the
> >    interrupt handler of the sampling facility processes each sample. Th=
e
> >    function call sequence is:
> >
> >    perf_event_overflow()
> >    +--> __perf_event_overflow()
> >         +--> __perf_event_output()
> >                +--> perf_output_sample()
> >                     +--> perf_output_read()
> >                          +--> perf_output_read_group()
> >                                 for_each_sibling_event(sub, leader) {
> >               values[n++] =3D perf_event_count(sub, self);
> >               printk("%s sub %p values %#lx\n", __func__, sub, values[n=
-1]);
> >                                 }
> >
> >    The last function perf_event_count() is invoked on the second event
> >    cylces *on* the counting PMU. An added printk statement shows the
> >    following lines in the dmesg output:
> >
> >    # dmesg|grep perf_output_read_group |head -10
> >    [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a80917 (1)
> >    [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a86c7f (2)
> >    [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a89c15 (3)
> >    [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a8c895 (4)
> >    [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a8f569 (5)
> >    [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a9204b
> >    [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a94790
> >    [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a9704b
> >    [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a99888
> >    #
> >
> >    This correlates with the output of
> >    # perf report -D | grep 'id 00000000000000'|head -10
> >    ..... id 0000000000000006, value 00000000001502e8, lost 0
> >    ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (=
1) above
> >    ..... id 0000000000000006, value 00000000002a05d0, lost 0
> >    ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (=
2) above
> >    ..... id 0000000000000006, value 00000000003f08b8, lost 0
> >    ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (=
3) above
> >    ..... id 0000000000000006, value 0000000000540ba0, lost 0
> >    ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (=
4) above
> >    ..... id 0000000000000006, value 0000000000690e88, lost 0
> >    ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (=
5) above
> >
> > Summary:
> > - Above command starts the CPU sampling facility, with runs interrupt
> >   driven when a 4KB page is full. An interrupt processes the 128 sample=
s
> >   and calls eventually perf_output_read_group() for each sample to save=
 it
> >   in the event's ring buffer.
> >
> > - At that time the CPU counting facility is invoked to read the value o=
f
> >   the event cycles. This value is saved as the second value in the
> >   sample_read structure.
> >
> > - The first and odd lines in the perf script output displays the period
> >   value between 2 samples being created by hardware. It is the number
> >   of instructions executes before the hardware writes a sample.
> >
> > - The second and even lines in the perf script output displays the numb=
er
> >   of CPU cycles needed to process each sample and save it in the event'=
s
> >   ring buffer.
> > These 2 different values can never be identical on s390.
> >
> > Since event leader sampling is not possible on s390 the perf tool will
> > return EOPNOTSUPP soon. Perpare the test case for that.
> >
> > Suggested-by: James Clark <james.clark@linaro.org>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Tested-by: Jan Polensky <japo@linux.ibm.com>
> > Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index 0f5841c479e7..46b96d565680 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -260,7 +260,21 @@ test_uid() {
> >
> >  test_leader_sampling() {
> >    echo "Basic leader sampling test"
> > -  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
> > +  events=3D"{cycles,cycles}:Su"
> > +  [ $(uname -m) =3D "s390x" ] && {

This broke shell check for me:
```
In tests/shell/record.sh line 264:
 [ $(uname -m) =3D "s390x" ] && {
   ^---------^ SC2046 (warning): Quote this to prevent word splitting.

For more information:
 https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word split=
t...
```

I'll mail the fix.

Thanks,
Ian

> > +    [ ! -d /sys/devices/cpum_sf ] && {
> > +      echo "No CPUMF [Skipped record]"
> > +      return
> > +    }
> > +    events=3D"{cpum_sf/SF_CYCLES_BASIC/,cycles}:Su"
> > +    perf record -o "${perfdata}" -e "$events" -- perf test -w brstack =
2> /dev/null
> > +    # Perf grouping might be unsupported, depends on version.
> > +    [ "$?" -ne 0 ] && {
> > +      echo "Grouping not support [Skipped record]"
> > +      return
> > +    }
> > +  }
> > +  if ! perf record -o "${perfdata}" -e "$events" -- \
> >      perf test -w brstack 2> /dev/null
> >    then
> >      echo "Leader sampling [Failed record]"
> > --
> > 2.52.0
>
