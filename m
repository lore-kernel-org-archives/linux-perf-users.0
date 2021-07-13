Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE7DC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3582861178
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 19:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhGMTs4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:48:56 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34164 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhGMTs4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 15:48:56 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4304EC0B5D;
        Tue, 13 Jul 2021 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1626205566; bh=yw3ZOBRxrXFibJ+0PSyhgbfdGfWwp+yDpVA+pWtOAoE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SRiX2xWoRLRzLmIZXvcfmob39NFbjT5GBvAu6HCKTvk7s04BBLq1NYyWMZ4fR0/oH
         +tNT6dqmkv9+Mib6238WjGP+NS5HJdbMJk/4dcksDTPAdhgtuBXtOHLxKPpOkuj/Ia
         TA9sZVhLDJIlvHPi+Ap1LmKrklH93MZvLqWUAaNIV2vFmUNsrFGEaFachMNWdUuRfR
         8TKcHeYzPma0mMofer34JSvAjrj2L/VToFZ4oeBLzpznWEYv2CyBZh9WoKotDdSEl3
         O+782d4ZadZpSit53Ey9Z8Kc2kmm48ANlDDaBqsP5wXcAFPKQ9LOCBnadsrVU4ZdRn
         oI5kIFlPnbwlQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7E7C8A0236;
        Tue, 13 Jul 2021 19:46:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7C8568012F;
        Tue, 13 Jul 2021 19:46:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dEXOXdWV";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDlVpBOY4pGok/gbNYhDqsiCWm2MeGef5PuiIO6bDrb+PZsoTdwpF1UU71f/044OBeZSqeBfWK3Ie0KO8sInqJVgcIfpQy6EdX07BUozR9NXfH/9EdOWqFiIi46MdYoiqgaVTZvt2fxpWrRaVPf/JZzffEfArKbcKIrWKEyFJR/GS2CRz8lT6U5OZVLB9Y63A04XDCKCe1BxX5SywU8RdOAiJ+uL9M+hHbsFmGp3nDUjiXwncdrTfGdqDN2OotZH4I1rSXZHn+QUmQgejBdNFTdOXjqZU2vhWLJvswb46XcJ+j+6OetTApRYTDzu0znlTm8om0b2JsYQpJQ3gzwwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw3ZOBRxrXFibJ+0PSyhgbfdGfWwp+yDpVA+pWtOAoE=;
 b=F7sQXpwVpgo1kiO36FvDEtM+hlL4YfJvpwVQH5dA4ynoioo6Nn2LhHIreLRBOtM+wz8c7d0qJQCdjLYdbt39idjKkzdTim+jq8R37E7bzTpbdAzi/9lyv/UmLIAW3y6un0kj61OHJ3rIBySepFASwtXIigeFwQe8R/Ml5akn1IN6NNdWeoYiE+j5UmGqwStbqACPfY3b1xkJUvwJ1RC/jfn+7Tf5YlGfQKaqFuZlcGE4IcJ2OT8hMxCAq+FLNFBpFhmLHRIqFQGL3pADvTr7QlKKV0GjuS9wYYSB9BsqQngc9Cf2xTWhxArwWLCcQF34eE4UG5BK6KJIKhAdSjA+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw3ZOBRxrXFibJ+0PSyhgbfdGfWwp+yDpVA+pWtOAoE=;
 b=dEXOXdWVMLBdjbjShDpmaQDfNhQYnxZz1VHTkG3JzyIY8ZRbxqyhGnEGC4CJaK98OqlFabmG1tBuY1IpVF9DyJrZdYOyfUDGdxwC7DYbM65MrhFsDcjU6m2iVJfczl6TxzyMc0CLsz07Ct1c6zxJjdXaBcC5ioHAF6i5Ex7LaQM=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 19:45:58 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 19:45:58 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Jinchao Wang <wjc@cdjrlc.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] arc: Prefer unsigned int to bare use of unsigned
Thread-Topic: [PATCH] arc: Prefer unsigned int to bare use of unsigned
Thread-Index: AQHXalBcTEAyUhxHyEaxa2ncALew5qtBasYA
Date:   Tue, 13 Jul 2021 19:45:58 +0000
Message-ID: <f8035ca9-9bc7-7d96-639f-ccfd1207f3c0@synopsys.com>
References: <20210626055828.29207-1-wjc@cdjrlc.com>
In-Reply-To: <20210626055828.29207-1-wjc@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: cdjrlc.com; dkim=none (message not signed)
 header.d=none;cdjrlc.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5b94305-8302-4e49-548a-08d94636d66a
