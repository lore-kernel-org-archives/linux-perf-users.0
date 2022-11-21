Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8468C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Nov 2022 17:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKURHQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Nov 2022 12:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiKURHK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Nov 2022 12:07:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94459C9AA1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Nov 2022 09:07:06 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-5-0jD1zmPbSdxTdmQXO8pw-1; Mon, 21 Nov 2022 17:06:35 +0000
X-MC-Unique: 5-0jD1zmPbSdxTdmQXO8pw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 17:05:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Mon, 21 Nov 2022 17:05:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Rogers' <irogers@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] tools: perf: Use "grep -E" instead of "egrep"
Thread-Topic: [PATCH] tools: perf: Use "grep -E" instead of "egrep"
Thread-Index: AQHY/cm/j7DUfP5DF02juK/bir99ta5Jmc/w
Date:   Mon, 21 Nov 2022 17:05:35 +0000
Message-ID: <50f4e48bcdc4496f90f28d241ee42003@AcuMS.aculab.com>
References: <1668762999-9297-1-git-send-email-yangtiezhu@loongson.cn>
 <CAP-5=fXR58DQFkUW81KUs_f9cLTX=L28H1hkxXVzX3dUdRLBjw@mail.gmail.com>
 <ab41b1fe-4a59-2a6b-ee9f-785c98c48df5@loongson.cn>
 <CAP-5=fWtFktYKch+4Sv4zSHoW8SO96yEsyQgDKApyR20UjXhSA@mail.gmail.com>
In-Reply-To: <CAP-5=fWtFktYKch+4Sv4zSHoW8SO96yEsyQgDKApyR20UjXhSA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RnJvbTogSWFuIFJvZ2Vycw0KPiBTZW50OiAyMSBOb3ZlbWJlciAyMDIyIDE2OjUzDQouLi4NCj4g
TXkgZ3JlcCBpcyAzLjcgYW5kIGhhcyAtRSBzdXBwb3J0LiAuLi4NCg0KQXMgZG9lcyBncmVwIDIu
MTQgb24gbXkgVWJ1bnR1IDEzLjA0IHN5c3RlbS4NCg0KV2hpY2ggaXNuJ3QgdGhhdCBzdXJwcmlz
aW5nLg0KSUlSQyBTWVNWIGdyZXAgc3VwcG9ydGVkIC1FIH4xOTkwIGFuZCBnbnUgZ3JlcCBwcm9i
YWJseSBoYWQNCnRvIG1hdGNoIHRoZSBzeW50YXguDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

