Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95F2C4332B
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A124A23107
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbhASOiu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:38:50 -0500
Received: from dd17628.kasserver.com ([85.13.138.83]:55730 "EHLO
        dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391573AbhASLgT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 06:36:19 -0500
Received: from milian-workstation.localnet (p4fd6c50d.dip0.t-ipconnect.de [79.214.197.13])
        by dd17628.kasserver.com (Postfix) with ESMTPSA id 1B577628543A;
        Tue, 19 Jan 2021 12:35:34 +0100 (CET)
From:   Milian Wolff <mail@milianw.de>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date:   Tue, 19 Jan 2021 12:33:12 +0100
Message-ID: <6799156.55LOemW0PR@milian-workstation>
In-Reply-To: <CAM9d7cihUNLX9wAWkNi5-J1HC4NPhD_mFW9EFc77t=SAFF10-A@mail.gmail.com>
References: <8218693.uYs0DeGetE@milian-workstation> <7161646.QLfhZlOSzD@milian-workstation> <CAM9d7cihUNLX9wAWkNi5-J1HC4NPhD_mFW9EFc77t=SAFF10-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5902756.XR8F9sFZxY"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart5902756.XR8F9sFZxY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Milian Wolff <mail@milianw.de>
To: Namhyung Kim <namhyung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date: Tue, 19 Jan 2021 12:33:12 +0100
Message-ID: <6799156.55LOemW0PR@milian-workstation>
In-Reply-To: <CAM9d7cihUNLX9wAWkNi5-J1HC4NPhD_mFW9EFc77t=SAFF10-A@mail.gmail.com>
References: <8218693.uYs0DeGetE@milian-workstation> <7161646.QLfhZlOSzD@milian-workstation> <CAM9d7cihUNLX9wAWkNi5-J1HC4NPhD_mFW9EFc77t=SAFF10-A@mail.gmail.com>

On Dienstag, 19. Januar 2021 10:36:11 CET Namhyung Kim wrote:
> Hi Milian,
> 
> On Tue, Jan 19, 2021 at 5:11 PM Milian Wolff <mail@milianw.de> wrote:
> > On Donnerstag, 14. Januar 2021 09:56:36 CET Namhyung Kim wrote:
> > > What I noticed is ss->adjust_symbols which is set for user DSOs.  It
> > > does
> > > 
> > >   sym.st_value -= shdr.sh_addr - shdr.sh_offset
> > > 
> > > Maybe your program's section header has different values?
> > 
> > Hey Namhyung,
> > 
> > how would I figure that one out? Isn't that data shown in the readelf
> > output above? Put differently: Could someone else maybe show his readelf
> > output so we can compare?
> 
> I mean the below.  In my case, address and offset of the .text section are
> same as 0x1080.

Ah, indeed for me it's not the same - there's the discrepancy of 0x1000 again:

  [13] .text             PROGBITS         0000000000001610  00000610
       0000000000000185  0000000000000000  AX       0     0     16

Thanks, that gives me a (complicated) path forward. We'd have to essentially 
load the elf file, find this offset, and then take it into account when 
telling elfutils where the file was actually mapped to originally.

Cheers

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart5902756.XR8F9sFZxY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEezawi1aUvUGg3A1+8zYW/HGdOX8FAmAGw3gACgkQ8zYW/HGd
OX+pjBAAx0Xy3gyCcK5ESmSh0l/jdneaV6Vl7a5OGtGK1wfwV1g7PQGGXt7nCUnh
Aa8LCiz961saHpthyqkAM4BGAJLMYTNkAxkE/3G7mPNwJkJi1TnUwk3o6JnLFDcZ
akn65CPFdH47BRd9DYUQw9gKrjPa98rcJwX66ldenD7bRTQIMQYgsk1ATy8evoz3
/A/Aww8O9CvRrLzmWvy4KPRhIIX93wSyWpBk0Evb7p9OYI7u6jCiJrzlwZ5MK1pD
462+5M26OwdPa2DJRVA+wEaN8dL0/tMvt1wjajwGoHtoVk6/E9AmBW06k3Mg0ZUU
QCKrarFoJSYhVuiutd6CbNWcBGKDHLmCWRzkqL7EyRPMgj5Vehb8lhZVcc9jfHoZ
VM+PYzwavlGcbOtStn3QU+zw09t6mHv5BJgvH5zNsuVE5PnWrzib3BYybmZ8OvSK
7F1zhXUiqPL0slyYiQFWhk1XN5HKtl0tAPLPrVgoxPbFDx/hbXbhiH7XI0lT5kZF
a+JgvsTCMd+uptPOEm8fyATGFByOP8qEGaWN+fQHbV/zA+b+V/sIEKdZyaNvokaS
5QUuRqyJUBWlnN46ueQzStvCQYS4q6GgBoTrDHFS11A5UQIsm95iA+TBaQ581cTu
ZMRcP6P92fdHN5YxM3Gl7mB4NElA5GW6Yx9/+rpzishpyp+azAc=
=Q4h0
-----END PGP SIGNATURE-----

--nextPart5902756.XR8F9sFZxY--



