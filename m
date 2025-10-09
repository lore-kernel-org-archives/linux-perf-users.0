Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F192E8DFE
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018172; cv=none; b=sOPa7SOfCHtyGrllbaL9sePW4PWD8ijvrOXBYG0VRQw9QmOOHSmGZBjenwChSqpih44/Et8wTZlzPLHX+J2Bp3YxH7sJv2ZQ5YnRhJ2U/Ou910VEuGuh+Q2Ze1rdd8mueITOZVUkwYwI8xqybNFDhFAOw9N7n5SI6icpWYb22QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018172; c=relaxed/simple;
	bh=EScXsTHU6VFhObHw0rXYp2k1TqD7515U/semhoJORb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckNfOkzN1wU9zJNtuXgiHHHg3GglvKTfycHVoFrQAG1Ld2M6GZck1rW7vLFCdjCHBIB+3hyvW13K6gF7hq4TUpfkj913GMoaCKDrIAIrE/2gEPNsJ+lRXi5K1+5YjvCz4cLZ1L3ph4QEj/xiRhRzZSXuy41LMN/oifPi3f1w9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBnd+4t9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBnd+4t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760018168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61nvDrMiv9e6uYVml7mlkV/9Dfw522WLdNan3L9lqUk=;
	b=gBnd+4t98I4BDSftvhLKOoNmVJffP9ijoQWSQuzQntGR9Tdn7KtsZgYhfM6STFKiBqfIIo
	F4IMruBLkxTp0G/+hOpxxu6YIci8ZXVR2qxt/SwH3hw1PM3nUms0XNk8pmpCPKylKJoBWm
	/A6+OjoXIxYyfoebTjCQuS7G9PxykgU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-JqRkpt-_MfC2_enCHhFEbQ-1; Thu, 09 Oct 2025 09:56:06 -0400
X-MC-Unique: JqRkpt-_MfC2_enCHhFEbQ-1
X-Mimecast-MFC-AGG-ID: JqRkpt-_MfC2_enCHhFEbQ_1760018165
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5906653da4cso545974e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 06:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018165; x=1760622965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61nvDrMiv9e6uYVml7mlkV/9Dfw522WLdNan3L9lqUk=;
        b=oKlxB+abWC4idHgnnGh9Ao7TfJ3nOeMJ0aHjxVixh+U3rNva/fayKFxBoy2vR5Lnzf
         qXO7NtOzYSMFgZ/pblmEgYtgdmVaKiaRe82kklthuLV+oT3v/Ozz7u8Sz5TwRzmS0B6L
         Rt1kjF1B9VexLl22KAWieSHhAk8qY9gx8Ic8WILgvboocAXDBHQagP6fBWYm738LIlrI
         0B8l7WcQetziG5k2Nyt60PI8PUfe3mGNqMrHF3TK+PKKOXCByj87j1zuvp4f4u1wlx4Z
         3QHKtlc/JWO7vCv5FoN3sDxKBuN2Or0IQNj5Pf1OKDL9++G99XWKh4BLP7TIdIDW8Jyt
         VGhw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ge7gKkfK/1f/ZocUxgxFypvT58Q/E3mUELrgtx51d+/hdk4xI4IEFtAP3SeexREdOPTfh820UyuUWdVK6oea@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqMPJeQD5i8QLXJ7kzABL2C/qdOmKh+BBBi+sLoN7SgxJuM45
	bb/roI6pV+Y/beWkK6RuffWbvPJ4hnFGM1qMx25mcvje/VJ11LHHohLJ+tECEz7/fj2Zru9G4HW
	B+E8hglwbq9WDiWETJ8C09fGnZecqJ2XDTlpJNTaWSKVy6PBkvqj0OsWc2aDNUzMZWuxPHjd1W0
	PLSSnFhChOH8XArYc211ZysmPHvI4Wj4pCfUo3m+jDOkNtjw==
X-Gm-Gg: ASbGncsglPb+vwggCbPgb146CEANOseIZOEqQs2Tv08mB0EfUuohZVStoTor5BlTm+4
	7k0v+37Y0ZVNznrBNXy7bLdnmlrLwWBJwWrqNs125rvBZ5+QDPNX1RkQFcq4ryp7yXSVLjTyo3N
	IcjZSwKilvQatxciC/MXuupo40
