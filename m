Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D157C87
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688363; cv=none; b=smfZEGsHdqqPWU9/fyMSwhLc7XFKRAtyUwQTilVPnaX+VR+7N5UmFx/v+XWGjterHLsrAOY2Dkwampcw/hxFWM+HHQnvMk9+tkGbhAmJlRU/GStZ4eevSBZR0yKLzG0WFc9re8OEoIbsF4AoXWWAub0SF99DCTg7Q25763M380c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688363; c=relaxed/simple;
	bh=bO2bSzZYg5eVuybM909I31iOjzvb3I+nSIW9JIdFhUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HfIZSVLeOgKQrII9oDSrbDISuctPEuVLCmcyFZcVMKjECdw/Za9aVfBBpcyAXfDUNXoCaTWySf4D7DBwSlvoiS34A6jAfaSTDMIzSJrvH7q29U/8UPZzntwRvXZgC4W5HDnogcu9aZBdaIBo73R4sLCeQ3SBRuBJ4wRe3LhfLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-254-5Vt6L_CMNO2wOuNp_wGOOQ-1; Thu, 02 May 2024 23:19:11 +0100
X-MC-Unique: 5Vt6L_CMNO2wOuNp_wGOOQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 2 May
 2024 23:18:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 2 May 2024 23:18:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jules Bashizi Irenge' <jbi.octave@gmail.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	'Linus Torvalds' <torvalds@linux-foundation.org>
Subject: RE: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Topic: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Index: AQHamYq9w5OrjuroEEyWIm0jPSXs6bGEJ7/A///xsQCAAGdE0A==
Date: Thu, 2 May 2024 22:18:44 +0000
Message-ID: <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
References: <Zi57-TMgU19puaQM@octinomon.home>
 <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home>
In-Reply-To: <ZjPApuDc0gL9Pchm@octinomon.home>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> > > -=09do_div(delta, tdelta);
> > > +=09div64_u64(delta, tdelta);
> >
> > Nak - you've not tested it.
> >
> > =09David
> >
> No, I later realised it's for 32bit here. It may be very expensive for
> a 32bit.
> I think I got it wrong here.

You've missed the main issue.
do_div(a, b) sets 'a =3D a / b' and returns 'a % b'.
div64_u64(a, b) returns 'a / b'.
They are not direct substitutes.

For x86 (32 bit - does anyone care are more??) do_div is defined as:

/*
 * do_div() is NOT a C function. It wants to return
 * two values (the quotient and the remainder), but
 * since that doesn't work very well in C, what it
 * does is:
 *
 * - modifies the 64-bit dividend _in_place_
 * - returns the 32-bit remainder
 *
 * This ends up being the most efficient "calling
 * convention" on x86.
 */
#define do_div(n, base)=09=09=09=09=09=09\
({=09=09=09=09=09=09=09=09\
=09unsigned long __upper, __low, __high, __mod, __base;=09\
=09__base =3D (base);=09=09=09=09=09\
=09if (__builtin_constant_p(__base) && is_power_of_2(__base)) { \
=09=09__mod =3D n & (__base - 1);=09=09=09\
=09=09n >>=3D ilog2(__base);=09=09=09=09\
=09} else {=09=09=09=09=09=09\
=09=09asm("" : "=3Da" (__low), "=3Dd" (__high) : "A" (n));\
=09=09__upper =3D __high;=09=09=09=09\
=09=09if (__high) {=09=09=09=09=09\
=09=09=09__upper =3D __high % (__base);=09=09\
=09=09=09__high =3D __high / (__base);=09=09\
=09=09}=09=09=09=09=09=09\
=09=09asm("divl %2" : "=3Da" (__low), "=3Dd" (__mod)=09\
=09=09=09: "rm" (__base), "0" (__low), "1" (__upper));=09\
=09=09asm("" : "=3DA" (n) : "a" (__low), "d" (__high));=09\
=09}=09=09=09=09=09=09=09\
=09__mod;=09=09=09=09=09=09=09\
})

Somewhen it must have got changed from a simple asm wrapper for divl.
(And the test in the middle should be '__high > __base' to avoid
a division that is guaranteed to return zero.)

I'm also not at all sure what happens when divide gets speculatively
executed - there is a fair chance it has to complete.
So that extra check for returning 64bit quotients may be move
expensive that you might think.
(Although x86 will fault if the quotient would overflow - not ideal.)

I do wonder how much more it would cost to check the high 32bits
of a 64bit 'base' for being zero in a full 64x64 divide?
Any 'full software' 64bit divide function is going to do that anyway.

For 32bit it should be possible to do an inline 32x32 divide if
both 64bit values are only 32bit and an out of line call otherwise.
Although that might need to be built into gcc (at least for
architectures where the modulus isn't free) since gcc detects
when code does a/b and a%b and will only do one divide.

So maybe just supporting 64bit divide wouldn't be that expensive??

(Although there is a fubar on risc-v where even 'q =3D a / b'
'r =3D a - q * b' gets converted to 'r =3D a % b' and two slow
divides.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

