Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517936103
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707519397; cv=none; b=dgiqHgXydEG95qzQDHga6RoUPMW5qKVaSzcsih73bfJfyWC32kiqrG52eOIxJMbAilJGJiBFYw+N6453PwUjYEA357dQ9a9fEmX12nKRGqC+QApOADJc4RdKVm4FBPsbDkreR+TB7SCTovHLrFtAmuaMQfw72UqKDGxhkSBns6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707519397; c=relaxed/simple;
	bh=R+tVz7X+GWdK9ijXuFNM6ysYj+HXuFvXImtN0P1VeB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnXCHyKUN4IOOSg6VwHxhn1TxLy+j05iuuF3RUjCvCuRz+w8cbMmS+DAZdbTtCSq0ezxMoHRn/OQX2xsD9mLRE0GFhtF2bgYrutFbNN25C3cClQTMEjz4J9kLD6dCeVRPOf+T0UzXkpLoYjieYrM88uWJev1Mhc8T7sZv/g0Ccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71cb97937so14751365ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 14:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707519395; x=1708124195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF6Myxw6cyFBmBz+GLG0oiuJ2vQz3zkATd8Bss7Omhs=;
        b=hdqPoTf8YM2gzJRXLKQnOA8HzHAT8DKJGgWM16b3PApDXFa04gn6Zbk2d0WL2jWG5E
         q9fG32tXJdb1sGGuDAPGwrSYmjXi0G2/afsh+RFDiH7elvNGRJu3ofbA9qe6EPQci1iY
         Kdq04qL58lLWeOTpQcFiCoDd0ghL2YzV8Po62N3ixFXazjwyAX6AXSs54cBB2jRGgtuZ
         HcSOqpMJ4hFPQhwwpcbmazEl+8kVK/1tLY7Z3YFmrdCnvA0aC8YjVYCcqj7RFWBMmN0u
         XeR65YoI7WcHH327s/aq+uJ/hDsQp5Dei6zAyG45a51qX43iy1alKtRxOAAwmapdVzXq
         ZPUg==
X-Gm-Message-State: AOJu0YzrbQ2bp7l1VgFAr1ewilx+ZrCnEXdUJJelgPrHv4HVgnJH1496
	TrpI1PIHMYqwDgiaFxuT6Wv4X1S43bL/oZqMehWMNyAyl8nILyilZ91iXUDNHE2bgvHY88OUlFx
	v8Kg21plUFusxr7pIWk35Pv56zoCUtciojENI1Q==
X-Google-Smtp-Source: AGHT+IEI0kYjK1W+jaMwC5APQ08PIUHfIh6H4BAbo2QFC5+nFtiv/gwWAAsOGxpXhCd5pYWv4jqCNp0ZJEX22+wFX9U=
X-Received: by 2002:a17:90a:fd0d:b0:296:bd4c:536d with SMTP id
 cv13-20020a17090afd0d00b00296bd4c536dmr336289pjb.45.1707519395170; Fri, 09
 Feb 2024 14:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131113951.17077-1-mpetlan@redhat.com> <CAM9d7chjET+Zy7EYcRNW=9XaC+DKcqqU+EatiGJouRCjjHscKA@mail.gmail.com>
 <alpine.LRH.2.20.2402081741080.11354@Diego> <CAM9d7chDp4_+Mk+-CNw2Es9MBtA7f6pbJ3X5cqpDfUjc+QkMQA@mail.gmail.com>
In-Reply-To: <CAM9d7chDp4_+Mk+-CNw2Es9MBtA7f6pbJ3X5cqpDfUjc+QkMQA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Feb 2024 14:56:23 -0800
Message-ID: <CAM9d7ciyou27sd59q2eZdE-qg-JcUOMoN5sJgMij1EFq4t328g@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf testsuite: Add common regex patters
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com, acme@redhat.com, 
	acme@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Feb 8, 2024 at 8:49=E2=80=AFAM Michael Petlan <mpetlan@redhat.com=
> wrote:
> >
> > On Thu, 1 Feb 2024, Namhyung Kim wrote:
> > > On Wed, Jan 31, 2024 at 3:42=E2=80=AFAM Michael Petlan <mpetlan@redha=
t.com> wrote:
> > > >
> > > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > > >
> > > > Unify perf regexes for checking testing output into a single file
> > > > to reduce duplicates and prevent errors when editing.
> > > >
> > > > This will be used in upcomming patches in shell tests.
> > > >
> > > > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > > > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > > > ---
> > > >  tools/perf/tests/shell/common/patterns.sh | 256 ++++++++++++++++++=
++++
> > > >  1 file changed, 256 insertions(+)
> > > >  create mode 100644 tools/perf/tests/shell/common/patterns.sh
> > > >
> > > > diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf=
/tests/shell/common/patterns.sh
> > > > new file mode 100644
> > > > index 000000000000..919a07b8b454
> > > > --- /dev/null
> > > > +++ b/tools/perf/tests/shell/common/patterns.sh
> > >
> > > We have tests/shell/lib directory, maybe better to put this there.
> > > But maybe we can move it later once we apply the series.
> >
> > Yes, in case the testsuite gets accepted, I plan to work further
> > on the integration with the current shell test set, in order to
> > unify the configuration, output, logging, etc. So, I'd prefer to
> > merge the directories later.
>
> Sounds good.  I'd like to merge this series to improve the test
> coverage.  And then we can work on fixing problems.

I have some shellcheck issues.  Can you please fix them first?

Thanks,
Namhyung


In tests/shell/perftool-testsuite_probe.sh line 6:
cd "$(dirname $0)/base_probe"
^---------------------------^ SC2164 (warning): Use 'cd ... || exit'
or 'cd ... || return' in case cd fails.

Did you mean:
cd "$(dirname $0)/base_probe" || exit


In tests/shell/perftool-testsuite_probe.sh line 9:
export PERFSUITE_RUN_DIR=3D$(mktemp -d /tmp/$(basename $0 .sh).XXX)
       ^---------------^ SC2155 (warning): Declare and assign
separately to avoid masking return values.
                         ^-- SC2046 (warning): Quote this to prevent
word splitting.
                                          ^----------------^ SC2046
(warning): Quote this to prevent word splitting.


In tests/shell/perftool-testsuite_probe.sh line 14:
     (( status +=3D $? ))
     ^----------------^ SC3006 (warning): In POSIX sh, standalone
((..)) is undefined.

For more information:
  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word spli=
tt...
  https://www.shellcheck.net/wiki/SC2155 -- Declare and assign separately t=
o ...
  https://www.shellcheck.net/wiki/SC2164 -- Use 'cd ... || exit' or 'cd ...=
 |...