X-Received: by 2002:a05:6512:234d:b0:577:f11f:7512 with SMTP id 2adb3069b0e04-5906d8ee9d5mr2248496e87.31.1760018165091;
        Thu, 09 Oct 2025 06:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjrcFQcFVCtaOV7YS222QoKgjyUeoi5ZUqSbi17Kt1fqyl5gWq79SWlpWtTplIBS/QPhauY+jbnDZCzFaqxF8=
X-Received: by 2002:a05:6512:234d:b0:577:f11f:7512 with SMTP id
 2adb3069b0e04-5906d8ee9d5mr2248469e87.31.1760018164536; Thu, 09 Oct 2025
 06:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001195047.541745-2-ashelat@redhat.com> <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com> <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com> <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
In-Reply-To: <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 9 Oct 2025 14:55:53 +0100
X-Gm-Features: AS18NWD4gxZiBrk1BWq2Yj2Y5Pfd2NYXpdCTHITCOVyOC_04816aXp87AdxMVPo
Message-ID: <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>, mpetlan@redhat.com, 
	acme@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, dapeng1.mi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested on a new arm machine and I'm getting a similar issue as
Thomas, but the test fails every 20 or so runs and I'm not getting the
issue that I previously mentioned.

Running test #15
 10bc60-10bcc4 g test_loop
perf does have symbol 'test_loop'
 10c354-10c418 l brstack
perf does have symbol 'brstack'
Basic leader sampling test
Basic leader sampling test [Success]
Invalid Counts: 1
Valid Counts: 27
Running test #16
 10bc60-10bcc4 g test_loop
perf does have symbol 'test_loop'
 10c354-10c418 l brstack
perf does have symbol 'brstack'
Basic leader sampling test
Basic leader sampling test [Success]
Invalid Counts: 1
Valid Counts: 27
Running test #17
 10bc60-10bcc4 g test_loop
perf does have symbol 'test_loop'
 10c354-10c418 l brstack
perf does have symbol 'brstack'
Basic leader sampling test
Leader sampling [Failed inconsistent cycles count]
Invalid Counts: 8
Valid Counts: 28

Initially I thought it was the throttling issue mentioned in the
comment in test_leadership_sampling, but there's another thread says
that it's fixed:
https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.intel=
.com/


On Thu, Oct 9, 2025 at 2:43=E2=80=AFPM Anubhav Shelat <ashelat@redhat.com> =
wrote:
>
> I tested on a new arm machine and I'm getting a similar issue as Thomas, =
but the test fails every 20 or so runs and I'm not getting the issue that I=
 previously mentioned.
>
> Running test #15
>  10bc60-10bcc4 g test_loop
> perf does have symbol 'test_loop'
>  10c354-10c418 l brstack
> perf does have symbol 'brstack'
> Basic leader sampling test
> Basic leader sampling test [Success]
> Invalid Counts: 1
> Valid Counts: 27
> Running test #16
>  10bc60-10bcc4 g test_loop
> perf does have symbol 'test_loop'
>  10c354-10c418 l brstack
> perf does have symbol 'brstack'
> Basic leader sampling test
> Basic leader sampling test [Success]
> Invalid Counts: 1
> Valid Counts: 27
> Running test #17
>  10bc60-10bcc4 g test_loop
> perf does have symbol 'test_loop'
>  10c354-10c418 l brstack
> perf does have symbol 'brstack'
> Basic leader sampling test
> Leader sampling [Failed inconsistent cycles count]
> Invalid Counts: 8
> Valid Counts: 28
>
> Initially I thought it was the throttling issue mentioned in the comment =
in test_leadership_sampling, but there's another thread says that it's fixe=
d:
> https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.int=
el.com/
>
>
> On Wed, Oct 8, 2025 at 12:24=E2=80=AFPM James Clark <james.clark@linaro.o=
rg> wrote:
>>
>>
>>
>> On 08/10/2025 11:48 am, Thomas Richter wrote:
>> > On 10/7/25 14:34, James Clark wrote:
>> >>
>> >>
>> >> On 07/10/2025 6:47 am, Thomas Richter wrote:
>> >>> On 10/2/25 15:39, Anubhav Shelat wrote:
>> >>>> On Oct 1, 2025 at 9:44=E2=80=AFPM, Ian Rogers wrote:
>> >>>>> If cycles is 0 then this will always pass, should this be checking=
 a
