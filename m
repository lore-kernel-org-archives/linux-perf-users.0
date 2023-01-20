Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B554C25B4E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 08:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjATIwG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 03:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATIwG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 03:52:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E374960
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 00:52:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-313--Lfi9qISPHGbgb-YRNfUNQ-1; Fri, 20 Jan 2023 08:52:01 +0000
X-MC-Unique: -Lfi9qISPHGbgb-YRNfUNQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Jan
 2023 08:51:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 20 Jan 2023 08:51:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnaldo Carvalho de Melo' <acme@kernel.org>
CC:     'Athira Rajeev' <atrajeev@linux.vnet.ibm.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "rnsastry@linux.ibm.com" <rnsastry@linux.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "disgoel@linux.ibm.com" <disgoel@linux.ibm.com>
Subject: RE: [PATCH V3] tools/perf/tests: Fix string substitutions in build id
 test
Thread-Topic: [PATCH V3] tools/perf/tests: Fix string substitutions in build
 id test
Thread-Index: AQHZLBIrp7uRxIXInkOHsORdTF5RZK6l4s+wgAAT9YCAAQmokA==
Date:   Fri, 20 Jan 2023 08:51:59 +0000
Message-ID: <8c433a543cda48e5b736312903355918@AcuMS.aculab.com>
References: <20230119142719.32628-1-atrajeev@linux.vnet.ibm.com>
 <1a2f988593a4403db2a043ff42886ced@AcuMS.aculab.com>
 <Y8l3C8LOohZvQOKH@kernel.org>
In-Reply-To: <Y8l3C8LOohZvQOKH@kernel.org>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Arnaldo Carvalho de Melo
> Sent: 19 January 2023 17:00
> 
> Em Thu, Jan 19, 2023 at 03:49:15PM +0000, David Laight escreveu:
> > From: Athira Rajeev
> > > Sent: 19 January 2023 14:27
> > ...
> > > The test script "tests/shell/buildid.sh" uses some of the
> > > string substitution ways which are supported in bash, but not in
> > > "sh" or other shells. Above error on line number 69 that reports
> > > "Bad substitution" is:
> >
> > Looks better - assuming it works :-)
> 
> :-)
> 
> Can I take this as an:
> 
> Acked-by: David Laight <David.Laight@ACULAB.COM>

I'm not sure that is worth anything.
You can add a Reviewed-by

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

