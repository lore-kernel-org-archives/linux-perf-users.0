Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD7C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 16:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347275AbhLBQKl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:10:41 -0500
Received: from algol.kleine-koenig.org ([162.55.41.232]:40658 "EHLO
        algol.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbhLBQKl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 11:10:41 -0500
X-Greylist: delayed 2592 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2021 11:10:40 EST
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 7037B1B895B;
        Thu,  2 Dec 2021 17:07:17 +0100 (CET)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id r1UKWp54YrC2; Thu,  2 Dec 2021 17:07:16 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b7c2:dbfc:4acd:9c00:d202:ebce])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu,  2 Dec 2021 17:07:16 +0100 (CET)
Message-ID: <f4518dad-b02a-368b-99d7-7a57b57f36eb@kleine-koenig.org>
Date:   Thu, 2 Dec 2021 17:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
Content-Language: en-US
To:     Branislav Rankov <branislav.rankov@arm.com>,
        James Clark <james.clark@arm.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
 <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
 <241b28ec-4acf-b30f-90c1-e1f7ef6c1443@arm.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
In-Reply-To: <241b28ec-4acf-b30f-90c1-e1f7ef6c1443@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------82Fmu32NBaCJbh4MCCLVPg20"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------82Fmu32NBaCJbh4MCCLVPg20
Content-Type: multipart/mixed; boundary="------------zLYSanCvkBOpNH9Gac25Hqnq";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Branislav Rankov <branislav.rankov@arm.com>,
 James Clark <james.clark@arm.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Message-ID: <f4518dad-b02a-368b-99d7-7a57b57f36eb@kleine-koenig.org>
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
 <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
 <241b28ec-4acf-b30f-90c1-e1f7ef6c1443@arm.com>
In-Reply-To: <241b28ec-4acf-b30f-90c1-e1f7ef6c1443@arm.com>

--------------zLYSanCvkBOpNH9Gac25Hqnq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIvMi8yMSAxNzowMCwgQnJhbmlzbGF2IFJhbmtvdiB3cm90ZToNCj4gSSBkaWQgbm90
IGhhdmUgcHJvYmxlbXMgd2hlbiB0cnlpbmcgY3Jvc3Njb21waWxlIGluIGJvdGggZHluYW1p
YyBhbmQgc3RhdGljIGNhc2UuDQo+IEJ1dCBtYXliZSB5b3UgaGF2ZSBhIGNhc2Ugd2hlcmUg
dGhpcyBpcyBhIHByb2JsZW0uIEkgd291bGQgbGlrZSB0byB1bmRlcnN0YW5kIHdoYXQNCj4g
eW91ciBjYXNlIGlzLg0KPiBEb2VzIHlvdXIgbGliT3BlbkNTRC5zbyBoYXZlIGEgZGVwZW5k
ZW5jeSBvbiBsaWJzdGRjKysuc28/DQo+IElmIHNvLCB3aGVyZSBpcyB0aGUgbGlic3RkYysr
LnNvPw0KDQpBcyBub3RlZCBpbiBhbiBvdGhlciB0aHJlYWQgYnJhbmNoOiBJIGhhdmUgbGli
c3RkYysrLnNvLjYuMC4yOSBidXQgbm90IA0KbGlic3RkYysrLnNvLiBGb3IgbGlua2luZyB0
aGlzIGlzIGVub3VnaCBhcyB0aGUgYmluYXJ5IHRoYXQgaXMgbGlua2VkIA0KZG9lc24ndCBu
ZWVkIGFueSBzeW1ib2xzIGZyb20gbGlic3RkYysrLnNvLg0KDQo+IElmIHRoaXMgaXMgYSBn
ZW51aW5lIHByb2JsZW0sIHdlIGNvdWxkIGFkZCAtbHN0ZGMrKyBjb25kaXRpb25hbGx5IG9u
bHkgZm9yIHRoZQ0KPiBzdGF0aWMgYnVpbGQuDQoNClRoYXQgc2VlbXMgdG8gYmUgdGhlIHBh
dGggdG8gZ28gdGhlbi4NCg0KQmVzdCByZWdhcmRzDQpVd2UNCg==

--------------zLYSanCvkBOpNH9Gac25Hqnq--

--------------82Fmu32NBaCJbh4MCCLVPg20
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGo7ycACgkQwfwUeK3K
7AlTAgf/Vlq7/0c8V4/F4EsnPnpOi79yqkmghLXVgdAi3/U9zhECOL+zkWHph3nP
HNQf7b696seSN3D7AACYG1YBFKu3CXrkCrHQVWIAZFY6+oogxA1AOfgxHEMXzoKo
UqVJqRuyM3Yk0KlzyZ6jaCj279GjAwJmMd5G5LCb5f6T5Czc+yG0HdnPdG+v78G8
NEfVIiP0dpvwbUKAhpZQoMaeEdxrancQ9hi60RYmRu9ExSf92fzsITT8NW01yySk
oRr2+rF+a1dyZBFSjmZ2I0dElz3Shc2vuQ+bfK/i/OWHYwuybY8fnV8/VoUefyIS
0pbHLDPj0NOBZQP9H7FV4RmDOC1EIw==
=IpN2
-----END PGP SIGNATURE-----

--------------82Fmu32NBaCJbh4MCCLVPg20--
