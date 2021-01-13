Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07900C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 17:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4AD21534
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 17:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbhAMRuY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jan 2021 12:50:24 -0500
Received: from dd17628.kasserver.com ([85.13.138.83]:53980 "EHLO
        dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbhAMRuX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jan 2021 12:50:23 -0500
Received: from milian-workstation.localnet (p4fd6c50d.dip0.t-ipconnect.de [79.214.197.13])
        by dd17628.kasserver.com (Postfix) with ESMTPSA id 659F3628149E;
        Wed, 13 Jan 2021 18:49:40 +0100 (CET)
From:   Milian Wolff <mail@milianw.de>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date:   Wed, 13 Jan 2021 18:47:22 +0100
Message-ID: <3012158.k929uczAvT@milian-workstation>
In-Reply-To: <20210113103031.GA1331835@krava>
References: <8218693.uYs0DeGetE@milian-workstation> <20210113103031.GA1331835@krava>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2163591.UBLyODYZFQ"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart2163591.UBLyODYZFQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Milian Wolff <mail@milianw.de>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date: Wed, 13 Jan 2021 18:47:22 +0100
Message-ID: <3012158.k929uczAvT@milian-workstation>
In-Reply-To: <20210113103031.GA1331835@krava>
References: <8218693.uYs0DeGetE@milian-workstation> <20210113103031.GA1331835@krava>

On Mittwoch, 13. Januar 2021 11:30:31 CET Jiri Olsa wrote:
> On Mon, Jan 11, 2021 at 05:56:52PM +0100, Milian Wolff wrote:
> > Hey there,
> > 
> > in hotspot I noticed a symbolization bug for perf.data files that are
> > recorded without `--call-graph dwarf`, i.e. something like this:
> > 
> > ```
> > $ cat test.c
> > int main()
> > {
> > 
> >     int sum = 0;
> >     for (int i = 0; i < 100000; ++i) sum += i;
> >     return sum > 0;
> > 
> > }
> > $ gcc -O0 -g test.c
> > $ perf record ./a.out
> > $ perf script --show-mmap-events | grep /a.out
> > 
> >            a.out 149719 18106.394277: PERF_RECORD_MMAP2 149719/149719:
> > [0x55e0b3b5e000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> > 
> >            a.out 149719 18106.394748:     275254 cycles:u:     
> >            55e0b3b5e72e
> > 
> > main+0x25 (/tmp/a.out)
> > 
> >            a.out 149719 18106.395011:     486078 cycles:u:     
> >            55e0b3b5e72e
> > 
> > main+0x25 (/tmp/a.out)
> > ```
> 
> for some reason I can't reproduce this and also I'm not getting
> randomized VA for your example, while I see it in other processes,
> which is strange.. I'll check on it deeper

Out of interest: what exactly are you not reproducing? And what do you mean by 
"randomized VA"?

> > How does perf resolve the address 0x55e0b3b5e72e to main+0x25 here? If we
> > look at this purely from the singular mmap event, this shouldn't be the
> > case:
> > 
> > 1) The mmap event starts at 0x55e0b3b5e000, has size 0x1000, so its end is
> > at 0x55e0b3b5f000.
> > 
> > 2) Address 55e0b3b5e72e is thus contained in this map, and at offset
> > 0x72e.
> > 
> > 3) But main is not at this offset, it starts at 0x1709:
> > 
> > ```
> > $ nm ./a.out | grep main
> > 
> >                  U __libc_start_main
> > 
> > 0000000000001709 T main
> > ```
> > 
> > How does perf report/script still get the right answer here and knows that
> > there's an offset of 0x1000?
> > 
> > Note that in reality, multiple mmap events occur. And the first one maps
> > the file at an address with the 0x1000 offset. This can be seen by:
> > 
> > ```
> > $ perf record --call-graph dwarf ./a.out
> > $ perf script --show-mmap-events | grep /a.out
> > a.out 149953 18488.265340: PERF_RECORD_MMAP2 149953/149953:
> > [0x55b2f29d2000(0x4000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
> > a.out 149953 18488.265346: PERF_RECORD_MMAP2 149953/149953:
> > [0x55b2f29d3000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> > a.out 149953 18488.265348: PERF_RECORD_MMAP2 149953/149953:
> > [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> > a.out 149953 18488.265350: PERF_RECORD_MMAP2 149953/149953:
> > [0x55b2f29d5000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> > a.out 149953 18488.265706: PERF_RECORD_MMAP2 149953/149953:
> > [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
> > 
> >             55b2f29d372e main+0x25 (/tmp/a.out)
> >             55b2f29d372e main+0x25 (/tmp/a.out)
> 
> when you use '--call-graph dwarf' you also enable data mmaps,
> so the extra mmap events are non-X mmaps

I see, is this an optimization to reduce the overhead when doing this 
"shallow" sampling? Can one opt-in to the data mmaps without going the full 
`--call-graph dwarf` way?

> > ```
> > 
> > In this case, we see that the first mmap event happens at 0x55b2f29d2000,
> > so if we take that as the base address, we arrive at the offset 0x172e
> > for address 0x55b2f29d372e. This then indeed matches main+0x25, i.e.:
> > 0x1709 + 0x25 = 0x172e.
> > 
> > But... The question again is: How does perf stat/report know this fact
> > with
> > just the singular mmap event in the plain `perf record a.out` case above?
> > Why is there just one mmap event recorded in such a profile?
> 
> it's simple binary, and you're getting just executable mmaps
> 
> but the calculation seems weird and we're mising something,
> I'll try to reproduce and come with an answer

Thank you!

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart2163591.UBLyODYZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEezawi1aUvUGg3A1+8zYW/HGdOX8FAl//MioACgkQ8zYW/HGd
OX9OfA/+IeAds+NuaGHJbG5h9tVgKEctXhtqyPExC2TUejLO1oJqq75Fmw6E0Hpk
UI5yfqusbZvQXNDMQbiGvwomc0/krSaBfZXCC/rbOPmcLur8hi74IXfjACmDLFJ2
0WaApiHgIJOMgLiKeO+INxH1xf/FI/gQfiubhLt00hOzqutF0Ft3Ie9M5B3NvLk3
pufkZTxT/b4aR6tIXuhD/zjzGjxlUk4xCiVEgnIRit68yRyxLCWhvZqcZm1XYrT+
U/RU1cpnW6h4gLabEEIeFlS/hmf9kmLiY0/iP1GqJnjqvdHRgzhYTrNsVxWiRgOc
pami34+SBdZGnLko9iKiEmO3hNnfC/2OQsyQWUjMKqc+DDEhMFI5pMuECzT6tPRy
YqG7WvZRIcyEXwbVEug6VAh5us38h9le3VVNUql+O5FMy9EmuzHZ3LFX18FDXfp9
AftkBFRTAhSqYIf2CIQ57KOBmxTs2bWzCnBf5IWyRXJyK+z+AMzVDLofHdaKLn89
3eeFSOeoZIn9WA37wZpAT+EppuSfWtAiYbJ5kaeku+alfh1gEf/EVXcdtauBuiUL
G/gHmlvh2dcw+ZhpKop6fSaV9hz9YxX1n3Rbb+4HxHG+cDiJlukoSjAx31cVlPUT
SlZBvSIC7islvQshNdS7NGnB9GgPAHFM8odbPB3IYzMsjkMNUOg=
=CXyE
-----END PGP SIGNATURE-----

--nextPart2163591.UBLyODYZFQ--



