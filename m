Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BDC433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Feb 2021 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C211464E04
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Feb 2021 10:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBPKsR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 05:48:17 -0500
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:1184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhBPKsH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Feb 2021 05:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4NDk+mJpCBUXZ75DYIa8KznouPlhhZ3SepsTYQvs4g=;
 b=SRJQ2DcB9ioONuNXW+nASG8TF3xhjvgOY59f0wbbPWMoZSAAAvt4ejhWVFx4VS66dJEo80lMkyDMzwZvgaOlOyVwVK2eZvl70Oj5YqeSB6G6v6ZnsHdsLDSfdmuWOTIPpWwRnq5UN5AgeAV6RYao7XuaWA2owcFEAquvRHuJ1pY=
Received: from DB6PR07CA0168.eurprd07.prod.outlook.com (2603:10a6:6:43::22) by
 AM0PR08MB4947.eurprd08.prod.outlook.com (2603:10a6:208:158::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 10:47:15 +0000
Received: from DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::51) by DB6PR07CA0168.outlook.office365.com
 (2603:10a6:6:43::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend
 Transport; Tue, 16 Feb 2021 10:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT048.mail.protection.outlook.com (10.152.21.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Tue, 16 Feb 2021 10:47:15 +0000
Received: ("Tessian outbound 2db1bbc8a1d2:v71"); Tue, 16 Feb 2021 10:47:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 39663bbaa410da77
X-CR-MTA-TID: 64aa7808
Received: from e33e4cefd4f6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 902209F8-E8E0-43DD-B1C0-D59AF692B2EB.1;
        Tue, 16 Feb 2021 10:47:10 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e33e4cefd4f6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 16 Feb 2021 10:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkKAt8+WZUmmXuIxgiY6tuJUK07TOmXX5utJjtb//Y6SsXR+Q4B/a7Xcy5as+uGPHwwwDM44FZMDG5TfaBDfuy49qMOfSiPtJ/p8Kd0g4BgstlCxmqFaiCFWI3jW4o0NN8GiPahKY5o1SMfoKP/NWdX4T9MXM22yhZQ89qnb0JfVmqPbZbdtdJi/VoIJGs/7u4rOLlVJb+KsOtgC9uHw14TcGV5kFz8jo9jXMt94Hwbzqspoeh3ZnrZkmBZGpnkqgM6qsVlE9QFlfJH4sPbvFZrXEi4E0PenHyNc2tsL56yg602w3XWGNd1J9qHkAV6bzsAksuc5N7kqtZsUbs1QGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4NDk+mJpCBUXZ75DYIa8KznouPlhhZ3SepsTYQvs4g=;
 b=InquJyH+O6+m7aYrYzp2mPcCaybDsx0Hb9gETSQgeWzAsFhx9waeovzCO1CGcssFboj9zVV9FRy5BjMCN3TCYwpGOBDMQ8Rrh1VBw8Dio5F3AYL11I1++mm0XiXJ14kKSEguvI1sYgJrWewDDZW4mITfeLLvu9J1FWxDeVLwxqiBy19xpDBbJUk9LDhNK8kQ/TQH1xgw7zYp6mn20FtCbib498seo/YpLCl2z8xNXoHrFlq3ZIq8PFpVvXmWn4UooZhGU7X3OiwfIdvPTqPdVhaAjAJB0pClElFFIasOh7VhqjqFqZSniuvCxUlOvWOmbhIV2UXmZDJ+8DUdYNqPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4NDk+mJpCBUXZ75DYIa8KznouPlhhZ3SepsTYQvs4g=;
 b=SRJQ2DcB9ioONuNXW+nASG8TF3xhjvgOY59f0wbbPWMoZSAAAvt4ejhWVFx4VS66dJEo80lMkyDMzwZvgaOlOyVwVK2eZvl70Oj5YqeSB6G6v6ZnsHdsLDSfdmuWOTIPpWwRnq5UN5AgeAV6RYao7XuaWA2owcFEAquvRHuJ1pY=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com (2603:10a6:20b:299::13)
 by AS8PR08MB6118.eurprd08.prod.outlook.com (2603:10a6:20b:29b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36; Tue, 16 Feb
 2021 10:47:09 +0000
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8]) by AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8%7]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 10:47:09 +0000
Subject: Re: [PATCH v2 4/4] perf tools: determine if LR is the return address
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20210212170343.7729-1-alexandre.truong@arm.com>
 <20210212170343.7729-4-alexandre.truong@arm.com>
