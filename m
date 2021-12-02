Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC0C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 16:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347643AbhLBQHX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242221AbhLBQHW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 11:07:22 -0500
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C84C06174A
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Dec 2021 08:03:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 4DE561B8937;
        Thu,  2 Dec 2021 17:03:57 +0100 (CET)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id YOGc4JJg3HQO; Thu,  2 Dec 2021 17:03:56 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b7c2:dbfc:4acd:9c00:d202:ebce])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu,  2 Dec 2021 17:03:56 +0100 (CET)
Message-ID: <36cc4dc6-bf4b-1093-1c0a-876e368af183@kleine-koenig.org>
Date:   Thu, 2 Dec 2021 17:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Branislav Rankov <branislav.rankov@arm.com>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
 <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
In-Reply-To: <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZdXinhUZCYf3mSPL9Vk3TJbH"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZdXinhUZCYf3mSPL9Vk3TJbH
Content-Type: multipart/mixed; boundary="------------1cx8RMVS0R4H8VSIceK736Ux";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: James Clark <james.clark@arm.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Branislav Rankov <Branislav.Rankov@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Branislav Rankov <branislav.rankov@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>
Message-ID: <36cc4dc6-bf4b-1093-1c0a-876e368af183@kleine-koenig.org>
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
 <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
In-Reply-To: <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>

