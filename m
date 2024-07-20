Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5712C470;
	Sat, 20 Jul 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721475871; cv=none; b=KewrYiFjzjU1piuVgK+WlArcnM8A96cpmV2R1/J//dmHnOzjz+iwR0ejkZq9hLGDjffpGV89vuKFYjbykOvKqFWMIpurotLlzFIIjkqQpmjtXg3du6jDLj8B5cw2mkVmJcQQK39Xn/wC0mpY/6G/og2B28b44j919QPT6y57W3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721475871; c=relaxed/simple;
	bh=TJO8h/eFfU7IPMWqUCGwvZlX+9Wbol7guLZr0oBAums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZkwe9AEVYVu2KAO6OLycBiARDmhuA6mdp01Flz8LR/C0KDU7RerAF5RLUu9uYQXvfkivry8N1SzZuWyoiQq7YMh2pHETSF2IC7ja0Pp1FQG5Iishb9TwhhF9wCLklLHQUl5efVLicGQAsmCZBgn33nPCiXXL+gA+57v8ukr7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=xX4fl+xh; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="xX4fl+xh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1721475862; x=1722080662; i=christian@heusel.eu;
	bh=d6sQncxksEBStHSB94RGXNBWqd4oufwfD0Ln6gOdxYk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xX4fl+xhK/p4rtE0bYxaZErstpNjjAX4+kaMdmMVm7HtRrq70KAuS+x/lSEx00NT
	 0SjG0XvmPlWDZwn0b/WS92wAar9nQwh+OGWikN9WCVyHEzo1TCwsD+dloYAPAcaCj
	 leP/z9A2339PXugiPVRK1lkTqS9B9dLHHcNHOzQEDBDCI2UhuM692V5gOI0bj6Oku
	 LLb9hnlzDx0Y+NbGtzbNU8cZRn3fCDW1b9n8756+fF0VExtQ0I/3XEd0jGGwtZGzg
	 GZNcqDWHE9xnB/qWoVJ0+cJU8m76yJjSIPn8qORoNBvcB150utya7XCf6aLsoSK9p
	 85VhQP+9iKg5JJvZcg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.67.70]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVMqF-1svty33lup-00UMKX; Sat, 20 Jul 2024 13:30:01 +0200
Date: Sat, 20 Jul 2024 13:29:56 +0200
From: Christian Heusel <christian@heusel.eu>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf trace: Avoid duplicate code in fprintf_duration()
Message-ID: <b48460e2-c54d-4390-89e3-6835c379eb01@heusel.eu>
References: <c564da16-062f-4da6-9021-c68f9c6eab63@web.de>
 <c105871a-6462-4678-9f0c-b2ed5a254bb1@heusel.eu>
 <b3943cc3-234f-4789-a894-314a3890ac8e@web.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fahnxmnp3vyuvxuq"
Content-Disposition: inline
In-Reply-To: <b3943cc3-234f-4789-a894-314a3890ac8e@web.de>
X-Provags-ID: V03:K1:wgXLWGQmfeKwtyqZq/xoXFDygvYYIkaZZFcwRqZakzg3BwHTh+9
 6Kr77YMAbCYKpmX1NjVHCtbABfoa3IkNKMXoh0EKpH3LdbD/x+mOGUPYG/ce2eznAiVY6Zv
 MigJCf5QvYBJlLc+fcOwKDzmuJnG9PRm2j0pnhBZEUFD90Omji/aoIjK5swqdFa/Za6Jc6T
 vHHE6HT8UBiYEunbXvzfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3xGSpVSwDLE=;54vOWFeM4vBW6Hh7HR3svbaroM0
 qQSsCFLJVMgTVnFSZlJCBBvB6joRr+12abWuvAna1DnnlN+MMr1MgWzBRz9SFJq2vGGk4Pbtm
 ojfFPUJJfGIWRu0QC6OnZbydPNLJ1x3b1bAi8rO6tROjT47VkfW7LWsDLvKyFs3TEPc4bwK0B
 73fAXm18YfPAOOlmksRCigZGIYQt3AXDQVIGNoywUEdLiTQ/ht1x9OTO/RmZ90rA4jPmDDPl5
 GbX5fcbgd7nEoCzGY+lpJv5mro4ghJ9rU8HWbRG3LgT41DmuMVZx0v77txtUBlntEU88lilN7
 pVb6exW5VeCvhezUvU1xu9nKQDPLrDnBivO7u8us2VAH51QwxxvuYsZz925FWmn9RkFATa6N5
 p9y4NHDMyemuY3wtLElg662OINnGIlEiEbVK1Y5WyVYz3bqCI8bxUk/jn6zrjXiZvTjUoTwWQ
 qUR+q4AQhIXcsCIgFkzRUQ7CQz4f7rtehRcDmWfeR1T4Pq24SsUvGNsCubZGjmQ5X3sUI40cd
 FNmd+ExcT3YmiG2s0QpTrVCAduS6iC9A9Glv7WPHU+Y6EN3hdPedNs1Me8PWwq16tmOyQCS7l
 STZT1mBWvjvr39/zTDS285ZRKoa6ISgsawO1WxrDTwVVh6i5/Mn+WC9Rnv50nx+Jpyi0FyHVK
 EkhZY/qimDntvKE1lKxDp81c38Tqh+r+9XzuMXlI+6iJSBbJgO5KvhWQ43VDDbzvI0iq3GIiq
 ApFeqHUFronffF9xRn0E8y28lpr6ay1Hg==


