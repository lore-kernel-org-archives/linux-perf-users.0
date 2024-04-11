Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52EC1C0DE7
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812816; cv=none; b=geePP3T9jQMi9eQIMcnUvuwezjxsCgWk+fyxXD1VpqN0BXlwKJCCp+weFcRCza38szOVTba4O99n4dj7AbnJTzBtHCtARjct/ihsEnN/9knNpHRE0X05J4pspRt59sl60WOwRlCa79VXxEueSgV/T5hhA3g6+a/iURoa5TqI3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812816; c=relaxed/simple;
	bh=VavP+TEgWlUIEEk0IE/CrIxnH5DldmPRefPQXNnYk1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdRtQlw5+sxGs/RNeGBJ4vo8EjLTmIUFnr9/brK1VXKPU3qLpxcHkfZHlshEOqa2uNXsV8eXDqaVLuakEWERPUFBGuCsY01E60YWZm+Ma869Gb7RHK9eALPhc2o157WJRr64s7HZL+ae7c4ao+Wc8c0iRerBlbkZL1Lb3Y8vhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=eqcQKFBw; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="eqcQKFBw"
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:1c00:0:640:7760:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 80B706158D;
	Thu, 11 Apr 2024 08:20:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2KTYIjHxP0U0-gUotAOEX;
	Thu, 11 Apr 2024 08:20:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712812803; bh=demdija4J/j6Z9Gt6myNi+Hnh34+y1exRKu0R4b2ArA=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=eqcQKFBwpKVkniDv0yQGoHPKnCW/GCaU0h2EmQMXHI1vNSvZNdi324ejnBnxwgnTs
	 GSLhh0i9EYYRAtBWdB/eZQi+kbN7Ifjv4RE/7BhqzR9nLf/MGM1XGPPWQ2+7YX5FCW
	 vSDHkX0PDeKuViEl0gU5XEQYPKYZaQC8l+tLdhGw=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <b388a04ef2d6275f776d4c390058921ebf61eb2a.camel@yandex.ru>
Subject: Re: `annotate --data-type` is empty
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Date: Thu, 11 Apr 2024 08:20:02 +0300
In-Reply-To: <CAM9d7chRRkEKxpvgD-=Aj+dWfma12EAQHJX=gakeNYrj7L_Lag@mail.gmail.com>
References: <83b3aa2678b7a82c4247669cd8edae4573d1f52b.camel@yandex.ru>
	 <CAM9d7cid-rmSVrQ2_eHH90NKxiXcX-u-udJv5WhRimkFtAyZVw@mail.gmail.com>
	 <15e1a2847b8cebab4de57fc68e033086aa6980ce.camel@yandex.ru>
	 <CAM9d7chRRkEKxpvgD-=Aj+dWfma12EAQHJX=gakeNYrj7L_Lag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-10 at 16:46 -0700, Namhyung Kim wrote:
> On Wed, Apr 10, 2024 at 1:19=E2=80=AFAM Konstantin Kharlamov
> <Hi-Angel@yandex.ru> wrote:
> >=20
> > Cool, thank you!
> >=20
> > To cut story short: it worked. I followed your advice and built
> > latest
> > `perf`, that is from 6.9-rc3. Additionally, I rebuilt Emacs because
> > that was an old build. I did check debug information in the older
> > build
> > before I sent previous email, by running emacs in `gdb` and setting
> > breakpoint in a C file. So Idk if newer perf fixed it or somehow
> > re-
> > built Emacs influenced it. For posterity, flags I build it with
> > are:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CFLAGS=3D'-march=3Dnative -O=
0 -g3 -pipe -fmerge-all-constants'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC=3D'ccache cc'
>=20
> Good to hear it worked well.=C2=A0 And v6.10 would bring a lot more
> exciting updates, stay tuned!
>=20
> >=20
> > -------------------------
> >=20
> > However, I am also getting the following errors, what are they
> > about?
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error running objdump=C2=A0 =
--start-address=3D0x0000000000016d00 -
> > - stop-address=3D0x0000000000016f40=C2=A0 -d --no-show-raw-insn=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -C
> > "$1"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No output from objdump=C2=A0=
 --start-address=3D0x0000000000016d00
> > -- stop-address=3D0x0000000000016f40=C2=A0 -d --no-show-raw-insn=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -C
> > "$1"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error running objdump=C2=A0 =
--start-address=3D0x00000000000155d0 -
> > - stop-address=3D0x0000000000015910=C2=A0 -d --no-show-raw-insn=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -C
> > "$1"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No output from objdump=C2=A0=
 --start-address=3D0x00000000000155d0
> > -- stop-address=3D0x0000000000015910=C2=A0 -d --no-show-raw-insn=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -C
> > "$1"
>=20
> I think it could not find the target binary for some reason.
> I've sent out a fix for that.
>=20
> https://lore.kernel.org/r/20240410185117.1987239-1-namhyung@kernel.org/

Oh, so judging by the patch, I presume they're harmless?

I tested the patch by manually applying to `tools/perf/util/annotate.c`
(the file was called another way on 6.9-rc3), so if you want you can
add to the patch a

	Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>

Thank you
