Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE42DFA20
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305375; cv=none; b=tnYH94O5zhL41fNicG3iJJaaKhq10Ua7MyQMerLzHqdteJsmNzeA/Rb2USIUNvq9y4uQHVOlkeAA3w7BpGhgHbPbby3jpMfW73ir4yhKUJANZFceZAouJGl2T7tSo9mg0O8soL+yjY+k4sbQt1uYOYGAX3B6NST6kswd5iU5n+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305375; c=relaxed/simple;
	bh=p9QHb3/hnKvWZKIXq5Fvg8ndjho6Otu5IGRMFihrTnE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JAirlTEdVgZcNFam06EN6sbJYOunp5jZQhmUio0GigCftCChGcPoKJbFWipXWRodsqcDRR+C/NBwussYzHLSVlwRBNtBCPlY5THDp+fZLXzLflj+u5vZmqR43URv0hUSYmczCmxL+BbI3V1TTb7S8NDquXvQjj40vhzU8g7E/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCAHmmTL; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCAHmmTL"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so25047425ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751305373; x=1751910173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImVsekYPJx+C4taW0n4SjIxS/mjgVChiR4QEyhkYP6w=;
        b=LCAHmmTLlc7LAL9IhX3jzPcQ2WgcZGwwRiWm0xZqvthjUhf9xOGL3xxTV0q5Y15+3z
         jvgDdqoloX97kyUqiC114rGfNYt8i8hYUDZsVOg44g8zsers9SA7WItxZdcuQAMTeBS8
         caDBoOK9ePCqQ8SaACgl9PKgpCMdYcFwllcxDTdXHRyzNmJCLPdEa+jqYPV41FJ7LHDH
         udAsChdeeY+kG61aHeWfqL8rjP9rZOlLinOxZoYqK49gI56wiJ/vGsSJYU+Ciqy+Y9KX
         sOSgF29NYSEpQNpjqG0VUYPAbY0XrVNKCufua4aislkVEu69wRl8MF1qPmEEzSTnFcuQ
         tuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751305373; x=1751910173;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImVsekYPJx+C4taW0n4SjIxS/mjgVChiR4QEyhkYP6w=;
        b=rAjka8KgXCS3WAvOhu6QD7r3ppMaRfTxMj86kS/EyGu7Yrv735wN7Y03KHbgtt6yAD
         WNsUDeam7WcXD0wLsJEZDcW7qPNUS9UtYP92aMbMXOz2o3pvIdOx8qmN+RoSq77W50EV
         94tnQsf+fPiNlKNzO1g+olI4lWpFEqPq2qqqTdlljrFggHsexTakHlv/WTYyGzLlrDmn
         BKuVARtSNe5vkqb5RPppgEU1U3u0haArLuOC0HKqHuq41qVWawMu74ZmjGsp/3GrJMWX
         F+c6kFcLIlywu7UD3ayzT1SQ5R2Qe1LTqAfsrJH6LsE5qc86fB+1qyEi+K/aUqUmhGm4
         +qTg==
X-Forwarded-Encrypted: i=1; AJvYcCUT8csb41DU0p3Z9iGxWt5s2u0QltYVfszOVyKcUnF+BM8i2654bZEzXIyRfsXBYTwIwOqHoW5kZcJh+usVayjy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi00TzvZ+kPjcPbq/qbZ8gSsyW1jcIFKYyybFwDwdQoGe6zI4i
	ueny3dDpPVwCMKwKh3iTA/jNy0/+eGcxr91vxepI4pb36GmRqGDMr+k0rzaQ0x5VHplcvp++jvA
	U+Les4BnARGh0wEGy61tcVLlZ5g==
X-Google-Smtp-Source: AGHT+IF9nPhO3RxMhccQIRyozfA0RZ1o/n5EUvH0ZvYssIkGUujSgAHo5a6XMuPc/RTrNVL6l8tA4e7hfnuN+vQINg==
X-Received: from ilbbc5.prod.google.com ([2002:a05:6e02:85:b0:3df:2ece:7197])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3c85:b0:3dd:b808:be59 with SMTP id e9e14a558f8ab-3df4acc61ecmr180573955ab.21.1751305372798;
 Mon, 30 Jun 2025 10:42:52 -0700 (PDT)
Date: Mon, 30 Jun 2025 17:42:52 +0000
In-Reply-To: <aF8FPTupC_VnAldN@linux.dev> (message from Oliver Upton on Fri,
 27 Jun 2025 13:55:25 -0700)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt4ivx86sj.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 02/22] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: ben.horgan@arm.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, mizhang@google.com, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oliver.upton@linux.dev> writes:

> On Fri, Jun 27, 2025 at 08:45:38PM +0000, Colton Lewis wrote:
>> Hi Ben. Thanks for the review.

>> Ben Horgan <ben.horgan@arm.com> writes:

>> > Hi Colton,

>> > On 6/26/25 21:04, Colton Lewis wrote:
>> > > There's no reason Enums shouldn't be equivalent to UnsignedEnums and
>> > > explicitly specify they are unsigned. This will avoid the annoyance I
>> > > had with HPMN0.
>> > An Enum can be annotated with the field's sign by updating it to
>> > UnsignedEnum or SignedEnum. This is explained in [1].

>> > With this change ID_AA64PFR1_EL1.MTE_frac would be marked as unsigned
>> > when it should really be considered signed.

>> > Enum	43:40	MTE_frac
>> > 	0b0000	ASYNC
>> > 	0b1111	NI
>> > EndEnum

>> Thanks for the explanation. I made this a separate commit because I
>> considered people might object and HPMN0 is already an UnsignedEnum in
>> my previous commit.

>> Do you think it would be a good idea to make plain Enums signed by
>> default or should I just remove this commit from the series?

> It is presumptive to associate a sign with an enumeration. Generally
> speaking, the only fields that can do signed / unsigned comparisons are
> the Feature ID register fields.

> So please drop this and only keep the change for HPMN0.

Done.


> Thanks,
> Oliver

>> > > Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> > > ---
>> > >    arch/arm64/tools/gen-sysreg.awk | 1 +
>> > >    1 file changed, 1 insertion(+)

>> > > diff --git a/arch/arm64/tools/gen-sysreg.awk
>> > > b/arch/arm64/tools/gen-sysreg.awk
>> > > index f2a1732cb1f6..fa21a632d9b7 100755
>> > > --- a/arch/arm64/tools/gen-sysreg.awk
>> > > +++ b/arch/arm64/tools/gen-sysreg.awk
>> > > @@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" ||
>> > > block_current() == "SysregFields
>> > >    	parse_bitdef(reg, field, $2)

>> > >    	define_field(reg, field, msb, lsb)
>> > > +	define_field_sign(reg, field, "false")

>> > >    	next
>> > >    }

>> > Thanks,

>> > Ben

>> > [1]
>> >  
>> https://lore.kernel.org/all/20221207-arm64-sysreg-helpers-v4-1-25b6b3fb9d18@kernel.org/