--fahnxmnp3vyuvxuq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/07/19 06:32PM, Markus Elfring wrote:
> =E2=80=A6
> >> +++ b/tools/perf/builtin-trace.c
> >> @@ -1258,12 +1258,16 @@ static size_t fprintf_duration(unsigned long t=
, bool calculated, FILE *fp)
> >>
> >>  	if (!calculated)
> >>  		printed +=3D fprintf(fp, "         ");
> >> -	else if (duration >=3D 1.0)
> >> -		printed +=3D color_fprintf(fp, PERF_COLOR_RED, "%6.3f ms", duration=
);
> >> -	else if (duration >=3D 0.01)
> >> -		printed +=3D color_fprintf(fp, PERF_COLOR_YELLOW, "%6.3f ms", durat=
ion);
> >>  	else
> >> -		printed +=3D color_fprintf(fp, PERF_COLOR_NORMAL, "%6.3f ms", durat=
ion);
> >> +		printed +=3D color_fprintf(fp,
> >> +					 (duration >=3D 1.0
> >> +					 ? PERF_COLOR_RED
> >> +					 : (duration >=3D 0.01
> >> +					   ? PERF_COLOR_YELLOW
> >> +					   : PERF_COLOR_NORMAL)),
> >> +					 "%6.3f ms",
> >> +					 duration);
> >
> > Why is this a desirable change?
>=20
> I find it helpful to specify the affected function call only once
> in such an if branch.
>=20
>=20
> >                                 Folding the if-statements into the
> > ternary operator makes the code quite unreadable compared to what it was
> > like before and doesn't give any obvious improvement.
>=20
> Do you prefer to store the result of the colour determination into another
> local variable so that it can be passed as a separate parameter?

No I think I prefer the current version of the code. But my judgement
does not matter much here, lets wait what the maintainers have to say
about this.

--fahnxmnp3vyuvxuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmabn7QACgkQwEfU8yi1
JYUbZA/8Cv2ZIOneMZnE+Gz/sxHy4yZDWl9ga0f5GR2uLonev/8uoAUBiFl68xIT
pUw4zH0OpbHIYGTnvLReuBp1oMjrkyi0Fng1OGuRPgsnAA3zx5xMi7KBtjMYN1Of
tjXtF9G8wA6+EgIJ/E1MVxXlBaaB9kjAhHmTl24nGVwUCaoji+naXXNIua5/2nj8
ADl1s5h+wrYsMJrHTaMTB0/j6erIyhyJzgcqS0+0AgKyihEUrUpgFIeelBIFO6rT
xm2BYazw7OeXhyqNjSmljO2aDWhcdRMRvg7i/jxzigf33UVEC8o6i5Ac/UUeU81Q
swK1pZGrUF37wap9W5WM//G7e28mDd4x8HSZnBBiPI1Ysup737Nd76zP9lsfKdq5
UAfjN8gCkSDeLZ4n+5OjwnygjgCTmyHPrrRMk1MC83IZAI3Me22UEMcdARmrSQr6
xaY8ArwnmX8swCURlW4+YdrcjicHrZ1wDfUxhjNdhqPYs1TD8iVpeJcOQxd0H+/O
+7UQvgD1DegPJZe1d55akALEFpKmRSTud+/109SZ6zQFRMQCdd0vFIzz/MAW3rfj
Zb6OAJO1kTPnFsuV54zy7EyjkSPWma8BKDq6OYXivFPZ4v990eS7VvlcyZE9Xv4z
xjmwxVdjDEJKDtlhmMiqL4PYiGv02AEgrksIYMuXQ7EpU08C0tk=
=AJQV
-----END PGP SIGNATURE-----

--fahnxmnp3vyuvxuq--