From:   Alexandre Truong <alexandre.truong@arm.com>
Message-ID: <9df60199-aaf6-04a0-d3f4-d6287a62321f@arm.com>
Date:   Tue, 16 Feb 2021 10:47:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210212170343.7729-4-alexandre.truong@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.99.251]
X-ClientProxiedBy: SN4PR0501CA0004.namprd05.prod.outlook.com
 (2603:10b6:803:40::17) To AS8PR08MB6120.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.17.47] (217.140.99.251) by SN4PR0501CA0004.namprd05.prod.outlook.com (2603:10b6:803:40::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend Transport; Tue, 16 Feb 2021 10:47:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 094ba444-bea7-48b5-187e-08d8d2683999
X-MS-TrafficTypeDiagnostic: AS8PR08MB6118:|AM0PR08MB4947:
X-Microsoft-Antispam-PRVS: <AM0PR08MB4947DDDF66BDFDCB44D0D9279C879@AM0PR08MB4947.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4ZCewYqxmJERE0q4szXfakaVy+cYVg6jNSXmvzxKQLdFF9RNVbe9NOZsrZBKbmXBkJtIGz5B/q2f5TA/4PMCdUEB3XE2OhLCQB1uIteZqQs/Vt79x424X8WmlzsRB6kd46dbGNeikjof0Cy0LiCXHOiKwtY9/2RKb267xeYOezn+fSzwKdueiO2eHLLJDbKkkl7BTP54DBD4VxmDKcHu65WHAUvYugtVFApDpuFECpDuUFnJJ4KIb4B40vqI4ZgwXJWTIImURcv+uMJZKr0lvThk3TCDVWsQ2iBmtB/NWoWpAFibTlYfMV/6K5H7BbSsbwtUgUeTIZFL4wXyDqvwSOsqYYpoUoFwEkbHDPMFdd7u4EWwlUmHYAUw3mpPhyufyR8l7p9uOX3QxEdBoHA3rHwomaOOX4l9Kn1HAB+YS3X2eBp4KzcIaGR9Jjje0HFBcCJea6NClZRUjX/08HN3FgCI5r3jF3bz65M0sN+mKRZnP4XS7usHR/NZbqOzXcETIK0iMhx8eS+3c4Gcq49WMHIhA2xGp34uMD8EcXh118NMLMXK57PT0wRLpvWGKeMP4OQWPNNjh83Y/u3N1bH0IYFDZNgIOw72gO4Jimby0jQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(316002)(450100002)(26005)(16576012)(186003)(16526019)(8676002)(5660300002)(6486002)(36756003)(53546011)(8936002)(66946007)(52116002)(66556008)(66476007)(6666004)(478600001)(2906002)(31686004)(956004)(31696002)(44832011)(86362001)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cEtTVTJzMkFub3E2RTBBWXFDM1dQZE5BUzkzeFNqQ2gvTHduR01hUU51N0FF?=
 =?utf-8?B?Z1VKU2gva0ViREZ2SWp2Wkx6VGQyR1hGTk8ycHpOZzVHM2lPUVpTMmVMcnUr?=
 =?utf-8?B?YTZRSDBaOEJuN1MzYUZLaHdJOUZ5S3FycE4vbUp0RzFkdHU4T2VVVGV4WWJM?=
 =?utf-8?B?dzhCczZVN2pnNUJTZFJJUFFITFhmUUNLTjVVV2w4TUx4emoyZ3BCS0ZQcGhL?=
 =?utf-8?B?a05kWUgzU3VkRFI0eXlhT1F2WndZTk9aZm1ZMEFNNGFYMGFtY0ZnTHJlUmF0?=
 =?utf-8?B?emR1N1FJT0dmSmhNbkN1Z0VRdUZodFA3aWxwdDBXUXRONDJJLzJTQU5qNjFW?=
 =?utf-8?B?cnkxUEFJMnFqYUVtbm11UkQrU3FpZEExc3ZCTmZNSllBditnNUtsRXRwYWFq?=
 =?utf-8?B?UEQ2NjJsTDNjNVFycW5UNFpyeUVDODYxSEZPUnZrMVI2U0tjc0dSaWF5clow?=
 =?utf-8?B?dDkrQTVvcm1yMUR6SlNuMDd2UHR2aXdvRlFvenJGeXEvZ0ltQW0rL2RIMmJu?=
 =?utf-8?B?RWo5OHhzSG53aUdMVno3WjBzd2RreWYyczdLZXAvbko4Qmc3NFp3RDVnN2sx?=
 =?utf-8?B?OVpEN3hlUm85NDlvVXRxdUxJZ3dOOTNiVjdMRHdkZm1hY2pUSk9Sd1BjNkgz?=
 =?utf-8?B?Vi9kYXdxRjZQb3VzczQ0d3F5dGlLR29ZQlZjOGF5eDNpSkhMdE03SXRJRmJJ?=
 =?utf-8?B?N0FSOVN5ZDhNblZjNFhUMklyQUh2SnE3eVl6SFhwdWk0SmZMWFgvbFVPSVJr?=
 =?utf-8?B?S2FMa1BsaFFMdWJEV2JMZDJEL0YxTjRlZmxUZ1BUdk12UXJ4ZzIrYXo3SFNv?=
 =?utf-8?B?UUFKYno2S2JIVFFaeDFMb0d5VjY4WXFwTEFxZDFvSnJvcHdrTFF2Y3FJNVBS?=
 =?utf-8?B?QzRhOTZwNkpMRWhXZ1hwYi94RlRhcDNIUnF0M0hGSFBoWmtiUlJXMi9vQUJy?=
 =?utf-8?B?VTFzdW5KamE0cU1YTUZTQXlQTk9mSDJLQ1N1TXFxT2NOVEZRaG9uY3F6Q3U4?=
 =?utf-8?B?Q0RBcGU2T0JLUk1LRFJ0T1RtdW5iK1N6SlB1QmZva1pSVUUyTFUxMEZaZVVJ?=
 =?utf-8?B?YW9hNzdvdEdZd3dpaXkwaWpqR2tldEhtRU9uNWtVVVdwTzFvQ3A3bnB3KzV4?=
 =?utf-8?B?NHNhY2E3eW13WmhPUVg4N3BWTEw2ZXVaV1VVVmtZMlZwUXgyWUxNWWZwQ1g4?=
 =?utf-8?B?L2l5d0dFaExEZUtsc0pPRWF0TW9SVW1rY2tSVUVPMEFsOXNjWXlaRTk5VG5K?=
 =?utf-8?B?bXpjT1A4TERxRTlPcS9KT0g3cGxUdWxKcFIzK3JyVGdvazZYTmRjT1lnM0JH?=
 =?utf-8?B?SWRQYmJpM0F1THlIZGJma1ZMYXhEWFdGME1iZE1ON1lZWVQ1R0syWFU3VFFp?=
 =?utf-8?B?ZmRDc24vMjJFRkdWVTV1MU9Lenh0NmZkZFplekg1WmVHSWRmc0JTZGc2cWJU?=
 =?utf-8?B?SkdZL0JMbmJnckErWUVNanpWYUppZ1Z6ZC9MZzNuY2RMN3ZlMEdGaXdDTWhP?=
 =?utf-8?B?REdmSFFFUHcvWmIwVlJTVFFXbTBCWDRrVHFQcFUrUXZzUUhXZE5Oem5pVDJP?=
 =?utf-8?B?Q0RISUxYVGlOMGJzRkNqRlY2SHpxRWxvaGlGaVA1UEtsd1VRaXRoV3BLL3NG?=
 =?utf-8?B?bS9qQlF1V2Q2cHRRZUZRTDlXS3QzOFhCZXlOenMyWU1nMjFyQ0RhbThJcUlk?=
 =?utf-8?B?Vk5USGFOWm00ZXczSFUveGVoVzlmNGE1eVRJeXc5SXNyRzRVcFg4UHh3cGNl?=
 =?utf-8?Q?d48i8RLkax9sTu1BLVuoxUwTnPkXvHrUQnXXG5b?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6118
Original-Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0629931b-ac0a-497d-106e-08d8d268359e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIEIAbk4r6Tmyk8KuhOV/27hmltLdsJYR/vqlVgsdgmDvzVx6P2UGkr2Pne0aCmO45ylbh6yWPNCBgiIP09NA5IpOOjbBOvZZtumqprf3xgZrriWCibJm+P8UJbYo6mhtNFnJFQcrQvVDeQ7EsJvRkidmknJQP/r42IlMh32Xp5+V96z9F4/lcYaS9qpbwLUfPmRLh3wzsjk17FaP28SxEwsdnYadpV7FqNwba7grNp6AWKGtVuYqtsbJLoNaIvln+q/LNirVAnQXrAq8oellfl2tIlyQnrzRSsAZkodcftw+GHZCZlSpVW5zaCGJZ3MafX8mCwjn+Aa7nIFMRJRPava7brdpsBjWDbFpMWJkowyuyU9UpbFDVfpvG6iYH750EHyQOlo754goK76jN8SrgVOSPcRZTooswqgWEyUyzayzpYgQ4CcwKylbTi5byqdE3RTtTanLxzzt9tjebghTohj7iqz37UB2UDcA6hNWcfNApwUQFzob8YSXnHDMk1b353HM7G8ep0C4tOjLNrhGp7VyieZ5wlM8EjW5h8aSbS3ScwJkT+B8rP4JYDVAv+11YrvBFfa3QzlJBdr98+qXgn+hFL9MmpA02Rky6ATxGK09hvXFvb0o4SOYLld1BacVKTGBzyTtekX6EP3h+8UQhexXCYJxEPli2CLaGh2vP8ZpRggFM26iYAUYOSmTWIS
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(86362001)(450100002)(70586007)(36860700001)(478600001)(5660300002)(6486002)(70206006)(36756003)(16576012)(44832011)(31696002)(81166007)(2616005)(956004)(316002)(6666004)(26005)(47076005)(31686004)(8936002)(2906002)(16526019)(336012)(82310400003)(83380400001)(186003)(8676002)(82740400003)(53546011)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 10:47:15.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094ba444-bea7-48b5-187e-08d8d2683999
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4947
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

This patch is supposed to be a v3, I did a rebase.

Thanks,

Alexandre

On 2/12/21 5:03 PM, Alexandre Truong wrote:
> On arm64 and frame pointer mode (e.g: perf record --callgraph fp),
> use dwarf unwind info to check if the link register is the return
> address in order to inject it to the frame pointer stack.
>
> Write the following application:
>
>       int a =3D 10;
>
>       void f2(void)
>       {
>               for (int i =3D 0; i < 1000000; i++)
>                       a *=3D a;
>       }
>
>       void f1()
>       {
>               for (int i =3D 0; i < 10; i++)
>                       f2();
>       }
>
>       int main (void)
>       {
>               f1();
>               return 0;
>       }
>
> with the following compilation flags:
>       gcc -fno-omit-frame-pointer -fno-inline -O2
>
> The compiler omits the frame pointer for f2 on arm. This is a problem
> with any leaf call, for example an application with many different
> calls to malloc() would always omit the calling frame, even if it
> can be determined.
>
>       ./perf record --call-graph fp ./a.out
>       ./perf report
>
> currently gives the following stack:
>
> 0xffffea52f361
> _start
> __libc_start_main
> main
> f2
>
> After this change, perf report correctly shows f1() calling f2(),
> even though it was missing from the frame pointer unwind:
>
>       ./perf report
>
> 0xffffea52f361
> _start
> __libc_start_main
> main
> f1
> f2
>
> Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> ---
>   tools/perf/util/Build                         |  1 +
>   .../util/arm-frame-pointer-unwind-support.c   | 44 +++++++++++++++++++
>   .../util/arm-frame-pointer-unwind-support.h   |  7 +++
>   tools/perf/util/machine.c                     |  9 ++--
>   4 files changed, 58 insertions(+), 3 deletions(-)
>   create mode 100644 tools/perf/util/arm-frame-pointer-unwind-support.c
>   create mode 100644 tools/perf/util/arm-frame-pointer-unwind-support.h
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 188521f34347..3b82cb992bce 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -1,3 +1,4 @@
> +perf-y +=3D arm-frame-pointer-unwind-support.o
>   perf-y +=3D annotate.o
>   perf-y +=3D block-info.o
>   perf-y +=3D block-range.o
> diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.c b/tools/p=
erf/util/arm-frame-pointer-unwind-support.c
> new file mode 100644
> index 000000000000..964efd08e72e
> --- /dev/null
> +++ b/tools/perf/util/arm-frame-pointer-unwind-support.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> +#include "arch/arm64/include/perf_regs.h"
> +#include "event.h"
> +#include "arm-frame-pointer-unwind-support.h"
> +#include "callchain.h"
> +#include "unwind.h"
> +
> +struct entries {
> +     u64 stack[2];
> +     size_t length;
> +};
> +
> +static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
> +{
> +     return callchain_param.record_mode =3D=3D CALLCHAIN_FP && sample->u=
ser_regs.regs
> +             && sample->user_regs.mask =3D=3D PERF_REGS_MASK;
> +}
> +
> +static int add_entry(struct unwind_entry *entry, void *arg)
> +{
> +     struct entries *entries =3D arg;
> +
> +     entries->stack[entries->length++] =3D entry->ip;
> +     return 0;
> +}
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thr=
ead *thread)
> +{
> +     int ret;
> +
> +     struct entries entries =3D {{0, 0}, 0};
> +
> +     if (!get_leaf_frame_caller_enabled(sample))
> +             return 0;
> +
> +     ret =3D unwind__get_entries(add_entry, &entries, thread, sample, 2)=
;
> +
> +     if (ret || entries.length !=3D 2)
> +             return ret;
> +
> +     return callchain_param.order =3D=3D ORDER_CALLER ?
> +             entries.stack[0] : entries.stack[1];
> +}
> diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.h b/tools/p=
erf/util/arm-frame-pointer-unwind-support.h
> new file mode 100644
> index 000000000000..16dc03fa9abe
> --- /dev/null
> +++ b/tools/perf/util/arm-frame-pointer-unwind-support.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thr=
ead *thread);
> +
> +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 7f03ffa016b0..dfb72dbc0e2d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -34,6 +34,7 @@
>   #include "bpf-event.h"
>   #include <internal/lib.h> // page_size
>   #include "cgroup.h"
> +#include "arm-frame-pointer-unwind-support.h"
>
>   #include <linux/ctype.h>
>   #include <symbol/kallsyms.h>
> @@ -2671,10 +2672,12 @@ static int find_prev_cpumode(struct ip_callchain =
*chain, struct thread *thread,
>       return err;
>   }
>
> -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unus=
ed,
> -             struct thread *thread __maybe_unused)
> +static u64 get_leaf_frame_caller(struct perf_sample *sample, struct thre=
ad *thread)
>   {
> -     return 0;
> +     if (strncmp(thread->maps->machine->env->arch, "aarch64", 7) =3D=3D =
0)
> +             return get_leaf_frame_caller_aarch64(sample, thread);
> +     else
> +             return 0;
>   }
>
>   static int thread__resolve_callchain_sample(struct thread *thread,
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
