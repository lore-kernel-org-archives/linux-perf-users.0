Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA548101C5
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737574; cv=none; b=Q9j8ruSkbnjDsvGwABQWAPMBy+1sRnIeqANcShbjzy+KX+mvx9wXMuTYvVAinWFWtrCWfScELK7lRMzvEgCrRHttSYq7FaU0d+e4TMLel4qTE1RCfvFDtMQtwmYVLeqrMgRbp3SYFKFA9520mqqZeJfMBB54bVBlLEH+j4YUEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737574; c=relaxed/simple;
	bh=duDj0a+BJ/nN+ww8vqV7NuAk0aYdD7AxE8cfud7UXsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZNitK9Dr8Nm9j2vnV+JeTKehy2AMTYI3CjcwTkkhTgDthdI7qo4bjD2PogFZm2zdFkTlPUBnfauXSXuZAxPzDH3BwMAxQEWmqA+jY82vIL9NKx0Hj4rkpW66e/YYjveawwVdyHCYHyVZATVx+MOt5YkO3ReHZWh5GTHffsRa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=TeiefwAu; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TeiefwAu"
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:a33:0:640:d837:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 7B3B35F28E;
	Wed, 10 Apr 2024 11:19:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JJVJ4H5GfCg0-MrNu3eSh;
	Wed, 10 Apr 2024 11:19:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712737160; bh=Fym9ep649dXMDHbz2SrqO2OBPQLiz2ow4usaPg3iIYc=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=TeiefwAuOacXPA44zbxW6gjDNpQnqVOZz0ez4m7C0oiGnPKrxpsEOPjhduWU8hRAd
	 B1Obl8snsbWvQQp32l3Cv+hczG1GPjgqhMUK47kSZf8KTrhFWzbbUBJ9NBMsAeCz6Q
	 /J03JJX1hJ3Yxc+2AEC+czhcWw3BdZQHtNxGljoo=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <15e1a2847b8cebab4de57fc68e033086aa6980ce.camel@yandex.ru>
Subject: Re: `annotate --data-type` is empty
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Date: Wed, 10 Apr 2024 11:19:19 +0300
In-Reply-To: <CAM9d7cid-rmSVrQ2_eHH90NKxiXcX-u-udJv5WhRimkFtAyZVw@mail.gmail.com>
References: <83b3aa2678b7a82c4247669cd8edae4573d1f52b.camel@yandex.ru>
	 <CAM9d7cid-rmSVrQ2_eHH90NKxiXcX-u-udJv5WhRimkFtAyZVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Cool, thank you!

To cut story short: it worked. I followed your advice and built latest
`perf`, that is from 6.9-rc3. Additionally, I rebuilt Emacs because
that was an old build. I did check debug information in the older build
before I sent previous email, by running emacs in `gdb` and setting
breakpoint in a C file. So Idk if newer perf fixed it or somehow re-
built Emacs influenced it. For posterity, flags I build it with are:

	CFLAGS=3D'-march=3Dnative -O0 -g3 -pipe -fmerge-all-constants'
	CC=3D'ccache cc'

-------------------------

However, I am also getting the following errors, what are they about?

	Error running objdump  --start-address=3D0x0000000000016d00 -- stop-addres=
s=3D0x0000000000016f40  -d --no-show-raw-insn       -C "$1"
	No output from objdump  --start-address=3D0x0000000000016d00 -- stop-addre=
ss=3D0x0000000000016f40  -d --no-show-raw-insn       -C "$1"
	Error running objdump  --start-address=3D0x00000000000155d0 -- stop-addres=
s=3D0x0000000000015910  -d --no-show-raw-insn       -C "$1"
	No output from objdump  --start-address=3D0x00000000000155d0 -- stop-addre=
ss=3D0x0000000000015910  -d --no-show-raw-insn       -C "$1"

On Tue, 2024-04-09 at 16:24 -0700, Namhyung Kim wrote:
> Hello,
>
> On Fri, Apr 5, 2024 at 6:17=E2=80=AFAM Konstantin Kharlamov
> <Hi-Angel@yandex.ru> wrote:
> >
> > 6.8 release added a new feature: ability to see which struct fields
> > are accessed the
> > most, to figure out how to reorder them to maximize performance.
>
> Thanks for testing this out!
>
> >
> > However, I am testing this with Emacs and I seem to get no results.
> > Emacs is built
> > with debugging information.
>
> Can you please share the output of `readelf -SW ./build/src/emacs` to
> verify
> if it has the debug information in the binary?
>
> >
> > # Steps to reproduce
> >
> > 1. Build emacs
> > 2. Record a bit of Emacs work as:
> >
> > =C2=A0=C2=A0=C2=A0 perf mem record ./build/src/emacs --batch --eval '(b=
enchmark-
> > run 9999999 (cons 1 2))'
> >
> > 3. Get the results with
> >
> > =C2=A0=C2=A0 perf annotate --data-type
> >
> > ## Expected
> >
> > Information on a lot of different structs that are being used.
> >
> > ## Actual
> >
> > There is only one struct
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Annotate type: 'struct _IO_FILE' in /usr=
/lib/libc.so.6 (1
> > samples):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=E2=80=A6]
> >
> > and that's it.
>
> And it seems it didn't get the debug info from the binary and
> only got one from the libc.=C2=A0 I suspect it missed the debug info
> somehow.
>
> >
> > # Additional information
> >
> > * perf version: 6.8 built manually from commit "e8f897f4afef: Linux
> > 6.8"
> > * `perf.data` for the testcase is 3.6M, so it definitely has more
> > information than
> > =C2=A0 just this one struct. I can upload it somewhere if that helps.
>
> If you can build from the perf source code, I'd recommend to use the
> latest version which has a lot of improvements.=C2=A0 v6.8 only has the
> basic support with pointer variables.=C2=A0 And the full features will be
> available from v6.10.
>
> Thanks,
> Namhyung
