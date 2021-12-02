Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBFBC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347557AbhLBPfx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbhLBPfw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 10:35:52 -0500
X-Greylist: delayed 505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Dec 2021 07:32:29 PST
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A5C06174A
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Dec 2021 07:32:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 570F01B87A0;
        Thu,  2 Dec 2021 16:24:00 +0100 (CET)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id tgLV4Xv-Lpjz; Thu,  2 Dec 2021 16:23:59 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b7c2:dbfc:4acd:9c00:d202:ebce])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu,  2 Dec 2021 16:23:59 +0100 (CET)
Message-ID: <c92d401b-cf53-e27e-b26d-870463494df1@kleine-koenig.org>
Date:   Thu, 2 Dec 2021 16:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Bunk <bunk@debian.org>
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
In-Reply-To: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kyGEEI0acnzmRWxoCaJzL1h4"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kyGEEI0acnzmRWxoCaJzL1h4
Content-Type: multipart/mixed; boundary="------------5aoDVM3L5nQ5p907nzXEgDaA";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Bunk <bunk@debian.org>
Message-ID: <c92d401b-cf53-e27e-b26d-870463494df1@kleine-koenig.org>
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>

--------------5aoDVM3L5nQ5p907nzXEgDaA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgcGlja2VkIHRoZSB3cm9uZyBzY3JpcHQgc28gdGhlIHNlbmRlciBhZGRy
ZXNzIHdhcyB3cm9uZy4gSSBhc3N1bWUgSSdsbCANCmhhdmUgdG8gZml4IHRoYXQuIFdpbGwg
cGF5IG1vcmUgYXR0ZW50aW9uIGZvciB2Mi4NCg0KT24gMTIvMi8yMSAxNDo0MywgVXdlIEts
ZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xl
aW5lLWtvZW5pZy5vcmc+DQo+IA0KPiBXaGVuIGNyb3NzIGNvbXBpbGluZyBvbiBhbWQ2NCBm
b3IgYXJtNjQgdGhlIGJ1aWxkIGZhaWxlZCBvbiBteSBtYWNoaW5lIHdpdGg6DQo+IA0KPiAJ
TWFrZWZpbGUuY29uZmlnOjQ5MzogKioqIEVycm9yOiBObyBsaWJvcGVuY3NkIGxpYnJhcnkg
Zm91bmQgb3IgdGhlIHZlcnNpb24gaXMgbm90IHVwLXRvLWRhdGUuIFBsZWFzZSBpbnN0YWxs
IHJlY2VudCBsaWJvcGVuY3NkIHRvIGJ1aWxkIHdpdGggQ09SRVNJR0hUPTEuICBTdG9wLg0K
PiANCj4gZXZlbiB0aG91Z2ggbGlib3BlbmNzZCB3YXMgaW5zdGFsbGVkIChmb3IgYm90aCBh
bWQ2NCBhbmQgYXJtNjQpLiBBZnRlcg0KPiBzb21lIGRpZ2dpbmcgYXJvdW5kIEkgZm91bmQg
dGhlIHJlbGV2YW50IGVycm9yIG1lc3NhZ2UgaW4NCj4gdG9vbHMvcGVyZi9mZWF0dXJlL3Rl
c3QtbGlib3BlbmNzZC5tYWtlLm91dHB1dDoNCj4gDQo+IAkvdXNyL2xpYi9nY2MtY3Jvc3Mv
YWFyY2g2NC1saW51eC1nbnUvMTEvLi4vLi4vLi4vLi4vYWFyY2g2NC1saW51eC1nbnUvYmlu
L2xkOiBjYW5ub3QgZmluZCAtbHN0ZGMrKw0KPiANCj4gSW5zdGVhZCBvZiBmaXhpbmcgdGhl
IGVycm9yIG1lc3NhZ2UgdG8gYWxzbyBpbmNsdWRlIGEgcmVxdWVzdCB0byBpbnN0YWxsDQo+
IGxpYnN0ZGMrKywganVzdCBkcm9wIC1sc3RkYysrLiBXaXRoIHRoaXMgY2hhbmdlIHRoZSBi
dWlsZCBjb21wbGV0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5p
ZyA8dXdlQGtsZWluZS1rb2VuaWcub3JnPg0KPiAtLS0NCj4gSGVsbG8sDQo+IA0KPiBub3Qg
c3VyZSB0aGlzIGlzIGEgcHVyZSBjcm9zcyBjb21waWxhdGlvbiBwcm9ibGVtLiBJIHRoaW5r
IGluIGdlbmVyYWwNCj4gaXQncyBhIGJhZCBpZGVhIHRvIGxpbmsgYWdhaW5zdCBsaWJzdGRj
KysgZXhwbGljaXRseS4gU3RpbGwgbW9yZSBpZg0KPiB0aGVyZSBpcyBubyBDKysgaW52b2x2
ZWQuDQoNCkluIHRoZSBtZWFudGltZSBJIHdhcyBwb2ludGVkIHRvIDU3M2NmNWM5YTE1MiAo
InBlcmYgYnVpbGQ6IEFkZCBtaXNzaW5nIA0KLWxzdGRjKysgd2hlbiBsaW5raW5nIHdpdGgg
bGlib3BlbmNzZCIpLCBhbmQgSSB3b25kZXIgd2hhdCBJJ20gbWlzc2luZy4gDQpNYXliZSBt
eSBwYXRjaCBicmVha3MgdGhlIGJ1aWxkIGlmIGxpYm9wZW5jc2QgaXMgb25seSBhdmFpbGFi
bGUgYXMgLmE/DQoNCkkgYWRkZWQgdGhlIHBlb3BsZSBpbnZvbHZlZCBpbiB0aGF0IGNvbW1p
dCB0byBDYzogYW5kIGxvb2sgZm9yd2FyZCB0byANCmRldGFpbHMuIFRoZSBtb3RpdmF0aW9u
IHRvIGFkZCAtbHN0ZGMrKyBzZWVtcyB0byBiZSAiSXQgZG9lcyBub3QgaHVydCIgDQp3aGlj
aCBpcyBhIGJpdCB3ZWFrLg0KDQpCZXN0IHJlZ2FyZHMNClV3ZQ0K

--------------5aoDVM3L5nQ5p907nzXEgDaA--

--------------kyGEEI0acnzmRWxoCaJzL1h4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGo5QoACgkQwfwUeK3K
7AnNtgf/UQzSdqV4tWvVwG9LnNI8p3x2oaj0NDtChPsf9+pEoJuFgbPICE0E89XH
tK8F2NGM06NPrcba2hoDAgfOB2QQJCCGEcNnVPRB2L+A1efRpcQEYIZ4OBHQdaKZ
BSPtICm+SxZnxVz2wAuvPYLzPcFP340ji6T+6aC2T/ypzfwigy35+QVJPjABmAO+
S/vPGiqBuhWAVwchcKfVjWVeR9NiHhZrtQlWaCdKzHBZH6UDPw1dZK/lHT6SxwkK
odIj0QqlZJrR8UdnCoFLhWz6sG2kU8TyvPobJl41kOvrHG74v+mkVHrFpMASRDln
kzGjoBIVGOaqovVevOHPd/nBtnk3Eg==
=+kRg
-----END PGP SIGNATURE-----

--------------kyGEEI0acnzmRWxoCaJzL1h4--