>> >>>> range?
>> >>>>
>> >>>> Yes you're right this will be better.
>> >>>>
>> >>>> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>> >>>>> Can we use a larger range to allow the test to pass?
>> >>>>
>> >>>> What range do you get on s390? When I do group measurements using "=
perf
>> >>>> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the te=
st I
>> >>>> always get somewhere between 20 and 50 cycles difference. I haven't=
 tested
>> >>>> on s390x, but I see no cycle count difference when testing the same=
 command
>> >>>> on x86. I have observed much larger, more varied differences when u=
sing
>> >>>> software events.
>> >>>>
>> >>>> Anubhav
>> >>>>
>> >>>
>> >>> Here is the output of the
>> >>>
>> >>>    # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>> >>>    # perf script | grep brstack
>> >>>
>> >>> commands:
>> >>>
>> >>> perf 1110782 426394.696874:    6885000 cycles:           116fc9e brs=
tack_bench+0xae (/r>
>> >>> perf 1110782 426394.696875:    1377000 cycles:           116fb98 brs=
tack_foo+0x0 (/root>
>> >>> perf 1110782 426394.696877:    1377000 cycles:           116fb48 brs=
tack_bar+0x0 (/root>
>> >>> perf 1110782 426394.696878:    1377000 cycles:           116fc94 brs=
tack_bench+0xa4 (/r>
>> >>> perf 1110782 426394.696880:    1377000 cycles:           116fc84 brs=
tack_bench+0x94 (/r>
>> >>> perf 1110782 426394.696881:    1377000 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.696883:    1377000 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.696884:    1377000 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.696885:    1377000 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.696887:    1377000 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.696888:    1377000 cycles:           116fc98 brs=
tack_bench+0xa8 (/r>
>> >>> perf 1110782 426394.696890:    1377000 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.696891:    1377000 cycles:           116fc9e brs=
tack_bench+0xae (/r>
>> >>> perf 1110782 426394.703542:    1377000 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.703542:   30971975 cycles:           116fb7c brs=
tack_bar+0x34 (/roo>
>> >>> perf 1110782 426394.703543:    1377000 cycles:           116fc76 brs=
tack_bench+0x86 (/r>
>> >>> perf 1110782 426394.703545:    1377000 cycles:           116fc06 brs=
tack_bench+0x16 (/r>
>> >>> perf 1110782 426394.703546:    1377000 cycles:           116fc9e brs=
tack_bench+0xae (/r>
>> >>> perf 1110782 426394.703547:    1377000 cycles:           116fc20 brs=
tack_bench+0x30 (/r>
>> >>> perf 1110782 426394.703549:    1377000 cycles:           116fc9e brs=
tack_bench+0xae (/r>
>> >>> perf 1110782 426394.703550:    1377000 cycles:           116fcbc brs=
tack_bench+0xcc
>> >>>
>> >>> They are usual identical values beside one or two which are way off.=
 Ignoring those would
>> >>> be good.
>> >>>
>> >>
>> >> FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test =
passed every time.
>> >>
>> >> Are we sure there isn't some kind of race condition or bug that the t=
est has found? Rather than a bug in the test?
>> > There is always a possibility of a bug, that can not be ruled out for =
certain.
>> > However as LPARs on s390 run on top of a hypervisor, there is a chance=
 for the
>> > linux guest being stopped while hardware keeps running.
>> >
>>
>> I have no idea what's going on or how that works, so maybe this question
>> is useless, but doesn't that mean that guests can determine/guess the
>> counter values from other guests? If the hardware keeps the counter
>> running when the guest isn't, that sounds like something is leaking from
>> one guest to another? Should the hypervisor not be saving and restoring
>> context?
>>
>> > I see these runoff values time and again, roughly every second run fai=
ls with
>> > one runoff value
>> >
>> > Hope this helps
>> >
>>
>> That may explain the issue for s390 then, but I'm assuming it doesn't
>> explain the issues on Arm if the failures there aren't in a VM. But even
>> if they were in a VM, the PMU is fully virtualised and the events would
>> be stopped and resumed when the guest is switched out.
>>
>> James
>>

