Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1323F0AB1
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885681; cv=none; b=VMYLH+SILWwPnVFuZEacvtlEO88PiZkKiPrL1z44jqzC99BhhN5G2KlGlA/6T/mdjzgNWc65d7uMX77F88UVHdw2nxUwzXBUdN4o5Smn7eEXqVnuq3BN4ngADUbQVt0Od3dutQunuR8SEy+hD6OCw3dlWUxg5oqU0MLauMC6KIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885681; c=relaxed/simple;
	bh=JSDNMDdj6RBvtVEwzv907ejZyctuNojqTmmTQ8K/xx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TnPKpx2VuXSO7+aD8K6IyKUMosUpdxk3PcRII5Fe1LdEOcFwajpol2o7SvZqoVoVXgJfjKA4N9XFD2x91/ltumVFMVyTI67LH5YcDGaAt3IPzdmKm0gNcZkZAzJm1hF/Kcivqkdir/VA2jflNmsFoeRD+SxbHk4hEwrw6Dy4E8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffph252g; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffph252g"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so2656300b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776885669; x=1777490469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+/vNTslcH/cppWkVgQ41I/n1943Jgelp7T3O60OjFk=;
        b=ffph252gxQ9r/qrE3dsCr6k8bknSCKbmRtutCOi37Xbzc+baIYdn/mPFLB0LAnj3pr
         kl1l5x6oL3hy6NGF2tshXW5he6LP3tZpXj8yqdqV03MPsf0KR1Y4ZlalJJHfGdhoJo1U
         MiWjQ4GXdlDziDUATO24FNrd49b8gtuo9eFVXAKa4HmEaCyPFovZb/+7c2f6e3c1oD41
         4YQvxucR1Dw2A96sgzSX5hPhefaL6bH9i9Im+6dMjAH/0D+6mFdlIC3402o1bPcw8Opm
         zI8DGHXWhbDCwhPy+G+/nwkzu3OmPjPx2Fh70y+Sxsufxxqj2oWE/m1Pg1bqAPSCxMAz
         lK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776885669; x=1777490469;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+/vNTslcH/cppWkVgQ41I/n1943Jgelp7T3O60OjFk=;
        b=scxgqddIaoNPWZxvVoPMjU7ezwfiprxN+pEZcbTgYLZU3G18OuEGp5TeXdnmcuCGAF
         tiz39HAlMfJr0obHHmqDfu3RCRgJkKlLIVr1KNN/ucBVKDpblz36aatzspgLJF++pu8H
         cl3YKtnna4bl8ORZH2InGKwKOxNch3bbH8LPIofnUZ7CJYDjje8jodIJecrcwIElQoPp
         mhmJ/RTCeVIylXIxwiskVxbcSHPrYN784DKdnzPnphCyAR13X2oVeHN287z7oefy0ufc
         L0Qr+MEhMTsy1RD+DScI//4VtFOoCQi4XVCyGeSOfqrfeKPBh+6xAIHtt0DGdQCShUex
         JxXw==
X-Forwarded-Encrypted: i=1; AFNElJ+Y+mexxT0B2c5JpYFpX5OmWRsF3MUi8Awi8h1FbBY2SzYNu8IBlF9YiE/KYiUb+7bRV+2ba1+a/sLh9zbVxHZh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rnuVSIiQhgOsMksDdA68C0vRI0kfnOTXOoxBcptiwjfIKMdE
	egnKxLD2pgkbECPrsrrDYJ6d9U0x6qV+jSA9huIpu6GedqIcpihRAuy9+IJKeIZOQS1TKYVChFu
	Y7Rmkwg==
X-Received: from pfgg10.prod.google.com ([2002:a05:6a00:bd8a:b0:82f:bea1:81f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cd6:b0:82c:eafa:8875
 with SMTP id d2e1a72fcca58-82f8c82e889mr26141949b3a.2.1776885669168; Wed, 22
 Apr 2026 12:21:09 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:21:07 -0700
In-Reply-To: <0f0e5ba5-e6af-45ca-98b8-ea3bcbcede59@suse.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420091634.128787-1-jgross@suse.com> <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
 <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com> <aeYty5kU8Rp44USr@google.com> <0f0e5ba5-e6af-45ca-98b8-ea3bcbcede59@suse.com>
Message-ID: <aekfoxmXbsvYn5eB@google.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
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

On Wed, Apr 22, 2026, Juergen Gross wrote:
> On 20.04.26 15:44, Sean Christopherson wrote:
> > On Mon, Apr 20, 2026, J=C3=BCrgen Gro=C3=9F wrote:
> > > On 20.04.26 13:41, Peter Zijlstra wrote:
> > > > On Mon, Apr 20, 2026 at 01:35:12PM +0200, Peter Zijlstra wrote:
> > > > > On Mon, Apr 20, 2026 at 11:16:28AM +0200, Juergen Gross wrote:
> > > > >=20
> > > > > > - Use functions instead of macros for accessing MSRs, which wil=
l drop
> > > > > >     modifying variables passed as a parameter.
> > > > > >=20
> > > > > > - Eliminate multiple accessors doing exactly the same thing (e.=
g.
> > > > > >     rdmsrl() and rdmsrq()).
> > > > >=20
> > > > > So far so sane.
> > > > >=20
> > > > > > - Instead of having function names based on the underlying inst=
ruction
> > > > > >     mnemonics, have functions of a common name space (msr_*()).
> > > > >=20
> > > > > Not sure on this one. The whole msr_{read,write}_{safe,noser}() t=
hing is
> > > > > a royal pain. Also 'noser' reads to me as the noun that goes with=
 'to
> > > > > nose' [he that noses (around), like baker: he that bakes].
> > > > >=20
> > > > > I would much rather we just stick to the mnemonics here. All of t=
his
> > > > > really is about wrapping single instructions, no need to make it =
an
> > > > > unreadable mess.
> > > >=20
> > > > Also, the _safe suffix should just go away. All MSR accessors shoul=
d be
> > > > 'safe'.
> > >=20
> > > That would be fine by me, but I'd like to have some confirmation this=
 is
> > > really the route to go.
> >=20
> > I don't care what the suffix is called, or if there is even a suffix, b=
ut there
> > needs to be a way for the caller to communicate that it wants to handle=
 faults,
> > so that the "caller isn't going to handle a fault" case generates a WAR=
N if the
> > access does #GP.
>=20
> So this calls for keeping the *_safe() variants (keeping the name or not)=
.
>=20
> Using the label based error handling for those is a no-go IMHO, as we are
> trying to inline all MSR accesses as much as possible in order to avoid
> calls and the associated possible retpoline stuff (request by Thomas Glei=
xner
> IIRC). Doing the WARN inline will bloat code more than necessary, especia=
lly
> as we already have the central WARN today when fixing up the #GP.

I don't see why those two are mutually exclusive.  Keep the WARN in the exc=
eption
fixup code, and let the caller use a label (or not).  Label-based error han=
dling
should allow for the best of both worlds, as the RDMSR/WRMSR can be inlined=
, with
the (presumably) unlikely error path being shoved into an out-of-line, cold=
 path.

> In order not having to modify the logic for current use cases it would be
> best to keep the main interface of the *_safe() functions (let them retur=
n
> 0/-errno, use a pointer for the value returned by rdmsr_safe()).
>=20
> We can add label variants on top using macros.

But that's likely going to defeat the value of using labels.  Or at least m=
ake
it more difficult to generate optimal code.