--------------1cx8RMVS0R4H8VSIceK736Ux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCk9uIDEyLzIvMjEgMTY6MzYsIEphbWVzIENsYXJrIHdyb3RlOg0KPiBPbiAw
Mi8xMi8yMDIxIDEzOjQzLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4+IEZyb206IFV3
ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+DQo+Pg0KPj4gV2hlbiBj
cm9zcyBjb21waWxpbmcgb24gYW1kNjQgZm9yIGFybTY0IHRoZSBidWlsZCBmYWlsZWQgb24g
bXkgbWFjaGluZSB3aXRoOg0KPj4NCj4+IAlNYWtlZmlsZS5jb25maWc6NDkzOiAqKiogRXJy
b3I6IE5vIGxpYm9wZW5jc2QgbGlicmFyeSBmb3VuZCBvciB0aGUgdmVyc2lvbiBpcyBub3Qg
dXAtdG8tZGF0ZS4gUGxlYXNlIGluc3RhbGwgcmVjZW50IGxpYm9wZW5jc2QgdG8gYnVpbGQg
d2l0aCBDT1JFU0lHSFQ9MS4gIFN0b3AuDQo+Pg0KPj4gZXZlbiB0aG91Z2ggbGlib3BlbmNz
ZCB3YXMgaW5zdGFsbGVkIChmb3IgYm90aCBhbWQ2NCBhbmQgYXJtNjQpLiBBZnRlcg0KPj4g
c29tZSBkaWdnaW5nIGFyb3VuZCBJIGZvdW5kIHRoZSByZWxldmFudCBlcnJvciBtZXNzYWdl
IGluDQo+PiB0b29scy9wZXJmL2ZlYXR1cmUvdGVzdC1saWJvcGVuY3NkLm1ha2Uub3V0cHV0
Og0KPj4NCj4+IAkvdXNyL2xpYi9nY2MtY3Jvc3MvYWFyY2g2NC1saW51eC1nbnUvMTEvLi4v
Li4vLi4vLi4vYWFyY2g2NC1saW51eC1nbnUvYmluL2xkOiBjYW5ub3QgZmluZCAtbHN0ZGMr
Kw0KPiANCj4gRG8geW91IGhhdmUgdGhpcyBsaWJyYXJ5IGluc3RhbGxlZCBmb3IgYXJtNjQ/
IEkga25vdyB5b3Ugc2FpZCB5b3UgaGFkIE9wZW5DU0QgaW5zdGFsbGVkLCBidXQNCj4gbWF5
YmUgdGhlIGFybTY0IHN0ZGMrKyBsaWIgaXMgbWlzc2luZz8NCg0KWWVzLCBJIGhhdmUgbGli
c3RkYysrIGluc3RhbGxlZCwgYnV0IG9ubHkgdGhlIGxpYnN0ZGMrKy5zby42LjAuMjksIG5v
dCANCnRoZSBwbGFpbiAuc28uIFRoZSBmb3JtZXIgaXMgZW5vdWdoIHRvIHJ1biBjKysgYmlu
YXJpZXMsIHRoZSBsYXR0ZXIgaXMgDQpvbmx5IG5lZWRlZCBmb3IgbGlua2luZy4gQXMgbm9u
ZSBvZiB0aGUgc3ltYm9scyBpbiBsaWJzdGRjKysgaXMgbmVlZGVkIA0KZm9yIHRoZSBrZXJu
ZWwgdG9vbHMsIG5vdCBoYXZpbmcgdGhlIC5zbyB3b3JrcyBmaW5lLg0KDQo+PiBJbnN0ZWFk
IG9mIGZpeGluZyB0aGUgZXJyb3IgbWVzc2FnZSB0byBhbHNvIGluY2x1ZGUgYSByZXF1ZXN0
IHRvIGluc3RhbGwNCj4+IGxpYnN0ZGMrKywganVzdCBkcm9wIC1sc3RkYysrLiBXaXRoIHRo
aXMgY2hhbmdlIHRoZSBidWlsZCBjb21wbGV0ZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
VXdlIEtsZWluZS1Lw7ZuaWcgPHV3ZUBrbGVpbmUta29lbmlnLm9yZz4NCj4+IC0tLQ0KPj4g
SGVsbG8sDQo+Pg0KPj4gbm90IHN1cmUgdGhpcyBpcyBhIHB1cmUgY3Jvc3MgY29tcGlsYXRp
b24gcHJvYmxlbS4gSSB0aGluayBpbiBnZW5lcmFsDQo+PiBpdCdzIGEgYmFkIGlkZWEgdG8g
bGluayBhZ2FpbnN0IGxpYnN0ZGMrKyBleHBsaWNpdGx5LiBTdGlsbCBtb3JlIGlmDQo+PiB0
aGVyZSBpcyBubyBDKysgaW52b2x2ZWQuDQo+IA0KPiBUaGlzIC1sc3RkYysrIHdhcyBvbmx5
IGp1c3QgYWRkZWQgYSBmZXcgbW9udGhzIGFnbyBieSBCcmFuaXNsYXYgc28gSSdtDQo+IG5v
dCBzdXJlIGlmIGl0IHNob3VsZCBiZSByZW1vdmVkLg0KDQpUaGlzIGlzIGEgcG9vciByZWFz
b25pbmcgaW4gbXkgZXllcy4gT3ZlcnN0YXRpbmc6IFdlIGRpZG4ndCBzdWZmZXIgbG9uZyAN
CmVub3VnaCBmcm9tIHRoaXMgcHJvYmxlbSwgbGV0J3Mga2VlcCBpdCBhcm91bmQgZm9yIGEg
d2hpbGUuDQoNCkkgd291bGQgaG9wZSB0aGF0IGdpdmVuIHRoZSBjaGFuZ2UgaXNuJ3QgdGhh
dCBvbGQgd2UgaGF2ZSBhIGdvb2QgY2hhbmNlIA0KdG8gZmluZCBvdXQgZW5vdWdoIGRldGFp
bHMgdG8gZmluZCBhIGdvb2QgZml4Lg0KDQpCZXN0IHJlZ2FyZHMNClV3ZQ0K

--------------1cx8RMVS0R4H8VSIceK736Ux--

--------------ZdXinhUZCYf3mSPL9Vk3TJbH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGo7mgACgkQwfwUeK3K
7AkoOQf9EgoKSvpiAbyFnHuw9kgCcdHicdso44LK01YlNWdCrIWrp0lIHGH1i905
AjqOY5xInIP82Q/dNykxkJXb8S9mZH5X1kvfYaupCwZr5LdueyHI3CDMgaZheUAD
tibbqgkwG1NdY8HiAE2zkMMBvXDgjXnUM/1R18OFZpBBreFpu1b+Y7oZ+7WYfmRs
P5rSVOiuuefmoeQ3+gJmhOPHe7mIZgqs/YdmmgZT9M6rC2FzVJwuz8XtrmRCf9m0
Z3rDJzejypuPpkT+tU4hR2M18lKsfc61XwinnKMgVTqVH+F5fWAqqyajArG/XgQx
rbphg183Y38RGkXPemJgeZt7GL8BgQ==
=4AuR
-----END PGP SIGNATURE-----

--------------ZdXinhUZCYf3mSPL9Vk3TJbH--
