Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92E1A71F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jRZ3KX0"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036D9E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 09:29:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a507986ed6so82541547b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696868992; x=1697473792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqY7KKcbXF3xUWGU4wT3dqp32k/36wxckx8YA28nXEY=;
        b=2jRZ3KX0B6IOGCxhNIVzbudTqLC/TNY8so4YAsUR7e2aLoZIPaCh7GssWxPmwwCO9t
         bS5qPjefeQcYibCCakz9dV+ZZHAKOqbV4qLtQn+c/klJyb/p7tUj/FM87VlD6YDFTsls
         ogn7NScS0YiE0/nFbdt3Ik2Y7b4NSfHAvGBPVEw5p9FCQf5xEo0iFxtUkw4ohpXFUENE
         +L956OtXXgljTFYVdB/uuIYoU16/m969JP4MxC6GWsR+0s57BCmJoedmUrWg3uSkY0ZW
         o5YlBNw9ByuTDMUAGQ2ufXeEKnNk09nuUUXxuP5s9wXXiD+q7tJJvjlTAyuC9C9SjVa8
         hJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868992; x=1697473792;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rqY7KKcbXF3xUWGU4wT3dqp32k/36wxckx8YA28nXEY=;
        b=qb3bzpSmbolptv5ssry5rVMdfRMMzfEWfMN4wBfbbCXSMgarjNUwgztB+lWUfDyZnV
         y1YqOWXtLZuVlpyHukhnMfsUFxTnv9SNhEqzoXqAZ1ubImiTwgdj8usAKC180EDl2axz
         VZBAMKwr39b61vTkD0AVd0jXBGtGaB2muUo9ICYSgqynerJVY1pEYXOick3DoknO5m01
         07wnl2UQCocLBdAHiJ9nZFJBLlV3h3xq0F+fkEqu5RV8eTGhnO5GvrENxuTE6TQ3aXbV
         zAJ1pbYxQ/cqXpKLtH6KPTOVkLgGSo1H1Pkf7RivxDNlXMuC24meoQu0Mx9eazs/9y6c
         EhmQ==
X-Gm-Message-State: AOJu0YzacgQtCZW8PdGvC65y0oJCotsOA4d4fBT9eSdK9a0bEFink4nX
	LSpEJOmLya17HvmfscSBygGxOomIyOQ=
X-Google-Smtp-Source: AGHT+IFczvQ2UyFbt9J+8jf9SjSk/hCP3ruErRSBZVfUfVJwQHUAJnIuKo5VnY3DDHB7QaZzSZ3tTfpjOD8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ae26:0:b0:5a7:b8d1:ef65 with SMTP id
 m38-20020a81ae26000000b005a7b8d1ef65mr6581ywh.3.1696868991924; Mon, 09 Oct
 2023 09:29:51 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:29:50 -0700
In-Reply-To: <20231007203411.GA8085@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZSGpl_hT23B6ix0M@mainframe> <20231007203411.GA8085@noisy.programming.kicks-ass.net>
Message-ID: <ZSQqfr96SfZM_OEk@google.com>
Subject: Re: [PATCH] perf/x86/p4: Fix "Wunused-but-set-variable" warning
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lucy Mielke <lucymielke@icloud.com>, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023, Peter Zijlstra wrote:
> On Sat, Oct 07, 2023 at 08:55:19PM +0200, Lucy Mielke wrote:
> > This fixes a compiler warning when compiling an allyesconfig with W=3D1=
:
> > warning: variable =C2=B4high=C2=B4 set but not used [-Wunused-but-set-v=
ariable]
>=20
> What compiler and what .config?
>=20
> > Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
> > ---
> >  arch/x86/events/intel/p4.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
> > index 35936188db01..69aaf7c0f340 100644
> > --- a/arch/x86/events/intel/p4.c
> > +++ b/arch/x86/events/intel/p4.c
> > @@ -1366,7 +1366,7 @@ static __initconst const struct x86_pmu p4_pmu =
=3D {
> > =20
> >  __init int p4_pmu_init(void)
> >  {
> > -	unsigned int low, high;
> > +	unsigned int low, __maybe_unused high;
> >  	int i, reg;
> > =20
> >  	/* If we get stripped -- indexing fails */
>=20
> Right after this we have:
>=20
> 	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
>=20
> which should get high unconditionally used. If there's a problem then
> it's probably inside that rdmsr macro.

rdmsr() writes to "high", but nothing ever reads from high.  FWIW, I would =
_love_
for rdmsrl() to have return semantics, e.g. to be able to do:

	low  =3D (u32)rdmsrl(MSR_IA32_MISC_ENABLE);

or even

	if (!(rdmsrl(MSR_IA32_MISC_ENABLE) & BIT(7)))
