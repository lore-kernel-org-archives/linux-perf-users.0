Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AF6C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17830229CA
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbhAKRJG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:09:06 -0500
Received: from dd17628.kasserver.com ([85.13.138.83]:52456 "EHLO
        dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbhAKRJG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Jan 2021 12:09:06 -0500
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2021 12:09:05 EST
Received: from milian-workstation.localnet (p4fd6c50d.dip0.t-ipconnect.de [79.214.197.13])
        by dd17628.kasserver.com (Postfix) with ESMTPSA id D05C5628020F;
        Mon, 11 Jan 2021 17:59:04 +0100 (CET)
From:   Milian Wolff <mail@milianw.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kenel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: missing mmap events in perf profiles without dwarf callgraph
Date:   Mon, 11 Jan 2021 17:56:52 +0100
Message-ID: <8218693.uYs0DeGetE@milian-workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart64417816.6HeEPmrY30"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart64417816.6HeEPmrY30
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Milian Wolff <mail@milianw.de>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kenel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: missing mmap events in perf profiles without dwarf callgraph
Date: Mon, 11 Jan 2021 17:56:52 +0100
Message-ID: <8218693.uYs0DeGetE@milian-workstation>

Hey there,

in hotspot I noticed a symbolization bug for perf.data files that are recorded 
without `--call-graph dwarf`, i.e. something like this:

```
$ cat test.c
int main()
{
    int sum = 0;
    for (int i = 0; i < 100000; ++i) sum += i;
    return sum > 0;
}
$ gcc -O0 -g test.c
$ perf record ./a.out
$ perf script --show-mmap-events | grep /a.out
           a.out 149719 18106.394277: PERF_RECORD_MMAP2 149719/149719: 
[0x55e0b3b5e000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
           a.out 149719 18106.394748:     275254 cycles:u:      55e0b3b5e72e 
main+0x25 (/tmp/a.out)
           a.out 149719 18106.395011:     486078 cycles:u:      55e0b3b5e72e 
main+0x25 (/tmp/a.out)
```

How does perf resolve the address 0x55e0b3b5e72e to main+0x25 here? If we look 
at this purely from the singular mmap event, this shouldn't be the case:

1) The mmap event starts at 0x55e0b3b5e000, has size 0x1000, so its end is at 
0x55e0b3b5f000.

2) Address 55e0b3b5e72e is thus contained in this map, and at offset 0x72e.

3) But main is not at this offset, it starts at 0x1709:

```
$ nm ./a.out | grep main
                 U __libc_start_main
0000000000001709 T main
```

How does perf report/script still get the right answer here and knows that 
there's an offset of 0x1000?

Note that in reality, multiple mmap events occur. And the first one maps the 
file at an address with the 0x1000 offset. This can be seen by:

```
$ perf record --call-graph dwarf ./a.out
$ perf script --show-mmap-events | grep /a.out
a.out 149953 18488.265340: PERF_RECORD_MMAP2 149953/149953: 
[0x55b2f29d2000(0x4000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
a.out 149953 18488.265346: PERF_RECORD_MMAP2 149953/149953: 
[0x55b2f29d3000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
a.out 149953 18488.265348: PERF_RECORD_MMAP2 149953/149953: 
[0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
a.out 149953 18488.265350: PERF_RECORD_MMAP2 149953/149953: 
[0x55b2f29d5000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
a.out 149953 18488.265706: PERF_RECORD_MMAP2 149953/149953: 
[0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
            55b2f29d372e main+0x25 (/tmp/a.out)
            55b2f29d372e main+0x25 (/tmp/a.out)
```

In this case, we see that the first mmap event happens at 0x55b2f29d2000, so 
if we take that as the base address, we arrive at the offset 0x172e for 
address 0x55b2f29d372e. This then indeed matches main+0x25, i.e.: 0x1709 + 
0x25 = 0x172e.

But... The question again is: How does perf stat/report know this fact with 
just the singular mmap event in the plain `perf record a.out` case above?
Why is there just one mmap event recorded in such a profile?

Thank you
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart64417816.6HeEPmrY30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEezawi1aUvUGg3A1+8zYW/HGdOX8FAl/8g1QACgkQ8zYW/HGd
OX9IWA/7BmEwpMJrQMdr7oYo5gkON/PkZ1S1ZPjuGIBjJE1QMmPz8THJZuX4NDKg
vtRYAccry0cwuv76pWErpUBaji+jJcOMQjmloRaDRecj/Tj8mm6LnuDViUiy97NN
k/loRXOHLsuEsnQk5TaNBQtHp2vetfHaCxQr4dO2qBPX/mLGwCm8NEIfRx4ZsFeH
4XyBDHJLRtLl1jmq5tG7pjFRe25q56pyFXqrTYKKslrNCkfp4sQ8GpvnwJJfoYYn
Fqq5He/lEO08fbbDSim6it4reY2PQcFRiHgTTOlSlDW31JEGYTOiNC3TP1OHGf/W
XafusOUZDRv2WPMz0a6zC28vNbdyJN50WM4GNc9PaYhco7xJJ1SUNywH703tfclY
3YTZ8FuF8bmemKddeymRHSgbBsazIn6yDRq54vsOEQN7KLuBbZpwR2d4HS56qjeR
6HQBUGS3gc+qtAqEim7JuLnpNEIflsKyIrfKYaGqF3XcKBxUlJQNtYkk7Ls6q2kc
E4AqFUAAaIhSm2UEoh9UKw26rvvuu8I424lkg5X/EQLkMhIfsJ4uX+3YKUx5IeXp
wmTqZ6albMWCQy7HjhUsU5rWjk00U7ZZNOdTDqw/ep5oQIup22yCUKpDSXNqirGD
Fy5tL6AGvWbC4Vooe9eaDR/GQMeamZyn8ZIiotAbjorUSGnOzbc=
=8Ytr
-----END PGP SIGNATURE-----

--nextPart64417816.6HeEPmrY30--



