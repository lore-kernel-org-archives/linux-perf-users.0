Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58106FB9;
	Wed, 17 Jul 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233927; cv=none; b=gHQSQ3ceO6jfgENbxFIF4T5nqHQVF6wSHfKS3BbUNOjO+CZVBHhyctikj81/RgLrAYTkR3I7Q/c159web32UWZ10n1YTaZBRcSrlh0V8vHfF64Oj01pAM4hqiHJ8SSIq0GGLtOkpqJyVx5wlV4fsIbHRyTfhUk9ewLTuVUbgRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233927; c=relaxed/simple;
	bh=AysrhcFQKXmU9df2+6yZVMuPFvWFYo9EP+aTXRoSoJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=He3pY2VPOkWDHzhtOS7xbU26RvrRgjiP2MCaCqvq8h6gtqslP+1K19STDhdNWhMUlTc9UM3y/P55OFzELA/t26FoTYIV4HGXZJbt5cFwOyXcvK6smd6Dy0PHWs1jw2QuFBAPRiz33X+hgkElzYkKD+QI6Zp1Ba4x6gaahHBwAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CC1C32782;
	Wed, 17 Jul 2024 16:32:00 +0000 (UTC)
Date: Wed, 17 Jul 2024 12:31:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Ian Rogers <irogers@google.com>, Thorsten Leemhuis
 <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf build: libtraceevent, libtracefs feature
 check with pkg-config
Message-ID: <20240717123147.17169873@rorschach.local.home>
In-Reply-To: <CAM9d7cgG5WvyEu1ECNht1z=bZ7MSsrPyBjokcY95SXmxgnzwsA@mail.gmail.com>
References: <CAM9d7ciLGP_w9YYOb-2U2ESg8kQx_knQXuB6_2JZVZ2ktL+bzg@mail.gmail.com>
	<20240712194511.3973899-1-amadio@gentoo.org>
	<CAM9d7cgG5WvyEu1ECNht1z=bZ7MSsrPyBjokcY95SXmxgnzwsA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jul 2024 09:27:58 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
>=20
> On Fri, Jul 12, 2024 at 12:45=E2=80=AFPM Guilherme Amadio <amadio@gentoo.=
org> wrote:
> >
> > Hi Namhyung, Arnaldo,
> >
> > Here is version 3 of the patchset. I see the change to send output to d=
evnull
> > has already been applied, so I am submitting the remaining work only.
> >
> > The difference with previous changes is that in v3 rather than add test=
s with
> > pkg-config to check if dependencies are actually installed, we just set=
 the
> > flags and send any warning to devnull. The change that remains in this =
patchset
> > is the fix for the other tools, which were inadvertently broken when th=
e include
> > for libtracefs changed from #include <tracefs/tracefs.h> to #include <t=
racefs.h>
> > since the flags for the feature check are not set in the other tools Ma=
kefiles,
> > it currently only works for perf. I recommend to either take at least p=
atch 2/5
> > that moves setting the flags to tools/build/Makefile.feature or to reve=
rt the two
> > patches that have been applied. You can easily test the fix with the co=
mmands below:
> >
> > make -B -C tools/verification/rv VF=3D1
> > make -B -C tools/tracing/latency VF=3D1
> > make -B -C tools/tracing/rtla VF=3D1
> >
> > from the root of the repository. Only after the feature check flags are=
 moved to
> > Makefile.feature that it also fixes the other tools. Apologies for the =
breakage
> > there. =20
>=20
> Steve, are you ok with having this patchset in the perf-tools tree?
>=20

I don't know as this is the first I've seen it. If you could have this
resend with me Cc'd and/or Cc linux-trace-devel@vger.kernel.org then I
can review and possibly ack it.

-- Steve

