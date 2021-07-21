Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C01C12002
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 11:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3243460FD7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 11:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhGUKvz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:51:55 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:19552
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239256AbhGUJwq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 05:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCBquauyynfzYz90IgG9iybvWXuVWac7vCnngC7cj8w=;
 b=HtDzTn45/MXWBsMnHsvQCVr7bwEWFq22vYvp7OUCcXngUUFZiYank91dwcWnNa1kyh+2w7MFKJd2TDsD7V5U9q76mw3gHcjEt0HFS9MIIJswSoSsL7jQrozzBpTJDSpYx8BJtjUzNWctRh+d625y+sVIofR1553dY+J9jh8xZwg=
Received: from DU2PR04CA0064.eurprd04.prod.outlook.com (2603:10a6:10:232::9)
 by AS8PR08MB7175.eurprd08.prod.outlook.com (2603:10a6:20b:406::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Wed, 21 Jul
 2021 10:33:21 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::7d) by DU2PR04CA0064.outlook.office365.com
 (2603:10a6:10:232::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 10:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 10:33:21 +0000
Received: ("Tessian outbound b269bca6e298:v99"); Wed, 21 Jul 2021 10:33:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f84d688195fedbd4
X-CR-MTA-TID: 64aa7808
Received: from ec7f684646af.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 95748713-DBF0-4532-9D42-1EEAC575EF5D.1;
        Wed, 21 Jul 2021 10:33:04 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ec7f684646af.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 21 Jul 2021 10:33:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6Dq8VCTCCu3Kz3HodgRfhwRsMPqhn3VSe6l0KCcL0wDTrc5YeUcoh3tUMakYoqP7x/bAce+g4W6O6Qbi0CrWOCkOkeWTmGyLKLPqEJ4TtvSF2BrVQLz9+Wumwf+uz8GOxvHXNtDR9eSgHSHqF00D2KsJqCf/Uk5dskFVraySELCnq64wzMMDT9xGcZDSStSB6s0ksuNoNvA7QwpLUyWJ7tPMQZ70f3pEz5oxVlvSDsn15M03r3t8z4SdnVpxJ7kLHxoKOQC5mbOf9Hmv3d2REUdS3sjGuaFIrOx32AdeRHCM3qPc5wYhrtOL+iX8z39SZ4AaTu4dZ8a1HAUAMdCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCBquauyynfzYz90IgG9iybvWXuVWac7vCnngC7cj8w=;
 b=AeaCGmX99WlrP2FYo10Au46UeaJJPB9uMcvlax+WdBeMeQQsoTkAR4pqdL6Wj+2T0Trne4wDsLE2MZ10tz2LjXlbRSbS6JxLz9DRHBri6YYeVuP136ugkfMBhjizlu5G0+92z46D+tCFBeyC9S51Atoc6GvsiSPOwQ+xMdj5PLI8rJiRI44pWm2WiXhRGJSrvXnGt3IEB/V9rbrTpddW7tYBDvfKX7jsxQnxbxMw5o9wQlD1DWO7Byc9G02gzlk3OCj1Fz5ZGHOsJpTFrovmEU4NQ2ig1VxwEd9KOFoU/J7E2TEH5TmlejELWewqniYR5dVDJU5S3fUk7E729DDAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCBquauyynfzYz90IgG9iybvWXuVWac7vCnngC7cj8w=;
 b=HtDzTn45/MXWBsMnHsvQCVr7bwEWFq22vYvp7OUCcXngUUFZiYank91dwcWnNa1kyh+2w7MFKJd2TDsD7V5U9q76mw3gHcjEt0HFS9MIIJswSoSsL7jQrozzBpTJDSpYx8BJtjUzNWctRh+d625y+sVIofR1553dY+J9jh8xZwg=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com (2603:10a6:20b:29c::13)
 by AM5PR0801MB1970.eurprd08.prod.outlook.com (2603:10a6:203:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 10:33:02 +0000
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::4cb0:5d8d:26b4:a9c5]) by AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::4cb0:5d8d:26b4:a9c5%4]) with mapi id 15.20.4331.032; Wed, 21 Jul 2021
 10:33:02 +0000