x-ms-traffictypediagnostic: BYAPR12MB2901:
x-microsoft-antispam-prvs: <BYAPR12MB29011FB158C0DF85DA5A30A1B6149@BYAPR12MB2901.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTuoWJ452cRLlAn3NXaWNTJ4qu2aOWoxKGdlra8Zl6DATfLnbwsTCOR2Zy5z+O+JGxnz+krJKt03Oair+U5svbm+A0QQzdvyV4F7AiroW7xesgyPDOrR/iI5H7a+IaENEzj84ksyRuP1qEoR9tLxeYruB4EWtYITxNrTILeq3gIXquU6c2q5x2xm3tcFtWzr4MX3Hwq10iQPOUzMxvv5tnbP6fzriLXfq0X2KiJCvWR3gxjeNOvslQCpsEozX+Rh6mexXRqDbNxYPT8m9VA6a7dbS21ebYavNCsk3WAzfpBX2EKowDrOUgmesC9IvJ9fL9TT2wPieZe/4YQx0GuqX+Dc7W6hoAuOLybJ8vmseFglztg5/ra7voYl9chqKzA7yWBox9NTd88jNMEXoPU4wfeTwHKt+kmlBZQHPDWwZgi6VBQkkTtWDeZwG+nil4ROP3sBmUfAikNDv15E18D7YILVDSb2OJyMBLQS2xHS1bBuQGZulZeGO6/UPAvnB5DiQhrMWTP/QyJJRio9LHFmuf095cmx490BTof+4WwKLc3GtVQ2WMvhH97YuIi0ZkchSt7rmfatrxsxjzC4ZfMDhrdDRpVFzyhhdMIqtBGpsvSXlnW/zp5V+HomvOiGxfH9wTxheppVI2WSUfXkVgFXL1UTRyVM+PbfOGz/XtdFHwCB4csEOcozFuCqcQqqF1v3UwY5fjqEq63J8pJcV7lBpB3+vrG4/PyCItq+gmBoCvi2qJdcT6w5yP1Wsn/yKUma
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(396003)(346002)(38100700002)(110136005)(71200400001)(6512007)(31696002)(31686004)(2906002)(7416002)(2616005)(4326008)(478600001)(316002)(83380400001)(76116006)(6486002)(8676002)(54906003)(66556008)(64756008)(6506007)(26005)(8936002)(5660300002)(186003)(86362001)(66476007)(53546011)(66446008)(66946007)(36756003)(122000001)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1lLWGUxekhRVXVyalNWdEVjQmwxUW9VekNXTUZTb2RmMGNRaVRJNDJLN3NC?=
 =?utf-8?B?UGpCbU5GVzNvcVFpSXc5cGtiU1VUWlYwTnVrU2dUcitzellJMzc0Nm5DaTdY?=
 =?utf-8?B?Yk1FMWZuaDY4WTFnQzBGclJjS2pwNXRsNVdVNUZmeEY3TE1XMytrUlFkcDhm?=
 =?utf-8?B?Yzkxbmp6dzRxWnNDR2FhOTdEVDUvMU5zZXlnQ1hPeXhuSDNmNjErdUl2R0la?=
 =?utf-8?B?ZjhEeVJKWjcraDdYWklpL1F6WWJhS1c4R3FMeWRLR2xaNnNwNmNjaXdqZVVZ?=
 =?utf-8?B?cnc3dCt3T3hEMklVdUlXa2N1czRTWVBHcVJBL29FTzBwZ0gwM1M5dHJyc0Qy?=
 =?utf-8?B?Y0pHbUJ1MitCbmh3eHIvZmtwclpZdnJKRVVpRGpOTjVmU1NWakFxOXc3elo3?=
 =?utf-8?B?OFdNSFJiR1J2NXUvRWlIZCtWY1VpczAvOUVSVmdTajVIU2pkeDBxNC9TdGJK?=
 =?utf-8?B?MWlpVXhKalducWxESXptMTQrYm4xUzFxakNlRFZUaENOUm5EdEhsNS9jMllr?=
 =?utf-8?B?US9jdGRvWHZOU1dNS0lJZmVqNTNOQWVSbnIwWkFTd2MxcVRPMllvR1pxL0Vk?=
 =?utf-8?B?bExzcDd2cEtqOG5FeFEwazNaeDNnbjVPNXhidk1IRFRhczVtYm9XOThGRFg1?=
 =?utf-8?B?aEpxU1c0Q1podXdIVWxlUklMOWJLZnJRYkhodzQvYTdnV0ZQTFZUNWRZZWUv?=
 =?utf-8?B?bVo5Mm1Xby9uMXdPOFZBOGFTVmxrZ0NqWVJuTzVTbTd1OWhEaGpTanRpUjI1?=
 =?utf-8?B?ZmwxTWEvMXlYZ2N5SkY0MGh0emRMMjB6K1c1RlBRR1hxbFUxRzlPd1BEbGhp?=
 =?utf-8?B?SjJFeDR1cUVtWmJCQStwbENPY04reTFWUUduK09UUjNMdXJ5OWJPZzdPUUhp?=
 =?utf-8?B?N2FsUktHNk9SNm1zWXpqdFBFLytSWUNTK0pPY3FUd0d2M29tOWpNcENSREh6?=
 =?utf-8?B?VmNNckFJL3llbHkrN2dxaXd1QnNzRzZSQldyVWJ1V2c5ZUxydlJtR0F3RW83?=
 =?utf-8?B?b2NhYUtaUUcyTlZ2c3FhTUlGQlBKMlN2dEZWSW5rRzBxR1pMVEpoVDBpUzNM?=
 =?utf-8?B?R2UyZUkrRXZkQ3JmMSttRisyaHp6MmtoNTBSN3VUckMzUFI0dENDeURaK2Yr?=
 =?utf-8?B?bURZTlhxbnQ1UVhkZWsyVUh5ZlJ1VTljblZHMG9iZVRQY1FKcnVwcG5oaDBq?=
 =?utf-8?B?QVhEcGpVT3I4TEJQZzVyeDJSc0JuL3B4d1lzdkUwb1g1V2E1RnZhQUR3bWVp?=
 =?utf-8?B?cUNiYXQ0a1RjRkhIN0xiMXVFRDhFblJBN2FIMndJQTZpUC93aWROY0FEWW83?=
 =?utf-8?B?dEgyYThJYUg0dS9CQkNxbXNFRkMvcG80UTVGODQxK3NBMkZ1YmpGaDVqVGFx?=
 =?utf-8?B?NUtNc01RN3ZIZGc4bHFhL2tSZTlyTlptSFNJY29oSk9vMHFrK2swUEdDbWNC?=
 =?utf-8?B?RnNHU3FBUW1YcWlORG9BSDZZVTZ5M0d5UnBaSVhBVFFYTlZiNHlWZjhnRkpH?=
 =?utf-8?B?VU5GZGRCemFzd2lYaE1qWlI5aFJNdjhyZEh6ZjJBYnpyQUdpdVNrcnhzdVg2?=
 =?utf-8?B?eHZpNFQ5M0JJYjRzUlFUNk9JemUzNGVhVkV6M1BNTkkvNktBdlpua0trcG0v?=
 =?utf-8?B?aGtEZkRGVldRN2dwTzZ6UTNNUVhybmxDeEtVSFRXeGVBV0RXSHBLZWd5KzQ1?=
 =?utf-8?B?QzdmeERuVWx6N3ZxRk5jRkdSa3JBSVJMSjNMZ2cya1R2WHZ5bEE1RGZkOU5r?=
 =?utf-8?Q?yqzoF3WmtCZXdqJgAk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E7AED1CE16D2B4394FEC40A10EDFE91@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b94305-8302-4e49-548a-08d94636d66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 19:45:58.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbLZJIMc4Z+9Hc3H81ISQN5WkoRfzKKg3olJ9Zqxc2FBBd8wXVhpAOWBSAtC8lxmber4Xmk97WHhqoYHfeVE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2901
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

T24gNi8yNS8yMSAxMDo1OCBQTSwgSmluY2hhbyBXYW5nIHdyb3RlOg0KPiBGaXggY2hlY2twYXRj
aCB3YXJuaW5nczoNCj4gICAgICBXQVJOSU5HOiBQcmVmZXIgJ3Vuc2lnbmVkIGludCcgdG8gYmFy
ZSB1c2Ugb2YgJ3Vuc2lnbmVkJw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKaW5jaGFvIFdhbmcgPHdq
Y0BjZGpybGMuY29tPg0KDQpUaHggZm9yIHRoZSBmaXguIEFkZGVkIHRvIGZvci1jdXJyDQoNCi1W
aW5lZXQNCg==
