Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B584A40;
	Tue,  2 Jul 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946766; cv=none; b=WCRjrNt8u4VYcCzVr5wyo492LKMuiXN02xtOQmVJoLCWBmp6wd72rNYo8WUIejZ7nf39AIMdtPtkHsLbvxR1NaDPAf4wNumEqAD1yE2mr1+GMXSMdPGIPX8lXvyxUffWJPlKjE1CcediYcxDCa3UUP4xC/X1EwSgnYn2P1ljxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946766; c=relaxed/simple;
	bh=r3rsrgYvDNPot/J0J9qW+ROTWJ+QO7HKBNmC7Ub0TXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyKtwBLDYB4PUYE32OTbmLPHCfd4Dg/YWxL5sLZgkEMjeAwDSnvJitDXk2fPVQgRcmpmLQ7qwGzWlYVe5Cs0bz6fz7LPZ2zq7jvTwNfL6cD7iM/1FYRvurIRdRpSDJGihnyuKVuuSOW+nzevZnEeed8lajj0FzL0iwDdaBozmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c964f5a037so581493a91.0;
        Tue, 02 Jul 2024 11:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946764; x=1720551564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwzG6F4f5E6fksBgJirQ54c8SNWFrroy6GPzSmRvfqQ=;
        b=anWh0mgCPYSDgl3XdJfp/KppuuBIbW5hIfAkORZ73cM08bWzQhrzEHcRZxMkggTSr3
         NEWwGm0p2akKrGekUDOjr1fmwz2QGYoA4gJRaUyOlPjoVJTJsXQWKcS6XPg8+OK2LUvR
         jQVETHZfmU3NjbeZ5JRZqHPl4HkOW1S4kSs6eTtJZV/4vhFvPa7gwUkw1n9TZGdIjBXh
         vx6NIvADQtyQYp65Rkr8qqn5K4KNJAZ3wofTulDEgtMMtQX2gnydZVG7yohqr/PLtJUY
         12niNKbQXOExjhOuTu0sXyecMFJFhSa7bGJIPHL0LOpxx4F/OuLlwjP5n4GhXc6PLDaT
         gtBA==
X-Forwarded-Encrypted: i=1; AJvYcCU63X9uZi+xfFF+lhyQupJrJi+c/w1RfG+LRs+/EVYU+TkTQWv43JaghHT37krkJwYtrxkHlacuo+FEANQZeBNzTMqBIp9ZMWoUgn68iIil326kDqq2XgYN/nV8d7+ii5Glh4bKkugfekvOu0yLHA==
X-Gm-Message-State: AOJu0YxtxY3IatuucSHy3sWcP1v5vgd/LnTLC1vT+CNpKWekBNXm9N06
	Bz7gb2XwimjNOARk/0MGcYEYHBNVVVbgQcp3zXYGLfzn69VThJ6BU2p1J51kmbRElw1RV5pvj2H
	1bA2syNvaILbnbj98a1ewzVx8rbA=
X-Google-Smtp-Source: AGHT+IGC6dX/dOAx2dakhe0u99rDFvwClutmuvkHsvn9RBM56LEvW+skwbUj15GzJlliKKHiByK2zvk/nj0sgFXKmrs=
X-Received: by 2002:a17:90a:ac8:b0:2c5:12b5:b816 with SMTP id
 98e67ed59e1d1-2c93d77cf94mr5568002a91.48.1719946764039; Tue, 02 Jul 2024
 11:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624222026.229401-1-weilin.wang@intel.com>
 <ZnxW4u_TB5agiFJT@google.com> <CO6PR11MB563505F0D97C0E2D5949F583EED62@CO6PR11MB5635.namprd11.prod.outlook.com>
 <Zn3MV8lCSHLEEXDG@google.com> <CO6PR11MB5635353A7B7A010FB727C5A5EED22@CO6PR11MB5635.namprd11.prod.outlook.com>
 <DM8PR11MB56372A51C1D0D2EEDDA95E31EEDC2@DM8PR11MB5637.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB56372A51C1D0D2EEDDA95E31EEDC2@DM8PR11MB5637.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 2 Jul 2024 11:59:11 -0700
Message-ID: <CAM9d7chcdiHCBdwagj=zAeB3P1yT1Edc+q31Uq3LZfOFpP7vaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v14 0/8] TPEBS counting mode support
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Weilin,

On Mon, Jul 1, 2024 at 9:27=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: Wang, Weilin
> > Sent: Saturday, June 29, 2024 10:13 PM
> > To: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: RE: [RFC PATCH v14 0/8] TPEBS counting mode support
> >
> >
> >
> > > -----Original Message-----
> > > From: Namhyung Kim <namhyung@kernel.org>
> > > Sent: Thursday, June 27, 2024 1:32 PM
> > > To: Wang, Weilin <weilin.wang@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > > <mingo@redhat.com>; Alexander Shishkin
> > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; H=
unter,
> > > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.co=
m>;
> > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylo=
r, Perry
> > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>;
> > Biggers,
> > > Caleb <caleb.biggers@intel.com>
> > > Subject: Re: [RFC PATCH v14 0/8] TPEBS counting mode support
> > >
> > > On Wed, Jun 26, 2024 at 06:17:22PM +0000, Wang, Weilin wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Namhyung Kim <namhyung@kernel.org>
> > > > > Sent: Wednesday, June 26, 2024 10:59 AM
> > > > > To: Wang, Weilin <weilin.wang@intel.com>
> > > > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Mo=
lnar
> > > > > <mingo@redhat.com>; Alexander Shishkin
> > > > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org=
>;
> > Hunter,
> > > > > Adrian <adrian.hunter@intel.com>; Kan Liang
> > <kan.liang@linux.intel.com>;
> > > > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; T=
aylor,
> > > Perry
> > > > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>;
> > > Biggers,
> > > > > Caleb <caleb.biggers@intel.com>
> > > > > Subject: Re: [RFC PATCH v14 0/8] TPEBS counting mode support
> > > > >
> > > > > On Mon, Jun 24, 2024 at 06:20:16PM -0400, weilin.wang@intel.com
> > > wrote:
> > > > > > From: Weilin Wang <weilin.wang@intel.com>
> > > > > >
> > > > > > Changes in v14:
> > > > > >  - Fix the python import test failure. We cannot support PYTHON=
_PERF
> > > > > because it
> > > > > >  will trigger a chain of dependency issues if we add intel-tpeb=
s.c to it.
> > So,
> > > > > >  only enable tpebs functions in evsel and evlist when PYTHON_PE=
RF is
> > not
> > > > > >  defined.
> > > > >
> > > > > I think it's easier if we have Ian's python build cleanup first.
> > > > >
> > > > >   https://lore.kernel.org/linux-perf-users/20240625214117.953777-=
1-
> > > > > irogers@google.com
> > > > >
> > > > > Let me take a look at it..
> > > >
> > > > Ok, I will hold the cmd option name update until we conclude on thi=
s one.
> > > > Thanks a lot!
> > >
> > > Please take a look at the current perf-tools-next branch.
> >
> > Hi Namhyung,
> >
> > The python import test works correctly with the latest perf-tools-next =
branch
> > without the change I added in v14. I will send a new version that rever=
ts this
> > change and update the command line option. Is there any other changes
> > you'd
> > like me to add?
>
> Hi Namhyung,
>
> I'm planning to submit the new version before Wednesday. Please let me kn=
ow if
> you have any new comment on this.

Yep, I think it's ok unless it introduces new test failures.

Thanks,
Namhyung