To:     coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Brown <Mark.Brown@arm.com>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>, nd@arm.com
From:   Branislav Rankov <branislav.rankov@arm.com>
Subject: [PATCH] perf build: Fix static linking with libopencsd.
Message-ID: <e88952b3-2470-da96-dee9-e247a1759cd0@arm.com>
Date:   Wed, 21 Jul 2021 11:32:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To AS8PR08MB6069.eurprd08.prod.outlook.com
 (2603:10a6:20b:29c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.35.153] (217.140.99.251) by LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1aa::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 10:33:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1b18b3-607d-47e3-6db4-08d94c32f63f
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1970:|AS8PR08MB7175:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB7175F5EAEDA4203C00B2F7D494E39@AS8PR08MB7175.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:813;OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rl0XuKWsv/gH1PScDuIHg7YAm5WmjpuyuGurJNinHxk7GSyPc7P6TCWN4J4RrWaA34R6Nghg7VChWcxawYkiIk/z3vFr/1LmHT5dvzkgL93O74abzNcaypYIFI0vP74brpnYqzmBdlzPE0buKZZD9lhYKjCjsT/rroksw2/rjlYP65YYfzJ+D6XK2wKyAHiPuP3PQ80Zi2BdhLInWRjq4OHpYqATwxOJXjpouvn/z9b5/nnwiHf161eAaBgTOYAUDGSct5bQ0xavmpDCKacPQKwzOUYj3tbRjmwOZQ92dXp5I2XYvoUOJs2DYSREHi84v9o3R0FrFZuhhlfz9RWDm55XYdSfimr08zDpntLAt9un/7IAsrqVIhhdCdcRmhXizrlSXcC9+K01hqQTGdSUSJTqybxwYofyy3/p0iIkTtCHVEkelzx088pu2KmPlg5MbO8OVQwZ8A4dA92rRamKR036G/uYQiM8S2iOe44+m3wsadf+eAFpgKwCEo8MHAUr7LcrZ5G4OZYrILcVUmOK0ZHShnF6tBK+d2iOn1OrztckWinbMLvjz/yspsVE/Fy4gQPn5gWkAPc4vEw8WWADymlOPCro8WK/BKbfUI6wj8YXQ6AmBrPydEl9EqH5JRpr59l+j1q6y/V/8URcC8WBcOsg0h+y/zgg3ccuNw16djGi0qyUjB8GSdAqB6lcsmAHHr7beib4rjJgxbs8eUDopAQqTUp9dWnMbXLSBLZhu894OB4ntTPlMG6SOwp2MJew
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(86362001)(5660300002)(26005)(2616005)(6486002)(2906002)(316002)(31696002)(16576012)(186003)(54906003)(8936002)(478600001)(956004)(36756003)(31686004)(66946007)(66556008)(6666004)(66476007)(8676002)(83380400001)(4326008)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Q4ckRPRlFGcGlER3ZUbjdYdldtVFBCODVEMU1vRi9tYm9qaXVhZ2pYZ1g0?=
 =?utf-8?B?LzdGUjhFR29DVXRnbmxuSzQyR2I3dndZbC9nYWUvajhoSlpXVDRVdGdWUHdR?=
 =?utf-8?B?cE55c0JBWnJ3RmdaUk9YbE15NXNrSFljSlRMbEJRU2dXb3IvYW83ZjdFWHhN?=
 =?utf-8?B?VzMyanZBYmsxY1lHbTI4QVRNT01LZHRjdFNRWXlaakRTOFdEMnJMUFowelNR?=
 =?utf-8?B?bWVkT3YyeXc3SFlSdzlRQUY3TlB6bFBhVFVpeXMwNVVoeEc2SUttMDU3SWVh?=
 =?utf-8?B?eDRxblpNUEx1WitJcHc3TXRUSjF5b2JLeStodDJsM1FTTG9TQXliTFhMQitM?=
 =?utf-8?B?Y1NkK0tlNUUyYXhXTHg4clpVdXFkSGVRanZmaE80L2ovQ3FISmZFMzdldzFU?=
 =?utf-8?B?RDJ3Y3NJeXExWk9pWDNWT0R6a1pzdjVsTWEzZzZQcmUzc2pqV0VyQysyN0d0?=
 =?utf-8?B?MzNnRVRzNkdPbFRvTDZnY2tMQnl2OG9zNktDYk50aUJZMVJsNWhsbUxCOTlH?=
 =?utf-8?B?WGg0d0VQM0JtcTZxNnVXc2hFMXI1ejcxb250VnZ2MS9ncmJ5Smpwb2UzaFZV?=
 =?utf-8?B?VXB1bDhEcWNGOGtmMU1tOTZkblVHTmFQenVxSitvWFdtZDcvbmJ6SEV1b1VD?=
 =?utf-8?B?NG4wVVBoMUlNU2d4eklYWGJwam9UOG40eW1LcjIvWUYrWmd1dDBjRlltM1NR?=
 =?utf-8?B?UFhoeDdSa1RkNmFlbzBiOTZWNzZXNDR3ZGNSQWo2QzU4SUo2S1VyTVEyc3pZ?=
 =?utf-8?B?RW5yUldUWDRvM2ZVc0M1RXJKbDVUMTlreW9KNGowN1hIbW5uWUZyOVlqRzA5?=
 =?utf-8?B?L0lnTldjcWtCRFN1N0JuRkJWZTFoUmlNKzRUbEVXcyt6NmU5dWxvdVVxTHE0?=
 =?utf-8?B?RXpNTHFDL2RnVW9YVkhzY2xIY0dGLzUyMnVId3ZrMkRUYUdPbHd0UVJJVVQr?=
 =?utf-8?B?eUFRM1RDd1hnMDZ0cG5qR3o5WkJtRG5yZmpjNjhQUFhBY0ZVeTQyVWVYa3Jt?=
 =?utf-8?B?cHBIYURIeHAwTE9qT3dpWnRCYlZ5WW4zNDJPb0hmZ285bFJJWUNmMnljbDFk?=
 =?utf-8?B?Z2VLTkkxWjZBWFJMa2dRRmhPRG5EWktRRVhWcjUrOEo3b1ZsZFRCcGRpcm82?=
 =?utf-8?B?dmpwSlZCUU53RXA4ZjdTNUQ2a2JEZ0l1YWxCSjVBZ1llSGN5eFF1QkxGYXhH?=
 =?utf-8?B?NzN1eVU1QUQwZ295V0xBM3J2S2NOdFk5UjRLQUh5M0gyRmJaTFUzaThXZ0l5?=
 =?utf-8?B?V3J1RTgySWNBTVRWU2w3enBzZkFSaUp1UEw1NU1ESDBEelhTZGJlRVA4VWJj?=
 =?utf-8?B?SmN3NVc5MXNwc01Hck1qOWJWVmZEU3VNVmE5MHZELzR6eWxUYmI3YzZHNGZO?=
 =?utf-8?B?WS95QXZKcVFmeWI3N2UrZFVjZUpQMmdxbVk3MStwenhpeENLajMwRkQzY04w?=
 =?utf-8?B?ZkJwK21WZGRIVVVrcHN5b1NiNi9QYUU5b2t0WHpSSld5WWVzNmZ0YjliTyt6?=
 =?utf-8?B?M0VyRDk1REZNdnpwN1Z6b2s5UEU2MkNndTQ5RXFyS0FpYXU4K2NFaERyVy9k?=
 =?utf-8?B?UGYwdC9OWDBtSWUyYVMzNzFDZ0ZES25oTjhkNFhMMzhyMUxQMTRndjY5NkNX?=
 =?utf-8?B?N01pQkI2eHAxR3JZdHJ1OTYyV0pwb0dFQ0t0S3RoMVd6SzBqVks1UWJXNnBE?=
 =?utf-8?B?SDhOaW8vSVJrNHVjWk8rVndoV2VXR0RtRHpVR2FVRDZDZjRvTHorWTJkOUxu?=
 =?utf-8?Q?ks9wOdgooyAuxaWu32wvONafP/G+NWxew0pb6Vo?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1970
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 79b8ee5e-50a5-4f05-59fb-08d94c32eb26
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nauQ248gtgQt80X4vjZhrvo5WdrN1vXcQkM8LuQeHgIALDNsYxON0qf0I3UxkiKlK9o5POjEMZXQlM2nnLOXoq/IVUfLdciqHQOBbO3zRyteiNjmNZYnaz88R7FmOZtMgRQzSpvOO4CemZK8z073IJv7Yi7PnxQSRbMaTy4GLzG08HJ803RpPxre/BgFd4ITpk+pjcgmr+tjPeoOXNmA4L5aWkIx3RmDyvBpkIQ0Cy+WqfTtC6UHTs0qhV6e3gEJWIRhJDRYQO8jektL1T93+BdwwFV4XX/0InlsOzf62qK2vvDegFKG3+wcGSzskJh7+fznZs8anVIdivS5sAzLUJGevFLmxDvY/xDZIVMTLUzrw/qidTYYb7eiGY7TjcUid+NNtpFYZLDyABQfCl02Os40mVlnenhq+RP95KvFB2fGd0sJyqpSKj7CLwRvrbYLSnipu9zdA5n8QU3PZRiN9wxIUSP9MrRsuzS4bxaJVmJVZlEM0TRtlUMxjDlXuopMmeeHpFNIV6IXV4Jg49IMchAb8yq+ge9Iw4zFx0eRuDi5+AG6f8AZLOLxWNWxRFhlYPANK+Ylwz1qHg9BXbe0GX4v7Qqm4dSTKkU389i+mHwhoYJhMO5VX3ABZLA+Vc57QIjQ4hBEYqtyxhRWqoGYYjLysTAVSHwgvIr/i1MVeSE2146yZZgFwm49mVGKXNNbQ/NAkFT8lm1MykSiIRk0EkFKlxb4YpmKEkP9jS8Iv1s=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(26005)(186003)(336012)(16576012)(316002)(31686004)(54906003)(82740400003)(2906002)(4326008)(5660300002)(956004)(83380400001)(2616005)(47076005)(81166007)(82310400003)(356005)(6486002)(36860700001)(70206006)(44832011)(478600001)(36756003)(6666004)(86362001)(70586007)(31696002)(8676002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 10:33:21.2993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1b18b3-607d-47e3-6db4-08d94c32f63f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7175
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add -lstdc++ to perf when linking libopencsd as it is a dependency. It
does not hurt to add it when dynamic linking.

Filter out -static flag when building plugins as they are always built
as dynamic libraries and -static and -dynamic don't work well together
on arm and arm64.

Signed-off-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
Signed-off-by: Branislav Rankov <branislav.rankov@arm.com>
---
 tools/perf/Makefile.config | 2 +-
 tools/perf/Makefile.perf   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 73df23dd664c..b014a9bdd0db 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -143,7 +143,7 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-OPENCSDLIBS := -lopencsd_c_api -lopencsd
+OPENCSDLIBS := -lopencsd_c_api -lopencsd -lstdc++
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..cd3cf910fa8a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -792,7 +792,7 @@ endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
-LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
+LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(filter-out -static,$(LDFLAGS))'
 
 $(LIBTRACEEVENT): FORCE
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
-- 
2.17.1
