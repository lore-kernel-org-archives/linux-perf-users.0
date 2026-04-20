Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177913B961D
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692687; cv=none; b=OWxIHMA3rmbAUUjXbv4LmFLJLuooCdbVEHPwL/z7HIVc+FS8wWMeAPRSQVQd0++OrmjCQvdGAPUie+HPRSktEIegzhxXjRtBZhr4ctC/xlZYjpvzJcApZzezsOl1TqgnBThKaYIlhCERxgXNv9XxS2Y0lnQxpZI0z00a3mHG9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692687; c=relaxed/simple;
	bh=Sb9N6ZxOpG6EYjxD6uzTvGIWgwlDE5T3Exa+z8je0Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0gGlriwssTJMRBheHCfK1Hbq70L9Z5K9gDMJXzl55hDDpQ9XvJxkImUzV58jZXE4ergG6GdSwm2ZBup4cCGmUGqHRl1tdAsMtJL2bHceFbY0b6uzUUPjlwbb1lYzzg3nUQ6O7qLCx5Vtm9ishofq+MoZ1Ojg+zd0/a3tn9NaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tM6o+DUc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tM6o+DUc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f504f6b75so1661104b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776692685; x=1777297485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sudcedv7bb6KmmokVjUGDtJIDuJ5fsha2RP++MmI/64=;
        b=tM6o+DUcUMJzSLJ/XOoDOIJk84847spcLhdH1DnBtK5UXlUijFWO9ZdJgURQhdpnwE
         MQpoNiVobJ/ErOguT9vWaeIjYzBv4eN4x9NwFCf8Y8+lAHcdOFclO5swsRDvM05Tearj
         Z8s8eJhd6KdmGuSWcJLX+w2m0inK6+BjNvwsgYW4+Z9eNuFZdViB1JrbK/KWgZiBRw+U
         fowlV75Ea2NfqRzezs01uDfyKlxjQJ6VR0kKGj25HrqEsdxegdNu7i1+BChaLQOg7/f9
         8nCXflUBr7IRzQCJONlshnJZFZH0CS/WeCqounYyCjnvgaH+9m2GuFrlHskV0mKe42jx
         nmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692685; x=1777297485;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sudcedv7bb6KmmokVjUGDtJIDuJ5fsha2RP++MmI/64=;
        b=MdFgT267r+PqAsfkInrTjGs/T5cPzdI2UuW1y5HZp7SndFiIX2+UJ59WR5yehKJXDg
         DWtWc7qjinV0oc+FUbHL/bWGVtxTzQThCs2QUzrp3nbJk9IxQKsJfs4TqHJThnh+AcyB
         ZwdDtDRP7zA/si9FvOVOI036bRQtz/gX2OxLJqwOnATbZ7xPwTyUTmaHRHZJUWDUfXOH
         J8OZu9Ivhb2JoQ1RcYi0Trxta4i5iBX+2+L5N0VEfJWH2Bpljt2Z6foyivRrztjW1wTD
         BUdxpyGlrOhqcJMICP7xkVX/3t0G6gpazov2/mdCCC+ZyU2KRnoL/Qp28uaOV6pb5D7a
         ld7A==
X-Forwarded-Encrypted: i=1; AFNElJ/nyHKpCTZt0QxlOHr8F3ZLLSx/jxYIEGovpirXP7OZFx6/GzYmeRilZBK7NZHRoUWgOYkKPZ2V1pTYkVkkOvfh@vger.kernel.org
X-Gm-Message-State: AOJu0YywRQiR+IpnEtSVIluE5A6L2YU7PXV42IgJ0/FyJl01PG7T/nco
	jruu3198RbTYxtvMAJtvd0vCO7Btr0ge58VXXqQ5VwPeAiKTDsfmgbes4jxbY9Pet4SKHKjgGsu
	lYHaP4g==
X-Received: from pfgs39.prod.google.com ([2002:a05:6a00:17a7:b0:82c:e9cd:a73f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3315:b0:81f:ac81:d597
 with SMTP id d2e1a72fcca58-82f8c2a9ed7mr12914323b3a.0.1776692685198; Mon, 20
 Apr 2026 06:44:45 -0700 (PDT)
Date: Mon, 20 Apr 2026 06:44:43 -0700
In-Reply-To: <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420091634.128787-1-jgross@suse.com> <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net> <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com>
Message-ID: <aeYty5kU8Rp44USr@google.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=" <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026, J=C3=BCrgen Gro=C3=9F wrote:
> On 20.04.26 13:41, Peter Zijlstra wrote:
> > On Mon, Apr 20, 2026 at 01:35:12PM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 20, 2026 at 11:16:28AM +0200, Juergen Gross wrote:
> > >=20
> > > > - Use functions instead of macros for accessing MSRs, which will dr=
op
> > > >    modifying variables passed as a parameter.
> > > >=20
> > > > - Eliminate multiple accessors doing exactly the same thing (e.g.
> > > >    rdmsrl() and rdmsrq()).
> > >=20
> > > So far so sane.
> > >=20
> > > > - Instead of having function names based on the underlying instruct=
ion
> > > >    mnemonics, have functions of a common name space (msr_*()).
> > >=20
> > > Not sure on this one. The whole msr_{read,write}_{safe,noser}() thing=
 is
> > > a royal pain. Also 'noser' reads to me as the noun that goes with 'to
> > > nose' [he that noses (around), like baker: he that bakes].
> > >=20
> > > I would much rather we just stick to the mnemonics here. All of this
> > > really is about wrapping single instructions, no need to make it an
> > > unreadable mess.
> >=20
> > Also, the _safe suffix should just go away. All MSR accessors should be
> > 'safe'.
>=20
> That would be fine by me, but I'd like to have some confirmation this is
> really the route to go.

I don't care what the suffix is called, or if there is even a suffix, but t=
here
needs to be a way for the caller to communicate that it wants to handle fau=
lts,
so that the "caller isn't going to handle a fault" case generates a WARN if=
 the
access does #GP.

If we make rdmsr() return a u64, then we can vacate __rdmsr() and use that =
for
the version with a label.

E.g. something like this if we provide both the out-param and label variant=
s:

static __always_inline u64 rdmsr(u32 msr)
{
	<this version WARNs on fault>
}

#define __rdmsr(msr, label)
({
	u64 __val;

	<this version jumps to @label on fault>
	__val;
})

static __always_inline int rdmsr_p(u32 msr, u64 *val)
{
	<this version zeros *val on fault and returns 0/-errno>
}
