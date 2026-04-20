Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADF3A3E78
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692181; cv=none; b=cSxDVIbHeG+h4MZzDcmgxzoHwWfc0P0tHGQNXXkQKER6xrnrTF2eUX9GzYxSlEZW3rp0+F2wmie7oHorJgb3ZBGNSPLjeuVegAXd0HwQQSfcokEBCDE97K0cJmwFbmYK23jbqrU4pPB+E+FsOnSfoqm34hWdEPIzUQmIXEP9wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692181; c=relaxed/simple;
	bh=/T9u1OBu3RnPmdffOOjLVw5WQiCkhk8xPbI9fHnomtk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GDg3g/+kxu4wMOiQFOjNkrWdlAPx3SzNu/7/9YFc7njeeGFrTL4G79NDXBL24F29OaQIXEcs98f0+xLJMvgxHRh+uGhKtayoac19TW5Ih1LJMdJ5jDPt+Vc7N6wMxcUuHRfnxGQHUuuj/gzhFhaVmeO9oXTY4ffCRMhojZm1MwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDmE0a1L; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDmE0a1L"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c798ace3d02so370033a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776692179; x=1777296979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2icCSdhtFYr6JZTgZwrOHg4sAd4pPViB0mMNXcuFYXI=;
        b=KDmE0a1LvSu7cccqq4faL+8E+sMwwG+HJOn6hLcTbOQUaV3A0ZX7lfNKNE/vf+LTWX
         J3fUYSY+XxT7ACFuiM4s9UAg1SOox7+WDCoGlkG+qaGe7GZFmMBu6vu4QlCt4ZMeWr8b
         jaliuI+iJUUoTbyPUyuPmcr2otj8nzOZOjPgDpDg65TYw5Cxmcj9+DvHX7f9qV8vNZO2
         PpkDN/HlcdKTpRgrHD8xgMCDSFm90IsgkujcIwtwtQoKuAyR52WkDsmIfsZVZrOqI+Nj
         kbzrb22+QBFW63bR/7weXW7P1PbrU8io8VGeA4VciExRC+709O3zbwMGAkNVAe9DbwEV
         bnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692179; x=1777296979;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2icCSdhtFYr6JZTgZwrOHg4sAd4pPViB0mMNXcuFYXI=;
        b=KGuaZuJmaWQWMXZINFzieOTTbh7I5Rc8b1yILV/cdeFw++HNc0oz+ZIWA6mdMrjNVJ
         EHZwE8zaGvscRJGhFXvcMN8xxnOduxQnIKDdbCsyOUBkjx9+QUZpXOQOv4KoYt5W3G52
         RmSmOwlo90eYBpCj84dK1XGqLD0otUrD3pwAFsMZ/P8MY+3lIfLkCE2tbFcSDNkYWK6l
         9YZW7oqxAcMunLutSnQxV4NnE0EFMh4zV0xRaEcF8zVOB2Rqqt1mqKEERnBZQ5+Vc1lS
         2MGmqHNmdVoIbO3XlWBfotTFbBT4rBURLlkvIKjfpdI1YLyqiQPY/PIJe+2FF5vTp+6L
         LmJA==
X-Forwarded-Encrypted: i=1; AFNElJ+9sWnv5T2MGsFCD5yRvnS31j5faZkcdMiGnB59nMUVFIv7U9+ehEESUg95n9OFgdb2661JrYt9Wp4/JaKSwdDn@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+pcAqqmZrku1u5pZoNLTBG81XyjcweUftvMOjc5JlYqfjzjW
	Zj5J+DGyJpcVkl+nSrlga17BXV6R7foz4y8DPDlze6G9d88sAZZ8v3oiglFzm7QyyC7T12JwVuw
	2zma9JA==
X-Received: from pgch35.prod.google.com ([2002:a05:6a02:50a3:b0:c79:83b3:cdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:eec9:20b0:398:6ea8:21d2
 with SMTP id adf61e73a8af0-3a08d732f3cmr8611429637.19.1776692179130; Mon, 20
 Apr 2026 06:36:19 -0700 (PDT)
Date: Mon, 20 Apr 2026 06:36:17 -0700
In-Reply-To: <20260420131020.GI3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420091634.128787-1-jgross@suse.com> <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com> <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
 <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com> <20260420131020.GI3102624@noisy.programming.kicks-ass.net>
Message-ID: <aeYr0dMxDs7-2VzO@google.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=" <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
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

On Mon, Apr 20, 2026, Peter Zijlstra wrote:
> On Mon, Apr 20, 2026 at 03:01:31PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> > On 20.04.26 14:33, Peter Zijlstra wrote:
> > > The only interesting question is what to do with the 'safe' aspect. T=
he
> > > instruction takes a fault, we do the extable, but rdmsr() above alrea=
dy
> > > has a return value, so that can't be used.
> > >=20
> > > One option is to, like uaccess and the proposed overflow, is to use
> > > labels like:
> > >=20
> > > 	val =3D rdmsr(msr, label);
> > >=20
> > > And then, even though the wrmsr*() functions have the return availabl=
e,
> > > do we want to be consistent and do:
> > >=20
> > > 	wrmsr(msr, val, label);
> > > 	wrmsrns(msr, val, label);
> > >=20
> > > rather than be inconsistent and have them have a boolean return for
> > > success.
> > >=20
> > > What am I missing?
> >=20
> > I like the idea to use a label, but this would result in the need to us=
e
> > macros instead of functions. So this is trading one aspect against anot=
her.
> > I'm not sure which is the better one here.
> >=20
> > An alternative might be to switch rdmsr() to the interface used by rdms=
r_safe(),
> > i.e. let all the accessors return a bool for success/failure and use a =
pointer
> > for the MSR value in rdmsr().
>=20
> Yes, either way around works. Perhaps that is 'better' because mostly we
> don't care about the faults since we've checked the 'feature' earlier.
>=20
> Its just inconvenient to have return in argument crud, but whatever ;-)

Why not do both?  There are definitely flows where one is obviously more re=
adable
than the the other.  E.g. if the RDMSR is being fed right back into a WRMSR=
, the
out-param version requires a local variable.  And it can be visually jarrin=
g if
the surrounding code is a bunch of "val =3D xyz" expressions.

On the other hand, the outparam with a 0/-errno return can be very useful t=
oo,
e.g. when wrapping the RDMSR in a multi-expression if-statement:

	if (rdmsrq_safe(MSR_IA32_CR_PAT, &host_pat) ||
	    (host_pat & GENMASK(2, 0)) !=3D 6) {

As it avoids having to assign with '=3D' in the if-statement, and avoids ha=
ving to
define a label.

It would be trivial to add a wrapper around the label version, the hard par=
t is
just the naming :-)
